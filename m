Return-Path: <bpf+bounces-44808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBAD9C7CEE
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 21:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015DEB2650A
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A54206E9B;
	Wed, 13 Nov 2024 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O05qIxGI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD36206959;
	Wed, 13 Nov 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529821; cv=none; b=FDfrV+DlQFnQasAapHtqRfNMFzZ5NnjUitL8HyMaYYKXv1xC2bnh1f4jMwOkZ1bLgcg6CR6fBQN8HUSbJ0aqErY5fmIIEWBD79+cGUIGsZRK/m9zzvHJd7lg1193w7G4GO1E+gFiDLVdH4w+oq78PJK9MAu/FSGbOAnj+527Y/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529821; c=relaxed/simple;
	bh=BMFiPrB4Na0d1C7B2s4SQ1QzAxoyuV8RLIyEnda0nYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qiV2KB9vlMV1t6NzlrPoF6yo20d/FkXnI6+w2KeoWf4YgyP2BbPHmNYR99GeDzGWj/bZ1nmJYS+Gtyn3GM5VqLYs3NK9amMKNDxzWmbmkkf0Edi8vV7bYdw1dI5+kgeEzo3vSHWSPfB54VocpE0JYFlM4QyO6O/VJWGy6Hnsnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O05qIxGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E744C4CED9;
	Wed, 13 Nov 2024 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731529820;
	bh=BMFiPrB4Na0d1C7B2s4SQ1QzAxoyuV8RLIyEnda0nYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O05qIxGIFULFGUet/t46igu2m0L2MkoEsGMOgoFtTK09FJMjHpsMWrhq3o+S+I14M
	 3WJh62Zwt0CUujInkCDSUXTFMnhTiW8ScdYdV7PX1G2YAvBoRvnBQCavjmIC/OTJEB
	 UkCv9XeZOUMZM6VQ9n894hg/DHzXoi22JbnOCPma6XlVUXdLnVpf52qBqIXSvhq4BR
	 eltb8Js06NmKvMQL9qorN2aSmHWGudv/90Hdnw/zhlfyw/EpmTr62QUD5H8e09j3x9
	 TVXjQ5QQXqci5zuljvZ6BSk1CHSK5GelfiQIvvyva9FeQUnmxZukkSQnp51tKzf1h4
	 d1CK5dPxgPTZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A793809A80;
	Wed, 13 Nov 2024 20:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf: Remove unused variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173152983100.1375566.8250232989587778107.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 20:30:31 +0000
References: <20241111062312.3541-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241111062312.3541-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 10 Nov 2024 22:23:12 -0800 you wrote:
> These variables are never referenced in the code, just remove them
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  samples/bpf/tc_l2_redirect_kern.c | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - samples/bpf: Remove unused variables
    https://git.kernel.org/bpf/bpf-next/c/3fcfbfe307dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



