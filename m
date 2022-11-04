Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C361A21B
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 21:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiKDUY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 16:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKDUY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 16:24:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53E71F2D1
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 13:24:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ud5so16194401ejc.4
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Et0Nw0cWynlfqrl06YLRb4VF1SNIzXH6iBOtzRTrvmQ=;
        b=mLLeP53qIZmtAZiyC72/Be8zyWRp11hFsdhXP/3Fifv59wlJHytUfuuJkv6bgBXcq6
         bn+MSof5nTDiXzZaXbk/g9Hj9GQoqyMRW56kirRp+lQFPN3WpKQ1Stju4B9KQhYp02N9
         +a9NpeaukJefwm6JqHqkwQWXQuswzLm4xJsGxvzMM0fDksdS8e/R+Nj3KM84GhtWo0uI
         2BL52Jd5Hu1xM0Z17X5AnlwcIblMoiZ6B/TTyHkPOMj9Ez/jJzXu4x5DearkNp3zv91r
         OwlrHvk76UpcibZhSBvMA4o0r2bdKEx5CR9H1VwVnfmv2yFnlgWI536C4A0UFgUm3CTw
         2y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Et0Nw0cWynlfqrl06YLRb4VF1SNIzXH6iBOtzRTrvmQ=;
        b=DRMM5cUGvXbJ5txur8LXIipska0B37BQz+KOkQqYo9DrpKQ9ehN/BecZBhxdWV4fGQ
         aBMhescaB5PB9biO9AHfGUqrbxE1XCnxwIcQ2v936lIbxW+ooVL0KW7jrz4FJwC3o0ua
         N/WU2B4jTtx7sWDRhI8cYrLPS7BswJCtE1lTEtwxpjnkoJM0UnOh9x8ODHhYAtAWmiuK
         U4WtIqD9cXD7ETA7Qw3L1/+uXc+rbfhGZwbjBQAJKe0/bnMuVs5nDSfYhz1VO9UUHXJZ
         XBhx0+YdECRipp/sJsArg3ZI7Ih12P7TlP3kYXZTvmLyVR2K+hodMC/PUyyV5JDdRBw5
         z9sA==
X-Gm-Message-State: ACrzQf1J6D/mSNawcXe4kNqk3/4i1jQUP3QXpI18SnCOcQBnm02vUNqH
        92JYiHWNrTiwiZqUD/+jMH2XBUrce9Jekj+jU4urLDaG
X-Google-Smtp-Source: AMsMyM5LnqqctAtHlcSutxOg1wlIY6ivIjIJ8FwsCaPAusqS/ZS/Zi1dLtseI6OczdfCPEr+Qpp6BWEvW4hB0D1p75Y=
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id
 sc36-20020a1709078a2400b00795bb7d643bmr36975227ejc.115.1667593466263; Fri, 04
 Nov 2022 13:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221103033430.2611623-1-eddyz87@gmail.com> <20221103033430.2611623-4-eddyz87@gmail.com>
 <CAEf4Bzax+kH65_s7sDmCO_gn+W4WqaARimLkn_-c8RAgXxY0KA@mail.gmail.com>
In-Reply-To: <CAEf4Bzax+kH65_s7sDmCO_gn+W4WqaARimLkn_-c8RAgXxY0KA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 13:24:14 -0700
Message-ID: <CAEf4Bzbu_jEFaioyQNFjiDkYXpgsbQfZ7aY9zYxi699ZFm5EcA@mail.gmail.com>
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

