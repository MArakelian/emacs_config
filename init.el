;;Basic Customizations
(when window-system (set-frame-size (selected-frame) 80 40))
(electric-pair-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-visual-line-mode 1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq mac-command-modifier 'meta)
(setq select-enable-primary nil)
(setq select-enable-clipboard t)

(global-display-line-numbers-mode)

;; (lambda () progn
;;   (setq left-margin-width 4)
;;   (setq right-margin-width 4)
;;   (set-window-buffer nil (current-buffer)))



;;-------ORG CONFIG--------------------------->
(setq org-hide-emphasis-markers t)
(setq org-hide-leading-stars t)
(setq org-startup-indented t)
(setq org-startup-folded t)

;; FONTS
(set-frame-font "Cascadia Code 12" nil t)

;;Set up Use-Package --------------------------> 

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;;Flycheck over Flymake
(use-package flycheck
  :ensure t)

;; Enable Vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode)

  ;;Different scroll margin
  (setq vertico-scroll-margin 0)

  ;;Show more candidates
  (setq vertico-count 15)

  ;;Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;;Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
 )
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :ensure t
  :init
  (savehist-mode))

;; Marginalia provides context sensitive notes in the minibuffer
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;;Provides for hyphenless and orderless search
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion--category-override '(file (styles basic partial-completion))))

;;AUCTEX
(use-package tex
  :ensure auctex)

;; Markdown
(use-package markdown-mode
  :ensure t)

;; Engraved Faces
(use-package engrave-faces
  :ensure t)

