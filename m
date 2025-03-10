Return-Path: <bpf+bounces-53762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0369DA5A4CD
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 21:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38ABA174D6B
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F631E0DFE;
	Mon, 10 Mar 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl6O99sA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D21DF75D;
	Mon, 10 Mar 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638008; cv=none; b=T0B3t4p4vP77hq4t25ew0anpdnCR41VCn4p3DwcPJ+jOKTIH2QiEPWm/sOCdU8WJy99plaXfLU1WFzVjiVnYJ87jBVVs/89bKGeSZU5HOJ6w9chKeTeDxnXZd1H35n5wBHcY1kih5M8y1WCcMfZ0bzy55aJknknMIpD7HjBRN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638008; c=relaxed/simple;
	bh=HINu/EnpUGJfIOXFDKpL8KvgzfAHGlOd6d1ShDILpy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WtvSn+KLHISF2f30GCH883d9GwlMK+HRiOIuDYDvIuIjfARHj1wXq1WieyMVHaBUhodSW1Po8W2LlVXlDorHeGqwfAVwnLxakdTh5fiUN1TWLrpdEGXhxZoCXTaJ6ycqVpW3ELA0Te7NVlCK6ioKMl3JSkiRejBvE3nSMgbiB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl6O99sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0264AC4CEEF;
	Mon, 10 Mar 2025 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638008;
	bh=HINu/EnpUGJfIOXFDKpL8KvgzfAHGlOd6d1ShDILpy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rl6O99sAKJTnVYGY+bajYzHLXWp0yGVmfGOe6k8HtKANa1ZTvMMH36O3DaJkFJxLO
	 hmuegG/s1zZkR/f1qF1QWAUAKdpkw2MxyVWYk7FVOyQLVpdM6p0Xhg349ZJDXemyK1
	 VrPcXlfmjM48YJ5IroSHSCX3fEbUTGEdLToGrnIcOQvWatmxMc0QNR7Yr1CnmssN9W
	 LhvcdsDG6KxLi/PFMKS2xaxZbRhAlGNJmXyQ4atNjO4qnN4hmJ88kcF1w5UMairDDb
	 rNWv3hUc19tvygv3e2eJ/pckktmYdNjZAHgZ2xkqbmpwPBlEmW/ViSr2ShZKg5vujs
	 qoNFfAGYO1Amg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E50380DBDB;
	Mon, 10 Mar 2025 20:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/4] virtio-net: Link queues to NAPIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163804173.3681464.7169835373797288242.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:20:41 +0000
References: <20250307011215.266806-1-jdamato@fastly.com>
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
 gerhard@engleder-embedded.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, kuba@kernel.org, mst@redhat.com,
 leiyang@redhat.com, ast@kernel.org, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, eperezma@redhat.com, hawk@kernel.org,
 john.fastabend@gmail.com, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 01:12:08 +0000 you wrote:
> Greetings:
> 
> Welcome to v6. Only patch updated is patch 3. See changelog below.
> 
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/4] virtio-net: Refactor napi_enable paths
    https://git.kernel.org/netdev/net-next/c/2af5adf962d4
  - [net-next,v6,2/4] virtio-net: Refactor napi_disable paths
    https://git.kernel.org/netdev/net-next/c/986a93045183
  - [net-next,v6,3/4] virtio-net: Map NAPIs to queues
    https://git.kernel.org/netdev/net-next/c/e7231f49d526
  - [net-next,v6,4/4] virtio_net: Use persistent NAPI config
    https://git.kernel.org/netdev/net-next/c/d5d715207e29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



