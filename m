Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0A6169A5
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 17:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiKBQtH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKBQsn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 12:48:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935111806
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 09:46:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r12so29207918lfp.1
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NxiXnptRNSgJBRC2YV+NJGJqe8Dzf657WIXA8ovPCo0=;
        b=gvhG+xqduqDRMTxNjX904Io+mS76raMhTlmDXRQKd60BnzEH3er0TMvNVlIE7V4uUD
         x/INsqnxRD3spU/HMUuOdc8LfD/NTRWNXiOGYU7j3J1QHB/AfCnNjpZYj3mnjQAkWwKm
         XpwqLq/fbi3kLDUqZAh6QeP6NZhYhXngsc3QS9HIgSxgtAK1WWyyLxh0n4Ug3cvD57ZT
         4O5t2FGvLd8vaGHssm3MmOVP4B62IW6zmffEH5GuC78pYUGll6md+K8+v/H2eo+uI4Rw
         tHb08Q0aWkCfwigdGnnncTSt5sBMOBSTR2HG04YrbFMoAfVZ5YGYXCvLRFwYGvmI9tJr
         ZPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxiXnptRNSgJBRC2YV+NJGJqe8Dzf657WIXA8ovPCo0=;
        b=ohgLrc2l4H/EXL63gfBZsmbuEAabrbXst6KlcuOKeqVcHuM2kEm1a3LXHw1Uw6Zid8
         ZXNAFE2m84bSk/looQeuHOD0zWtokmoxaBnvjAPEdMy1PiUvZ8eRJGlYftmj5+vD2HAs
         UtHXcoxfXLcTZXkKuyaVCErCRISQ3UBC7NWVZkYp0CHTTGHWt+5J80ZDpGbKs8LHsSTJ
         lN+3ShK/YeNcpMJ22eVNGfI+bBMK5w9fC57xIGHLQ8hjrTe3WQt73+vfesnJXVUS9MmE
         BriFb0jzPsEuX1mk813MCm5545BR4Lz5bC4PiyUyQ7bks761/8XLqso8xCRNAoEm4pFS
         qC7g==
X-Gm-Message-State: ACrzQf0adWlPvhbqVMmOh38X1QVzvFytcYpiXWADHKjRQATMOJnKI+bJ
        4CRgrVMBmb7gUc0I06ORbL8=
X-Google-Smtp-Source: AMsMyM4lXg+Ob5GogOjjPCy0/r2oPToQq75sWheQ/kVicpon/3n4jYg1qp75WqbPfRhnu2LRXrERxQ==
X-Received: by 2002:a19:7613:0:b0:4a4:2243:9b3e with SMTP id c19-20020a197613000000b004a422439b3emr10249401lff.158.1667407576307;
        Wed, 02 Nov 2022 09:46:16 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f8-20020a19dc48000000b004947a12232bsm2061795lfj.275.2022.11.02.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:46:15 -0700 (PDT)
Message-ID: <9f39b58abd083abb156a3494bfbaa7675e67cac2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] libbpf: Resolve unambigous forward
 declarations
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com
Date:   Wed, 02 Nov 2022 18:46:14 +0200
In-Reply-To: <a3d3aa04-0247-e073-ebde-6c8f3d8abdf0@oracle.com>
References: <20221102110905.2433622-1-eddyz87@gmail.com>
         <20221102110905.2433622-4-eddyz87@gmail.com>
         <a3d3aa04-0247-e073-ebde-6c8f3d8abdf0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-11-02 at 16:36 +0000, Alan Maguire wrote:
