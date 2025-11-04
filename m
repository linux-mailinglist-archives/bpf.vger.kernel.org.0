Return-Path: <bpf+bounces-73449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53504C31D15
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 16:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE28B3ACF8E
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD096256C6C;
	Tue,  4 Nov 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcSP0/Bc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC193BB40;
	Tue,  4 Nov 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269635; cv=none; b=f0PGSOyzcTeLvkWkguyZNTCPUq1u8Dya5oz5CbevRp00a/aw1h5W5eI+xcIdl2CwOC/uFapIqjGyjBFe9nt3ymuXXmpRfFfMFaCmIbriVHIsGaJY3C3eN1Nvf3U6W6Kt9u+j0xq5CKnU26XJUhgg1SlGR8lGCh3+tZKVTbIIu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269635; c=relaxed/simple;
	bh=5+jJuM8g/sk5utbSk7zqpxtJZfTKwUL9gIylAir+FM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BD9t6FIUFLl07h3M9KSUgQJfG2RI1cDhAfsKJi4rzdT2PvQB9PM/P0mJlVZ3n+CiTfBpYve23YOIdqR/tz1vE9hujTWxg12aF5pXkGPLQyjZ6PzvcZEGNmDjWOhWdIdpMmyEuXr7IF5H77dBT5GpaYB+gZqXOmQVElkVU3EEKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcSP0/Bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D918EC4CEF7;
	Tue,  4 Nov 2025 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762269634;
	bh=5+jJuM8g/sk5utbSk7zqpxtJZfTKwUL9gIylAir+FM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rcSP0/BcizkK02B3uGUnZzIJvZKtOssXGbmIjCRZmUfihZRfYaObWXRLr0G8/tOEf
	 A8fzwwTGM5NmliYCdvQrXhQsxAQ7wAPerfElhlMvffvxMgg33Fr29+T1cd0ErNMdbb
	 IgR1745qVw+AybH+5AtqqxJc7LktXmGU0KM2anoRc88jzv05Rt+QMitCdtqp/xuZ+M
	 cc+TMS3sKCDr1Kl7MPnug52hEgw0P3EeqBmfSI4iGIc4N5kDPv8ArPLCoPoTp0BiNI
	 LTxZkFIE94SES3SiBD8x+itHM7E2amNYI+z6BqVMELWmN1Lvq9spw2K9SbcJIM1BHh
	 gsN70GtIilmpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C664380A97B;
	Tue,  4 Nov 2025 15:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] xsk: minor optimizations around locks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176226960901.2892501.11273928896997538978.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 15:20:09 +0000
References: <20251030000646.18859-1-kerneljasonxing@gmail.com>
In-Reply-To: <20251030000646.18859-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 30 Oct 2025 08:06:44 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Two optimizations regarding xsk_tx_list_lock and cq_lock can yield a
> performance increase because of avoiding disabling and enabling
> interrupts frequently.
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] xsk: do not enable/disable irq when grabbing/releasing xsk_tx_list_lock
    https://git.kernel.org/netdev/net-next/c/462280043466
  - [net-next,v2,2/2] xsk: use a smaller new lock for shared pool case
    https://git.kernel.org/netdev/net-next/c/30ed05adca4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



