Return-Path: <bpf+bounces-53371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486AA505D5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F9B3A089E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7BF1A841A;
	Wed,  5 Mar 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXsgKNiv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43001922ED
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194000; cv=none; b=UJv8/HraNsRzDu1pku239KrkT9bxS1NDFfbkYApCRZXT98vhQ1VE9Z5Unl1GgYV1ioO1tyFd789bO3lsTqN7xmvt6z+oO6fpzoNa9MWBRDa0kJJeUWmoq8UC/cPxRnWBFV7gKSzIGUKJM5Zd2iWWVcmsOhvfxmyd9PApQsgJvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194000; c=relaxed/simple;
	bh=5tpyGscuLvYQoId4CiAu+ZdgnGHPwZLcyb6nFUwplm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bjn3ecOgMQM2ZKwY01d/PzXv/ZqtJaI+iP1UXasUGiz76oHijI7O0gVs39HkLgKVnSHXQv06o/KtUygNcY/hBZ0+hgycYnNn6a42CV9762bpsyoQA1EeEfpJ+H+Tzrsno3DcuIdjoQdmcMt032JTfGCbNA0Cn+xkIAmA65/EWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXsgKNiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE6FC4CEE0;
	Wed,  5 Mar 2025 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741193999;
	bh=5tpyGscuLvYQoId4CiAu+ZdgnGHPwZLcyb6nFUwplm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UXsgKNivTW1SO8moKOmDtD+nuOzXKt8/rAxVZsdYes+oFZS5MpYhZvPcQTPNVQYst
	 nDkvqRXISxHH10TPKXXP5xFB45Rgi29HptDbdOEeZx2kq+sISX/rBT5IKaz+0rfEYV
	 fGodaNzBTMwG/WJsJB/iqcGCo+TXUdixTCzyAipvLF1SNLCx6vORBmc3NtKBvQPQr7
	 q5t14XO1KOg2Ha60s0MtXBwXAK5p6Scpv8i1o3s5s3mr4F8Sd7HodbBjesCuBHxALJ
	 mXVhRfBsHUrpmm32Jz/6jkWC7o4euvEz2y9+5K2JaDpxL0CoYZmtdzsayjoWk8ZYyZ
	 4FFjWOJvtcuQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE29D380CEDD;
	Wed,  5 Mar 2025 17:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: correct use/def for may_goto instruction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174119403252.950339.17522498560947756085.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 17:00:32 +0000
References: <20250305085436.2731464-1-eddyz87@gmail.com>
In-Reply-To: <20250305085436.2731464-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Mar 2025 00:54:36 -0800 you wrote:
> may_goto instruction does not use any registers,
> but in compute_insn_live_regs() it was treated as a regular
> conditional jump of kind BPF_K with r0 as source register.
> Thus unnecessarily marking r0 as used.
> 
> Fixes: 7dad03653567 ("bpf: simple DFA-based live registers analysis")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: correct use/def for may_goto instruction
    https://git.kernel.org/bpf/bpf-next/c/aae1add9053e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



