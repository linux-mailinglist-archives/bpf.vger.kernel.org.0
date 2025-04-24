Return-Path: <bpf+bounces-56561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BB4A99C8A
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 02:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979D17AC3CE
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 00:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786FF625;
	Thu, 24 Apr 2025 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf/gaptA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031C163
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453391; cv=none; b=rcaTvBPFmvH2BlezGyTvm9lVtBI5wyZbcGAx8gnM2iQmOi1Gpu3zjxBKfM637SK/EMyhUtchPYpxCI582xPxA19F4PosPSd7EmDoh4vPvfVvJsY2tDyC3RQdEhXR0sxk96kX0qggqP18MfKnCxiHzldULtHniYbWAk0oDd2/ub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453391; c=relaxed/simple;
	bh=2AU2Xft7lyv80jpYAC5Q6t5+VYMGCjHhSEt7qXHDBo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AsEy1+opzYyxnAJ5OsJ24tqX7IY1IYkt+KzMuyT4j4SRU/vrW7xJ78ot3TSOgvBrk5V03XuhsriAxUmG3PfWd86WIiUlkAP1Kj6UYrbQs4EQ55UAbUJsojkgBLqIzp0jXpfMxrp51xqQvZ9VBWri27Yx5bU7jjwfqfLdRdLxs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf/gaptA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65877C4CEE2;
	Thu, 24 Apr 2025 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745453390;
	bh=2AU2Xft7lyv80jpYAC5Q6t5+VYMGCjHhSEt7qXHDBo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vf/gaptAV5IRS4tVEur7GrF7R8OQCG11QUtfEkHF0ekWgmwU1SSzWNWg/RYmrkErG
	 ApKn+F4H5jiqg4wdvq7jFf/QO+lgsjxDYr0MOHktMp/YMWkv3soBaDSRmBGx/HGbyT
	 kgikrAo7d0IfFBG4QMKBucYIJOKKHbYsNiJOZYirtQuwXVJPR+rBWR+jBhKFjntgfl
	 dhlr77gjqGh/1RVTBAATVVJmvxbMmXaGIzRm7vnxvJP8nZZopiGlM87UtRPVmMREx6
	 A6YHygKdHCr04CpJJ/nWkfLuhT/JZBdUzbj7O2Dto1NY1e2iEwgAJrJIXTmx2ctqws
	 sGdaT00hXee4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3B380CED9;
	Thu, 24 Apr 2025 00:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Set MACs during veth creation in tc_redirect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545342902.2807189.3308637278338677255.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 00:10:29 +0000
References: <20250416124845.584362-1-iii@linux.ibm.com>
In-Reply-To: <20250416124845.584362-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 16 Apr 2025 14:47:58 +0200 you wrote:
> tc_redirect/tc_redirect_dtime fails intermittently on some systems
> with:
> 
>    (network_helpers.c:303: errno: Operation now in progress) Failed to connect to server
> 
> The problem is that on these systems systemd-networkd and systemd-udevd
> are installed in the default configuration, which includes:
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Set MACs during veth creation in tc_redirect
    https://git.kernel.org/bpf/bpf-next/c/60400cd2b9be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



