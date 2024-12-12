Return-Path: <bpf+bounces-46718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92A9EF3E5
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 18:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0517E8DD
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114A722E9FD;
	Thu, 12 Dec 2024 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXXEPQym"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84833223E8D;
	Thu, 12 Dec 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021614; cv=none; b=EMhozsxg7Hos1ChwOESbD6lj1Ur+QWulL7Dm365+7RZ/zu8Zy0zet3SBk5COm5NykU0MhvQS+x54Jkq08myycl7L0eo0ILqWXnVthm/4ceo/11K+28UCCWgaCX93ypdak+TCZ37V3GlhXMVibo8hRGUftdCbUnkW1gPVfICaXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021614; c=relaxed/simple;
	bh=syLKL8tRQqbY8Yn2GNqk1vlT2Nctq2v4N0rngNhTimU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jQcXh8oXIQ0n7VhGEeAZ2eS5xTtlW/oWFs9fkBcvM9RCK8oztpCFkNtX0qbPXVN8SVY6QbhpmeQbg/wgMH5/4mXZLPsqQ/gIoo9IlG3BAwzKKXsV+IIY1ghU+iuRBgx+FbV8QdQVSUk5zlQkAPaAx80seK9dEAh9GzVhRAByGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXXEPQym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B65C4CECE;
	Thu, 12 Dec 2024 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021614;
	bh=syLKL8tRQqbY8Yn2GNqk1vlT2Nctq2v4N0rngNhTimU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NXXEPQym9+64+R5mH0pSAO9MOdiXsTnSpiTTRffdTZL9mIUpjTfg4x/pnohRfjK8o
	 Tuu/qhSLVJDg4xRVkqEfVg/s+gZxQ1F0EwW02cbp5K60/xc2ImMEjswotV5jHKu8X9
	 k6KxVrUOltqWNM1ZCXqd+25V1186NxCcwNFaBgygv2aD4byZ7CKQNnHZLf97tXlP+2
	 b9cbee2kShKit7Ydz6YnD1gyx3lUd3dQnX6Od7TMBnvgGqMI4hCCs36PVUZSNXF1mw
	 dk64+wsABCrulQlWLqwAB19OMe0glE1zu7XfZ3nofVbBXuGaTahyWwlKocXg1oIr8I
	 L4AlcRyhZRwfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 94202380A959;
	Thu, 12 Dec 2024 16:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: Probe for ISA v4 instruction set
 extension
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173402163052.2361877.6606920596911707447.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 16:40:30 +0000
References: <20241209145439.336362-1-simone.magnani@isovalent.com>
In-Reply-To: <20241209145439.336362-1-simone.magnani@isovalent.com>
To: Simone Magnani <simone.magnani@isovalent.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  9 Dec 2024 15:54:39 +0100 you wrote:
> This patch introduces a new probe to check whether the kernel supports
> instruction set extensions v4. The v4 extension comprises several new
> instructions: BPF_{SDIV,SMOD} (signed div and mod), BPF_{LD,LDX,ST,STX,MOV}
> (sign-extended load/store/move), 32-bit BPF_JA (unconditional jump),
> target-independent BPF_ALU64 BSWAP (byte-swapping 16/32/64). These have
> been introduced in the following commits respectively:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: Probe for ISA v4 instruction set extension
    https://git.kernel.org/bpf/bpf-next/c/b9fee10a52c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



