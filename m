Return-Path: <bpf+bounces-20936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D48455A2
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44182282278
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4546715A490;
	Thu,  1 Feb 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVY5cL3B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF02747F
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784027; cv=none; b=iAQFlOaTsTUAiZlO+1wOcF7IhyTIaDL0vgo7euRqoAIhPd7eE+dnz1fb2Cb4oXGcmpT2cYo53V0qcjxC7bk0nHN4JsKBdIu+KCDd22zllwHyPuOwny6JiB79ZMBM4CtgrLRxLDdqY6dPtEUe4ctDqeKU6XUo4wxUT+m53CLCRsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784027; c=relaxed/simple;
	bh=rSDf0c6vdzI4dg316U8Bj+RWJZPyoXXPF/jYWG9Z1dM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=siPe78urvRRBRIsAivH6LxL6ltQZzzNGtezApAQPwVZ4/xB/Atcd7c9/qAZJg4dOBCmcR70m7OYeVWV8XGQDDcw8yRn7nd1ykKrpAXTqmyWN0aV3o8ZLEiV8Yyntz8rwPiU0IYDgHo3CmlkrorKogFj7MwjGIVH3APS/WiwrTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVY5cL3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FF54C433B1;
	Thu,  1 Feb 2024 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706784027;
	bh=rSDf0c6vdzI4dg316U8Bj+RWJZPyoXXPF/jYWG9Z1dM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TVY5cL3BvKJcasZ0u925XyoPva1zN/DYjc2p0PnmCCnbOsvLj+mMHIQEBNA91/Br3
	 JECxdcrOrrXwq9HUpG/CFfm+JLCm+KZ0+a2WUxWxYDCZcLa0E/lJ7ZwpIWTn6u0dPK
	 i4usrrKtVT2kNdwRpYF7sXBr3JA7kPa9W4jVqrKX20DWIA/yNY8HST0Oh1I+BtPDS0
	 o3lgNDG2+xMXq43TZspmZ3G5umVyQWqcyn7HrbJk+3U2C94jP5thMEoV0S7ugfepxz
	 MEBH+Bwm2NBCrS/hCUbnRCI/7K2wSvnMKPTrXTWDcayPVI5WynGlHhazPqvEU7yMfi
	 +rhkQm/ipnryA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B0E8E3237E;
	Thu,  1 Feb 2024 10:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: Clarify which legacy packet instructions existed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170678402723.13930.16089071763992664119.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 10:40:27 +0000
References: <20240131033759.3634-1-dthaler1968@gmail.com>
In-Reply-To: <20240131033759.3634-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 30 Jan 2024 19:37:59 -0800 you wrote:
> As discussed in mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/5LnnKm093cGpOmDI9TnLQLBXyys/
> this patch updates the "Legacy BPF Packet access instructions"
> section to clarify which instructions are deprecated (vs which
> were never defined and so are not deprecated).
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Clarify which legacy packet instructions existed
    https://git.kernel.org/bpf/bpf-next/c/088a464ed53f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



