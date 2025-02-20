Return-Path: <bpf+bounces-52061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B964FA3D364
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A233B2F78
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4161EBA1E;
	Thu, 20 Feb 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2NgOppW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77541E9B07;
	Thu, 20 Feb 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040801; cv=none; b=mLHrDlbnqTxhzAcRwoxo+Jn8LAMvDBxIXPG3Fnub3ZwIIAZQ4hX4JLBzgI+HakLQJ1dhhwe4PDPztrMAPH+H+RZtPEgbPW+56d2RYQBpd2VtHeFPA/WP5MZnuWdqtepQs8dBCt9SBLa2cPSxsC8C0+JCykOmEE4UoQSfMKWiKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040801; c=relaxed/simple;
	bh=eYc7LMKuByYRxGaNCW8otxZTs2GWL1JDGwpT23bnpp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fMt5MDAcFJRNKPsoySx+HFvTGtHobLruG0EuWuSvTQ/bKVgTykFAEvcshJHFhoVEG5oz37JTeFNsivjfrix75T7e9pdWi6ao16RlpZbGTSk8wGSbWh2Y7vHN+c5V6a+6aErYDSb/i7ab/dHfWu3EJk6OOOIA4HTSjsjnrmHY2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2NgOppW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579C1C4CEDD;
	Thu, 20 Feb 2025 08:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740040800;
	bh=eYc7LMKuByYRxGaNCW8otxZTs2GWL1JDGwpT23bnpp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e2NgOppWT845Ct+uSbitMkIYIEyQHv2XtfSLphu2OJ2COHZwUVD/uHlufulX1vRwX
	 z4gN6O6vVPklEZTQMXnnKquuZEnRBCkIVBU6egsRH9jVtGMi3JCtjRjwHaEJmJdaIJ
	 nKa5HuS+fyttsm0AZLKNRLj+22KJEprUwWiZUVd2JyCPX2yx1FivfsqnzjxkRETBNE
	 wud0xeHYTdsgQtdCTOTIaMd6edoxKj4HucsY1736Lk7o/PKwYcFZBai5YjpPCMH7zT
	 Ab5SshiPlAjtOl1v8GiSqr6RXaBIOciMoqGDWNKJeeBlyKJ94LU3Hc+NUqxSLrwh2a
	 Q25ExRergKb8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6E380CEE2;
	Thu, 20 Feb 2025 08:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174004083099.1211626.15093376087065414266.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 08:40:30 +0000
References: <20250218030409.2425798-1-haoxiang_li2024@163.com>
In-Reply-To: <20250218030409.2425798-1-haoxiang_li2024@163.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: kuba@kernel.org, louis.peens@corigine.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, qmo@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Feb 2025 11:04:09 +0800 you wrote:
> Add check for the return value of nfp_app_ctrl_msg_alloc() in
> nfp_bpf_cmsg_alloc() to prevent null pointer dereference.
> 
> Fixes: ff3d43f7568c ("nfp: bpf: implement helpers for FW map ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
    https://git.kernel.org/netdev/net/c/878e7b11736e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



