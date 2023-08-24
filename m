Return-Path: <bpf+bounces-8490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CFB787499
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A44F2815B0
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA401426D;
	Thu, 24 Aug 2023 15:50:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377614263;
	Thu, 24 Aug 2023 15:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE857C433C9;
	Thu, 24 Aug 2023 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692892227;
	bh=VDf/P57UBTNUWaNujy/UboLHBn6h3liQaPxetBBlPTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gDjEtq5SnuQXXUak3ZMINPc+egP6xJUD2yOUDHAOyKnbXOlF9rDKxXWDujoa2Elz9
	 YCoN1K42kZTXgCtGSaYvWddHdiT0LQkOA+/M+IlpqdoZHJ38m07X90TERuXkxsVJTJ
	 iOZaZVC/of8WRbBrWU6PxsEXNo2P9E+SJFGKTpcKdibutqZbGTcgq+Ps4NvCfnbec3
	 gtjJ8jfY3sSJ4Rnqg37HiH+6RVXBdydHkmENrq6+yMgZIxeG0J9BSSumzG7ceVxxYy
	 QsEtaeE9RuCOKUeD4J649nIMBXv5Key4q9Ggm05wnLA0bMKHIstUx1N74P+f+lRqhe
	 dqsrNwcKzPuTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B00FE33094;
	Thu, 24 Aug 2023 15:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/7] samples/bpf: Remove unmaintained XDP sample
 utilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169289222756.26245.8888733528089186580.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 15:50:27 +0000
References: <20230824102255.1561885-1-toke@redhat.com>
In-Reply-To: <20230824102255.1561885-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Aug 2023 12:22:43 +0200 you wrote:
> The samples/bpf directory in the kernel tree started out as a way of showcasing
> different aspects of BPF functionality by writing small utility programs for
> each feature. However, as the BPF subsystem has matured, the preferred way of
> including userspace code with a feature has become the BPF selftests, which also
> have the benefit of being consistently run as part of the BPF CI system.
> 
> As a result of this shift, the utilities in samples/bpf have seen little love,
> and have slowly bitrotted. There have been sporadic cleanup patches over the
> years, but it's clear that the utilities are far from maintained.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] samples/bpf: Remove the xdp_monitor utility
    https://git.kernel.org/bpf/bpf-next/c/e7c9e73d0822
  - [bpf-next,v3,2/7] samples/bpf: Remove the xdp_redirect* utilities
    https://git.kernel.org/bpf/bpf-next/c/91dda69b08de
  - [bpf-next,v3,3/7] samples/bpf: Remove the xdp_rxq_info utility
    https://git.kernel.org/bpf/bpf-next/c/0e445e115f8f
  - [bpf-next,v3,4/7] samples/bpf: Remove the xdp1 and xdp2 utilities
    https://git.kernel.org/bpf/bpf-next/c/eaca21d6eee9
  - [bpf-next,v3,5/7] samples/bpf: Remove the xdp_sample_pkts utility
    https://git.kernel.org/bpf/bpf-next/c/cced0699cbf1
  - [bpf-next,v3,6/7] samples/bpf: Cleanup .gitignore
    https://git.kernel.org/bpf/bpf-next/c/91b965136d53
  - [bpf-next,v3,7/7] samples/bpf: Add note to README about the XDP utilities moved to xdp-tools
    https://git.kernel.org/bpf/bpf-next/c/5a9fd0f778eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



