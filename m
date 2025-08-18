Return-Path: <bpf+bounces-65884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F55B2A572
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 15:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17695581365
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FCE322A25;
	Mon, 18 Aug 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjtnoLQ1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882533A016
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523200; cv=none; b=AQ0UU076WjgqTSa4g2dhjTLVsGJyTO/ZN2g5VOrH5BmmlO0sY8stUO/p0nMRVlQcN1pt3eZx1FZPzZbkDH++7xX8G673B4ponIr8GBxt2s0Py1U1HKOX7UJwi1cmKCx/FijgkTaNgqkveMvaGCZ7vXMRhnDfIPqtfmHiGOKJii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523200; c=relaxed/simple;
	bh=BIf8efd9tjO1hPnIciVN5mW6bazsctOzy2j3+GLBqAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y9DlINbbluWZq69Pp+ORK9MIDs23ROcERZMeSchGOgFk6R6XPv/UL9zLs9YwbiR/Qwv2sFuKoeVzCpDZi1osPtE8txD3AMVQXR+8S7rMGa3CETsKg51yNWCe/fYfmo5vQyA0x3AAGuI5TU1vzjS3y9D53quSsRyvvR+nJhT9rQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjtnoLQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821C6C4CEF1;
	Mon, 18 Aug 2025 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755523200;
	bh=BIf8efd9tjO1hPnIciVN5mW6bazsctOzy2j3+GLBqAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jjtnoLQ1ULpJ7oxl3ebC7AGc3ReKciAO88JyvrmD+vR3ivmjL6keTI7jbVbkZnVnq
	 aTp5E1gw4sx3M4dag51oq6eTCTZtbTqnTrnRm99fg5VLtcH19fcvAoKS/iIgYVLolJ
	 ir5+R6KU0pnkMkQd1QsNATjwLh0rIAvczKYg/qKclv0vCmXZFCwl+vkGrPg+/z6EYa
	 uV4JQSk+hdaFRL1J9E0ytNaYEnY4rk1u/zerys6UPnhQrdv+U0pVz9TiOYehgvhYKH
	 8bLtHve13SZGLg95ovOvW6UQxPyQcunyFxVRjjd5k+yHKBR9H+7VcNXWvA5Oh+GdDA
	 QZBQk2J7pc/Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA0383BF4E;
	Mon, 18 Aug 2025 13:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/4] s390/bpf: Write back tail call counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175552321025.2749470.4174677292251959603.git-patchwork-notify@kernel.org>
Date: Mon, 18 Aug 2025 13:20:10 +0000
References: <20250813121016.163375-1-iii@linux.ibm.com>
In-Reply-To: <20250813121016.163375-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 13 Aug 2025 14:06:27 +0200 you wrote:
> v1: https://lore.kernel.org/bpf/20250812141217.144551-1-iii@linux.ibm.com/
> v1 -> v2: Write back tail call counter only for BPF_PSEUDO_CALL
> 
> Hi,
> 
> This series fixes the tailcall_bpf2bpf_hierarchy test failures on s390.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/4] s390/bpf: Do not write tail call counter into helper and kfunc frames
    https://git.kernel.org/bpf/bpf-next/c/eada40e057fc
  - [bpf-next,v2,2/4] s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
    https://git.kernel.org/bpf/bpf-next/c/c861a6b14713
  - [bpf-next,v2,3/4] s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG
    https://git.kernel.org/bpf/bpf-next/c/bc3905a71f02
  - [bpf-next,v2,4/4] selftests/bpf: Clobber a lot of registers in tailcall_bpf2bpf_hierarchy tests
    https://git.kernel.org/bpf/bpf-next/c/12741630350c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



