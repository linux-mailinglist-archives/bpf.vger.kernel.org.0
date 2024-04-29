Return-Path: <bpf+bounces-28066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C491C8B54AA
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AEE1F22356
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624328DDA;
	Mon, 29 Apr 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaKCEx3A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E628373
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384829; cv=none; b=OsJ521HsXFu5+Z/lQmtMNZs6ljbdg0LHCuPyBkp4OcsXk6uH0wOCq0P+hwauI0N+/uENAbzWoEHUnQleizApsIFxbw6M60vhRszt1Z2tkomIdOlWDrIIhGb5XV1zj7vrt8H2pKsPrp1bz8tDeTXhi4Wdyes4u+F70zbfrA6zOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384829; c=relaxed/simple;
	bh=2m6SFSB/85dp5BReIECje50kuiAuRQKPeVq/QXF2r8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n5n7w14wbH0pQL9v7DYVBomFHOQaNN8L0LBk6/T2BtSdaehge6a/u6kbDlKwiV38raKI7kusblpoH0LLAXGjpr48WaHufhYHdt4h/l7VvKSg6sFg3yl7YU/f+dAHZxHw7ZOo+pKxxukyipteAKPmn1snZs2vmS3rzPf001a+BzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaKCEx3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C236C116B1;
	Mon, 29 Apr 2024 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714384829;
	bh=2m6SFSB/85dp5BReIECje50kuiAuRQKPeVq/QXF2r8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TaKCEx3A7BcVS9joSgdOQNUj3DYNz10MexrK9c9lCFC/qM+prUMwY1dMy/lPKK5rM
	 SSL5WVXbnfSeBCPmorCn2fwXTaHLT1VD950eCJ67TlvykIkEbEN0idkYHOiR9UiOvp
	 S8HcW44ijOnjbA/9CrPBPe1DYaID7c846Y2qTYl4vfUcSd+8x3/5tCe4WiCXzJG6Hi
	 tpz52FqbnPjwnmZfE4u30kqxuQvTszjjL6nHQipjQEs6INydMzuuDuLUNyp2cD2P7J
	 zvoYKWxZWSUqePta/YhbD01dVHPUNFSWcntzLTZGBOGl9nJMrYFOtbZy4mox8TGu3x
	 RLCsHW6mdjbZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EFEAC43616;
	Mon, 29 Apr 2024 10:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf, docs: Clarify PC use in instruction-set.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171438482912.23086.4653983782324514524.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 10:00:29 +0000
References: <20240426231126.5130-1-dthaler1968@gmail.com>
In-Reply-To: <20240426231126.5130-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 26 Apr 2024 16:11:26 -0700 you wrote:
> This patch elaborates on the use of PC by expanding the PC acronym,
> explaining the units, and the relative position to which the offset
> applies.
> 
> v1->v2: reword per feedback from Alexei
> 
> v2->v3: reword per feedback from David Vernet
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf, docs: Clarify PC use in instruction-set.rst
    https://git.kernel.org/bpf/bpf-next/c/07801a24e2f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



