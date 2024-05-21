Return-Path: <bpf+bounces-30145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A9C8CB351
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB97281F11
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341541C93;
	Tue, 21 May 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqTdFMKV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E423775
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315035; cv=none; b=i4L9J7YP7adNhoC1t9kq+COHB529hof+bxqa2Q1IGw0haSd4TdlzlfwU2sYYTvOBQvNxCDRByn33Xzd6x6BE/qu2ECmEPK+mPOn9Dt0M//EbY6/1ru3Hl8q/ZNGp6ywK6kga0cyVIV76pTueVhBhr1TjWHgvfCUjv+uNbTnwOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315035; c=relaxed/simple;
	bh=8PyBck019aHUPKQeSyjs4Ye/8mU6Qa9JfTF2hWRWlgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pnp+dMurmyhBO680qpdRF0HVZWLlC0NSHQvcxn//pqC7dSMUfWHpJRfJyieC2VufNJ6vdCSw3PdxOq2ILrZqiE6iRXWC8jgz0EHhh6CHQ4qUW6TLS0p/mdUiVyMoK3fXXt+sSGPcg/gbnyZf3HXk/eQJ6Vg4jwLSOuT44d9lGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqTdFMKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 859F0C4AF09;
	Tue, 21 May 2024 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716315034;
	bh=8PyBck019aHUPKQeSyjs4Ye/8mU6Qa9JfTF2hWRWlgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZqTdFMKVEhamQB5OllwZK5gXeY1r5jGyRKxOBWYX4cSZ5UKKucpV25GIOqQzyPYS1
	 wQ+vdl7nds1rmx7y9/yymhnSSlIUVYtL0qeaoAyMslFXXYoGIMRPdvYWJVqtqmJCt/
	 awxaC+IGoHezwKYpOLOrHleLE+BRaAUoM2dLke7VDP1cTt7naQx9X3xHAypZoRwHCy
	 IYEw+KTySsxnz1Has/bFY+gNIWcjcB435H43/6i+v+C5nqZPw1zv0bP0KpnjGDyw6a
	 r8zkBmEiW15yWMqqeFRCdQ60w8JrLErLLcuU9UH0MdYDpiHLjzYL1shqfujpIv4hfh
	 03wBVWiaUHmcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73921C54BB2;
	Tue, 21 May 2024 18:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] MAINTAINERS: Add myself as reviewer of ARM64 BPF JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171631503446.15656.18020318458382777062.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 18:10:34 +0000
References: <20240516020928.156125-1-xukuohai@huaweicloud.com>
In-Reply-To: <20240516020928.156125-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, puranjay@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 May 2024 10:09:28 +0800 you wrote:
> I am working on ARM64 BPF JIT for a while, hence add myself
> as reviewer.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huaweicloud.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf] MAINTAINERS: Add myself as reviewer of ARM64 BPF JIT
    https://git.kernel.org/bpf/bpf/c/8d00547ea875

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



