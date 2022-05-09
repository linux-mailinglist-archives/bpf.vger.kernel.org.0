Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15EA52085C
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiEIXaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiEIXaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:30:04 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFDE45523
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:26:07 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h11so10342597ila.5
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twJ26pVK2ecmpVt6OFsJNBesMJ7UqjFuSMRiXFeyodA=;
        b=nWmpYGqUeHvJrUaXZSFKEm+NSg/RGX9EQ7utj9UgbTNDeQwVm1jgR1D2Svp96ry0ag
         l5GOZABad8Lh/Xc54x4Y3tTjyuLDoSZx6D7ygY6bNgVBEbtE5teOvrH8o8L3idr0SbUQ
         yJJcUh4eHwzctgNfSM53yS8k+tyWxzOL+OyK+vwBbkhE46tYA6kVzLQrmGQiaP9Twpx8
         w9tsM362yd2CAuciPSP2aJvfxjbRtoKO7bzDoWuqGy08UsvNzzwa87o2J6L42tM41YvC
         jwfxuIkaSEzIPDiP0D0O12656fnjhF2lArv3BIqjZO9NVn93iQavRMKL+1fy5ZnwbXbR
         4PEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twJ26pVK2ecmpVt6OFsJNBesMJ7UqjFuSMRiXFeyodA=;
        b=lL+rnqgzlpJVQnAZZUXIOy7TjAWnmBq3jZJHZTcWo8xiwK6YpPmOeNcCKRvsxN5l17
         W+qHOQsmTR5VD/QygNUB/J9bX2AIehm/Jzwn+EiXhypukSnGh4ZT6ti3DtfPirecyyg1
         OWaBQ762c5M/rIrCuauskF5hUimeLlJYFg9H0kHC5YK1gysASk4PIqD6Ac/nr1ND1aUH
         LRQv80kPZnG5H7g/UtJ//gPu4iPK6cEkdITcJ0y3BC6tD2h8xNhz4TBbht6OXB8mGeqM
         1ucWxK2j1dDGhaYFotNWIgLDBtqCZ1t5WL9OtgIZ+i1Dorc72XB+U0ChH3wgAOp84eE9
         n5Cg==
X-Gm-Message-State: AOAM530Go3xZvP7+Zrt4SNMxOUTT4sJivCbl4CHlgi05FdVM56cUtc9g
        nwJ0zdkgXexxIdT3DYImb1KY68qBzidF883PhgfFVadGWYk=
X-Google-Smtp-Source: ABdhPJzVQ/wJB9GEMZHSkjs8jAvEAy6DmqCByXBduOswv+/D1jbwu9cLtk3wjbxFVlH9PzLJ/2+aFsByj+awUV0CQVs=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr7817464ilb.305.1652138766919; Mon, 09
 May 2022 16:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190023.2578209-1-yhs@fb.com>
In-Reply-To: <20220501190023.2578209-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:25:56 -0700
Message-ID: <CAEf4BzbXuN4YOYqm_ojgTuJMo4a+J_M6WPF=MUX1B9BK8DdmMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_ENUM64 support. Deprecated btf__add_enum() and
> btf__add_enum_value() and introduced the following new APIs
>   btf__add_enum32()
>   btf__add_enum32_value()
>   btf__add_enum64()
>   btf__add_enum64_value()
> due to new kind and introduction of kflag.
>
> To support old kernel with enum64, the sanitization is
> added to replace BTF_KIND_ENUM64 with a bunch of
> pointer-to-void types.
>
> The enum64 value relocation is also supported. The enum64
> forward resolution, with enum type as forward declaration
> and enum64 as the actual definition, is also supported.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
>  tools/lib/bpf/btf.h                           |  21 ++
>  tools/lib/bpf/btf_dump.c                      |  94 ++++++--
>  tools/lib/bpf/libbpf.c                        |  64 ++++-
>  tools/lib/bpf/libbpf.map                      |   4 +
>  tools/lib/bpf/libbpf_internal.h               |   2 +
>  tools/lib/bpf/linker.c                        |   2 +
>  tools/lib/bpf/relo_core.c                     |  93 ++++---
>  .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
>  .../selftests/bpf/prog_tests/btf_write.c      |   6 +-
>  10 files changed, 450 insertions(+), 72 deletions(-)
>

