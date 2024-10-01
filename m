Return-Path: <bpf+bounces-40659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3D98BB3F
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F701C23525
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4C1BFE14;
	Tue,  1 Oct 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR/V0gw/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354E53201;
	Tue,  1 Oct 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782509; cv=none; b=N1LFVn4RT/1rfinLy2fHQJMR+3JcJQEnNypBe37wuvuAkDxOoHsNiVOoaK94eYeH5NCKddpWX/Ip98Ui42zFNf1bWjxDnVegfR71UHIPtNXLSK3nHl63fz6mceSVWCgTXmhEFuBlURZG8fkz5hIHpYPqJl++yjH6vYRrZ5qfw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782509; c=relaxed/simple;
	bh=XxT0Z8197vW9jVomIdstuRLWTbHpgdbOLOEsa5U84oM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I2Tt9MTzpTJIqhXMKxzZROtjl2qERnNd3Gcqmd7VcrFo18/XTvgoUwy8pdb5pnOwRDtsdbmd4qYfheogu6PUoTvugJ1EXIqI3L1ASIxHrA47SwPhtfqWYAZt7WbLbZ6ytAMhMEQ63M30Bp3HuK50nfAEYWHPS6eKhj2ZlRyok0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR/V0gw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E68C4CEC6;
	Tue,  1 Oct 2024 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782508;
	bh=XxT0Z8197vW9jVomIdstuRLWTbHpgdbOLOEsa5U84oM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LR/V0gw/zbvmAaVRZuRxfUpHHUsGUr0bu+zTMgtD7L8Aank1Gt/Lna1RCXfOiAQkG
	 HpL4+gE5SQ0adRsrGKgxNibxg0bvI0AcdSo3NLrFpr4QPs3jFPXsj2WRBZAw3HTMmj
	 feRNhvZJGIlTwpKSOP8GTcTdmno1zGHneWjytc07B57oEmt0rl5eQ7gkvPjzAVGUTN
	 J5FlVPRsu0WRp4Q7KUThYuiun2yUzhIr4LAQass894PcohgZYX4o/FFR950ooFL3JD
	 XhivSZXmpOgTzLGkdIV/z0HQfhcS8PyWQfvgdjhvzRaRe+RrD18ffI4YFoiSYbP76w
	 8PHjLAViF4/hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB024380DBF7;
	Tue,  1 Oct 2024 11:35:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] Fix accessing first syscall argument on RV64
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172778251175.314421.4543571856155168797.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 11:35:11 +0000
References: <20240831041934.1629216-1-pulehui@huaweicloud.com>
In-Reply-To: <20240831041934.1629216-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, andrii@kernel.org, bjorn@kernel.org,
 iii@linux.ibm.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 palmer@dabbelt.com, pulehui@huawei.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 31 Aug 2024 04:19:30 +0000 you wrote:
> On RV64, as Ilya mentioned before [0], the first syscall parameter should be
> accessed through orig_a0 (see arch/riscv64/include/asm/syscall.h),
> otherwise it will cause selftests like bpf_syscall_macro, vmlinux,
> test_lsm, etc. to fail on RV64.
> 
> Link: https://lore.kernel.org/bpf/20220209021745.2215452-1-iii@linux.ibm.com [0]
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] libbpf: Access first syscall argument with CO-RE direct read on s390
    https://git.kernel.org/riscv/c/e4db2a821b6c
  - [bpf-next,v3,2/4] libbpf: Access first syscall argument with CO-RE direct read on arm64
    https://git.kernel.org/riscv/c/9ab94078e868
  - [bpf-next,v3,3/4] selftests/bpf: Enable test_bpf_syscall_macro:syscall_arg1 on s390 and arm64
    https://git.kernel.org/riscv/c/4a4c4c0d0a42
  - [bpf-next,v3,4/4] libbpf: Fix accessing first syscall argument on RV64
    https://git.kernel.org/riscv/c/99857422338b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



