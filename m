Return-Path: <bpf+bounces-32773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46407912F92
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 23:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10821F222C7
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE117C229;
	Fri, 21 Jun 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7SxdtUa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5068208C4;
	Fri, 21 Jun 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005431; cv=none; b=WFeaMAGIA4AbQaTYSsMYLBjP12Y8IkmM+gnQ/51TKKcCF6B5OnveMrH+HGn0wf+NizBjd/98Hts6oKbi4R6ALyS4qmvVtfyz/FuFnk2vzZDWjzJYj8cpCy5y2/jWv2QH9xGzW0C47VystdV77CKnwLrogOyVhR1X5a6sZJrjr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005431; c=relaxed/simple;
	bh=jdD3ZD2Vht/wixxNighYPFeyKxYU6FhMFPXqiCtusXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HLotvxkpXBEpU25o9uuXsSRppDmxvdRHQA6D+8VQ7A8rcAAa2s66tq2fughluNN8yWf18QXToqzFuCGLhPjA1rC8kQjMFM8fDmExy5Ckq3MQGwkr3UmgDHikL1cNU4h1lQG/ibfioTE9vdjKB+JokHxcWguE8R6tJ9U2NgwTApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7SxdtUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55D12C4AF0E;
	Fri, 21 Jun 2024 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719005430;
	bh=jdD3ZD2Vht/wixxNighYPFeyKxYU6FhMFPXqiCtusXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U7SxdtUabIvSdeIZH7QFAvXhT3FTAP+VzKNJXHamNbJsNVI2WTYbbCWZ8sO7tHegq
	 Yauw64HGaLy4Wdb0o0eARLZGYSMbXzGtz32uPpEnUU6oJ4wCrxiS06steMm80RTO48
	 sMY9uXB54VGimbGydyHVEx+cd3L+fDmJBkupTpCXPB4BxzYkwLN20lpvsm1BCZtj/m
	 wFHCuGY9dMz1s6q42JiRRS38MgHWFDiRpLS0REenu7QdGcxLCfEvz0RdOl2vNvOq/m
	 /sUR59QAgGMGDMwziePa37RF8z86PY6mGnqltuOez26XWFMFJ/cxUpSUgWOegR2hyH
	 mgW+dKSVMZFWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 482F2CF3B95;
	Fri, 21 Jun 2024 21:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, arm64: inline bpf_get_current_task/_btf() helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171900543029.18811.11896556389826056750.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 21:30:30 +0000
References: <20240619131334.4297-1-puranjay@kernel.org>
In-Reply-To: <20240619131334.4297-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 19 Jun 2024 13:13:34 +0000 you wrote:
> On ARM64, the pointer to task_struct is always available in the sp_el0
> register and therefore the calls to bpf_get_current_task() and
> bpf_get_current_task_btf() can be inlined into a single MRS instruction.
> 
> Here is the difference before and after this change:
> 
> Before:
> 
> [...]

Here is the summary with links:
  - bpf, arm64: inline bpf_get_current_task/_btf() helpers
    https://git.kernel.org/bpf/bpf-next/c/2bb138cb20a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



