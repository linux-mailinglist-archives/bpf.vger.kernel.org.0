Return-Path: <bpf+bounces-60211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93BAD4013
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E01896EC7
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E2C24397B;
	Tue, 10 Jun 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVhf44G4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3E1FAC34;
	Tue, 10 Jun 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575399; cv=none; b=EQDT6mXzhGrRmzb2YHGKCcWK20RN1Q99eEc+TDhX6+TaoQ+BNFSMOcaL5lYcK9cDYlC260ylmiS+SFfjcsI9peu3qTwZraD8qUw3mKnv8XKHZDc1DFZ5I1TeKXS/NzeQAxVt+R7s9LCa9iFFaEjfMFcupMDTojBbDN2hxXJX+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575399; c=relaxed/simple;
	bh=92Pz6pj4TO5Cq4bz9dNFnrb+WOjBbXMZF/wKtdVuqQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O2DA6fBrUWFqcfzUHyh7DC4Gm3mxXNVBexL9mrMo4jgZoMZkQlS2qpD2RTcN64pQhHiWUGQCY6S+eb2H/FSVn84YnoOt59VcdZreMFwH53T8cX0POnyxb4LNeg4RTL4IP5hE68isRZJ/GsTK348wpxFk9KMjC2L9SRKGLkRTRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVhf44G4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED4CC4CEED;
	Tue, 10 Jun 2025 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749575398;
	bh=92Pz6pj4TO5Cq4bz9dNFnrb+WOjBbXMZF/wKtdVuqQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BVhf44G47lIsVjLvYmZ61KEvvflS7qCVvIRoJYpxmCjwQUqo13vaKXl0N8Y7X1CgW
	 BTrW2Y35i8D9UmC26pw/kFAbMNf46fG/5CIL1MX+PKyH9teYOh3n7JkJzDpJg4RvMt
	 /HmaIHKpR4A74Kvbc8afLr74AH9e4UTcZS0Lbs2nLooQObwHdYxhUurS2MrPJOWMOq
	 yT7LtQeEci1Je+MjVImCZRQMqr+tltQsPCcgfOQRrgTsnOhx8SWf3oumvuHZ3MTkO5
	 D/Rqau3np3piUyDLv8vrgcYpkOkHVO1JVoipQjF8uYEPl04m0Q4wExyTTsGFfo4OpN
	 T0WXFSwX4UutA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1839D6540;
	Tue, 10 Jun 2025 17:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tools/resolve_btfids: Fix build when cross compiling
 kernel with clang.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174957542901.2523637.9194820826653322315.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 17:10:29 +0000
References: <20250606074538.1608546-1-suleiman@google.com>
In-Reply-To: <20250606074538.1608546-1-suleiman@google.com>
To: Suleiman Souhlal <suleiman@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, masahiroy@kernel.org,
 irogers@google.com, ssouhlal@freebsd.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Jun 2025 16:45:38 +0900 you wrote:
> When cross compiling the kernel with clang, we need to override
> CLANG_CROSS_FLAGS when preparing the step libraries.
> 
> Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
> when building tools in parallel"), MAKEFLAGS would have been set to a
> value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
> fact that we weren't properly overriding it.
> 
> [...]

Here is the summary with links:
  - [v2] tools/resolve_btfids: Fix build when cross compiling kernel with clang.
    https://git.kernel.org/bpf/bpf/c/a298bbab903e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



