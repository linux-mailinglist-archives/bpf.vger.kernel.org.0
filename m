Return-Path: <bpf+bounces-30501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0A8CE7BA
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 17:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A6E2833C0
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900D130482;
	Fri, 24 May 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4J/XWOh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D912FF84
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564029; cv=none; b=fHJ8bOumvW/KMdwgzGLjUKsoKb/P8ATBj2v2ZzKgGJX2ZU7tsDmtiyTsq4+2gsgs3fZdwsctb8hEkt0FoSvG7vqLKpulBDjHQQ3mWxiNhqJrT9NCOyN4G0Hsxhhk1xBzwa28tiuSMWA3dbqTOuMEXdhqiOM5S8omGb7XM4nBHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564029; c=relaxed/simple;
	bh=9qq7ugNoTdCHZd6Xi+pZL+rDGvDg+Hq72Ss724dxB7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pf4zv8MkZdlFOi+dYjsxZfHIeUvJSMGmGfgvC7aY1PpJUqMvGB2dy7YZU6cu4bXu94Adl5mm1Tm4qZsKf7Vmd2ylA929kcbM+JQ1YcKkk+yG8kdTD3YvBRM8AQWI7gMa+WQOIrAaMWhg1a9viHuE2ESFf4t6vMmd10fxUU6TNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4J/XWOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F35EDC32782;
	Fri, 24 May 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716564029;
	bh=9qq7ugNoTdCHZd6Xi+pZL+rDGvDg+Hq72Ss724dxB7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I4J/XWOhOuU7DROmrcA+6MioXWjYra38XbMKHbSxY9w3Zz7lMnwP2g6GMgfuWigj2
	 13w0nf5USJt3o8m9fhpgZnj9YZdn5O62ttW8/U61f4BJSQq4mwpgvfezwSKLDX8Nh4
	 X4/N1OI19asE3IYD8bfyvXMkMkyAA5szYr90wlew4hSEq8Tcr3486/GcS0f7VEaoAg
	 Gbksc7UzAl+my6MpYg1d4ZYVP8NPMeQ6tFc61Ecw14rEdH9fd5I2mybHFWdV+Zw8hJ
	 WeWoduVZHmecNCW6Qj8naNbg1GmKfqy4/y6HPsBPzpaiNebdobdZ7HO+9uhAlD7K/u
	 Fa44y5PQUOmXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D57D9C54BB3;
	Fri, 24 May 2024 15:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix potential integer overflow in resolve_btfids
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171656402886.10818.5119298803086804983.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 15:20:28 +0000
References: <20240514070931.199694-1-friedrich.vock@gmx.de>
In-Reply-To: <20240514070931.199694-1-friedrich.vock@gmx.de>
To: Friedrich Vock <friedrich.vock@gmx.de>
Cc: bpf@vger.kernel.org, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 14 May 2024 09:09:31 +0200 you wrote:
> err is a 32-bit integer, but elf_update returns an off_t, which is
> 64-bit at least on 64-bit platforms. If symbols_patch is called on a
> binary between 2-4GB in size, the result will be negative when cast to
> a 32-bit integer, which the code assumes means an error occurred. This
> can wrongly trigger build failures when building very large kernel
> images.
> 
> [...]

Here is the summary with links:
  - bpf: Fix potential integer overflow in resolve_btfids
    https://git.kernel.org/bpf/bpf/c/44382b3ed6b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