(setq org-latex-src-block-backend 'engraved)
(setq org-latex-engraved-theme 'doom-one-light)  ;; Optional

;;---CITATIONS------------------------------------->

;;Citations for Org Mode
(use-package citar
  :init
  (setq citar-templates
	'((main . "${author :20%sn}   ${date year :4}   ${title:30}")
          (suffix . " ${=key= id:15}    ${=type=:12}")
          (preview . "${author editor:%etal} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
          (note . "Notes on ${author editor:%etal}, ${title}")))
  :no-require
  :custom
  (org-cite-global-bibliography '("~/Desktop/PhilosophyNotes/MyLibrary.json"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  (citar-bibliography org-cite-global-bibliography)
  ;; optional: org-cite-insert is also bound to C-c C-x C-@
  :bind
  (:map org-mode-map :package org ("C-c b" . #'org-cite-insert)))

(use-package citeproc
  :ensure t)

;; Set up Company Mode -------------------------------> 
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0))

(add-hook 'after-init-hook 'global-company-mode)

;; Projectile allows for projects--------------------->
(use-package projectile
  :ensure t)

;; Better Org Mode Bullets ------------------------>
(use-package org-bullets
  :ensure t)

(use-package deft
  :ensure t
  :custom
  (setq deft-extensions '("txt" "md" "org" "tex"))
  (setq deft-recursive t))

;;(setq deft-strip-summary-regexp t)
(setq deft-use-filename-as-title t)
(setq deft-directory "~/Desktop/PhilosophyNotes/Notes/")

;; ;; Set up Python Literate Notes
(org-babel\-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (lisp . t)
   (C . t)))
(setq org-babel-python-command "python3")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Elpy		        ;;
;; (use-package elpy	        ;;
;;   :ensure t)		        ;;
;; (setq elpy-autodoc-delay .5) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Hooks, Baby---------------------------------------->

(defun deftyness()
  (display-line-numbers-mode -1))

(defun python-stuff ()
  "Change all programming buffers."
  (show-paren-mode 1))

(defun org-stuff()
  "Change org buffers."
  (org-bullets-mode 1)
  (visual-line-mode 1)
  (show-paren-mode 1)
  (display-line-numbers-mode -1))

(defun org-agenda-changes()
  "Change Org Agenda"
  (display-line-numbers-mode -1))


(setq org-agenda-files '("~/Desktop/PhilosophyNotes/Notes/"))
(setq org-agenda-start-on-weekday 0
      org-agenda-overriding-header "My Agenda")

;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :custom
  (setq doom-modeline-mode 1))


;;Deft mode Hooks
(add-hook 'deft-mode-hook 'deftyness)

;;Org mode hookp
(add-hook 'org-mode-hook 'org-stuff)
(add-hook 'org-agenda-mode-hook 'org-agenda-changes)


;;Python hook
(add-hook 'python-mode-hook 'python-stuff)

(load-theme 'doom-nord t)
(setq doom-flatwhite-brighter-modeline 1)

;; c offset

(setq-default c-basic-offset 4)

;; Python offset

(setq-default python-basic-offset 4)

;;Keybindings---------------------------------------
(keymap-global-set "C-c e" 'org-latex-export-to-pdf)

;; Eldoc
(setq eldoc-idle-delay 0.5)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4ade6b630ba8cbab10703b27fd05bb43aaf8a3e5ba8c2dc1ea4a2de5f8d45882" "80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" "34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec" "c1d5759fcb18b20fd95357dcd63ff90780283b14023422765d531330a3d3cec2" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "9e1cf0f16477d0da814691c1b9add22d7cb34e0bb3334db7822424a449d20078" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "0527c20293f587f79fc1544a2472c8171abcc0fa767074a0d3ebac74793ab117" "10e5d4cc0f67ed5cafac0f4252093d2119ee8b8cb449e7053273453c1a1eb7cc" "ffafb0e9f63935183713b204c11d22225008559fa62133a69848835f4f4a758c" "7964b513f8a2bb14803e717e0ac0123f100fb92160dcf4a467f530868ebaae3e" "89d9dc6f4e9a024737fb8840259c5dd0a140fd440f5ed17b596be43a05d62e67" "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "c8b3d9364302b16318e0f231981e94cbe4806cb5cde5732c3e5c3e05e1472434" "e1f4f0158cd5a01a9d96f1f7cdcca8d6724d7d33267623cc433fe1c196848554" "8b148cf8154d34917dfc794b5d0fe65f21e9155977a36a5985f89c09a9669aa0" "8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a" "a9eeab09d61fef94084a95f82557e147d9630fbbb82a837f971f83e66e21e5ad" "dccf4a8f1aaf5f24d2ab63af1aa75fd9d535c83377f8e26380162e888be0c6a9" "2078837f21ac3b0cc84167306fa1058e3199bbd12b6d5b56e3777a4125ff6851" "013728cb445c73763d13e39c0e3fd52c06eefe3fbd173a766bfd29c6d040f100" "6f96a9ece5fdd0d3e04daea6aa63e13be26b48717820aa7b5889c602764cf23a" "c5878086e65614424a84ad5c758b07e9edcf4c513e08a1c5b1533f313d1b17f1" "e14884c30d875c64f6a9cdd68fe87ef94385550cab4890182197b95d53a7cf40" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "6adeb971e4d5fe32bee0d5b1302bc0dfd70d4b42bad61e1c346599a6dc9569b5" "b1acc21dcb556407306eccd73f90eb7d69664380483b18496d9c5ccc5968ab43" "5b9a45080feaedc7820894ebbfe4f8251e13b66654ac4394cb416fef9fdca789" "3cdd0a96236a9db4e903c01cb45c0c111eb1492313a65790adb894f9f1a33b2d" "4fdbed4aa8bcb199d7f6a643886bac51178d1705b9b354ef3dd82d4ec48072d2" "75b2a02e1e0313742f548d43003fcdc45106553af7283fb5fad74359e07fe0e2" "b9761a2e568bee658e0ff723dd620d844172943eb5ec4053e2b199c59e0bcc22" "dc8285f7f4d86c0aebf1ea4b448842a6868553eded6f71d1de52f3dcbc960039" "680f62b751481cc5b5b44aeab824e5683cf13792c006aeba1c25ce2d89826426" "a44e2d1636a0114c5e407a748841f6723ed442dc3a0ed086542dc71b92a87aee" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "a9dc7790550dcdb88a23d9f81cc0333490529a20e160a8599a6ceaf1104192b5" "9d29a302302cce971d988eb51bd17c1d2be6cd68305710446f658958c0640f68" "e87fd8e24e82eb94d63b1a9c79abc8161d25de9f2f13b64014d3bf4b8db05e9a" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "02d422e5b99f54bd4516d4157060b874d14552fe613ea7047c4a5cfa1288cf4f" "df6dfd55673f40364b1970440f0b0cb8ba7149282cf415b81aaad2d98b0f0290" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "9013233028d9798f901e5e8efb31841c24c12444d3b6e92580080505d56fd392" "13096a9a6e75c7330c1bc500f30a8f4407bd618431c94aeab55c9855731a95e1" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "3de5c795291a145452aeb961b1151e63ef1cb9565e3cdbd10521582b5fd02e9a" "1f292969fc19ba45fbc6542ed54e58ab5ad3dbe41b70d8cb2d1f85c22d07e518" "0d0936adf23bba16569c73876991168d0aed969d1e095c3f68d61f87dd7bab9a" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "badd1a5e20bd0c29f4fe863f3b480992c65ef1fa63951f59aa5d6b129a3f9c4c" "2db9c83380f626b24a0ba7a1dd9972b72ec3e5ce9e58892350d7188106e0e114" "75fb82e748f32de807b3f9e8c72de801fdaeeb73c791f405d8f73711d0710856" "de8f2d8b64627535871495d6fe65b7d0070c4a1eb51550ce258cd240ff9394b0" "e7820b899036ae7e966dcaaec29fd6b87aef253748b7de09e74fdc54407a7a02" "1781e8bccbd8869472c09b744899ff4174d23e4f7517b8a6c721100288311fa5" "4c7228157ba3a48c288ad8ef83c490b94cb29ef01236205e360c2c4db200bb18" default))
 '(highlight-indent-guides-method 'character)
 '(org-agenda-prefix-format
   '((agenda . " %i %?-12t% s")
     (todo . " %i %?-12t% s")
     (tags . " %i %-12:c")
     (search . " %i %-12:c")))
 '(package-selected-packages
   '(eglot catppuccin-theme highlight-indent-guides doom-themes iceberg-theme nano-modeline nano-agenda nano-theme yasnippet-capf nord-theme citeproc-org citar yasnippet projectile org-bullets lsp-ui lsp-pyright flycheck company-anaconda)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(doom-modeline-mode 1)
