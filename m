Return-Path: <bpf+bounces-61998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2DAF0419
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3424C189AE0A
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C9E280A20;
	Tue,  1 Jul 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfYefCHe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563E4502F
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399384; cv=none; b=Zn7FI/oXoBMtM9cXszO7MkGeVBgnJcRtalbwOH4GmIUQWZQKD/TN/h91N2vTW4baDGF36yJoN6IFmb7QQ97EzFXGCnVEcjIFpbdXPSn0gkNO8j+ndEugEUiksNIN0nu8iPMDGSwTrjp+WknlhoYMe9TRoQMC92qKyLc4EDTcNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399384; c=relaxed/simple;
	bh=tm6/ET+3Vr9QHiwzYi+UxqC4mjrUn6BQlIYioGgnWdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F/muqulgQoUQL75q7SAJU+MgPUwBGNe6c/1s6Y5mtIQEy3fM9q/f6ciQlyvJyvmMLpp9+ogEzANDdQ0RXVsezfRQAvaJHaGxciyd/PU6jOgRPEJJdQdmyeCgT1pKdTQhM8YFNbv+Wp9hnymP61JLPVN03t833lvnpQeGREzi+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfYefCHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1158C4CEEB;
	Tue,  1 Jul 2025 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751399383;
	bh=tm6/ET+3Vr9QHiwzYi+UxqC4mjrUn6BQlIYioGgnWdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DfYefCHeJOcEjjC34pVGiJi6oy3fXB9gtv6LdEENYgNjQ43d7uyFU0kfa8jlx1w8N
	 3zyDuE9PyP0rorji0NAErIIyCxR2ff0d6DInuPFOWEDQuLufQ1QeiMU4EgPfKK/rMd
	 bR3nGJUJWjUXEIcch8aTmiX5gfgRnlTD5lZqjM95IaFGg+UOzdtbZvJvIXtd60yyPS
	 dqE1bNGnu5LXmxqveipMJkZjU/EmHbAMI141NC5Fne/WqbfixhvufHHCpTct5tYL8u
	 NzMhVX/Hc57TcsO6ihCsGFd4kuLDwOhP0gOHc+Gh8fdG76GI8rqHijjoCUWWizxZSC
	 K4TCzCPxtL4Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFBD383B273;
	Tue,  1 Jul 2025 19:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: enable
 dynptr/test_probe_read_user_str_dynptr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175139940826.99585.15723070067518604420.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 19:50:08 +0000
References: <20250630133515.1108325-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250630133515.1108325-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 30 Jun 2025 14:35:14 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Enable previously disabled dynptr/test_probe_read_user_str_dynptr test,
> after the fix it depended on was merged into bpf-next.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: enable dynptr/test_probe_read_user_str_dynptr
    https://git.kernel.org/bpf/bpf-next/c/cce3fee729ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



