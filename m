Return-Path: <bpf+bounces-13616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3317DBEA3
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 18:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DD92815D4
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711D19467;
	Mon, 30 Oct 2023 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlPsfo6v"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1C15EA1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 17:17:26 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E7ABD
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:17:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso3272057f8f.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686242; x=1699291042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xCPYdOEerxLBOv9ORUYRFtApw/deOLu2qd8YpeIQWA=;
        b=PlPsfo6vpOw9kaTkpsZk0WaU8RALRzZn/B+DuLkSlg8ZIlix+XIAi+bMggsgCd4qV3
         t6G+0tAz2yqnMCjZlb7q7HC6Qn3ULzKvEXvXcFheJrCgFtGvx/D1yJYs7WzXMTPeMhgw
         xXuXSu9S3hVPp6aM4VoXbh3lDUcf5toURIXzkDs7NXmxTn8h34VDNXO4s4B+Y+S6SVYr
         YnyPVgQXKwew7z38/23lp7FXPW3Qt8uW3v2wH0spaPAgliZQb1V9iHFte9zX8gs/Dj0s
         yhY+LkzX9+luKhRzomfZFlwPWaxkbjr4ZCDjMm/+6x6XRfWP7no9qyebGU0bijbCE3Ez
         pFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686242; x=1699291042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xCPYdOEerxLBOv9ORUYRFtApw/deOLu2qd8YpeIQWA=;
        b=aSPBLzUTu828CLxlYr3Fxq5JgQXyjXO+47mGyrEQauvEtBpiueaUl9LFuB7qJRBvCF
         fnikYfBRasfG+06LFrCdYsECG+JTkUcD9MrDYV+Cqki/Nz1GwCaUknAL08TsinPLsGxf
         dlMWAHIQSENirAA4nWLGyPniI2VJ5xeDjW/s17iYTLSSN15ucO+OCYXCbPAmSKA5xt4/
         4iLPe4d8wSkQI5r2dxGWLepURFLLP76TYfx27hVcURB5Pv4RkRrRxtTJPJI1DlAmGz5k
         LAMbvAwZJDya+Tx48WqSnD9+KBALRBvbk4tEAW7XPPbPpMatuBTQ5fz9n0XJOcLgHl6i
         aObQ==
X-Gm-Message-State: AOJu0YzFwHEv3ti/Ck0HarRyWaiuf7ej5J/cmNsZK4+Hg19z8EcFOvdy
	DCTzFLG3gAvhdIy86aFZ3Gh7mAL/UHzyKTpPhHw=
X-Google-Smtp-Source: AGHT+IHKBQrX7kMKBYCiaXmU276FjF7V9koDxUp7jjdPcJtZL5f7YQy2sahFWnp+/ch3Dj1kVpJJrKYDN0Yp3O20evM=
X-Received: by 2002:adf:ef02:0:b0:32d:8220:8991 with SMTP id
 e2-20020adfef02000000b0032d82208991mr8665650wro.8.1698686241699; Mon, 30 Oct
 2023 10:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030132145.20867-1-shung-hsi.yu@suse.com> <20231030132145.20867-3-shung-hsi.yu@suse.com>
 <905f4ae9a5d9fe1a030d7e7442e980e9d49e00b9.camel@gmail.com>
In-Reply-To: <905f4ae9a5d9fe1a030d7e7442e980e9d49e00b9.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Oct 2023 10:17:10 -0700
Message-ID: <CAADnVQKF6G2au4QPNwxyxNBLTvzhJpADYxKeYMjPg3wA1jJNAA@mail.gmail.com>
Subject: Re: [RFC bpf 2/2] selftests/bpf: precision tracking test for BPF_ALU
 | BPF_TO_BE | BPF_END
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andriin@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 7:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-10-30 at 21:21 +0800, Shung-Hsi Yu wrote:
> > Add a test written with inline assembly to check that the verifier does
> > not incorrecly use the src_reg field of a BPF_ALU | BPF_TO_BE | BPF_END
> > instruction.
> >
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> >
> > This is the first time I'm writing a selftest so there's a lot of
> > question I can't answer myself. Looking for suggestions regarding:
> >
> > 1. Whether BPF_NEG and other BPF_END cases should be tested as well
>
> It is probably good to test BPF_NEG, unfortunately verifier does not
> track range information for BPF_NEG, so I ended up with the following
> contraption:

Makes sense to me.

> SEC("?raw_tp")
> __success __log_level(2)
> __msg("mark_precise: frame0: regs=3Dr2 stack=3D before 3: (bf) r1 =3D r10=
")
> __msg("mark_precise: frame0: regs=3Dr2 stack=3D before 2: (55) if r2 !=3D=
 0xfffffff8 goto pc+2")
> __msg("mark_precise: frame0: regs=3Dr2 stack=3D before 1: (87) r2 =3D -r2=
")
> __msg("mark_precise: frame0: regs=3Dr2 stack=3D before 0: (b7) r2 =3D 8")
> __naked int bpf_neg(void)
> {
>         asm volatile (
>                 "r2 =3D 8;"
>                 "r2 =3D -r2;"
>                 "if r2 !=3D -8 goto 1f;"
>                 "r1 =3D r10;"
>                 "r1 +=3D r2;"
>         "1:"
>                 "r0 =3D 0;"
>                 "exit;"
>                 ::: __clobber_all);
> }
>
> Also, maybe it's good to test bswap version of BPF_END (CPU v4
> instruction) for completeness, e.g. as follows:
>
> #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
>         defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
>         __clang_major__ >=3D 18
>
> ...
>                 "r2 =3D bswap16 r2;"

+1. Let's have a test for this one as well.

> ...
>
> #endif
>
>
> > 2. While the suggested way of writing BPF assembly is with inline
> >    assembly[0], as done here, maybe it is better to have this test case
> >    added in verifier/precise.c and written using macro instead?
> >    The rational is that ideally we want the selftest to be backport to
> >    the v5.3+ stable kernels alongside the fix, but __msg macro used her=
e
> >    is only available since v6.2.
>
> As far as I understand we want to have new tests written in assembly,
> but let's wait for Alexei or Andrii to comment.

Backports is not a reason to use macros.
Please continue with inline asm.

