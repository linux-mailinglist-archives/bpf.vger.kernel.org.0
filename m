Return-Path: <bpf+bounces-28547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7808BB4F4
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 22:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAF91C23232
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D04A1C68C;
	Fri,  3 May 2024 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtFO8Aav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFB63CF
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768590; cv=none; b=VbgwSdY5lS6E62TvyRRKL+PyAuV3+kSVKZugiPAr21vWVEv2TOTxU1J0BwPnyITl/lY3K04m9cmyQfc96FkopkqiFZHSs6MF1b9VDmJNO/orFnP0bfVtc5PRrVLxT6BjL1y68Hy7T9T2K0CvyXjwmLWBJtVJbfAkWh1W8+RqA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768590; c=relaxed/simple;
	bh=vk4969wZzjerye7WBuDtdjNZG18+jG/yipAKPd1yW2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xt3Ss7meHJ2Q2Cc2MFmey54PK9yFWEXT+vpLHjmMBeOeOQNp8Lj5M5OQTS2m9RD9NKRV1nJMy9KcJoYjfYyRDbYzmoRvXKX4YVYOoV55LEN0In4GFBSxs4C0bvue5L6NrCBHspaoYzZ4J4nUq6J24a6F26O7ij385Bj47qSaEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtFO8Aav; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f44b296e1fso103715b3a.3
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714768588; x=1715373388; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z/fIOS+nwqC/Xk/GNcMg8oTHKGa7m26kMR4Xry34La0=;
        b=CtFO8AavWq5J33wUO3Tr2d1npjKe5T8+xdh38JuJE6CqeVgdVeNL6JoPdcajn0n/j7
         hcAtMgWTcYIACl+DqBCFTdxo/cAAkjvn/K1dj/Xxv0Pl4Ty7OJLYzSUSkzG6Vy/ufynW
         K74RIl48xQzXp283hdR9MxU0+IoCcERKSIP96ebWtKZhEuY/aUgDmfoDshfz8bHMbBLN
         6Q6HEdSUqheOH4oY+p735XQqcXuImBphJPJfbLQ/jt3cR5XXnFMgWDEo/0PkToVtTbTT
         HFzg5bujRe8SQbeFhSqdhUvO8Hc8Xi3Rg61ossl3aMSUN6kxHMXAU5YdVIU6aqcWBVge
         /ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714768588; x=1715373388;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/fIOS+nwqC/Xk/GNcMg8oTHKGa7m26kMR4Xry34La0=;
        b=LfvOyVDzzOv8WBdx9xhjhm2j24TfD9WhV2dRhGwGrzvSAVAIJ9vuYLK07wH00fkKxZ
         RnD6m1/2VrTz0u8OZclilqEsstQb29Sa1H3rsQISenzVBx/3SOCXmyTDs1VzJBQhMHp8
         670WIen++KtzpXcUODLVdoIMvV1crDziChAZ6aWDOY8E3Lp4L6NO2rDYsc7p/j+baVWt
         Vzl2yfwJq3g39xcHFem1+D0NAFmH2YYZZeu509fEWL+4cBixAukKC7c4xe8pAlbBSN6m
         wbtuvGhNeikq/EHbIBsDKrxKVA3OgDkKUGX7cgy9oLBQITWf8ngrijDUimDnmPAO5Plb
         4yxw==
X-Forwarded-Encrypted: i=1; AJvYcCWYY1i/+O1IVWQA7jz/uH42RzVeaA1JAtNOIydp8al7HYdDyxSpZD1CunsIg49vDQH4R2nDI9L3Z6RP2HUj9orA8qi5
X-Gm-Message-State: AOJu0Yy5s63N/K1mT3XcDO5b0C8O5ZAE7kMQ8BXKiMF3VL75CaGj4ErU
	ArLjwblQsNXRu9WjubA8EfenA2+8DFlrux5K1c2HV6YGP32QtHjx
X-Google-Smtp-Source: AGHT+IEH2OHGD/+Xryz5mmywPm3fBL3b7yDRLTLSLMDnJWi4wfG314PZVXNoPXNDGkx3Uqk6m9lkVQ==
X-Received: by 2002:a05:6a21:1f23:b0:1ad:7bfd:54a1 with SMTP id ry35-20020a056a211f2300b001ad7bfd54a1mr3621182pzb.17.1714768587835;
        Fri, 03 May 2024 13:36:27 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:da47:6959:81c7:8b0? ([2604:3d08:6979:1160:da47:6959:81c7:8b0])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b006eadc87233dsm3467783pfn.165.2024.05.03.13.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:36:27 -0700 (PDT)
Message-ID: <6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com>
Subject: Re: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute
 pragmas in bpftool
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	david.faust@oracle.com, cupertino.miranda@oracle.com
Date: Fri, 03 May 2024 13:36:26 -0700
In-Reply-To: <20240503111836.25275-1-jose.marchesi@oracle.com>
References: <20240503111836.25275-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-03 at 13:18 +0200, Jose E. Marchesi wrote:
[...]

> This patch modifies bpftool in order to, instead of using the pragmas,
> define ATTR_PRESERVE_ACCESS_INDEX to conditionally expand to the CO-RE
> attribute:
>=20
>   #ifndef __VMLINUX_H__
>   #define __VMLINUX_H__
>=20
>   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>   #define ATTR_PRESERVE_ACCESS_INDEX __attribute__((preserve_access_index=
))
>   #else
>   #define ATTR_PRESERVE_ACCESS_INDEX
>   #endif

Nit: maybe swap the branches to avoid double negation?

>=20
>   [... type definitions generated from kernel BTF ... ]
>=20
>   #undef ATTR_PRESERVE_ACCESS_INDEX
>=20
> and then the new btf_dump__dump_type_with_opts is used with options
> specifying that we wish to have struct type attributes:
>=20
>   DECLARE_LIBBPF_OPTS(btf_dump_type_opts, opts);
>   [...]
>   opts.record_attrs_str =3D "ATTR_PRESERVE_ACCESS_INDEX";
>   [...]
>   err =3D btf_dump__dump_type_with_opts(d, root_type_ids[i], &opts);
>=20
> This is a RFC because introducing a new libbpf public function
> btf_dump__dump_type_with_opts may not be desirable.
>=20
> An alternative could be to, instead of passing the record_attrs_str
> option in a btf_dump_type_opts, pass it in the global dumper's option
> btf_dump_opts:
>=20
>   DECLARE_LIBBPF_OPTS(btf_dump_opts, opts);
>   [...]
>   opts.record_attrs_str =3D "ATTR_PRESERVE_ACCESS_INDEX";
>   [...]
>   d =3D btf_dump__new(btf, btf_dump_printf, NULL, &opts);
>   [...]
>   err =3D btf_dump__dump_type(d, root_type_ids[i]);
>=20
> This would be less disruptive regarding library API, and an overall
> simpler change.  But it would prevent to use the same btf dumper to
> dump types with and without attribute definitions.  Not sure if that
> matters much in practice.
>=20
> Thoughts?

I think that generating attributes explicitly is fine.

I also think that moving '.record_attrs_str' to 'btf_dump_opts' is preferab=
le,
in order to avoid adding new API functions.
Could you please add a doc-string somewhere saying that
".record_attrs_str" applies to 'struct' and 'union'?
Spent some time reading clang to verify that this is the case for
'applies_to=3Drecord' and it is.
(build/tools/clang/include/clang/Sema/AttrParsedAttrImpl.inc,
 function checkAttributeMatchRuleAppliesTo(),
 case for attr::SubjectMatchRule_record).

[...]

