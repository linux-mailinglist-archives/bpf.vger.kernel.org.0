Return-Path: <bpf+bounces-57898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03CDAB1B7E
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D39A28446
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0FA239E82;
	Fri,  9 May 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffij97td"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E386337
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811200; cv=none; b=XCvBAC09aMHjDsGE1BFedBrz2C3qx086p3wgFo590WdmInUZox3naCIAHg9V+5PkrAXW/e6vLN6eocbPlMCSjIjYqpKYEonitTN8J6dQbfm7aF3qvT318s2VjxsECwW4ew2rBbanWtqcO2IXyeJLpA0kcHBKbip5eAxVg+uZYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811200; c=relaxed/simple;
	bh=GffpHlxdBZtvdLLC3Nu+X9+VGrswBZjIPrfp3jgM+rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YLcDTleu8ZrGhWy3ej86Q+blg0A5/PRe3eInwYe7AVX3v0fY2QfzUx4TzZsXm9XcrG1U2cnVMSJW5eUSP1ByOcaU+LqZponPQM7Nj0I8oLafMFd1koHnm13bHK8Sg2eyYXGN1D29Y+4ohOtL+KQDnIy/QhIzIzgiIFjZPnMjr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffij97td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C416AC4CEE4;
	Fri,  9 May 2025 17:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746811199;
	bh=GffpHlxdBZtvdLLC3Nu+X9+VGrswBZjIPrfp3jgM+rc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ffij97tdK0QgqvVjMhKTaK8UO+2Vzk4346Td/ZPgbqLoT8JWyICAckET5Cx3XnMvJ
	 4DqI0+RFkjkm04wkenX6VKVBT54bgBnc0COXzbws/iSxJgkukkGbeVEtxDpQR+gxcz
	 3u6ube4g5MRxZngh4TLc+PlARQz28Kl8jWX0z2qLWEWpOPr9VIav6jj5+Cp8fUph8m
	 HmtJLbVqTWxoCYuw2s4cFHhRzi/b769Y1pDYTl1BJaARGCCLeOqonGVEkraf1CH4Cy
	 cZxkvxWf7Un7SVMNMPAOkoWseCLd/oetT/6wYsUs01C6nobYkihwGTXVfhEDLVNs19
	 wDMF4HOPOYNkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC2380DBCB;
	Fri,  9 May 2025 17:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/8] bpf, riscv64: Support load-acquire and
 store-release instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174681123825.3694746.2689572723731178946.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 17:20:38 +0000
References: <cover.1746588351.git.yepeilin@google.com>
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 parri.andrea@gmail.com, bjorn@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, paulmck@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, luke.r.nels@gmail.com,
 xi.wang@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, mykolal@fb.com, shuah@kernel.org,
 joshdon@google.com, brho@google.com, neelnatu@google.com, bsegall@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  7 May 2025 03:42:29 +0000 you wrote:
> Hi all!
> 
> Patchset [1] introduced BPF load-acquire (BPF_LOAD_ACQ) and
> store-release (BPF_STORE_REL) instructions, and added x86-64 and arm64
> JIT compiler support.  As a follow-up, this v2 patchset supports
> load-acquire and store-release instructions for the riscv64 JIT
> compiler, and introduces some related selftests/ changes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/8] bpf/verifier: Handle BPF_LOAD_ACQ instructions in insn_def_regno()
    https://git.kernel.org/bpf/bpf-next/c/fce7bd8e385a
  - [bpf-next,v2,2/8] bpf, riscv64: Introduce emit_load_*() and emit_store_*()
    https://git.kernel.org/bpf/bpf-next/c/118ae46b7942
  - [bpf-next,v2,3/8] bpf, riscv64: Support load-acquire and store-release instructions
    https://git.kernel.org/bpf/bpf-next/c/8afd3170d511
  - [bpf-next,v2,4/8] bpf, riscv64: Skip redundant zext instruction after load-acquire
    https://git.kernel.org/bpf/bpf-next/c/db7a3822b5f4
  - [bpf-next,v2,5/8] selftests/bpf: Use CAN_USE_LOAD_ACQ_STORE_REL when appropriate
    https://git.kernel.org/bpf/bpf-next/c/13fdecf3456e
  - [bpf-next,v2,6/8] selftests/bpf: Avoid passing out-of-range values to __retval()
    https://git.kernel.org/bpf/bpf-next/c/6e492ffcab60
  - [bpf-next,v2,7/8] selftests/bpf: Verify zero-extension behavior in load-acquire tests
    https://git.kernel.org/bpf/bpf-next/c/0357f29de809
  - [bpf-next,v2,8/8] selftests/bpf: Enable non-arena load-acquire/store-release selftests for riscv64
    https://git.kernel.org/bpf/bpf-next/c/d3131466b4f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



