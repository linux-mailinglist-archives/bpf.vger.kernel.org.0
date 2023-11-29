Return-Path: <bpf+bounces-16108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0703C7FCE6C
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2EFB2169D
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 05:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A86FD5;
	Wed, 29 Nov 2023 05:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1Wh97wm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB411AE;
	Tue, 28 Nov 2023 21:43:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bc57d81f4so263848e87.2;
        Tue, 28 Nov 2023 21:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701236586; x=1701841386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ah39K3mdJLfvpMeUTfIZFBYmO5pc4KH9lUCedS23RE=;
        b=B1Wh97wmNPILD3CtS3iZPuvQFKGiKTg+d1RNeQFwA4wE80A10nuyYwtJjvA602X2Nw
         VSqxa6SslhQdUnYhVd2pfwHRkXxXqEfFldnEhkScGrYS0KAqfvezEUUwEetgCxoNCaop
         Z5YtP6P+PLYeXr36LfAMoo7fZnSIy/pgUxXNOp8AzDV6qf4mw8ma9ZAlol0l0UhxVCZG
         2ayK//sLKOX3OGvt8ADkA2Bt2d2kAS0LRLpUYLCQwroHvEXdUsmftcBU6xzW6d5FtEBL
         1PJG8g20CJc+rcAcYyOp3FNwdxqo7pbVkkHI0ynY9a/dw9eSpgNsmduHIpOMic9yokyy
         9Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701236586; x=1701841386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ah39K3mdJLfvpMeUTfIZFBYmO5pc4KH9lUCedS23RE=;
        b=UYtAZFCCmYk52WSzZRsB6iu4/6dFZ3F6+QdUgbeXLy9Wvwy+Nyvv8DcxIitJwWAQWd
         XmS8Mm6ftLZLUkouoNYxV4iiSSmRZ5SFBgx7PnBjjiSmiq0n0yB12gnaGLlfOV0KUlK1
         0fizJyX6XmcvRmfoPsHzD0ZmHpMgjg505G9wSx22wvh300BxGjPKw2CqIYrkO3PV69I8
         dPVbR7mTaYErcZ9JPcwv4d9ZGjISM7gMv/xoWk2PhDftP60txYKAqgSOfV4ZVrl4QJkV
         +80v3tzYDsPqQI/QbmOTRojPiPl6UUytfumAHiDIcdYr4mDuEZUBBkT/4mixiPK2HjaO
         Bikg==
X-Gm-Message-State: AOJu0YwewKHW4mEa8W77ujPhpSG7aG0qzYzuNaqgCiiqDM8LRl10fiHX
	YJNZ4Su2ht91gZiCWxFaIlne2fXfjVG9344nkECcyKBp
X-Google-Smtp-Source: AGHT+IEZsOIEr+ZZtGiGO5Lcgph5Yo+42Yr9Bs/pLXV33SmYqod3gAwKCxRCsRuaITB+u/VoWbEW6eJSyuKVojC7M10=
X-Received: by 2002:a05:6512:108c:b0:507:9f4c:b72 with SMTP id
 j12-20020a056512108c00b005079f4c0b72mr13521196lfg.15.1701236586282; Tue, 28
 Nov 2023 21:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsaecr+VjmfOHzaMbiei5G3WMDjvjp4kZVE79Bn8ib1-Rg@mail.gmail.com>
In-Reply-To: <CACkBjsaecr+VjmfOHzaMbiei5G3WMDjvjp4kZVE79Bn8ib1-Rg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Nov 2023 21:42:52 -0800
Message-ID: <CAEf4BzYVRwpP6TbXdJeFwMot80FodexyOk2_Y9H2tsJC-3FBUA@mail.gmail.com>
Subject: Re: [Bug Report] bpf: reg invariant voilation after JSLE
To: Hao Sun <sunhao.th@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 7:08=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> Hi,
>
> The following program (reduced) breaks reg invariant:
>
> C Repro: https://pastebin.com/raw/SRQJYx91
>
> -------- Verifier Log --------
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (b7) r0 =3D -2                       ; R0_w=3D-2
> 1: (37) r0 /=3D 1                       ; R0_w=3Dscalar()
> 2: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3Dsc=
alar(id=3D1)
> 3: (56) if w8 !=3D 0xfffffffe goto pc+4         ;
> R8_w=3Dscalar(id=3D1,smin=3D0x80000000fffffffe,smax=3D0x7ffffffffffffffe,=
umin=3Dumin32=3D0xfffffffe,umax=3D0xfffffffffffffffe,smin32=3D-2,smax32=3D-=
2,umax32=3D0xfffffffe,var_off=3D(0xfffffffe;
> 0xffffffff00000000))

this part looks suspicious, I'll take a look a bit later

> 4: (65) if r8 s> 0xd goto pc+3        ;
> R8_w=3Dscalar(id=3D1,smin=3D0x80000000fffffffe,smax=3D13,umin=3Dumin32=3D=
0xfffffffe,umax=3D0xfffffffffffffffe,smin32=3D-2,smax32=3D-2,umax32=3D0xfff=
ffffe,var_off=3D(0xfffffffe;
> 0xffffffff00000000))
> 5: (b7) r4 =3D 2                        ; R4_w=3D2
> 6: (dd) if r8 s<=3D r4 goto pc+1
> REG INVARIANTS VIOLATION (false_reg1): range bounds violation
> u64=3D[0xfffffffe, 0xd] s64=3D[0xfffffffe, 0xd] u32=3D[0xfffffffe, 0xd]
> s32=3D[0x3, 0xfffffffe] var_off=3D(0xfffffffe, 0x0)
> 6: R4_w=3D2 R8_w=3D0xfffffffe
> 7: (cc) w8 s>>=3D w0                    ; R0=3D0xfffffffe R8=3Dscalar()
> 8: (77) r0 >>=3D 32                     ; R0_w=3D0
> 9: (57) r0 &=3D 1                       ; R0_w=3D0
> 10: (95) exit
>
> from 6 to 8: safe
>
> from 4 to 8: safe
>
> from 3 to 8: safe
> processed 14 insns (limit 1000000) max_states_per_insn 0 total_states
> 1 peak_states 1 mark_read 1
>
>
> Besides, the verifier enforces the return value of some prog types to
> be zero, the bug may lead to programs with arbitrary values loaded.

Generally speaking, if the verifier reports "REG INVARIANTS VIOLATION"
warning above, it doesn't necessarily mean that verifier has some bug.
We do know that in some conditions verifier doesn't detect conditions
that *will not* be taken, and in such cases we might get reg
invariants violation. But in such case verifier will revert to
conservative unknown scalar state, which is correct, even if
potentially unnecessarily pessimistic.

>
> Best
> Hao Sun