> On 02/11/2022 11:09, Eduard Zingerman wrote:
> > Resolve forward declarations that don't take part in type graphs
> > comparisons if declaration name is unambiguous. Example:
> >=20
> > CU #1:
> >=20
> > struct foo;              // standalone forward declaration
> > struct foo *some_global;
> >=20
> > CU #2:
> >=20
> > struct foo { int x; };
> > struct foo *another_global;
> >=20
> > The `struct foo` from CU #1 is not a part of any definition that is
> > compared against another definition while `btf_dedup_struct_types`
> > processes structural types. The the BTF after `btf_dedup_struct_types`
> > the BTF looks as follows:
> >=20
> > [1] STRUCT 'foo' size=3D4 vlen=3D1 ...
> > [2] INT 'int' size=3D4 ...
> > [3] PTR '(anon)' type_id=3D1
> > [4] FWD 'foo' fwd_kind=3Dstruct
> > [5] PTR '(anon)' type_id=3D4
> >=20
> > This commit adds a new pass `btf_dedup_resolve_fwds`, that maps such
> > forward declarations to structs or unions with identical name in case
> > if the name is not ambiguous.
> >=20
> > The pass is positioned before `btf_dedup_ref_types` so that types
> > [3] and [5] could be merged as a same type after [1] and [4] are merged=
.
> > The final result for the example above looks as follows:
> >=20
> > [1] STRUCT 'foo' size=3D4 vlen=3D1
> > 	'x' type_id=3D2 bits_offset=3D0
> > [2] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> > [3] PTR '(anon)' type_id=3D1
> >=20
> > For defconfig kernel with BTF enabled this removes 63 forward
> > declarations. Examples of removed declarations: `pt_regs`, `in6_addr`.
> > The running time of `btf__dedup` function is increased by about 3%.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> A few small things below, but looks great!

Hi Alan,

thanks for the review, I'll apply your suggestions in v2.
Will wait a bit in case anyone else would want to comment.

Thanks,
Eduard

>=20
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>=20
> > ---
> >  tools/lib/bpf/btf.c | 140 ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 136 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 04db202aac3d..d2f994d30af7 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -2881,6 +2881,7 @@ static int btf_dedup_strings(struct btf_dedup *d)=
;
> >  static int btf_dedup_prim_types(struct btf_dedup *d);
> >  static int btf_dedup_struct_types(struct btf_dedup *d);
> >  static int btf_dedup_ref_types(struct btf_dedup *d);
> > +static int btf_dedup_resolve_fwds(struct btf_dedup *d);
> >  static int btf_dedup_compact_types(struct btf_dedup *d);
> >  static int btf_dedup_remap_types(struct btf_dedup *d);
> > =20
> > @@ -2988,15 +2989,16 @@ static int btf_dedup_remap_types(struct btf_ded=
up *d);
> >   * Algorithm summary
> >   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   *
> > - * Algorithm completes its work in 6 separate passes:
> > + * Algorithm completes its work in 7 separate passes:
> >   *
> >   * 1. Strings deduplication.
> >   * 2. Primitive types deduplication (int, enum, fwd).
> >   * 3. Struct/union types deduplication.
> > - * 4. Reference types deduplication (pointers, typedefs, arrays, funcs=
, func
> > + * 4. Resolve unambiguous forward declarations.
> > + * 5. Reference types deduplication (pointers, typedefs, arrays, funcs=
, func
> >   *    protos, and const/volatile/restrict modifiers).
> > - * 5. Types compaction.
> > - * 6. Types remapping.
> > + * 6. Types compaction.
> > + * 7. Types remapping.
> >   *
> >   * Algorithm determines canonical type descriptor, which is a single
> >   * representative type for each truly unique type. This canonical type=
 is the
> > @@ -3060,6 +3062,11 @@ int btf__dedup(struct btf *btf, const struct btf=
_dedup_opts *opts)
> >  		pr_debug("btf_dedup_struct_types failed:%d\n", err);
> >  		goto done;
> >  	}
> > +	err =3D btf_dedup_resolve_fwds(d);
> > +	if (err < 0) {
> > +		pr_debug("btf_dedup_resolve_fwds failed:%d\n", err);
> > +		goto done;
> > +	}
> >  	err =3D btf_dedup_ref_types(d);
> >  	if (err < 0) {
> >  		pr_debug("btf_dedup_ref_types failed:%d\n", err);
> > @@ -4526,6 +4533,131 @@ static int btf_dedup_ref_types(struct btf_dedup=
 *d)
> >  	return 0;
> >  }
> > =20
> > +/*
> > + * Collect a map from type names to type ids for all canonical structs
> > + * and unions. If the same name is shared by several canonical types
> > + * use a special value 0 to indicate this fact.
> > + */
> > +static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, struct=
 hashmap *names_map)
