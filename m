Return-Path: <bpf+bounces-27333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F78AC032
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBCB1F21044
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715021C6A6;
	Sun, 21 Apr 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXSxN5lh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD11C292
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713719429; cv=none; b=Mzbe0p2COcJbQy5eIjWzGXvXqA/qhbuyqy/xPIeR0I2U7cBPayADkDtrOv+umlhr1wqYrEYxuI4ZjRgpvNzWPGF5qHjYDHc2VAOg7oMcgC7eclXUhrQ6hRsUAQk4hWaLk91Lw42CNm5UOlXB7QiwSDAm8o3uTDUbIRCU7W+4e1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713719429; c=relaxed/simple;
	bh=plLIIstdrENFlQzVEqWLcwaN2/pfYkyA+yVUWIMriZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OnzUDtACj9AyZhpP6JqLzkKjoJnqh89fjiDBgutI8zWq5uuZ/eOwxqRKtYjGGhrnkKsQricBRFIVBD6IcYmH8A8psPQMB/AsLSLthtIC1hZpAV21jfxjxzOchcRmGLhJIwQcF8/00w2W+OugHUxXmgjINShy1GpVgxNYria/FIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXSxN5lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90920C4AF08;
	Sun, 21 Apr 2024 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713719428;
	bh=plLIIstdrENFlQzVEqWLcwaN2/pfYkyA+yVUWIMriZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BXSxN5lh5w6ZIfwyUxamUs5SIco/mSQblDgQiq+FuOU/d/T+3NuRleDLTtgHWyQog
	 c9IkmZBncUFaBUFd9T5dMYbXGDnMM/FfajH3kXwnKQ0qTP9Tj613Tg91CZyHUXsdUX
	 NDPTZoJv/KT/NwCJCC+8p3Bu4LVXXdSwO7kGo7ZrKyziRlY/fkHfupRJGRdpOFVXTy
	 aoe+6l9a+LHE3kUAJ7qHD/ZSV+eX4feEPAIVpfqjYgPQ4aV6ezg5jZTzntjp1jBFFJ
	 IGdkLGUsKbNhZNgJuXHTwL9jXQtTQm93fyF9JxjM/HKpNJi62ht9yXXIB+a3dEf2Gf
	 ez5Yt3Ncx5kpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83353C4361C;
	Sun, 21 Apr 2024 17:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Fix formatting nit in instruction-set.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171371942853.789.7835756158212522740.git-patchwork-notify@kernel.org>
Date: Sun, 21 Apr 2024 17:10:28 +0000
References: <20240419213826.7301-1-dthaler1968@gmail.com>
In-Reply-To: <20240419213826.7301-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 19 Apr 2024 14:38:26 -0700 you wrote:
> Other places that had pseudocode were prefixed with ::
> so as to appear in a literal block, but one place was inconsistent.
> This patch fixes that inconsistency.
> 
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: Fix formatting nit in instruction-set.rst
    https://git.kernel.org/bpf/bpf-next/c/735f5b8a7ccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



