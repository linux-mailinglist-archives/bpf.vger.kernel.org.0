Return-Path: <bpf+bounces-77276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C1CD47F5
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 01:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A794B3006612
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 00:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CA72192EE;
	Mon, 22 Dec 2025 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1MM2ddv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577321A285
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364913; cv=none; b=QP8QgQM3Q5yOtlPDC4NgHWWvNyRl8RHPwthA9+rZYDNOTjJyrxVwnOddoiYoc4D6sdNPCYSEqCqEJtGhbSkPgb+inb/N/2yVNJqxGHIMBPXw9reVtDKUgJqw8ZHA9JG0wVNuZNqEoimFq2Wh0qhYMsg2kTtkYyYuMv9uezlpxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364913; c=relaxed/simple;
	bh=wuCC1LT/aj0EXJ+4WJXsahOYlnKqJeGthHdRF8BkfOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orbzngzanMtGhZz5f/p7ySXu6IveeGcWfmKK65/6fBs89Jx8E9L4YEZO/gCjs02BNcM+BHaGPIaGHWe+11Q2fmHytfqnrmqvo0eZyPv3nBSA0/v02IdpSNxVQqPXp2untC3KBx4IcEkOpUvmwRMC7mhUFKmPvZdbvAOzGGMaLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1MM2ddv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so2245110f8f.2
        for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 16:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364907; x=1766969707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJR+oepnPgn4ESTA8aZqNg4xMqQB2g84eaTDs8qEqRY=;
        b=A1MM2ddvMwWLFx8pRAXXgD49sogcZXwfxgTxNvceC0sYdnZT6nyIwCzJjXLlbbUnxZ
         X/uZAvngDNtFrHkd/+8PPghpVsy+lCDoaaipZZWSxfdVOYPkyIqWFQKgYsvG+Pez8Rwc
         DLSsMIU+gsXWPhmDkeghPCWXErQuzF8Kd21TM4l4fRCYiLqj+HhaygUTnZ5nnICWXPVq
         gAoK1oh80IE4wDxHQEhD+OOJlSnA12mZLS64rZVnFMxXgkQShTSd7v8cuI+WwJwU/gFn
         SORDuhBdKn2CIqmG/e8sxKMusiN5V/0TqJTCo74srk4ySgoJ1nFme395hKSEAv7s92i9
         5hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364907; x=1766969707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJR+oepnPgn4ESTA8aZqNg4xMqQB2g84eaTDs8qEqRY=;
        b=Y77/hyCMf//x84Mm4wCjT+d1fsSJs679cwZX75etgx7I6I9wKDeuPXtQO0fvz6/uRI
         WLODXeYGsomVC3dZBgwksjkJY8rBMzOGuDSg0Bl/EcfTpBjr8fc624gKM+wLhO2NaPiC
         8QzMJW1+telC6GY9Pv/oUgx35OA0QONxBjl8NuQyYGtSwltaB1KoySEk027TGvPB0DmF
         zZb+5c3mu6aUp8iv1u3IKBClLAz9TemrFeFH5ItHEfOiBDD3WRZMViaL7dWeVctoDzPF
         mwfno4cuHgD5Weg4fLaTO43JgoMvzl9d5wkgzLcNeq7AlnKEpwVuoaVs1VHhVIimYojG
         5TLg==
X-Gm-Message-State: AOJu0YxVL8EWqTGbBC52/36PEZDb3fw1Q3pVPvo53XwQaoiJFOpLY7mL
	JgWXNCB3xmN1MD68pCOJTkBWIfO0h1V4i5bg6JRA0zDR4aBE7TB6Ca5tjP8njuFN2qT2wYyN+UY
	BI/UdMusabG/ff9XptJ8PA3t76cApLhM=
X-Gm-Gg: AY/fxX5ug/24F3S1ItGz2+koXZhxTV+a7ItBv9+ompKdadXDlOrDzZTb8pCD1XU5PZq
	BDs8k8eJLTkF7palwWqUq8Tuh8fcLmBQxt5tOHagw63W80M9PjFxuMe5JUUQkRrUrMV9U+RsXnN
	6p9rJVtHJDnmAUMPN8fmhf/haEhdPZ9Buxb2Kp/qz4banBKhYM8Iz5bgKbbpd9GxmWvd/GRo7Sr
	/Blc7rbZYSac5DABdZza9KPtJ7q9SdP+iWkaQSS9qEF/MD+vzpEvC4PtzwfaaPUVk8JPKqk
