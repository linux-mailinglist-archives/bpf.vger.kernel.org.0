Return-Path: <bpf+bounces-77611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE8CEC591
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121543011415
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CBC29D29D;
	Wed, 31 Dec 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhPMDlGu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0102877D6;
	Wed, 31 Dec 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201210; cv=none; b=Ope48oEorp4JcLf4la3ezeBhLDgNJ8+Gc7woO2SChnZpVacBJajZBuQSqG+OINpkpU4Uvu/GtIzGJfLEvzMmJ0Oy77hAQmbfUUwJDAmvSji7C1C4YiHegWrjMFjuYKuNqyhuop2Z2/tXOQzVNV88xBLWgrJSREldacH1XYH0yG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201210; c=relaxed/simple;
	bh=BD6ySfSzuYPAtW4vpHUjhmwKbDSWHprGr575x+jAt/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SsfVUzF4VBObalehfAFx0YEkAxBQJ6w9LIFf0XG7fEB25HMUMRbSYyrcJF4QUkvKMe0bXS5phpKjAMcXbXbd8JjrbFY9bmY3GRPEfHT1OvLZ7UX7lI++GDWSYUZB/6dzIaCrcPuryoaPKxSwpvGmovltK0/Q+okqSyvnOZ8x4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhPMDlGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F4DC113D0;
	Wed, 31 Dec 2025 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201210;
	bh=BD6ySfSzuYPAtW4vpHUjhmwKbDSWHprGr575x+jAt/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KhPMDlGuvTFQn/aIK/5idZtaBm6V4CJtW9CdGcuEv1dK69nI3kEfm+3X9VCRz2F+R
	 mQ/gbfApqHS+64ZcNeWNz+ZNOUnacGPmDawz7xV5/RkBICA5oTLGrO2aOO7rdYnCPp
	 oxlaiNe0KtFi2pp7PhL4k6VpLUeafC0frTPSQS8Rqc4wnTMdLaGSBHzyN42FVW4XiD
	 9eAM9WMOccW07aCEqU2a4EVs6/5CuHbKEDG8Z4Y4xaNjIE1KzEdQAwYSGpHNKTGPTx
	 uaOj+CpxM4V5qwkJ+Oee/PDaxdltPUUwpFPnzCUTPoIm9ohXlDoCAEC6Qj2f3dFn4J
	 HlZ28j0nvuo3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 790C03809A83;
	Wed, 31 Dec 2025 17:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] resolve_btfids: Implement --patch_btfids
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176720101127.3562703.15519413804763442905.git-patchwork-notify@kernel.org>
Date: Wed, 31 Dec 2025 17:10:11 +0000
References: <20251231012558.1699758-1-ihor.solodrai@linux.dev>
In-Reply-To: <20251231012558.1699758-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, nathan@kernel.org, nsc@kernel.org,
 bpf@vger.kernel.org, linux-kbuild@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 30 Dec 2025 17:25:57 -0800 you wrote:
> Recent changes in BTF generation [1] rely on ${OBJCOPY} command to
> update .BTF_ids section data in target ELF files.
> 
> This exposed a bug in llvm-objcopy --update-section code path, that
> may lead to corruption of a target ELF file. Specifically, because of
> the bug st_shndx of some symbols may be (incorrectly) set to 0xffff
> (SHN_XINDEX) [2][3].
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] resolve_btfids: Implement --patch_btfids
    https://git.kernel.org/bpf/bpf-next/c/1a8fa7faf489

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



