Return-Path: <bpf+bounces-44970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E89CF14F
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663BA1F235D7
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED51CEE9F;
	Fri, 15 Nov 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UngvuK17"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E81BCA19
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687619; cv=none; b=dBwt7liCARpt6bqX6qkV+5zHvnncLF7V4kYdY/brd6Eqf9pfNtVTrhbaejsnhNAIpeoTi5qQCqfAoVNm4kv0hdLntzHxPnsRdBwrXAyn20jue2FbV/q3YsVqn3UBwh9aBQoUmLoPRD9rmikGTE4jETdgt8FNAhO1pES/BGy2jaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687619; c=relaxed/simple;
	bh=qxzcN31OP74/h6jPNM4RK6TeOqWlKJ/qzYnLKHaM3Nc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b2L2Dg0/TzicPszwArqL4RHz3z1R8HBqicXRfGgIFg0mldVooZ5yy5/vwHbEaAP8BRO/xp8MEO0p/+Fr/9HYmbTCHlHFFeC7YqBub1Dekgl+YhkKCEZcmOOCBZs+1/dr7LNWn1piQpUVf2sbM7Hm+ceYcgYT5tc4C3CDas+8MYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UngvuK17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D798C4CECF;
	Fri, 15 Nov 2024 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731687618;
	bh=qxzcN31OP74/h6jPNM4RK6TeOqWlKJ/qzYnLKHaM3Nc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UngvuK17Rnowxgcrv9YiVVmAPA+mRltaV0HzF/I4dvycvclnBp1o8X/uA8YQQv4zQ
	 cIRv7jmZF6vyLaoK3k6XPJTesMaZAAi0X0UOflNcrvtJAWicNfwhdVxF5w/yjLi4qz
	 AQGZxFhkeIRLkCokl3+T3SApOScCagm/BeWNg8fxkqjuve+7eb+pfrqBRsMJhTgfRy
	 ESLuuILHW/RlFfkM5SEsKOLGG2dxZQ+DhF3wxcENZ8X2Wyqa9qQAB+sEMBCpJ1XGhk
	 i0KhKLB2uf9YViMMkKMyAfWk5cinyhlB+HEc6uLYDCbgKso/HO6gGocIcc3VOkpbSY
	 vtwpAjiXV8QaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6C3809A80;
	Fri, 15 Nov 2024 16:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Add necessary migrate_{disable,enable} in
 range_tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173168762925.2635622.6673990600725223564.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 16:20:29 +0000
References: <20241115060354.2832495-1-yonghong.song@linux.dev>
In-Reply-To: <20241115060354.2832495-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Nov 2024 22:03:54 -0800 you wrote:
> When running bpf selftest (./test_progs -j), the following warnings
> showed up:
> 
>   $ ./test_progs -t arena_atomics
>   ...
>   BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u19:0/12501
>   caller is bpf_mem_free+0x128/0x330
>   ...
>   Call Trace:
>    <TASK>
>    dump_stack_lvl
>    check_preemption_disabled
>    bpf_mem_free
>    range_tree_destroy
>    arena_map_free
>    bpf_map_free_deferred
>    process_scheduled_works
>    ...
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Add necessary migrate_{disable,enable} in range_tree
    https://git.kernel.org/bpf/bpf-next/c/4ff04abf9d5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



