Return-Path: <bpf+bounces-53161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF35A4D2D4
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 06:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB67116F49A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 05:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9C1F428D;
	Tue,  4 Mar 2025 05:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmy2uixt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F61BBBF7;
	Tue,  4 Mar 2025 05:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065004; cv=none; b=NqjwUmbBjmYdrdFmC8nwqKDCmtpmwR3FNewxaGPoDmwwJbJXzwxbEq6yEBwNxdyniuEv3mvGolqzIkmczf3kM7reKFL2w76PXlhQpo+NTwbldxomely2LcTb1kvdufD8O6M/BCwsWdeyOTD0lc5qsjSt4mC+F5/YC1e/QF1b/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065004; c=relaxed/simple;
	bh=wO5x2dvF229R64tAvyWDQAOJOp4+JsHPcpkIUjPAMAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lSMl9cwyk1TGD4C6ka8i6ldVAKsjHuPZAjyDUasEcYSlrpxEvrzdjayUlJDK5LBfpOHA/NBhEaFr7B36Glc35sl/0q65Io+oBsFhrob2SduYfNHJdh4ui13+fz+QjMT8LhnNDY3npNc65HFpBztapUSinmPqkUfbXUYVQRL8LM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmy2uixt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E757DC4CEE5;
	Tue,  4 Mar 2025 05:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741065004;
	bh=wO5x2dvF229R64tAvyWDQAOJOp4+JsHPcpkIUjPAMAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nmy2uixtSZBKKKmRXdxlVANrfaYlP8NmJalgl4qyFuxZWHZqakqvEuznkaEdvVb2y
	 DJ7FMOMH3SyY6rwNoNqtGcQJte47YpAgbSnG4m6w67MmYf/0jeUdCAF27QvjtatcNH
	 cdPQya9Yuu7Eo3f3d1dbUdIJZW/RrhjWr2jb0/XW3PqCdpX2sPcB5wJUAoXZMVu91M
	 uDWN9fYKslvkFxtNOQynGwhqpfomFtCNUxgQxUFRr8zastq3oclEmoPRLCu/4cpfFN
	 1MTUnqcMp/ZU8fvtWvzrX5w4/S8HWyvOBWIWTc4wUDtDBsEc4KqXBWDAEVmf44PqF9
	 X0HNe8XVJrwSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1F7380AA7F;
	Tue,  4 Mar 2025 05:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/6] Introduce load-acquire and store-release BPF
 instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174106503648.3866937.5658954004964289425.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 05:10:36 +0000
References: <cover.1741049567.git.yepeilin@google.com>
In-Reply-To: <cover.1741049567.git.yepeilin@google.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
 ast@kernel.org, xukuohai@huaweicloud.com, eddyz87@gmail.com,
 void@manifault.com, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, corbet@lwn.net, paulmck@kernel.org,
 puranjay@kernel.org, iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 catalin.marinas@arm.com, will@kernel.org, qmo@kernel.org, mykolal@fb.com,
 shuah@kernel.org, ihor.solodrai@linux.dev, longyingchi24s@ict.ac.cn,
 joshdon@google.com, brho@google.com, neelnatu@google.com, bsegall@google.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  4 Mar 2025 01:05:41 +0000 you wrote:
> Hi all!
> 
> This patchset adds kernel support for BPF load-acquire and store-release
> instructions (for background, please see [1]), including core/verifier
> and arm64/x86-64 JIT compiler changes, as well as selftests.  riscv64 is
> also planned to be supported.  The corresponding LLVM changes can be
> found at:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/6] bpf: Introduce load-acquire and store-release instructions
    https://git.kernel.org/bpf/bpf-next/c/e24bbad29a8d
  - [bpf-next,v6,2/6] arm64: insn: Add BIT(23) to {load,store}_ex's mask
    https://git.kernel.org/bpf/bpf-next/c/4170a60c473d
  - [bpf-next,v6,3/6] arm64: insn: Add load-acquire and store-release instructions
    https://git.kernel.org/bpf/bpf-next/c/248b1900dd95
  - [bpf-next,v6,4/6] bpf, arm64: Support load-acquire and store-release instructions
    https://git.kernel.org/bpf/bpf-next/c/1bfe7f657cf4
  - [bpf-next,v6,5/6] bpf, x86: Support load-acquire and store-release instructions
    https://git.kernel.org/bpf/bpf-next/c/14c0427b8a09
  - [bpf-next,v6,6/6] selftests/bpf: Add selftests for load-acquire and store-release instructions
    https://git.kernel.org/bpf/bpf-next/c/953df09aa42c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



