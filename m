Return-Path: <bpf+bounces-76957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F2CCA1C1
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 03:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA98D30487F5
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2775F2459D4;
	Thu, 18 Dec 2025 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfIwVztm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EC3BB44
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026367; cv=none; b=Ml22OamLdSffwy4dCN/TLgMzmKSnovExCTS0zQTQOoFSCvQHf6PVCFfFYe6IQBwoBJBWlGdyb/N1V6+uJIs/+WlIrbGO7RbCwffxwslcQFtkssrAbrnoOuNMQdDN39X10nAkJy6bYYXru/Ahxkl/VBOldeLYDVqMRXxBHKhpfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026367; c=relaxed/simple;
	bh=KH2ko3GSTkVwZLREXfQKQzEQFLKa9SM2v6rJm6U/U4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge9gsim3YUKehFlR2mlibibE/QeOy/zTZQG9l6QW9PeaGYLd9cSgr0hLvpDE+Fag94DqFmNOjmg/HkTSN4yXzr4MmZ/N+0xz6Cdrqq1Q7eE+oCb7g9b8P0EQ87kUlCsQX8KVdI3nSLGqSPo75R2dq+KNWR9+p8Y6hc52HfFPWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfIwVztm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2758AC2BC87
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 02:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766026367;
	bh=KH2ko3GSTkVwZLREXfQKQzEQFLKa9SM2v6rJm6U/U4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qfIwVztmE6LyYdb6WKAlDszsad1USqQQVkP7e/ieNt8MZkxeIwYF7aF4mepJScQLG
	 YX5Xo0N2ybq4pC7BT/oCdXpEDJnOdjoq9YwizdATrtmGcP+R9eTqlxwxb2R40xkoew
	 y7eZLAOOOsZq29Hx27A1UmERdZbt43Fchn2fNSCA3Nk1iDpAjn+J5eH3ZLuBdPElLI
	 VmJuV3dOuzrPFXKXblt9s7QmvvuQFaO+AzUq3k6flKt7UE0kGuQGFJfQYtehvEPooE
	 lqAgyaxm7gGjekH0YOoqIOhi7HPQ5tdsg2cny872LwlI1p1sFijt9Ku0OYpxPYpsGu
	 y3q6v6IxdIAAw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79e7112398so25269866b.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:52:47 -0800 (PST)
X-Gm-Message-State: AOJu0YzidtVYOfeED8rxxAk0TtBsVXpmnuy4RcmZIOA/0gTAUDMX6w+H
	atXdCC253ZSuWAObT0mjA/DlU4osuZGdKdNW0xyBd4wmhwCTPR2qC2sA0y0fOwmlaud2x11BZE/
	NCZAaa7r4qyuRoNRYNuURxlrVNMffgZc=
X-Google-Smtp-Source: AGHT+IHAIpwPJttGyjAA9c99KnqrgrDDFlIBGnzgPzsZDn6fAm/Eroe2y6rDuSLbnSWqo0J2BEeZ0OXVH3wDIlgM9Tw=
X-Received: by 2002:a17:906:6a21:b0:b80:117d:46e5 with SMTP id
 a640c23a62f3a-b80117d4cbamr345887166b.29.1766026365591; Wed, 17 Dec 2025
 18:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217233608.2374187-1-puranjay@kernel.org>
In-Reply-To: <20251217233608.2374187-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Thu, 18 Dec 2025 02:52:32 +0000
X-Gmail-Original-Message-ID: <CANk7y0hG8wQc2krKbMz1GUPsWdNWa353EzdAykv0nrE4ot4imA@mail.gmail.com>
X-Gm-Features: AQt7F2qXTXnTJ7AInyF4CwJz8eNbfGqTT4Mr5bsOmUs1vM6T81MyrFn35V5rDeU
Message-ID: <CANk7y0hG8wQc2krKbMz1GUPsWdNWa353EzdAykv0nrE4ot4imA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Optimize recursion detection on arm64
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 11:36=E2=80=AFPM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> V1: https://lore.kernel.org/all/20251217162830.2597286-1-puranjay@kernel.=
org/
> Changes in V1->V2:
> - Patch 2:
>         - Put preempt_enable()/disable() around RMW accesses to mitigate
>           race conditions. Because on CONFIG_PREEMPT_RCU and sleepable
>           bpf programs, preemption can cause no prog to execute.
>
> BPF programs detect recursion using a per-CPU 'active' flag in struct
> bpf_prog. The trampoline currently sets/clears this flag with atomic
> operations.
>
> On some arm64 platforms (e.g., Neoverse V2 with LSE), per-CPU atomic
> operations are relatively slow. Unlike x86_64 - where per-CPU updates
> can avoid cross-core atomicity, arm64 LSE atomics are always atomic
> across all cores, which is unnecessary overhead for strictly per-CPU
> state.
>
> This patch removes atomics from the recursion detection path on arm64.
>
> It was discovered in [1] that per-CPU atomics that don't return a value
> were extremely slow on some arm64 platforms, Catalin added a fix in
> commit 535fdfc5a228 ("arm64: Use load LSE atomics for the non-return
> per-CPU atomic operations") to solve this issue, but it seems to have
> caused a regression on the fentry benchmark.
>
> Using the fentry benchmark from the bpf selftests shows the following:
>
>   ./tools/testing/selftests/bpf/bench trig-fentry
>
>  +---------------------------------------------+------------------------+
>  |               Configuration                 | Total Operations (M/s) |
>  +---------------------------------------------+------------------------+
>  | bpf-next/master with Catalin=E2=80=99s fix reverted |         51.862  =
       |
>  |---------------------------------------------|------------------------|
>  | bpf-next/master                             |         43.067         |
>  | bpf-next/master with this change            |         53.856         |
>  +---------------------------------------------+------------------------+
>
> All benchmarks were run on a KVM based vm with Neoverse-V2 and 8 cpus.
>


Here is some more data about other attach types:

+-----------------+-----------+-----------+----------+
|     Metric      |  Before   |   After   | % Diff   |
+-----------------+-----------+-----------+----------+
| fentry          |   43.149  |   53.948  | +25.03%  |
| fentry.s        |   41.831  |   50.937  | +21.76%  |
| rawtp           |   50.834  |   58.731  | +15.53%  |
| fexit           |   31.118  |   34.360  | +10.42%  |
| tp              |   39.536  |   41.632  |  +5.30%  |
| syscall-count   |    8.053  |    8.305  |  +3.13%  |
| fmodret         |   33.940  |   34.769  |  +2.44%  |
| kprobe          |    9.970  |    9.998  |  +0.28%  |
| usermode-count  |  224.886  |  224.839  |  -0.02%  |
| kernel-count    |  154.229  |  153.043  |  -0.77%  |
+-----------------+-----------+-----------+----------+

