Return-Path: <bpf+bounces-11115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39157B368C
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5E435289154
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7851B9E;
	Fri, 29 Sep 2023 15:20:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993851B81;
	Fri, 29 Sep 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 756F1C433CA;
	Fri, 29 Sep 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696000825;
	bh=veHmvNjRCXlUnmj73YP54u2aUsx7T4nL8WTSUfmBVsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cfl+a46kcur4cPMqgH9CPgVT6q3GZ1HDacoyzhCZeYm0G7IIY6zFQchrHNJEO/Ez7
	 WdFL1dH0YgrjVzgVnmoGTcaSV0HRatj8EjkNvIJP35zdIKaL41apqKNI3yHE8PLUOk
	 sIoopB3TG+Yu0mrqI8ru/QBRSB2UJzq3dFzR7XWeIgOV3aSNDGfWW4PkwtQHGRTbfE
	 bH5dSC1xfdvZaknyazJqE3aJS7lppdXlDXGTKdo+ohqBoMv6Rp7pCqwMUC8HrKhfNy
	 XwcAQEeow95/cBR9nA8ckXJS+PbV71+fMOL0J0DXyKDVTQHqZ7m7zZCMPTKNAB+oYV
	 ra6MnQKXc/PkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A6D3C395C8;
	Fri, 29 Sep 2023 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf,
 sockmap: Reject sk_msg egress redirects to non-TCP sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169600082536.24887.16932433184368539961.git-patchwork-notify@kernel.org>
Date: Fri, 29 Sep 2023 15:20:25 +0000
References: <20230920102055.42662-1-jakub@cloudflare.com>
In-Reply-To: <20230920102055.42662-1-jakub@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 john.fastabend@gmail.com, cong.wang@bytedance.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 20 Sep 2023 12:20:55 +0200 you wrote:
> With a SOCKMAP/SOCKHASH map and an sk_msg program user can steer messages
> sent from one TCP socket (s1) to actually egress from another TCP
> socket (s2):
> 
> tcp_bpf_sendmsg(s1)		// = sk_prot->sendmsg
>   tcp_bpf_send_verdict(s1)	// __SK_REDIRECT case
>     tcp_bpf_sendmsg_redir(s2)
>       tcp_bpf_push_locked(s2)
> 	tcp_bpf_push(s2)
> 	  tcp_rate_check_app_limited(s2) // expects tcp_sock
> 	  tcp_sendmsg_locked(s2)	 // ditto
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets
    https://git.kernel.org/bpf/bpf/c/b80e31baa436

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



