Return-Path: <bpf+bounces-57287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54C9AA7B4E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90294639F0
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B19202998;
	Fri,  2 May 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lts24kuA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40029408;
	Fri,  2 May 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746220799; cv=none; b=DjJl/PADZKIT8WmF71E7HhcoSKbm3cCVUhalVaOSoahdFBlMeaPI19iFs2Su9NTEzgRjZZMiOig46yu6Ld94j/N8WDxGSBXDHsa1nWrXuareDPAZtO6tiGknFa50GoVm3uF04uiZp4VQZ/DqogPUegJD+3agxkiiFq0eTHaq1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746220799; c=relaxed/simple;
	bh=vyEZ6nMZaoKb7M5ISRJVJUgjz/XqqOwtQKjmWCFXSSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CJ/t+pyv0EIiAt/69qvUwr1PRxDeIeZMFfPzkJhdHNkNKRLlUHYjhobx14H0ruGYdM/PBXeU74chPQBAwJBQ+lF6Ttp3qfDTDXqSvY2pE0tXyOAMe5s9V3gt3HHJSc5wQcH+I0m4Loplohhl54iK17a0sgqsnqaPXSmDCR/KM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lts24kuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C80C4CEE4;
	Fri,  2 May 2025 21:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746220799;
	bh=vyEZ6nMZaoKb7M5ISRJVJUgjz/XqqOwtQKjmWCFXSSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lts24kuAvDKGht6ZhvzQARcSbpLCvKVsNLH5cH7k8EHPEcUW55FouyU/9v2DyJ2Pq
	 D6jSjXq3Tc13OdkYkdWdG0rW6j7jbzdcvGJ5/VukN95hAxLO6/Ya3Eor0KHQ/zZtfQ
	 nCGn38AbpLSCBYaW4Fw4LArZItEoxbqnL+8/5zTKtX8NsbehJ3U67h29OK0wbIUXZP
	 nbqvXsUunV5EIU4tKuU2i6nUDkVJHXWCOgoyucZGzj78KfrycRDRdOLUGgFLK4ADWB
	 je5UlCdlg3BBCnU0CM9z1+g8n+COPg0S8G2QIC/CmQ3s5zsJ0uIerUpsh3nYCG6eQN
	 DFw6mPYUlIZ3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE471380DBE9;
	Fri,  2 May 2025 21:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 bpf-next 0/7] bpf: udp: Exactly-once socket iteration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174622083850.3731637.6479069584548815355.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 21:20:38 +0000
References: <20250502161528.264630-1-jordan@jrife.io>
In-Reply-To: <20250502161528.264630-1-jordan@jrife.io>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, aditi.ghag@isovalent.com,
 daniel@iogearbox.net, martin.lau@linux.dev, willemdebruijn.kernel@gmail.com,
 kuniyu@amazon.com, alexei.starovoitov@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  2 May 2025 09:15:19 -0700 you wrote:
> Both UDP and TCP socket iterators use iter->offset to track progress
> through a bucket, which is a measure of the number of matching sockets
> from the current bucket that have been seen or processed by the
> iterator. On subsequent iterations, if the current bucket has
> unprocessed items, we skip at least iter->offset matching items in the
> bucket before adding any remaining items to the next batch. However,
> iter->offset isn't always an accurate measure of "things already seen"
> when the underlying bucket changes between reads which can lead to
> repeated or skipped sockets. Instead, this series remembers the cookies
> of the sockets we haven't seen yet in the current bucket and resumes
> from the first cookie in that list that we can find on the next
> iteration. This series focuses on UDP socket iterators, but a later
> series will apply a similar approach to TCP socket iterators.
> 
> [...]

Here is the summary with links:
  - [v7,bpf-next,1/7] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
    (no matching commit)
  - [v7,bpf-next,2/7] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
    https://git.kernel.org/bpf/bpf-next/c/66d454e99d71
  - [v7,bpf-next,3/7] bpf: udp: Get rid of st_bucket_done
    https://git.kernel.org/bpf/bpf-next/c/3fae8959cda5
  - [v7,bpf-next,4/7] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
    (no matching commit)
  - [v7,bpf-next,5/7] bpf: udp: Avoid socket skips and repeats during iteration
    (no matching commit)
  - [v7,bpf-next,6/7] selftests/bpf: Return socket cookies from sock_iter_batch progs
    https://git.kernel.org/bpf/bpf-next/c/4a0614e18c2d
  - [v7,bpf-next,7/7] selftests/bpf: Add tests for bucket resume logic in UDP socket iterators
    https://git.kernel.org/bpf/bpf-next/c/c58dcc1dbe30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



