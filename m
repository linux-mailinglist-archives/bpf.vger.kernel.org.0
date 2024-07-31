Return-Path: <bpf+bounces-36105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AC49423E6
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 02:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502271F2491A
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 00:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46073539A;
	Wed, 31 Jul 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCCL38kC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B324A31
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386431; cv=none; b=jEFMCWyFIWY01WhRKWnWaeFqjFkddouc0nHWySg5fwyjuisMfbmazntBCOx6ANBKZd504xvGFKl1AxDOKyacyFVWgySAi1I6IHbUZGR7NPAVe2XNvHSwIpjmGCxTAsyGY65rFaVROMqK4TGhiqAiDsdZ55Z3UauMCGcJCVf5alk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386431; c=relaxed/simple;
	bh=8+29GTX3U4Z0CIRIlpYiydQnRbgB5dr/WsVZh4t3kiI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AxUApm58Ueok4+fpvhX4QCAPOq0il83Ide16+HbAPKGvWiDVM+jbUN9e0GY6BaMuI8OnOjDZGDbNaJH6GQL643SdYrl9dOJ98V8pqxglfvi0Qp94WsKrb9uceMJswp78fmTGWlzdYjdRUACOEvWwatCYilI9caRuTQLtHbklWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCCL38kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B8B3C32782;
	Wed, 31 Jul 2024 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722386431;
	bh=8+29GTX3U4Z0CIRIlpYiydQnRbgB5dr/WsVZh4t3kiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uCCL38kCO9V72X0LQdLcoWbka+JH4i2bt5MxgdXPzGnZ3wV45zp3XOone2L+BXxt2
	 B4jiIH2CK7g6QfA/gcrEXscCGF5xQ2y4ifU/0Bt6HmapO1LkOO3s3xSF1p7H2fHiuv
	 RKn0JChO/2dIjew3e8+noA2SfHMjIyjNFnSkCgDFFW+DzXRk6WnAH4O5m8ya7QNof7
	 QlRf7zvuR/BVEAhOibaUk4a9RVGqQ6ATDu+xeLUtN3MU77hlPboY3u9kA2hzjbdu9k
	 CSVy+CMoB5SU09RZoPkttZQ73aJaItivUvqb/8+QQwtYbllkR9GcMpxb+Xg39GLB9n
	 9Rrg1FBL8CN2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33883C6E398;
	Wed, 31 Jul 2024 00:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix RELEASE=1 compilation for
 sock_addr.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172238643120.4892.18197234511198636441.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 00:40:31 +0000
References: <20240730231805.1933923-1-andrii@kernel.org>
In-Reply-To: <20240730231805.1933923-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 30 Jul 2024 16:18:05 -0700 you wrote:
> When building selftests with RELEASE=1 using GCC compiler, it complaints
> about uninitialized err. Fix the problem.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/sock_addr.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix RELEASE=1 compilation for sock_addr.c
    https://git.kernel.org/bpf/bpf-next/c/92cc2456e977

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



