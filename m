Return-Path: <bpf+bounces-12622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC67CEC34
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C5C1C20A3D
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555B3E000;
	Wed, 18 Oct 2023 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKuMiQG3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187215AFB
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7837EC433C9;
	Wed, 18 Oct 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697672423;
	bh=0nthA+YDQqkb7otQfdquZjEtKETdeajmlvz+GrkgoGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vKuMiQG3yyLOm67dyLTNJx7WLESCCmSvj2ZikfvOO2RUHTAHWBvjHIn0/LRf4i0Oq
	 GGHfT61ZAb5+IZA9jTRktTPuvJywOc9orLsTis2irF/wVlsKz6LoqQUstpKKPyg8lW
	 Jsbb9umrm9Vpw/14tni//18fwIXS33Q5tGJB1QtJ5DJ+miRBxekGxYHq9Yz1Wgt07p
	 keRsmWHiuCLfjDVOM6i9GSuOCYRgX8ARYrsSsdp/0gvk2BrQu7aVJKW8B8IrJj3aT3
	 bcrcjFb3ri6ajpRYxkSkYetrSxmF6aqrmtiq1WSXTnclluWUOnnNlEoD+4c7x8kNzl
	 pbzIs4Hv0RbTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E1FCC04E24;
	Wed, 18 Oct 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: Define signed modulo as using truncated division
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767242338.29372.2996084798084133663.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 23:40:23 +0000
References: <20231017203020.1500-1-dthaler1968@googlemail.com>
In-Reply-To: <20231017203020.1500-1-dthaler1968@googlemail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler@microsoft.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 17 Oct 2023 20:30:20 +0000 you wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> There's different mathematical definitions (truncated, floored,
> rounded, etc.) and different languages have chosen different
> definitions [0][1].  E.g., languages/libraries that follow Knuth
> use a different mathematical definition than C uses.  This
> patch specifies which definition BPF uses, as verified by
> Eduard [2] and others.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Define signed modulo as using truncated division
    https://git.kernel.org/bpf/bpf-next/c/0e133a133703

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



