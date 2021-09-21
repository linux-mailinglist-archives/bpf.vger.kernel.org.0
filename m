Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFAC413C5A
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 23:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhIUV0v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhIUV0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 17:26:48 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82AFC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:25:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 194so1910678qkj.11
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwwJnqcN/z36PRqQLfEZmEbHYa3C4kaR0BRVN54o6rs=;
        b=ey4isOZyNShbl0GYk8ZsQytTlA/I2FxWTV4DVKfuUdsaImjW5IxoH8p5ApdEmPAq8C
         WNJBCQULyPKq4QPCJoR6+uzQH0a/HR+ZX6JI/uPm+39AEWE4LrLUbYdU92RQ6ZNLsNHt
         eI1QEPQn6XJYKCGM8V5/CZIr7fDZjoJmCbyhrfoviLHxnW+i72kyjsD6QhJJORjf5ois
         NFfCk6nUnqt+eq+2qRQdpdXAS8m5CaqBvZ65jZllQxjhl6VivXYhl6a2YHZgmeP2f2An
         uRDNBeJrjNz1ZRPa9pFHJyCD1YIev1lhUO0f5Z4s3KZBAUGUu9amHNzO4+FHuLlfO2Xi
         u2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwwJnqcN/z36PRqQLfEZmEbHYa3C4kaR0BRVN54o6rs=;
        b=1b8mY27U0qxfxe6v+Gqj094WxzM6S80qt13DInUq3PXk8pHRzNy5qqn2r/V9b0J+kc
         aIrCa48g1ObyIdF8i5IYyknZr7zktW1/SBUiWEpe5Ct2ad6wqxCM4G5qvzJ1ndk24V+s
         7U43+Hve67zyC5rBiWmyGqWkOXmYD/WfVTBWx/SvZT/FGptMfdmWg5TFu6rYndY62oIo
         QKVmw9Dj3cPtNSGHShp0m6Q1J1UfjTxkLXg+bT8WpTmrsWBa44BmX3lSBCfWLtvpAbFz
         zWkEJmsqvDGTApdU+O9oRSfMxCiCynOo7j+5i3xr56oICcQjx5BPm4+qiKkmOgrnSed0
         SIhQ==
X-Gm-Message-State: AOAM532uWB+p7+F7f9T5N3hSz7LcQ2b9xs26msu1cOBEfiPX3kY31dfB
        6mT2QdUc304AYW0xq8GG6ROp4hiXT95myiDNyakwqZK0Xf8=
X-Google-Smtp-Source: ABdhPJymnvm/G6K0ua2vIYJiS13GEAmlInUD5y/q1eGf8wcO9ygJrpf02GKK4MpCQaW87Z1YHLLrp8A/FPRB7drCKM0=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr39357028ybp.51.1632259517974;
 Tue, 21 Sep 2021 14:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com> <20210917215721.43491-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20210917215721.43491-2-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 14:25:06 -0700
Message-ID: <CAEf4Bzav49LODFUQ1jw57C6RN56PPQRWOSkGi_j5n1FQcp4p8A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel duty.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, mcroce@microsoft.com,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 2:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Make relo_core.c to be compiled with kernel and with libbpf.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/btf.h       | 89 +++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/Makefile       |  4 ++
>  kernel/bpf/btf.c          | 26 ++++++++++++
>  tools/lib/bpf/relo_core.c | 72 ++++++++++++++++++++++++++++++-
>  4 files changed, 189 insertions(+), 2 deletions(-)
>

[...]

>  static inline u16 btf_func_linkage(const struct btf_type *t)
>  {
>         return BTF_INFO_VLEN(t->info);
> @@ -193,6 +245,27 @@ static inline bool btf_type_kflag(const struct btf_type *t)
>         return BTF_INFO_KFLAG(t->info);
>  }
>
> +static inline struct btf_member *btf_members(const struct btf_type *t)
> +{
> +       return (struct btf_member *)(t + 1);
> +}
> +#ifdef RELO_CORE

ugh... seems like in most (if not all) cases kernel has member_idx
available, so it will be a simple and mechanical change to use
libbpf's member_idx implementation everywhere. Would allow #define
RELO_CORE, unless you think it's useful for something else?

> +static inline u32 btf_member_bit_offset(const struct btf_type *t, u32 member_idx)
> +{
> +       const struct btf_member *m = btf_members(t) + member_idx;
> +       bool kflag = btf_type_kflag(t);
> +
> +       return kflag ? BTF_MEMBER_BIT_OFFSET(m->offset) : m->offset;
> +}
> +

[...]

>  static inline const struct btf_var_secinfo *btf_type_var_secinfo(
>                 const struct btf_type *t)
>  {
> @@ -222,6 +307,10 @@ static inline const struct btf_var_secinfo *btf_type_var_secinfo(
>  struct bpf_prog;
>
>  const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
> +static inline const struct btf_type *btf__type_by_id(const struct btf *btf, u32 type_id)
> +{
> +       return btf_type_by_id(btf, type_id);
> +}

There is just one place in relo_core.c where btf__type_by_id()
behavior matters, that's in bpf_core_apply_relo_insn() which validates
that relocation info is valid. But we've already done that in
bpf_core_apply_relo() anyways, so I think all relo_core.c uses can be
just switched to btf_type_by_id(). So you don't need to add this tiny
wrapper.

>  const char *btf_name_by_offset(const struct btf *btf, u32 offset);
>  struct btf *btf_parse_vmlinux(void);
>  struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 7f33098ca63f..3d5370c876b5 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -36,3 +36,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
>  obj-${CONFIG_BPF_LSM} += bpf_lsm.o
>  endif
>  obj-$(CONFIG_BPF_PRELOAD) += preload/
> +
> +obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
> +$(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
> +       $(call if_changed_rule,cc_o_c)
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c3d605b22473..fa2c88f6ac4a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6343,3 +6343,29 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
>  };
>
>  BTF_ID_LIST_GLOBAL_SINGLE(btf_task_struct_ids, struct, task_struct)
> +
> +int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
> +                             const struct btf *targ_btf, __u32 targ_id)
> +{

We chatted offline about bpf_core_types_are_compat() and how it's used
in only one place. It's because fields have dedicated
bpf_core_fields_are_compat(), which is non-recursive.

> +       return -EOPNOTSUPP;
> +}
> +
> +static bool bpf_core_is_flavor_sep(const char *s)
> +{
> +       /* check X___Y name pattern, where X and Y are not underscores */
> +       return s[0] != '_' &&                                 /* X */
> +              s[1] == '_' && s[2] == '_' && s[3] == '_' &&   /* ___ */
> +              s[4] != '_';                                   /* Y */
> +}
> +

[...]
