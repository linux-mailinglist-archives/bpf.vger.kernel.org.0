Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0631400F1
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgAQA2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 19:28:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34039 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgAQA2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 19:28:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id j9so21134163qkk.1;
        Thu, 16 Jan 2020 16:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6F4ZnavD0e/0chFQ3kgLKefPDVYDYjwgeigG3mgzgo=;
        b=OVgpERU0SAEtw3TECBcLos0ASYCg7YIeD9Y4/Ao2eH0mpTyzJkhQbfgi1wFeVKfkeZ
         hdnB5GFT/mrt92iJGgrbPNvht3FkXBgept9Qb6vekQY3doaf9BbWkF7u52xVfFaiNtJ/
         f81szrToA9mEwByoQTAPv+8HHaVEf62zH4Y9JdritM2pGH7ZQr2I9TfPXktuX0oe4ZRN
         4VPmG6YsEUwbDeec0dBpWeStKWSOrslt0ufERkNt37DPXWICDnu8TfmtIUB2b1/Ulyo5
         5vsIxJ2wLzqxg8cUZJLykU/lkKt88LWYmXIrOAvvaFwJfLvL0HXxogWYZDnmTDC0wH97
         Ks5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6F4ZnavD0e/0chFQ3kgLKefPDVYDYjwgeigG3mgzgo=;
        b=cYgdoDCvd+U7gauI7GWHFWHdsMcih1/rnagBXte1KaIEiSXPVHN0SofSU2H7nkkVtj
         A2ABVRjiPs8R48XsxB2ovCqQiiB0/Ri9ZaON3+bsPnzl73jzwiD4UcgIk2Ho3fxxFFeZ
         1La6J7J9GcRvmdHnNwHVFMcn1fsMnBnVn5mFMvlKKdLlo1ytH1gGASsTbTn7VTi6vJ7L
         mvGx/tpaDWfRzDX+EKZIB7Ei2ua1biCBITXAsBJYXgATJtWewkHgpfxfBJyN8F7mfM4y
         2rsTk+WOHrtbO5gqJPj+62w+OarOmYu0KqsrOH/3alC28NRcM0D78rsPh7nqBOfclEhZ
         CQ8Q==
X-Gm-Message-State: APjAAAWmyGcNIneN+7hOqDNPelOPLMl+zWzao4V9d05DPKX2QBT8D7RN
        z8WsS0R8tl4CLjGTfRfwwdDYcboPnRKWGnwLMdXVRFAUhio=
X-Google-Smtp-Source: APXvYqwsfFzq80hquq3LspX/KN8hSx+8XNuRLGL/HQaf/j7qBgvYUtZPltNqkh2RP5g3Ixh87lq8IwyPtjgKvxPCZeY=
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr36057955qkj.36.1579220894464;
 Thu, 16 Jan 2020 16:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20200115171333.28811-1-kpsingh@chromium.org> <20200115171333.28811-6-kpsingh@chromium.org>
