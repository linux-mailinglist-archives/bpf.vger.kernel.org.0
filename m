Return-Path: <bpf+bounces-21276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325E284AD6A
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 05:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82941F25DB6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703A174E16;
	Tue,  6 Feb 2024 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVuauG5M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C874E03
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193227; cv=none; b=Cg/OXTMsZCYrvnwwFXjxZu1VFBoXOz0OWAdfW/Ll1nwNlQHUB/AQ7XCok6dCEVPrS1eXU07UIqL27owH91qWGDm8BiQBoyVMuW3CekwI7BicFkEvaq4lydBEpwDFMKWO7DHa4nQJBgx+5hDWLgZN5UJF8huazlKtp0m9FMqNXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193227; c=relaxed/simple;
	bh=oB1ukpatlOQ/VH+ioSKPO/cNdC+vrOqNpl6ZNJ/CQu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMMp5F/TmXls0FKjn/+gAdEc6OIrTF8Ii0b64JpqgpGkUyA6+cal/feFjaILBWYVAyMADGvSINg+DtddDTzvzLL0edWB1p/PCJ50nIY3RSJH6aWwwhcaR0K3FF/kXsnJpc4MWKH1dPmkDGKbSBP5Ve4Y+Or8zawWnqTnojp+Loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVuauG5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 827F7C43390;
	Tue,  6 Feb 2024 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707193226;
	bh=oB1ukpatlOQ/VH+ioSKPO/cNdC+vrOqNpl6ZNJ/CQu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZVuauG5MtotjKzS81jED7pppTlbzIbemLj6goV+QJUbBgZjb2pSHoIzxERZX1bIm6
	 WhLgMgkpBUO3P+OXOBM+RGC1aYW9cA91Ip+GZgBVqCp78qW3TxR1tj5PxL+2BFZ7uM
	 I4uiIjxBD3pvPBuePAC3fJ2cBb+TkU9470S4hwaJZQC4NSw+CmKYQdh95lUmezLIV1
	 0dtLBdCEXx7MjiPx1Bh3PepleNqp8TGjidIylOxD0aTjRoMpQE/s8a/1pRqPrkYNF2
	 sMPMqVVfkkb8/aP1F/fStX6VUCMkhVG7ztu+Y20IJokq7i5b0ztbke4f4WZUJ+glJD
	 YhwZ0wxxBEqLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B5FDE2F2EF;
	Tue,  6 Feb 2024 04:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix return value for PERF_EVENT __arg_ctx
 type fix up check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170719322643.4467.580963372525626194.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 04:20:26 +0000
References: <20240206002243.1439450-1-andrii@kernel.org>
In-Reply-To: <20240206002243.1439450-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 Feb 2024 16:22:43 -0800 you wrote:
> If PERF_EVENT program has __arg_ctx argument with matching
> architecture-specific pt_regs/user_pt_regs/user_regs_struct pointer
> type, libbpf should still perform type rewrite for old kernels, but not
> emit the warning. Fix copy/paste from kernel code where 0 is meant to
> signify "no error" condition. For libbpf we need to return "true" to
> proceed with type rewrite (which for PERF_EVENT program will be
> a canonical `struct bpf_perf_event_data *` type).
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix return value for PERF_EVENT __arg_ctx type fix up check
    https://git.kernel.org/bpf/bpf-next/c/d7bc416aa5cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



