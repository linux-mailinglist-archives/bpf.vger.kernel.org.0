Return-Path: <bpf+bounces-68382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 272E1B5786B
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 13:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6685D7AD6DA
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 11:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F992302775;
	Mon, 15 Sep 2025 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT+e0fxJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9427817F
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935806; cv=none; b=o84tpWWjrcl1ZeCRiE5LBCVYfzNPz2rArILhENDxASEgiQbvbfy06P9z9maSi3pDwT/dVYZ48i1suWz3ETJR56dGf/BWakZpRCA0hlEHS+dcmPZ8XVi8DeIzxmRfC1yeCWcIE0/RieRTNI0CfJlpEre4OIdiP5td9nWSj6PBgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935806; c=relaxed/simple;
	bh=0LeemALigBhOE/z8tc+3LQeO3KM+cUtqRXMQIlOWg7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=meDKuxqH3LY6CHhSux2VQixZ/pA3cXbn/eiOHE32e3EVVTYWzOqsLtoAsXwiH9VUK1u4NWCxQw2UfXebdY7WEpUrX4j3MxOJMGlt1+iM4kAmROgrsJb23Vwm9WT8pMk5RaU95Dwcfo5UYgigygxKx6hzoQExlmCGyo9xNdhs1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT+e0fxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A82C4CEF1;
	Mon, 15 Sep 2025 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757935805;
	bh=0LeemALigBhOE/z8tc+3LQeO3KM+cUtqRXMQIlOWg7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aT+e0fxJ0WcXTdzmFMlaOmeLBj7G/nVsrGnYX0C5UQGZARV4Ddqa6GBUMaI4JctuJ
	 ZPklzrvRxCLa1KLCc9Fi6nvlJdBqs/apKscB39/MZJ33CBkYH82FeDGLsy4j6EsJZR
	 PRiBwZHL+mAc6ZwY5oBbRb9Sk0ySNSpZ0PVrPgMwnwHINrn5hT24xaZMw9kKuSI64c
	 KcwnOODa3LxeBaspYEv12GgUIV1GjSv4h6OAJnMVEg+KLdRamu4Z3etavGWEsQR5ZE
	 8MZF5nW00qYy02gvPGV68CsQD07ZDPghoiBNYU8HhOouHwjlhX1+iaCviO1pr6wNAU
	 a6+bF0ClR8jvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE5383BF6C;
	Mon, 15 Sep 2025 11:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] riscv, bpf: Remove duplicated bpf_flush_icache()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175793580727.4119003.4683827020122621439.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 11:30:07 +0000
References: <20250904105119.21861-1-hengqi.chen@gmail.com>
In-Reply-To: <20250904105119.21861-1-hengqi.chen@gmail.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, bjorn@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, bpf@vger.kernel.org, linux-riscv@lists.infradead.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu,  4 Sep 2025 10:51:18 +0000 you wrote:
> The bpf_flush_icache() is done by bpf_arch_text_copy() already.
> Remove the duplicated one in arch_prepare_bpf_trampoline().
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] riscv, bpf: Remove duplicated bpf_flush_icache()
    https://git.kernel.org/bpf/bpf-next/c/6798668ab195

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



