Return-Path: <bpf+bounces-41942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E187D99DBFC
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BDC1C21ADD
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038A15B96E;
	Tue, 15 Oct 2024 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3uYrzGH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BB41C63;
	Tue, 15 Oct 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957625; cv=none; b=VkHEp9DubfyJrYwIHid589Wc6yQFyB05T36lLt+uosDCufYqXuLSNKjGoy2jyKwjpsRLzaQzCOC3k8mFb5V9u1U+oUBkXrqcA+jd9pjMN6TjHYagzpT72FWDLaIiNNakf8A5jkG4+LClb2X+SQJgxF4TNyiAPmfB6tpEqq5i8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957625; c=relaxed/simple;
	bh=rCVAZHtuiawarDEZZotMDsxYdy6ZRqoS28eKJ5t3cAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tPx4RmKfLEMPi3b52JtIc0KZmspq1SlK0FkVUdTGHMeAUNB2YwbHAyBxrqWWbl8sbU5bnVg4OJjULincVHTHepBX1p1l5O41s0/PXxA7eiOtyG0zNuuJc0CJOqjCOdeiHPrg/CcaVB3sE8YuYV1oywC9ue+OD248aZ1LWUv8Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3uYrzGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF9C4CEC3;
	Tue, 15 Oct 2024 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728957625;
	bh=rCVAZHtuiawarDEZZotMDsxYdy6ZRqoS28eKJ5t3cAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W3uYrzGHnsJcub+zJSSVLMQf4Bg9Z6RKWUSVhkCGsZIE6MijCPdl9tgIlV9uvgMlI
	 q7ciITmrBaJfjz6QO114XQn4bC05PB+EQQVVcpdD1VGmZs7lgrKLs/5TeDmLJPSq9y
	 pwGBId4yaUsmYwuz7+k/ucnQwgrUMv9mtNoqRcA8nl9boSZYMwBC2H89NNzHAEOiQ5
	 Nq1YijTReMV/NTvvhOqzY7AChGzhBWXt+K95HXm07KkLxIrElyNQqp+SlD3E5l2DVe
	 DaTJ+97L7C6G4wSZLxe3ZQ2X0+dmJep9WfvSUJRaijbOZdbhHKTo6Rh9QlRoagAFW1
	 MBzMlxy0i26dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC63822E4C;
	Tue, 15 Oct 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895763026.696768.9791144201638057630.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 02:00:30 +0000
References: <20241010232505.1339892-1-namhyung@kernel.org>
In-Reply-To: <20241010232505.1339892-1-namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, akpm@linux-foundation.org,
 cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, acme@kernel.org, kees@kernel.org,
 paulmck@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 10 Oct 2024 16:25:02 -0700 you wrote:
> Hello,
> 
> I'm proposing a new iterator and a kfunc for the slab memory allocator
> to get information of each kmem_cache like in /proc/slabinfo or
> /sys/kernel/slab in more flexible way.
> 
> v5 changes)
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/3] bpf: Add kmem_cache iterator
    https://git.kernel.org/bpf/bpf-next/c/4971266e1595
  - [v5,bpf-next,2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
    https://git.kernel.org/bpf/bpf-next/c/04b069ff0181
  - [v5,bpf-next,3/3] selftests/bpf: Add a test for kmem_cache_iter
    https://git.kernel.org/bpf/bpf-next/c/73bb7e74d181

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



