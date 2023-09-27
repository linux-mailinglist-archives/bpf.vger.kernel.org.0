Return-Path: <bpf+bounces-10979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103E57B0983
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 18:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4F05E2821BE
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3F48EB7;
	Wed, 27 Sep 2023 16:02:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129B111AB
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 16:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DD5C433BB
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695830565;
	bh=WG949DcM9Bmn+f1FkPZJR87nRg6RxJn2XBd0i4CsVsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n7dRUxkaBspBk5ouvSIe+Y8dLPWA1jvjGfYE2phfcY7lwmU3Tfg9Xy65wO3XWNbp8
	 ghJx39RdS2k9q2S8ZuJQokti7NvIIVoiXb7rCqT2sv/BoKrEIfoCahO7SgUyhDZ5BU
	 iffd3xDdSvsvKPOJ7AjV9y9Gwg4RUs1/IvxhRNlI3KMni0zFPeyTSUFDFOzWB39ygb
	 y9ry8OZN4iwFGTzBJIvsKprby0CMHLXZt1vNnPFK4Tgkmv+DGfsLDMLGNTcnnbiWta
	 n6Mzx83vJXMJQNX7O4nxBBkqtdeZw10eZzwwTsYqnNsc/OZo4Wf5HYGGVL8zaxEFJP
	 Q4Q4sFc2rteuQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so9506424a12.3
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 09:02:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw0DPCxZB+a2PeJFY6CJeI1NEIj2lxh8j1CD17wYNWZES5BKVqL
	ZQ9fKypQ2BLs7eDFErDEVm6inp/4etGc870teTm3Xg==
X-Google-Smtp-Source: AGHT+IGBgjs/DWNJYnqy5w1/21S0WlvI8mFuiCu8zlLRjfS1tizUg02XkY9UkVad/bWh//MDleQBA1AzkzVxlMERqnY=
X-Received: by 2002:a05:6402:38e:b0:525:469a:fc49 with SMTP id
 o14-20020a056402038e00b00525469afc49mr2240243edv.17.1695830563511; Wed, 27
 Sep 2023 09:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
In-Reply-To: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 27 Sep 2023 18:02:32 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
Message-ID: <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 5:09=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Recently, the LSM community is trying to make drastic changes.
>
> Crispin Cowan has explained
>
>   It is Linus' comments that spurred me to want to start this undertaking=
.  He
>   observes that there are many different security approaches, each with t=
heir own
>   advocates.  He doesn't want to arbitrate which of them should be "the" =
Linux
>   security approach, and would rather that Linux can support any of them.
>
>   That is the purpose of this project:  to allow Linux to support a varie=
ty of
>   security models, so that security developers don't have to have the "my=
 dog's
>   bigger than your dog" argument, and users can choose the security model=
 that
>   suits their needs.
>
> when the LSM project started [1].
>
> However, Casey Schaufler is trying to make users difficult to choose the
> security model that suits their needs, by requiring LSM ID value which is
> assigned to only LSM modules that succeeded to become in-tree [2].
> Therefore, I'm asking Casey and Paul Moore to change their mind to allow
> assigning LSM ID value to any LSM modules (so that users can choose the
> security model that suits their needs) [3].
>
> I expect that LSM ID value will be assigned to any publicly available LSM
> modules. Otherwise, it is mostly pointless to propose this patch; there
> will be little LSM modules to built into vmlinux; let alone dynamically
> loading as LKM-based LSMs.
>
> Also, KP Singh is trying to replace the linked list with static calls in
> order to reduce overhead of indirect calls [4]. However, this change
> assumed that any LSM modules are built-in. I don't like such assumption
> because I still consider that LSM modules which are not built into vmlinu=
x
> will be wanted by users [5].
>
> Then, Casey told me to supply my implementation of loadable security
> modules [6]. Therefore, I post this patch as basic changes needed for
> allowing dynamically appendable LSM modules (and an example of appendable
> LSM modules). This patch was tested on only x86_64.
>
> Question for KP Singh would be how can we allow dynamically appendable
> LSM modules if current linked list is replaced with static calls with
> minimal-sized array...

