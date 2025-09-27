Return-Path: <bpf+bounces-69903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2C7BA5FC3
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B507A992D
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F3B29BDA6;
	Sat, 27 Sep 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn1J8mx+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5591E231E
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758979812; cv=none; b=SxYi1S9lVWr0tma8GY5WPEGeW0WDXoqWWYvAO5KFqldZcsOfWhMH33femYL8ypIoo6dNiFgdTMyuvemo+6W7KFD54wWF63f8rrKswTcF5BLNd1GaijtFaAOTw3jgo6qPx7A16MHl/69XT+ySz7//BN5Pnakz+pKAJCljaOhv1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758979812; c=relaxed/simple;
	bh=ns58ObY1LMJfhdB2g3DWWVBEq/OheQBrD9rwZ9V5toc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DDcZHdcy5eSwaDLBI8d3O346smMolv88xcyAUg8VUjFRTF+58R/yLkqqhM5CYjHnSJb0RLkN10kmbTk5qFLakqcpS90V+0Q24lqO73TjMw3/05HgnqBPlFdkkBQN6yzfdiAzuKOvaysrUMmPTQ8+ktXQ3dqy0sE539GmJVRUxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn1J8mx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658BFC4CEE7;
	Sat, 27 Sep 2025 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758979812;
	bh=ns58ObY1LMJfhdB2g3DWWVBEq/OheQBrD9rwZ9V5toc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pn1J8mx+YcCrVvkM6nUyw7/0XL6wyd9mkJPQrbU8HpjnaTjQppNUkqaDH+HJZAR03
	 Jmsf5Q7IzAO9Wehxe3lK3EN1L/lLOQg2zYRMyIEGWmjxhJE/S9W8V/4fSIH3I03Yz3
	 oiKV9MKBGV/o9iqNW/syOATSM1iheEi0KFcElH+coPQpn6QAuGtGWGYoHYijvwtJYY
	 IKptGQAgm8RgGim/uDIaFzmEFGCyNTYGYP6zqzdDYBRM0R0supiCoFg2hK6zxxoH7v
	 iSeDGrzrGXDVzClOLcniyAU3IVOy8xUD5o1/9E+d0qXQdCuSv48mT+daJNtYYImRzk
	 bwH8jPQGOk+nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7270439D0C3F;
	Sat, 27 Sep 2025 13:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Enforce expected_attach_type for
 tailcall compatibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175897980726.251224.13645077575301930117.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 13:30:07 +0000
References: <20250926171201.188490-1-daniel@iogearbox.net>
In-Reply-To: <20250926171201.188490-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, dddddd@hust.edu.cn, M202472210@hust.edu.cn,
 dzm91@hust.edu.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 26 Sep 2025 19:12:00 +0200 you wrote:
> Yinhao et al. recently reported:
> 
>   Our fuzzer tool discovered an uninitialized pointer issue in the
>   bpf_prog_test_run_xdp() function within the Linux kernel's BPF subsystem.
>   This leads to a NULL pointer dereference when a BPF program attempts to
>   deference the txq member of struct xdp_buff object.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Enforce expected_attach_type for tailcall compatibility
    https://git.kernel.org/bpf/bpf-next/c/4540aed51b12
  - [bpf-next,v2,2/2] selftests/bpf: Add test case for different expected_attach_type
    https://git.kernel.org/bpf/bpf-next/c/0e8e60e86cf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



