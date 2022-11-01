Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2768A6150E3
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKARiD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiKARiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 13:38:02 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19295DF5
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 10:38:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j14so21920321ljh.12
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G6KGpArkyH+fVfBIZbzWqQT677fO9YZMwbEYsFu6Cts=;
        b=mraiD7Bdqc9RtGa9WzfubzrS7xf8P2dJbWWQpx7k43w/c6yr8ttq/uqXRXe6mFCLD5
         KXpNttcEyEmhVgMVkZXuogPMJ7ZP8XN2wl+xha+kmUOcxH8UY2C2E62YNa701sH6pk8Y
         /SEcOyPu3L+/BQvNnNYt2rpkA+b64yZMx2J+R+aDwZzCvRHS0SnfpiP5BUHnXTDqbC4O
         QP1Zlp+VxdiRrtLtIV0cJvRuOg3nhxpMYZFMDE7xSc14XYyeo7jBqMsLBsKS2CjPDlxw
         Iv+AVgCbI6rCaLWSgX1HJrw06qVmvh7AvloukHHLeHDnQfdRogFyPBuuRmpFUhNY8E0V
         y3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6KGpArkyH+fVfBIZbzWqQT677fO9YZMwbEYsFu6Cts=;
        b=HpH8UF2bR0VM3nq16ip248B/hNGLivWSij9GbBDqh7+YHp8Oe/1xJWA843SNvR6up7
         heCADQQ9PVJlDRLoNRQggodgyuo8rceY4kf33RbmoWxbhi1A/7y+CBC1YMwPklDsPNd7
         kqsgD/mhCgfNAq4i3GXCzeEPyXDOgF3YhZHILIcYsfBWXI7jWHxAouMvgQN6IV6JDYMJ
         2+oQA8CTi88goONiOnPw/BxD7fHUrHB4qmlu9ngiX4Op/wu0e/89vdAglc25rgK8YrSq
         kKINkdTkow39x2YzBz0PHmkMKftxOC1o4Q2CwpVaHihugMA9oEZhzeJq+A64d3kBQGHg
         oo4w==
X-Gm-Message-State: ACrzQf23dE+TT8Q0tvnBis+LnXk8ZU+jJGM3ivWQ/USVHIuw8O34YgEh
        e2WX/fl82uvU3c+pvWQIGZM=
X-Google-Smtp-Source: AMsMyM5SbOK7ZjsgIPOA2QPcNWlrsXi/e5wEEB4upIbk/PpXzolqokiQYUDe/LilzurIYgv2tsMGDA==
X-Received: by 2002:a2e:a817:0:b0:26e:580:fa70 with SMTP id l23-20020a2ea817000000b0026e0580fa70mr1079317ljq.307.1667324279228;
        Tue, 01 Nov 2022 10:37:59 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id 4-20020a2e1644000000b00277129b4a10sm1830523ljw.86.2022.11.01.10.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:37:58 -0700 (PDT)
Message-ID: <31c8edcbdda4b4d7ed05e0b25180c8ebf0d94f05.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/12] libbpf: Deduplicate unambigous standalone
 forward declarations
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
Date:   Tue, 01 Nov 2022 19:37:56 +0200
In-Reply-To: <c70549d8-f9c7-636b-7e4c-2b3e918978ec@oracle.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <20221025222802.2295103-2-eddyz87@gmail.com>
         <CAEf4Bzaf8XhO6OPoKSHPPSa1oQQ+KFHeN5Rmp0vn_9dgvOkOYw@mail.gmail.com>
         <264553ab5b53d22442ecb13725da905be8530c21.camel@gmail.com>
         <c70549d8-f9c7-636b-7e4c-2b3e918978ec@oracle.com>
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

