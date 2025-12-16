Return-Path: <bpf+bounces-76749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167CCC4F88
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E8F3037CDA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C5265CA8;
	Tue, 16 Dec 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3eCrrgw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F686359
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911803; cv=none; b=J5xHvVlh3+if948bzTxNwiFMBhzn91uDTIIpcIzPI6A+zktuE8KCX6cekupIj2tkhFeMXsSz3ORWAsY8z+30HdHSS3UO7LpIJ6lIJJi15XXPb8GBS3HMJSDfYCadaeK//2BQwRNIFrUhBjCjIqxehEKyS4egX38lbT2D79OBenk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911803; c=relaxed/simple;
	bh=u+rErwwgdGAxYPIn7ahIQM7o8HQfloX64mhwwEQJ/MY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tZVPZiStHQxFpm+hHB6gEXz8s4P+pcSIGS3tx5rV5enBYz/tNvfjy3tlNCA5h7MCHOPoB1B1e2K+Pk2Xgyvr/ycLlGh9r5hUZO3eFGQBdVcg4NV7QG1673NlnbrQMootBP5mPjSe8F+xalM5LdJKlWmslWRAKajjNFcZOWqJyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3eCrrgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A595AC4CEF1;
	Tue, 16 Dec 2025 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765911802;
	bh=u+rErwwgdGAxYPIn7ahIQM7o8HQfloX64mhwwEQJ/MY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F3eCrrgwb9Nswrc2WLzVeBYIW6RRTnMN7hoyOFis5Lwxp4SoLjzu2xJSQZaBp3hbE
	 c0/hw7xBszy1urQtzMh1OTV0qwQLLREQFlZNrOPLeoASlxbflsYNYj1vrGofrpKyVp
	 N6f2AFOP9y+EW6AdQlWU3BCKsxrh3am0PzTJkfMnOl+4iHkRSTIK9zz1W61VwmpZ55
	 qFR/bH7ZoveiyN8HzWLcMZFEOchJz6hRCBy6t0kNWvRExftgTKR/z2RHsj0kwp71YN
	 Mk3MYMbMRgLLMV0lOajMK/zjxph/ZjXCa07tND3JSfkW9DsruJtyzwIVrUaHbJV5pf
	 S3SjgC01DUOgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787CA3808200;
	Tue, 16 Dec 2025 19:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/5] libbpf: move arena variables out of the zero page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176591161329.1242102.6732390197852635004.git-patchwork-notify@kernel.org>
Date: Tue, 16 Dec 2025 19:00:13 +0000
References: <20251216173325.98465-1-emil@etsalapatis.com>
In-Reply-To: <20251216173325.98465-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, memxor@gmail.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 16 Dec 2025 12:33:20 -0500 you wrote:
> Modify libbpf to place arena globals at the end of the arena mapping
> instead of the very beginning. This allows programs to leave the
> "zero page" of the arena unmapped, so that NULL arena pointer
> dereferences trigger a page fault and associated backtrace in BPF streams.
> In contrast, the current policy of placing global data in the zero pages
> means that NULL dereferences silently corrupt global data, e.g, arena
> qspinlock state. This makes arena bugs more difficult to debug.
> 
> [...]

Here is the summary with links:
  - [v4,1/5] selftests/bpf: explicitly account for globals in verifier_arena_large
    https://git.kernel.org/bpf/bpf-next/c/0355911ac021
  - [v4,2/5] bpf/verifier: do not limit maximum direct offset into arena map
    https://git.kernel.org/bpf/bpf-next/c/12a1fe6e12db
  - [v4,3/5] libbpf: turn relo_core->sym_off unsigned
    https://git.kernel.org/bpf/bpf-next/c/0aa721437e4b
  - [v4,4/5] libbpf: move arena globals to the end of the arena
    https://git.kernel.org/bpf/bpf-next/c/c1f61171d44b
  - [v4,5/5] selftests/bpf: add tests for the arena offset of globals
    https://git.kernel.org/bpf/bpf-next/c/19f12431b6c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



