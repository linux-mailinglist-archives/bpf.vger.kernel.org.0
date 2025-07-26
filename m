Return-Path: <bpf+bounces-64449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE2DB12C0E
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7EF7A41C9
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFB928A1CD;
	Sat, 26 Jul 2025 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzZOMhvj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E23288525
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753558193; cv=none; b=O1nFS/XrkQQnP2mYLAnIddpZlpaU1vk7JrOc3NQ6oVAzPmn5ZuyfhEJfwR4dRZREjMQcnHIHd/CJ/Lowlsiolt5us+0emcrJTQFBaYnufo/ISoRhzKFX8YVRnoWDBFaFqWnyZ7+eB1LRmH+X3YagpfNST+PWkbYQSYTAJzGiaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753558193; c=relaxed/simple;
	bh=x14oK8XD0Bcqdszl2Pwmn4QVSNyPmPDigIMZEMDPrr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lSPcczrxemHeD6IK4bLcjYOLyuRMgNSMQhTGjdoTWoV0m1g3A7zvnIrViq8SCZCyf8wzp280mGP5zPWV4KgTut/54psdF0leCT+Dts7qLmsx3T0NHmyn8RnUOAjveMbvvOez7mfAbBlIGBPkuNxN4wEoB9WJAEt7TA7iCsfeKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzZOMhvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420FFC4CEED;
	Sat, 26 Jul 2025 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753558193;
	bh=x14oK8XD0Bcqdszl2Pwmn4QVSNyPmPDigIMZEMDPrr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UzZOMhvjXIiH/jQUVlXtqxVXGwy9f/2dICBsVELAU+ynVYSVEypzSdrDKuVjLTiKA
	 FWExspOeAXDcLIX5uI0xAaw/gcX528D9ba4o7QsHNGEpxQHdX1XefyO7oWg6vxKTwP
	 kby+dVH5uA2j6q13Xpv2Ajaqu4oFjoyaDGXhVQrr0aME+vpOnzyiHtIzCjk9zRYnUZ
	 NUFOuEwZXXBR6r7O209VG2pkMIXnMc6Zj7wxDHqh8X4OmCbEV6s+uMIz/n7+zKcebt
	 hahfSYliflaQlLcszF0GSyOlRXO2J0dewQFCEuOFnYnvRj+weEKkl9BezpuSk+3/Rd
	 YDUofmog5YR5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBF1383BF4E;
	Sat, 26 Jul 2025 19:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/1] bpf,
 arm64: fix fp initialization for exception boundary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355821051.3674813.11697788265095490964.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 19:30:10 +0000
References: <20250722133410.54161-1-puranjay@kernel.org>
In-Reply-To: <20250722133410.54161-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 22 Jul 2025 13:34:08 +0000 you wrote:
> In the ARM64 BPF JIT when prog->aux->exception_boundary is set for a BPF
> program, find_used_callee_regs() is not called because for a program acting
> as exception boundary, all callee saved registers are saved.
> find_used_callee_regs() sets `ctx->fp_used = true;` when it sees FP being
> used in any of the instructions.
> For programs acting as exception boundary, ctx->fp_used always remains
> false and therefore, BPF frame pointer is never set-up for such programs in
> the prologue.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/1] bpf, arm64: fix fp initialization for exception boundary
    https://git.kernel.org/bpf/bpf-next/c/b114fcee766d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



