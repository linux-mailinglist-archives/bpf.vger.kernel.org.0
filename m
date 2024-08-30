Return-Path: <bpf+bounces-38538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B201D965D3E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D491F25E35
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FEA17A5AA;
	Fri, 30 Aug 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7hWT2Je"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40681428E2;
	Fri, 30 Aug 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010947; cv=none; b=fyv7lLSg07g3LL64cQ+IvKxADj2bS8VA5s3X2zXUmYmQ86I6JgvjLjr8sKZW5uXjzpjnPneoSQifOZ6rOMxKRqJavzFi22Vy4iXEXn/SYxF8yyFWvml//2PXsTcplOjv/imkZXxi4QOKuVvTPFzTzKMxZdoxNZ8viiqDVl9o1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010947; c=relaxed/simple;
	bh=XtjQYRY1qQe47Fpaoq2cTkTu2LwaVE5cpakUbT2lP1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/sjSUR/N0n/KwHCCXKQTuOJ+jGQrtsmIfvIf4F6o0J3K+TKRUim/INKVrXmiu8iVBs8iLEXL/mhcuWG/3ttONvCHIcombpngBl3PBNXVCfJxG0qhVA6YIBVURW7EJ8eP4o6eq0+TewCvcNalnU+ZLNf9C7s5bkyz36AFh6JrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7hWT2Je; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053616fa36so1871905ad.0;
        Fri, 30 Aug 2024 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725010945; x=1725615745; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wTIITi2HBba2Tcx2nwPxtjFvHhGbOz8GwiOPGQCpZHk=;
        b=h7hWT2Je6gHAcfgoMi+SefLAoIKQKut1vDhL0Nkj4kR7RTs4qp2SPz5zKLn0HdXwDO
         lqrS8F25f+7sQw5EHpkVbbBEcuRP/SsYCHNx4Wnizij58Zzc1oy20tP+DhcJ1Y6LgFMQ
         SkyMbIAl5kpK18WiQduqEDksCFq2WgyowQCnwIjQkzaRm4LwstWkhARaWDIj9N5W3ZQw
         tf0/oze3o32Av4lvl/q1G5gBgw12AmAg/YT7e+jybF2VHkPKCUA3YzBG84IQiMOHgv8z
         Zbo8VnZBGIIn/mNGB1Pbmp1oyYsx5KeEGpuQ6Fk/SBpQwlck6L6pYT71BHcQpNSfoN4N
         WFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010945; x=1725615745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTIITi2HBba2Tcx2nwPxtjFvHhGbOz8GwiOPGQCpZHk=;
        b=bdM+7qIvOVMP/J3FFWb1qBtCM7bIWfewDMtf3RApGtdrYRyC5VoxidHktFRcBgRV3d
         UGeqVg2epA3Ere4U0poSzNqvuEF4Zr/x1Sq+JRxLd7hCRFRe0NBF5cnTW22nXHVoo7QN
         2JwuGXhfRFRZtfqMxy8t8y4AAy+RUQ+f8LERGIdtgVt+2YVLzPav5a4vaMQgMoQzFTWW
         HpAZECpDolCI9JyCDHHuiXfsp6oDAly6rMr/dmdkSS/qRz78kv4AaVNa+Aacx6K/u92u
         RDrQXJkqsYdPUwn32TdMOUeBeX+PqJi524ZdG1yWhC4Ix/d+gFqyLtT/+2gB+GWmqipR
         j8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB+Ot4V+Ut8eATvqW2VQ4Y0hqx8wR3V75AH9trqxI44g9nYC1mDpiP5tSwKkVH7wwNXBmhtFacDQL3SmyE@vger.kernel.org, AJvYcCX5O7zFDUB2x90bL7G87niuC35lpzKwDTjSfTA4lKeSQ6ZA2CMHfXsCNEAos//o4Ax7OXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2gnKcF73zVszEEmS+L3OhbQ2TQYsdg11B/ZOdMEuIYW29jEv
	+ZjgK4N+PSfJWbbCicvm0CJAfRmo8UvGc3TF2zxbNOjDCclD6OygUQhoPQ==
X-Google-Smtp-Source: AGHT+IG5Vy0uvqw+cgVXdeSrVPP7gz44WLSszu+P31w+SEz7rrV47mjSAEKdCpP+AIS3REHvYiWKxw==
X-Received: by 2002:a17:902:e552:b0:202:35e0:deab with SMTP id d9443c01a7336-2050c3cd56fmr56981035ad.32.1725010944705;
        Fri, 30 Aug 2024 02:42:24 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd653sm23596485ad.74.2024.08.30.02.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:42:24 -0700 (PDT)
Message-ID: <bd8a6dc3e52369a30c73578ea1144a48f736f393.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: add check for invalid name in
 btf_name_valid_section()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, yonghong.song@linux.dev
Date: Fri, 30 Aug 2024 02:42:19 -0700
In-Reply-To: <07EBE3E5-61A7-4F64-92BA-24A1DCA9583B@gmail.com>
References: <3a48e38f29cc8c73e36a6d3339b9303571d522a8.camel@gmail.com>
	 <07EBE3E5-61A7-4F64-92BA-24A1DCA9583B@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 11:03 +0900, Jeongjun Park wrote:

[...]

> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index edad152cee8e..d583d76fcace 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -820,7 +820,6 @@ static bool btf_name_valid_section(const struct btf=
 *btf, u32 offset)
> >=20
> >        /* set a limit on identifier length */
> >        src_limit =3D src + KSYM_NAME_LEN;
> > -       src++;
> >        while (*src && src < src_limit) {
> >                if (!isprint(*src))
> >                        return false;
>=20
> However, this patch is logically flawed.=20
> It will return true for invalid names with=20
> length 1 and src[0] being NULL. So I think=20
> it's better to stick with the original patch.

Fair enough, however the isprint check should be done for the first charact=
er.
So the full fix is a combination :)

--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -818,9 +818,11 @@ static bool btf_name_valid_section(const struct btf *b=
tf, u32 offset)
        const char *src =3D btf_str_by_offset(btf, offset);
        const char *src_limit;
=20
+       if (!*src)
+               return false;
+
        /* set a limit on identifier length */
        src_limit =3D src + KSYM_NAME_LEN;
-       src++;
        while (*src && src < src_limit) {
                if (!isprint(*src))
                        return false;


And corresponding test cases (tools/testing/selftests/bpf/prog_tests/btf.c)=
:

{
	.descr =3D "datasec: name with non-printable first char not is ok",
	.raw_types =3D {
		/* int */
		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
		/* VAR x */                                     /* [2] */
		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
		BTF_VAR_STATIC,
		/* DATASEC ?.data */                            /* [3] */
		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
		BTF_VAR_SECINFO_ENC(2, 0, 4),
		BTF_END_RAW,
	},
	BTF_STR_SEC("\0x\0\7foo"),
	.err_str =3D "Invalid name",
	.btf_load_err =3D true,
},{
	.descr =3D "datasec: name '\\0' is not ok",
	.raw_types =3D {
		/* int */
		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
		/* VAR x */                                     /* [2] */
		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
		BTF_VAR_STATIC,
		/* DATASEC \0 */                                /* [3] */
		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
		BTF_VAR_SECINFO_ENC(2, 0, 4),
		BTF_END_RAW,
	},
	BTF_STR_SEC("\0x\0"),
	.err_str =3D "Invalid name",
	.btf_load_err =3D true,
},

Could you please resend your patch as a patch-set fix + selftests update?


