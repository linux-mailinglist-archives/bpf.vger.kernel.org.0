Return-Path: <bpf+bounces-9173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D5791318
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381CE280FA4
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ACD17C3;
	Mon,  4 Sep 2023 08:13:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684910F5;
	Mon,  4 Sep 2023 08:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 799A3C433C9;
	Mon,  4 Sep 2023 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693815229;
	bh=+xoreAuRXKCrxhUSEJeksQA8D7ndz7hYj3wEgwRwgt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jSN3BwlF4N8GjTKe6YO8gJUDmsJvok033ElMNErClgSoqkcR2OYL+3VukQSuGKw8O
	 lFBKt3LIQ3shLbBDzQy3FRcJH4J7cn3gGWDAd3qv9qvSXYnTtd+z+kRQ6X1F4aysMT
	 rhYUH9TkTa3HlbRIvdwiqNpCv4D9E5ejv9/jnnNAdz8TG1EYZQwHb4eDij/bS85EKS
	 S9lOnuAL0nB+s/jSmZ45Qaz3gbAlNAe103QhdqeOmgptzjch2Hwwnm1dq9SNRwzIpj
	 BA9nyu+EF7ZPt9sV4dTc79sja9WcxLZKRebyOTXlkeTonk9h0SmGNBy7kXlLx/t9wT
	 GqxAw/MgZaSTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FDD1C04DD9;
	Mon,  4 Sep 2023 08:13:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: sockmap, fix skb refcnt race after locking changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169381522938.3122.223485705283897635.git-patchwork-notify@kernel.org>
Date: Mon, 04 Sep 2023 08:13:49 +0000
References: <20230901202137.214666-1-john.fastabend@gmail.com>
In-Reply-To: <20230901202137.214666-1-john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: olsajiri@gmail.com, xukuohai@huawei.com, eddyz87@gmail.com,
 edumazet@google.com, cong.wang@bytedance.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  1 Sep 2023 13:21:37 -0700 you wrote:
> There is a race where skb's from the sk_psock_backlog can be referenced
> after userspace side has already skb_consumed() the sk_buff and its
> refcnt dropped to zer0 causing use after free.
> 
> The flow is the following,
> 
>   while ((skb = skb_peek(&psock->ingress_skb))
>     sk_psock_handle_Skb(psock, skb, ..., ingress)
>     if (!ingress) ...
>     sk_psock_skb_ingress
>        sk_psock_skb_ingress_enqueue(skb)
>           msg->skb = skb
>           sk_psock_queue_msg(psock, msg)
>     skb_dequeue(&psock->ingress_skb)
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: sockmap, fix skb refcnt race after locking changes
    https://git.kernel.org/bpf/bpf/c/a454d84ee20b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



