Return-Path: <bpf+bounces-21581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9340D84EF06
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5022A28AEF2
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF3468E;
	Fri,  9 Feb 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISgSmNu7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513C4A39;
	Fri,  9 Feb 2024 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447027; cv=none; b=F4m+9Yg7KA5vT6Sh4mKLqdN72U5HfS3XmXfmZcvGQd7hwF7RpWAeJvHMgwZwZ2pCXWl82tQAwPblHJIjdk7FeWBVOtEgsOGjbMoog28xk4WW5Q8Bqrdjnr+pB3t8MhF15+Nw/IKPAha+k6X6tB1rOCcRdsdtF7OuQqSi/rKpl8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447027; c=relaxed/simple;
	bh=Io57ZbX4TIh2WM8fozHkyciEnZkx2vuUJX8marjq220=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tJKTBukQeYg+daCef+ptdl5DZ6kyapkcRoVs2PR5ICUd1R8NZf+cp5nhUDj975xJ91/2Ndes0NNJQs/GvCE/q+lIo8lavIr8AfFumHnHKG6NG9qMnBHt8lj2wee9cdsGt2LrZbxrVmPPRWAothxjlZDac3RKVhSRJ3sab08vpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISgSmNu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED373C43394;
	Fri,  9 Feb 2024 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447027;
	bh=Io57ZbX4TIh2WM8fozHkyciEnZkx2vuUJX8marjq220=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ISgSmNu7bmN3lxt7jNewzTzJdvVgKQoz5JXHvV0TorqiRGxDOwSjQUAbFfY4dpUDg
	 yjzEBUSY4/WdLHY1Gw8kiBQcR+0lg9xVdo26fLb6lFbYBq1zMdSjAveCjwKiPBjufr
	 t19oY8MI+TFFVJoXBK/cOdIbkZM3V3b0mZRusyiPuqFNf4oKVUJQDkqTTPSA/psqZZ
	 9w3Vcuri1zX109ut8/P5Jlr93CbZR2cLvQ9dz6sfxAXaFMiAY54CC+r5lu4oOs5Zfr
	 d4OgE+q+KCIlS+3QZd2ij96dhiQsyqdH0c++7Y1MbUi2CFDauHz4ngG+n/fgetjTE6
	 b6cUeu09ivAuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA6F4C395FD;
	Fri,  9 Feb 2024 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744702682.13594.15329078929458071578.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 02:50:26 +0000
References: <20240207084737.20890-1-magnus.karlsson@gmail.com>
In-Reply-To: <20240207084737.20890-1-magnus.karlsson@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 kuba@kernel.org, toke@redhat.com, pabeni@redhat.com, davem@davemloft.net,
 j.vosburgh@gmail.com, andy@greyhouse.net, hawk@kernel.org,
 john.fastabend@gmail.com, edumazet@google.com, lorenzo@kernel.org,
 bpf@vger.kernel.org, prbatra.mail@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 09:47:36 +0100 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
> bonding driver does not support XDP and AF_XDP in zero-copy mode even
> if the real NIC drivers do.
> 
> Note that the driver used to report everything as supported before a
> device was bonded. Instead of just masking out the zero-copy support
> from this, have the driver report that no XDP feature is supported
> until a real device is bonded. This seems to be more truthful as it is
> the real drivers that decide what XDP features are supported.
> 
> [...]

Here is the summary with links:
  - [net,v2] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
    https://git.kernel.org/netdev/net/c/9b0ed890ac2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



