Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700E4044B6
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350550AbhIIFKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhIIFKh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:10:37 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03926C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:09:29 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c206so1407982ybb.12
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JSOv65gEFSbzR13SPjZkVebRYk5cYUh9we/UeKVcGc=;
        b=eXn6vJb+qkh7OnF9oWX8hlcJW3FKFiVT2hVC0hiotuJeyBQWkZt8Xcw1+FuXfeXk09
         21ug6hwOjTpQ/q4N2Khgj8VGNr1ZLcVXxxf4yhKx6m6kJCK/+D7HwKKD8Vkl3ooUUmJf
         iSY8fVZqk0MOK5ntrJtdMa1YC8CMpoOBXmsEnS4y4V2Jh1Zx/wP5vgzX9H7TnPqcs+0u
         fB4YMJByT0Fa0JRfj4e5mbQTLOabYl/tKy6pL+UeqhnCb4EC42SvXhal13SIUH+fO5/Y
         ba7kBYXVZvPuJIRJZAny9W3aRc/zEZ3hadp2xIOa093C1lMDsuwL0S9Ay0EEwqRQ9lI7
         FDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JSOv65gEFSbzR13SPjZkVebRYk5cYUh9we/UeKVcGc=;
        b=rnIFZcsSONQPeEOdUVFts8AQdVB0J7yNT7fUbV03MowIbemHyr9n0ID7N7PCtdvpk9
         7oHKgeWlf3Z7xAaoljMXuppQVGuQew13xCoiEml1FD6JbBqzBV4mCYlZhnqrYp01TkFO
         J7rzclQivJvxXtkdeFHZgXg0guHihG7Q6gWgn8sfu47T0V3Wu7+5dhLZ7AZj9XOB7vxg
         oycoqaoIpOyJbGcdzrU62LKg3iFnVg3LN1bWIM70Be+LKbzrTqrCCtsnQlo8YuyJ6kYa
         UjNqwn0ri5Vc51/Cgc0yanbQ1QLx08cvi+44TK1shM+iXnoT5mc0Bt89ETIh4L3IXgs/
         rvZw==
X-Gm-Message-State: AOAM531XlyAK/NuNNegSP0BMNWWU/4Lu1vynP5p5V25yFqdY0PpOMCR3
        gsLOimlCLpPWdjCDbCSv/Z4bMqWOrX1q/SjJ7vDmDve8
X-Google-Smtp-Source: ABdhPJz/F39SkSGDYqixxKdZHXgDWmA+19ui/P7tyoPQ9jPHe+KQhMNconBgBLdRD9U8LQb0BDG8LhUmhgnx41Pyv6M=
X-Received: by 2002:a5b:702:: with SMTP id g2mr1415492ybq.307.1631164168196;
 Wed, 08 Sep 2021 22:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230055.1957809-1-yhs@fb.com>
