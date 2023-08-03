Return-Path: <bpf+bounces-6845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A0976E99D
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E53F1C21537
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0151F16C;
	Thu,  3 Aug 2023 13:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C21ED51;
	Thu,  3 Aug 2023 13:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 383D2C433C8;
	Thu,  3 Aug 2023 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691068221;
	bh=zJq+7MHzjebZFTJ3+CcDRXVZzxlvDho72oqWr9mesO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SVUCI//OsHkUay0eCPcq7hyihL/dnpSISjlvafir7TNzgKr6krpnN7O1CEzyX1cOs
	 0qYKyC5EoL6LmYRC238BW9ddC2U6v53zUgb7LNimftPrKFNB6j36/smZKrrK9LVSLx
	 MhGwBwAy/uS5ZCVkb2cYYj5xgOJxbpZLYVZpp32TbOlMTQh79TO+6wQXwADhEgS5rP
	 MQFagNyOnOrCzAk43HZ1R6Xwzs1gnBAzp0pAEAVvX/7xLdQDby6iXttC6qnXMhBUdp
	 xYSzobqnoSRFrxfB7zfHlB6BEjal51h5jgFmD9XPg7x8iv0qb/SRedoHy8tZaGI/vK
	 pJ1b6NUqzoIRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1951CC41620;
	Thu,  3 Aug 2023 13:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp6: Fix __ip6_append_data()'s handling of
 MSG_SPLICE_PAGES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169106822109.11210.4147932489626206535.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 13:10:21 +0000
References: <1580952.1690961810@warthog.procyon.org.uk>
In-Reply-To: <1580952.1690961810@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com, bpf@vger.kernel.org,
 brauner@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 02 Aug 2023 08:36:50 +0100 you wrote:
> __ip6_append_data() can has a similar problem to __ip_append_data()[1] when
> asked to splice into a partially-built UDP message that has more than the
> frag-limit data and up to the MTU limit, but in the ipv6 case, it errors
> out with EINVAL.  This can be triggered with something like:
> 
>         pipe(pfd);
>         sfd = socket(AF_INET6, SOCK_DGRAM, 0);
>         connect(sfd, ...);
>         send(sfd, buffer, 8137, MSG_CONFIRM|MSG_MORE);
>         write(pfd[1], buffer, 8);
>         splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);
> 
> [...]

Here is the summary with links:
  - [net-next] udp6: Fix __ip6_append_data()'s handling of MSG_SPLICE_PAGES
    https://git.kernel.org/netdev/net-next/c/ce650a166335

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