> > +{
> > +	__u32 nr_types =3D btf__type_cnt(d->btf);
> > +	struct btf_type *t;
> > +	__u32 type_id;
> > +	__u16 kind;
> > +	int err;
> > +
> > +	/*
> > +	 * Iterate over base and split module ids in order to get all
> > +	 * available structs in the map.
> > +	 */
> > +	for (type_id =3D 1; type_id < nr_types; ++type_id) {
> > +		t =3D btf_type_by_id(d->btf, type_id);
> > +		kind =3D btf_kind(t);
> > +
> > +		if (kind !=3D BTF_KIND_STRUCT && kind !=3D BTF_KIND_UNION)
> > +			continue;
> > +
> > +		/* Skip non-canonical types */
> > +		if (type_id !=3D d->map[type_id])
> > +			continue;
> > +
> > +		err =3D hashmap__add(names_map, t->name_off, type_id);
> > +		if (err =3D=3D -EEXIST)
> > +			err =3D hashmap__set(names_map, t->name_off, 0, NULL, NULL);
> > +> +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int btf_dedup_resolve_fwd(struct btf_dedup *d, struct hashmap *=
names_map, __u32 type_id)
> > +{
> > +	struct btf_type *t =3D btf_type_by_id(d->btf, type_id);
> > +	enum btf_fwd_kind fwd_kind =3D btf_kflag(t);
> > +	__u16 cand_kind, kind =3D btf_kind(t);
> > +	struct btf_type *cand_t;
> > +	uintptr_t cand_id =3D 0;
> > +
> > +	if (kind !=3D BTF_KIND_FWD)
> > +		return 0;
> > +
> > +	/* Skip if this FWD already has a mapping */
> > +	if (type_id !=3D d->map[type_id])
> > +		return 0;
> > +
> > +	hashmap__find(names_map, t->name_off, &cand_id);
>=20
> would it be safer to do=20
>=20
> 	if (!hashmap__find(names_map, t->name_off, &cand_id))
> 		return 0;
> =09
> > +	if (!cand_id)
> > +		return 0;
> > +
>=20
> ...and might be no harm to reiterate the special meaning of 0 here (multi=
ple
> name matches -> ambiguous) since it's a valid type id (void) in other cas=
es.
> While strictly you probably don't need separate conditions for not found
> and found ambiguous name, it might read a bit easier and more consistentl=
y
> with other users of hashmap__find().
>=20
> > +	cand_t =3D btf_type_by_id(d->btf, cand_id);
> > +	cand_kind =3D btf_kind(cand_t);
> > +	if (!(cand_kind =3D=3D BTF_KIND_STRUCT && fwd_kind =3D=3D BTF_FWD_STR=
UCT) &&
> > +	    !(cand_kind =3D=3D BTF_KIND_UNION && fwd_kind =3D=3D BTF_FWD_UNIO=
N))
> > +		return 0;
> > +
>=20
> I'd find
>=20
> 	if ((cand_id =3D=3D BTF_KIND_STRUCT && fwd_kind !=3D BTF_FWD_STRUCT) ||
> 	    (cand_id =3D=3D BTF_KIND_UNION && fwd_kind !=3D BTF_FWD_UNION))
>=20
> ...a bit easier to parse, but again not a big deal.
>=20
> > +	d->map[type_id] =3D cand_id;
> > +
> > +	return 0;
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
> > + * [1] STRUCT 'foo' size=3D4 vlen=3D1 ...
> > + * [2] INT 'int' size=3D4 ...
> > + * [3] PTR '(anon)' type_id=3D1
> > + * [4] FWD 'foo' fwd_kind=3Dstruct
> > + * [5] PTR '(anon)' type_id=3D4
> > + *
> > + * This pass assumes that such FWD declarations should be mapped to
> > + * structs or unions with identical name in case if the name is not
> > + * ambiguous.
> > + */
> > +static int btf_dedup_resolve_fwds(struct btf_dedup *d)
> > +{
> > +	int i, err;
> > +	struct hashmap *names_map =3D
> > +		hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
> > +
> > +	if (!names_map)
> > +		return -ENOMEM;
> > +
> > +	err =3D btf_dedup_fill_unique_names_map(d, names_map);
> > +	if (err < 0)
> > +		goto exit;
> > +
> > +	for (i =3D 0; i < d->btf->nr_types; i++) {
> > +		err =3D btf_dedup_resolve_fwd(d, names_map, d->btf->start_id + i);
> > +		if (err < 0)
> > +			goto exit;
>=20
> could just break; here I suppose
>=20
> > +	}
> > +
> > +exit:
> > +	hashmap__free(names_map);
> > +	return err;
> > +}
> > +
> >  /*
> >   * Compact types.
> >   *
> >=20

