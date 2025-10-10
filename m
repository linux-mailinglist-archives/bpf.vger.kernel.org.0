Return-Path: <bpf+bounces-70757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC46BCE0B2
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF10C4E5830
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D779F204F93;
	Fri, 10 Oct 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQovkJdY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F8201278
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116230; cv=none; b=BtuLFZheJCQXoO+femkALGhtX1ekmDb4N6tLHyK2eOSU0qgX6esM1oRSAEmXGHmtGx0keIVmxre7BXdSJNew11j2WygEU7zBJjUzTWADzymXKHiWrnvnViHiF/r3o9Fg1O2MewoGOIXoThslN0VU8NRXannlis0rCXy+o1h7DhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116230; c=relaxed/simple;
	bh=gKwl9XIeJ5X+AFfIwivGFUAXJEsZe8+/Pq8GglnjHlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OTsj5LXCjszJZz5uoRO3XHnfEegk9DUvh3Qn7qqgImmAMWZwY2ian6hi6Rw7bICXqmtXrjQ3XFxMperJbDrtqjYZ+nwrcGarWCodBz2jkK2xCZZxCBK/afwCPZpmEaNPAg6l0krlHdMCvb8+NDHPnweAmhwWVhFTz+NriblRnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQovkJdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383B3C4CEF1;
	Fri, 10 Oct 2025 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760116230;
	bh=gKwl9XIeJ5X+AFfIwivGFUAXJEsZe8+/Pq8GglnjHlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vQovkJdYgZutdUsV7WgGqLoqARYRvl0/NHCRjNt/13MX4H1AClzEz2lQSelR4zxd4
	 pjHgw427ifb2G5NZwtxOPsFlXzvcZLjcj3gWXzzQk6qgeYfaTXL6rpjh66cWjP+W3X
	 IwW3lHvi+4/EA4lYbeUb5KEz57yhyb06ooHqNWLWYpBt1kxIue8MO85ShoUKJYBn3h
	 1KdyoNsNEgjpukAupgC/wQoibO1pfcOmDjJjM76K4z0th+FQyAHx47Ksk34RFiF/yg
	 B5WUlFNRsO3DI0BXFWLRI6jWGwXyFr9jXLXLJfSuE/hXePLCAbMVOZz76FEoz+U51N
	 X0wEBLAdIm/Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF9E3809A00;
	Fri, 10 Oct 2025 17:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] Fix sleepable context tracking for async
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176011621774.1050631.14348659219233302229.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 17:10:17 +0000
References: <20251007220349.3852807-1-memxor@gmail.com>
In-Reply-To: <20251007220349.3852807-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 Oct 2025 22:03:46 +0000 you wrote:
> Currently, asynchronous execution primitives set up their callback
> execution simulation using push_async_cb, which will end up inheriting
> the sleepable or non-sleepable bit from the program triggering the
> simulation of the callback. This is incorrect, as the actual execution
> context of the asynchronous callback has nothing to do with the program
> arming its execution.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: Fix sleepable context for async callbacks
    https://git.kernel.org/bpf/bpf-next/c/469d638d1520
  - [bpf-next,v2,2/3] bpf: Refactor storage_get_func_atomic to generic non_sleepable flag
    https://git.kernel.org/bpf/bpf-next/c/f233d4855918
  - [bpf-next,v2,3/3] selftests/bpf: Add tests for async cb context
    https://git.kernel.org/bpf/bpf-next/c/5b1b5d380ac7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



