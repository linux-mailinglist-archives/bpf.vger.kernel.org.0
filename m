Return-Path: <bpf+bounces-9098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A1078F8EE
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 09:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FA2281807
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877698482;
	Fri,  1 Sep 2023 07:10:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E75235;
	Fri,  1 Sep 2023 07:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E78CC433C9;
	Fri,  1 Sep 2023 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693552226;
	bh=1NIUPeYWfQmfUVrTaj0Uv33j5+UiYwZCFZQXznl1PQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rdjV9FrvtVqBOaFrOZYU2go+ZiG5lhdjCizz3KD83nTdKcFhAFYLTCRGiecni2NZE
	 mV0UQa7ugcUzHppw7EGO0SWFQI2KptP89cP9O0C7Z7ofjdgmN0t/q0wqlnTHHQLs4w
	 8GiDbXJqgMAZucwzf/c3jcy8ur6O5Ytp9XNBRHEMbasaF47VtVawfDlu+KqPkE5AJ/
	 yJBVVe7KIsvq2GQ/a+l3bMfmi5mVgevTGCeWUKNdkIktMmyof5QJKQzB/g8x2YIJEg
	 MmGo1dwNJUDOmHoXdTEkd1E4EnVtaZlvxXNQqxBpgwldkh4BQ/gmPbVMb6BDGgB50s
	 76JGh0lZQc1RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BBDBC595D2;
	Fri,  1 Sep 2023 07:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] skbuff: skb_segment,
 Call zero copy functions before using skbuff frags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169355222610.20762.15768271551540080758.git-patchwork-notify@kernel.org>
Date: Fri, 01 Sep 2023 07:10:26 +0000
References: <20230831081702.101342-1-mkhalfella@purestorage.com>
In-Reply-To: <20230831081702.101342-1-mkhalfella@purestorage.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: willemdebruijn.kernel@gmail.com, alexanderduyck@fb.com,
 bpf@vger.kernel.org, brouer@redhat.com, davem@davemloft.net,
 dhowells@redhat.com, edumazet@google.com, keescook@chromium.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, willemb@google.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 02:17:02 -0600 you wrote:
> Commit bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions
> once per nskb") added the call to zero copy functions in skb_segment().
> The change introduced a bug in skb_segment() because skb_orphan_frags()
> may possibly change the number of fragments or allocate new fragments
> altogether leaving nrfrags and frag to point to the old values. This can
> cause a panic with stacktrace like the one below.
> 
> [...]

Here is the summary with links:
  - [v3] skbuff: skb_segment, Call zero copy functions before using skbuff frags
    https://git.kernel.org/netdev/net/c/2ea35288c83b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



