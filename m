Return-Path: <bpf+bounces-27439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1DD8AD0CF
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BDB1F2301C
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81B1534F5;
	Mon, 22 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9jd0kXn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910EB152517;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799828; cv=none; b=bP5yl64EwXaWpq5AZG/unyRwgVBJAupRJu5ts6TbwmAtL7LEGta/arZm3hkG2JzbKmu5Fca3aOHY+t2rRAeL3gzEOYlRxbHZohPUtzOPxTze2A3NDCcja4rG7NTZvWfa8P7i5lq0D1KKwoIiMdRz32jKEiTi4kRdgNVz11nIZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799828; c=relaxed/simple;
	bh=DRpsO/qGwpqtZ9SV8MS4vlbsva1SoUOzG48RE15A66c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cJq7JhmrIo3vXfq8wxqUk/Wo1vPTN8pl3WtqHevx6r9x3FaZZUNJbiCWdU1+ImZ/4v/ytl3KgM35AIrC16Bkw9ILQmZHD2W6eNu8hpRROlAHPy2uU0079HhR+5ValwohNu5FOtiziPE7a97nV0e345tbV/e2gIuDIEWCsP9/wS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9jd0kXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10284C32783;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799828;
	bh=DRpsO/qGwpqtZ9SV8MS4vlbsva1SoUOzG48RE15A66c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I9jd0kXnqUj3o/guOVp7OnJKoWVTeteiOD6qcYTnTBQdQ6+raRGu/f8wfgILAygl1
	 wXFwt4bQdMXbeHQk/qHV56Ta1tuLkDo+//o+YB01qVWFA+JlFvaD1c1wTiKFVTBQqT
	 rDgzPq0Lgp0LfH7qod7BhJGqi8zUlfjwYN+jonUN9JQFwASZSWdq5p0QaejENMfdph
	 NMpmW93e/zpWgH2/REJ7IzkqCSYNO9+3TLkfKVqLo7yvXMm/llciYTCmcyMVBK8Bde
	 +y18nhLemaH5wH3xxr+9VGOfgmArZgXAsQzjpSXI/c96OSf2rb5DGnrt73G7rZtxGO
	 Ss0PKgNME1VpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05B91C4339F;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] arm32, bpf: reimplement sign-extension mov instruction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171379982802.28518.11875355744954376996.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 15:30:28 +0000
References: <20240419182832.27707-1-puranjay@kernel.org>
In-Reply-To: <20240419182832.27707-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, linux@armlinux.org.uk,
 rmk+kernel@armlinux.org.uk, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 19 Apr 2024 18:28:32 +0000 you wrote:
> The current implementation of the mov instruction with sign extension
> has the following problems:
> 
>   1. It clobbers the source register if it is not stacked because it
>      sign extends the source and then moves it to the destination.
>   2. If the dst_reg is stacked, the current code doesn't write the value
>      back in case of 64-bit mov.
>   3. There is room for improvement by emitting fewer instructions.
> 
> [...]

Here is the summary with links:
  - [bpf] arm32, bpf: reimplement sign-extension mov instruction
    https://git.kernel.org/bpf/bpf/c/c6f48506ba30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



