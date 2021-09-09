Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571A14044F3
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbhIIF1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350499AbhIIF1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:27:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441A0C061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:26:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z5so1538593ybj.2
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2XLsWwCFW1fXgzxno0oIkQ3Fb5AlMvwh54ckmY1Uxw=;
        b=YaJ/xKzwaCPpkp7d2PAdZp7XuSshpZUix/dVj5p0HUom7MT2zbm6t36WO6ghJa5EAK
         4duu9o51/JlS3cRsZgJ7zHDwd1fShzJIEv6Rl5ZRmX0AvMcpJ3zUMJc3Cs0bNapdIXuG
         /Juf9DLo4OI3xVshAlHg7iniCllmM65pHB+EOSKzsMLXmfU8plG0eBeZlLEcMNLZ7JOW
         RsOW8KXXrnwAWowSKdBFcpjOkedcr9DhbldZShH6u9u+A2nmiwtYYcp7ZyQwhsujeLUe
         fVCfmYnqMTWo2yF47Fu4u/yY5GKEj+9dWGRtZ292uuS8HDU52e64QP7CDz6Yo86v5NSX
         tNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2XLsWwCFW1fXgzxno0oIkQ3Fb5AlMvwh54ckmY1Uxw=;
        b=aEFnHKLZSSe7lKBS/jN65TWV/OyYevmByozfnjRR6tQC6EMUYfitCcw8JVgc7QMs+b
         REPazTamwNC6f2Su1Vu2qSXnDFC4RfzSObnn3bqc9pGr6zEwivgK/AmvW3+1etVNwx93
         sCFACIdmmxaE8mrrcsIWpYdUr1u+vHIvv6oBxHm8hHwd6NRS2WwIjQGZCZAX9ADgaZv5
         6k6cAzBh+UMO6B3VyYCY3JGlL8r8mPOhbxa0VAyQ7taIllaGe79A54WdOWN166/wDYxe
         KbcGYWFPNiT7CQBeZvH86zI3HUZrAxJ0cCfqUei7m+CirIGl3jsjTQpNCJY0VE79nzFM
         DQBQ==
X-Gm-Message-State: AOAM5305Mpa65+aDqdrJWfRHW2VJCMp6IkAOOb1sZIWaBqjdMNreh4mg
        TgnKiMx2eFZ9ssSOHAddpL1IXIuABJFZ5nvfwoJgiX/CDdo=
X-Google-Smtp-Source: ABdhPJznHh5CIDKJDAdVisJq1opWU+fCvRl7aLTfc8j+PrSC3YG7jXXZc7J30z0el+dqfUjHNb4NlqMH4N46Uaa0w6E=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr1685877ybt.178.1631165204483;
 Wed, 08 Sep 2021 22:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230105.1958546-1-yhs@fb.com>
In-Reply-To: <20210907230105.1958546-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:26:32 -0700
Message-ID: <CAEf4Bza5azi3mamL8geoCPJm-jxtKYsJ6+-Yv8uEg_pBkachNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/9] libbpf: add support for BTF_KIND_TAG
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
> Add BTF_KIND_TAG support for parsing and dedup.
> Also added sanitization for BTF_KIND_TAG. If BTF_KIND_TAG is not
> supported in the kernel, sanitize it to INTs.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.c             | 61 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h             | 13 +++++++
>  tools/lib/bpf/btf_dump.c        |  3 ++
>  tools/lib/bpf/libbpf.c          | 31 +++++++++++++++--
>  tools/lib/bpf/libbpf.map        |  1 +
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  6 files changed, 108 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 7cb6ebf1be37..ed02b17aad17 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -304,6 +304,8 @@ static int btf_type_size(const struct btf_type *t)
>                 return base_size + sizeof(struct btf_var);
>         case BTF_KIND_DATASEC:
>                 return base_size + vlen * sizeof(struct btf_var_secinfo);
> +       case BTF_KIND_TAG:
> +               return base_size + sizeof(struct btf_tag);
>         default:
>                 pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
>                 return -EINVAL;
> @@ -376,6 +378,9 @@ static int btf_bswap_type_rest(struct btf_type *t)
>                         v->size = bswap_32(v->size);
>                 }
>                 return 0;
> +       case BTF_KIND_TAG:
> +               btf_tag(t)->comp_id = bswap_32(btf_tag(t)->comp_id);
> +               return 0;
>         default:
>                 pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
>                 return -EINVAL;
> @@ -586,6 +591,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
>                 case BTF_KIND_CONST:
>                 case BTF_KIND_RESTRICT:
>                 case BTF_KIND_VAR:
> +               case BTF_KIND_TAG:
>                         type_id = t->type;
>                         break;
>                 case BTF_KIND_ARRAY:
> @@ -2440,6 +2446,41 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
>         return 0;
>  }
>
> +int btf__add_tag(struct btf *btf, const char *name, int comp_id, int ref_type_id)

