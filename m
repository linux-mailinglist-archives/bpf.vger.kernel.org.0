Return-Path: <bpf+bounces-22936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC37086BA32
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6786286D78
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5B170055;
	Wed, 28 Feb 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmat6Q+G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317438626B;
	Wed, 28 Feb 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157032; cv=none; b=VdV2FMG5d5ahzTd2GJl3P4IHCX83c1BCDmyVrOzKfBn9ylTjswLjysg/ubA8WlQbIUB87lA/bjFAaifZSw3hHs+OQ2a4W+c9kYDQRNSJdJU+O/dQdtnmj4OXxw4fFuO1Hl1nXv4yaDp51J4NMrxK97L3gJ5nbazuHdUSqp89q+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157032; c=relaxed/simple;
	bh=eoeirm87cwA0Iui7WLtXFkKqZKe3jxTPSlgVzKzZjYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a88lfVIlSEJojZjY5AQJZcFfRLuyxotnKK5sDoIVirKrn5jC17PWriBRzTfkioRLP0scsXJIp7kbt5cWSyxRsgecPm6J0yvP1zT+nxaDATzYD7gl+YfGTWuYM4ttIaIiku/d4gXoCIedhUuKPWNgerceA22U91ZRD5urRxx+w2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmat6Q+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A24BAC43390;
	Wed, 28 Feb 2024 21:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709157031;
	bh=eoeirm87cwA0Iui7WLtXFkKqZKe3jxTPSlgVzKzZjYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jmat6Q+GYJ0gn6u3E/ImQE6D1395xmATcpoAHj2kcDeFLW0tzSSEupd3FAA5EKuTo
	 9U5lAcGxqrht0TKQkz1l6EjECtS0U1+CkI1iWxLwgqWPAkvzdo3h2Sk6ZMOPaGJqRo
	 Bo5/3kklZM4SKLYU6EUg8a+xYRARjXM84UBzf+5ozcwUKXcRm607dfAMsANDegGd5L
	 qO8ULweGbxB014NoVyu+bdZyatOZ/Ir3Wse6FhLswitrnqagmd9hDLWm/PA/P7UaRS
	 acwirb3/pcRh25hIo6toFERYtQKJbvGVMwGo1AZ4mwunei4gF3DAOck3U2WuYzpceA
	 B3UTvBSjtNjpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84128D88FAF;
	Wed, 28 Feb 2024 21:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/2] bpf,
 arm64: use BPF prog pack allocator in BPF JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170915703153.28072.17034695102932283115.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 21:50:31 +0000
References: <20240228141824.119877-1-puranjay12@gmail.com>
In-Reply-To: <20240228141824.119877-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xukuohai@huaweicloud.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 28 Feb 2024 14:18:22 +0000 you wrote:
> Changes in V8 => V9:
> V8: https://lore.kernel.org/bpf/20240221145106.105995-1-puranjay12@gmail.com/
> 1. Rebased on bpf-next/master
> 2. Added Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Changes in V7 => V8:
> V7: https://lore.kernel.org/bpf/20240125133159.85086-1-puranjay12@gmail.com/
> 1. Rebase on bpf-next/master
> 2. Fix __text_poke() by removing usage of 'ret' that was never set.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/2] arm64: patching: implement text_poke API
    https://git.kernel.org/bpf/bpf-next/c/451c3cab9a65
  - [bpf-next,v9,2/2] bpf, arm64: use bpf_prog_pack for memory management
    https://git.kernel.org/bpf/bpf-next/c/1dad391daef1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



