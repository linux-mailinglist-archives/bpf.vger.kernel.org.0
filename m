Return-Path: <bpf+bounces-14312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A177E2D7B
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4915428061B
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A966829CF3;
	Mon,  6 Nov 2023 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCYpFqWH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703CF2E40B
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C70E1C433C9;
	Mon,  6 Nov 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699300825;
	bh=83oqL36ezGP+VXiHCJ0NbzbKbQ/+6fHoFllpQBYwHCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GCYpFqWHu/hXvF/HmVR09Ow/aZ7v160KKgPYPPBlU9j4GM29BAA0mCv5USBKViR/a
	 yls/9qV/3m2oXD1ZA956nrQeiLfbCT68LBZSdXJJK3En1r2EA6FfUoZlSld8nK6S7f
	 Ev1T97sf4FU8HUiOKGtfbs87QAZWer15MWAwCj2QHUaTE19yYHJeTD8mqxScemydmT
	 8HjiuEFJntylLX3fz+jPN3zGv8wfwUrbenVU4kytVemjqOSqaFqIO/AXO1A0V++Z6c
	 qNRp/elX4T7r2ipW9ecjvxJ1bgwPFJXgB+ETCpcKhL7pCUC82mcVEyI06cWPbNxpn5
	 o1EUhTIjow1cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9609E00087;
	Mon,  6 Nov 2023 20:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, lpm: fix check prefixlen before walking trie
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169930082568.2779.10528286905631002464.git-patchwork-notify@kernel.org>
Date: Mon, 06 Nov 2023 20:00:25 +0000
References: <20231105085801.3742-1-dev@der-flo.net>
In-Reply-To: <20231105085801.3742-1-dev@der-flo.net>
To: Florian Lehner <dev@der-flo.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, david@readahead.eu,
 davem@davemloft.net, daniel@zonque.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  5 Nov 2023 09:58:01 +0100 you wrote:
> When looking up an element in LPM trie, the condition 'matchlen ==
> trie->max_prefixlen' will never return true, if key->prefixlen is larger
> than trie->max_prefixlen. Consequently all elements in the LPM trie will
> be visited and no element is returned in the end.
> 
> To resolve this, check key->prefixlen first before walking the LPM trie.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, lpm: fix check prefixlen before walking trie
    https://git.kernel.org/bpf/bpf-next/c/856624f12b04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



