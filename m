Return-Path: <bpf+bounces-56982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17490AA39F4
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 23:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168879C1136
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098926B960;
	Tue, 29 Apr 2025 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLWHhuxb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FF2528EC;
	Tue, 29 Apr 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962793; cv=none; b=mpaT5mC9lFjsmlGPHhncaiWsr5vkfcewEpN2+B6N6rSM2ctUbbd+Gv8/bCfaZLCKLjmE/OZwc8xzMN97CdIXBPYovceRjqnomtc2uTPr9/9+heGS9cUctoUpMtM7x+h2E39xiFUo1hvGz1LiB0Wd6M2S9Yvh1nzTL9QT/VhNBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962793; c=relaxed/simple;
	bh=RAx7Zevt4MDRSQBBDsoltAbofA76l+6apvnhqXBCE+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JjqciaXR5J8jGWIGa5ivQ/Hh8LzRFpE3zmCw5KkRi8s3ldnEZvLMxUODIuswyOFBJyqDIKefzfCYo+xf3R+OYPM3ROPzzGxiei+ivMjxLLs5r6SlEzoz7eCh1LWA/cDqjPJP2thHwsEYE/a9IwMgSXXXBcZr73PaYSiZbY2IgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLWHhuxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A57C4CEE3;
	Tue, 29 Apr 2025 21:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745962792;
	bh=RAx7Zevt4MDRSQBBDsoltAbofA76l+6apvnhqXBCE+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLWHhuxbmdOVcXLhXFCY47SMIR5lT68LqIZC/0b435p0RH31elOT1KKGdczMIdPel
	 TOQWBtrbo1A0MJKQYbn7tUq4zO/cgu9T/GTMfnNNK1ppkPqBR/7kPpNu89St+2PDCa
	 8F5BHFrbgluCRAZHjkQAPawK15eBie0AO9Ju/EZV0xvfdWvxIZQDbf1+1WEqk8Nlcv
	 jggMbBSRilz29+UstWOBIT8Fg4j59yg+lsyVGktigVDh8nvqmAi8esp3SgmyXwtn/v
	 a7Gr9q/uA1nZdq6iOs8qLR3zVKvO4G0UKkjjjokpzLhBhnOwjhLJh+S97hDD9d39Sz
	 JQhzhWe9Hm7rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCAD3822D4E;
	Tue, 29 Apr 2025 21:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] xsk: respect the offsets when copying frags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174596283150.1804413.6332242799239007270.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 21:40:31 +0000
References: <20250426081220.40689-1-minhquangbui99@gmail.com>
In-Reply-To: <20250426081220.40689-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, maciej.fijalkowski@intel.com, aleksander.lobakin@intel.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Apr 2025 15:12:18 +0700 you wrote:
> Hi everyone,
> 
> In commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb
> conversion"), we introduce a helper to convert zerocopy xdp_buff to skb.
> However, in the frag copy, we mistakenly ignore the frag's offset. This
> series adds the missing offset when copying frags in
> xdp_copy_frags_from_zc(). This function is not used anywhere so no
> backport is needed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] xsk: respect the offsets when copying frags
    https://git.kernel.org/netdev/net-next/c/ebaebc5eaf43
  - [net-next,v2,2/2] xsk: convert xdp_copy_frags_from_zc() to use page_pool_dev_alloc()
    https://git.kernel.org/netdev/net-next/c/7ead4405e06f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



