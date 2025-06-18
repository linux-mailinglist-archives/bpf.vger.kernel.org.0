Return-Path: <bpf+bounces-60904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6783ADE990
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D093B93EF
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67D72882D3;
	Wed, 18 Jun 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYm0Cx8V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02102882B9
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244665; cv=none; b=O91R13hDC6Ih62AQb1sHhp6dPqF5ptqymPvfN1/i/HIXx+lGWRn8KgF2VZgT5BTIgKXVBGKebqiP34sepHvxWK+DemcVe//XanSALGc0ZmP33BmIEBMo1pVPftjhg80jqfimILFyHKkd12yl84QC2nOAqiHdnZdz1XLFuIMUMq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244665; c=relaxed/simple;
	bh=y5od5aqyJi3831Fy6v+7xB6dpqgKaNoYE9MXaaadqAQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBj6EOOy4j7tjuV80jzaAdnGMsw+rRi6Ch3yZvfQbszfhnUZXuXXgyNHiHlg++oAlkZ5+8g43ns5P+/PfFjaEmSfbc6vsficc3/5MV37Qap3TPReKno8w/mthpbQXFvpO4koJyq+fuEWbl87wpk+6NNjxvBv9LYIdnplLunexXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYm0Cx8V; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-879d2e419b9so6504865a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750244663; x=1750849463; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhe+3iax+FbxpxKx1FqDIocUPqcMX1GEQDOTkcPi+UU=;
        b=ZYm0Cx8VBUMBALwxxS2SRhdWmcluNdLptGpPHtZxySKIelktrZpl+OJHdXnCSeHFZN
         jniaAOuBxM9VgNItoLdewdrfyuDXXWPxS/GoaMqYWM9OmRjSNgFGolUMYSW61Hd34C2X
         +Q87My60iVzuv/Srjbz3XagvOq5LlkyQhfashBrS/jRM/+BSDBizCIW9b5Kf00jobUBk
         msERMulqpdx4djm6EpPaFpVpuYjvv+CiTfruTYxo0N8O+rb3JKPv60zk2V1ReLAsjJTE
         LdcHn7ZylOqPAF8zlmqreFwrWoYesTaLVL2GSQz6BfRVsUvYrNIgZZAyMqyS8yjTGuay
         tR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750244663; x=1750849463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uhe+3iax+FbxpxKx1FqDIocUPqcMX1GEQDOTkcPi+UU=;
        b=rSq+GVpUIadHtgtshbmkegMLccY8Fp0MxF5bEYXoDPMXJLBrfHRm4uXn0hQty5n30J
         8Fp1aM9y1cGedDzx672o9leSLqC5SQc0eOc0xwT7DSTjODcbt+feIlMquiel+UMUPo1m
         QEbSepSJNO77vS0VamQC4rpI43YMkpUx5y5PVomKbGXvm5ld7lz+ygtlKAYhGfG9SWKX
         /nLyYAi9bmp+2TwH0Zbeu+7Ua85iueesVnG8A5GHz14nfg0VFERmcZqd54QMUqkpmp1+
         ViDERAv6+yH21S6t2WbSwqtKqwVU0QP2X+4IXpJcOMqtQgai4uc2WsST+oKzzuTZRZ7R
         FbSg==
X-Forwarded-Encrypted: i=1; AJvYcCWsOoRw7qcGFoICkr22yHFXDDAzom7ptHQxO9zMYG75ip+73wr5vixEuRt03+JDpgUTXzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6IliSaaIpj0KPbfwGegKvXkW/oJ58S3LzuIkR9VErb79RASIr
	1KDyzPhKcoRpwu8EKuKtmx2E2GKojsz8ESAx97cEStYoNCmXJj//SVJOCJ2sYwDgIkE=
X-Gm-Gg: ASbGnctFlzqmbtLY+PNm6fvQsavytRxjUhYDZaNl1VcRKhnVIKLbrk8OQpMBN8Ck49y
	MbDxsfqnIPe21RkqZ151MuGV16bvHeUk0fqu3JL70ZYePPcrblHfk8F7G03tT7eA4gaK9e0GSiV
	HaQKOzj2FQxigBgjcg5aehTxFPbrQJBMw84hVQ70gawkOrmafEYjQjKvSWG1ieN2vK/ofOMUvig
	YcmOQBU2ItVHXuaazt9CP3oajzoDIHW8JaEH8JykMFix2Gu1rA13zY0XkA6LmBsg0dMKt3dCPvP
	AjC2ea9iSrZQm9AAQmD5t6JWvpZUajfXtDqsvbOw+neXkuiJ4VVNR6trpg==