As I suggested in the other thread:

https://lore.kernel.org/bpf/20230918212459.1937798-1-kpsingh@kernel.org/T/#=
md21b9d9cc769f39e451d20364857b693d3fcb587

You can add extra static call slots and fallback to a linked list
based implementation if you have more than say N modules [1] and
fallback to a linked list implementation [2].

for [1] you can just do MAX_LSM_COUNT you can just do:

#ifdef CONFIG_MODULAR_LSM
#define MODULAR_LSM_ENABLED "1,1,1,1"
#endif

and use it in the LSM_COUNT.

for [2] you can choose to export a better module API than directly
exposing security_hook_heads.

Now, comes the question of whether we need dynamically loaded LSMs, I
am not in favor of this.Please share your limitations of BPF as you
mentioned and what's missing to implement dynamic LSMs. My question
still remains unanswered.

Until I hear the real limitations of using BPF, it's a NAK from me.

>
> Link: https://marc.info/?l=3Dlinux-security-module&m=3D98706471912438&w=
=3D2 [1]
> Link: https://lkml.kernel.org/r/20230912205658.3432-2-casey@schaufler-ca.=
com [2]
> Link: https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-lo=
ve.SAKURA.ne.jp [3]
> Link: https://lkml.kernel.org/r/20230918212459.1937798-1-kpsingh@kernel.o=
rg [4]
> Link: https://lkml.kernel.org/r/ed785c86-a1d8-caff-c629-f8a50549e05b@I-lo=
ve.SAKURA.ne.jp [5]
> Link: https://lkml.kernel.org/r/36c7cf74-508f-1690-f86a-bb18ec686fcf@scha=
ufler-ca.com [6]
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/lsm_hooks.h |   2 +
>  security/security.c       | 107 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index dcb5e5b5eb13..73db3c41df26 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -105,6 +105,8 @@ extern char *lsm_names;
>
>  extern void security_add_hooks(struct security_hook_list *hooks, int cou=
nt,
>                                 const char *lsm);
> +extern int register_loadable_lsm(struct security_hook_list *hooks, int c=
ount,
> +                                const char *lsm);
>
>  #define LSM_FLAG_LEGACY_MAJOR  BIT(0)
>  #define LSM_FLAG_EXCLUSIVE     BIT(1)
> diff --git a/security/security.c b/security/security.c
> index 23b129d482a7..6c64b7afb251 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -74,6 +74,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIA=
LITY_MAX + 1] =3D {
>  };
>
>  struct security_hook_heads security_hook_heads __ro_after_init;
> +EXPORT_SYMBOL_GPL(security_hook_heads);

Rather than exposting security_hook_heads, this should actually export
security_hook_module_register. This should internally handle any data
structures used and also not need the special magic that you did for
__ro_after_init.

- KP

