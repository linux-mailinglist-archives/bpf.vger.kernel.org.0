Return-Path: <bpf+bounces-56516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27B7A996AB
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54598921C32
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8D28BAA9;
	Wed, 23 Apr 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCd/motd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCEA28B518
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429391; cv=none; b=FiSP5EpT4zvAeBLbB5i/UZGIGpSrfzLyVQonTjsFMp8IMZ+KizEfrhmhBUwFZ3CljxFR5WJ47Itn+8fzvrOXotT6HSPGWhPaqAJHAg0g/gsKcUtDxJhsXZt/73koQD2BHWsHzDuKKL3/aViFaFhMw/ohGVizD6PEG8HZp/AjyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429391; c=relaxed/simple;
	bh=Fk4lJAfurWPO2a1dyGJn2d11QzFk6RvWvkUJC97Cyoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cJS4R9j7PzWKZZlYabkAWIwEV6qUBFPai8gv0kwMWMsN0CHpY++5nbkLxVkPTco348c3eqpqfz+IXHaoxvDOMaU62odZhKJ9F+zYhGfnYLqG9PiGm53kfCsyViT+Gueud6oBb25y/hSVqtoTJ5H+CpTOPw8Rmw4Nr5D2CE1XWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCd/motd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB7AC4CEE2;
	Wed, 23 Apr 2025 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745429391;
	bh=Fk4lJAfurWPO2a1dyGJn2d11QzFk6RvWvkUJC97Cyoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PCd/motd2KP2UWA3vOIDfXtq2zKAyArwiTJNaqHHEBn87SLAIivLzMuQvJi7Xp4z7
	 Lukg/DpZO4JtcnUhCpWldzq/fNlo4PGhGnR+IUtgk2Wg2DNGW+phh2H4wI0QHFKwUP
	 WcWHBegkKThrLzG8/8bo+V18vEM7z0uITDuz0fORfV4Y7rnayDkV8C1OcXlYiwfa5c
	 q6fb4WWySlj2a7KQUubnd1GVD/YsuYc/AOnbG7Epnejd10mof976OIFxFfngVMC/7n
	 3DxIaNxL7u1olXQP1Dtaftnmso7/tEH4kmzeVAZUWghBLkQkRrWfMGwnAHr7izgtTT
	 PmCu8/dQrghUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF0380CED9;
	Wed, 23 Apr 2025 17:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174542942949.2710773.11334405961436671140.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 17:30:29 +0000
References: <20250418074633.35222-1-shung-hsi.yu@suse.com>
In-Reply-To: <20250418074633.35222-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, memxor@gmail.com,
 dan.carpenter@linaro.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 18 Apr 2025 15:46:31 +0800 you wrote:
> >From bda8bb8011d865cebf066350c8625e8be1625656 Mon Sep 17 00:00:00 2001
> From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Date: Fri, 18 Apr 2025 15:22:00 +0800
> Subject: [PATCH bpf-next 1/1] bpf: use proper type to calculate
>  bpf_raw_tp_null_args.mask index
> 
> The calculation of the index used to access the mask field in 'struct
> bpf_raw_tp_null_args' is done with 'int' type, which could overflow when
> the tracepoint being attached has more than 8 arguments.
> 
> [...]

Here is the summary with links:
  - 
    https://git.kernel.org/bpf/bpf-next/c/53ebef53a657

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



