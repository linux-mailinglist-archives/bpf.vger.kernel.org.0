Return-Path: <bpf+bounces-21353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4F784BA1F
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62A81F26D0C
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35641339B7;
	Tue,  6 Feb 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5Rl9XQt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48A132C38
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234629; cv=none; b=s+JUhYsOI2rssGrGWLiZgstxiKyvZCuoVuMmiYixenybMx8nALgyfGfwqnP5oQGa4Ep+34yxlWxnU65D2Eq2Ce7f7AhdoBXsFSHIhmREOcPkRJ5xrM0nIh2JzyQOogXvEir7ZXgw69IV52E18QJCvgcqCUeUe9pYDe8FG/BaWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234629; c=relaxed/simple;
	bh=7neVWuT0tDvo4+ZISzPyfX85QGM6jCmvjZ5T20l5iOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UBmGr9HPLJRGdOzb/8dc/85MJzDD0qe73kVzrCYh1bsvrno2C1VU6eOrBmo8NorfOuV1eamFIssM3Hi2HM5dOerqHaNA7dRvTQDg0cp8DWn1OHEV524jawVYjH8bb3gqDiGWH64LEVQJgYCXNjuHSw7QcIj9SLkHn23kGCDitIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5Rl9XQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4151C43394;
	Tue,  6 Feb 2024 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707234628;
	bh=7neVWuT0tDvo4+ZISzPyfX85QGM6jCmvjZ5T20l5iOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c5Rl9XQteVxBhz9toI5FK+cKWLkeLfiXSLMbx+sZBDf4cxhyeyRSlWLWhoiTd8GPY
	 vHndXvTpuRWRkGjeklCR7GmZwks1U62OAiqnuaLC4KdmZYWbZRJNMjP4IdtX7GBmD+
	 bFrzLfW5+re76WHbt5OQgyF1YcYKLlVOiwqFkDhVubuFO2Z1FYpr70w3Di6I8Dg4x+
	 +bXUvrJYDzejBcozYKVi4DrTi14/4txXs2u4hRXeWy+PW7z3UZhWhcDbVyMP4ZCUI5
	 +IFLtfquz30gY8ydDnlOlOw7QehIe3X/eKaTGGng3RgEGFOcCnUQdP20IaBh4ENd0b
	 ASZjkBa1rdEmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9914CE2F2F9;
	Tue,  6 Feb 2024 15:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Fix typos in instructions-set.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170723462862.7494.10855901799714067103.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 15:50:28 +0000
References: <20240206045146.4965-1-dthaler1968@gmail.com>
In-Reply-To: <20240206045146.4965-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  5 Feb 2024 20:51:46 -0800 you wrote:
> * "imm32" should just be "imm"
> * Add blank line to fix formatting error reported by Stephen Rothwell [0]
> 
> [0]: https://lore.kernel.org/bpf/20240206153301.4ead0bad@canb.auug.org.au/T/#u
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Fix typos in instructions-set.rst
    https://git.kernel.org/bpf/bpf-next/c/563918a0e3af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



