Return-Path: <bpf+bounces-35673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F251C93C9BF
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8791EB225F2
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A973D13AD18;
	Thu, 25 Jul 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnRtyu1v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60E1C6BE;
	Thu, 25 Jul 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940033; cv=none; b=JBH/YiIyTzmTWBmm15EPtScxKyC1Gg2VjOkSpWYdncRUkjOTljmnipalKkS10egGC/ymZnbRV+fT/+P4HVA7wnqWLAj2G7+H7AwqwQKpY3HzPGSZQ0egi9IkMMePBduDPTy3sx7d4tdDJtx6g27EYEuQhxm0J6ZECwwXJlu2rn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940033; c=relaxed/simple;
	bh=H65LDiHXZ3TU3vZsAYVAP0cMH03/rPPJ5B4qK2+d3kg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E7M5YNr+KtOGoiy7JTDLyS+/h1vodUj+YN4Y9HdKLBFB8/jI6dXzzEw64TjmpTOwSwT3dG0v9xLfvhAtA0wdl4nFoBGmTAVn4tSEyR/BL5VK8H/k8xBgd1VJsnuVR/y66DBlYsQ1nS4ft8xWlZq59YmBUdrMmqDhzgTzr+U9S2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnRtyu1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE492C32786;
	Thu, 25 Jul 2024 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721940031;
	bh=H65LDiHXZ3TU3vZsAYVAP0cMH03/rPPJ5B4qK2+d3kg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fnRtyu1vc8kHzRJu1RgmzrUeUPJFUW17ZHxQW4O6tiLARjmonwWDqQr6OQAV/FSVc
	 chbsECERjn9FLF8ggi6SoAMJ0vnNPJSuI1IyLp0VT7dQZC3ih6XbUvcmZdW/6FUgMN
	 F84TvlEDyGchT0sgiNEfObLbPRK+wVs+DjTUxuQp1eaFHqzUi0RRq6uXBK9/+bkJox
	 oxfKfLdW1+Qscux6NWfTgCq080Zl8YeM+FO04SWJECTwHMNwpXXZiiahwM/6Wz9ZSm
	 3OqasaANtD2IFc6jnb6UElMn3pXm0WDe0gCME0AZF/2tbtUjz41oSvrbtsBbJ8G0SZ
	 LMfyDse3TRofw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9704CC4332D;
	Thu, 25 Jul 2024 20:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Load struct_ops map in
 global_maps_resize test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172194003161.20182.11872236874793276327.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 20:40:31 +0000
References: <20240725032214.50676-1-void@manifault.com>
In-Reply-To: <20240725032214.50676-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 24 Jul 2024 22:22:14 -0500 you wrote:
> In prog_tests/test_global_maps_resize.c, we test various use cases for
> resizing global maps. Commit 7244100e0389 ("libbpf: Don't take direct
> pointers into BTF data from st_ops") updated libbpf to not store pointers
> to volatile BTF data, which for some users, was causing a UAF when resizing
> a datasec array.
> 
> Let's ensure we have coverage for resizing datasec arrays with struct_ops
> progs by also including a struct_ops map and struct_ops prog in the
> test_global_map_resize skeleton. The map is automatically loaded, so we
> don't need to do anything other than add it to the BPF prog being tested
> to get the coverage.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Load struct_ops map in global_maps_resize test
    https://git.kernel.org/bpf/bpf-next/c/7d30b8aa4fc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



