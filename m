Return-Path: <bpf+bounces-66758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA408B38FBB
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B8617C770
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7FA157E99;
	Thu, 28 Aug 2025 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywn7MnT4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A764125A0
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340662; cv=none; b=BJlAGauRWJO7BLuaspVvlGKBN3xaGofSInE1K0sUx7JiKOtovh6wXrf0HBSPBW3uHpWTUeLp6/rPNe8GU5h222fEYwx47+pGaHMIpZ75K7Lbag7QM2k1x8iGaPijvF2QCnEbpsqBBITg6MnoDJjvs4lKlj9gN14Yj8fa584jtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340662; c=relaxed/simple;
	bh=1uMsamVJhagehR1t5cjN418VARJAS0z8sR6CQeCuSwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFKsnfUCjl00mWr4gLqs0tlx7m8r6gfGiRBUQNaZB9XZ/CbCzeZqqycSy39K2nC5bfW85B4OtpLkXb6sVyf+7m0f1Y5ZkaI6iY78LcQlv43GDa1WT4rSfTyJyiqu2OvozNQxmIsjmNcl3qBt9ysMvg8QYVQvwd2hit0oVT8MG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywn7MnT4; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-61c325a4d18so604515a12.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756340659; x=1756945459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibJbxnkg/Oxgj5qyzFUvJ90tuxlBYUO/+mG6CZivTSU=;
        b=Ywn7MnT4Xi2d20aeQu/yOtV5XlaswiBLM2Comm+CvyMUrrLOol6V6Tz46jWNpP72nF
         Wo5H+kADeLdpruXb7wm9U2t6hHKI58JhtjGvkDzG6ZKcxkoEP/kpx/BwQEE97soKMREN
         gakOzSYBpMQkoVfZWGDco3wt9eVhjKR4wCea3oRfW+VKBTfOFzY0AguTJN7+paf/voK5
         623Aga3ms8gD/Yg8bS4ttZe/ZW+uYU6HdJlqztw0gXShxtxdA7ZIThwTHaHSaYeb0saG
         aNd9cO+g53xUf/uVy36CO9XANahynoT1zmbhFzW2S+JxFIKr92QZn4ZKaKEC25RtsjQe
         KPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340659; x=1756945459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibJbxnkg/Oxgj5qyzFUvJ90tuxlBYUO/+mG6CZivTSU=;
        b=am1DxSRwAo8Zim0jKsu0iehYfRSUT2RLJ7uAZGQTYDeynJfJWDZmgLaHiVI03QE9z3
         bU1KjIMfqg7LcxvMo2KYEJCbX9/7GOS3HNE6qGW+7NnEfnAOfysDNzx1LnMVm9wvx4og
         wM9uJuSoGRLaQYFvSvIrcFs8kbCQ7EKXj34t5ftLFi55NpzYhO7yNsFLeUCbdKaJymHH
         gdPuosYAApCi7BuNCd1FBOBhJTIQ+0mw6+k4MUgONoPexGb5N49fN5kf36gGIpiO0CXO
         6McdIpjnTfFLhiBGJ23SHUxqv9FSCS994qk63a8x+cgw0Qgc2QP6Gr8Uf0qgQu3W3YC1
         3UWw==
X-Forwarded-Encrypted: i=1; AJvYcCVTD9FiRslnMDncqnGouCS1HMB6BjL/g+iOEEaa8MgqTlgYQV8BYdbC6HkJb3bAnxJ9BiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwembYqesiK7LMV8Ce5SMUFriEqqCH6QDbr9ywulW5zYLDVZekI
	03I3C4bF8PuMJ2MslUzDqsDs2lHO7C7mMg6q8ZrM0D9tP5bSJ+v0TuJo2CLnL/HZGNrWBTd8OFS
	7Gig6THC9KUNFS+epJWIpS7zzNPok1i4=
X-Gm-Gg: ASbGnctqdfS/8lB9TcqE0ub90UzQCGTba3YR+fWxk15Tum2EjKJDKStdqJmLQBpyULh
	pfbmmBFJa1xrBakFrAEPLRrRqoj64bXWmR3zKmzxvW8jaOdX4mqcRW0hOsjZA3Z1i8T+oBp7IA9
	EDB3xqUjx5awpNPjIrUB9S47gt1sBoFqIx5gGUVAW3nLB1Fp3fjnktHItIrUe+4GsJ75/1aH7Us
	5380DpvaV3AwrJGqtylD6XdOJZoNCRTLfTi8OIZ
