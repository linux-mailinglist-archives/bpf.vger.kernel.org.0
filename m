Return-Path: <bpf+bounces-11179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4C37B48D0
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 19:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C953E281E6F
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B981805A;
	Sun,  1 Oct 2023 17:20:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFCBD290;
	Sun,  1 Oct 2023 17:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D0EAC433C9;
	Sun,  1 Oct 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696180823;
	bh=QYgny6PwNamG5NS8GHQ8VLOhaddeQzPUUx73boo7bBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K/piiXxbampS+I1nE0kyK+HeWXLbcdtdnG/g/neTS/MFDlM/HPyr1hcO2lwtb63wa
	 rt1sGW494KFWSPkqQ/it+E9Y5RlwaTNsHF4Wp4enzX/PnvP0vh7qTg2tSdsdfptrQs
	 ijCkeKQ4rOLMlT+gtrso3TSxicJaFN6Y9oDoz/f1GXLRwXTqIoIdo1d5tLykpqodML
	 kCBuKeQZmnCNMyXKqD8tmSsNZKUJxi2oiAleAGaksmx2vUFzz6hFnAcMlCxiNq3Mrk
	 RHDHIdlWtsOLPAPcRhhgl7Yyk7kMnqerTtuDL2j+pB5vFGdLHiDEdlOHSpErEC/566
	 kqTAGos+F/MOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 019AAC64457;
	Sun,  1 Oct 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv4,
 ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169618082300.17513.8154196586548656981.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 17:20:23 +0000
References: <730408.1695292879@warthog.procyon.org.uk>
In-Reply-To: <730408.1695292879@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org,
 syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, bpf@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 11:41:19 +0100 you wrote:
> Including the transhdrlen in length is a problem when the packet is
> partially filled (e.g. something like send(MSG_MORE) happened previously)
> when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> transport header or account for it twice.  This can happen under some
> circumstances, such as splicing into an L2TP socket.
> 
> The symptom observed is a warning in __ip6_append_data():
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
    https://git.kernel.org/netdev/net/c/9d4c75800f61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



