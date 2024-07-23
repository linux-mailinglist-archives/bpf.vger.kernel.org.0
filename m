Return-Path: <bpf+bounces-35427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7C93A812
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04F5283255
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32D14389D;
	Tue, 23 Jul 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwqxndtU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B913D898
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766636; cv=none; b=Czs+cwUJSIeAOd5QaKn7ps8cS4/nH8dbsWX7KRAKZnyExqsMjXktGYWBSWB0Hr8oeGebsyBROyaNm+semjcP2jSgzGJFuZLDEn+NZ+M74+uRpv4ne4qQkTmo28bT4jMfA6LorHBaG83XMJ5fgfp5EAhHQabvGBl7j8WKVE6l+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766636; c=relaxed/simple;
	bh=3LcB8bPR4r9jCMhinz6NWRl87VzJeh/dKx46sHjXUnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sxTQpp6vsCgSdzNhGgi32/8ZfFbXjKKJtHv7sNOO4mXMzq5sm1cmzmi5sUKEtjXiC/BpvK85QJSOSeaeNf7Uj+WnKKRNyXjzu86vFkB8Jh1nDxyun2anQBsph6P7YVJFFMZUvlzF8XQfKW/7IZNU3uvCmJRBWssV2rDxAJl+lt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwqxndtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF31C4AF0A;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721766635;
	bh=3LcB8bPR4r9jCMhinz6NWRl87VzJeh/dKx46sHjXUnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kwqxndtUuEOodxYeQReNP8jNlwS6OgaKrHfmJEnR9Xk1O2Y7M58Yhdu3PQs69/lnt
	 BRStp7xBz3uI8jbZM6F5X6yBt1Q+ZC4RcKaJWHlJpKetXyEqY/GrSsDzI1D3UIJwcR
	 Al5DDCGZeFHqT9wU7iUXLvtg8cIEEu5KXGwdrVBx/Bo2rb4T1hnUNcJByKaJ+Nv46G
	 8JxjKeQRvMogVUliRCs2yHEIQ3a9SZEKOFgUbpyvlyBdbdbOzRPE7M3eMw5Yo4tBfM
	 2zlWNpSwdfRVbfNoIpvIMXb8UU3HSTkoBnayDg45SPLrL9ZR/pkmw5MtP/GThhyTxm
	 ZiV0AnF1y+GzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F6DDC4332C;
	Tue, 23 Jul 2024 20:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/2] selftests/bpf: Add more uprobe multi tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172176663558.27466.9674850229320310129.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 20:30:35 +0000
References: <20240722202758.3889061-1-jolsa@kernel.org>
In-Reply-To: <20240722202758.3889061-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com, oleg@redhat.com, peterz@infradead.org, mhiramat@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 22 Jul 2024 22:27:56 +0200 you wrote:
> hi,
> adding more uprobe multi tests for failed attachments
> inside the uprobe register code.
> 
> v3 changes:
>   - renamed several variables/functions, null check [Andrii]
>   - fixed CI issue
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/2] selftests/bpf: Add uprobe fail tests for uprobe multi
    https://git.kernel.org/bpf/bpf-next/c/f5ee7d559a7c
  - [PATCHv3,bpf-next,2/2] selftests/bpf: Add uprobe multi consumers test
    https://git.kernel.org/bpf/bpf-next/c/c5ec71c325e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