X-Google-Smtp-Source: AGHT+IHn310MBGXuXUYm3zA+jozPXMcrpHuMw4os+AJBGUA0j4fx5GNLbC3YT5U1RFtIKVktcQLLEzi3AEhpygKnQlA=
X-Received: by 2002:a05:6402:2747:b0:61c:283a:cad2 with SMTP id
 4fb4d7f45d1cf-61c283ad32dmr16809092a12.10.1756340658698; Wed, 27 Aug 2025
 17:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org>
In-Reply-To: <20250827153728.28115-1-puranjay@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Aug 2025 02:23:42 +0200
X-Gm-Features: Ac12FXxlOT0X5P6Z843vyxTYDLy2bzJaL4H-_o0HOoBdb9qcymG13NTPfBiQ_sc
Message-ID: <CAP01T77PGbpEEmGyCqKSy-+Zb18+dfWH=8ujEQFBDKEOca3Mjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf: Report arena faults to BPF streams
To: Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 17:37, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Changes in v3->v4:
> v3: https://lore.kernel.org/all/20250827150113.15763-1-puranjay@kernel.org/
> - Fixed a build issue when CONFIG_BPF_JIT=y and # CONFIG_BPF_SYSCALL is not set
>
> Changes in v2->v3:
> v2: https://lore.kernel.org/all/20250811111828.13836-1-puranjay@kernel.org/
> - Improved the selftest to check the exact fault address
> - Dropped BPF_NO_KFUNC_PROTOTYPES and bpf_arena_alloc/free_pages() usage
> - Rebased on bpf-next/master
>
> Changes in v1->v2:
> v1: https://lore.kernel.org/all/20250806085847.18633-1-puranjay@kernel.org/
> - Changed variable and mask names for consistency (Yonghong)
> - Added Acked-by: Yonghong Song <yonghong.song@linux.dev> on two patches
>
> This set adds the support of reporting page faults inside arena to BPF
> stderr stream. The reported address is the one that a user would expect
> to see if they pass it to bpf_printk();
>
> Here is an example output from a stream and bpf_printk()
>
> ERROR: Arena WRITE access at unmapped address 0xdeaddead0000
> CPU: 9 UID: 0 PID: 502 Comm: test_progs
> Call trace:
> bpf_stream_stage_dump_stack+0xc0/0x150
> bpf_prog_report_arena_violation+0x98/0xf0
> ex_handler_bpf+0x5c/0x78
> fixup_exception+0xf8/0x160
> __do_kernel_fault+0x40/0x188
> do_bad_area+0x70/0x88
> do_translation_fault+0x54/0x98
> do_mem_abort+0x4c/0xa8
> el1_abort+0x44/0x70
> el1h_64_sync_handler+0x50/0x108
> el1h_64_sync+0x6c/0x70
> bpf_prog_a64a9778d31b8e88_stream_arena_write_fault+0x84/0xc8
>   *(page) = 1; @ stream.c:100
> bpf_prog_test_run_syscall+0x100/0x328
> __sys_bpf+0x508/0xb98
> __arm64_sys_bpf+0x2c/0x48
> invoke_syscall+0x50/0x120
> el0_svc_common.constprop.0+0x48/0xf8
> do_el0_svc+0x28/0x40
> el0_svc+0x48/0xf8
> el0t_64_sync_handler+0xa0/0xe8
> el0t_64_sync+0x198/0x1a0
>
> Same address is seen by using bpf_printk():
>
> 1389.078831: bpf_trace_printk: Read Address: 0xdeaddead0000
>
> To make this possible, some extra metadata has to be passed to the bpf
> exception handler, so the bpf exception handling mechanism for both
> x86-64 and arm64 have been improved in this set.
>
> The streams selftest has been updated to also test this new feature.

We also need arm64 experts to take a look before we land, since you'll
respin anyway now.
Xu, could you please provide acks on the patches?

Thanks a lot.

>
> Puranjay Mohan (3):
>   bpf: arm64: simplify exception table handling
>   bpf: Report arena faults to BPF stderr
>   selftests/bpf: Add tests for arena fault reporting
>
>  arch/arm64/net/bpf_jit_comp.c                 | 77 ++++++++++++------
>  arch/x86/net/bpf_jit_comp.c                   | 79 ++++++++++++++++++-
>  include/linux/bpf.h                           |  5 ++
>  kernel/bpf/arena.c                            | 20 +++++
>  .../testing/selftests/bpf/prog_tests/stream.c | 33 +++++++-
>  tools/testing/selftests/bpf/progs/stream.c    | 39 +++++++++
>  6 files changed, 226 insertions(+), 27 deletions(-)
>
> --
> 2.47.3
>

