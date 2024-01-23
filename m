Return-Path: <bpf+bounces-20139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1F8839C6E
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28011C2712D
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF453E11;
	Tue, 23 Jan 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID5Mj2TG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905753815;
	Tue, 23 Jan 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049681; cv=none; b=T6kMKeS8Dy+rUFtzJ7nja9MmjEYEfhd9duNv+OtyZb1U8o81euStghAnL70/mFDfPDsiJ0PdiJe/4/MS3R0fa1nAw69AM1R1oDaTZgF6ya7ZF95mjcnjLfVPDL5YFUXOB5LeSuvEdIpG2N5p9WTA9E5nw7F4q4iUpj21YVhJGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049681; c=relaxed/simple;
	bh=KBDvm6jR3jzfuV1y7xgwPcuBi4NbghpqGKRgTpdaYA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iAXyhE05Jd4Buz6p3cm7XCHcTjvbPFpUVLct3sD6V4vhQf+hDyZAx0XdxPUriOyv68+1NOUEhzkvHvQdatgJHy8Y5I5xSOcN+oyi8dU7dkIPjPBlMtDz195yw04QHqktOGRUL23MkfL3acPksYnKO1Dxl2PaZ+EqPcy/N84Xy/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID5Mj2TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D1F8C433F1;
	Tue, 23 Jan 2024 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706049681;
	bh=KBDvm6jR3jzfuV1y7xgwPcuBi4NbghpqGKRgTpdaYA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ID5Mj2TG0vzsElzcLaMMnAeMTMVOy3C7JHQmAlFvDkTN6e51X3uYJw58Msqy0vT1P
	 Sh2qQipu6ey19zHf7Lg3RNlPjzBpjW9T/P2fKyDQpxbrBMstepn64I2VFf5FraHQ3A
	 gk5JYjZY+mJPUZfaTzY/eX6l2/BZLpOitxIdeHie+fA7QKeQAQQlgv5PU9AjolshuV
	 V+hKnmz6hxJoi6WKcMT55N3wLRzhvfIg4H5NTXp4KeRzgtPJ/QIv4bep2o/UXBwg/5
	 3z7lS0DKBMV4mgimBuNujDHL4xl747fdAY6S1tla2VhN+eJmR9u8yGYr+L95BzmT3A
	 OyhtMLfb/pCyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 489EBDFF761;
	Tue, 23 Jan 2024 22:41:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] riscv,
 bpf: Fix unpredictable kernel crash about RV64 struct_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170604968128.538.9171637206468068779.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 22:41:21 +0000
References: <20240123023207.1917284-1-pulehui@huaweicloud.com>
In-Reply-To: <20240123023207.1917284-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, palmer@dabbelt.com,
 luke.r.nels@gmail.com, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 23 Jan 2024 02:32:07 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> We encountered a kernel crash triggered by the bpf_tcp_ca testcase as
> show below:
> 
> Unable to handle kernel paging request at virtual address ff60000088554500
> Oops [#1]
> ...
> CPU: 3 PID: 458 Comm: test_progs Tainted: G           OE      6.8.0-rc1-kselftest_plain #1
> Hardware name: riscv-virtio,qemu (DT)
> epc : 0xff60000088554500
>  ra : tcp_ack+0x288/0x1232
> epc : ff60000088554500 ra : ffffffff80cc7166 sp : ff2000000117ba50
>  gp : ffffffff82587b60 tp : ff60000087be0040 t0 : ff60000088554500
>  t1 : ffffffff801ed24e t2 : 0000000000000000 s0 : ff2000000117bbc0
>  s1 : 0000000000000500 a0 : ff20000000691000 a1 : 0000000000000018
>  a2 : 0000000000000001 a3 : ff60000087be03a0 a4 : 0000000000000000
>  a5 : 0000000000000000 a6 : 0000000000000021 a7 : ffffffff8263f880
>  s2 : 000000004ac3c13b s3 : 000000004ac3c13a s4 : 0000000000008200
>  s5 : 0000000000000001 s6 : 0000000000000104 s7 : ff2000000117bb00
>  s8 : ff600000885544c0 s9 : 0000000000000000 s10: ff60000086ff0b80
>  s11: 000055557983a9c0 t3 : 0000000000000000 t4 : 000000000000ffc4
>  t5 : ffffffff8154f170 t6 : 0000000000000030
> status: 0000000200000120 badaddr: ff60000088554500 cause: 000000000000000c
> Code: c796 67d7 0000 0000 0052 0002 c13b 4ac3 0000 0000 (0001) 0000
> 
> [...]

Here is the summary with links:
  - [bpf] riscv, bpf: Fix unpredictable kernel crash about RV64 struct_ops
    https://git.kernel.org/bpf/bpf/c/1732ebc4a261

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



