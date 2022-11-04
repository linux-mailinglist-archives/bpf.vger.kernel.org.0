Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40C61A07C
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 20:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKDTCj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiKDTCi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 15:02:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C60FAEE
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 12:02:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f7so8962247edc.6
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ahy4Buzb+0k11FGgiZlp8vfLSvkdiZd3aX//Zeul/I=;
        b=fnZWqKGZNotD3akKjEWlLelrDq+IOVx4z7Vb0pMa3/iermvENRUOxE8h+kXbAe7eW7
         Z7SMWBhwP83TnJlS8USQvpfo7Mn8SKsJeEq0IzhbWPOdaGhJn3DeSFVjQdxoez79z+38
         PeJ3CPpxqa6XOrJi+OgSWD+hc5ErCvIQuFynFgUbhzOi9ax6KaD8d1mok4lkKCglWEF+
         rQmQq3bciCaDyQOmLtxByzJODcFOCtaHbAgBrH6ggMGv7ByGAAK7V6JF6Yww0SL27Sl4
         lErk689i09fW+Zhoa97GwAdbd36f7icF5bQIvNjQXsLjBCxYBmqUXRPcGE/GSpgObPKR
         haGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ahy4Buzb+0k11FGgiZlp8vfLSvkdiZd3aX//Zeul/I=;
        b=IPirTA0XnS4Jhkjg6xxpn65rx62vFDS+zcWLVU5QBYqnd+j/jMeXZKl0QV2HVAdHOo
         olxpt7i3SbEk0JEILAvR0hBzAYfoEgsaMMr/fLynVmDSoU1R2Pe8rzoWNAw8KpAdy2K/
         FWVMYQ/d2h5HkItFQLyS7rqVgWJWufRvf3DhBGCJ32lz0RiYH8QiajAyGy/ykns1Jfo0
         HpaTHTHV4JpO4bT1PbDDuwU640AP+BRrVRoAXjgicdRG1Bl6Wvy01RP9v+f0LX2X4p8D
         FpFaUO6mzT1WN4jjhItMfZlE9iO7FOVj4Z15Age7YwIaoIusuSRp2qKT+3uknSiVpwak
         Vn+w==
X-Gm-Message-State: ACrzQf1bngiE7bNK6hbWc/IFUubDBlFXiCRiDDcqafE66IMOsFmzhp3s
        TQ3qjTqLHDcqY5xbvs7yw4KNGqTAVb8CwKBG+r8=
X-Google-Smtp-Source: AMsMyM7KKx8g7Djh0ZB3C1/bBLa4lj7NO6qviwWjdxzK10tlqzFu0Kb0ZOsIKsxSboTnVfD4VomA9GbHSjxqWMnt56I=
X-Received: by 2002:a05:6402:3641:b0:45c:4231:ddcc with SMTP id
 em1-20020a056402364100b0045c4231ddccmr37941018edb.224.1667588555748; Fri, 04
 Nov 2022 12:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221103033430.2611623-1-eddyz87@gmail.com> <20221103033430.2611623-4-eddyz87@gmail.com>
