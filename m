Return-Path: <bpf+bounces-15130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6E17ED1FF
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 21:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E7B281447
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F5446AA;
	Wed, 15 Nov 2023 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1Ej07Wb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6A446B0
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 20:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16B4FC433C7;
	Wed, 15 Nov 2023 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700080226;
	bh=z9SWO6BWcgc+yBo63uxP//qWuj80gyFPno/dqBQDKs0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I1Ej07WbMq3qaMImRGGxcvIDZEpvDCwbglle2YOL9/7xLzkYIQfukHWef9eI6UvWi
	 oUPPs57bXVvOFFQtkLXsFBS4P+nQcPmGK+D31RjvoMPAL69++9m4yG4Rb5lnEpEcC7
	 PZZgRn3sD25FTMLxiXCcTdSrTC2Tbyzfz+a5+fEgns5uEykIa4Va5X4WvpUH1K+5yc
	 /NwEIK33+lhiF0dSurAEhOAC083/3nILeP3P+NvZjaDqkuN7dMYqBw8lx0CTKHF5gA
	 tqTL6OO/JA7ignLR9vb7wylXE8fWVz2ekjmCqHBl0c+CY722WTc9PrnIaecm+dhEiM
	 45zkfjXZPp3Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1B91E1F670;
	Wed, 15 Nov 2023 20:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 00/13] BPF register bounds range vs range support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170008022598.32180.10391937319281894463.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 20:30:25 +0000
References: <20231112010609.848406-1-andrii@kernel.org>
In-Reply-To: <20231112010609.848406-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 Nov 2023 17:05:56 -0800 you wrote:
> This patch set is a continuation of work started in [0]. It adds a big set of
> manual, auto-generated, and now also random test cases validating BPF
> verifier's register bounds tracking and deduction logic.
> 
> First few patches generalize verifier's logic to handle conditional jumps and
> corresponding range adjustments in case when two non-const registers are
> compared to each other. Patch #1 generalizes reg_set_min_max() portion, while
> patch #2 does the same for is_branch_taken() part of the overall solution.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,01/13] bpf: generalize reg_set_min_max() to handle non-const register comparisons
    https://git.kernel.org/bpf/bpf-next/c/67420501e868
  - [v2,bpf-next,02/13] bpf: generalize is_scalar_branch_taken() logic
    https://git.kernel.org/bpf/bpf-next/c/96381879a370
  - [v2,bpf-next,03/13] bpf: enhance BPF_JEQ/BPF_JNE is_branch_taken logic
    https://git.kernel.org/bpf/bpf-next/c/be41a203bb9e
  - [v2,bpf-next,04/13] bpf: add register bounds sanity checks and sanitization
    https://git.kernel.org/bpf/bpf-next/c/5f99f312bd3b
  - [v2,bpf-next,05/13] bpf: remove redundant s{32,64} -> u{32,64} deduction logic
    https://git.kernel.org/bpf/bpf-next/c/3cf98cf594ea
  - [v2,bpf-next,06/13] bpf: make __reg{32,64}_deduce_bounds logic more robust
    https://git.kernel.org/bpf/bpf-next/c/cf5fe3c71c5a
  - [v2,bpf-next,07/13] selftests/bpf: BPF register range bounds tester
    https://git.kernel.org/bpf/bpf-next/c/8863238993e2
  - [v2,bpf-next,08/13] selftests/bpf: adjust OP_EQ/OP_NE handling to use subranges for branch taken
    https://git.kernel.org/bpf/bpf-next/c/774f94c5e74d
  - [v2,bpf-next,09/13] selftests/bpf: add range x range test to reg_bounds
    https://git.kernel.org/bpf/bpf-next/c/2b0d204e368b
  - [v2,bpf-next,10/13] selftests/bpf: add randomized reg_bounds tests
    https://git.kernel.org/bpf/bpf-next/c/dab16659c50e
  - [v2,bpf-next,11/13] selftests/bpf: set BPF_F_TEST_SANITY_SCRIPT by default
    https://git.kernel.org/bpf/bpf-next/c/8c5677f8b31e
  - [v2,bpf-next,12/13] veristat: add ability to set BPF_F_TEST_SANITY_STRICT flag with -r flag
    https://git.kernel.org/bpf/bpf-next/c/a5c57f81eb2b
  - [v2,bpf-next,13/13] selftests/bpf: add iter test requiring range x range logic
    https://git.kernel.org/bpf/bpf-next/c/882e3d873c2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



