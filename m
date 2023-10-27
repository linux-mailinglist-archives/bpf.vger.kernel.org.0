Return-Path: <bpf+bounces-13515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF3F7DA30F
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 00:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767681C209FA
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 22:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B979405CF;
	Fri, 27 Oct 2023 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXktHvUD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4A3FB02;
	Fri, 27 Oct 2023 22:02:50 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E471B5;
	Fri, 27 Oct 2023 15:02:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso360679966b.0;
        Fri, 27 Oct 2023 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698444168; x=1699048968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nerlBGOk3p0DOhDfvG+YXUIRqsl2qZ4e38CdCvsDH2o=;
        b=GXktHvUDrxXOdFnXWJIfVJjw6iDrnOUsep4r0DiAYBg3KB/fuzX1uDxv9hjeg7li/u
         xIO5nG5AMQ0E8rirXiMwDK0K1W+7n5y7pfYgEZH/bFBppQrlt5cRusoEhRuMWxy6UXj7
         zgJuoo1r1FHhr8ETcEz1mNlHi16DXm0nokhv6S81OYsIgxWQ5nSKX/dAV8TABtXMH3Ct
         e4YIQRXdJed6LXfhqutzOt3HH6BWC2IdP1N3KfZ/pmolfvLES/xpWo6BTNQj1k+cMZmM
         pGfpSXDKHX4JVvc3OU6fomkfM1wITXv2vdzDOBNjq6gJiz5ncM+JhNG1jwYFbEKn3P3K
         uPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698444168; x=1699048968;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nerlBGOk3p0DOhDfvG+YXUIRqsl2qZ4e38CdCvsDH2o=;
        b=E/+SReRwIwYEMZoTmIxbUcBR/znLe/tOjd87csN9ANLqWIETHBiDfqt1Ny8ZzaSClC
         9TIQxX3ckkTIkNbbyR5awFnWwtE1crvzhIIVNTmbU53oRQ7b9C2o/1GyXld7Fz/D7CkD
         f3rIHMRvJ+OhTwB2uiZdB+QCkJ/fNN6sdyB2TnOgEQ1vO0d10AjpTB9pZw5pJeaUZ95a
         kj6pDfvrtKsQCwYPAwCszobkEffssyMVwye7YWwinMUmoiLmATKNAQ091MD3gYLyxT9E
         dC1BUnszO7ALWo8b0zDayMaHdOB/QRK0RyPgq2K8tseoI0lVlJOEtmKd4/bj9iB5V3Tz
         vC8g==
X-Gm-Message-State: AOJu0Yz1VaxQbFZw+M1IIWilwWMydzIwkpgzT9LV4nYOd8UZkJr1sB0H
	G6VMBcfE9DzGJNTiDuwaR+KEsU/i/0xDLanF
X-Google-Smtp-Source: AGHT+IHUzKlRwHrG5ZLUVwsxRK7O0VvlNH7Qt7SkQak1LaJRhkk+KydaYFBu+aQ4ioi+j7w3UoBX/Q==
X-Received: by 2002:a17:906:fe08:b0:9ca:e7ce:8e68 with SMTP id wy8-20020a170906fe0800b009cae7ce8e68mr2895068ejb.44.1698444167414;
        Fri, 27 Oct 2023 15:02:47 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l17-20020a170906415100b009adc77fe165sm1761235ejk.118.2023.10.27.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:02:46 -0700 (PDT)
Message-ID: <af3b92d434b1d85e9dc3e60c46ed7ed68dde438e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 07/10] bpf, net: switch to dynamic
 registration
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com, 
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
  kernel-team@meta.com, andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com, netdev@vger.kernel.org
