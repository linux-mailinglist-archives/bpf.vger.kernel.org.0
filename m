Return-Path: <bpf+bounces-35416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B093A7A5
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 21:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8A51C20F35
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 19:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C16913E03A;
	Tue, 23 Jul 2024 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKfZGz86"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19013C3F5
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762432; cv=none; b=F9u+dzEpW4Rw/nkD3QWyy3rNO1gxIZzGg9DYQKvmYVs8VT4PpmE07F4VRjVjbhFy54X+0UTU/x67H5SlPasMfIrzyN2WovE6r3itvlVWE68OwaDucz4ZvTO3DiOwtHWYgEPvesYim4wzxoXnCJAhnng5XJNyLDfSYZxbI29bDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762432; c=relaxed/simple;
	bh=+1f8TIAAF2Sp6GQFy+M6VCJ2V53gpjJsWJ1hFiy+ag8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fOkIAIqFj3groHOw36LN0blIJkK6bEj48pdpxbjEuwUbvmhtTHxkEbZTA1cXrv+zeVV62Vyf/Vg116Z6HifMKUiJY4dAZyi4DRDBqwetx1qCWZtDUlJnsHwf+HYZ7Ab50K/DyB87TZ2Lc12TEDwwxFOV5TPI/NiaSprjHStTO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKfZGz86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C76BC4AF0E;
	Tue, 23 Jul 2024 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721762431;
	bh=+1f8TIAAF2Sp6GQFy+M6VCJ2V53gpjJsWJ1hFiy+ag8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RKfZGz86HiJhJ0SPTSHWYffvDJ07SjpbzUKGIKfXtrwUwnBs+YjGZ4H3BSd8Jtu4U
	 Z7+aWqTiItIen0IMjbPQCSaBk6DB0B0Ov7gj+pPKXF20Px1JYnPN03FirYHleqrk1W
	 nSBHt7R0usInXzhxc+Q/SHc3JWalkT8KBB62Kagg7/+gP6TueN5n0fYyIa82GOX6XM
	 JAKK2HegJI6DYWmbcntOuVVtGYN4Qx7yulZ/uqKpYF/rYdZDfzErlfHqknEd0w3GTQ
	 ghgCNGoJ6PPRAfjWU0nmhLoPIvEyte4vTIZyjeLIN8OsCzMnYIlWFg+mz8PQSlGz4c
	 cVY+5RdOoaupQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 894F1C43443;
	Tue, 23 Jul 2024 19:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add a test for mmap-able map in map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172176243155.21287.5775280753843803571.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 19:20:31 +0000
References: <20240723051455.1589192-1-song@kernel.org>
In-Reply-To: <20240723051455.1589192-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 22 Jul 2024 22:14:55 -0700 you wrote:
> Regular BPF hash map is not mmap-able from user space. However, map-in-map
> with outer map of type BPF_MAP_TYPE_HASH_OF_MAPS and mmap-able array as
> inner map can perform similar operations as a mmap-able hash map. This
> can be used by applications that benefit from fast accesses to some local
> data.
> 
> Add a selftest to show this use case.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add a test for mmap-able map in map
    https://git.kernel.org/bpf/bpf-next/c/541b135010ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



