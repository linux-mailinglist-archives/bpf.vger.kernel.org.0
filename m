Return-Path: <bpf+bounces-20253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C783B0F2
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733BE2849D5
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05212AAF0;
	Wed, 24 Jan 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzB4zaVR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BE12AACA
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120427; cv=none; b=KNJ4D8BWRTw0XU/MpYdMi72fFwbve94ez/8ZUwrExQWlDpubt4iSBNaHRg3eMI30QOkldnYrQxNczBrMbdkoXmErtbz0iuGWQmnG/YDuqdTciDnX+yGnSWNqo89U3dPuxGMtQQqjMTXHuwEgYsFHTS4CuilTZvWBqdmHzgcSMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120427; c=relaxed/simple;
	bh=XGeKIkR2hMJikd4UaTEWNbAvMIyZHDPjxWpVUwPn8LI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oBNg1XBdJ18FU7Gt+Oig8lYcMza3YscK46v47G8PpXaLVSqvAhNzWMBsWeCIYOpltpUXzndxs6u7D9KCcHboVp1vAr2O/b/PWKdA5voXb46/OAMDXrtxM6lgmxq/rNHr0pa6cEEa+obZC+FdPZzH0ksZolu5DKOsWJUZbghpuUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzB4zaVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10508C43394;
	Wed, 24 Jan 2024 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706120427;
	bh=XGeKIkR2hMJikd4UaTEWNbAvMIyZHDPjxWpVUwPn8LI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kzB4zaVRP/EedeTk2e/UjHwm3fULWR/V0/TX1kxq6qW6OFepn/OdSJ7i6lMDY1pZx
	 hxjvLzGbMxs9C1l+3Vfdsyg5xi0aKlxU/qYVpT0+rXUSx+Kr8yFo05wDs7ut5ZhDXa
	 2qPM304BlWZ+z8K3o4utZApu72ZFcSxAtQaFWlZqpOBdJQjsLA4QffCBq8Q/kgJ2Mx
	 NEEppoVRRwfC2Eq569ttLaBUR3WL4nHeoWzK8F5ci4U+GV5s/hVmDlod/OYQzCqGyb
	 C3Plw92eOr7fs9/+LMEiqt6Oryh14j3HgAqkiAzxtooYM7iiXtcCmuKLGwtkcFlq+J
	 XZiT7vVTgtN8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE140D8C962;
	Wed, 24 Jan 2024 18:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] selftests/bpf: Fix the flaky
 tc_redirect_dtime test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170612042697.22864.4085418184966669443.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 18:20:26 +0000
References: <20240120060518.3604920-1-martin.lau@linux.dev>
In-Reply-To: <20240120060518.3604920-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 19 Jan 2024 22:05:17 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> BPF CI has been reporting the tc_redirect_dtime test failing
> from time to time:
> 
> test_inet_dtime:PASS:setns src 0 nsec
> (network_helpers.c:253: errno: No route to host) Failed to connect to server
> close_netns:PASS:setns 0 nsec
> test_inet_dtime:FAIL:connect_to_fd unexpected connect_to_fd: actual -1 < expected 0
> test_tcp_clear_dtime:PASS:tcp ip6 clear dtime ingress_fwdns_p100 0 nsec
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] selftests/bpf: Fix the flaky tc_redirect_dtime test
    https://git.kernel.org/bpf/bpf-next/c/177f1d083a19
  - [v2,bpf-next,2/2] selftests/bpf: Wait for the netstamp_needed_key static key to be turned on
    https://git.kernel.org/bpf/bpf-next/c/ce6f6cffaeaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



