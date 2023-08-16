Return-Path: <bpf+bounces-7926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C0C77E931
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384E41C20DC8
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8968217721;
	Wed, 16 Aug 2023 19:00:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BF3D60;
	Wed, 16 Aug 2023 19:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79FD3C433C8;
	Wed, 16 Aug 2023 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692212428;
	bh=rEdul0JpWo7UI26UCX+q00I+G+ygegw9aObVQvYySQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HTi8CWJQFmhUdke7qA/SrQiU5COF+gwJ7Tdlwl5X9rh1Zm6plgklArcrTsArFqx5I
	 piJ2OTVJj19Ah/2MScXA854R3eb8qaKx2WXDPNeiI08fmTpqZ+gptxBVZ7TzTmGyi2
	 sQhmBQQb57HYAmEPaZCMdzrUG8ijso96fEUMEEFWGyChPfWKhoeuY0wVF/S3RuIpef
	 4Uhtb5iT0vGSLoRQIBtfh9PU1BMjolhvnKpEXE9xnncDvz9wXHlnzJ0krxFsxxHVgw
	 ZVQik7R6HdSylHFVaa1PTRyED9XhDJMGP9Pgq7c9XbPR2dxi0DJcPb/Vy55O1xY3qN
	 iNha9n9uHj+KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D2BAE93B39;
	Wed, 16 Aug 2023 19:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v14 0/4] bpf: Force to MPTCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169221242837.25657.8139131994909389115.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 19:00:28 +0000
References: <cover.1692147782.git.geliang.tang@suse.com>
In-Reply-To: <cover.1692147782.git.geliang.tang@suse.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 revest@chromium.org, jackmanb@chromium.org, matthieu.baerts@tessares.net,
 martineau@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, john.johansen@canonical.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, mykolal@fb.com,
 shuah@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 16 Aug 2023 09:11:55 +0800 you wrote:
> As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:
> 
> "Your app should create sockets with IPPROTO_MPTCP as the proto:
> ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
> forced to create and use MPTCP sockets instead of TCP ones via the
> mptcpize command bundled with the mptcpd daemon."
> 
> [...]

Here is the summary with links:
  - [bpf-next,v14,1/4] bpf: Add update_socket_protocol hook
    https://git.kernel.org/bpf/bpf-next/c/0dd061a6a115
  - [bpf-next,v14,2/4] selftests/bpf: Add two mptcp netns helpers
    https://git.kernel.org/bpf/bpf-next/c/97c9c652089b
  - [bpf-next,v14,3/4] selftests/bpf: Fix error checks of mptcp open_and_load
    https://git.kernel.org/bpf/bpf-next/c/207746550262
  - [bpf-next,v14,4/4] selftests/bpf: Add mptcpify test
    https://git.kernel.org/bpf/bpf-next/c/ddba122428a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