Curious about the terminology here. The string recorded in bpf_tag, is
that a "name" of the tag, or rather a "value" of the tag? We should
reflect that in argument names for btf__add_tag.

I'll also nitpick on order of arguments. ref_type_id is always
specified, and it points to the entire type (struct/union/func), while
comp_id might, optionally, point inside that type. So I think the
order should be ref_type_id followed by comp_id.

Please also add a comment describing inputs (especially the -1 comp_id
case) and outputs, like all that other btf__add_xxx() APIs.

> +{
> +       bool for_ref_type = false;
> +       struct btf_type *t;
> +       int sz, name_off;
> +
> +       if (!name || !name[0] || comp_id < -1)
> +               return libbpf_err(-EINVAL);
> +
> +       if (validate_type_id(ref_type_id))
> +               return libbpf_err(-EINVAL);
> +
> +       if (btf_ensure_modifiable(btf))
> +               return libbpf_err(-ENOMEM);
> +
> +       sz = sizeof(struct btf_type) + sizeof(struct btf_tag);
> +       t = btf_add_type_mem(btf, sz);
> +       if (!t)
> +               return libbpf_err(-ENOMEM);
> +
> +       name_off = btf__add_str(btf, name);
> +       if (name_off < 0)
> +               return name_off;
> +
> +       t->name_off = name_off;
> +       t->type = ref_type_id;
> +
> +       if (comp_id == -1)
> +               for_ref_type = true;
> +       t->info = btf_type_info(BTF_KIND_TAG, 0, for_ref_type);
> +       ((struct btf_tag *)(t + 1))->comp_id = for_ref_type ? 0 : comp_id;

As I mentioned in the previous patch, it feels cleaner to just have
this -1 special value and not utilize kflag at all. It will match
libbpf API as you defined it naturally.

> +
> +       return btf_commit_type(btf, sz);
> +}
> +

[...]

>         case BTF_KIND_ARRAY: {
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4a711f990904..a78cf8331d49 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -141,6 +141,9 @@ LIBBPF_API int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz
>  LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
>                                          __u32 offset, __u32 byte_sz);
>
> +/* tag contruction API */

typo: construction, but I'd put it after btf__add_restrict with no comment

> +LIBBPF_API int btf__add_tag(struct btf *btf, const char *name, int comp_id, int ref_type_id);
> +
>  struct btf_dedup_opts {
>         unsigned int dedup_table_size;
>         bool dont_resolve_fwds;
> @@ -328,6 +331,11 @@ static inline bool btf_is_float(const struct btf_type *t)
>         return btf_kind(t) == BTF_KIND_FLOAT;
>  }
>
> +static inline bool btf_is_tag(const struct btf_type *t)
> +{
> +       return btf_kind(t) == BTF_KIND_TAG;
> +}
> +
>  static inline __u8 btf_int_encoding(const struct btf_type *t)
>  {
>         return BTF_INT_ENCODING(*(__u32 *)(t + 1));
> @@ -396,6 +404,11 @@ btf_var_secinfos(const struct btf_type *t)
>         return (struct btf_var_secinfo *)(t + 1);
>  }
>

please add `struct btf_tag;` forward reference for those users who are
compiling with old UAPI headers.

> +static inline struct btf_tag *btf_tag(const struct btf_type *t)
> +{
> +       return (struct btf_tag *)(t + 1);
> +}
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif

[...]

>  LIBBPF_0.5.0 {
>         global:
> +               btf__add_tag;
>                 bpf_map__initial_value;
>                 bpf_map__pin_path;
>                 bpf_map_lookup_and_delete_elem_flags;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 533b0211f40a..7deb86d9af51 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -69,6 +69,8 @@
>  #define BTF_VAR_SECINFO_ENC(type, offset, size) (type), (offset), (size)
>  #define BTF_TYPE_FLOAT_ENC(name, sz) \
>         BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
> +#define BTF_TYPE_TAG_KIND_ENC(name, type) \

following other macro names, it should be BTF_TYPE_TAG_ENC, no?

> +       BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_TAG, 1, 0), type), (0)
>
>  #ifndef likely
>  #define likely(x) __builtin_expect(!!(x), 1)
> --
> 2.30.2
>
