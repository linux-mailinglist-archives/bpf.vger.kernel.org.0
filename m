Return-Path: <bpf+bounces-21945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E68541A0
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFBB1C21BC5
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329453BE;
	Wed, 14 Feb 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaDE1avc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3C387
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879029; cv=none; b=YNi3rEbHNk4RiXXpnnE3/Vdacg3VAvWJQAGU2tkPXFmyZ2VTyGiWYgPEBfaNJG3CGdgbHdIYdj/oNn+oOhsvCGmlnnTHCXuY+4XmvphEa3MMjuwu39RK4gS34KFkHsNAw7HgJfva+iUFkFgmDTwZV2s/fc/m9THjLB+LF3LGFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879029; c=relaxed/simple;
	bh=e2M32uwaXVn4Jy8gqsgOliCS2Q7fqlcEY6NjrvgOri4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=coO13ZRWniviiNXTwM5V/aMmYZCINiny3wJcYtFHBms4wzVTTuYUoiu105gg6/KaxEvWWCScHAdytQleqGhzMucBlgeRVSJINwaiiPxoBsj7uS9diKIHCEXcCSjm4Z9f2cA6LqPpeDrJIKzwO20HMb9QdZ5r48K/z/3wwC2SgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaDE1avc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AA98C43390;
	Wed, 14 Feb 2024 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707879029;
	bh=e2M32uwaXVn4Jy8gqsgOliCS2Q7fqlcEY6NjrvgOri4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TaDE1avci3AD5VRaqlAQkrHrF79F7zmUiZszTxSMMM6BBO2y7ufd7sSKGYjmM/Q63
	 nHWwVQMRgYpDDqbY2djfQjWmia2EjwXsxpigNtAcl6NgLusWA2NCRh0RB5G7OdmjHs
	 OEh3suwsPET5T1JgfkNC7HVrAWUxMC4/HeX5XM7d4eHATMdCETF5SsNIndTfN9YsDy
	 GvneCrB622uTk18rtSVTTWIH2NzBieq0Si70r98rcph6Aea/PelOAZC+ayaFgCRv+S
	 wighf/w4bUVMhtd4imVdbO0NbzYSqoNntJtjruu7WI/5QYzy8SSdbTqtfHSeMbfwTr
	 4idR279+PqjJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11958C1614E;
	Wed, 14 Feb 2024 02:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/4] Fix global subprog PTR_TO_CTX arg handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170787902906.13249.6108551210318316344.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 02:50:29 +0000
References: <20240212233221.2575350-1-andrii@kernel.org>
In-Reply-To: <20240212233221.2575350-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 Feb 2024 15:32:17 -0800 you wrote:
> Fix confusing and incorrect inference of PTR_TO_CTX argument type in BPF
> global subprogs. For some program types (iters, tracepoint, any program type
> that doesn't have fixed named "canonical" context type) when user uses (in
> a correct and valid way) a pointer argument to user-defined anonymous struct
> type, verifier will incorrectly assume that it has to be PTR_TO_CTX argument.
> While it should be just a PTR_TO_MEM argument with allowed size calculated
> from user-provided (even if anonymous) struct.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/4] bpf: simplify btf_get_prog_ctx_type() into btf_is_prog_ctx_type()
    https://git.kernel.org/bpf/bpf-next/c/fb5b86cfd4ef
  - [v2,bpf-next,2/4] bpf: handle bpf_user_pt_regs_t typedef explicitly for PTR_TO_CTX global arg
    https://git.kernel.org/bpf/bpf-next/c/824c58fb1090
  - [v2,bpf-next,3/4] bpf: don't infer PTR_TO_CTX for programs with unnamed context type
    https://git.kernel.org/bpf/bpf-next/c/879bbe7aa4af
  - [v2,bpf-next,4/4] selftests/bpf: add anonymous user struct as global subprog arg test
    https://git.kernel.org/bpf/bpf-next/c/63d5a33fb4ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



