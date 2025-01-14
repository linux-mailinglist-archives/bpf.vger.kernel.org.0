Return-Path: <bpf+bounces-48872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A90DA1150F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1F4161662
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7821423A;
	Tue, 14 Jan 2025 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYMgam9u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745232066EA;
	Tue, 14 Jan 2025 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896209; cv=none; b=GN5V/NkCiKrV6OGFlXKmtK5Ta2mcQd4zo4w9QD8LbNTryqQ7hg1cmRqNq865gi8egzOHG86K3trV1mEoyWSlWugBu+r/zDMQQ+t89/ppuVdYWjrR4op1kuFiCcs4ZV4pUXpJG3Qic8KyNWghbazsOMEkX6Z02UUXUbkJBUsu7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896209; c=relaxed/simple;
	bh=N+PHdZegDwRPRj0BgyP8qtooZeM9Z6Nh9dNMgXlrs1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GzxH7KRGbpKpQQ7IfcDOf7w/x+uLAI+3QAmmeM4c/kvm/iJrySxKZ2kyAOMAqNa4i1/jCJLVvq2zarkaYHP+Tq5e9vn4TeFCk+KdJAtKOKgmXfeQ3+UjEcppNMboyZIASdF2oXmTqcM6ZTNf9t/9shPtgqFVZan/5N+noqUK9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYMgam9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A44C4CEDD;
	Tue, 14 Jan 2025 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736896209;
	bh=N+PHdZegDwRPRj0BgyP8qtooZeM9Z6Nh9dNMgXlrs1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oYMgam9uofhNXQmMAoZayCPBKjpayABwHVsJ8ehDQod1Ir8ual/nQmSuDcEB97Qf7
	 kgiZbYvp2rHZYJ3FEJ3zJ9q+hucwwAzDvCKTIf65SA/oO6PDQyDcFOSxZn+VuDpaAH
	 8xxjR3jgxTkDKpzdPaYePAQDC0vn1kV2MFl/00buGh2m1FHeVOGnnFl6SAf6Nzwy1b
	 uu3nYnHJ5FBQ0bq98SLc0dn41qc8z6VB+VIeOmt/FQAVYAESWFJPzQNqXy6dQ/p+eH
	 NUqn7ikbib5h1o/IM9Gs2+0YipEDdIAeSfeXzcmkHAsR+ktWJKeM2m+TBJWvFxjSzb
	 BvtMn6KnjBSEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED357380AA5F;
	Tue, 14 Jan 2025 23:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689623176.173844.1096542449271979587.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 23:10:31 +0000
References: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
In-Reply-To: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: kuba@kernel.org, louis.peens@corigine.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, qmo@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 09:18:39 +0300 you wrote:
> The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
> potentially have an integer wrapping bug on 32bit systems.  Check for
> this and return an error.
> 
> Fixes: 9816dd35ecec ("nfp: bpf: perf event output helpers support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] nfp: bpf: prevent integer overflow in nfp_bpf_event_output()
    https://git.kernel.org/netdev/net/c/16ebb6f5b629

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



