Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D8262672
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 06:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgIIErR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 00:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIErQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 00:47:16 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF3C061573
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 21:47:16 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c17so958056ybe.0
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehQQwpyxLJuDKvY9UinNrD51+FCaPAcLTZnr8upXrn4=;
        b=OMDnGbszjqXW/OwSM/AJ7NAeG4P+prT3tyEXEzYwDs6YZGPpwJbhiR1rEBYpa7tAFR
         +DiTQHCPWdum1kBdZblKyGm9ooDeH5K2V+L8RYpKQjMZL1eLHKbXoNmu22nBiI1kn9sb
         z5jOQfQ9gGWeBB2WsHrtaowKPnoRic9fme7eR0n1z6ufRR3l1k8N6Zzyxi49/qYVUgXv
         OuGVhgHoe36r0EYmHeHfzqOZbgBy++zhj71bIW2Avk+/4YaAKC80hCL49p3KnmHHbv2q
         aRmAQ4I40YgpQUuabIXvAeTTdiubk5hOYoi/oKVbHJJGV2Q8NL/3OoRgieG/kZCpN6Bm
         Adiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehQQwpyxLJuDKvY9UinNrD51+FCaPAcLTZnr8upXrn4=;
        b=VqP2pLaaulpEbooPicwIdY57A8QyRglW1efeWXhgTvcWVcuRNtQCGXowsUkI2Bwgie
         I0tXGKG9tYK8kbt2lLGRI29XONWFB2m2I88KDac91w5N2OBzXHiIn1kkOEHM1zobz5ed
         LfiwfGK37ArsxOq3EOnm7qmPqu+FBU5MbDouVRhezQP23by0aujANEf/bD+kOmZfIS+A
         SPM9eaQ16g9XR2UpT8j78CQljIWZf69Ag9yvSJ/+Mquc2IvzJq5vWS0u7FmRM9IbKZYF
         48SW0k8DvdCIKAHmLrBSWan5d7WufeB3lCZPwPUBc5ioDb6/FlzlNn9UGn8HWBvdiGm5
         FM/g==
X-Gm-Message-State: AOAM531XtYmLUIQgsge32rQfQazYwINDPi/tj7vZk+0D7kX/orL7J503
        7GX0d3ZNFNQ26QH3oocPdMUPbp2JiJTUgCxOH58=
X-Google-Smtp-Source: ABdhPJz94E95CRNqXcsS+vXJA5Ms2pR7l698EvuThfaRa9hsFSZWJrOhMPUgC02ZD5KqyCmny13tCDWVcisfTTgAoj0=
X-Received: by 2002:a25:9d06:: with SMTP id i6mr2230451ybp.510.1599626835610;
 Tue, 08 Sep 2020 21:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-6-lmb@cloudflare.com>
In-Reply-To: <20200904112401.667645-6-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 21:47:04 -0700
Message-ID: <CAEf4BzbPJKK+YPTgPmaUVsKg3GQdwJKypfSZXg09M+sY8BzDbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/11] bpf: allow specifying a set of BTF IDs for
 helper arguments
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 4:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> IDs, one for each argument. This array is only accessed up to the highest
> numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> is a function pointer that is called by the verifier if present. It gets the
> actual BTF ID of the register, and the argument number we're currently checking.
> It turns out that the only user check_arg_btf_id ignores the argument, and is
> simply used to check whether the BTF ID matches one of the socket types.
>
> Replace both of these mechanisms with explicit btf_id_sets for each argument
> in a function proto. The verifier can now check that a PTR_TO_BTF_ID is one
> of several IDs, and the code that does the type checking becomes simpler.
>
> Add a small optimisation to btf_set_contains for the common case of a set with
> a single entry.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

You are replacing a more generic and powerful capability with a more
restricted one because no one is yet using a generic one fully. It
might be ok and we'll never need a more generic way to check BTF IDs.
But it will be funny if we will be adding this back soon because a
static set of BTF IDs don't cut it for some cases :)

I don't mind this change, but I wonder what others think about this.

>  include/linux/bpf.h            | 22 ++++++++++---------
>  kernel/bpf/bpf_inode_storage.c |  8 +++----
>  kernel/bpf/btf.c               | 22 ++++++-------------
>  kernel/bpf/stackmap.c          |  5 +++--
>  kernel/bpf/verifier.c          | 39 +++++++++++++---------------------
>  kernel/trace/bpf_trace.c       | 15 +++++++------
>  net/core/bpf_sk_storage.c      | 10 +++++----
>  net/core/filter.c              | 31 ++++++++++-----------------
>  net/ipv4/bpf_tcp_ca.c          | 24 +++++++++------------
>  9 files changed, 76 insertions(+), 100 deletions(-)
>

[...]

> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> index 75be02799c0f..d447d2655cce 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -249,9 +249,9 @@ const struct bpf_map_ops inode_storage_map_ops = {
>         .map_owner_storage_ptr = inode_storage_ptr,
>  };
>
> -BTF_ID_LIST(bpf_inode_storage_btf_ids)
> -BTF_ID_UNUSED
> +BTF_SET_START(bpf_inode_storage_btf_ids)
>  BTF_ID(struct, inode)
> +BTF_SET_END(bpf_inode_storage_btf_ids)

with your change single-element BTF ID set becomes a very common case,
so having a simple macro that combines BTF_SET_START + BTF_ID +
BTF_SET_END in one simple macro would be useful, I think

>
>  const struct bpf_func_proto bpf_inode_storage_get_proto = {
>         .func           = bpf_inode_storage_get,
> @@ -259,9 +259,9 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
>         .ret_type       = RET_PTR_TO_MAP_VALUE_OR_NULL,
>         .arg1_type      = ARG_CONST_MAP_PTR,
>         .arg2_type      = ARG_PTR_TO_BTF_ID,
> +       .arg2_btf_ids   = &bpf_inode_storage_btf_ids,
>         .arg3_type      = ARG_PTR_TO_MAP_VALUE_OR_NULL,
>         .arg4_type      = ARG_ANYTHING,
> -       .btf_id         = bpf_inode_storage_btf_ids,
>  };
>

[...]

> @@ -4065,26 +4066,21 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>         }
>
>         if (type == PTR_TO_BTF_ID) {
> -               bool ids_match = false;
> +               if (fn->arg_btf_ids[arg])
> +                       btf_ids = fn->arg_btf_ids[arg];

nit: no need for the if part, just assign directly, even if its NULL

>
> -               if (!fn->check_btf_id) {
> -                       if (reg->btf_id != meta->btf_id) {
> -                               ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> -                                                                meta->btf_id);
> -                               if (!ids_match) {
> -                                       verbose(env, "Helper has type %s got %s in R%d\n",
> -                                               kernel_type_name(meta->btf_id),
> -                                               kernel_type_name(reg->btf_id), regno);
> -                                       return -EACCES;
> -                               }
> -                       }
> -               } else if (!fn->check_btf_id(reg->btf_id, arg)) {
> -                       verbose(env, "Helper does not support %s in R%d\n",
> -                               kernel_type_name(reg->btf_id), regno);
> +               if (!btf_ids) {
> +                       verbose(env, "verifier internal error: missing BTF IDs\n");
> +                       return -EFAULT;
> +               }
>
> +               if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> +                                         btf_ids)) {
> +                       verbose(env, "R%d has incompatible type %s\n", regno,
> +                               kernel_type_name(reg->btf_id));
>                         return -EACCES;
>                 }
> -               if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
> +               if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
>                         verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
>                                 regno);
>                         return -EACCES;

[...]
