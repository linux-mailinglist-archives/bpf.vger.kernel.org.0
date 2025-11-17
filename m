Return-Path: <bpf+bounces-74713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D98C63961
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 11:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD3F64EDE7E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21D2F6189;
	Mon, 17 Nov 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhQ/y9Os"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC827467E
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375420; cv=none; b=TQ51H+nD2epDwieoz8HjJvTVRGVbrgOS6vX9Nzh0iuueZ8IUPbdewnO6E4EJJUQ2+A11ELs7STyWWOHSs7C0Qhfb3fRRSgfhKGfIBPiIcrM//oddYSCNntfz+ek/goq3pP/aCP9no2waHc/FsRBaA49q3B+McwwWB+CTylXK2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375420; c=relaxed/simple;
	bh=SDIhl0Wf5uJy7LMweM1GvOygaJTp2FtmNpW20YBGiCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWuDMCARinRpYrAlGkJhfljasIEHKTAfbH4bDl7SsoSuUMaC2K3RL8betbgx7NtlcgLNPoJzlpoL5kOEmidBMxuBbq/pt0NigFCM3OZ6mnL+SA5UPaW23Dm1/remYuwSm2e3gzAigPRonP7warZPuqv3EY5Rb51hxqCKn3BJQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhQ/y9Os; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso6295285a12.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763375416; x=1763980216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sr7f5N16qvmWUfUsmezCBPyPi6fPqUsa1uGo+ZkQUg=;
        b=QhQ/y9Os/C93MMoFa9/MzfxrL2G2h/3+q//4d1IhV2lEUBbEVfLH6EpU9E3jP/9LKJ
         fI2kjDoV4CPQjQlBO5mZIcoFLzilon+GKN4YiwUTLU3ltKOswoOGqWpAHuU17JXKIONd
         CBB13tUmVnvun8uC1Y2ydpYOdh2XA1DU6oe6Ph0uT64IkYXLIYmTcwAXDzVDePACJJSA
         4YTHkrANfBB2lJcV787AA34Ssy6bZ7PD+zqTvpUpaetv2ldEUl7Hf8CM+4VpRE9Z77d1
         fNrSu89I2D0wl3QYionecIOrqofP1bCBbSW/ekqS0KuzO57lbESyeQnimZyu5avv2cvy
         AFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375416; x=1763980216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Sr7f5N16qvmWUfUsmezCBPyPi6fPqUsa1uGo+ZkQUg=;
        b=WDj9SLua9dcTQOivXWrTbb4MkCvhscua9Fu59WDXNBF1T37HWgoEPuk4r60boJY6Rw
         kvpLVxrDlT4UeIoyd+PuWEWvpV17wQ4npkEmteMrseVSLB9tUPW9tBRbaQ3wxoCUD8ph
         uAo/HS+TtQ41EuESHoZ6KaMqu/UFfru05kAWzMEy/y8JsJBRuztaPPw+raPLL1asyxSJ
         mYWyKmDp3SMW6o4HKXpVx4RFkqS3+UKAfC8ptRVzZq6E91m/Y8j+mWPkhiRfsrx+m22Y
         KDaMxwA8pp5OU6aos4NVNYolKuzAtsh0OUNvh1EGLldvpEcd4q5v+6nNnCFiOptnTnfJ
         U8FA==
X-Gm-Message-State: AOJu0Yy2rWHqILcmG5dMN440Et3/EY3tCq4TMn7SX8pYnpVsGzmMKAw5
	yQhMduoM0exZiuOy5CEwATx53l99dt7SUh48mfqAbFvwWS57zm0GssLWvqXEETJRFEW/YGzHx7t
	fpVDetb1a8pKg7LYAl3QKaQFjjrWFKg==
