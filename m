Return-Path: <bpf+bounces-19699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8694282FE8C
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B94C287FEF
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5017FD;
	Wed, 17 Jan 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhbSBOPe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1D1385;
	Wed, 17 Jan 2024 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456226; cv=none; b=nGY3oyaz7T/P9jVZTcfCcqdudvKCZ/XPfkxqab3LAO2i+WFF5cMvGPwihMIlnimXc9P6bdEW3oDAqJxvUYA/OIrIep0b5IfTiUJoVV9vrsDQKS8HUQX6YL1ZhfDfbuvolwpY/t3Wt4fSdb86rsOhubdac57klRMMLJxfXg5NX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456226; c=relaxed/simple;
	bh=ZuJ/C2BNvb5acMxZ+Ac6bCq09yuZUqZ0t/BaYBL2um8=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TxxaETtJ1v1LLv2lnDyzN795D8qad+Cn3nEOR9Larajmg3XgnVrDArw5mHAse0KTfxlFVGmsWyiOZXXnOe0QE82LlYunSJQnM4Jnc5n/ZeDqGmdAhlSM1Hxfd7jsk09IdSk+BezU9aIQA1ClyHdCC+K4t1tJvuz1rKF9e88JGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhbSBOPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E54CC433C7;
	Wed, 17 Jan 2024 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705456226;
	bh=ZuJ/C2BNvb5acMxZ+Ac6bCq09yuZUqZ0t/BaYBL2um8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DhbSBOPenRuAM/3rkg+i7I0Y5+9MPOlTitg2lF9Lpj3kpEinEEg32xVAfUwcxE+EH
	 tFZO3/rqv3H+p0ts0ANUUFZ3pUfBh1cOBywEc45Zd/XEzH5YG5o3lURBeCQGV9+1md
	 9BxKGR+LGC8Md5HEI1GeN74YuGn9zsTU9FDjlT0dR+mhyTN0LDUwYT0COJGs1StVOi
	 GIE8Hhhmu6udl3EB2dLY2wE5vkq6pElnkihPv3Edy4Z2sCpqrJJVNbhN++XXB66Tzs
	 /F323qqw2jzENXUKdKytSvtzWIsuU4Odch62ZNNvjbOWznBO4nXaH3XfSH8J1wpa6C
	 RcnVnVezh7h9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25BBDD8C985;
	Wed, 17 Jan 2024 01:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 bpf-next 0/6] bpf: tcp: Support arbitrary SYN Cookie at TC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170545622615.24208.8311280954771361156.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 01:50:26 +0000
References: <20240115205514.68364-1-kuniyu@amazon.com>
In-Reply-To: <20240115205514.68364-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: edumazet@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, pabeni@redhat.com,
 kuni1840@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 15 Jan 2024 12:55:08 -0800 you wrote:
> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> for the connection request until a valid ACK is responded to the SYN+ACK.
> 
> The cookie contains two kinds of host-specific bits, a timestamp and
> secrets, so only can it be validated by the generator.  It means SYN
> Cookie consumes network resources between the client and the server;
> intermediate nodes must remember which nodes to route ACK for the cookie.
> 
> [...]

Here is the summary with links:
  - [v8,bpf-next,1/6] tcp: Move tcp_ns_to_ts() to tcp.h
    https://git.kernel.org/bpf/bpf-next/c/e8a7ea899527
  - [v8,bpf-next,2/6] tcp: Move skb_steal_sock() to request_sock.h
    https://git.kernel.org/bpf/bpf-next/c/2d1ee30a3b07
  - [v8,bpf-next,3/6] bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
    https://git.kernel.org/bpf/bpf-next/c/5f8b96b9b391
  - [v8,bpf-next,4/6] bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
    https://git.kernel.org/bpf/bpf-next/c/311ef79955d3
  - [v8,bpf-next,5/6] bpf: tcp: Support arbitrary SYN Cookie.
    https://git.kernel.org/bpf/bpf-next/c/b9c3eca5c086
  - [v8,bpf-next,6/6] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
    https://git.kernel.org/bpf/bpf-next/c/98af7dca1e0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



