Return-Path: <bpf+bounces-68506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D067B59919
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3CE46457F
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F858301463;
	Tue, 16 Sep 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/V9fSL+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFD2036E9;
	Tue, 16 Sep 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031806; cv=none; b=mQqoPwOdal4t0UIwIswh5VeKoqNzdRWi2VD04FcjCeorAfNahsXs7/7Vg/vfa9vkRsHOgkYnzCeu9HP5gGdKAewkkIXQhnJg7M0qsberv4F8PeeQ5yR+o02TtuvKVdkCs/37W7O2LI290/f1J2mgkRrty2b/FhoR3KI6aeQ9HPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031806; c=relaxed/simple;
	bh=Yd4uBnavbG/ehrEzDObTonIzSgsm+BbE9ElPe/yFbtI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FzB07HiNzn+yjWecbGs8eQS96Ar5d/wfnsCeHhl9StyRtotnyFjXiToakkDqhCPrtC82t0XkFUdMMixYLdtAD6Tm0uAnx8WkXueYyX1usuJaN5jSyOUqrSdYv0XcSXiGGmK0hJI8ew5gPFF6SIdTup4kQax4MZxuotds5cVXFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/V9fSL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9C6C4CEEB;
	Tue, 16 Sep 2025 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758031805;
	bh=Yd4uBnavbG/ehrEzDObTonIzSgsm+BbE9ElPe/yFbtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q/V9fSL+J6kyi+0qEeDL/4BbaOAgB53CBWyR4bPNpxA9Iwz3LtXYDJwDoV75hIeec
	 g1QciyOmzia44a02Y5aVJPPAF0YP4WjMLCEAooev74sVdn1ppkxktBi82c1ZAtrNr1
	 nrD08pa0VzWFYCur+pTx7TmKzqfy3h3xjSqbn56dSatASGi9bMWNEL7O/B/IOOsyW6
	 HvaFTXIWxN7JNeHzWNKURv1kpH4oWF5dskLONZyor4K8jCBeO1dH8+eJ28bV2kzFbs
	 CiEvO/QAA1j8lO4msxkHVFOxgil74uk5m0xG6cjoCiBYKWroG1kql2yhevFpd/VdQ+
	 0aFgMp1e4VZQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7039D0C1A;
	Tue, 16 Sep 2025 14:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] MAINTAINERS: delete inactive maintainers from AF_XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175803180676.1137669.6441007359967878719.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 14:10:06 +0000
References: <20250915120148.2922-1-magnus.karlsson@gmail.com>
In-Reply-To: <20250915120148.2922-1-magnus.karlsson@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 bpf@vger.kernel.org, jonathan.lemon@gmail.com, sdf@fomichev.me,
 andrii@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 15 Sep 2025 14:01:44 +0200 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Delete Björn Töpel and Jonathan Lemon as maintainer and reviewer,
> respectively, as they have not been contributing towards AF_XDP for
> several years. I have spoken to Björn and he is ok with his removal.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> [...]

Here is the summary with links:
  - [bpf] MAINTAINERS: delete inactive maintainers from AF_XDP
    https://git.kernel.org/bpf/bpf/c/f36caa7c14f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



