Return-Path: <bpf+bounces-32112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9135C907B53
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 20:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23AB1C23250
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8914B075;
	Thu, 13 Jun 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nekPwBPk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15905130AC8;
	Thu, 13 Jun 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303430; cv=none; b=JLD0XjVmcJFYeIr9jHd1oEA95ZhSMzhQapXV/CrJNgWRjTxNrhWMq6y6Tghxc7gLYe4vWBSaNzZwsRoyMiHv/Vt7S7RzdYuq9ieZlZrkrdZdcZYazWHop872MgAsckDe1KvxE0RQjrBDeTXDkc/ksZUcCfeGR6+ossDyWL/8lOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303430; c=relaxed/simple;
	bh=/bH/DgWK3nfEfKvzrnknsZDpglOXsP12dN+sgXjHSvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rZC0hGHQFquP3zCNssuLMH42bAH1favWt6vQc0DP18D3/2Jpotol512MJcpo18ue9z4YuvN4ZxjyZY/dwvM1kWVvB9tZMSj/5BS4541VrTOjoQmsbVtGBuuQ2wt3Wd9mk362Fi+3dVXlwv/SVwl5M0H3g0rFBZ42pE9C3DAn5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nekPwBPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74021C3277B;
	Thu, 13 Jun 2024 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303429;
	bh=/bH/DgWK3nfEfKvzrnknsZDpglOXsP12dN+sgXjHSvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nekPwBPk3pccw47RKay2oT3qeeq1huSLnLXHVeoDfONNtbt8FtdeIjDvNmi8iYycp
	 o9LMlKTkxyv7z6xyuLXluS3bNthXOckYOPaAeHNRcdpZ97UKJastkH1cr9oo01R4al
	 jlSJvNm+c1d7Q/vIyI/49TEI8NAHrOXhBeQzWglwJhWG0GaE2zzqkeSa8utazjGFnv
	 eB6oED7lY5kS4JNObeDxl/C/Qq0RJtMdtlIdx+9DpIvh2ClB+HNOXtiFFZ1T1AGy2I
	 Tj3lcLi8nPPySn9wVOMbDGZkxLguRV7aHVO4kEKiFJDOY18Ka6jm5C45oJHeAeX88N
	 5BvaIOmUu+Yuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60E64C43619;
	Thu, 13 Jun 2024 18:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: fix UML x86_64 compile failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171830342939.18223.14373746199529646810.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 18:30:29 +0000
References: <20240613173146.2524647-1-maze@google.com>
In-Reply-To: <20240613173146.2524647-1-maze@google.com>
To: =?utf-8?q?Maciej_=C5=BBenczykowski_=3Cmaze=40google=2Ecom=3E?=@codeaurora.org
Cc: zenczykowski@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Jun 2024 10:31:46 -0700 you wrote:
> pcpu_hot (defined in arch/x86) is not available on user mode linux (ARCH=um)
> 
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: fix UML x86_64 compile failure
    https://git.kernel.org/bpf/bpf/c/b99a95bc56c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



