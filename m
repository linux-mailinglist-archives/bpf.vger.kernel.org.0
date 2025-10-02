Return-Path: <bpf+bounces-70240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4650BBB523A
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01BA3A4F2E
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AEA265CC5;
	Thu,  2 Oct 2025 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz+4CzhY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8C239E65
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437617; cv=none; b=qi7SUWvhip0R1JCYekKrRVo0FVA5Qtbfa+mLWcF0wT0RDXJ9LimGDm9jQjFndBvmNvUAhjBZE9N2UIT/I8S9gBMmcZQ0ZVbQYcdgrWC1xkYQbWT0x50NkLrhN4Kk2zbl01T1f1I6JoNCXgptnAttRrxoofgjKR+6wzbbKAlpxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437617; c=relaxed/simple;
	bh=y8/HBVvgAfnzRWdMviSLyQSP26ljy/26UfJ8akRol/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QDEWfVWwh7GAbXi43H3LDdC7XugsqhKoMKvWLQdw3VM9sFU+OOfiehUji28zjZ5OEpdbO3exBv3cSbyrtEVH+09L9uK7AKHIhxlb0pky+LA8cSs6He9AX+PGHgh+R3HLkomQ70ZXM6c3qwFUCYNPglFz4tHK7Nw93MC20NSriLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz+4CzhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A297AC4CEF4;
	Thu,  2 Oct 2025 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759437615;
	bh=y8/HBVvgAfnzRWdMviSLyQSP26ljy/26UfJ8akRol/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mz+4CzhYt1pn2m53h+3/20U2xDmviKPToNQxwNfxxyqHs00QIWkMvPBlc/t0b87gE
	 xewohxyh77YRofMkEOlkMtaWf0/ZBJ4774nz0oP1rJ54gt+4xIzp+YeuiWtCe/Ej7Z
	 1a6MBlY7bCoZ+B0P/PN5Sr9utlcPronJkP5jX0DFnTXpPYcecBJ6K4Ct9+y43cBAai
	 R9/kvXFWN5GV0Axcb5syCfstWdwo+z2RHjOmy7ADimfpv4yJuWJca9K0a2zcGFrRQL
	 5X3sGupdAWghAo3h3tdwA5a9hQ9rj64LdV0MZQn4armGvHGw9yRRbJAzlk/qjEwEno
	 NKrZJELwnsb3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE96039D0C1A;
	Thu,  2 Oct 2025 20:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: tests for rejection of ALU ops with
 negative offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175943760763.3446986.1821115050894318110.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 20:40:07 +0000
References: <20251002191140.327353-1-eddyz87@gmail.com>
In-Reply-To: <20251002191140.327353-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Oct 2025 12:11:40 -0700 you wrote:
> These are test cases for commit [1].
> Define a simple program using MOD, DIV, ADD instructions,
> make sure that the program is rejected if invalid offset
> field is used for instruction.
> 
> [1] 55c0ced59fe1 ("bpf: Reject negative offsets for ALU ops")
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: tests for rejection of ALU ops with negative offsets
    https://git.kernel.org/bpf/bpf/c/2ce61c63e745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