This is a huge patch touching very different and logically independent
parts of libbpf. Please split it into smaller parts, e.g.:
  - libbpf.c changes (sanitization and kcfg);
  - BTF public API helpers (btf_is_enum64, btf__add_enum64);
  - btf_dump changes;
  - btf__dedup changes;
  - CO-RE relocations.

It will be easier to discuss each in a separate patch.

[...]

> +static int btf_add_enum_common(struct btf *btf, const char *name,
> +                              bool is_unsigned, __u8 kind, __u32 tsize)
> +{
> +       struct btf_type *t;
> +       int sz, name_off = 0;
> +
> +       if (btf_ensure_modifiable(btf))
> +               return libbpf_err(-ENOMEM);
> +
> +       sz = sizeof(struct btf_type);
> +       t = btf_add_type_mem(btf, sz);
> +       if (!t)
> +               return libbpf_err(-ENOMEM);
> +
> +       if (name && name[0]) {
> +               name_off = btf__add_str(btf, name);
> +               if (name_off < 0)
> +                       return name_off;
> +       }
> +
> +       /* start out with vlen=0; it will be adjusted when adding enum values */
> +       t->name_off = name_off;
> +       t->info = btf_type_info(kind, 0, is_unsigned);

As mentioned on another patch, I think unsigned should be default
(despite UAPI having s32 as type for enum's val), because that's what
we assume in practice. It makes backwards compatibility easier in more
than one place


> +       t->size = tsize;
> +
> +       return btf_commit_type(btf, sz);
> +}
> +
> +/*
> + * Append new BTF_KIND_ENUM type with:
> + *   - *name* - name of the enum, can be NULL or empty for anonymous enums;
> + *   - *is_unsigned* - whether the enum values are unsigned or not;
> + *
> + * Enum initially has no enum values in it (and corresponds to enum forward
> + * declaration). Enumerator values can be added by btf__add_enum64_value()
> + * immediately after btf__add_enum() succeeds.
> + *
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_enum32(struct btf *btf, const char *name, bool is_unsigned)

given it's still BTF_KIND_ENUM in UAPI, let's keep 32-bit ones as just
btf__add_enum()/btf__add_enum_value() and not deprecate anything.
ENUM64 can be thought about as more of a special case, so I think it's
ok.

> +{
> +       return btf_add_enum_common(btf, name, is_unsigned, BTF_KIND_ENUM, 4);
> +}
> +

[...]

>  /*
>   * Append new BTF_KIND_FWD type with:
>   *   - *name*, non-empty/non-NULL name;
> @@ -2242,7 +2419,7 @@ int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
>                 /* enum forward in BTF currently is just an enum with no enum
>                  * values; we also assume a standard 4-byte size for it
>                  */
> -               return btf__add_enum(btf, name, sizeof(int));
> +               return btf__add_enum32(btf, name, false);
>         default:
>                 return libbpf_err(-EINVAL);
>         }
> @@ -3485,6 +3662,7 @@ static long btf_hash_enum(struct btf_type *t)
>  /* Check structural equality of two ENUMs. */
>  static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
>  {
> +       const struct btf_enum64 *n1, *n2;
>         const struct btf_enum *m1, *m2;
>         __u16 vlen;
>         int i;
> @@ -3493,26 +3671,40 @@ static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)

they are so different that I think separate btf_equal_enum64() and
similar approaches everywhere makes sense. Yes, it's enum, but in
practice two very different kinds and should be handled differently

