Return-Path: <bpf+bounces-52228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A04A40423
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 01:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C597A88B7
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908F7E765;
	Sat, 22 Feb 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+FTE8Gn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79078F24;
	Sat, 22 Feb 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184207; cv=none; b=Sj1n41Jlhz5uRObI6D1zLJhJ3B2+LzDAf4NbliJr6VQcJTg+gLB3GxdPpqqq2hw4RgRSZso2J9V5iN21kH63qQhdb3km8ws0ndNRCOKj+XLKROpMbb3gNrJHENW6YkjuvC6+pXUp1NO/ZnrU3lsoWP49EV/I4fl4VP8Y6Tioouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184207; c=relaxed/simple;
	bh=GbjB0KWrr23/xYMW7j05jxmuIebPEfg2Ab84myZi128=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uEmTjsGnU+CHV24W1qK2Ohwi9FKdG5KAG3nh1TGpNDA0+QyL+34/9op/gpq/DjjolseVdoolK9kbQn29tcd9Rj/l01KirMMpmVq7f5hQEEQ+1oPKYOBPp4lIF2/NZ8xhcGv03I4Q5Jb2sy/VSAw+R/XYsBpnjsODGPWzrTx+zxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+FTE8Gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E04C4CEE8;
	Sat, 22 Feb 2025 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184206;
	bh=GbjB0KWrr23/xYMW7j05jxmuIebPEfg2Ab84myZi128=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m+FTE8Gnk2+6ppYjo5uGRy9FP6wK3BluvoF0jFoRyzW3Zu+r5tRzo9S8p5pnw3FQp
	 qjxVUipMkzY+HrM7FE7rWrKgjI6PqRjIHZnynGqqyd1R0Fk7RhOv90Qu723cjKbWWC
	 yjtdRMcDq/No1hpSe9cbZYUdZ4ZC24KHfBkEyWKR+MyAgKDutBa6mv1W3spBnbZi2B
	 eSEFWETb70DSg+ZqvWkj1Glgu4sixgAvhP5TUKdk69Qlh5p7UfIEmO4DWNY2F8iW/8
	 INpVeBWQr1lQSmgUnG42tdNd8JywJs8MyBhfjJ1iCCc3Pb29wIMM5HMCaCTq/0yTB4
	 BqVic22LBN/PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7161C380CEF0;
	Sat, 22 Feb 2025 00:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-02-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018423699.2248733.5993313650415690136.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:30:36 +0000
References: <20250221022104.386462-1-martin.lau@linux.dev>
In-Reply-To: <20250221022104.386462-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 18:21:04 -0800 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 19 non-merge commits during the last 8 day(s) which contain
> a total of 35 files changed, 1126 insertions(+), 53 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-02-20
    https://git.kernel.org/netdev/net-next/c/e87700965abe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



