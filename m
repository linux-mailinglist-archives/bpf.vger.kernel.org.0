Return-Path: <bpf+bounces-16109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19C37FCE80
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 06:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609D12834B6
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 05:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415A7462;
	Wed, 29 Nov 2023 05:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuNuh1zf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38E1AE;
	Tue, 28 Nov 2023 21:46:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a03a900956dso100378666b.1;
        Tue, 28 Nov 2023 21:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701236786; x=1701841586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueXoKt71z3XuYUBIRdhazyfZxt2NDv9TI5Vbp/wAPOE=;
        b=RuNuh1zfM82ZNwMY3BcThel4suOHA66vhNXDWJxJJAOmVsT7SiRE3fmQBw2Nv5Z+uH
         R0QvuB0Y6JgMCW0vb0SqpJ1z+gAH4+0hF3/nZ9yZdAYFc5hHAuak9onBpfgakLoJ9vQh
         pO0ssZE0LOXsm5AgJs9P8MJ+L48Ef48DL8kiLN0montLyOkMVVWwx2aNe8Qi9tMqw70i
         fwCe5nk4LPy04CKUZSGWDFlJHgLoimXmxuxqfEnmM/1eDV7PJFHBUGPeKglnjVyxHAmf
         V6JWVQp8wCtV0kMvb/6T554Ad5AHqEV+vanPXjwYC7qFF06SAPBYKAEHr0Vrgv+h/Aru
         zt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701236786; x=1701841586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueXoKt71z3XuYUBIRdhazyfZxt2NDv9TI5Vbp/wAPOE=;
        b=h3SBdHarS5sJ/GoLH9sj3xlE98Niz3CKw1g1+PCGYY+vUWzhZo/T/Zu01s+/X7//uy
         0iw6u8J4ybw2lCFf/NckLJ0vxHYp9T3Sqc65GI1MO1X/qgLFPocZOLicFSo2HaAprA2N
         5O+Rtd6fg6abEIpIGQcN+03Z4SkYdum7icspeLjs2Di3Agbqg+GaU9a0X7cR2FLEnbNi
         MfduBClmh6kDzgdHhnnAFm/bIsRthu+cR/NYE5BwTqcRgGNvX+AJsNzQFdtOb4/0XOjY
         qf1/97HS+0AIlC2e/HNW0oGYELrNTQOdCanldJVn6d56GhtdzQPzqG942XH1dRGfy4J5
         Vudg==
X-Gm-Message-State: AOJu0YxvpRPv8Ucd93aTHU1TeD+ucEzzFV+mL6wcR9Os+AQRu9L4zDXd
	dirDqM832+W1b4M/qieoPoOclRXI35jwo3hZhKs=
X-Google-Smtp-Source: AGHT+IGE+KzPojjTp4Kh+YKhE2d7vQEA73S1tl+4mJLqh6RfLpPO3Xn8jNYQ6NfTYgY+GbROxETn0GD3WWTmxhKNkzM=
X-Received: by 2002:a17:906:2bd1:b0:9e8:2441:5cd4 with SMTP id
 n17-20020a1709062bd100b009e824415cd4mr12413558ejg.17.1701236785791; Tue, 28
 Nov 2023 21:46:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsZ-M=1Yj2PQZM7JN4=9rnDLP36fVO35o9fuAvAMKe=9Nw@mail.gmail.com>
In-Reply-To: <CACkBjsZ-M=1Yj2PQZM7JN4=9rnDLP36fVO35o9fuAvAMKe=9Nw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Nov 2023 21:46:14 -0800
Message-ID: <CAEf4BzYkc-4kk6gVJPY50txLV_5keNkOruJREKMbew7+Qp71YA@mail.gmail.com>
Subject: Re: [Bug Report] bpf: reg invariant voilation after JSET
To: Hao Sun <sunhao.th@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 4:57=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> Hi,
>
> The following program (reduced) breaks reg invariant:
>
> C Repro: https://pastebin.com/raw/FmM9q9D4
>
> -------- Verifier Log --------
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (18) r8 =3D 0x3d                     ; R8_w=3D61
> 2: (85) call bpf_ktime_get_ns#5       ; R0_w=3Dscalar()
> 3: (ce) if w8 s< w0 goto pc+1         ; R0_w=3Dscalar(smax32=3D61) R8_w=
=3D61
> 4: (95) exit
>
> from 3 to 5: R0_w=3Dscalar(smin=3D0x800000000000003e,smax=3D0x7fffffff7ff=
fffff,umin=3Dsmin32=3Dumin32=3D62,umax=3D0xffffffff7fffffff,umax32=3D0x7fff=
ffff,var_off=3D(0x0;
> 0xffffffff7fffffff)) R8_w=3D61 R10=3Dfp0
> 5: R0_w=3Dscalar(smin=3D0x800000000000003e,smax=3D0x7fffffff7fffffff,umin=
=3Dsmin32=3Dumin32=3D62,umax=3D0xffffffff7fffffff,umax32=3D0x7fffffff,var_o=
ff=3D(0x0;
> 0xffffffff7fffffff)) R8_w=3D61 R10=3Dfp0
> 5: (45) if r0 & 0xfffffff7 goto pc+2
> REG INVARIANTS VIOLATION (false_reg1): range bounds violation
> u64=3D[0x3e, 0x8] s64=3D[0x3e, 0x8] u32=3D[0x3e, 0x8] s32=3D[0x3e, 0x8]
> var_off=3D(0x0, 0x8)
> 5: R0_w=3Dscalar(var_off=3D(0x0; 0x8))
> 6: (dd) if r0 s<=3D r8 goto pc+1
> REG INVARIANTS VIOLATION (false_reg1): range bounds violation
> u64=3D[0x0, 0x8] s64=3D[0x3e, 0x8] u32=3D[0x0, 0x8] s32=3D[0x0, 0x8]
> var_off=3D(0x0, 0x8)
> 6: R0_w=3Dscalar(var_off=3D(0x0; 0x8)) R8_w=3D61
> 7: (bc) w1 =3D w0                       ; R0=3Dscalar(var_off=3D(0x0; 0x8=
))
> R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=
=3D(0x0; 0x8))
> 8: (95) exit
>
> from 6 to 8: safe
>
> from 5 to 8: safe
> processed 10 insns (limit 1000000) max_states_per_insn 0 total_states
> 1 peak_states 1 mark_read 1
>
> The tnum after #5 is correct, but the ranges are incorrect, which seems a=
 bug in
> reg_bounds_sync().  Thoughts?
>

It would be great if in addition to reporting the bug and repro
program, you could also try to analyse why this is happening and
suggest fixes in the verifier.

As I mentioned in another email, when we see REG INVARIANTS VIOLATION,
verifier reverts to conservative unknown scalar register state. We
should try to avoid this pessimistic outcome, but generally speaking
it should not be a critical bug.

> Best
> Hao Sun