>                 return false;
>
>         vlen = btf_vlen(t1);
> -       m1 = btf_enum(t1);
> -       m2 = btf_enum(t2);
> -       for (i = 0; i < vlen; i++) {
> -               if (m1->name_off != m2->name_off || m1->val != m2->val)
> -                       return false;
> -               m1++;
> -               m2++;

[...]

>  enum btf_fwd_kind {
>         BTF_FWD_STRUCT = 0,
> @@ -454,6 +460,11 @@ static inline bool btf_is_enum(const struct btf_type *t)
>         return btf_kind(t) == BTF_KIND_ENUM;
>  }
>
> +static inline bool btf_is_enum64(const struct btf_type *t)
> +{
> +       return btf_kind(t) == BTF_KIND_ENUM64;

please also add #define BTF_KIND_ENUM64 19 to avoid user breakage if
they don't have very latest kernel UAPI header, same as we did for
TYPE_TAG and others

> +}
> +
>  static inline bool btf_is_fwd(const struct btf_type *t)
>  {
>         return btf_kind(t) == BTF_KIND_FWD;

[...]

> @@ -993,8 +996,11 @@ static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
>                                    const struct btf_type *t,
>                                    int lvl)
>  {
> -       const struct btf_enum *v = btf_enum(t);
> +       bool is_unsigned = btf_kflag(t);
> +       const struct btf_enum64 *v64;
> +       const struct btf_enum *v;
>         __u16 vlen = btf_vlen(t);
> +       const char *fmt_str;
>         const char *name;
>         size_t dup_cnt;
>         int i;
> @@ -1005,18 +1011,47 @@ static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
>
>         if (vlen) {
>                 btf_dump_printf(d, " {");
> -               for (i = 0; i < vlen; i++, v++) {
> -                       name = btf_name_of(d, v->name_off);
> -                       /* enumerators share namespace with typedef idents */
> -                       dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
> -                       if (dup_cnt > 1) {
> -                               btf_dump_printf(d, "\n%s%s___%zu = %u,",
> -                                               pfx(lvl + 1), name, dup_cnt,
> -                                               (__u32)v->val);
> -                       } else {
> -                               btf_dump_printf(d, "\n%s%s = %u,",
> -                                               pfx(lvl + 1), name,
> -                                               (__u32)v->val);
> +               if (btf_is_enum(t)) {
> +                       v = btf_enum(t);
> +                       for (i = 0; i < vlen; i++, v++) {
> +                               name = btf_name_of(d, v->name_off);
> +                               /* enumerators share namespace with typedef idents */
> +                               dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
> +                               if (dup_cnt > 1) {
> +                                       fmt_str = is_unsigned ? "\n%s%s___%zu = %u,"
> +                                                             : "\n%s%s___%zu = %d,";
> +                                       btf_dump_printf(d, fmt_str,
> +                                                       pfx(lvl + 1), name, dup_cnt,
> +                                                       v->val);
> +                               } else {
> +                                       fmt_str = is_unsigned ? "\n%s%s = %u,"
> +                                                             : "\n%s%s = %d,";
> +                                       btf_dump_printf(d, fmt_str,
> +                                                       pfx(lvl + 1), name,
> +                                                       v->val);
> +                               }
> +                       }
> +               } else {
> +                       v64 = btf_enum64(t);
> +                       for (i = 0; i < vlen; i++, v64++) {
> +                               __u64 val = btf_enum64_value(v64);
> +
> +                               name = btf_name_of(d, v64->name_off);
> +                               /* enumerators share namespace with typedef idents */
> +                               dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
> +                               if (dup_cnt > 1) {
> +                                       fmt_str = is_unsigned ? "\n%s%s___%zu = %lluULL,"
> +                                                             : "\n%s%s___%zu = %lldLL,";
> +                                       btf_dump_printf(d, fmt_str,
> +                                                       pfx(lvl + 1), name, dup_cnt,
> +                                                       val);
> +                               } else {
> +                                       fmt_str = is_unsigned ? "\n%s%s = %lluULL,"
> +                                                             : "\n%s%s = %lldLL,";
> +                                       btf_dump_printf(d, fmt_str,
> +                                                       pfx(lvl + 1), name,
> +                                                       val);
> +                               }
>                         }

yeah, let's just have btf_dump_emit_enum64_def(), there is very little
that can be reused, I think it will be cleaning to keep enum and
enum64 separate everywhere where we actually need to iterate
enumerators and do something about them

>                 }
>                 btf_dump_printf(d, "\n%s}", pfx(lvl));
> @@ -1183,6 +1218,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
>                 case BTF_KIND_UNION:
>                 case BTF_KIND_TYPEDEF:
>                 case BTF_KIND_FLOAT:

[...]

> -       btf_dump_type_values(d, "%d", value);
> +               btf_dump_type_values(d, is_unsigned ? "%u" : "%d", value);
> +       } else {
> +               for (i = 0, e64 = btf_enum64(t); i < btf_vlen(t); i++, e64++) {
> +                       if (value != btf_enum64_value(e64))
> +                               continue;
> +                       btf_dump_type_values(d, "%s", btf_name_of(d, e64->name_off));
> +                       return 0;
> +               }
> +
> +               btf_dump_type_values(d, is_unsigned ? "%lluULL" : "%lldLL", value);
> +       }

ditto, also beware of %lld/%llu use with __u64/__s64, it gives
compilation warnings without cast on some architectures

>         return 0;
>  }
>

[...]

> @@ -2717,6 +2720,17 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>                         /* replace TYPE_TAG with a CONST */
>                         t->name_off = 0;
>                         t->info = BTF_INFO_ENC(BTF_KIND_CONST, 0, 0);
> +               } else if (!has_enum64 && btf_is_enum(t)) {
> +                       /* clear the kflag */
> +                       t->info &= 0x7fffffff;

please use btf_type_info() helper (defined in libbpf_internal.h) or
just plain BTF_INFO_ENC() like all other cases around instead of
hard-coding magic masks

> +               } else if (!has_enum64 && btf_is_enum64(t)) {
> +                       /* replace ENUM64 with pointer->void's */
> +                       vlen = btf_vlen(t);
> +                       for (j = 0; j <= vlen; j++, t++) {
> +                               t->name_off = 0;
> +                               t->info = BTF_INFO_ENC(BTF_KIND_PTR, 0, 0);
> +                               t->type = 0;
> +                       }

I don't think we can replace each enumerator with a new kind, it
breaks type ID numbering. struct btf_member has matching layout, so we
can replace ENUM64 with UNION (easier to keep offsets as zeroes),
WDYT?

>                 }
>         }
>  }
> @@ -3563,6 +3577,12 @@ static enum kcfg_type find_kcfg_type(const struct btf *btf, int id,
>                 if (strcmp(name, "libbpf_tristate"))
>                         return KCFG_UNKNOWN;
>                 return KCFG_TRISTATE;
> +       case BTF_KIND_ENUM64:
> +               if (t->size != 8)
> +                       return KCFG_UNKNOWN;

I think I don't like this t->size == 8 more and more. At some we'll
decide it's ok and then we'll have to go and adjust everything again.
It requires pretty much zero effort to support from the very beginning
and makes tons of sense to allow that, let's allow it.

> +               if (strcmp(name, "libbpf_tristate"))
> +                       return KCFG_UNKNOWN;
> +               return KCFG_TRISTATE;
>         case BTF_KIND_ARRAY:
>                 if (btf_array(t)->nelems == 0)
>                         return KCFG_UNKNOWN;
> @@ -4746,6 +4766,17 @@ static int probe_kern_bpf_cookie(void)
>         return probe_fd(ret);
>  }
>
> +static int probe_kern_btf_enum64(void)
> +{
> +       static const char strs[] = "\0enum64";
> +       __u32 types[] = {
> +               BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
> +       };
> +
> +       return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types),
> +                                            strs, sizeof(strs)));
> +}
> +
>  enum kern_feature_result {
>         FEAT_UNKNOWN = 0,
>         FEAT_SUPPORTED = 1,
> @@ -4811,6 +4842,9 @@ static struct kern_feature_desc {
>         [FEAT_BPF_COOKIE] = {
>                 "BPF cookie support", probe_kern_bpf_cookie,
>         },
> +       [FEAT_BTF_ENUM64] = {
> +               "BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
> +       },
>  };
>
>  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
> @@ -5296,6 +5330,15 @@ void bpf_core_free_cands(struct bpf_core_cand_list *cands)
>         free(cands);
>  }
>
> +static bool btf_is_enum_enum64(const struct btf_type *t1,
> +                              const struct btf_type *t2) {
> +       if (btf_is_enum(t1) && btf_is_enum64(t2))
> +               return true;
> +       if (btf_is_enum(t2) && btf_is_enum64(t1))
> +               return true;
> +       return false;
> +}
> +