In-Reply-To: <20221103033430.2611623-4-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 12:02:24 -0700
Message-ID: <CAEf4Bzax+kH65_s7sDmCO_gn+W4WqaARimLkn_-c8RAgXxY0KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: Resolve unambigous forward declarations
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 2, 2022 at 8:35 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Resolve forward declarations that don't take part in type graphs
> comparisons if declaration name is unambiguous. Example:
>
> CU #1:
>
> struct foo;              // standalone forward declaration
> struct foo *some_global;
>
> CU #2:
>
> struct foo { int x; };
> struct foo *another_global;
>
> The `struct foo` from CU #1 is not a part of any definition that is
> compared against another definition while `btf_dedup_struct_types`
> processes structural types. The the BTF after `btf_dedup_struct_types`
> the BTF looks as follows:
>
> [1] STRUCT 'foo' size=4 vlen=1 ...
> [2] INT 'int' size=4 ...
> [3] PTR '(anon)' type_id=1
> [4] FWD 'foo' fwd_kind=struct
> [5] PTR '(anon)' type_id=4
>
> This commit adds a new pass `btf_dedup_resolve_fwds`, that maps such
> forward declarations to structs or unions with identical name in case
> if the name is not ambiguous.
>
> The pass is positioned before `btf_dedup_ref_types` so that types
> [3] and [5] could be merged as a same type after [1] and [4] are merged.
> The final result for the example above looks as follows:
>
> [1] STRUCT 'foo' size=4 vlen=1
>         'x' type_id=2 bits_offset=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] PTR '(anon)' type_id=1
>
> For defconfig kernel with BTF enabled this removes 63 forward
> declarations. Examples of removed declarations: `pt_regs`, `in6_addr`.
> The running time of `btf__dedup` function is increased by about 3%.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 143 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 139 insertions(+), 4 deletions(-)
>

LGTM, small nit about hashmap__new initialization

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> +}
> +
> +static int btf_dedup_resolve_fwd(struct btf_dedup *d, struct hashmap *names_map, __u32 type_id)
> +{
> +       struct btf_type *t = btf_type_by_id(d->btf, type_id);
> +       enum btf_fwd_kind fwd_kind = btf_kflag(t);

this is a bit subtle, but probably won't ever break as enum
btf_fwd_kind is part of libbpf UAPI

> +       __u16 cand_kind, kind = btf_kind(t);
> +       struct btf_type *cand_t;
> +       uintptr_t cand_id;
> +
> +       if (kind != BTF_KIND_FWD)
> +               return 0;
> +
> +       /* Skip if this FWD already has a mapping */
> +       if (type_id != d->map[type_id])
> +               return 0;
> +
> +       if (!hashmap__find(names_map, t->name_off, &cand_id))
> +               return 0;
> +
> +       /* Zero is a special value indicating that name is not unique */
> +       if (!cand_id)
> +               return 0;
> +
> +       cand_t = btf_type_by_id(d->btf, cand_id);
> +       cand_kind = btf_kind(cand_t);
> +       if ((cand_kind == BTF_KIND_STRUCT && fwd_kind != BTF_FWD_STRUCT) ||
> +           (cand_kind == BTF_KIND_UNION && fwd_kind != BTF_FWD_UNION))
> +               return 0;
> +
> +       d->map[type_id] = cand_id;
> +
> +       return 0;
> +}
> +
> +/*
> + * Resolve unambiguous forward declarations.
> + *
> + * The lion's share of all FWD declarations is resolved during
> + * `btf_dedup_struct_types` phase when different type graphs are
> + * compared against each other. However, if in some compilation unit a
> + * FWD declaration is not a part of a type graph compared against
> + * another type graph that declaration's canonical type would not be
> + * changed. Example:
> + *
> + * CU #1:
> + *
> + * struct foo;
> + * struct foo *some_global;
> + *
> + * CU #2:
> + *
> + * struct foo { int u; };
> + * struct foo *another_global;
> + *
> + * After `btf_dedup_struct_types` the BTF looks as follows:
> + *
> + * [1] STRUCT 'foo' size=4 vlen=1 ...
> + * [2] INT 'int' size=4 ...
> + * [3] PTR '(anon)' type_id=1
> + * [4] FWD 'foo' fwd_kind=struct
> + * [5] PTR '(anon)' type_id=4
> + *
> + * This pass assumes that such FWD declarations should be mapped to
> + * structs or unions with identical name in case if the name is not
> + * ambiguous.
> + */
> +static int btf_dedup_resolve_fwds(struct btf_dedup *d)
> +{
> +       int i, err;
> +       struct hashmap *names_map =
> +               hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);

if variable declaration and initialization doesn't even fit in a
single line, that's a signal that they should better be split.

In general we also try to avoid doing "complex" initialization at
declaration time. So please split.

> +
> +       if (!names_map)
> +               return -ENOMEM;
> +

[...]
