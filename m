Return-Path: <bpf+bounces-78978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 066AAD22430
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 04:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F080301D5D4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 03:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A52848B2;
	Thu, 15 Jan 2026 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLjLZERL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A7194C96
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768446816; cv=none; b=WmhXjt19YlTl7DBBOj0M08Izz3hM/gQfT0MKAmg9zuJvz9jnwqXQlesFt+4I/qbjDhiJprHVoKW4ABg7HFVH6jZKulVDkKzxj04f+IzIGnKDEa4WC97C3YC4PJqM6qMNvwLgUKin9vGNZseM+x9YMDFQkzNvpy8drXtZzNNCkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768446816; c=relaxed/simple;
	bh=1+orvjq90QLewpEdbUCzrGUD1iMtNEUp9qXD8WbqKv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PObg8oui4EVNJpAQJNasDk9zzjxpBSdAeOij2JrNN6kdWK6fM+kOm8utPvF8AgRvLsJ42OvDz1CdnlF/mdsVelgwQTpbNjXmZRsjeRWdODCqKPfPGV8txKXNgo4zaQNPy7MbObCmx0nuiBOL9FSaV0HcxdrdTZiZiNdPHVzUnfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLjLZERL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037A5C4CEF7;
	Thu, 15 Jan 2026 03:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768446816;
	bh=1+orvjq90QLewpEdbUCzrGUD1iMtNEUp9qXD8WbqKv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uLjLZERLtM/AOU4nq7J70xzrMckwe0GRN0kmdYZ+NEvJ/SB1z0rEYlbKG2tBUtiHE
	 CMB+QCe12s0TNte1v/Hn2WCH9H193TR9N6Gn+rOO4KkaN/Deo4fdtaIegbt9BuLzj9
	 iIaXMfSVQxUMF7g/o7FHVZ9/zdNlM2qLynSqNZGoF8no4/a4+wyUdFsTYuUPi+GNbZ
	 vhZhaTRVSfc9TTyDQgSqLuh2ugLqK2YQxTvnrlufSb8nobg2xBsOOWWt4GitP25+4x
	 x0dXoVX9uGbHRUYq16FMcBhqZ+JNTUyWdpoLQ1mKLhpwGcj3fPuwD60GY42tcLha7U
	 EliWQK7UbDBUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A003809A8D;
	Thu, 15 Jan 2026 03:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/2] bpf: Live registers computation with
 gotox
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176844660837.3413945.7283534725807927040.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 03:10:08 +0000
References: <20260114162544.83253-1-a.s.protopopov@gmail.com>
In-Reply-To: <20260114162544.83253-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 14 Jan 2026 16:25:42 +0000 you wrote:
> While adding a selftest for live registers computation with gotox,
> I've noticed that the code is actually incomplete. Namely, the
> destination register rX in `gotox rX` wasn't actually considered
> as used. Fix this and add a selftest.
> 
> v1 -> v2:
>   * only enable the new selftest on x86 and arm64
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Properly mark live registers for indirect jumps
    https://git.kernel.org/bpf/bpf-next/c/d1aab1ca576c
  - [v2,bpf-next,2/2] selftests/bpf: Extend live regs tests with a test for gotox
    https://git.kernel.org/bpf/bpf-next/c/7c8e817e443c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



