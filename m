Return-Path: <bpf+bounces-60117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79227AD2A9C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D62B3ADF7C
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A5622DFAC;
	Mon,  9 Jun 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsjoPpM1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2B190067
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749512405; cv=none; b=eSYHio7IV2K06jQPYr9+Ru8cQeMKOr2SRb58kYdoICwmu+y08c2hpM796citaYhezc/DRrQhJDCbu+mY7WRiVO2a1ieVSIGviQeRcbJ7mb0gHmL5gfPaaTnhJU7weryqrd26/sMcj4vdvv7pG8bK0TXcwAIoiLVJA+QDch7LDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749512405; c=relaxed/simple;
	bh=pAmJkBd9iwqtpdMGgeLr4KjKW5fN258zv6Fv39DnV/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k38nbeipBMPvpjxsIs/M/5IngzL2BE0ad4LFWOej+jJt98y9baW2EydS8E90NjsSTmzN/4A2CiNTjJav9wGd+jmgovY+Yq8lLo/+yYe9Q/1vEmicTJTe0bJBZzr3aOj1vpx6wiqB6hrfjcXo1uvw16dRscZbOAzVcA996JqJGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsjoPpM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A186C4CEEB;
	Mon,  9 Jun 2025 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749512405;
	bh=pAmJkBd9iwqtpdMGgeLr4KjKW5fN258zv6Fv39DnV/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VsjoPpM1Y/DvN4D7E08gry+KEXv+l6fi0U7WgyuehvLK0iAyJnT1NBt0k6/tn7w7w
	 oZ1a6A2xqefemAWNkhJzsgVfWwgdsxE+7+SfHOkWI2kHWlZlFzpcUtVlCZtE3EQBhY
	 pq0qgIWjZHZJuaY5LygBUhIjefY/LRBaJohHsacxaVqPq9HUsweiFGcGFUriLJ+7Kk
	 3f92vHoXzgaWlSr+wfe4kqFPAYsqL45bSl7Mzih026gOByxXZuxoIO1KfVNbzp/Hfi
	 8lA68gFQ9+mI1Pks0zKXUpmRfKSqnQezIL6tIvujbSAPnqUKeaRbyltLG3O8swR44U
	 BCaY9N0TpHAhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E5B3822D49;
	Mon,  9 Jun 2025 23:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/5] bpf: Implement mprog API on top of
 existing
 cgroup progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174951243600.1592300.9068365275620223473.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 23:40:36 +0000
References: <20250606163131.2428225-1-yonghong.song@linux.dev>
In-Reply-To: <20250606163131.2428225-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  6 Jun 2025 09:31:31 -0700 you wrote:
> Current cgroup prog ordering is appending at attachment time. This is not
> ideal. In some cases, users want specific ordering at a particular cgroup
> level. For example, in Meta, we have a case where three different
> applications all have cgroup/setsockopt progs and they require specific
> ordering. Current approach is to use a bpfchainer where one bpf prog
> contains multiple global functions and each global function can be
> freplaced by a prog for a specific application. The ordering of global
> functions decides the ordering of those application specific bpf progs.
> Using bpfchainer is a centralized approach and is not desirable as
> one of applications acts as a daemon. The decentralized attachment
> approach is more favorable for those applications.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/5] cgroup: Add bpf prog revisions to struct cgroup_bpf
    https://git.kernel.org/bpf/bpf-next/c/9b8367b604c7
  - [bpf-next,v5,2/5] bpf: Implement mprog API on top of existing cgroup progs
    (no matching commit)
  - [bpf-next,v5,3/5] libbpf: Support link-based cgroup attach with options
    https://git.kernel.org/bpf/bpf-next/c/1d6711667cb3
  - [bpf-next,v5,4/5] selftests/bpf: Move some tc_helpers.h functions to test_progs.h
    https://git.kernel.org/bpf/bpf-next/c/c1bb68656bc1
  - [bpf-next,v5,5/5] selftests/bpf: Add two selftests for mprog API based cgroup progs
    https://git.kernel.org/bpf/bpf-next/c/e422d5f118e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