Date: Sat, 28 Oct 2023 01:02:45 +0300
In-Reply-To: <df8f71ce-4e3b-4e65-a197-e2ce0ca494de@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
	 <20231022050335.2579051-8-thinker.li@gmail.com>
	 <7b143dd306cdb3a94c995bf807596fb1f88a02f9.camel@gmail.com>
	 <f2c33ec4-339d-464d-893e-4f5ba0b9c294@gmail.com>
	 <df8f71ce-4e3b-4e65-a197-e2ce0ca494de@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 14:32 -0700, Kui-Feng Lee wrote:
>=20
> On 10/26/23 21:39, Kui-Feng Lee wrote:
> >=20
> >=20
> > On 10/26/23 14:02, Eduard Zingerman wrote:
> > > On Sat, 2023-10-21 at 22:03 -0700, thinker.li@gmail.com wrote:
> > > > From: Kui-Feng Lee <thinker.li@gmail.com>
> [...]
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 btf =3D btf_get_module_btf(st_ops->owner);
> > > > +=C2=A0=C2=A0=C2=A0 if (!btf)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 log =3D kzalloc(sizeof(*log), GFP_KERNEL | __GF=
P_NOWARN);
> > > > +=C2=A0=C2=A0=C2=A0 if (!log) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D -ENOMEM;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto errout;
> > > > +=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 log->level =3D BPF_LOG_KERNEL;
> > >=20
> > > Nit: maybe use bpf_vlog_init() here to avoid breaking encapsulation?
> >=20
> > Agree!
> >=20
>=20
> I don't use bpf_vlog_init() eventually.
>=20
> I found bpf_vlog_init() is not for BPF_LOG_KERNEL.
> According to the comment next to BPF_LOG_KERNEL, it
> is an internal log level.
> According to the code of bpf_vlog_init(), the level passing to
> bpf_vlog_init() should be covered by BPF_LOG_MASK. BPF_LOG_KERNEL is
> defined as BPF_LOG_MASK + 1. So, it is intended not being used with
> bpf_vlog_init().

I see, looks like btf_parse_vmlinux does the same, sorry should have checke=
d there.
Thank you for looking into it.

