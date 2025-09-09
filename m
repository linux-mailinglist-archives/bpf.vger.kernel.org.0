Return-Path: <bpf+bounces-67931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B37B5057B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D31E1C67ED5
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00AB2FE058;
	Tue,  9 Sep 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLoCs8Kk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69395301008
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443206; cv=none; b=QlqAx1OSJGGkA+rZetTkj/ErTCdHI6Sbz1p+OMSU9d4uHcbiD8hrfilA59tZp2sIT+F++Ny7FT4unfnykp2xapc016Ad+SmkJ2PlCtlAAvPI8MpVG0pRLAxsSlTt3NFgG85af4LSMsvQRJdlrxKNEVlRtq9dKRn05jL0uWzE1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443206; c=relaxed/simple;
	bh=oE6xKfvu8kUkll63Q0vMQeBZ8O7emnAhfuih17WMssM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3AbxuCcv/MnctshL7x4g3DwaZjA6VCDOnZxK4Kt/vjgjR00dm5brXmiE8bcS/03/l3Bxi6w4IaXJ5KszxCYDCi0+63MpsxUN4m4zGZZUakCWUva1U56xJVyVthnXpRCghEOZnpvPFcKyNehhhMnFHM6GxewCXKIsRfphlDin+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLoCs8Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F291AC4CEF4;
	Tue,  9 Sep 2025 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757443206;
	bh=oE6xKfvu8kUkll63Q0vMQeBZ8O7emnAhfuih17WMssM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BLoCs8KkbmYj8lQ1QEaTFmw5Xha1Oi7yWIx+AxTH/uqGI1RyjwB90F+BgUn4PU5iM
	 fFCGRbK2NaSxh5Wd5IVOXILfAZj6P1ak7IMY1/0ap72JUVTIXsHCPytkxIl65D/aCp
	 ZZbIv7TBAXKX0bulp7YC61VP3w5u3Fb2+iTcst+H0cP8Z8u52uzoBXrrGmYb3uKQb0
	 v3wrfhhDIJOIZiVUJ3/ObuP9j+D0eQyWbxqb6tl02kp7qrXOOB3L6YZ+m86YPT1zeX
	 LQkPnDzCu+mnDA03oaQ7778qpJ+0UMFwcPEN2vu60jy5NyJKeq0b9XM2jmw+iI5hOO
	 /hiSueGhnutTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F18383BF69;
	Tue,  9 Sep 2025 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: remove Mykola Lysenko from BPF
 selftests maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175744320925.783799.16292442885494310557.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 18:40:09 +0000
References: <20250909171638.2417272-1-eddyz87@gmail.com>
In-Reply-To: <20250909171638.2417272-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Sep 2025 10:16:38 -0700 you wrote:
> Unfortunately Mykola won't participate in BPF selftests maintenance
> anymore. He asked me to remove the entry on his behalf.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] selftests/bpf: remove Mykola Lysenko from BPF selftests maintainers
    https://git.kernel.org/bpf/bpf/c/78c2ef58b395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