On Tue, 2022-11-01 at 17:08 +0000, Alan Maguire wrote:
> On 31/10/2022 15:49, Eduard Zingerman wrote:
> > On Thu, 2022-10-27 at 15:07 -0700, Andrii Nakryiko wrote:
> > > On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> =
wrote:
> > [...]=20
> > > > +
> > > > +/*
> > > > + * Collect a `name_off_map` that maps type names to type ids for a=
ll
> > > > + * canonical structs and unions. If the same name is shared by sev=
eral
> > > > + * canonical types use a special value 0 to indicate this fact.
> > > > + */
> > > > +static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, st=
ruct hashmap *names_map)
> > > > +{
> > > > +       int i, err =3D 0;
> > > > +       __u32 type_id, collision_id;
> > > > +       __u16 kind;
> > > > +       struct btf_type *t;
> > > > +
> > > > +       for (i =3D 0; i < d->btf->nr_types; i++) {
> > > > +               type_id =3D d->btf->start_id + i;
> > > > +               t =3D btf_type_by_id(d->btf, type_id);
> > > > +               kind =3D btf_kind(t);
> > > > +
> > > > +               if (kind !=3D BTF_KIND_STRUCT && kind !=3D BTF_KIND=
_UNION)
> > > > +                       continue;
> > >=20
> > > let's also do ENUM FWD resolution. ENUM FWD is just ENUM with vlen=3D=
0
> >=20
> > Interestingly this is necessary only for mixed enum / enum64 case.
> > Forward enum declarations are resolved by bpf/btf.c:btf_dedup_prim_type=
:
> >=20
>=20
> Ah, great catch! A forward can look like an enum to one CU but another CU=
 can
> specify values that make it an enum64.
>=20
> > 	case BTF_KIND_ENUM:
> > 		h =3D btf_hash_enum(t);
> > 		for_each_dedup_cand(d, hash_entry, h) {
> > 			cand_id =3D (__u32)(long)hash_entry->value;
> > 			cand =3D btf_type_by_id(d->btf, cand_id);
> > 			if (btf_equal_enum(t, cand)) {
> > 				new_id =3D cand_id;
> > 				break;
> > 			}
> > 			if (btf_compat_enum(t, cand)) {
> > 				if (btf_is_enum_fwd(t)) {
> > 					/* resolve fwd to full enum */
> > 					new_id =3D cand_id;
> > 					break;
> > 				}
> > 				/* resolve canonical enum fwd to full enum */
> > 				d->map[cand_id] =3D type_id;
> > 			}
> > 		}
> > 		break;
> >     // ... similar logic for ENUM64 ...
> >=20
> > - btf_hash_enum ignores vlen when hashing;
> > - btf_compat_enum compares only names and sizes.
> >=20
> > So, if forward and main declaration kinds match (either BTF_KIND_ENUM
> > or BTF_KIND_ENUM64) the forward declaration would be removed. But if
> > the kinds are different the forward declaration would remain. E.g.:
> >=20
> > CU #1:
> > enum foo;
> > enum foo *a;
> >=20
> > CU #2:
> > enum foo { x =3D 0xfffffffff };
> > enum foo *b;
> >=20
> > BTF:
> > [1] ENUM64 'foo' encoding=3DUNSIGNED size=3D8 vlen=3D1
> > 	'x' val=3D68719476735ULL
> > [2] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encod=
ing=3D(none)
> > [3] PTR '(anon)' type_id=3D1
> > [4] ENUM 'foo' encoding=3DUNSIGNED size=3D4 vlen=3D0
> > [5] PTR '(anon)' type_id=3D4
> >=20
> > BTF_KIND_FWDs are unified during btf_dedup_struct_types but enum
> > forward declarations are not. So it would be incorrect to add enum
> > forward declaration unification logic to btf_dedup_resolve_fwds,
> > because the following case would not be covered:
> >=20
> > CU #1:
> > enum foo;
> > struct s { enum foo *a; } *a;
> >=20
> > CU #2:
> > enum foo { x =3D 0xfffffffff };
> > struct s { enum foo *a; } *b;
> >=20
> > Currently STRUCTs 's' are not de-duplicated.
> >=20
>=20
> What if CU#1 is in base BTF and CU#2 in split module BTF? I think we'd ex=
plicitly
> want to avoid deduping "struct s" then since we can't be sure that it is =
the
> same enum they are pointing at.  That's the logic we employ for structs a=
t=20
> least, based upon the rationale that we can't feed back knowledge of type=
s
> from module to kernel BTF since the latter is now fixed (Andrii, do corre=
ct me
> if I have this wrong). In such a case the enum is no longer standalone; i=
t
> serves the purpose of allowing us to define a pointer to a module-specifi=
c
> type. We recently found some examples of this sort of thing with structs,
> where the struct was defined in module BTF, making dedup fail for some co=
re
> kernel data types, but the problem was restricted to modules which _did_
> define the type so wasn't a major driver of dedup failures. Not sure if
> there's many (any?) enum cases of this in practice.

Hi Alan,

As far as I understand the loop in `btf_dedup_prim_types` guarantees
that only ids from the split module would be remapped:

	struct btf {
    	...
		/* BTF type ID of the first type in this BTF instance:
		 *   - for base BTF it's equal to 1;
		 *   - for split BTF it's equal to biggest type ID of base BTF plus 1.
		 */
		int start_id;
    	...
	}

    ...
	for (i =3D 0; i < d->btf->nr_types; i++) {
		err =3D btf_dedup_prim_type(d, d->btf->start_id + i);
		if (err)
			return err;
	}

Thus CU1:foo won't be updated to be CU2:foo and CU1:s will not be the
same as CU2:s. Is that right or am I confused?

Thanks,
Eduard

>=20
> I suppose if we could guarantee the dedup happened within the same object
> (kernel or module) we could relax this constraint though?
>=20
> Alan

