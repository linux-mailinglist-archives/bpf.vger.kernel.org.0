Return-Path: <bpf+bounces-18978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977958239FC
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954C71C24A70
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CF1859;
	Thu,  4 Jan 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlTb4gSS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C635EDD;
	Thu,  4 Jan 2024 01:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6995C433CB;
	Thu,  4 Jan 2024 01:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330033;
	bh=FewGRaz0guvopeeGoS8vRCKya63jqoP/f1Dc08/JWyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UlTb4gSS6VTYhbNB0Gmy4vdfoqyRFyysObdCeNcOOD4OSTVDQa0ToTY5vmqMuHYIG
	 61WWvif97sUEChzIN/w3E54d/zwaZ6Z0oftalF8gXxwzwaHCz7O19+Z3PxgGkvXyHf
	 4nH9LzyrxqyOOrQY1BWA5nxtugxZPV6ANN+BYJ48RUV9Ivh+qu3YMUHlVOozyQlZjD
	 8u2Ob5iNFqNe54BiZF9f1x/PPuTaJKDTFLAeJnvfbzXtAUo9zYELHSAyKVBEpYsZxz
	 gHKMMAVx64yT7R35teS9o7A/GE7bYBJxgwl8+oOLTHWMTrEcMw36sRQyR2S3Kl/+mJ
	 7Uxr68VHobW/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCF17DCB6D8;
	Thu,  4 Jan 2024 01:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/5] fix sockmap + stream  af_unix memleak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433003377.5757.720867555256604448.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:00:33 +0000
References: <20231221232327.43678-1-john.fastabend@gmail.com>
In-Reply-To: <20231221232327.43678-1-john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: jakub@cloudflare.com, rivendell7@gmail.com, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 21 Dec 2023 15:23:22 -0800 you wrote:
> There was a memleak when streaming af_unix sockets were inserted into
> multiple sockmap slots and/or maps. This is because each insert would
> call a proto update operatino and these must be allowed to be called
> multiple times. The streaming af_unix implementation recently added
> a refcnt to handle a use after free issue, however it introduced a
> memleak when inserted into multiple maps.
> 
> [...]

Here is the summary with links:
  - [bpf,1/5] bpf: sockmap, fix proto update hook to avoid dup calls
    https://git.kernel.org/bpf/bpf-next/c/16b2f264983d
  - [bpf,2/5] bpf: sockmap, added comments describing update proto rules
    https://git.kernel.org/bpf/bpf-next/c/7865dfb1eb94
  - [bpf,3/5] bpf: sockmap, add tests for proto updates many to single map
    https://git.kernel.org/bpf/bpf-next/c/8c1b382a555a
  - [bpf,4/5] bpf: sockmap, add tests for proto updates single socket to many map
    https://git.kernel.org/bpf/bpf-next/c/f1300467dd9f
  - [bpf,5/5] bpf: sockmap, add tests for proto updates replace socket
    https://git.kernel.org/bpf/bpf-next/c/bdbca46d3f84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