X-Google-Smtp-Source: AGHT+IEeaQPFDuz4OUSIcKmH5g7RmY3NmSkDx3Nzr4sKLi5PK0AbDeeGHQVBOmHW2bBcNAus0DekGw==
X-Received: by 2002:a05:6a21:3283:b0:21c:fea4:60e2 with SMTP id adf61e73a8af0-21fbd50703amr29136270637.3.1750244663126;
        Wed, 18 Jun 2025 04:04:23 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890084ae8sm11037177b3a.99.2025.06.18.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:04:22 -0700 (PDT)
Message-ID: <5be2b20d4190e6c2aed7386a350bccc3eaa79535.camel@gmail.com>
Subject: Re: [RFC bpf-next 6/9] bpf: workaround llvm behaviour with indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 18 Jun 2025 04:04:21 -0700
In-Reply-To: <20250615085943.3871208-7-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
		 <20250615085943.3871208-7-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> When indirect jumps are enabled in LLVM, it might generate
> unreachable instructions. For example, the following code
>=20
>     SEC("syscall") int foo(struct simple_ctx *ctx)
>     {
>             switch (ctx->x) {
>             case 0:
>                     ret_user =3D 2;
>                     break;
>             case 11:
>                     ret_user =3D 3;
>                     break;
>             case 27:
>                     ret_user =3D 4;
>                     break;
>             case 31:
>                     ret_user =3D 5;
>                     break;
>             default:
>                     ret_user =3D 19;
>                     break;
>             }
>=20
>             return 0;
>     }
>=20
> compiles into
>=20
>     <foo>:
>     ;       switch (ctx->x) {
>          224:       79 11 00 00 00 00 00 00 r1 =3D *(u64 *)(r1 + 0x0)
>          225:       25 01 0f 00 1f 00 00 00 if r1 > 0x1f goto +0xf <foo+0=
x88>
>          226:       67 01 00 00 03 00 00 00 r1 <<=3D 0x3
>          227:       18 02 00 00 a8 00 00 00 00 00 00 00 00 00 00 00 r2 =
=3D 0xa8 ll
>                     0000000000000718:  R_BPF_64_64  .rodata
>          229:       0f 12 00 00 00 00 00 00 r2 +=3D r1
>          230:       79 21 00 00 00 00 00 00 r1 =3D *(u64 *)(r2 + 0x0)
>          231:       0d 01 00 00 00 00 00 00 gotox r1
>          232:       05 00 08 00 00 00 00 00 goto +0x8 <foo+0x88>
>          233:       b7 01 00 00 02 00 00 00 r1 =3D 0x2
>     ;       switch (ctx->x) {
>          234:       05 00 07 00 00 00 00 00 goto +0x7 <foo+0x90>
>          235:       b7 01 00 00 04 00 00 00 r1 =3D 0x4
>     ;               break;
>          236:       05 00 05 00 00 00 00 00 goto +0x5 <foo+0x90>
>          237:       b7 01 00 00 03 00 00 00 r1 =3D 0x3
>     ;               break;
>          238:       05 00 03 00 00 00 00 00 goto +0x3 <foo+0x90>
>          239:       b7 01 00 00 05 00 00 00 r1 =3D 0x5
>     ;               break;
>          240:       05 00 01 00 00 00 00 00 goto +0x1 <foo+0x90>
>          241:       b7 01 00 00 13 00 00 00 r1 =3D 0x13
>          242:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =
=3D 0x0 ll
>                     0000000000000790:  R_BPF_64_64  ret_user
>          244:       7b 12 00 00 00 00 00 00 *(u64 *)(r2 + 0x0) =3D r1
>     ;       return 0;
>          245:       b4 00 00 00 00 00 00 00 w0 =3D 0x0
>          246:       95 00 00 00 00 00 00 00 exit
>=20
> The jump table is
>=20
>     242, 241, 241, 241, 241, 241, 241, 241,
>     241, 241, 241, 237, 241, 241, 241, 241,
>     241, 241, 241, 241, 241, 241, 241, 241,
>     241, 241, 241, 235, 241, 241, 241, 239
>=20
> The check
>=20
>     225:       25 01 0f 00 1f 00 00 00 if r1 > 0x1f goto +0xf <foo+0x88>
>=20
> makes sure that the r1 register is always loaded from the jump table.
> This makes the instruction
>=20
>     232:       05 00 08 00 00 00 00 00 goto +0x8 <foo+0x88>
>=20
> unreachable.
>=20
> Patch verifier to ignore such unreachable JA instructions.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

This should be possible to handle on LLVM side, no need to deal with
it in the kernel.

[...]



