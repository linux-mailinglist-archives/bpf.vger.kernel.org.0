Return-Path: <bpf+bounces-26148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723589B84A
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 09:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742F3B20F68
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8338FA0;
	Mon,  8 Apr 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlcSEdIZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE838DF2;
	Mon,  8 Apr 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560827; cv=none; b=uT1g19Sq3UbV12u5/YcxXUIf2O5CF9QMPs6luZdkpUAa/0fVL34gKhSprsdFbQYrqZ/irp0OIS+p02DICvt9cnycjhlsl1oz9wXUpXICziIFf+9wMJSwPAOhtuTuB74dvK4Imfg757PlWCpPpKapf0fpWzi6/b92GaUC/c3vCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560827; c=relaxed/simple;
	bh=FSP4VNCUPpDOWOFJNrszALczx7muCHcRdQcUv4lU88w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dFOkLA8LGx5ahn2W2ZKRKwVtt7Sv+rQYCYpySjlEse5ToIi8TUw7MSvFEH/rq+2Tou/sRbpAavSq0lmbaqUIE1Wuq9ll0y63bH0DmO4ZK7RFOUsEJ8Hw2ZdPdhYXeKvkHZcCj/8Hqjdz36Uc7xjg98TS71yh9oihSMW+10b1mCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlcSEdIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0167C43399;
	Mon,  8 Apr 2024 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712560826;
	bh=FSP4VNCUPpDOWOFJNrszALczx7muCHcRdQcUv4lU88w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jlcSEdIZWdlxUIJf9BtyHUh0zJ0TYkYNuB5zVMnTNTACN4HaQDrKzier4g9rfMgzn
	 omJm+m2fGpOEPf0/Kh7Bpkl7O5b/q77hnzDqFQokqQ8/lfBN6gg6ke9ZS2zSEDg5NW
	 fVvoMnVpWzsg8Ha+mqb4hr9K/qdxquDbZjRB2Apr/R6tZUJFmb2DJe/16ulaZZAXEt
	 QnCdCNzto2iVdaufm+SnAMzuE4n93+j3+BIP7V5aJaWu3WkHob3jd28ht6j81TVwQP
	 9L5h7hud72xy2xAbHNSHPWYOGMUsDemPYEtdYPRc5CWpkH57WQhItEdR5c5bWtyKmT
	 MSsMD2aqWecEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC4E0D7982E;
	Mon,  8 Apr 2024 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bpf,
 skmsg: fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171256082676.1075.10414740476017882208.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 07:20:26 +0000
References: <20240404021001.94815-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240404021001.94815-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: john.fastabend@gmail.com, edumazet@google.com, jakub@cloudflare.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, kernelxing@tencent.com,
 syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  4 Apr 2024 10:10:01 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue() which
> syzbot reported [1].
> 
> [1]
> BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingress_enqueue
> 
> [...]

Here is the summary with links:
  - [net,v2] bpf, skmsg: fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
    https://git.kernel.org/bpf/bpf/c/6648e613226e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



