Return-Path: <bpf+bounces-63692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22DB099C1
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149AC567E8E
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D74186E2D;
	Fri, 18 Jul 2025 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQoNZzFY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406E4C9D
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805787; cv=none; b=pt1JxskNKJeHe0+5RBywVD/GlFwY8Y3TGlRJ6bvmUZ2xMbayhbIB/iOoobOfXQVgt2qe34k6VKmISOaaltKECQ9ZSvJeF/5qFTkZP81aptg0hVeWBvOqFvXLCL9Tqc7Xn0+3Ee0PhLhUgbeVmGVhIV0rKib348Mp9Q/lBFWc5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805787; c=relaxed/simple;
	bh=Lezooth2kuySEu6NAwmuec1m8gabS76hqJS5Mhhq1Mk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c97FtyiudO14GoZO9cqUrCiOQ9ukj5CEDQ13vXxXwnKAqt5n5PiroYRfIPm0iZRZUERXDEWvml13pVqcMtR3nFwfaVxBD6B/TA28QrrXpS7htZF1LVKlU+ewUtCNOjmdVPaG2d8qG4qwrm0hT7PhhgjeWF9rflz4HCprIDlRHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQoNZzFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8B2C4CEE3;
	Fri, 18 Jul 2025 02:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752805787;
	bh=Lezooth2kuySEu6NAwmuec1m8gabS76hqJS5Mhhq1Mk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qQoNZzFY9sk5o2e1ES904H0CPt2y8JSAczCVmrwH29YmihFDBSdLpZlYsO/KAM0wM
	 LPug9iOA4sagHy7HShLdQjfpzGstiQp8wVMiLmgizAZlQtgEMe5J2p/r2hQae458P5
	 46F1Z14npM3v7iy6gUmFsKVf7CRvWoEaniiqQaw0rh9B7wx3YD2YCXluY8WV9QO7tO
	 ceFF+fxgWmXdz74p26HCv/ql/aHl5O4nbPuiuXZdICJWCH22kh2TjWhwwNl7aqhnYy
	 PQ9ZuOYWIpFKa2LFyk0C/ByzWqj4tqAvPrWoXqtQpaKcqQCfUBtGafmtUkCURjQaYE
	 aCx8cJmTfHFIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA4383BA3C;
	Fri, 18 Jul 2025 02:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: fix handling of BPF arena relocations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280580701.2148942.16536171931658629515.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:30:07 +0000
References: <20250718001009.610955-1-andrii@kernel.org>
In-Reply-To: <20250718001009.610955-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 17 Jul 2025 17:10:09 -0700 you wrote:
> Initial __arean global variable support implementation in libbpf
> contains a bug: it remembers struct bpf_map pointer for arena, which is
> used later on to process relocations. Recording this pointer is
> problematic because map pointers are not stable during ELF relocation
> collection phase, as an array of struct bpf_map's can be reallocated,
> invalidating all the pointers. Libbpf is dealing with similar issues by
> using a stable internal map index, though for BPF arena map specifically
> this approach wasn't used due to an oversight.
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: fix handling of BPF arena relocations
    https://git.kernel.org/bpf/bpf/c/0238c45fbbf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



