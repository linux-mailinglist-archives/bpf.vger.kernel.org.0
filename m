Return-Path: <bpf+bounces-27926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 927138B3876
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3AF71C23805
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB820147C61;
	Fri, 26 Apr 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1BK7n9U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EECC13E88A;
	Fri, 26 Apr 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138227; cv=none; b=QGrxbj3leG2GAwiyLB98Un4OS3itKzlQIoZP6FEWgMyvVQSaQ4Upp7CR6Q2VZUL0ez7JFf3SMdK2RRNmagtN5YPM9Lo2ihNonzVd418BkWljVL2xpKpa6/H4jhxito0bo8ljX37AB3pW/N+jeoRwHa8CHnxxPllfTQeRt6Sh5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138227; c=relaxed/simple;
	bh=mY7q5VTyLPkHI3vJSAnKqhazrM33FexsBCl0yHTPZnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K+q7thKl1AE1rIFrGidg1e7UTFwhgyGYqcGAJdiX11PLawHlLPtCZX/5NZAC61cjacVpt71vPj1eDluUofDr8l4y8ZE3scxQKi/9BlXuGmihCNP3AbC6WNy1FznbyPTQCBYuNgpkH2c7aGoSVgM/BQZEtCUAGEvGsjYh230ShOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1BK7n9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E27DAC116B1;
	Fri, 26 Apr 2024 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714138227;
	bh=mY7q5VTyLPkHI3vJSAnKqhazrM33FexsBCl0yHTPZnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T1BK7n9UZYKPfGGS6MthY16Qf5qtmJ8hNa3FSfFhAR2ZKLPvv85k9N0cR1TH0Be2w
	 p9+3axiTvrZ0JjHmtM+/asbZ3vKZ1Mz4mdR9s6SxQ8+L5H/5cSOJ2djEp3UOWDsb6P
	 5zpJFAeFuB/cXrhW2ZMvjqDyOgeAVl5IZbABAcx6E8CFRmbiro9pzT6yFz9EfKPzBZ
	 RgXs9fKVge0GCr/ELP2XRtN02b/Q81d75riryHy4Zct8SD5sskJEEFw+T890Rck/8y
	 sWD6SWtBiQbaWV4BA2aFw9NZ2q/56LfSbRr1g2RkB8VKMp3HNyZpfS0cLH1SOZyi2M
	 2Dqk6Ci3MWBxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1385C32761;
	Fri, 26 Apr 2024 13:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] igc: Add Tx hardware timestamp request for AF_XDP
 zero-copy packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171413822685.31434.16198399699579254737.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 13:30:26 +0000
References: <20240424210256.3440903-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240424210256.3440903-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, yoong.siang.song@intel.com,
 kurt@linutronix.de, richardcochran@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@google.com, vinicius.gomes@intel.com, florian.bezdeka@siemens.com,
 maciej.fijalkowski@intel.com, bpf@vger.kernel.org, xdp-hints@xdp-project.net,
 sasha.neftin@intel.com, magnus.karlsson@intel.com, jun.ann.lai@intel.com,
 naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 24 Apr 2024 14:02:54 -0700 you wrote:
> From: Song Yoong Siang <yoong.siang.song@intel.com>
> 
> This patch adds support to per-packet Tx hardware timestamp request to
> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
> user needs to enable Tx HW timestamp capability via igc_ioctl() with
> SIOCSHWTSTAMP cmd before sending xsk Tx hardware timestamp request.
> 
> [...]

Here is the summary with links:
  - [net-next] igc: Add Tx hardware timestamp request for AF_XDP zero-copy packet
    https://git.kernel.org/netdev/net-next/c/15fd021bc427

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



