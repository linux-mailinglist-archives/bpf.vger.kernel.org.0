Return-Path: <bpf+bounces-6780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DD76DE3C
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 04:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8F01C213DD
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 02:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B37469;
	Thu,  3 Aug 2023 02:30:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F08C09;
	Thu,  3 Aug 2023 02:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0AEFC433C7;
	Thu,  3 Aug 2023 02:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691029821;
	bh=aOYpkIHh/DPbsxHUKna75zI7rjpRLM5Mkvu+b1TwdCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cf3SYePTjJjzCoHKr6jzywybKWLiWijzqWO7GEKNzaQbRKy3Citemkb0V/D3DEUzc
	 JIWxXQxMaVLkAdJcmiIQgIp7lZX3X6gC+LPG1ZPumf62DB4l0yO1LkDbSSFZgUxamV
	 qerPnacB/KZwef5wuFQr/Plij9BUyydZquQTmaDhoQUuQUUzpF9TEc1AL0Yjx2uSeN
	 HPwf8cCtMmCFKIzdYWhAgznNN7vbskpk+5tB4Z9vCl/F4LmuLrAr60E8R+UHYfxc/N
	 oVFnTQRYdNMKBJpb8Cw8HYqNBJIDm5EVhFMdZwxAZl8idm1n7NEGTaUOOZZUkj6saZ
	 M6NpmDs7zWDtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E318E270D1;
	Thu,  3 Aug 2023 02:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp: Fix __ip_append_data()'s handling of
 MSG_SPLICE_PAGES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169102982164.22584.2159457611636116632.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 02:30:21 +0000
References: <1420063.1690904933@warthog.procyon.org.uk>
In-Reply-To: <1420063.1690904933@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com, bpf@vger.kernel.org,
 brauner@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Aug 2023 16:48:53 +0100 you wrote:
> __ip_append_data() can get into an infinite loop when asked to splice into
> a partially-built UDP message that has more than the frag-limit data and up
> to the MTU limit.  Something like:
> 
>         pipe(pfd);
>         sfd = socket(AF_INET, SOCK_DGRAM, 0);
>         connect(sfd, ...);
>         send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE);
>         write(pfd[1], buffer, 8);
>         splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);
> 
> [...]

Here is the summary with links:
  - [net] udp: Fix __ip_append_data()'s handling of MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net/c/0f71c9caf267

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



