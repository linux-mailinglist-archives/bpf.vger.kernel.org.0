Return-Path: <bpf+bounces-67530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8ADB44CC0
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 06:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F391C27290
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 04:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1364261B91;
	Fri,  5 Sep 2025 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP+QEq1r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB528E0F;
	Fri,  5 Sep 2025 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047204; cv=none; b=cdDXNhfIDpWXOedeEQFdFUrSmQ+QSD9/WOlD81QGL7SJRgneIPzsu27Z4VBXMPIza4yB6wDaI2HjulP0ZoLCMHWK024sPZm4ZNIt2FszxCMRTLwSw6jUKQLH5Sr4j+/wpcBAZQ99l7hxqy3OyPnGPphgp9PF2g+m/s6YGVBlQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047204; c=relaxed/simple;
	bh=ahWTKTjoAzuZYQKntEwUqtEmeCcmN72r3D1Ewzt4myo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ExMqQlHHFzl1/WKdSE1ZJv0AEDLzCFRxNkPobopbaAv+hOiF9jCQACzeCmuEydS0tMM6gPy8tbTjT2RD5AmhRih1YTAO9LBwI93uSqdcteMXhbx4YT+yrzg16tPyuKUnPyNGhC2KRSE89g0NFjdR6RmW9BvT2KpXEHxG4ixr8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP+QEq1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF62C4CEF1;
	Fri,  5 Sep 2025 04:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757047202;
	bh=ahWTKTjoAzuZYQKntEwUqtEmeCcmN72r3D1Ewzt4myo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JP+QEq1rVvbL9A2at6o0ayHXorT+3gfSHFohTuWV2knyx2rPIAyqLYza5HjPKqQof
	 p6E+fkGoXj6wBhiliAkgO3UKHJ4iBf6gl/6lc7sWuY4BZlNWz67mPmClhKlvfJlrxs
	 DDobqYbF6u2T6LY12UMYvH1FPrJoQBHMOiaHqTFOA0mS5bTrshmNkNV51UcOJDDZdA
	 BCBPqixfGUIUz7q6J8pHs6g01utSbUHyU9g/PSOwjnKTjYwCuPEVH/3FaCFsGTMRae
	 iQ23Abv/+tBYnivcTCxENwmxHhXfG3vXU4dr6hmtbYXTLjbf5QXNK2YPjfO61nafrj
	 xw9MP0GTWHiZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA1383BF6E;
	Fri,  5 Sep 2025 04:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Return an error pointer for skb metadata
 when CONFIG_NET=n
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175704720726.2040233.14416715550845676114.git-patchwork-notify@kernel.org>
Date: Fri, 05 Sep 2025 04:40:07 +0000
References: <20250901-dynptr-skb-meta-no-net-v2-1-ce607fcb6091@cloudflare.com>
In-Reply-To: 
 <20250901-dynptr-skb-meta-no-net-v2-1-ce607fcb6091@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@cloudflare.com,
 netdev@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 01 Sep 2025 15:27:43 +0200 you wrote:
> Kernel Test Robot reported a compiler warning - a null pointer may be
> passed to memmove in __bpf_dynptr_{read,write} when building without
> networking support.
> 
> The warning is correct from a static analysis standpoint, but not actually
> reachable. Without CONFIG_NET, creating dynptrs to skb metadata is
> impossible since the constructor kfunc is missing.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Return an error pointer for skb metadata when CONFIG_NET=n
    https://git.kernel.org/bpf/bpf-next/c/54728bd535fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



