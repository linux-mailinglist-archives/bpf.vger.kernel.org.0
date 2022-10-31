Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17C613AAB
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiJaPtN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiJaPtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 11:49:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9624211C15
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 08:49:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z24so17234046ljn.4
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKsnfGfRQXVP6aZ6wocwBBoiekvRPB7F+qrwDXyx1U0=;
        b=Qooz1RmpeVf/p9pUh0v19/D8IILitF5THBq6pdQNNjVtDIuFHekIKXR7IQBZBWC6q+
         rDeO6DDuMaaQwQ1vlPmYAwsY620bRKonsPgPQ4CVmYAavndk5hJ51q7mwEXs4aBsHR2A
         w8ueRTeMJ+FyR5zPCdkhZ4DqP3U9p4mKgK4YzN4V1bqea6OiPw2DoEssxym4+w8dUous
         Majc6B+zCOXBtcjuIEBFC4ptOqj5icN1nxouMBYzqcu8uYPbx9DddF2uRDJ9I/AMP3D1
         X6gNic83uIE45bqd+cwEapm4ROEy/8rWIP4QbhM/rWBzlsIV5TSxQ1WJ8YTB28rA0GXb
         OJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKsnfGfRQXVP6aZ6wocwBBoiekvRPB7F+qrwDXyx1U0=;
        b=QX0kxRuqvJFFJv8Fp5SJ7LMOALdH2HN61CfPoHR3xjHqN4m2Py3xY7mPD5pbd1HMpp
         vkRjIYm1g3iwOrtekhfQ8g7/hCH7VP3g8xA4tVDFA8VDPaGzlrdD68mysCshYo9mJRTz
         WSDEx0D+LhpeGRW4XmqkQopOyoJCsdoFlkF6R80bwREqVLuQsFouRlRCNcdFDUab67vE
         3Y5ce83Ly/tuhCqLU/IHmQt254FhCCZEsefQ695wP8JRotIciqRinbuEr3ZZL1VOuK4W
         N5xQoJ9+xR6tYI6acwhTwMtHmxAEGUyh/1BpSGutPhlXHP0L0vv0q1NVuUhIqws2uICE
         2NFQ==
X-Gm-Message-State: ACrzQf2kYnkg2JZaqbNTrunEYcH47BiStCBvVtHlL96bjYitwbKDzhvd
        MDrnTyJ623E9MghTG/zYyVZEEkR9xWxN+Tce
X-Google-Smtp-Source: AMsMyM7x81+eMXkewUA7+ZDMIPI+NzrYL0O1LRrbDE7VzSd/+88W+NUaRQcqjR/KbKQ3WFcYqK0s0A==
X-Received: by 2002:a2e:86d6:0:b0:277:62b5:1927 with SMTP id n22-20020a2e86d6000000b0027762b51927mr788888ljj.443.1667231349796;
        Mon, 31 Oct 2022 08:49:09 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id s5-20020a056512314500b004ac980a1ba1sm1328705lfi.24.2022.10.31.08.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:49:09 -0700 (PDT)
Message-ID: <264553ab5b53d22442ecb13725da905be8530c21.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/12] libbpf: Deduplicate unambigous standalone
 forward declarations
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
Date:   Mon, 31 Oct 2022 17:49:07 +0200
In-Reply-To: <CAEf4Bzaf8XhO6OPoKSHPPSa1oQQ+KFHeN5Rmp0vn_9dgvOkOYw@mail.gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <20221025222802.2295103-2-eddyz87@gmail.com>
         <CAEf4Bzaf8XhO6OPoKSHPPSa1oQQ+KFHeN5Rmp0vn_9dgvOkOYw@mail.gmail.com>
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

On Thu, 2022-10-27 at 15:07 -0700, Andrii Nakryiko wrote:
> On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
[...]=20
> > +
> > +/*
> > + * Collect a `name_off_map` that maps type names to type ids for all
> > + * canonical structs and unions. If the same name is shared by several
> > + * canonical types use a special value 0 to indicate this fact.
> > + */
> > +static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, struct=
 hashmap *names_map)
> > +{
> > +       int i, err =3D 0;
> > +       __u32 type_id, collision_id;
> > +       __u16 kind;
> > +       struct btf_type *t;
> > +
> > +       for (i =3D 0; i < d->btf->nr_types; i++) {
> > +               type_id =3D d->btf->start_id + i;
> > +               t =3D btf_type_by_id(d->btf, type_id);
> > +               kind =3D btf_kind(t);
> > +
> > +               if (kind !=3D BTF_KIND_STRUCT && kind !=3D BTF_KIND_UNI=
ON)
> > +                       continue;
>=20
> let's also do ENUM FWD resolution. ENUM FWD is just ENUM with vlen=3D0

Interestingly this is necessary only for mixed enum / enum64 case.
Forward enum declarations are resolved by bpf/btf.c:btf_dedup_prim_type:

	case BTF_KIND_ENUM:
		h =3D btf_hash_enum(t);
		for_each_dedup_cand(d, hash_entry, h) {
			cand_id =3D (__u32)(long)hash_entry->value;
			cand =3D btf_type_by_id(d->btf, cand_id);
			if (btf_equal_enum(t, cand)) {
				new_id =3D cand_id;
				break;
			}
			if (btf_compat_enum(t, cand)) {
				if (btf_is_enum_fwd(t)) {
					/* resolve fwd to full enum */
					new_id =3D cand_id;
					break;
				}
				/* resolve canonical enum fwd to full enum */
				d->map[cand_id] =3D type_id;
			}
		}
		break;
    // ... similar logic for ENUM64 ...

- btf_hash_enum ignores vlen when hashing;
- btf_compat_enum compares only names and sizes.

So, if forward and main declaration kinds match (either BTF_KIND_ENUM
or BTF_KIND_ENUM64) the forward declaration would be removed. But if
the kinds are different the forward declaration would remain. E.g.:

CU #1:
enum foo;
enum foo *a;

CU #2:
enum foo { x =3D 0xfffffffff };
enum foo *b;

BTF:
[1] ENUM64 'foo' encoding=3DUNSIGNED size=3D8 vlen=3D1
	'x' val=3D68719476735ULL
[2] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encoding=
=3D(none)
[3] PTR '(anon)' type_id=3D1
[4] ENUM 'foo' encoding=3DUNSIGNED size=3D4 vlen=3D0
[5] PTR '(anon)' type_id=3D4

BTF_KIND_FWDs are unified during btf_dedup_struct_types but enum
forward declarations are not. So it would be incorrect to add enum
forward declaration unification logic to btf_dedup_resolve_fwds,
because the following case would not be covered:

CU #1:
enum foo;
struct s { enum foo *a; } *a;

CU #2:
enum foo { x =3D 0xfffffffff };
struct s { enum foo *a; } *b;

Currently STRUCTs 's' are not de-duplicated.

I think that btf_dedup_prim_type should be adjusted to handle this case.

[...]=20
