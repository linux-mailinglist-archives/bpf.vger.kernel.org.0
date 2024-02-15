Return-Path: <bpf+bounces-22047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543A8558EF
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BFE1F273FD
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0654F1C02;
	Thu, 15 Feb 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gha67BRR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D4184E
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707963631; cv=none; b=kU8dwHJdi8Od5SZgxbJEm7tUqzkBbaZeyjvfHucOeuVVQbmYaxYv9Tm5WvoPxlwseCB8UDtrnv+pbbg1T4DCvio+SMqT77dMz8x4PbejuPjDc1029QyetE1kB2FtfPIK8lOE9gNDXBC4MdydkKi+ksIyveFpIlWIGDI5c/YE0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707963631; c=relaxed/simple;
	bh=FavmSHr2iG3fa7K0DeXM8ELS6TgJurlOvmHpsGLyo+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn1/KkH+MArUrGbFpc0jliWVcIG/mCDNHAHVQJHFLN8EbS1+t+5NbfKi8idgjeLIEcj1Y1Luj3ZAAe7VeocM8eT0+NEbfxZaMN1wuc4GY9vc0LTWIU0wdAmvlTYjjsZcHiPClyDsjZmfVc5SN3c2ZXkV9lGYO6J5L4tvgTCxNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gha67BRR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41166710058so2825715e9.3
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 18:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707963628; x=1708568428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L+XCIpjEtNHCPHxkgAtIeXamKlXpltaUMh7ZfIgb14=;
        b=gha67BRRXoPfZuxBOF5IzBI11YgwxAdaGS93qN5GZ1tz6LbK40+28bxH8dTFNMCvfg
         VIAO2gUJzgCVLj1vz4Dh3a6jtqIJslOVqx+OC0Hr6W6FGu5zMBqOH26bkfX1LIDi5Mui
         K79rNeBp4wYJ6SPfHYrGT+GmZUf4bvlDddMpSlQLDaAFMg0xUz8PLGmP61ff15Uluh8y
         u0UXaEGK5JZtQsvc7LCZ32renSK8XchrkFmw5eBYUYvjTwmTXYa2MbPyUvW/3OwW8TiC
         GpBhEC8+cdPgb0akFhB36oMl/EIiypYABGsYnAyUD2TR/+cQ88Y8EclwysVNn02kZITB
         x/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707963628; x=1708568428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6L+XCIpjEtNHCPHxkgAtIeXamKlXpltaUMh7ZfIgb14=;
        b=iZls1g1hhLfRvlD2g5SgaeHWng578iJIXyBan+zd9R+wKaQJYJmB7U/KcWBxHHCtAl
         +rYrPquvh17oOKFIB1pJAC8NQge2lqq+NGCDp+GR9QK0RMcxkcWU33RZ3ejvr/i6oyxE
         coyYKq5jN78LIsUWkeDluXeUIXs8GntbwmmyDBjrT2lF7tt+XdYkIX9XEKiVc59F84/f
         Saf+HoLgPAirW935q1xoY69ZpdX4qzsV2CBwqHgJrMTyV/TCpX2+ujD3NtFbsBr1FX14
         PIpWvrDtNUVPFTbkm79cEau4VzwozCjRlam75NxPw7UNCYbtw039FoQvVfDw07g4ZNfk
         +Sqg==
X-Gm-Message-State: AOJu0Yw6h0GaVRiwpDM4smwzvXyImT/RYEUcamXInWxjuAu2mk1q270v
	mtJT9m9sLj/FPMC3QBtshP+iKrwGrz3uimS340G52GLL835L/vk5FqAFG1esM6bTji9G55l67Hs
	Tzvnstw7OrqW9X4mK/iyN1edVxkSN7QbE
X-Google-Smtp-Source: AGHT+IGHhNEMaFLNFx6dplMdbI1il3onr46qkyeGlykwEI/1TcoSciiTdKPdbtmagZK0yGwH4rsCyZMhUB5UoKdO2lg=
X-Received: by 2002:a5d:6e56:0:b0:33a:f798:bfa with SMTP id
 j22-20020a5d6e56000000b0033af7980bfamr309897wrz.64.1707963627926; Wed, 14 Feb
 2024 18:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a15f6a20-c902-4057-a1a9-8259a225bb8b@linux.dev>
In-Reply-To: <a15f6a20-c902-4057-a1a9-8259a225bb8b@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Feb 2024 18:20:16 -0800
Message-ID: <CAADnVQJwN_NvjM2121urjutY3FqtzHxNWyGPWQzyzhCmFmDDzQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Segmented Stacks for BPF Programs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, David Vernet <void@manifault.com>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:53=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> For each active kernel thread, the thread stack size is 2*PAGE_SIZE ([1])=
.
> Each bpf program has a maximum stack size 512 bytes to avoid
> overflowing the thread stack. But nested bpf programs may post
> a challenge to avoid stack overflow.
>
> For example, currently we already allow nested bpf
> programs esp in tracing, i.e.,
>    Prog_A
>      -> Call Helper_B
>        -> Call Func_C
>          -> fentry program is called due to Func_C.
>            -> Call Helper_D and then Func_E
>              -> fentry due to Func_E
>                -> ...
> If we have too many bpf programs in the chain and each bpf program
> has close to 512 byte stack size, it could overflow the kernel thread
> stack.
>
> Another more practical potential use case is from a discussion between
> Alexei and Tejun. It is possible for a complex scheduler like sched-ext,
> we could have BPF prog hierarchy like below:
>                         Prog_1 (at system level)
>            Prog_Numa_1    Prog_Numa_2 ...  Prog_Numa_4
>         Prog_LLC_1 Prog_LLC_2 ...
>       Prog_CPU_1 ...
>
> Basically, the top bpf program (Prog_1) will call Prog_Numa_* programs
>
> through a kfunc to collect information from programs in each numa node.
> Each Prog_Numa_* program will call Prog_LLC_* programs to collect
> information from programs in each llc domain in that particular
> numa node, etc. The same for Prog_LLC_* vs. Prog_CPU_*.
> Now we have four level nested bpf programs.
>
> The proposed approach is to allocate stack from heap for
> each bpf program. That way, we do not need to worry about
> kernel stack overflow. Such an approach is called
> segmented stacks ([2]) in clang/gcc/go etc.
>
> Obviously there are some drawbacks for segmented stack approach:
>   - some performance degradation, so this approach may not for everyone.
>   - stack backtracking,  kernel changes are necessary.

I suspect segmented stacks the way compilers do them are not suitable
for bpf progs, since they break backtraces and backtrace is a crucial
feature that must work even when there are kernel bugs.
How about we keep call/ret, save/restore of callee saved regs
in the normal stack, but use a parallel memory (per-cpu or some other)
for bpf prog needs. What bpf prog thinks of stack will be in that memory
while the call chain will remain correct.
From bpf prog pov the stack is where bpf_reg_r10 points to.
It doesn't have to be in the kernel stack. Shadow memory will work.

Let's also call it something else than "segmented stack" to avoid
confusion.