In-Reply-To: <20210907230055.1957809-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:09:17 -0700
Message-ID: <CAEf4BzYUhFZf_Kt+uQ1k4N1k_H3uJd2A9-FqSF9HbcfvLYUO4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/9] bpf: support for new btf kind BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM14 added support for a new C attribute ([1])
>   __attribute__((btf_tag("arbitrary_str")))
> This attribute will be emitted to dwarf ([2]) and pahole
> will convert it to BTF. Or for bpf target, this
> attribute will be emitted to BTF directly ([3]).
> The attribute is intended to provide additional
> information for
>   - struct/union type or struct/union member
>   - static/global variables
>   - static/global function or function parameter.
>
> For linux kernel, the btf_tag can be applied
> in various places to specify user pointer,
> function pre- or post- condition, function
> allow/deny in certain context, etc. Such information
> will be encoded in vmlinux BTF and can be used
> by verifier.
>
> The btf_tag can also be applied to bpf programs
> to help global verifiable functions, e.g.,
> specifying preconditions, etc.
>
> This patch added basic parsing and checking support
> in kernel for new BTF_KIND_TAG kind.
>
>  [1] https://reviews.llvm.org/D106614
>  [2] https://reviews.llvm.org/D106621
>  [3] https://reviews.llvm.org/D106622
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/uapi/linux/btf.h       |  15 ++++-
>  kernel/bpf/btf.c               | 115 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/btf.h |  15 ++++-
>  3 files changed, 139 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index d27b1708efe9..ca73c4449116 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -36,14 +36,14 @@ struct btf_type {
>          * bits 24-27: kind (e.g. int, ptr, array...etc)
>          * bits 28-30: unused
>          * bit     31: kind_flag, currently used by
> -        *             struct, union and fwd
> +        *             struct, union, fwd and tag
>          */
>         __u32 info;
>         /* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
>          * "size" tells the size of the type it is describing.
>          *
>          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
> -        * FUNC, FUNC_PROTO and VAR.
> +        * FUNC, FUNC_PROTO, VAR and TAG.
>          * "type" is a type_id referring to another type.
>          */
>         union {
> @@ -73,7 +73,8 @@ struct btf_type {
>  #define BTF_KIND_VAR           14      /* Variable     */
>  #define BTF_KIND_DATASEC       15      /* Section      */
>  #define BTF_KIND_FLOAT         16      /* Floating point       */
> -#define BTF_KIND_MAX           BTF_KIND_FLOAT
> +#define BTF_KIND_TAG           17      /* Tag */
> +#define BTF_KIND_MAX           BTF_KIND_TAG
>  #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)

offtop, but realized reading this: we should probably turn these into
enums and capture them in vmlinux BTF and subsequently in vmlinux.h

>
>  /* For some specific BTF_KIND, "struct btf_type" is immediately
> @@ -170,4 +171,12 @@ struct btf_var_secinfo {
>         __u32   size;
>  };
>
> +/* BTF_KIND_TAG is followed by a single "struct btf_tag" to describe
> + * additional information related to the tag such as which field of
> + * a struct or union or which argument of a function.
> + */
> +struct btf_tag {
> +       __u32   comp_id;

what does "comp" stand for, component? If yes, it's quite non-obvious,
I wonder if just as generic "member" would be better (and no
contractions)? Maybe also not id (because I immediately thought about
BTF type IDs), but "index". So "member_idx"? "component_idx" would be
quite obvious as well, just a bit longer.

> +};
> +
>  #endif /* _UAPI__LINUX_BTF_H__ */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index dfe61df4f974..9545290f804b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -281,6 +281,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
>         [BTF_KIND_FLOAT]        = "FLOAT",
> +       [BTF_KIND_TAG]          = "TAG",
>  };
>

[...]

> +       const struct btf_tag *tag;
> +       u32 meta_needed = sizeof(*tag);
> +
> +       if (meta_left < meta_needed) {
> +               btf_verifier_log_basic(env, t,
> +                                      "meta_left:%u meta_needed:%u",
> +                                      meta_left, meta_needed);
> +               return -EINVAL;
> +       }
> +
> +       if (!t->name_off) {
> +               btf_verifier_log_type(env, t, "Invalid name");
> +               return -EINVAL;
> +       }
> +
> +       if (btf_type_vlen(t)) {
> +               btf_verifier_log_type(env, t, "vlen != 0");
> +               return -EINVAL;
> +       }
> +
> +       tag = btf_type_tag(t);
> +       if (btf_type_kflag(t) && tag->comp_id) {

just realized that we could have reserved comp_id == (u32)-1 as the
meaning "applies to entire struct/func/etc"? This might be a bit
cleaner, because if you forget about kflag() semantics, you can treat
comp_id == 0 as if it applied to first member, but if we put
0xffffffff, you'll get SIGSEGV with high probability (making the
problem more obvious)?


> +               btf_verifier_log_type(env, t, "kflag/comp_id mismatch");
> +               return -EINVAL;
> +       }
> +
> +       btf_verifier_log_type(env, t, NULL);
> +
> +       return meta_needed;
> +}
> +
> +static int btf_tag_resolve(struct btf_verifier_env *env,
> +                          const struct resolve_vertex *v)
> +{
> +       const struct btf_type *next_type;
> +       const struct btf_type *t = v->t;
> +       u32 next_type_id = t->type;
> +       struct btf *btf = env->btf;
> +       u32 vlen, comp_id;
> +
> +       next_type = btf_type_by_id(btf, next_type_id);
> +       if (!next_type || !btf_type_is_tag_target(next_type)) {
> +               btf_verifier_log_type(env, v->t, "Invalid type_id");
> +               return -EINVAL;
> +       }
> +
> +       if (!env_type_is_resolve_sink(env, next_type) &&
> +           !env_type_is_resolved(env, next_type_id))
> +               return env_stack_push(env, next_type, next_type_id);
> +
> +       if (!btf_type_kflag(t)) {
> +               if (btf_type_is_struct(next_type)) {
> +                       vlen = btf_type_vlen(next_type);
> +               } else if (btf_type_is_func(next_type)) {
> +                       next_type = btf_type_by_id(btf, next_type->type);
> +                       vlen = btf_type_vlen(next_type);
> +               } else {
> +                       btf_verifier_log_type(env, v->t, "Invalid next_type");
> +                       return -EINVAL;
> +               }
> +
> +               comp_id = btf_type_tag(t)->comp_id;
> +               if (comp_id >= vlen) {
> +                       btf_verifier_log_type(env, v->t, "Invalid comp_id");
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       env_stack_pop_resolved(env, next_type_id, 0);
> +
> +       return 0;
> +}
> +
> +static void btf_tag_log(struct btf_verifier_env *env, const struct btf_type *t)
> +{
> +       btf_verifier_log(env, "type=%u", t->type);

comp_id and kflag should be logged as well, they are important part

> +}
> +
> +static const struct btf_kind_operations tag_ops = {
> +       .check_meta = btf_tag_check_meta,
> +       .resolve = btf_tag_resolve,
> +       .check_member = btf_df_check_member,
> +       .check_kflag_member = btf_df_check_kflag_member,
> +       .log_details = btf_tag_log,
> +       .show = btf_df_show,
> +};
> +

[...]
