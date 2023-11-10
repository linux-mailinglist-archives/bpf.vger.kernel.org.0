Return-Path: <bpf+bounces-14670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9F7E7699
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F39B20EF4
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BC7FE;
	Fri, 10 Nov 2023 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh/SIXf+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F7EA0
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:34:14 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC12425B8
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:34:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso10658135e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 17:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699580052; x=1700184852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeMTjdbb8PVsPenNASkJho61cJ16lTaGiYXQhulNuKQ=;
        b=Lh/SIXf+qlu0Wl/rpLir+Q/Y/LpuvJNbYCduXMYNiC2WWBfbBNaP5y87WcP0vGTXUd
         DT5LBMzcPUBFbyd37Z5dzra96MZkp8uJDmUawPvpJNi50VbozW72W0E5yxOeGJtybDrj
         gnSosCq2veRmbeDot6wd4Aq8zdqCuSMp32pi6A6CJM/UeRWOFuYwXdzGpLp/0LgmnYpz
         K4iYFCX2Uml0XggqQOm5YIRwHvCfc9m23uaVZsBZ8vUjUrNwspdlEUm+IxOaEjTbovXh
         h7IoufALCOPM3S1LVoxmlg06Rm8c5rC3n+5lEwxKz6iJGxJUgwfMFNpBM8x0CJBGqGjk
         keLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699580052; x=1700184852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeMTjdbb8PVsPenNASkJho61cJ16lTaGiYXQhulNuKQ=;
        b=M3DFyqRH1R0TSRvXZyFHH4DzskhQjKldRx629pgnpxS36QTam0TwHNWXQ45IW2amHg
         I8HYfy8YubxEqBNeLbbNM5MjcC92nIoyR3pAcZsLEC+bVXqEe2vc/ilDWKTgB/woUn6i
         LTVwyw++v64iM49A5n1jtAn5Q/lVXxYJHnvurbsC9KIBLcAMMntXAEE/0UT2rseZOTlg
         hkzNt9gTMhqcfhvqDUMVJFD51e83cTARnNiYS4vhAT6uts6gnBcQ4W8t1wxHkmYZklYl
         UQj1P1r0QeIybrj6nyylstTjY/YR8aNDe5ArIGzyn7y5Mcen5YnivYJVL9mNEXnQVwgw
         71qA==
X-Gm-Message-State: AOJu0Yw9D/Beb1NgCqiXsBhclRhuIvO7RiXejlkJvXzbWMmordbtcxNH
	DZEeWEVtkkMRxL+O+AXVVSodrJC209MehxzxDWg=
X-Google-Smtp-Source: AGHT+IHwP4gL+nb7Rqm9ClGsSZT75Gzgf2nZ9XyBTSCs9S7IM+rD7lnXwiZgj2oZiU13lEVhIN1OG+NlLR2GxiLkyNE=
X-Received: by 2002:a5d:4b86:0:b0:32f:a6fe:9c00 with SMTP id
 b6-20020a5d4b86000000b0032fa6fe9c00mr4991997wrt.35.1699580051923; Thu, 09 Nov
 2023 17:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110002638.4168352-1-andrii@kernel.org> <20231110002638.4168352-4-andrii@kernel.org>
In-Reply-To: <20231110002638.4168352-4-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 17:34:00 -0800
Message-ID: <CAADnVQ+KtueBdD=8DazMhM3Xz0+YpLVW1-5-N4ZFiBOzji4vbg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] selftests/bpf: add edge case backtracking
 logic test
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 4:26=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Add a dedicated selftests to try to set up conditions to have a state
> with same first and last instruction index, but it actually is a loop
> 3->4->1->2->3. This confuses mark_chain_precision() if verifier doesn't
> take into account jump history.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/progs/verifier_precision.c  | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/too=
ls/testing/selftests/bpf/progs/verifier_precision.c
> index 193c0f8272d0..6b564d4c0986 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> @@ -91,3 +91,43 @@ __naked int bpf_end_bswap(void)
>  }
>
>  #endif /* v4 instruction */
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +/*
> + * Without the bug fix there will be no history between "last_idx 3 firs=
t_idx 3"
> + * and "parent state regs=3D" lines. "R0_w=3D6" parts are here to help a=
nchor
> + * expected log messages to the one specific mark_chain_precision operat=
ion.
> + *
> + * This is quite fragile: if verifier checkpointing heuristic changes, t=
his
> + * might need adjusting.

Hmm, but that what
__flag(BPF_F_TEST_STATE_FREQ)
supposed to address.

> + */
> +__msg("2: (07) r0 +=3D 1                       ; R0_w=3D6")
> +__msg("3: (35) if r0 >=3D 0xa goto pc+1")
> +__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 2: (07) r0 +=3D 1=
")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 1: (07) r0 +=3D 1=
")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 4: (05) goto pc-4=
")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 3: (35) if r0 >=
=3D 0xa goto pc+1")
> +__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R0_rw=3DP4"=
)
> +__msg("3: R0_w=3D6")
> +__naked int state_loop_first_last_equal(void)
> +{
> +       asm volatile (
> +               "r0 =3D 0;"
> +       "l0_%=3D:"
> +               "r0 +=3D 1;"
> +               "r0 +=3D 1;"

That's why you had two ++ ?
Add state_freq and remove one of them?

