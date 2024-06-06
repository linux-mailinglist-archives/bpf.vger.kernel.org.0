Return-Path: <bpf+bounces-31478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5911D8FDCAE
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 04:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9401F24E4A
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9558199B8;
	Thu,  6 Jun 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpB9Z4rv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E184440C;
	Thu,  6 Jun 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640439; cv=none; b=mndahq1ORhlYDrFo5W1cFnZJ1RZeDvBl1kkdmFksrkaFoxEMeqgAm5cgLjM6R07eF3gec7q4eTRe829Prmba0BOy7fpGCJF1erJ/HXtolBiXAWPSJCbTJW0/dlggWaW6Sbx3Ei+GYxP/a2SQf0tpiVp4dy6SHp8Nv4ExbD2dEvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640439; c=relaxed/simple;
	bh=yVM4UXYryD6+xTiJNedfKfni5JiHi3Zy13HliZUP5wA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=av6Ndd9M5D1NJtKPOvIF+N7ABva5jNO/XV5Oe9TOKoYKsKI9i3lHrb6+JL/2Kcy5DGXE58pd/U/O6XFyGfECOQVTctRLwXVaeJM4jic64DxrM+7MS7AUZ9KB3/HidaY804++CrbRLyz9qpbFqkYbzf+gjlUS9tuwZQlOgGuaDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpB9Z4rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C3D9C4AF11;
	Thu,  6 Jun 2024 02:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717640439;
	bh=yVM4UXYryD6+xTiJNedfKfni5JiHi3Zy13HliZUP5wA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fpB9Z4rvACyJH1iAZsKR2+6IZ6+iDAzRQHrr3c3jQ5zutTmzSEAygcEqz1sbj/Edo
	 w7+VCCEEZiLgEiJORLNNa9qjLXKCVd0pr1dnoMyRLNZ1ohrapIeSian6WzxwoJ9+UX
	 /BkSdzK+Alx0ZCCWMcmYUQ1MFTyZKzMMT4tSGX3CjXB/hoW/UABOwXBElRAzOthIKs
	 +zJmmdkvzjGphVarW7rFXbEVeLBKBEca2MG1dok0mGiF+d/znlZbLAwnC7Upsxnm92
	 g4aDJTVX7wWPgQWOHC4rMz0515eydX4mE02cvhtUVapciSoFHfzaT+NwzpsEomghZ1
	 D48pVaSKIpIRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2C1FD3E997;
	Thu,  6 Jun 2024 02:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-06-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171764043898.18622.17549557515869733799.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 02:20:38 +0000
References: <20240605091525.22628-1-daniel@iogearbox.net>
In-Reply-To: <20240605091525.22628-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Jun 2024 11:15:25 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 8 non-merge commits during the last 6 day(s) which contain
> a total of 9 files changed, 34 insertions(+), 35 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-06-05
    https://git.kernel.org/netdev/net/c/886bf9172da0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



