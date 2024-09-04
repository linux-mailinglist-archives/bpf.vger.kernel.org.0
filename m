Return-Path: <bpf+bounces-38923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C2196C7F1
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CEA6B22F79
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F571E6321;
	Wed,  4 Sep 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0hzgkME"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47E40C03
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479433; cv=none; b=DlmInmmC8VbaoCvnI42AHg0O1nIXKAA4aUl2OSDyD5FGO2W/ydlZcnmSIjNJd/I2gXR0f61LlP9YMoW4BkH2dQrQ5Ht5kyjRcOTAmBKvu2kDhuKihizKcdI5DwrQCRDxB/q2QT13pBHqSXNG/u9YmJDyMvXkvYbbXHd5/B3piP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479433; c=relaxed/simple;
	bh=RhXh1Kkpwv1xWPGfr1IOPNK0ATHXNNczrhEuLrIc+wk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SY93vzucqdknCxmhdkQKlaVlWS4L5Q8uVTB8gVLSnY5ZpCP4Vq2+oOHzGGWiYP2IbyjV+Keqj3XriDmVwH+GWdbG1inFtmfh32FmCfgRysx0qURmWTTABurF8BQTaKXcvTW0zyPdOmyNpNlOHZnz6Xyj1lV487CUeMp7XRL2Gvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0hzgkME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B58C4CEC2;
	Wed,  4 Sep 2024 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725479432;
	bh=RhXh1Kkpwv1xWPGfr1IOPNK0ATHXNNczrhEuLrIc+wk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T0hzgkMEJXIF2T6MvB5fA6BxYBWwRS2GtN1kBJq9FW2YXdfOkPAQhjciB0pLvpZ4h
	 vPBWFzg4GVDnsNxCRmAX84BoTDZ+lzsD2Y4ZoUQaH6M75iKQLnIqfVNuy7+iUhRQ+N
	 bDP4C+HEY9oebYz8crubze8N+nX6NnGpZHwOhsbsRKM9E5D5VYzj4vP8XxeiNbT8QY
	 EuiqfL+eDXOvDavKoRECVhFkJbAmXJTS61pZexJBdTsYDONgDHb9SzVVLdTG3h7p6e
	 gUBSyCjvTMmplCA8HGSlvmCrEUsYNYnTgleDqXtw+FoFUgo+Q8W0fQj6wTiPdI82lB
	 9uU7To1QCb0fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8A3822D30;
	Wed,  4 Sep 2024 19:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Follow up on gen_epilogue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172547943352.1148997.10438402101724044034.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 19:50:33 +0000
References: <20240904180847.56947-1-martin.lau@linux.dev>
In-Reply-To: <20240904180847.56947-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Sep 2024 11:08:43 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The set addresses some follow ups on the earlier gen_epilogue
> patch set.
> 
> Martin KaFai Lau (2):
>   bpf: Remove the insn_buf array stack usage from the inline_bpf_loop()
>   bpf: Fix indentation issue in epilogue_idx
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Remove the insn_buf array stack usage from the inline_bpf_loop()
    https://git.kernel.org/bpf/bpf-next/c/940ce73bdec5
  - [bpf-next,2/2] bpf: Fix indentation issue in epilogue_idx
    https://git.kernel.org/bpf/bpf-next/c/00750788dfc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



