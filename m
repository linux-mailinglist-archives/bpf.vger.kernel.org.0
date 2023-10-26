Return-Path: <bpf+bounces-13323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04577D8441
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA34C1C20F80
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFDE2E62C;
	Thu, 26 Oct 2023 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro7MUQNx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB05848A;
	Thu, 26 Oct 2023 14:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56A23C433C9;
	Thu, 26 Oct 2023 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698329424;
	bh=BMrxVm/sGBoi3dW6drBne2iCG6tmh4h37WbIlobJunw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ro7MUQNxxSdT0h2O7259MH+8oXvQABZ3CyI+29cPbfTXI5ih6yYyRF3ZsjHUHOv5S
	 XLNnvZhzNQ5MRLrAHZd1wzGIlQGSfyvxLAlWqxLEPX6EaCU1tp8c2T+JKM9RoOJsLQ
	 ZeIYbEkVP0xUP9r5UAYIKouEp2e5kWiJUUnCeAUrBQ8MhhkzPQxiwi9bBhElUy0wID
	 K6YxIb29sc51buAFMdYedZ2gvvXSH4vmmkMwNnGiBGWJPX5AGth4QSGRpbYbbDt0UF
	 AYcGNaRhLIA2pT95VEozoYUHdOLVd5fmS2UvpMzw2dmI04n1WgW866jKVFM8dWzzd/
	 s3ZZqiY5xQ8mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39A4AC3959F;
	Thu, 26 Oct 2023 14:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] netkit: two minor cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169832942422.23002.17141975863236613572.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 14:10:24 +0000
References: <20231026094106.1505892-1-razor@blackwall.org>
In-Reply-To: <20231026094106.1505892-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, andrew@lunn.ch, toke@kernel.org,
 toke@redhat.com, sdf@google.com, daniel@iogearbox.net

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 26 Oct 2023 12:41:04 +0300 you wrote:
> Hi,
> This set does two minor cleanups mentioned by Jiri. The first patch
> removes explicit NULLing of primary/peer pointers and relies on the
> implicit mem zeroing done at net device alloc. The second patch switches
> netkit's mode and primary/peer policy netlink attributes to use
> NLA_POLICY_VALIDATE_FN() type and sets the custom validate function to
> return better user errors. This way netlink's policy is used to validate
> the attributes and simplifies the code a bit. No functional changes are
> intended.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] netkit: remove explicit active/peer ptr initialization
    https://git.kernel.org/bpf/bpf-next/c/ea41b880cc85
  - [bpf-next,2/2] netkit: use netlink policy for mode and policy attributes validation
    https://git.kernel.org/bpf/bpf-next/c/3de07b963ab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



