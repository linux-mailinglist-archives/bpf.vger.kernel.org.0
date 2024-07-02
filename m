Return-Path: <bpf+bounces-33634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD91923FF9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0A22848FD
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4991B583A;
	Tue,  2 Jul 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs0cKKTI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427D176ACE;
	Tue,  2 Jul 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929430; cv=none; b=oFD79qnxIDpoexpDoBOJOtrO5F7NF3j8LRJ4NMfp83u35CcRXaJ2BJKunDllJ5nG53ZXym7VWVFPD2EXxK9vvxVm3NxsdxC8h9AbNzD4b2cglRL0sg0oVNTkzgvs0L7KFsD/zBFDd6qJwzFw4lKrGcAFTxtIh3aXPqJV+5RaPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929430; c=relaxed/simple;
	bh=Hq/HJfHRr/8W72EqDAYRS9KUhjRi1sXTi3WnkwLCKRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MH5uS9wm1nYQrNLgx9n002LjN/pUYh2MQqmLqg6rFfFqN5QuAIUpcrOqpjftuwNLEBkGGAD4zUu7AjKQLtHTDCL7UwGj45gWYjSpAcGnZJPsahtdhdqua701qMU3Q1Rwn+/2DGZR+IpCHnDr1e7+xIOcAwMFbYrPUpPyCXFKY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs0cKKTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A8A9C2BD10;
	Tue,  2 Jul 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719929430;
	bh=Hq/HJfHRr/8W72EqDAYRS9KUhjRi1sXTi3WnkwLCKRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zs0cKKTIcSl5MVvzU1Gfbq1dsrCbl080cBjBnQA//Q1VlWTCmlQulm6UtU7kRZl1p
	 v3MRXFxbB4GZeGlscjJwpQdTPmWVp85fkfdZIFNLTtooCz4ZCBRGFa2rnt9ksOFyb7
	 adQyCd7Ys5TFANxNXhjNtTeszJwPifQP0X1sIs3w1b5fhAhBY5PRasYpH3txilFpnp
	 eYJhjRIy5bHKUYTMGh2W/AItfHR6/UzaX76Domt2zKrcNHe5TbS1QUeMeMx7QDQaLj
	 SI5Rp6r+XBViuBBMH4Xu6W8QFtIe54eXL7b/QIkcb1Yj7MFjORrOQ3nHO8O28XgLWl
	 VXIfwwLITkGTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BFB4D2D0E2;
	Tue,  2 Jul 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/3] Add 12-argument support for RV64 bpf
 trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171992943017.14973.8310193579957590981.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 14:10:30 +0000
References: <20240702121944.1091530-1-pulehui@huaweicloud.com>
In-Reply-To: <20240702121944.1091530-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org, palmer@dabbelt.com,
 pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Jul 2024 12:19:41 +0000 you wrote:
> This patch adds 12 function arguments support for riscv64 bpf
> trampoline. The current bpf trampoline supports <= sizeof(u64) bytes
> scalar arguments [0] and <= 16 bytes struct arguments [1]. Therefore, we
> focus on the situation where scalars are at most XLEN bits and
> aggregates whose total size does not exceed 2×XLEN bits in the riscv
> calling convention [2].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/3] riscv, bpf: Add 12-argument support for RV64 bpf trampoline
    https://git.kernel.org/bpf/bpf-next/c/6801b0aef79d
  - [bpf-next,v6,2/3] selftests/bpf: Factor out many args tests from tracing_struct
    https://git.kernel.org/bpf/bpf-next/c/5d52ad36683a
  - [bpf-next,v6,3/3] selftests/bpf: Add testcase where 7th argment is struct
    https://git.kernel.org/bpf/bpf-next/c/9474f72cd657

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



