Return-Path: <bpf+bounces-57969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A1AB2165
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 07:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A188A04CBB
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA51DC9BB;
	Sat, 10 May 2025 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efwHah05"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957D5103F
	for <bpf@vger.kernel.org>; Sat, 10 May 2025 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746856794; cv=none; b=ZU2RQHxsG+JgjLMPiP+7FuZwJvVMk33WN/e5TjRdBfyRj7co3wBPQY5KRd1PjqaCsTVUG+8qGt/E7TZdspwvK5GoI1laExsz8hQcKmG59xvdyNe2vAHvgQVoiqlLHPRWYhDVxhY01mDuNm1lFpelwJn5VlxgrLUqFXsCKXdq6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746856794; c=relaxed/simple;
	bh=eRWPmTcmok6N9vqTNEkhUC7iRXDMPuv6zL+R7+czy+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JKbk/IQaXBP75qIMR3TcFSU5RTA2V91yvRqXIRMEq2HvjWjZWND43ZVskqpKsWhbnldR7Wybstiltw3w7yjPqZ5ReOkxeFrMgEBAz7UeJIGkMyuSr/yw2Z4CnzLPF60TxDYtLkg0xF7V1UzWaSrf8m7QegU/LZreB38hevscnFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efwHah05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE574C4CEE2;
	Sat, 10 May 2025 05:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746856791;
	bh=eRWPmTcmok6N9vqTNEkhUC7iRXDMPuv6zL+R7+czy+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=efwHah05nQKjYDIGSlV1AJBbknB3c9UILtcY8sio/gnEHVMokWV1UaRmfUjY5jP5V
	 IBwpzBuLCfiffOsVHIuEknyBzX1UXd+WR0RXBJm2u/ATZJ5BZ7l3qq9PwbMO718VbR
	 XJQjbEItSuzCTmG83f1zNVvFIr7DMK1/0MmBsUAEmFzFkeweW53xZ4vb0TIaDpEDqs
	 FjWAOpgolakbrhh1+O22TZz1Q6/Y/4bfIjKDUcgwBKRA2Qn56bNv1M3araWevcGKTh
	 49xBAh26GDlC9IgDxQBTqFPAVrlmF7WaBOWBRi9imlA8voS/SpCrpunrr663OpZwaa
	 2ymWh968XIpeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5F3822D42;
	Sat, 10 May 2025 06:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf, docs: document open-coded BPF iterators
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174685683027.3903960.5546015291851693456.git-patchwork-notify@kernel.org>
Date: Sat, 10 May 2025 06:00:30 +0000
References: <20250509180350.2604946-1-andrii@kernel.org>
In-Reply-To: <20250509180350.2604946-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, tj@kernel.org, kernel-team@meta.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 May 2025 11:03:50 -0700 you wrote:
> Extract BPF open-coded iterators documentation spread out across a few
> original commit messages ([0], [1]) into a dedicated doc section under
> Documentation/bpf/bpf_iterators.rst. Also make explicit expectation that
> BPF iterator program type should be accompanied by a corresponding
> open-coded BPF iterator implementation, going forward.
> 
>   [0] https://lore.kernel.org/all/20230308184121.1165081-3-andrii@kernel.org/
>   [1] https://lore.kernel.org/all/20230308184121.1165081-4-andrii@kernel.org/
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf, docs: document open-coded BPF iterators
    https://git.kernel.org/bpf/bpf-next/c/7220eabff8cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



