Return-Path: <bpf+bounces-14717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34337E78EF
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C901C20DE4
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 05:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1B3C36;
	Fri, 10 Nov 2023 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG/dWIKS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC713C05
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 05:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28E02C433A9;
	Fri, 10 Nov 2023 05:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699595427;
	bh=Nbdy7aWyTz/umN5u78ZR+Ku6QCxfkST4G7Gdddd6cwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jG/dWIKSRQ6ejTcBnu98aGqsG8AAIPNaYhTJTsLYjAEJBYPuuZe6EM8rGg5kfEbHv
	 Petg4xlhVhIpEsoUhArQ2fzQ5TquV2ezFkWMhLKD0r4Inde5ZIE7yqpgenzt8AjvOF
	 B53REI9UIlstVwDKwDzL5oU1KSpWFxV8xnBrpT7h4+dXquoFis21m1HU5eMIEWgtd4
	 4/j78T60A5/CbS0Dbi3vM6X3VU0VvoDdIWKhwel1NRkXVzHTXjzQk+MC+AYPBR2uF9
	 KmSASdqMceezNCGgaWt9eGIrAvTVT79UkvguuATKQkur3YwAlnh3y2ldg5gQ6kVGAE
	 LlptBM7KERyDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FACEC691EF;
	Fri, 10 Nov 2023 05:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 0/3] BPF control flow graph and precision backtrack
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169959542705.29680.2784250808395809182.git-patchwork-notify@kernel.org>
Date: Fri, 10 Nov 2023 05:50:27 +0000
References: <20231110002638.4168352-1-andrii@kernel.org>
In-Reply-To: <20231110002638.4168352-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 9 Nov 2023 16:26:35 -0800 you wrote:
> A small fix to BPF verifier's CFG logic around handling and reporting ldimm64
> instructions. Patch #1 was previously submitted separately ([0]), and so this
> patch set supersedes that patch.
> 
> Second patch is fixing obscure corner case in mark_chain_precise() logic. See
> patch for details. Patch #3 adds a dedicated test, however fragile it might.
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/3] bpf: handle ldimm64 properly in check_cfg()
    https://git.kernel.org/bpf/bpf/c/3feb263bb516
  - [v2,bpf,2/3] bpf: fix precision backtracking instruction iteration
    https://git.kernel.org/bpf/bpf/c/4bb7ea946a37
  - [v2,bpf,3/3] selftests/bpf: add edge case backtracking logic test
    https://git.kernel.org/bpf/bpf/c/62ccdb11d3c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



