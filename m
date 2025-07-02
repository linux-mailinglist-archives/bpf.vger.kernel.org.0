Return-Path: <bpf+bounces-62179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEEAF61CA
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 20:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C944A83A0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980921C9F5;
	Wed,  2 Jul 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npNnxA+t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528612F7CFF
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482182; cv=none; b=r6LDLHoGo0r+G8HP7AKfY+yPNV6jTFj22i1SUIM71OnJ+AWEhONyAP2P93iRWRz8vrwaOQR3/c7VhWC7zy3BLm0ZhE9JnOnvBLPxj+2icFMj1yZsEtc9BEtP14rNQSpdcqLdZ3NfaPmmrk4/8quU33kXeykNFUne7VHuqozqLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482182; c=relaxed/simple;
	bh=UC/fOZtqUBQc0MIieISUz52evv8/dpeAcwNeIFZvDns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TPe6h8sR+LwUHu3eI1uILgPUhaOdExVaPmKywGLrzZETZMOlrDCt9S6x3HkIlpKXDfzmU4FEyrAG1vsPVRSKCwUQU9+98S7Yia8yQsPfSQnp5cA7qlRVUhM+RLWh4+SyGm/dY9bQG8VIbVf/byUBSqwE+z00SblomMUk9JaofCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npNnxA+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DE0C4CEE7;
	Wed,  2 Jul 2025 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482182;
	bh=UC/fOZtqUBQc0MIieISUz52evv8/dpeAcwNeIFZvDns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=npNnxA+tBbKG52+tyG+2hEJx68tHAvshS8qq9UAcHEQMR4tigKOmIWi6D3KQ4tB/n
	 ztVsPC1JRS0A5U3c9EQpy/GQJEUaKqxWwHf3eFjrmOg3fjbrLnpfdn0v7KezzUIWfH
	 J96vSMeq+rHGAwvsxV1yhbvYnoEPDShVp4qAcvmI+TWRgSydYmT0p1WS8R5LR/fhUQ
	 UBbKCH3Bgvk+22kXweWILgHS7f5ny6OrjS9c2ZhS6siBYBVwo0zF16bpUCaITRiWB0
	 F2rCn+3d7gov5EXiswbLK1P/E72YcEhKOdwhlPrGKySSv2ISTMhv/OhOYWJOl5VAvC
	 lEpqA6S4pd7QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC9383B273;
	Wed,  2 Jul 2025 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: allow veristat compile
 standalone
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175148220651.828808.13575427691762877182.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 18:50:06 +0000
References: <20250702175622.358405-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250702175622.358405-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  2 Jul 2025 18:56:22 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Veristat is synced into the standalone repo, where it compiles without
> kernel private dependencies. This patch fixes compilation errors in
> standalone veristat.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: allow veristat compile standalone
    https://git.kernel.org/bpf/bpf-next/c/38d95beb4b24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



