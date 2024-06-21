Return-Path: <bpf+bounces-32774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40717912FAE
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 23:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF21B20DDF
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC317C226;
	Fri, 21 Jun 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlk9BlKZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DFE208C4
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719006029; cv=none; b=jfkPAj8zFg4Wpbdv2E7O2tjVQ96+BW1X4g2i1D/uku5EKChPJpRMlyQjGyJ+6kAVRN5gz8O3cCpe7l8mlKHV5WXtLceE9AC/J8grcjSCipih8aTNAHcLwyYV5Ocbl67MW2B6EZFtWajRKWBwMfHU1Bd0OBAWFIzCvXO3CpXUb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719006029; c=relaxed/simple;
	bh=kqGatdkofBei8WLGqUZ8bnCMkbhDA59Wc5TWvjA/fjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k/FJnUjCz+NE0ChIsiWsY5IuBoniVJmiHhD9iNV7GcgRDztP+XusrYKVlJ13hMC0XSwYD2RCOQhtEpAH5BLG1HlAgEe5eVqJXm0JX5c6quxTka6qA2xlsTiP4cMvju9fdYoqERqFxiY2Zpwq2US+BcD2BmgGdQMmGvzqWhC6Pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlk9BlKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3935C4AF07;
	Fri, 21 Jun 2024 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719006028;
	bh=kqGatdkofBei8WLGqUZ8bnCMkbhDA59Wc5TWvjA/fjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tlk9BlKZTnAkqOLJGwoqHqdwAZISkHz54/eu5MvQxTRWXBUk+SxHCPKC1tgddM7CK
	 dwl4X40BCnXCj5oYdYB9hyOikJBk0AgXMDNtG6UwU07yNMAVTyPHOxe8oH0lNQU0Un
	 Lq07LXP/WlS8+L8dMZbEhVlCTTe4Z5Fi42iUo84hZFzau4vfX+/PweBppMXHNRNY4M
	 myRnYQ1Q4dLA12w/yQ1ke4Wv30FVp2rVw1bJtkYU1UrfruX+bQHWDwJyqcpW+072i2
	 7XvvjMdpYRxMfan/Ysdo2jNvZDLucW7EQDCOenfCKii9nL5kX9GbqO5LyVZ4izk4A0
	 200TuhGCFi/1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFD35C4167D;
	Fri, 21 Jun 2024 21:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: test struct_ops bpf map auto-attach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171900602878.23797.910443661395333027.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 21:40:28 +0000
References: <20240621180324.238379-1-yatsenko@meta.com>
In-Reply-To: <20240621180324.238379-1-yatsenko@meta.com>
To: None <"Mykyta Yatsenkomykyta.yatsenko5"@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 21 Jun 2024 19:03:24 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Adding selftest to verify that struct_ops maps are auto attached by
> bpf skeleton's `*__attach` function.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: test struct_ops bpf map auto-attach
    https://git.kernel.org/bpf/bpf-next/c/cd387ce54834

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



