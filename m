Return-Path: <bpf+bounces-41639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63E9993E8
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86B31F21771
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673F1E102C;
	Thu, 10 Oct 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIFwQUC5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3C1991B8
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593426; cv=none; b=B9QRwNeZwE0KKLXzPhNdPKaHSM24CBlo8G0HM2hiT8LDo1LThslXfj2hfk9bxLkpyF+/gFl6AL5SeM0LZUMPEnZmFeaUUyjQHt/YIRjLsbjl/pk/S4ioE/15Ou5mo5BXHNxuDF4RYzrVvkZjl6NKatF/pisXIxUwyx9iOog2bNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593426; c=relaxed/simple;
	bh=yjd9wYyew6JqFu14EtIxlMNYGDp6nW+pEtn14fWg+EE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tI56gsDjCsVBIAVFpKAh4FMgS2mjA4rcYmii8L1zhB3nYAw3Ju8h/9071LBG8FCperBEVz+7boCA2wIat74ZRd8ud1TTwBGmQdYmvk3LlGkb/po0w5PBOGWzZTTcalBlTxIUs0Qh+R+GNyTyTXfFrcZ3vJyYY7P3moh8c7Wi0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIFwQUC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD21C4CEC5;
	Thu, 10 Oct 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728593425;
	bh=yjd9wYyew6JqFu14EtIxlMNYGDp6nW+pEtn14fWg+EE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bIFwQUC5KBcziGv9aIIvaoHHLgVMVPHZsfuh8fvgDv78wq2nilC6w2iltYbT4WhJy
	 UPUI1qpSZYgNwjDbQpwNvYeOQ1CikNMaR5UjwwtL38RtuolVqeoBM7wFqWKSXs5lne
	 XMr55Ni5eHmwb3rou4M6KKE4qLydJo5oiK/2n2+PB36H1C0p7zJaxAAerqQVUfKq/e
	 4uPKnoHgoCTAPtBYH+VQugy+igDKb3alQzfOcCyucJBdw77likvd8lmcIbdcral2tB
	 0e3OZckAKdpY5dulDPcjKbLSwVBN2F0PC7eBF846a1td70oycdITBtRetlrn3UCIS4
	 WeWRbzapGdrAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D5B3803263;
	Thu, 10 Oct 2024 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: update docs on
 CONFIG_FUNCTION_ERROR_INJECTION
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172859343001.2169193.17310912791191645823.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 20:50:30 +0000
References: <20241010193301.995909-1-martin.kelly@crowdstrike.com>
In-Reply-To: <20241010193301.995909-1-martin.kelly@crowdstrike.com>
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Oct 2024 12:33:01 -0700 you wrote:
> The documentation says CONFIG_FUNCTION_ERROR_INJECTION is supported only
> on x86. This was presumably true at the time of writing, but it's now
> supported on many other architectures too. Drop this statement, since
> it's not correct anymore and it fits better in other documentation
> anyway.
> 
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: update docs on CONFIG_FUNCTION_ERROR_INJECTION
    https://git.kernel.org/bpf/bpf-next/c/c6ca31981b54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