X-Gm-Gg: ASbGnctCzBkUl0pbv1X/8IPQa5Y2xm6iKOy4vCeQQ3rjpVoxKryXGeiDqBNwu3bBd+/
	WJ1bt6uNO07iETd5ctZoC8Lt6uH6ZjEKPJu2YsBIqiP9n0KLPcGYW/+AmJzG0LPyVP7A6DMpANW
	vlbDxDPp1ho7n6Ok0FHrs7XHgYkxAbD6Jfh0OO9ImN/vEx43hAyjiGjT74aMZmYJ+NwCDuADCwp
	Wxq02gg8dDUepXtWOMSc9ykmChkOFlXXYm8hip6AJE/mqhGkXBLDPeqv2AzKvYyjDDZG5rSVIdl
	TG6Wzixs/PhGDg==
X-Google-Smtp-Source: AGHT+IE5+VyvpJumg2dzIPu6yyk0dBC4e0+1bnkh8uQxLyLzp9Zo/yiSoJYeMRt7217cL7FFfaDemE5UibdWoYZVAc4=
X-Received: by 2002:a05:6402:35d5:b0:640:b31a:8439 with SMTP id
 4fb4d7f45d1cf-64350e2360bmr11041294a12.12.1763375416182; Mon, 17 Nov 2025
 02:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch> <CAADnVQ+AsvqZZOPmga0VsavQNt0Qc4Gbh9+KPSkaxoOsstELxQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+AsvqZZOPmga0VsavQNt0Qc4Gbh9+KPSkaxoOsstELxQ@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Mon, 17 Nov 2025 11:30:04 +0100
X-Gm-Features: AWmQ_bnH9KnHhsR1B1Uoa8mbNqjxptJw4skEM36CG1l8ptxc3b62NuHFA2Sghn4
Message-ID: <CACkBjsauBbmKRAgEhOujtpGBeAWksar9yS+0hk1i9pLYwtQN3A@mail.gmail.com>
Subject: Re: [PATCH RFC 00/17] bpf: Introduce proof-based verifier enhancement
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, Hao Sun <hao.sun@inf.ethz.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:27=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I tried to categorize failures from many of these ~1500
> and lots of them are similar.
>
> In paper you mention 3 examples:
> - ptr + str_pos, with size MAX - str_pos
> - s>>=3D 31
> - &=3D 0xffff
>
> Did you categorize all 1500 failures into categories?
>
> What are the specific gaps in the verifier beyond these 3 cases ?

There are additional patterns beyond the three cases mentioned
earlier. I reviewed
several other object files and their verifier logs, and in some
instances, the root
are insufficient tracking of relationships between registers.

The example below was analyzed manually by me. Let me know if you spot
any mistakes.

clang-15_-O1_felix_bin_bpf_from_wep_debug_v6.o/calico_tc_skb_accepted_entry=
point:
```
...
572: (61) r1 =3D *(u32 *)(r10 -272)     ;
R1=3Dscalar(id=3D70,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D0xfff=
f,var_off=3D(0x0;
0xffff))
573: (54) w1 &=3D 255                   ;
R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=
=3D(0x0;
0xff))
574: (bc) w2 =3D w1                     ;
R1=3Dscalar(id=3D233,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,=
var_off=3D(0x0;
0xff)) R2=3Dscalar(id=3D233,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=
=3D255,var_off=3D(0x0;
0xff))
575: (04) w2 +=3D -4                    ;
R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D251,var_=
off=3D(0x0;
0xffffffff))
576: (a6) if w2 < 0x2 goto pc+130     ;
R2=3Dscalar(smin=3Dumin=3Dumin32=3D2,smax=3Dumax=3D0xffffffff,smin32=3D-4,s=
max32=3D251,var_off=3D(0x0;
0xffffffff))
577: (56) if w1 !=3D 0x0 goto pc+8      ; R1=3D0
578: (61) r1 =3D *(u32 *)(r8 +432)
...
R3 !read_ok
```
From 576 to 577, (w1&255) + -4 >=3D 2, so w1&255 >=3D 6; hence, 577 to 578
is unreachable.

