Return-Path: <bpf+bounces-52606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80816A453BC
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C75A188C83F
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0899E225766;
	Wed, 26 Feb 2025 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtxxaPr3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546C18D626
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539399; cv=none; b=GYuDG69M0vxgrLUfqBaV2y2qWxSL+ec5wiYVuYnhlEJfKU9ZH9EEfPbZPLnVCuxfp50rTnNpfCEBeoZXbBSsA+iqnjViW9szFHdq91gizWhyJvmVP6Pv97sYJ7Gx9WDNVbGq+ACavKRyyKL60lCievPmp1P6idHywvhOq/UqBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539399; c=relaxed/simple;
	bh=vzRjxyyHFjvA0g+VTXoC/LcsfvEQJntoi8Wdad/XrgA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OtvWXo2fTrZN5sLOEfdOnSwFCGV9qnLD8urQDeYO7Uq4c7/dXfHyMqx2glGqnTfB1a/6UMDHi79GEnBb/qBTRp/9E2Lz/P+h5/As79zC7iI1h2ax2ogDxJ6UNP6TmJAaIvElVxC19+sljPo1KOqQln/fhq/tAKssCKApDFPAENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtxxaPr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD83C4CED6;
	Wed, 26 Feb 2025 03:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539399;
	bh=vzRjxyyHFjvA0g+VTXoC/LcsfvEQJntoi8Wdad/XrgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DtxxaPr35/x+0rfJetxiVt1QEhnJAh38DSHHTIt49yVsNzjpRusSyoGpUi9OT9yYs
	 vTX0OmnAKB80sjo+DmTTcHjqEkkWHZeG0J6rAn+jM+dalSz8OLXpf8BFBSO8sB3pUg
	 Dz6olBhiyo5N17U5u+oyYPKumXR9XLPOhBu0qe2hB8Sj8NBsH4vLcceiFoLzyrQwPY
	 iYSprkB6GecaSg4puiUGE5uchIIZZOpwVmNdZW+1OSQrHG/bu6vEWX4nXjiSeGCiyU
	 8RxKKCOUNeW7EFKpbkEm0hft23gFAB9dsrFtGuolLn3gRkRwKrroODS2bDCp9BEWGo
	 snTJ41x0VbAgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEAB380CFDD;
	Wed, 26 Feb 2025 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Search and add kfuncs in struct_ops
 prologue and epilogue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053943077.217003.16678556837470441769.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:30 +0000
References: <20250225233545.285481-1-ameryhung@gmail.com>
In-Reply-To: <20250225233545.285481-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 25 Feb 2025 15:35:44 -0800 you wrote:
> From: Amery Hung <amery.hung@bytedance.com>
> 
> Currently, add_kfunc_call() is only invoked once before the main
> verification loop. Therefore, the verifier could not find the
> bpf_kfunc_btf_tab of a new kfunc call which is not seen in user defined
> struct_ops operators but introduced in gen_prologue or gen_epilogue
> during do_misc_fixup(). Fix this by searching kfuncs in the patching
> instruction buffer and add them to prog->aux->kfunc_tab.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Search and add kfuncs in struct_ops prologue and epilogue
    https://git.kernel.org/bpf/bpf-next/c/d519594ee244
  - [bpf-next,v5,2/2] selftests/bpf: Test gen_pro/epilogue that generate kfuncs
    https://git.kernel.org/bpf/bpf-next/c/4e4136c64467

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



