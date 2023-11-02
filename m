Return-Path: <bpf+bounces-13965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD67DF770
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94732B2129A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6E1D6BA;
	Thu,  2 Nov 2023 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUFcCRzh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6021C29A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC5FC433CA;
	Thu,  2 Nov 2023 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698941429;
	bh=wWCMJgbMnzEU1stKTZMHnsvyGaCp8imYhOOHxqCtR0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iUFcCRzhKCDo7PWds33aRn9XYnsp80YeumisPnAtY9JGIfEK6y0Slbr7/hGVEVcGP
	 s/JHTXyxfnslzdDG4mOsmwUvZyP3NJNL94WLl7K+nPND2FkP+QlCtiRJXdSV28JZcV
	 dOK7LFJGaN7Ia4A8uuC4xAWNm9cFzZ/1breLnlyVikSeq+D1RZilddTwyna1cnzY07
	 xyJ2ccupl5VZVSeym2nE8my09rMPRg3HLV2WFicnQa7fsIr4hrLJxH9ehCtVIOXi/o
	 3v/beTp08zJiCbCliZOOEETQeh0izeJEwKykQbH/sYK5UBuXk8aGiNxdOlcRYjNm8U
	 G17l7jW9nFkCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2F2FC395FC;
	Thu,  2 Nov 2023 16:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf-next 00/17] BPF register bounds logic and testing
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169894142879.27186.8286702726190146232.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 16:10:28 +0000
References: <20231102033759.2541186-1-andrii@kernel.org>
In-Reply-To: <20231102033759.2541186-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 1 Nov 2023 20:37:42 -0700 you wrote:
> This patch set adds a big set of manual and auto-generated test cases
> validating BPF verifier's register bounds tracking and deduction logic. See
> details in the last patch.
> 
> We start with building a tester that validates existing <range> vs <scalar>
> verifier logic for range bounds. To make all this work, BPF verifier's logic
> needed a bunch of improvements to handle some cases that previously were not
> covered. This had no implications as to correctness of verifier logic, but it
> was incomplete enough to cause significant disagreements with alternative
> implementation of register bounds logic that tests in this patch set
> implement. So we need BPF verifier logic improvements to make all the tests
> pass. This is what we do in patches #3 through #9.
> 
> [...]

Here is the summary with links:
  - [v6,bpf-next,01/17] selftests/bpf: fix RELEASE=1 build for tc_opts
    https://git.kernel.org/bpf/bpf-next/c/3cda0779ded1
  - [v6,bpf-next,02/17] selftests/bpf: satisfy compiler by having explicit return in btf test
    https://git.kernel.org/bpf/bpf-next/c/7bcc07dcd835
  - [v6,bpf-next,03/17] bpf: derive smin/smax from umin/max bounds
    https://git.kernel.org/bpf/bpf-next/c/2e74aef782d3
  - [v6,bpf-next,04/17] bpf: derive smin32/smax32 from umin32/umax32 bounds
    https://git.kernel.org/bpf/bpf-next/c/f188765f23a5
  - [v6,bpf-next,05/17] bpf: derive subreg bounds from full bounds when upper 32 bits are constant
    https://git.kernel.org/bpf/bpf-next/c/f404ef3b42c8
  - [v6,bpf-next,06/17] bpf: add special smin32/smax32 derivation from 64-bit bounds
    https://git.kernel.org/bpf/bpf-next/c/6533e0acff58
  - [v6,bpf-next,07/17] bpf: improve deduction of 64-bit bounds from 32-bit bounds
    https://git.kernel.org/bpf/bpf-next/c/3d6940ddd9b5
  - [v6,bpf-next,08/17] bpf: try harder to deduce register bounds from different numeric domains
    https://git.kernel.org/bpf/bpf-next/c/558c06e551a3
  - [v6,bpf-next,09/17] bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
    https://git.kernel.org/bpf/bpf-next/c/b929d4979b2b
  - [v6,bpf-next,10/17] selftests/bpf: BPF register range bounds tester
    (no matching commit)
  - [v6,bpf-next,11/17] bpf: rename is_branch_taken reg arguments to prepare for the second one
    https://git.kernel.org/bpf/bpf-next/c/cdeb5dab9238
  - [v6,bpf-next,12/17] bpf: generalize is_branch_taken() to work with two registers
    https://git.kernel.org/bpf/bpf-next/c/fc3615dd0ee9
  - [v6,bpf-next,13/17] bpf: move is_branch_taken() down
    https://git.kernel.org/bpf/bpf-next/c/dd2a2cc3c1bf
  - [v6,bpf-next,14/17] bpf: generalize is_branch_taken to handle all conditional jumps in one place
    https://git.kernel.org/bpf/bpf-next/c/171de12646d2
  - [v6,bpf-next,15/17] bpf: unify 32-bit and 64-bit is_branch_taken logic
    https://git.kernel.org/bpf/bpf-next/c/761a9e560d0c
  - [v6,bpf-next,16/17] bpf: prepare reg_set_min_max for second set of registers
    https://git.kernel.org/bpf/bpf-next/c/4c617286771e
  - [v6,bpf-next,17/17] bpf: generalize reg_set_min_max() to handle two sets of two registers
    https://git.kernel.org/bpf/bpf-next/c/9a14d62a2cdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



