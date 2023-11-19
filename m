Return-Path: <bpf+bounces-15331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED57F08C6
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 21:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082721C20869
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11519BCC;
	Sun, 19 Nov 2023 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j45PWymq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D1199BD;
	Sun, 19 Nov 2023 20:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13EC5C433C7;
	Sun, 19 Nov 2023 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700424624;
	bh=RfcmcSJXbNshmCCmuIQ3OLjalTX/zBZa+mvG0+u9+OQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j45PWymqb1xFb4zs9J1IsJFg8HnooUak2A+BOQquFgMsnDmBkA/r2GHxyRsPbiMwz
	 1tNm/mpxE8jdAzOzOV0JVzh3Jxst2rwdYWekOb0BZS79Q+FAdSbcgfP64yy/KALD48
	 4icnL9dHKIgrw3/g/JXuDxTwdS2H+tl3Mp9JuplIkuE9q4gOnDksLeVWDeEsXUwRhW
	 K5xrICNaBvCnx/1/YmlSa67kSdLhrRcRkVbW2Q+ewBH3dnrW4KVZ2VnUpRWJN+9yAn
	 gWbzAnqavepenz6VDL01VAXVw74N1vt1X0fkZTp//ZFghNrjM3ZXsOR3tnocCGNZXB
	 7r7xXBklox58g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED963C4316B;
	Sun, 19 Nov 2023 20:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170042462396.21508.74186037666655435.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 20:10:23 +0000
References: <20231119033006.442271-1-kuba@kernel.org>
In-Reply-To: <20231119033006.442271-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, marcelo.leitner@gmail.com, lucien.xin@gmail.com,
 kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 jmaloy@redhat.com, ying.xue@windriver.com, sgarzare@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 kuniyu@amazon.com, mptcp@lists.linux.dev, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 virtualization@lists.linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 18 Nov 2023 19:30:06 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to all the sock diag modules in one fell swoop.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> CC: matttbe@kernel.org
> CC: martineau@kernel.org
> CC: marcelo.leitner@gmail.com
> CC: lucien.xin@gmail.com
> CC: kgraul@linux.ibm.com
> CC: wenjia@linux.ibm.com
> CC: jaka@linux.ibm.com
> CC: alibuda@linux.alibaba.com
> CC: tonylu@linux.alibaba.com
> CC: guwen@linux.alibaba.com
> CC: jmaloy@redhat.com
> CC: ying.xue@windriver.com
> CC: sgarzare@redhat.com
> CC: bjorn@kernel.org
> CC: magnus.karlsson@intel.com
> CC: maciej.fijalkowski@intel.com
> CC: kuniyu@amazon.com
> CC: mptcp@lists.linux.dev
> CC: linux-sctp@vger.kernel.org
> CC: linux-s390@vger.kernel.org
> CC: tipc-discussion@lists.sourceforge.net
> CC: virtualization@lists.linux.dev
> CC: bpf@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules
    https://git.kernel.org/netdev/net/c/938dbead34cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



