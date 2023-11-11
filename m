Return-Path: <bpf+bounces-14813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30B7E86EC
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 01:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B395128129C
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D501396;
	Sat, 11 Nov 2023 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEgR0Nb8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483B1FC4
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 00:31:54 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C03C39
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:31:52 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9df8d0c2505so532696866b.0
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699662710; x=1700267510; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xT/EynJ9zSa/R2WA9MMlRRNEr1j5IH7T/B6VNVvpAi8=;
        b=lEgR0Nb8ulsqe+V69io+exc6YAsI25R+NJFkCOxlolVj3QEBezM6gbhrCv63p5FoZo
         48JjwSHznzu9gZCS1tQwOZBHXS8+rORcI0Gu5nss6/YNG3rOYMGT0Hi3Y/yOsZUwZCll
         mTAwxt9X1c9GrjJ6DkhHb9HmHqvIuFaup6KWKd+7nw4SQpv+tXbxhlUNR5PM1PwYgran
         TyxWgjLBO9wvy2Nc7GaHEJlBw54IwIAScYkMKbARP25im8hP34GrQiETGCogDLWG7v8A
         AouoVBnjigAQXhaNmG3DZ+UCnR2zOTgTSIYiAiD36sYQ583xu6T0flvo0B9c/QJH3HrU
         lDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662710; x=1700267510;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xT/EynJ9zSa/R2WA9MMlRRNEr1j5IH7T/B6VNVvpAi8=;
        b=XeY0elk2IUywY0hCjYgSLHGzZtIZYxihiiiJtTtOspgyjg50ukdbYfAldpKhSKu7G0
         sGHQfYtPNWbyC7ufFoSoTT0YPfZRBIWZ/zS/hNYEqJIG3dzu00jw9aeRLjAbCptYwc3P
         VkOemWKqXR1QEgf1xyXZC5iHruJYdoYL6D1OQuOsLpO4l1npK+4ddwMLInd2vGB+I+S3
         9LgoLlAdLyr7LrnjvTb44uvWT9kEU9YEa6yWbHWDjMBjfVY3P6eVE9G4OQXrWBCz3fzJ
         hBrbIdj2gSkWRgGopeUFFZrA/5YoyoS80Udc6doGy2QUfpRZ9OhihJLEWir3uBQc7k5m
         D/Nw==
X-Gm-Message-State: AOJu0Yx3M2jT5CVBo6TJlZguXuwHgsAlpyWebVKxS2zpvEeEnZHO9uVz
	9a2GzfYdlCKGaTdJoh9z5/g=
X-Google-Smtp-Source: AGHT+IFjhfgyNtIzbhaACtxD7AT2Xeu0j76g3duuiRXvXDz5eLGzrYk4Sn9ca+N39B3pw0qXG1u0AA==
X-Received: by 2002:a17:906:f8cc:b0:9ad:e62c:4517 with SMTP id lh12-20020a170906f8cc00b009ade62c4517mr3622207ejb.34.1699662710451;
        Fri, 10 Nov 2023 16:31:50 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id kg4-20020a17090776e400b009e5e4ff01d4sm250218ejc.129.2023.11.10.16.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:31:49 -0800 (PST)
Message-ID: <eb9793e4681473fd809c031b046c9cba8a5d3b80.camel@gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf: print spilled register state in stack
 slot
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Sat, 11 Nov 2023 02:31:48 +0200
In-Reply-To: <20231110161057.1943534-5-andrii@kernel.org>
References: <20231110161057.1943534-1-andrii@kernel.org>
	 <20231110161057.1943534-5-andrii@kernel.org>
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

On Fri, 2023-11-10 at 08:10 -0800, Andrii Nakryiko wrote:
> Print the same register state representation when printing stack state,
> as we do for normal registers. Note that if stack slot contains
> subregister spill (1, 2, or 4 byte long), we'll still emit "m0?" mask
> for those bytes that are not part of spilled register.
>=20
> While means we can get something like fp-8=3D0000scalar() for a 4-byte
> spill with other 4 bytes still being STACK_ZERO.
>=20
> Some example before and after, taken from the log of
> pyperf_subprogs.bpf.o:
>=20
> 49: (7b) *(u64 *)(r10 -256) =3D r1      ; frame1: R1_w=3Dctx(off=3D0,imm=
=3D0) R10=3Dfp0 fp-256_w=3Dctx
> 49: (7b) *(u64 *)(r10 -256) =3D r1      ; frame1: R1_w=3Dctx(off=3D0,imm=
=3D0) R10=3Dfp0 fp-256_w=3Dctx(off=3D0,imm=3D0)
>=20
> 150: (7b) *(u64 *)(r10 -264) =3D r0     ; frame1: R0_w=3Dmap_value_or_nul=
l(id=3D6,off=3D0,ks=3D192,vs=3D4,imm=3D0) R10=3Dfp0 fp-264_w=3Dmap_value_or=
_null
> 150: (7b) *(u64 *)(r10 -264) =3D r0     ; frame1: R0_w=3Dmap_value_or_nul=
l(id=3D6,off=3D0,ks=3D192,vs=3D4,imm=3D0) R10=3Dfp0 fp-264_w=3Dmap_value_or=
_null(id=3D6,off=3D0,ks=3D192,vs=3D4,imm=3D0)
>=20
> 5192: (61) r1 =3D *(u32 *)(r10 -272)    ; frame1: R1_w=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf)) R10=3Dfp0=
 fp-272=3D
> 5192: (61) r1 =3D *(u32 *)(r10 -272)    ; frame1: R1_w=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf)) R10=3Dfp0=
 fp-272=3D????scalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,v=
ar_off=3D(0x0; 0xf))
>=20
> While at it, do a few other simple clean ups:
>   - skip slot if it's not scratched before detecting whether it's valid;
>   - move taking spilled_reg pointer outside of switch (only DYNPTR has
>     to adjust that to get to the "main" slot);
>   - don't recalculate types_buf second time for MISC/ZERO/default case.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

This is great!

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

