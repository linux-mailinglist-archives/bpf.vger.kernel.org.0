Return-Path: <bpf+bounces-33628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29371923F30
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D996728AF08
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD421B582C;
	Tue,  2 Jul 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9fqnT3J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6B14F135;
	Tue,  2 Jul 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927634; cv=none; b=e12Ev2F2FV2xd2tSYtgTD7a/SaH8rKgPXVn2mUtB0dVQLjY3WpB7W1rYqIW+MSGLhemS65UC5PHMTuxLGFamwL1iTtVs/XzYf0KhLFjd0+cTCn99IXiDHZHH0npCtPxcJuIbRUk6GW22Uf1r55sCd7YT6s2q2R9lyWNaEiHjijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927634; c=relaxed/simple;
	bh=+W4yKMpVM0FnCCTlzkUBo33I+67EW0C3h2+ocDgYWbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A/0LJji7enbZTMDjLuVotvaEKoEqK68fmqg0PnP2ya6jNguGgMOVYwWTyMGewjbzTqomjTD5W1OLALd2EutsABRxkTuhG7QzWsNPy3mRMlvDRsNw/kuLUVF1B6oD7Y4Avn4J4Y576t7QjrqDM3aZf90gPJjy4J84Y59zoyz9HsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9fqnT3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 987EFC4AF16;
	Tue,  2 Jul 2024 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927633;
	bh=+W4yKMpVM0FnCCTlzkUBo33I+67EW0C3h2+ocDgYWbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b9fqnT3JH22j4pp4VG0lRcS2AA6gOyCz9MXD97EiVK9d/RmQWpV+ZywZRDLGr50QX
	 wDTRT0PciADFMMl+3194fMOnN8cq5X7b+LYLrCKqbaltLBnSQo3eDMDAFnjdbPTBhp
	 HsNbQISM/A0SOQ4KziBeOfFk55CDtdfTbwCmMw7MXq6Yt8q5/qVj5ARoaBw2fU9ZHF
	 pzUi7XzNOrofDlp5TnHPzALRa4wy2moIjGpqfnmUlstifjQdWXYNa0QhfmdIolwSC/
	 7FONQ+xi0/mlTa9J557xvS7WrQekPuLgDvhF+5TgtyGujXg7EpqYmEiJCRs43QlVEo
	 nnaB1YVFxuZmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83B8DD2D0E3;
	Tue,  2 Jul 2024 13:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: bpf_net_context cleanups.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171992763353.28501.245433484118524334.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 13:40:33 +0000
References: <20240628103020.1766241-1-bigeasy@linutronix.de>
In-Reply-To: <20240628103020.1766241-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, bjorn@kernel.org,
 davem@davemloft.net, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, kuba@kernel.org,
 hawk@kernel.org, jolsa@kernel.org, john.fastabend@gmail.com,
 jonathan.lemon@gmail.com, kpsingh@kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, sdf@fomichev.me, tglx@linutronix.de, yonghong.song@linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Jun 2024 12:18:53 +0200 you wrote:
> Hi,
> 
> a small series with bpf_net_context cleanups/ improvements.
> Jakub asked for #1 and #2 and while looking around I made #3.
> 
> Sebastian

Here is the summary with links:
  - [net-next,1/3] net: Remove task_struct::bpf_net_context init on fork.
    https://git.kernel.org/netdev/net-next/c/2896624be30b
  - [net-next,2/3] net: Optimize xdp_do_flush() with bpf_net_context infos.
    https://git.kernel.org/netdev/net-next/c/d839a73179ae
  - [net-next,3/3] net: Move flush list retrieval to where it is used.
    https://git.kernel.org/netdev/net-next/c/e3d69f585d65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



