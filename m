Return-Path: <bpf+bounces-74617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A8C5FDBA
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E829935A4D1
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED361DF247;
	Sat, 15 Nov 2025 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3LjFYe6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439361C2324
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172140; cv=none; b=O3qaisqpBQwYLrt0KhYOxgnMvpevuTahtIMk3bfLmOY86+DD09ra6sNzV4rpy1ivAnM3TiKOzanBbmBOdNTICOPUKMvASqiGBOXvqTjuqlqBGwSa7s6DH8tVzkVbM6eKuvoGGDqF0X8WSS1YgfjPRECJGNEodcoX/L4TpcdUM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172140; c=relaxed/simple;
	bh=CpQ7r5DiLF/ytiOlHQ0b/NRcD9HKD6TB52KoN5ErrFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sf9c+P5cLPA7a5QOpP78iMlTeawp2k4ifp+SV+iLfv9ZxYuBoospKt1ILA+c+LmurffyYaqm9LlJAPGpORhP0pf2WKuT6Q7jdMeqqwC/ywihIf03ITeHOarzpNWA+Baio8avgS8vZWSeo34GsmJD6AT/P26PK8SnuwELL340x+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3LjFYe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131E6C4CEF1;
	Sat, 15 Nov 2025 02:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763172140;
	bh=CpQ7r5DiLF/ytiOlHQ0b/NRcD9HKD6TB52KoN5ErrFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F3LjFYe6e8eC0vcx8M8lbFgqI1bw1PsiNHLAXzfkttEUgZLR/uUi1yJduUBrTXcc6
	 CJDYZO+3IHAjyqSkiRakur8CMquP5BA1hSQJ0nfKb/z2EBMjCwfCpIhnB8Hv7TQE3b
	 0zgTYDGMyqkqyzk4/V/VpUTJfjGcvfIjTXPxrtFUJ2ghIe6hcYLlwQkdWmdAC0tYNN
	 YdgxbErJ7nqusfZYBnE3Alp7Ff6GSNtLjC8S5rwTdadNmewiYX0o1+ZVY9BpNhqn0S
	 +MeSU5YTYUwZsPd5TzrSicxGG00LW7PlKSQREZ7W4CgOJEjTBlikCy7xORP13hv0Bv
	 pOkIulo/DHRbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD093A78A62;
	Sat, 15 Nov 2025 02:01:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: verifier: Move desc->imm setup to
 sort_kfunc_descs_by_imm_off()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317210850.1905277.7296912042800942452.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:01:48 +0000
References: <20251114154023.12801-1-puranjay@kernel.org>
In-Reply-To: <20251114154023.12801-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 14 Nov 2025 15:40:22 +0000 you wrote:
> Metadata about a kfunc call is added to the kfunc_tab in
> add_kfunc_call() but the call instruction itself could get removed by
> opt_remove_dead_code() later if it is not reachable.
> 
> If the call instruction is removed, specialize_kfunc() is never called
> for it and the desc->imm in the kfunc_tab is never initialized for this
> kfunc call. In this case, sort_kfunc_descs_by_imm_off(env->prog); in
> do_misc_fixups() doesn't sort the table correctly.
> This is a problem for s390 as its JIT uses this table to find the
> addresses for kfuncs, and if this table is not sorted properly, JIT may
> fail to find addresses for valid kfunc calls.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: verifier: Move desc->imm setup to sort_kfunc_descs_by_imm_off()
    https://git.kernel.org/bpf/bpf-next/c/4f7bc83b9837

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