>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>
>  static struct kmem_cache *lsm_file_cache;
> @@ -537,6 +538,112 @@ void __init security_add_hooks(struct security_hook=
_list *hooks, int count,
>         }
>  }
>
> +#if defined(CONFIG_STRICT_KERNEL_RWX)
> +#define MAX_RO_PAGES 1024 /* Wild guess. Can be minimized by dynamic all=
ocation. */
> +static struct page *ro_pages[MAX_RO_PAGES]; /* Pages that are marked rea=
d-only. */
> +static unsigned int ro_pages_len; /* Number of pages that are marked rea=
d-only. */
> +
> +/* Check whether a page containing given address does not have _PAGE_BIT=
_RW bit. */
> +static bool lsm_test_page_ro(void *addr)
> +{
> +       unsigned int i;
> +       int unused;
> +       struct page *page;
> +
> +       page =3D (struct page *) lookup_address((unsigned long) addr, &un=
used);
> +       if (!page)
> +               return false;
> +       if (test_bit(_PAGE_BIT_RW, &(page->flags)))
> +               return true;
> +       for (i =3D 0; i < ro_pages_len; i++)
> +               if (page =3D=3D ro_pages[i])
> +                       return true;
> +       if (ro_pages_len =3D=3D MAX_RO_PAGES)
> +               return false;
> +       ro_pages[ro_pages_len++] =3D page;
> +       return true;
> +}
> +
> +/* Find pages which do not have _PAGE_BIT_RW bit. */
> +static bool check_ro_pages(struct security_hook_list *hooks, int count)
> +{
> +       int i;
> +       struct hlist_head *list =3D &security_hook_heads.capable;
> +
> +       if (!copy_to_kernel_nofault(list, list, sizeof(void *)))
> +               return true;
> +       for (i =3D 0; i < count; i++) {
> +               struct hlist_head *head =3D hooks[i].head;
> +               struct security_hook_list *shp;
> +
> +               if (!lsm_test_page_ro(&head->first))
> +                       return false;
> +               hlist_for_each_entry(shp, head, list)
> +                       if (!lsm_test_page_ro(&shp->list.next) ||
> +                           !lsm_test_page_ro(&shp->list.pprev))
> +                               return false;
> +       }
> +       return true;
> +}
> +#endif
> +
> +/**
> + * register_loadable_lsm - Add a dynamically appendable module's hooks t=
o the hook lists.
> + * @hooks: the hooks to add
> + * @count: the number of hooks to add
> + * @lsm: the name of the security module
> + *
> + * Each dynamically appendable LSM has to register its hooks with the in=
frastructure.
> + *
> + * Assumes that this function is called from module_init() function wher=
e
> + * call to this function is already serialized by module_mutex lock.
> + */
> +int register_loadable_lsm(struct security_hook_list *hooks, int count,
> +                         const char *lsm)
> +{
> +       int i;
> +       char *cp;
> +
> +       // TODO: Check whether proposed hooks can co-exist with already c=
hained hooks,
> +       //       and bail out here if one of hooks cannot co-exist...
> +
> +#if defined(CONFIG_STRICT_KERNEL_RWX)
> +       // Find pages which needs to make temporarily writable.
> +       ro_pages_len =3D 0;
> +       if (!check_ro_pages(hooks, count)) {
> +               pr_err("Can't make security_hook_heads again writable. Re=
try with rodata=3Doff kernel command line option added.\n");
> +               return -EINVAL;
> +       }
> +       pr_info("ro_pages_len=3D%d\n", ro_pages_len);
> +#endif
> +       // At least "capability" is already included.
> +       cp =3D kasprintf(GFP_KERNEL, "%s,%s", lsm_names, lsm);
> +       if (!cp) {
> +               pr_err("%s - Cannot get memory.\n", __func__);
> +               return -ENOMEM;
> +       }
> +#if defined(CONFIG_STRICT_KERNEL_RWX)
> +       // Make security_hook_heads (and hooks chained) temporarily writa=
ble.
> +       for (i =3D 0; i < ro_pages_len; i++)
> +               set_bit(_PAGE_BIT_RW, &(ro_pages[i]->flags));
> +#endif
> +       // Register dynamically appendable module's hooks.
> +       for (i =3D 0; i < count; i++) {
> +               hooks[i].lsm =3D lsm;
> +               hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> +       }
> +#if defined(CONFIG_STRICT_KERNEL_RWX)
> +       // Make security_hook_heads (and hooks chained) again read-only.
> +       for (i =3D 0; i < ro_pages_len; i++)
> +               clear_bit(_PAGE_BIT_RW, &(ro_pages[i]->flags));
> +#endif
> +       // TODO: Wait for reader side before kfree().
> +       kfree(lsm_names);
> +       lsm_names =3D cp;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(register_loadable_lsm);
> +
>  int call_blocking_lsm_notifier(enum lsm_event event, void *data)
>  {
>         return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
> --
> 2.18.4

