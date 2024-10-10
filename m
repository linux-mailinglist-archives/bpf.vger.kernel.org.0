Return-Path: <bpf+bounces-41518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C59997A15
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3BD1F23A87
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBDF39AEB;
	Thu, 10 Oct 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDExF0yQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEC2D052;
	Thu, 10 Oct 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523228; cv=none; b=iZUm795JnutRWCGDihQoKOwNayHoWVHAfU8bxFVqvBK69wC549gWTJywfl5VAgWbVZGu7wz00/5rtQW0NEsgt/tV0NNqF4l2OEvS3Ml6LyRGaLBbiHnY7cFzwXkHvinEO+EPGxie8i5tgfLfd9uipJYFmDJP0NFPG6Fh+RIY2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523228; c=relaxed/simple;
	bh=Lkcl60SEJPA7uDweNpU3GmDG7TaEgzu298rHTBceVeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NyfwhZbU864/AyFdKMY2pEcYjWK5OlInoxbaUVlJwG48F3YmcDSxyBjXUM6PL/+8bNpB7K5FPo9D1RdMq96Yk6iubIrRNUvcpFGM6+fpxce4uWw/KslTOUv4QEF0652TdOw4o25wUdv3yx7hSv0yL6ZyQujxU1nSZ1EXKEnofcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDExF0yQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694B9C4CECD;
	Thu, 10 Oct 2024 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728523227;
	bh=Lkcl60SEJPA7uDweNpU3GmDG7TaEgzu298rHTBceVeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lDExF0yQn+lNPrc2y0cXKFW7KgVEyco50xNsPXYcdSkTVJj7hP+9nSKNvpvapMQ78
	 nAIdb86DOaAzOO8lkiMA/yiWr1B31BeEKU4xD2t1VsK9ZMeV3S6NQ4b1QnKNadYn3s
	 auVDNbWKy3+dmH189AKhHlXJE1wwMirMW0KKxi0ZlqkjdNtmdZCRaLKKTpBq2KIxgU
	 sO1SezSXuYefs4qQxaHLpi/lqmUwQtMpX8ckfTDUq+Wz5HNmGBxzhWvLVy9DFOd59V
	 gT4dnjjkZOzS8zsLmbK4S+STzqeW1XTBkKLYpY1bjs5iUi50JEOd7DNjXhFDrsKTEa
	 s/vAYh6jIa3DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFE33806644;
	Thu, 10 Oct 2024 01:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: use kvzmalloc to allocate BPF  verifier environment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852323150.1529972.15976244400269742571.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:20:31 +0000
References: <20241008170735.16766766@imladris.surriel.com>
In-Reply-To: <20241008170735.16766766@imladris.surriel.com>
To: Rik van Riel <riel@surriel.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 8 Oct 2024 17:07:35 -0400 you wrote:
> The kzmalloc call in bpf_check can fail when memory is very fragmented,
> which in turn can lead to an OOM kill.
> 
> Use kvzmalloc to fall back to vmalloc when memory is too fragmented to
> allocate an order 3 sized bpf verifier environment.
> 
> Admittedly this is not a very common case, and only happens on systems
> where memory has already been squeezed close to the limit, but this does
> not seem like much of a hot path, and it's a simple enough fix.
> 
> [...]

Here is the summary with links:
  - bpf: use kvzmalloc to allocate BPF verifier environment
    https://git.kernel.org/bpf/bpf/c/434247637c66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



