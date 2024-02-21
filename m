Return-Path: <bpf+bounces-22438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45285E410
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F6B1C2231E
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367CE83A00;
	Wed, 21 Feb 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEu0SlS5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255D839F7
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535429; cv=none; b=C10d4Loyzqi+xFtFHd1hP/gs4QAvVec9j+qubTxf22H0aOuL+pHEfJZkROfwVKg2cMD6erpaGOI6/25V1pfxwz1aFe685T/wAx6cqpAxD3/b/f/Fw/QntebPDQs3JTqUB/i43QP+kJ3AJJt+9KcdLHFQ/q14+GLbdem6Ufl2B+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535429; c=relaxed/simple;
	bh=efyCiLuleKp57DbeHjl3nZHMzpyZtUsiclG8R7hzzGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JxRl+6t6c1nxpwvQ5532ZKQHkOXqlmNfRo5KwmwO2W5OSzADqJpNVPnXAH1IPRZBvmNr+zHfMl26auoxivoqf3ykAsDoLeGHskA/CFeq9ngnSl6wbNSPzbe0EM5/iUr6YUKN0eXmHE8r2fyKVXyXuTOueOAZWi3xbt7tSIqOJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEu0SlS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39F39C43390;
	Wed, 21 Feb 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708535429;
	bh=efyCiLuleKp57DbeHjl3nZHMzpyZtUsiclG8R7hzzGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CEu0SlS5YJCUnNPIK0SmXZJBHAW5ejPV+TtdBJki/RMeAvjxtCTF+zydsPmq/4R/v
	 tsbU+pZCw9kC+jjvB51ax5K+AS+cN/C1pLnDwB8bXNJ4jCvXyV0mwaigfYx94p4+U0
	 E+/4U32f8dSQvWW6XRdDPoYX+qTxfScwBCyMLJQcvnjnD3VtjmKG/KUUghmz9CFqU/
	 dU/5SIk6r7l4WKsnFBmBwv6ijN14ZdC50MEDHnE+K+WSYrXQMpXwdRuOKzcVE07hvv
	 tPBboe2tc2BgjnVvQqjBYB6Rz2pqz5wqLTJWdhS0e12tdhk7V67naxQzM0DOsxeKBu
	 8y/sPLVQuMi/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 160FCC00446;
	Wed, 21 Feb 2024 17:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Shrink size of struct bpf_map/bpf_array.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170853542908.1753.8774842675480593810.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 17:10:29 +0000
References: <20240220235001.57411-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240220235001.57411-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 20 Feb 2024 15:50:01 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Back in 2018 the commit be95a845cc44 ("bpf: avoid false sharing of map refcount with max_entries")
> added ____cacheline_aligned to "struct bpf_map" to make sure that fields like
> refcnt don't share a cache line with max_entries that is used to bounds check
> map access. That was done to make spectre style attacks harder. The main
> mitigation is done via code similar to array_index_nospec(), of course.
> This was an additional precaution.
> It increased the size of "struct bpf_map" a little, but it's affect
> on all other maps (like array) is significant, since "struct bpf_map" is
> typically the first member in other map types.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Shrink size of struct bpf_map/bpf_array.
    https://git.kernel.org/bpf/bpf-next/c/f86783991809

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



