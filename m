Return-Path: <bpf+bounces-34340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6848392C7F4
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BBF1C22418
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA579C0;
	Wed, 10 Jul 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJUGuMZN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958B4A07;
	Wed, 10 Jul 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575031; cv=none; b=BK/BEgv+YgT/1tlKhHxtgwx0dkoJkM0SRUCY01wsD2Jv1Ij22r9oEJaHG2YHNX+0SCRi15WpDSMIBkskoqXhGsSy483NtPOKFaeUY6RwZJBJZdOZia3XP89FzASypIU1b5gx8H9GnWckD+oeeXmayJRnCGWsXuya7PKcExj/+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575031; c=relaxed/simple;
	bh=Ly9Dtxt2ooKVz+p8nyWwIGIq21aaUXtTe7OVsje9UBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q1X52vG5q/HQxjLl88lUcftKhapy6/Fjf+4kqi/vgvT6k3mq9aBOW0KlLNtZT08sFvdC/6/4yJ1waefenMdnImTEWCss/Zl+2vV2yHYZEgFK7OnoUPIWsngELR1a2dH/t5nGI9Sp9tiyP2LDeP8lRhhIM/8LQktMVcnibiIaZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJUGuMZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57AC9C32786;
	Wed, 10 Jul 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720575030;
	bh=Ly9Dtxt2ooKVz+p8nyWwIGIq21aaUXtTe7OVsje9UBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BJUGuMZNyA4Uo/QHHkyE/VMWxyL6YpaF9N6MkyLEj+RfQHyInVZy6eX0VifbEwi1+
	 YDM0lGGm6unur9iKqB8Ulri6Vxpn79/8xospgo8p69g+7/LVWvZEgmHA1gNv3HCV4H
	 HMrrj5Y689likcK1QUvfiLh2GVRiH/b890im9vDGNTiyjR0kVn+DHIWeh5EdZZ181i
	 SRRKFpY9s20sg6yCG7DSPzp7n1J9G0/JHReoCVSuJIf0BYFwmzdqXKVRO21fLOlN2D
	 aP9+/7xQY08MvErQe6EVow4ntooWqCIbSC9i4KipTEo8YA7hrPW/YJMSWQRjB0qQKn
	 BZPZkcrknwTww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 444FBC4332C;
	Wed, 10 Jul 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: Fix XDP program unloading while removing the driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172057503027.14218.17686780823088535823.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 01:30:30 +0000
References: <20240708230750.625986-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240708230750.625986-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, michal.kubiak@intel.com,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, chandanx.rout@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jul 2024 16:07:49 -0700 you wrote:
> From: Michal Kubiak <michal.kubiak@intel.com>
> 
> The commit 6533e558c650 ("i40e: Fix reset path while removing
> the driver") introduced a new PF state "__I40E_IN_REMOVE" to block
> modifying the XDP program while the driver is being removed.
> Unfortunately, such a change is useful only if the ".ndo_bpf()"
> callback was called out of the rmmod context because unloading the
> existing XDP program is also a part of driver removing procedure.
> In other words, from the rmmod context the driver is expected to
> unload the XDP program without reporting any errors. Otherwise,
> the kernel warning with callstack is printed out to dmesg.
> 
> [...]

Here is the summary with links:
  - [net] i40e: Fix XDP program unloading while removing the driver
    https://git.kernel.org/netdev/net/c/01fc5142ae6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