X-Google-Smtp-Source: AGHT+IGXo112KvGcJQYLFJQyDVh8Z25BfmkkrlbAlVE+is8DciEiIb/8FFrxOaCCHs4sJhEl2FQ8wkM0usotETFfncY=
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id
 ffacd0b85a97d-4324e4c1219mr8352787f8f.8.1766364907461; Sun, 21 Dec 2025
 16:55:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219184422.2899902-1-puranjay@kernel.org>
In-Reply-To: <20251219184422.2899902-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Dec 2025 16:54:56 -0800
X-Gm-Features: AQt7F2pipINI8bOKwhk7Vlx-Mfc7O28EOzE3UkbvfYD9eM80LDFFQDrjSkRRY2U
Message-ID: <CAADnVQJ91+B=BQ4BC02uqtm+PDerUOfYHDdVGTEbHyi+MCV6bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Optimize recursion detection on arm64
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 8:45=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> V2: https://lore.kernel.org/all/20251217233608.2374187-1-puranjay@kernel.=
org/
> Changes in v2->v3:
> - Added acked by Yonghong
> - Patch 2:
>         - Change alignment of active from 8 to 4
>         - Use le32_to_cpu in place of get_unaligned_le32()
>
> V1: https://lore.kernel.org/all/20251217162830.2597286-1-puranjay@kernel.=
org/
> Changes in V1->V2:
> - Patch 2:
>         - Put preempt_enable()/disable() around RMW accesses to mitigate
>           race conditions. Because on CONFIG_PREEMPT_RCU and sleepable
>           bpf programs, preemption can cause no bpf prog to execute in
>           case of recursion.
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
>  | bpf-next/master with Catalin=E2=80=99s fix reverted |         51.770  =
       |
>  |---------------------------------------------|------------------------|
>  | bpf-next/master                             |         43.271         |
>  | bpf-next/master with this change            |         43.271         |
>  +---------------------------------------------+------------------------+
>
> All benchmarks were run on a KVM based vm with Neoverse-V2 and 8 cpus.
>
> This patch yields a 25% improvement in this benchmark compared to
> bpf-next. Notably, reverting Catalin's fix also results in a performance
> gain for this benchmark, which is interesting but expected.
>
> For completeness, this benchmark was also run with the change enabled on
> x86-64, which resulted in a 30% regression in the fentry benchmark. So,
> it is only enabled on arm64.
>
> P.S. - Here is more data with other program types:
>
>  +-----------------+-----------+-----------+----------+
>  |     Metric      |  Before   |   After   | % Diff   |
>  +-----------------+-----------+-----------+----------+
>  | fentry          |   43.149  |   53.948  | +25.03%  |
>  | fentry.s        |   41.831  |   50.937  | +21.76%  |
>  | rawtp           |   50.834  |   58.731  | +15.53%  |
>  | fexit           |   31.118  |   34.360  | +10.42%  |
>  | tp              |   39.536  |   41.632  |  +5.30%  |
>  | syscall-count   |    8.053  |    8.305  |  +3.13%  |
>  | fmodret         |   33.940  |   34.769  |  +2.44%  |
>  | kprobe          |    9.970  |    9.998  |  +0.28%  |
>  | usermode-count  |  224.886  |  224.839  |  -0.02%  |
>  | kernel-count    |  154.229  |  153.043  |  -0.77%  |
>  +-----------------+-----------+-----------+----------+
>
> [1] https://lore.kernel.org/all/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paul=
mck-laptop/
>
> Puranjay Mohan (2):
>   bpf: move recursion detection logic to helpers
>   bpf: arm64: Optimize recursion detection by not using atomics
>
>  include/linux/bpf.h      | 38 +++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/core.c        |  3 ++-
>  kernel/bpf/trampoline.c  |  8 ++++----
>  kernel/trace/bpf_trace.c |  4 ++--
>  4 files changed, 45 insertions(+), 8 deletions(-)

It was applied to bpf-next.
pw-bot is asleep.

