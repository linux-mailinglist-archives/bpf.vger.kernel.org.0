Return-Path: <bpf+bounces-56384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABAAA963D0
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 11:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333493B72AA
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 09:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E5125C704;
	Tue, 22 Apr 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXMUF1bd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1525825C6FC;
	Tue, 22 Apr 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313023; cv=none; b=I7TUvGAVZtVAhC9Sij3EfCiOC9FKyYkkQy2fEga9Y2qum40ob+2sRFqaLxv6c02v6/PeV5oH1gMHbQgJ0R09kC1NWFdSCBabPtzRKCl3LxLCz+jnc4zORBOfzO+lf4CXBvpk8dJov+RfiV0TdCHIwwaQt7STl7k0Jgy15BHgkmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313023; c=relaxed/simple;
	bh=mqyxRKHdVm2N5M3+F1q6B6mbV4al+YiJAAlrjXzPB/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CGPbsyZMTnuPh7Uyt8TqGPJSnr65+K/8+q1Q5w5ThmyhGoizGukAuqNo43xYBKw5Ux2dApb9bMPQ5n5J0Tem2+/30zmA/UHVGnVEA5ho4xotOxiN1qM41KBfvtSwIyt6mYMLtSJEyoMyAAPFQD44GfwcqkVIMCuJ221X+Q5c+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXMUF1bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC53C4CEE9;
	Tue, 22 Apr 2025 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313022;
	bh=mqyxRKHdVm2N5M3+F1q6B6mbV4al+YiJAAlrjXzPB/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DXMUF1bd9mPkr+Coa2NLSftdObfmTb2NXnoUcIKYJRi7gbv84OO6gLITSI2d31Wkc
	 +lmldsJqywqSP+2XzUsyfrTExHhuXMVvqDJuPtUN48b9nmhsIvjnbFY+UebWN4Rbob
	 gvY24I9PvRne82pDZ55eVXJnUs6JGKMOM4CXPd83Ty4RabYhUwdDg+dwE9Dv0ed/9p
	 1yjpOnNJfTWB1x+Qr/2MFFpKkzK9AuUlTNWNvzkPOzzdD1yQatRXlnwcPsaIt1H2LA
	 MEey3vzIo7MgfdFPr4wSDiNnHa0NRoeQnNUWSXULt4J23lKTjN8pb5Lhu34YK4LCee
	 A37zP/xXDHzVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3440339D6546;
	Tue, 22 Apr 2025 09:11:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-04-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531306075.1477965.2610305807611704106.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:11:00 +0000
References: <20250417184338.3152168-1-martin.lau@linux.dev>
In-Reply-To: <20250417184338.3152168-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 11:43:37 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 12 non-merge commits during the last 9 day(s) which contain
> a total of 18 files changed, 1748 insertions(+), 19 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-04-17
    https://git.kernel.org/netdev/net-next/c/07e32237ed9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



