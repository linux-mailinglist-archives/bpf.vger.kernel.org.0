Return-Path: <bpf+bounces-46538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953D9EB951
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866C8188A001
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C64154C15;
	Tue, 10 Dec 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c570ERm/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A2DF58;
	Tue, 10 Dec 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855415; cv=none; b=LSIWGDZkxkbWzX9m1qSNVJmkWSEPWf84Dpc0Gju7PRqrqMSY1Q8FfCEaweCmrLB0RSfI5CAK4wpMCDxDQgZAElRXDWBV07R0yLwKdq11fEw0iZs6ido/G4v+6JhgBqxFgPDhubI3LKA0czheWYkd58v97ld+3CACDo6Qfgmip4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855415; c=relaxed/simple;
	bh=6+XaTaTNue4wy2FSdnIyl1DOA823ZDTPacm7x71QGRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nFmAXceU/3nKWgYmGbhjTfTGjsgTtl/5olcDRw93T6L0aXVIjvNxqwkdiawtLny5HemmDPPOAl8VbIsk5owCStWsjomKRGfyNKzc1Ym12F04ri6EAug1v4gzhtGehYeXMObePXjLvFpRBt6KbddeAVG3WmiIJ0vFArFioaV5stM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c570ERm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D1EC4CED6;
	Tue, 10 Dec 2024 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855414;
	bh=6+XaTaTNue4wy2FSdnIyl1DOA823ZDTPacm7x71QGRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c570ERm/rSVnEdkeZssIqWwvRZY03JgwkzIO4jIOwHR9vnZpo7PXEuVYwPmHF3xO0
	 XHcAk72wqANHwsTSJSvv/tAToP6eeb5sLSRTR8+86DqCZ/r30apGP/wErOgWRtN+0L
	 u/LDIEgqbB6PvGp2N1g1MEmR/3pNTNUhTiS2fsaA8NSQNPKeV80h2HvlAxsaU7uda7
	 x4zhZc+Zo9yu8h8/XBFfCqIOhA2TugbyfjUtnX+jbHpglGAfgwj5sO9dSi7sHyoEpg
	 Lj8jE9ZvJAybD43zvuoIfze8ZBCrrNeFJ5C7lIoHsvhZlO+Ur8Jms5uGnetDYf2hOo
	 MdOExFe3hdF7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B087B380A954;
	Tue, 10 Dec 2024 18:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf,perf: Fix invalid prog_array access in
 perf_event_detach_bpf_prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173385543052.937529.3035278335485000200.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 18:30:30 +0000
References: <20241208142507.1207698-1-jolsa@kernel.org>
In-Reply-To: <20241208142507.1207698-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org, sdf@fomichev.me,
 haoluo@google.com, sean@mess.org, peterz@infradead.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  8 Dec 2024 15:25:07 +0100 you wrote:
> Syzbot reported [1] crash that happens for following tracing scenario:
> 
>   - create tracepoint perf event with attr.inherit=1, attach it to the
>     process and set bpf program to it
>   - attached process forks -> chid creates inherited event
> 
>     the new child event shares the parent's bpf program and tp_event
>     (hence prog_array) which is global for tracepoint
> 
> [...]

Here is the summary with links:
  - [bpf] bpf,perf: Fix invalid prog_array access in perf_event_detach_bpf_prog
    https://git.kernel.org/bpf/bpf/c/978c4486cca5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



