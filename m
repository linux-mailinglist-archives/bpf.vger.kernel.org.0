Return-Path: <bpf+bounces-74198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D44C4CEC5
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 11:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C223428170
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAE3446B5;
	Tue, 11 Nov 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8uBI0sR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17B33290C;
	Tue, 11 Nov 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855236; cv=none; b=EserkqdjRooQRWfy2lTUCg5xwiFTzTiJKPbC7cuqDR+pYZI00MztusBcNNO5pVkVxaPxpTRGKda07OotZPKlGTcqjKsNiUV0aSNufx4WVGyseDdevFUodSi/jSN9FQFmZE1+UNxk6Gn5EMEEOIbmEq/VRoVL1vF85Go4fK9/2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855236; c=relaxed/simple;
	bh=8Pmmm1HuIYyEgfYT2NVPRIrLFXwTJVhD/jas7OG1qwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=krFX8A5U3PtDsi1LSiNDLMbzRakmZErO0xrOtKJJH/bMYxf1h2RRoi+4JnJN1UFneQAdgEAn0EG6FX+oqWTLfIgyppXX1zh+rS2BAJUenGkud4OayFRs/7bckcIYh3rOSxhaG1VxMC0+qhGU0GrAaAttv1jDTvB/w8aYGp/5lQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8uBI0sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BC9C19421;
	Tue, 11 Nov 2025 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762855236;
	bh=8Pmmm1HuIYyEgfYT2NVPRIrLFXwTJVhD/jas7OG1qwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O8uBI0sRdwz2EcbIg9krUrhg/awoRr8PpWfSWB4NmtCgllUTRJLU04tHKLIfOo6yz
	 +AGetSdvApsWNseHw8/yh5hb4ntULUh2+2negRrimsMKIZi08FnVpEK4qGodJliNt8
	 dlHOylAiU1UV/DYi5tRc9Hj9Gzg+qDt+hosC6RtaGMSecCIBMqiOZX1AAmRIcaGcDO
	 /vvjvspR7ISlV0wtD13AODdPuNqy33sViGvpP+xBdgeul73HrmFx6srBd6Mp+yO77v
	 7skp76bnamiXW4AtZayQIVRKth5ThJJX03Cxus9K7U2QH+oTCyAPB/NVKkFtHyeTca
	 yRx+F2+A7Nrbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9DB380CFEE;
	Tue, 11 Nov 2025 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] xsk: add indirect call for xsk_destruct_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176285520652.3362247.9933154098387419785.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 10:00:06 +0000
References: <20251031103328.95468-1-kerneljasonxing@gmail.com>
In-Reply-To: <20251031103328.95468-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com, aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 31 Oct 2025 18:33:28 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since Eric proposed an idea about adding indirect call wrappers for
> UDP and managed to see a huge improvement[1], the same situation can
> also be applied in xsk scenario.
> 
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> will be magnified. I applied this patch on top of batch xmit series[2],
> and was able to see <5% improvement from our internal application
> which is a little bit unstable though.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] xsk: add indirect call for xsk_destruct_skb
    https://git.kernel.org/netdev/net-next/c/8da7bea7db69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



