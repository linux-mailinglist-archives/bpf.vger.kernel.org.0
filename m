Return-Path: <bpf+bounces-66678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE1AB386CB
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5227C08D7
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248DE2D1F7E;
	Wed, 27 Aug 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THHQVdep"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D126F28F
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309131; cv=none; b=XpjyVb8rfDCwGDUvIqZ67SvYQftE7ao0HmQFhLhwHdd06lfx6kGpzhsXHDBLUp2RsUO64OQAwC+WF7aPYlOY1HsDnr4c0iGPBFpaINnF6iBDS8tSbnfdE+llBNGQL8c31ITo3qjeAV3CYHgiwssng4OdHxtDesTcyB2V3uCx0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309131; c=relaxed/simple;
	bh=loYYaNJYfHTrXaySDdMRAmKAwbG/EVWwipbqdErAgrw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N62SMSW5W62/qy69ZxCCLvra77lf1xGIhBUY65EQFs5yR+WVsmHJ93m+6Ozqzi5WLbTi82Hs+NemGSoQX81+Oxg2/VO6bIcKP3hqeisH04vnZfzDaze7gQ1YJkpVAeILR270SjirYEujoQJWcEp7AahBUXotB4ERNVskhmEMTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THHQVdep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7992C4CEEB;
	Wed, 27 Aug 2025 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756309131;
	bh=loYYaNJYfHTrXaySDdMRAmKAwbG/EVWwipbqdErAgrw=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=THHQVdepxvZiuAozZYCcnkQggYeCE9mnQwgzUk64cPIdRYWwEGn4dPLgQPn/B1dZ6
	 boaPrCoj1+XZrT3g2pe2UrwAMDEIzhvUEthoPo8N0528/TzgQPU2hZ7ipmBtbMZkx/
	 cArg9eY125GDP5yupbOnWuPRkC2dtqOQZpjI36J4zdcD0XC9jzWhAx4tuijkz/sEX5
	 gaWtafxMEwwTpByvJvdBpgaFR/qDv0JYLVvaSQbVfDRSVc9pAwTwUcMKWr3aRxmWMZ
	 2u7J1O14xUw1q+UbLDBlYRvfXsLj3q1uteWLydIbTcUhS3u0LqNAXksFoWDaTaDF0S
	 AyCbDpk5a8PxQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Report arena faults to BPF streams
In-Reply-To: <20250827150113.15763-1-puranjay@kernel.org>
References: <20250827150113.15763-1-puranjay@kernel.org>
Date: Wed, 27 Aug 2025 15:38:47 +0000
Message-ID: <mb61pfrdchj08.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

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
>
> Puranjay Mohan (3):
>   bpf: arm64: simplify exception table handling
>   bpf: Report arena faults to BPF stderr
>   selftests/bpf: Add tests for arena fault reporting
>

Please ignore this version!!!

I forgot to fix a build issue in this version, it triggers when
BPF_SYSCALL is disabled but JIT is enabled. I have sent another version
to fix this.

v4 including the fix: https://lore.kernel.org/all/20250827153728.28115-1-puranjay@kernel.org/

Thanks,
Puranjay

