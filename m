Return-Path: <bpf+bounces-54685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBCA70473
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A357A3ADA08
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E925B67D;
	Tue, 25 Mar 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGNMIH/e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6125A64C;
	Tue, 25 Mar 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914798; cv=none; b=UcB7Sdnd2Olca/5zhPtIxlxRhvSjX31aDMaewkebPMkroe0UXf92tTc99LIu2srd8vUzsovVq0Tyum+VGAXozzHLBW4mEgccpU1Zk5u4ynTQqlDemDxIYbDP/eTbdZqGHcmU5K4MujLLV7TKpeNyGkIOn6SbE8Sonavk88akJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914798; c=relaxed/simple;
	bh=FOiz7ZeLamPZDkQ2/GXp+1IpWI81RSd0aYdQbPeigyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nq6Q3NqwjPh6j9DUervlOlokT4la+Oa4stIbq/xzocW5gsLCtduAqZ6IOY5SG3B1JNwDT6ihMbSbesQ8Wg6ceNa0Np2lcnBfQll2BCjADOMSlR/6iVuUdDkjcB/ynoAn/xL8GuERV0QkNN07dFocak/vXQvNrnYbPLnCbXjIKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGNMIH/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1926C4CEEA;
	Tue, 25 Mar 2025 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914797;
	bh=FOiz7ZeLamPZDkQ2/GXp+1IpWI81RSd0aYdQbPeigyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JGNMIH/eR0aUyF7cDBaDZMD6BWeQj0zBp/0/82sfQxfKGIZ/znoyKocaLrAE0Jqis
	 93Ycsz0mZABCdqcK4A1MJjUwmsGXAXFsBXWGKo50HFe6w7ZFGLcjoLCtXZt3B4e+Gg
	 sHa63b63Iqr3Y11hEFLOSHMyp8MtEZHDhrOBVGfeEFTvtNqVPWT/qeg6j2fNUlCtvX
	 pfoIF7Lr/TUMeerc6OGB3LWxSNL1YNUHF3oEA/eENCuM7jLd838qfnNtgZ1ixQYj97
	 MfoW1wx7dZ6f8q6oXywL7YRAyNeGl6mcbaPjQPVHMj+3o3LXiQ0Z3T06efiQJjzhpG
	 VN7f19AxVDNGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34798380CFE7;
	Tue, 25 Mar 2025 15:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vmxnet3: unregister xdp rxq info in the reset path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291483401.606159.9447299840832813987.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:00:34 +0000
References: <20250320045522.57892-1-sankararaman.jayaraman@broadcom.com>
In-Reply-To: <20250320045522.57892-1-sankararaman.jayaraman@broadcom.com>
To: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Cc: netdev@vger.kernel.org, ronak.doshi@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, u9012063@gmail.com, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
 alexandr.lobakin@intel.com, alexanderduyck@fb.com, bpf@vger.kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 10:25:22 +0530 you wrote:
> vmxnet3 does not unregister xdp rxq info in the
> vmxnet3_reset_work() code path as vmxnet3_rq_destroy()
> is not invoked in this code path. So, we get below message with a
> backtrace.
> 
> Missing unregister, handled but fix driver
> WARNING: CPU:48 PID: 500 at net/core/xdp.c:182
> __xdp_rxq_info_reg+0x93/0xf0
> 
> [...]

Here is the summary with links:
  - [net] vmxnet3: unregister xdp rxq info in the reset path
    https://git.kernel.org/netdev/net/c/0dd765fae295

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