>=20
> > >=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 desc =3D btf_add_struct_ops(btf, st_ops);
> > > > +=C2=A0=C2=A0=C2=A0 if (IS_ERR(desc)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D PTR_ERR(desc);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto errout;
> > > > +=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 bpf_struct_ops_init(desc, btf, log);
> > >=20
> > > Nit: I think bpf_struct_ops_init() could be changed to return 'int',
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then register_bpf_struct_ops() could r=
eport to calling module if
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 something went wrong on the last phase=
, wdyt?
> >=20
> >=20
> > Agree!
> >=20
> > >=20
> > > > +
> > > > +errout:
> > > > +=C2=A0=C2=A0=C2=A0 kfree(log);
> > > > +=C2=A0=C2=A0=C2=A0 btf_put(btf);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 return err;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
> > > > diff --git a/net/bpf/bpf_dummy_struct_ops.c=20
> > > > b/net/bpf/bpf_dummy_struct_ops.c
> > > > index ffa224053a6c..148a5851c4fa 100644
> > > > --- a/net/bpf/bpf_dummy_struct_ops.c
> > > > +++ b/net/bpf/bpf_dummy_struct_ops.c
> > > > @@ -7,7 +7,7 @@
> > > > =C2=A0 #include <linux/bpf.h>
> > > > =C2=A0 #include <linux/btf.h>
> > > > -extern struct bpf_struct_ops bpf_bpf_dummy_ops;
> > > > +static struct bpf_struct_ops bpf_bpf_dummy_ops;
> > > > =C2=A0 /* A common type for test_N with return value in bpf_dummy_o=
ps */
> > > > =C2=A0 typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_st=
ate=20
> > > > *state, ...);
> > > > @@ -223,11 +223,13 @@ static int bpf_dummy_reg(void *kdata)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
> > > > =C2=A0 }
> > > > +DEFINE_STRUCT_OPS_VALUE_TYPE(bpf_dummy_ops);
> > > > +
> > > > =C2=A0 static void bpf_dummy_unreg(void *kdata)
> > > > =C2=A0 {
> > > > =C2=A0 }
> > > > -struct bpf_struct_ops bpf_bpf_dummy_ops =3D {
> > > > +static struct bpf_struct_ops bpf_bpf_dummy_ops =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .verifier_ops =3D &bpf_dummy_verifie=
r_ops,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init =3D bpf_dummy_init,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .check_member =3D bpf_dummy_ops_chec=
k_member,
> > > > @@ -235,4 +237,12 @@ struct bpf_struct_ops bpf_bpf_dummy_ops =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .reg =3D bpf_dummy_reg,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unreg =3D bpf_dummy_unreg,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "bpf_dummy_ops",
> > > > +=C2=A0=C2=A0=C2=A0 .owner =3D THIS_MODULE,
> > > > =C2=A0 };
> > > > +
> > > > +static int __init bpf_dummy_struct_ops_init(void)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0 BTF_STRUCT_OPS_TYPE_EMIT(bpf_dummy_ops);
> > > > +=C2=A0=C2=A0=C2=A0 return register_bpf_struct_ops(&bpf_bpf_dummy_o=
ps);
> > > > +}
> > > > +late_initcall(bpf_dummy_struct_ops_init);
> > > > diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> > > > index 3c8b76578a2a..b36a19274e5b 100644
> > > > --- a/net/ipv4/bpf_tcp_ca.c
> > > > +++ b/net/ipv4/bpf_tcp_ca.c
> > > > @@ -12,7 +12,7 @@
> > > > =C2=A0 #include <net/bpf_sk_storage.h>
> > > > =C2=A0 /* "extern" is to avoid sparse warning.=C2=A0 It is only use=
d in=20
> > > > bpf_struct_ops.c. */
> > > > -extern struct bpf_struct_ops bpf_tcp_congestion_ops;
> > > > +static struct bpf_struct_ops bpf_tcp_congestion_ops;
> > > > =C2=A0 static u32 unsupported_ops[] =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(struct tcp_congestion_ops, =
get_info),
> > > > @@ -277,7 +277,9 @@ static int bpf_tcp_ca_validate(void *kdata)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tcp_validate_congestion_contr=
ol(kdata);
> > > > =C2=A0 }
> > > > -struct bpf_struct_ops bpf_tcp_congestion_ops =3D {
> > > > +DEFINE_STRUCT_OPS_VALUE_TYPE(tcp_congestion_ops);
> > > > +
> > > > +static struct bpf_struct_ops bpf_tcp_congestion_ops =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .verifier_ops =3D &bpf_tcp_ca_verifi=
er_ops,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .reg =3D bpf_tcp_ca_reg,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unreg =3D bpf_tcp_ca_unreg,
> > > > @@ -287,10 +289,18 @@ struct bpf_struct_ops bpf_tcp_congestion_ops =
=3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .init =3D bpf_tcp_ca_init,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .validate =3D bpf_tcp_ca_validate,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "tcp_congestion_ops",
> > > > +=C2=A0=C2=A0=C2=A0 .owner =3D THIS_MODULE,
> > > > =C2=A0 };
> > > > =C2=A0 static int __init bpf_tcp_ca_kfunc_init(void)
> > > > =C2=A0 {
> > > > -=C2=A0=C2=A0=C2=A0 return register_btf_kfunc_id_set(BPF_PROG_TYPE_=
STRUCT_OPS,=20
> > > > &bpf_tcp_ca_kfunc_set);
> > > > +=C2=A0=C2=A0=C2=A0 int ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 BTF_STRUCT_OPS_TYPE_EMIT(tcp_congestion_ops);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE=
_STRUCT_OPS,=20
> > > > &bpf_tcp_ca_kfunc_set);
> > > > +=C2=A0=C2=A0=C2=A0 ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp=
_congestion_ops);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 return ret;
> > > > =C2=A0 }
> > > > =C2=A0 late_initcall(bpf_tcp_ca_kfunc_init);
> > >=20


