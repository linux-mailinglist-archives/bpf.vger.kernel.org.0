Return-Path: <bpf+bounces-73485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52407C32AC4
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DC442273C
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3833E37A;
	Tue,  4 Nov 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB3L9jif"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DE214A94;
	Tue,  4 Nov 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281035; cv=none; b=mTVIk7CzO2Nl88C8nJPs9p34fQEGsiWlP7X1oOFWFZA0szdwwj+yhOC6UXSw59xKoQznoWKwOxzvg4hevFee6cnIMZ931QxnfrR+EfnkHZY+YeL1p7PyiuVxnXiIYEO2V+5z04d9u+BbnbeNiKAlx7PLu3RDbwFxZKmD+UhJbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281035; c=relaxed/simple;
	bh=HHRiuvag/nuJuBWy2Cw0bS5gBUcRI0eVWaPuEuu4EaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mgYOCXp/RtW0yEX6As7qvQZFkXe3RlJbvqRImgz9dbBM5/MxvAFfDypdX4ZNe6I9qOAp6HTn6EizuR53Nv+Dmpbaj9aJb09lF5b6feF6Hmk4ayd55hR0TGp4/FO8Ov5lfL/+45DKQY6r6te3b7UpFBNZ4TSbYkMmSrzBR5fgqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB3L9jif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C71C116B1;
	Tue,  4 Nov 2025 18:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762281035;
	bh=HHRiuvag/nuJuBWy2Cw0bS5gBUcRI0eVWaPuEuu4EaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PB3L9jifGRtzL32vdyarPLmOjhA4rlUoQeIWbCgnLYnXifxtmowRkCQomB+GYtWnC
	 hy7TnHUceElmD4Gr+73pPPiyGSSt+DGSXIcvi3bIIHPo1+tvfEkEbSgx5B+yX6pOtN
	 wbAvxClSsAeuYezXIztWirMMf9VrTbk0KkUI4yfkHR39FxG4UwNU85AedPrJavb8mQ
	 e5e6ESHU9xv2wqrwtrD9CdCK4rF3KzRVnj1bXQB0NXVXzJCJtGDNOG+hGqJhMWR4gt
	 M4o/SWMgIm0a5InSMqbOSsrgvOS1PXn+S0sXSaIMZaNFPTVAfbt92HMjmtAX3g52vj
	 tclyjROd5mC6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0F3BC380AA44;
	Tue,  4 Nov 2025 18:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: Complete the missing @param and @return tags
 in
 btf.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176228100901.2956689.106109461802688869.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 18:30:09 +0000
References: <20251103115836.144339-1-jianyungao89@gmail.com>
In-Reply-To: <20251103115836.144339-1-jianyungao89@gmail.com>
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  3 Nov 2025 19:58:36 +0800 you wrote:
> Complete the missing @param and @return tags in the Doxygen comments of
> the btf.h file.
> 
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> ---
> v1->v2:
> Try to fix the CI FAILURE issue by rebasing the local code to the latest
> version. The v1 version is here:
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: Complete the missing @param and @return tags in btf.h
    https://git.kernel.org/bpf/bpf-next/c/74bd7bc0683e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



