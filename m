Return-Path: <bpf+bounces-41787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A996D99ACDD
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530901F22356
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7E1D079D;
	Fri, 11 Oct 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnu53OIx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E31D0799
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675623; cv=none; b=MZTlG8uT0XWn160m55dhKOgRU74oSjZN5CXWIxuCo6BcHTAzEoXGQJtR3i2b/bQEtcpC2tzNQqr4KVBK1fEVDPStGxfe8TMg0Sv1sGssYpMifrg82ZVcvDuS6qSgrga0U7pTOXr831voUE5NiTOn1iyFWFM35vQCEaoxqM8v1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675623; c=relaxed/simple;
	bh=nUBtk4oapBvLC9SzOinz8CPYCECWLGcIiqv9Ia0rhq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u2Fw0aFRptxGRS7o+K3FnaqETSa5VhBcNJxBGBzSSrJ/xtAWK7oQ634xVVXE3paIsjpeEkcn2LMaTA5NaOXfgv7EZTSRi3rfok1+O5D4l6xxzXLg21d5Ov5I0F+Qy1Z5THj8O2v0mkhgeAhbpqT3rv98lW/1FD6162rF89mIvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vnu53OIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94602C4CECF;
	Fri, 11 Oct 2024 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675623;
	bh=nUBtk4oapBvLC9SzOinz8CPYCECWLGcIiqv9Ia0rhq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vnu53OIxAP5SVgmX79BTKuOUl4kwqpUpqWmEHnVfdp5auFUVFh5os2hqteI5Pjkoh
	 I1Igk6GIt8i0x4g4w6fzeiAtBg9kuQO5GpbLWpH3N4NkqEKGXsaZcfOByRoa5qNlF4
	 li/O1rO4AdExIzUk92LAV4RiCtW5tHpb4byUyJ7l4pOZ97vt7E2L37BbSKnKFiY0y5
	 6iMAVUqA0A5tIZN9Sewz05NC1eOfkW7VB5lWnMvS3u2//+uv3JFT/HHfNLB2dSK5kg
	 G44Y45b1A0KycLWOvNaMb1u130SPWzsP0a8PhSQ+Db7HaiX2mdgvM2iP8+GY8+kIHr
	 7PkkHhFODiHJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CEC380DBC0;
	Fri, 11 Oct 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: check for timeout in perf_link
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172867562826.2977918.1652782277962687660.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 19:40:28 +0000
References: <20241011153104.249800-1-ihor.solodrai@pm.me>
In-Reply-To: <20241011153104.249800-1-ihor.solodrai@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 11 Oct 2024 15:31:07 +0000 you wrote:
> Recently perf_link test started unreliably failing on libbpf CI:
>   * https://github.com/libbpf/libbpf/actions/runs/11260672407/job/31312405473
>   * https://github.com/libbpf/libbpf/actions/runs/11260992334/job/31315514626
>   * https://github.com/libbpf/libbpf/actions/runs/11263162459/job/31320458251
> 
> Part of the test is running a dummy loop for a while and then checking
> for a counter incremented by the test program.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: check for timeout in perf_link test
    https://git.kernel.org/bpf/bpf-next/c/e6c209da7e0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



