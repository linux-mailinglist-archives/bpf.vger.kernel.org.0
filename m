Return-Path: <bpf+bounces-53802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E3A5BDA1
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 11:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F56C175AB7
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9304223099C;
	Tue, 11 Mar 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi1bseSQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7D22577E;
	Tue, 11 Mar 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688398; cv=none; b=DOQ372uIyewxdVvYVODfhxn7zqmTnyEry9opB2JYEgOCG/MZKhhHjBssmmMH26B/D106KGyTjOUT4R1rlJPAFawoff7Ghlpl7ppfOP2qSDdWF/1OpdkPsJur3lZbjsxPETboUQKAfJXkG4N1f8Pu3gdgXZhLGC2EAfFsK6+UqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688398; c=relaxed/simple;
	bh=EvjQeYuInX+TO7B6vyrVptF7MFFu939ztQrKf5QJrgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UgybO/gjmHJ1COO1ldWGFLvCTOMf6F8eC02n5J1O2qqmBtDzlThdgVaStVt7klWHGnVwJaHrQ4mVwd4psHRmA/D4pc/uzjieGZZWg6Q+BfSMBpg3nDhxNM9vesXTcpe2N/D/HEkeq31CnsmFy7oZbAAq7YOlxdaScDPQWFmUPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi1bseSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D545BC4CEE9;
	Tue, 11 Mar 2025 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741688397;
	bh=EvjQeYuInX+TO7B6vyrVptF7MFFu939ztQrKf5QJrgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vi1bseSQ8G2EGOlZ95y5kbaHq8dDidxBzU6HSdIw6TIGfuGjgjdj5Ft/CAG/RNjrZ
	 Yi/MqGhoLViq5yUZsOgGeS6rr7rYi+CN/wir9S0YN4w8O+E1Ro5EWJnKQ5s04Uh3XL
	 OL1zr3ck5axg8Te1gtgznCM0jelyecZxHt3G/ts05CQ0xN1xX3wf43nFZKIkQHHO0w
	 CTZiINgRJcETuGWa3odxwJu7X51iKkGlmdlDtlqyaFcigzNcH/0Xv5JkGTnsqvIoXC
	 fawHrgCaCMpD8QdHbjA/A9XwMQ/13ecySsyEsWh3RHGXcvk3fZCvGWwe3uOrIcC4vf
	 qOwXjt7R3aigQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3423E380AC1C;
	Tue, 11 Mar 2025 10:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: ti: icssg-prueth: Add native mode XDP
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174168843201.3885087.2899206416205542663.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 10:20:32 +0000
References: <20250305101422.1908370-1-m-malladi@ti.com>
In-Reply-To: <20250305101422.1908370-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 matthias.schiffer@ew.tq-group.com, krzysztof.kozlowski@linaro.org,
 dan.carpenter@linaro.org, diogo.ivo@siemens.com, s.hauer@pengutronix.de,
 glaroque@baylibre.com, schnelle@linux.ibm.com, arnd@kernel.org,
 john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, srk@ti.com, vigneshr@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 5 Mar 2025 15:44:19 +0530 you wrote:
> This series adds native XDP support using page_pool.
> XDP zero copy support is not included in this patch series.
> 
> Patch 1/3: Replaces skb with page pool for Rx buffer allocation
> Patch 2/3: Adds prueth_swdata struct for SWDATA for all swdata cases
> Patch 3/3: Introduces native mode XDP support
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net: ti: icssg-prueth: Use page_pool API for RX buffer allocation
    https://git.kernel.org/netdev/net-next/c/46eeb90f03e0
  - [net-next,v4,2/3] net: ti: icssg-prueth: introduce and use prueth_swdata struct for SWDATA
    https://git.kernel.org/netdev/net-next/c/73f7f1311866
  - [net-next,v4,3/3] net: ti: icssg-prueth: Add XDP support
    https://git.kernel.org/netdev/net-next/c/62aa3246f462

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