maybe simplify and rename to

static bool btf_are_enums(...) {
    return (btf_is_enum(t1) || btf_is_enum64(t1)) && (same for t2)?
}

>  int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>                        size_t local_essent_len,
>                        const struct btf *targ_btf,
> @@ -5315,8 +5358,10 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>         n = btf__type_cnt(targ_btf);
>         for (i = targ_start_id; i < n; i++) {
>                 t = btf__type_by_id(targ_btf, i);
> -               if (btf_kind(t) != btf_kind(local_t))
> -                       continue;
> +               if (btf_kind(t) != btf_kind(local_t)) {
> +                       if (!btf_is_enum_enum64(t, local_t))
> +                               continue;
> +               }

let's extract this into a helper and call it btf_kinds_are_compat() or
something along those lines?

>
>                 targ_name = btf__name_by_offset(targ_btf, t->name_off);
>                 if (str_is_empty(targ_name))
> @@ -5529,8 +5574,10 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
>         /* caller made sure that names match (ignoring flavor suffix) */
>         local_type = btf__type_by_id(local_btf, local_id);
>         targ_type = btf__type_by_id(targ_btf, targ_id);
> -       if (btf_kind(local_type) != btf_kind(targ_type))
> -               return 0;
> +       if (btf_kind(local_type) != btf_kind(targ_type)) {
> +               if (!btf_is_enum_enum64(local_type, targ_type))
> +                       return 0;
> +       }
>
>  recur:
>         depth--;
> @@ -5542,8 +5589,10 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
>         if (!local_type || !targ_type)
>                 return -EINVAL;
>
> -       if (btf_kind(local_type) != btf_kind(targ_type))
> -               return 0;
> +       if (btf_kind(local_type) != btf_kind(targ_type)) {
> +               if (!btf_is_enum_enum64(local_type, targ_type))
> +                       return 0;
> +       }

and reuse it in many places like here and above

>
>         switch (btf_kind(local_type)) {
>         case BTF_KIND_UNKN:
> @@ -5551,6 +5600,7 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
>         case BTF_KIND_UNION:
>         case BTF_KIND_ENUM:
>         case BTF_KIND_FWD:
> +       case BTF_KIND_ENUM64:
>                 return 1;
>         case BTF_KIND_INT:
>                 /* just reject deprecated bitfield-like integers; all other
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b5bc84039407..acde13bd48c8 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -448,6 +448,10 @@ LIBBPF_0.8.0 {
>                 bpf_object__open_subskeleton;
>                 bpf_program__attach_kprobe_multi_opts;
>                 bpf_program__attach_usdt;
> +               btf__add_enum32;
> +               btf__add_enum32_value;
> +               btf__add_enum64;
> +               btf__add_enum64_value;
>                 libbpf_register_prog_handler;
>                 libbpf_unregister_prog_handler;
>  } LIBBPF_0.7.0;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 4abdbe2fea9d..10c16acfa8ae 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -351,6 +351,8 @@ enum kern_feature_id {
>         FEAT_MEMCG_ACCOUNT,
>         /* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
>         FEAT_BPF_COOKIE,
> +       /* BTF_KIND_ENUM64 support and BTF_KIND_ENUM kflag support */
> +       FEAT_BTF_ENUM64,
>         __FEAT_CNT,
>  };
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 9aa016fb55aa..1e1ef3302921 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -1343,6 +1343,7 @@ static bool glob_sym_btf_matches(const char *sym_name, bool exact,
>         case BTF_KIND_FWD:
>         case BTF_KIND_FUNC:
>         case BTF_KIND_VAR:
> +       case BTF_KIND_ENUM64:
>                 n1 = btf__str_by_offset(btf1, t1->name_off);
>                 n2 = btf__str_by_offset(btf2, t2->name_off);
>                 if (strcmp(n1, n2) != 0) {
> @@ -1358,6 +1359,7 @@ static bool glob_sym_btf_matches(const char *sym_name, bool exact,
>         switch (btf_kind(t1)) {
>         case BTF_KIND_UNKN: /* void */
>         case BTF_KIND_FWD:
> +       case BTF_KIND_ENUM64:

this should be lower, along with BTF_KIND_ENUM (btw, maybe keep it
next to BTF_KIND_ENUM64 in switches like this, e.g. in the one right
above in the patch)

>                 return true;
>         case BTF_KIND_INT:
>         case BTF_KIND_FLOAT:
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index f25ffd03c3b1..1e751400427b 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -231,11 +231,15 @@ int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
>         spec->len++;
>
>         if (core_relo_is_enumval_based(relo->kind)) {
> -               if (!btf_is_enum(t) || spec->raw_len > 1 || access_idx >= btf_vlen(t))
> +               if (!(btf_is_enum(t) || btf_is_enum64(t)) ||
> +                   spec->raw_len > 1 || access_idx >= btf_vlen(t))
>                         return -EINVAL;
>
>                 /* record enumerator name in a first accessor */
> -               acc->name = btf__name_by_offset(btf, btf_enum(t)[access_idx].name_off);
> +               if (btf_is_enum(t))
> +                       acc->name = btf__name_by_offset(btf, btf_enum(t)[access_idx].name_off);
> +               else
> +                       acc->name = btf__name_by_offset(btf, btf_enum64(t)[access_idx].name_off);

mild nit: it seems like extracting name_off into a variable (based on
btf_is_enum(t)) would be a bit cleaner, then just one
btf__name_by_offset() call with that name_off?

>                 return 0;
>         }
>
> @@ -340,15 +344,19 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
>
>         if (btf_is_composite(local_type) && btf_is_composite(targ_type))
>                 return 1;
> -       if (btf_kind(local_type) != btf_kind(targ_type))
> -               return 0;
> +       if (btf_kind(local_type) != btf_kind(targ_type)) {
> +               if (btf_is_enum(local_type) && btf_is_enum64(targ_type)) ;
> +               else if (btf_is_enum64(local_type) && btf_is_enum(targ_type)) ;
> +               else return 0;
> +       }

use proposed btf_kinds_are_compat() here?

>
>         switch (btf_kind(local_type)) {
>         case BTF_KIND_PTR:
>         case BTF_KIND_FLOAT:
>                 return 1;
>         case BTF_KIND_FWD:
> -       case BTF_KIND_ENUM: {
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64: {
>                 const char *local_name, *targ_name;
>                 size_t local_len, targ_len;
>
> @@ -494,29 +502,48 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
>
>         if (core_relo_is_enumval_based(local_spec->relo_kind)) {
>                 size_t local_essent_len, targ_essent_len;
> +               const struct btf_enum64 *e64;
>                 const struct btf_enum *e;
>                 const char *targ_name;
>
>                 /* has to resolve to an enum */
>                 targ_type = skip_mods_and_typedefs(targ_spec->btf, targ_id, &targ_id);
> -               if (!btf_is_enum(targ_type))
> +               if (!btf_is_enum(targ_type) && !btf_is_enum64(targ_type))
>                         return 0;
>
>                 local_essent_len = bpf_core_essential_name_len(local_acc->name);
>
> -               for (i = 0, e = btf_enum(targ_type); i < btf_vlen(targ_type); i++, e++) {
> -                       targ_name = btf__name_by_offset(targ_spec->btf, e->name_off);
> -                       targ_essent_len = bpf_core_essential_name_len(targ_name);
> -                       if (targ_essent_len != local_essent_len)
> -                               continue;
> -                       if (strncmp(local_acc->name, targ_name, local_essent_len) == 0) {


so idea here is to find enumerator with matching name and record its
name and position, let's extract that part of the logic into a helper
and keep the targ_acc/targ_spec initialization in one piece. It will
be easier to follow the intent and less opportunity to get out of
sync.

> -                               targ_acc->type_id = targ_id;
> -                               targ_acc->idx = i;
> -                               targ_acc->name = targ_name;
> -                               targ_spec->len++;
> -                               targ_spec->raw_spec[targ_spec->raw_len] = targ_acc->idx;
> -                               targ_spec->raw_len++;
> -                               return 1;
> +               if (btf_is_enum(targ_type)) {
> +                       for (i = 0, e = btf_enum(targ_type); i < btf_vlen(targ_type); i++, e++) {
> +                               targ_name = btf__name_by_offset(targ_spec->btf, e->name_off);
> +                               targ_essent_len = bpf_core_essential_name_len(targ_name);
> +                               if (targ_essent_len != local_essent_len)
> +                                       continue;
> +                               if (strncmp(local_acc->name, targ_name, local_essent_len) == 0) {
> +                                       targ_acc->type_id = targ_id;
> +                                       targ_acc->idx = i;
> +                                       targ_acc->name = targ_name;
> +                                       targ_spec->len++;
> +                                       targ_spec->raw_spec[targ_spec->raw_len] = targ_acc->idx;
> +                                       targ_spec->raw_len++;
> +                                       return 1;
> +                               }
> +                       }
> +               } else {
> +                       for (i = 0, e64 = btf_enum64(targ_type); i < btf_vlen(targ_type); i++, e64++) {
> +                               targ_name = btf__name_by_offset(targ_spec->btf, e64->name_off);
> +                               targ_essent_len = bpf_core_essential_name_len(targ_name);
> +                               if (targ_essent_len != local_essent_len)
> +                                       continue;
> +                               if (strncmp(local_acc->name, targ_name, local_essent_len) == 0) {
> +                                       targ_acc->type_id = targ_id;
> +                                       targ_acc->idx = i;
> +                                       targ_acc->name = targ_name;
> +                                       targ_spec->len++;
> +                                       targ_spec->raw_spec[targ_spec->raw_len] = targ_acc->idx;
> +                                       targ_spec->raw_len++;
> +                                       return 1;
> +                               }
>                         }
>                 }
>                 return 0;
> @@ -681,7 +708,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
>                 break;
>         case BPF_CORE_FIELD_SIGNED:
>                 /* enums will be assumed unsigned */
> -               *val = btf_is_enum(mt) ||
> +               *val = btf_is_enum(mt) || btf_is_enum64(mt) ||
>                        (btf_int_encoding(mt) & BTF_INT_SIGNED);
>                 if (validate)
>                         *validate = true; /* signedness is never ambiguous */
> @@ -753,6 +780,7 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>                                       const struct bpf_core_spec *spec,
>                                       __u64 *val)
>  {
> +       const struct btf_enum64 *e64;
>         const struct btf_type *t;
>         const struct btf_enum *e;
>
> @@ -764,8 +792,13 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>                 if (!spec)
>                         return -EUCLEAN; /* request instruction poisoning */
>                 t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
> -               e = btf_enum(t) + spec->spec[0].idx;
> -               *val = e->val;
> +               if (btf_is_enum(t)) {
> +                       e = btf_enum(t) + spec->spec[0].idx;
> +                       *val = e->val;
> +               } else {
> +                       e64 = btf_enum64(t) + spec->spec[0].idx;
> +                       *val = btf_enum64_value(e64);
> +               }

I think with sign bit we now have further complication: for 32-bit
enums we need to sign extend 32-bit values to s64 and then cast as
u64, no? Seems like a helper to abstract that is good to have here.
Otherwise relocating enum ABC { D = -1 } will produce invalid ldimm64
instruction, right?

Also keep in mind that you can use btf_enum()/btf_enum64() as an
array, so above you can write just as

*val = btf_is_enum(t)
    ? btf_enum(t)[spec->spec[0].idx]
    : btf_enum64(t)[spec->spec[0].idx];

But we need sign check and extension, so better to have a separate helper.

>                 break;
>         default:
>                 return -EOPNOTSUPP;
> @@ -1034,7 +1067,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>                 }
>
>                 insn[0].imm = new_val;
> -               insn[1].imm = 0; /* currently only 32-bit values are supported */
> +               insn[1].imm = new_val >> 32;

for 32-bit instructions (ALU/ALU32, etc) we need to make sure that
new_val fits in 32 bits. And we need to be careful about
signed/unsigned, because for signed case all-zero or all-one upper 32
bits are ok (sign extension). Can we know the expected signed/unsigned
operation from bpf_insn itself? We should be, right?

>                 pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
>                          prog_name, relo_idx, insn_idx,
>                          (unsigned long long)imm, new_val);
> @@ -1056,6 +1089,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>   */
>  int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
>  {
> +       const struct btf_enum64 *e64;
>         const struct btf_type *t;
>         const struct btf_enum *e;
>         const char *s;
> @@ -1086,10 +1120,15 @@ int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *s
>
>         if (core_relo_is_enumval_based(spec->relo_kind)) {
>                 t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
> -               e = btf_enum(t) + spec->raw_spec[0];
> -               s = btf__name_by_offset(spec->btf, e->name_off);
> -
> -               append_buf("::%s = %u", s, e->val);
> +               if (btf_is_enum(t)) {
> +                       e = btf_enum(t) + spec->raw_spec[0];
> +                       s = btf__name_by_offset(spec->btf, e->name_off);
> +                       append_buf("::%s = %u", s, e->val);
> +               } else {
> +                       e64 = btf_enum64(t) + spec->raw_spec[0];
> +                       s = btf__name_by_offset(spec->btf, e64->name_off);
> +                       append_buf("::%s = %llu", s, btf_enum64_value(e64));

%llu problem here again

> +               }
>                 return len;
>         }
>

[...]
