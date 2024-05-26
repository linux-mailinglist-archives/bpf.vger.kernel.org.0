Return-Path: <bpf+bounces-30615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB908CF4F6
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 19:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CB21C20C0D
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2221C69E;
	Sun, 26 May 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4tkMzqg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B2018B05
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716742831; cv=none; b=Pi9KlscS3MGujatf51ZvRPaZbt4yeNx7XPjYcCqCLh/TMNhkKm1Wh9bnK/6dHtafzUqvTp4pzj0arNU6QOWM7pQZEqNbIqCahNJfGUHbOD1nJpdfcXr79NnvBmiYs6Rzqn6bYmLJgwBjNqwGmy2WLcHAZpB+Jeeb7SUrwf0H+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716742831; c=relaxed/simple;
	bh=gS7lYaFNWNAy8GLuurB0mYrAv3UVEtRt/EUmmNMHLe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FXNxaySUJxrofaUJ44DwGEttcLiN69pJupbsHxsWXJgUrKutHAk7Ueu5SlOwnoNmFR/SwtUFeydqkcinXaE0SVmYLPU1d4wHQs1nfX1ydumxjTtIsoO3A38k7Fhg0kANZl2hcok3k3C367SlFYLHpNbEUfZXsujvRLPKdmGkz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4tkMzqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AF35C32786;
	Sun, 26 May 2024 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716742831;
	bh=gS7lYaFNWNAy8GLuurB0mYrAv3UVEtRt/EUmmNMHLe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S4tkMzqg1U3N3BG1FZFplmP4Sr3DFTzdqQmWn61JNTwxWLCr4Ef/PYMvWg6xjITpD
	 S7Sl0/WADJ6x+G/TNkX3/ILr/E/YX/TOdijvgy4kPfxQokzEvgVM0Vi7PgE8wbQ2Qy
	 4iRHaOBud/tSXW21bUir8ixDigE601FAy+nCVJCur9Q7+hdiQqF9HAyhjuHWrFy6JV
	 pgtRfm/GjDXuNf4wfsqwhPIKfmCYZI0otNFhATHPyWENJM1QhA4rsQa3nzs2JgZYCB
	 NuBXk+T67D6Z9wlZAkuPyhWazeOnIHJrUvRdpRA1zPLOiGlJ5CqycSePw6+Tn5yorc
	 574RiRwLV6A0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50008C43617;
	Sun, 26 May 2024 17:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Fix instruction.rst indentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171674283132.20238.16993241382696584849.git-patchwork-notify@kernel.org>
Date: Sun, 26 May 2024 17:00:31 +0000
References: <20240526061815.22497-1-dthaler1968@gmail.com>
In-Reply-To: <20240526061815.22497-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 25 May 2024 23:18:15 -0700 you wrote:
> The table captions patch corrected indented most tables to work with
> the table directive for adding a caption but missed two of them.
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  .../bpf/standardization/instruction-set.rst   | 26 +++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: Fix instruction.rst indentation
    https://git.kernel.org/bpf/bpf-next/c/e245ef8a0b06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



