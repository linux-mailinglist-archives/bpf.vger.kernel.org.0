Return-Path: <bpf+bounces-22514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EAB85FF2F
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC7C1F2CB39
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A370B19478;
	Thu, 22 Feb 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgyC4xDe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D128153BCE
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622428; cv=none; b=GqGL+N9CeveOTiv3ehPSb3JRy0w/GGXan5kTZ5hQxh9w9Kbw6LiT4t5m4Ut2wtiJCxnVPPFGEbXq9xFvnh+jvfhx8ZlnS/U9EHdOmtz/uj/aIoZJBp30MtjOz4pCO5AF7vPtHoXMOg0FR4RV7VvoVQeM7LO/3e51FY0rCuKk2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622428; c=relaxed/simple;
	bh=WTrt1Gkj2rby0X12vHkbDIKsuTjV/rhDrWuQwyxIzHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OI0/yTibVRd+3cnxZ5VXTm2gdFEonCFNDhDJFmakHkLkWsne6+IeyfDGh+G8DNTI0F7UPFOC2VJ91JS2v6dItAhtCbwzPK4pXwXdPxZM1a0agaIwdo3iaaqSWATCcCUnd+X+fq9lBYwHNpEIED1hwRsrSxZLoeh7bHLGqpDLz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgyC4xDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0878DC43390;
	Thu, 22 Feb 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708622428;
	bh=WTrt1Gkj2rby0X12vHkbDIKsuTjV/rhDrWuQwyxIzHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AgyC4xDeTzmg6ZtRpswEthu8siMZDykJDzIZJ42733Xczry33sdpCfssH+7vd8V++
	 gOZN+AiHE8hdupwfHpA3iWM+WAn6U4i3X+BMGjpOa/Fgv1FnH6xhRlgYoKwGE+4gnz
	 9DXzjN2X6Jt/7uHKt6xpV6/GX/G3omP90awCsuGnYz2Tu/qHpHtTkjbuKcf+avjZOu
	 9eT8eN+sH2XEdYZAzK/AnajDFEBIoEXBiLOy1ZZ27TrqoCLAHbIYroKZaD7zkho6xZ
	 8z/YlEEztpO+tedKDcsr35Y3Vhj9xsrvqEDqgC2pSyzUGoGRfpN0Mvt0JBHJfueNaX
	 nrkRpWyxm0mSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E45C7C04E32;
	Thu, 22 Feb 2024 17:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: specify which BPF_ABS and BPF_IND fields were zero
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170862242793.15800.11876966035725051382.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 17:20:27 +0000
References: <20240221175419.16843-1-dthaler1968@gmail.com>
In-Reply-To: <20240221175419.16843-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Feb 2024 09:54:19 -0800 you wrote:
> Specifying which fields were unused allows IANA to only list as deprecated
> instructions that were actually used, leaving the rest as unassigned and
> possibly available for future use for something else.
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: specify which BPF_ABS and BPF_IND fields were zero
    https://git.kernel.org/bpf/bpf-next/c/89ee838130f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



