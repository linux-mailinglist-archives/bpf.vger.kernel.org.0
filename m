Return-Path: <bpf+bounces-38930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565C96C84C
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 22:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A835F1C22A96
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A51482E7;
	Wed,  4 Sep 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfiU0VC7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1501EBFEC;
	Wed,  4 Sep 2024 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481305; cv=none; b=RLlK89JgZIUO126eCOwxyZPa6CY0PkPt7xVGMB6DP+yWAd9h6s6q8DBTOeF5YpkUc8GE5BMBcmnnmmYs4q/cVlBcHNW2ZX6nvXB3egCRbbQ5Mbclplm7JHfRixBc8ysdyB/d+9WBaSCunAhAFIgF2VmZoAd82TeI7DiRsY+BUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481305; c=relaxed/simple;
	bh=/V5r08nqviGI0xJ8/lmKZlxR7GTf4bTmTDPu9w/QN6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sl0Qy+RQeepcond9H8c2NvkCuEei01mA4xeMW12a/za4RRMpWLVP7YR9cqxxskm4LLqmSQZqD6dJLkzCruQxB8o1Ql+n8Kw1Qb+ZZPVJ1def8cPVZuHY6zvM9ovmM3bCjoq4I9EV7ujJvOvLL8k8J39TedWgmfyDpmqRRLqYl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfiU0VC7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d88690837eso3922102a91.2;
        Wed, 04 Sep 2024 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725481303; x=1726086103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khaawNAlNApfnuUFLuoc0b0TKkCbytkfrIkubZTVCdU=;
        b=CfiU0VC7gvEeTyyRf/NoxReYzCJ/uFuBK7rvijst8tNYWzfoyE+CQtWKq1ZXq+sAS0
         VSJHp6pZZkZ5EOwI0sY287IBSo+OCPKZppUa1ZUcx62/OXm7SFhk86qI9ELFYu3a12c3
         n/l5ZckuAkX9BE6rrWcXcrNe6eY7+r1OK2kAelOb4we7JFUYuyayJjrR+m+WbG7EARh4
         o0hLW39CERwgCZvNubSOyWUSjn7lj0OaX68cBdiU9T/vgmUzSpwN02yJCNfbtwUhn64e
         39xJXhmX0FRE+ND+am5TOawzK/N8/GYnolhNG0BjbCGOKxua67uCqpfgw9qanslXdEo1
         5PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481303; x=1726086103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khaawNAlNApfnuUFLuoc0b0TKkCbytkfrIkubZTVCdU=;
        b=biKoJEibsR5wOhoFii27tQbUYTamMmMc/w2rpMFMxoHySfKd2RuXdFX4k8kfhJei1m
         5VL1sMI7VwZhwQeEOUZEe8ooe204qJPVo2uh35eqOtsou93esnT3zSGs4l0uuzrI6l4X
         UgUxyE0HYy/t+L/XtftEO43+htSEE5AxUPvVe5LAOCiKmDCrT3HxyROmqmtp0uuLwmN5
         fz2Z6Gqj6z7iu4XgzwsGMbx6D5o4gnBFqXOCABpUawbus5X4jvyyto1a6WiSb1mX6GCm
         AlC42LEN0j301ViWRtBOntQWscn3tLc6oDuMQhHSGhzajX3BisUR78x12OY9ED3z2PHk
         VMdg==
X-Forwarded-Encrypted: i=1; AJvYcCVC+UMyFtESm5wDIJyAqHQ9pYfKcy+3fIER5B/quyvHR8cOOIKNHAln/O0L2rHEIY1IQ+ejzxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAdEVQx1yxgcxjf+LqtdS+Q0Ty2YQZNO5B1kVXPQvtUbF3zXr
	6WvoliouHi4u3YBOhLxfX4h2A70jL3JqbImgW8yAIJjNEzJIUofqikwukZ6R81dRbF2SIFEoJ/h
	rUE8QtRKfS1PJZ2lqoayFDf3dI1w=
X-Google-Smtp-Source: AGHT+IF9SbM3MOIJjbovhN7aSna5YGP1BzRSyOgc8SIrN2g92tsPxLrKWU2/j+vTpIf1Dn92253znctT3vuuLYUUxhA=
X-Received: by 2002:a17:90a:eb0f:b0:2d8:8138:fa11 with SMTP id
 98e67ed59e1d1-2da6344d3d4mr7316870a91.37.1725481303365; Wed, 04 Sep 2024
 13:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831041934.1629216-1-pulehui@huaweicloud.com> <20240831041934.1629216-4-pulehui@huaweicloud.com>
In-Reply-To: <20240831041934.1629216-4-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 13:21:31 -0700
Message-ID: <CAEf4BzZ3Sya=OoLhSzoYFif_cPr7sqOchjM7enoLeV4=2PXdGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Enable test_bpf_syscall_macro:syscall_arg1
 on s390 and arm64
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	netdev@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 9:17=E2=80=AFPM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> Considering that CO-RE direct read access to the first system call
> argument is already available on s390 and arm64, let's enable
> test_bpf_syscall_macro:syscall_arg1 on these architectures.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  .../testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c | 4 ----
>  tools/testing/selftests/bpf/progs/bpf_syscall_macro.c         | 2 --
>  2 files changed, 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macr=
o.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> index 2900c5e9a016..1750c29b94f8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> @@ -38,11 +38,7 @@ void test_bpf_syscall_macro(void)
>         /* check whether args of syscall are copied correctly */
>         prctl(exp_arg1, exp_arg2, exp_arg3, exp_arg4, exp_arg5);
>
> -#if defined(__aarch64__) || defined(__s390__)
> -       ASSERT_NEQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
> -#else
>         ASSERT_EQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
> -#endif
>         ASSERT_EQ(skel->bss->arg2, exp_arg2, "syscall_arg2");
>         ASSERT_EQ(skel->bss->arg3, exp_arg3, "syscall_arg3");
>         /* it cannot copy arg4 when uses PT_REGS_PARM4 on x86_64 */
> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tool=
s/testing/selftests/bpf/progs/bpf_syscall_macro.c
> index 1a476d8ed354..9e7d9674ce2a 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> @@ -43,9 +43,7 @@ int BPF_KPROBE(handle_sys_prctl)
>
>         /* test for PT_REGS_PARM */
>
> -#if !defined(bpf_target_arm64) && !defined(bpf_target_s390)
>         bpf_probe_read_kernel(&tmp, sizeof(tmp), &PT_REGS_PARM1_SYSCALL(r=
eal_regs));
> -#endif
>         arg1 =3D tmp;

There is no point in having tmp variable now, I cleaned that up as well


>         bpf_probe_read_kernel(&arg2, sizeof(arg2), &PT_REGS_PARM2_SYSCALL=
(real_regs));
>         bpf_probe_read_kernel(&arg3, sizeof(arg3), &PT_REGS_PARM3_SYSCALL=
(real_regs));
> --
> 2.34.1
>