On Fri, Nov 4, 2022 at 12:02 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 2, 2022 at 8:35 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > Resolve forward declarations that don't take part in type graphs
> > comparisons if declaration name is unambiguous. Example:
> >
> > CU #1:
> >
> > struct foo;              // standalone forward declaration
> > struct foo *some_global;
> >
> > CU #2:
> >
> > struct foo { int x; };
> > struct foo *another_global;
> >
> > The `struct foo` from CU #1 is not a part of any definition that is
> > compared against another definition while `btf_dedup_struct_types`
> > processes structural types. The the BTF after `btf_dedup_struct_types`
> > the BTF looks as follows:
> >
> > [1] STRUCT 'foo' size=4 vlen=1 ...
> > [2] INT 'int' size=4 ...
> > [3] PTR '(anon)' type_id=1
> > [4] FWD 'foo' fwd_kind=struct
> > [5] PTR '(anon)' type_id=4
> >
> > This commit adds a new pass `btf_dedup_resolve_fwds`, that maps such
> > forward declarations to structs or unions with identical name in case
> > if the name is not ambiguous.
> >
> > The pass is positioned before `btf_dedup_ref_types` so that types
> > [3] and [5] could be merged as a same type after [1] and [4] are merged.
> > The final result for the example above looks as follows:
> >
> > [1] STRUCT 'foo' size=4 vlen=1
> >         'x' type_id=2 bits_offset=0
> > [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > [3] PTR '(anon)' type_id=1
> >
> > For defconfig kernel with BTF enabled this removes 63 forward
> > declarations. Examples of removed declarations: `pt_regs`, `in6_addr`.
> > The running time of `btf__dedup` function is increased by about 3%.
> >
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  tools/lib/bpf/btf.c | 143 ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 139 insertions(+), 4 deletions(-)
> >
>
> LGTM, small nit about hashmap__new initialization
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>
> > +}
> > +
> > +static int btf_dedup_resolve_fwd(struct btf_dedup *d, struct hashmap *names_map, __u32 type_id)
> > +{
> > +       struct btf_type *t = btf_type_by_id(d->btf, type_id);
> > +       enum btf_fwd_kind fwd_kind = btf_kflag(t);
>
> this is a bit subtle, but probably won't ever break as enum
> btf_fwd_kind is part of libbpf UAPI
>
> > +       __u16 cand_kind, kind = btf_kind(t);
> > +       struct btf_type *cand_t;
> > +       uintptr_t cand_id;
> > +
> > +       if (kind != BTF_KIND_FWD)
> > +               return 0;
> > +
> > +       /* Skip if this FWD already has a mapping */
> > +       if (type_id != d->map[type_id])
> > +               return 0;
> > +
> > +       if (!hashmap__find(names_map, t->name_off, &cand_id))
> > +               return 0;
> > +
> > +       /* Zero is a special value indicating that name is not unique */
> > +       if (!cand_id)
> > +               return 0;
> > +
> > +       cand_t = btf_type_by_id(d->btf, cand_id);
> > +       cand_kind = btf_kind(cand_t);
> > +       if ((cand_kind == BTF_KIND_STRUCT && fwd_kind != BTF_FWD_STRUCT) ||
> > +           (cand_kind == BTF_KIND_UNION && fwd_kind != BTF_FWD_UNION))
> > +               return 0;
> > +
> > +       d->map[type_id] = cand_id;
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Resolve unambiguous forward declarations.
> > + *
> > + * The lion's share of all FWD declarations is resolved during
> > + * `btf_dedup_struct_types` phase when different type graphs are
> > + * compared against each other. However, if in some compilation unit a
> > + * FWD declaration is not a part of a type graph compared against
> > + * another type graph that declaration's canonical type would not be
> > + * changed. Example:
> > + *
> > + * CU #1:
> > + *
> > + * struct foo;
> > + * struct foo *some_global;
> > + *
> > + * CU #2:
> > + *
> > + * struct foo { int u; };
> > + * struct foo *another_global;
> > + *
> > + * After `btf_dedup_struct_types` the BTF looks as follows:
> > + *
> > + * [1] STRUCT 'foo' size=4 vlen=1 ...
> > + * [2] INT 'int' size=4 ...
> > + * [3] PTR '(anon)' type_id=1
> > + * [4] FWD 'foo' fwd_kind=struct
> > + * [5] PTR '(anon)' type_id=4
> > + *
> > + * This pass assumes that such FWD declarations should be mapped to
> > + * structs or unions with identical name in case if the name is not
> > + * ambiguous.
> > + */
> > +static int btf_dedup_resolve_fwds(struct btf_dedup *d)
> > +{
> > +       int i, err;
> > +       struct hashmap *names_map =
> > +               hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
>
> if variable declaration and initialization doesn't even fit in a
> single line, that's a signal that they should better be split.
>
> In general we also try to avoid doing "complex" initialization at
> declaration time. So please split.
>
> > +
> > +       if (!names_map)

also:

if (IS_ERR(names_map))
    return PTR_ERR(names_map);

> > +               return -ENOMEM;
> > +
>
> [...]