clang-19_-O1_seccomp_x86_bpfel.o/ig_seccomp_e:
```
30: (79) r8 =3D *(u64 *)(r7 +8)         ; R7=3Dctx() R8=3Dscalar()
...
41: (bf) r1 =3D r8                      ; R1=3Dscalar(id=3D2) R8=3Dscalar(i=
d=3D2)
42: (67) r1 <<=3D 32                    ;
R1=3Dscalar(smax=3D0x7fffffff00000000,umax=3D0xffffffff00000000,smin32=3D0,=
smax32=3Dumax32=3D0,var_off=3D(0x0;
0xffffffff00000000))
43: (77) r1 >>=3D 32                    ;
R1=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
44: (25) if r1 > 0x1f3 goto pc+98     ;
R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D499,var_off=
=3D(0x0;
0x1ff))
45: (bf) r1 =3D r10                     ; R1=3Dfp0 R10=3Dfp0
...
139: (57) r8 &=3D 511                   ;
R8=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D511,var_off=
=3D(0x0;
0x1ff))
140: (0f) r0 +=3D r8                    ;
R0=3Dmap_value(map=3Dsyscalls_per_mn,ks=3D8,vs=3D501,smin=3Dsmin32=3D0,smax=
=3Dumax=3Dsmax32=3Dumax32=3D511,var_off=3D(0x0;
0x1ff)) R8=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D511,v=
ar_off=3D(0x0;
0x1ff))
141: (b7) r1 =3D 1                      ; R1=3D1
142: (73) *(u8 *)(r0 +0) =3D r1
invalid access to map value, value_size=3D501 off=3D511 size=3D1
```
From 44 to 45, r1<=3D499; hence, w8<=3D499 After r8&=3D511, the access is s=
afe.
The above cases are hard to address with small improvements to the verifier=
.

I did find lots of similar cases where the imprecision causes were similar.
This is limited by the way we reveal those false rejections (i.e., compile
the same source with different compiler configurations).

clang-17_-O1_felix_bin_bpf_to_l3_debug.o/calico_tc_host_ct_conflict:
```
1899: (63) *(u32 *)(r10 -296) =3D r8    ;
R8=3Dscalar(id=3D56,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,v=
ar_off=3D(0x0;
0xff))
1900: (16) if w8 =3D=3D 0x6 goto pc+1     ;
R8=3Dscalar(id=3D56,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,v=
ar_off=3D(0x0;
0xff))
1901: (b7) r3 =3D 0                     ; R3=3D0
1902: (61) r6 =3D *(u32 *)(r10 -216)    ; R6=3D0 R10=3Dfp0 fp-216=3D????0
1903: (61) r1 =3D *(u32 *)(r10 -296)    ;
R1=3Dscalar(id=3D56,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,v=
ar_off=3D(0x0;
0xff)) R10=3Dfp0 fp-296=3D????scalar(id=3D56,smin=3Dsmin32=3D0,smax=3Dumax=
=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0;
0xff))
...
1907: (56) if w1 !=3D 0x6 goto pc+10    ; R1=3D6
1908: (69) r1 =3D *(u16 *)(r3 +12)
R3 invalid mem access 'scalar'
```
The fact w8!=3D6 (from 1900 to 1901) is not 'remembered', the unreachable p=
ath
(from 1907 to 1908) is mistakenly taken. One possible fix is another
state forking
on the neq path to remember this information and propagate this information=
 to
all the regs and slots that share the same ID. But again, this leads more s=
tates
to explore on neq/eq branches.

Another case that is trivially the same:
clang-15_-O1_felix_bin_bpf_from_hep_dsr_no_log_co-re.o/calico_tc_skb_accept=
ed_entrypoint:
```
262: (56) if w8 !=3D 0x5 goto pc+4 267: R3=3Dscalar(id=3D171,...)
R8=3Dscalar(id=3D171,var_off=3D(0x0; 0xff))
267: (56) if w8 !=3D 0x5 goto pc+16     ; R8=3D5
268: (61) r4 =3D *(u32 *)(r7 +372)      ; unreachable
269: (61) r3 =3D *(u32 *)(r1 +0)
R1 invalid mem access 'scalar'
```