In-Reply-To: <20200115171333.28811-6-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Jan 2020 16:28:03 -0800
Message-ID: <CAEf4BzYJy40csmwfBgtD+UZY3X+hjqpQ=NwjUQ-cwy+RPF8VHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/10] bpf: lsm: BTF API for LSM hooks
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 15, 2020 at 9:14 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The BTF API provides information required by the BPF verifier to
> attach eBPF programs to the LSM hooks by using the BTF information of
> two types:
>
> - struct security_hook_heads: This type provides the offset which
>   a new dynamically allocated security hook must be attached to.
> - union security_list_options: This provides the information about the
>   function prototype required by the hook.
>
> When the program is loaded:
>
> - The verifier receives the index of a member in struct
>   security_hook_heads to which a program must be attached as
>   prog->aux->lsm_hook_index. The index is one-based for better
>   verification.
> - bpf_lsm_type_by_index is used to determine the func_proto of
>   the LSM hook and updates prog->aux->attach_func_proto
> - bpf_lsm_head_by_index is used to determine the hlist_head to which
>   the BPF program must be attached.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/linux/bpf_lsm.h |  12 +++++
>  security/bpf/Kconfig    |   1 +
>  security/bpf/hooks.c    | 104 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)
>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 9883cf25241c..a9b4f7b41c65 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -19,6 +19,8 @@ extern struct security_hook_heads bpf_lsm_hook_heads;
>
>  int bpf_lsm_srcu_read_lock(void);
>  void bpf_lsm_srcu_read_unlock(int idx);
> +const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 offset);
> +const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 id);
>
>  #define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)                     \
>         do {                                                    \
> @@ -65,6 +67,16 @@ static inline int bpf_lsm_srcu_read_lock(void)
>         return 0;
>  }
>  static inline void bpf_lsm_srcu_read_unlock(int idx) {}
> +static inline const struct btf_type *bpf_lsm_type_by_index(
> +       struct btf *btf, u32 index)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline const struct btf_member *bpf_lsm_head_by_index(
> +       struct btf *btf, u32 id)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
>
>  #endif /* CONFIG_SECURITY_BPF */
>
> diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
> index 595e4ad597ae..9438d899b618 100644
> --- a/security/bpf/Kconfig
> +++ b/security/bpf/Kconfig
> @@ -7,6 +7,7 @@ config SECURITY_BPF
>         depends on SECURITY
>         depends on BPF_SYSCALL
>         depends on SRCU
> +       depends on DEBUG_INFO_BTF
>         help
>           This enables instrumentation of the security hooks with
>           eBPF programs.
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index b123d9cb4cd4..82725611693d 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -5,6 +5,8 @@
>   */
>
>  #include <linux/bpf_lsm.h>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
>  #include <linux/srcu.h>
>
>  DEFINE_STATIC_SRCU(security_hook_srcu);
> @@ -18,3 +20,105 @@ void bpf_lsm_srcu_read_unlock(int idx)
>  {
>         return srcu_read_unlock(&security_hook_srcu, idx);
>  }
> +
> +static inline int validate_hlist_head(struct btf *btf, u32 type_id)
> +{
> +       s32 hlist_id;
> +
> +       hlist_id = btf_find_by_name_kind(btf, "hlist_head", BTF_KIND_STRUCT);
> +       if (hlist_id < 0 || hlist_id != type_id)
> +               return -EINVAL;

This feels backwards and expensive. You already have type_id you want
to check. Do a quick look up, check type and other attributes, if you
want. There is no need to do linear search for struct named
"hlist_head".

But in reality, you should trust kernel BTF, you already know that you
found correct "security_hook_heads" struct, so its member has to be
hlist_head, no?

> +
> +       return 0;
> +}
> +
> +/* Find the BTF representation of the security_hook_heads member for a member
> + * with a given index in struct security_hook_heads.
> + */
> +const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 index)
> +{
> +       const struct btf_member *member;
> +       const struct btf_type *t;
> +       u32 off, i;
> +       int ret;
> +
> +       t = btf_type_by_name_kind(btf, "security_hook_heads", BTF_KIND_STRUCT);
> +       if (WARN_ON_ONCE(IS_ERR(t)))
> +               return ERR_CAST(t);
> +
> +       for_each_member(i, t, member) {
> +               /* We've found the id requested and need to check the
> +                * the following:
> +                *
> +                * - Is it at a valid alignment for struct hlist_head?
> +                *
> +                * - Is it a valid hlist_head struct?
> +                */
> +               if (index == i) {

Also not efficient. Check index to be < vlen(t), then member =
btf_type_member(t) + index;


> +                       off = btf_member_bit_offset(t, member);
> +                       if (off % 8)
> +                               /* valid c code cannot generate such btf */
> +                               return ERR_PTR(-EINVAL);
> +                       off /= 8;
> +
> +                       if (off % __alignof__(struct hlist_head))
> +                               return ERR_PTR(-EINVAL);
> +
> +                       ret = validate_hlist_head(btf, member->type);
> +                       if (ret < 0)
> +                               return ERR_PTR(ret);
> +
> +                       return member;

This feels a bit over-cautious to double-check this. If
security_hook_heads definition is controlled by kernel sources, then
we could just trust vmlinux BTF?

> +               }
> +       }
> +
> +       return ERR_PTR(-ENOENT);
> +}
> +
> +/* Given an index of a member in security_hook_heads return the
> + * corresponding type for the LSM hook. The members of the union
> + * security_list_options have the same name as the security_hook_heads which
> + * is ensured by the LSM_HOOK_INIT macro defined in include/linux/lsm_hooks.h
> + */
> +const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 index)
> +{
> +       const struct btf_member *member, *hook_head = NULL;
> +       const struct btf_type *t, *hook_type = NULL;
> +       u32 i;
> +
> +       hook_head = bpf_lsm_head_by_index(btf, index);
> +       if (IS_ERR(hook_head))
> +               return ERR_PTR(PTR_ERR(hook_head));
> +
> +       t = btf_type_by_name_kind(btf, "security_list_options", BTF_KIND_UNION);
> +       if (WARN_ON_ONCE(IS_ERR(t)))
> +               return ERR_CAST(t);

btf_type_by_name_kind() is a linear search (at least right now), so it
might be a good idea to cache found type_id's of security_list_options
and security_hook_heads?

> +
> +       for_each_member(i, t, member) {
> +               if (hook_head->name_off == member->name_off) {
> +                       /* There should be only one member with the same name
> +                        * as the LSM hook. This should never really happen
> +                        * and either indicates malformed BTF or someone trying
> +                        * trick the LSM.
> +                        */
> +                       if (WARN_ON(hook_type))
> +                               return ERR_PTR(-EINVAL);
> +
> +                       hook_type = btf_type_by_id(btf, member->type);
> +                       if (unlikely(!hook_type))
> +                               return ERR_PTR(-EINVAL);
> +
> +                       if (!btf_type_is_ptr(hook_type))
> +                               return ERR_PTR(-EINVAL);
> +               }
> +       }
> +
> +       if (!hook_type)
> +               return ERR_PTR(-ENOENT);
> +
> +       t = btf_type_by_id(btf, hook_type->type);
> +       if (unlikely(!t))
> +               return ERR_PTR(-EINVAL);

why not do this inside the loop when you find correct member and not
continue processing all the fields?

> +
> +       return t;
> +}
> --
> 2.20.1
>
