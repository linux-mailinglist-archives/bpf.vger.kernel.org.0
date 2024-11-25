Return-Path: <bpf+bounces-45593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74619D8E73
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 23:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC90168AD8
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 22:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17741CEAB3;
	Mon, 25 Nov 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+nu56hg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF541BB6BC
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573221; cv=none; b=VJVmX2Os3aBTz/RTQw9dRgZ0m5c97LTgFwAku2bPdxqdYjbQjjWnHLMx/MQ8aifdl4sdFXCPHlWYKTz7nvG6dGnKemq3FSTHCNlarJyazHf8dhPU69fArmv2vA7i2LcIpJfQAUvoUmM/iV3Zj3GKCJC1D+J/4ya3ZOLe85WrejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573221; c=relaxed/simple;
	bh=pubsUg00ALnnhKD+XHokeyvqLKugHsO+D8JOa19YViI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N7+9Mv0ABPT7aEWzR1K4mVqFYJN8/xzd+5P+1j3984kFN5859gJ0yVSvZPzJIqJby12U5G5HMpLkFR2fk744vWQZUw1qRSINkBSAVvpC7rN4FU1EkKunT207tPVlWUFuYmqtzo5C4K3JT+axGnAIs8YaDXUTFTCvHyMAkzknuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+nu56hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513A6C4CECE;
	Mon, 25 Nov 2024 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732573221;
	bh=pubsUg00ALnnhKD+XHokeyvqLKugHsO+D8JOa19YViI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J+nu56hg5moiEswpAP4wuqgcTzI+9VH3wjfck1+PWEJdVBS2Ic3k8cIbIt7fXHdzV
	 f2G5D2f0nX6zsC10F1jmAugB0peViAWy7r3gNexEhOdfvUvfJkRVcpm3cNFA9hdmJq
	 lOZNkqRLIxKrhjE7oTsKVWEiltKMVP91WOZnLfqUv0ndL3vq2Z4wEwDMqRZt0Lk3Cw
	 0A4rQypHs7OGoEySWiABY+CtPB+kXsFNhknUHWutCEu+IU5YrhNmxpRR9G6D5sxYqW
	 aaPS9skOQ3il+eWqYKO07SZIm/mciHl3rfpRiAoz3bRYYuGjwRZBzvLymF2QGyccVR
	 S1gmikZ0CtPFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3465D3809A00;
	Mon, 25 Nov 2024 22:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: fix cgroup_skb prog test run direct packet
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173257323374.4055688.12478982839046244045.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 22:20:33 +0000
References: <20241125152603.375898-1-mahe.tardy@gmail.com>
In-Reply-To: <20241125152603.375898-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
 john.fastabend@gmail.com, song@kernel.org, ast@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 25 Nov 2024 15:26:02 +0000 you wrote:
> This is needed in the context of Tetragon to test cgroup_skb programs
> using BPF_PROG_TEST_RUN with direct packet access.
> 
> Commit b39b5f411dcf ("bpf: add cg_skb_is_valid_access for
> BPF_PROG_TYPE_CGROUP_SKB") added direct packet access for cgroup_skb
> programs and following commit 2cb494a36c98 ("bpf: add tests for direct
> packet access from CGROUP_SKB") added tests to the verifier to ensure
> that access to skb fields was possible and also fixed
> bpf_prog_test_run_skb. However, is_direct_pkt_access was never set to
> true for this program type, so data pointers were not computed when
> using prog_test_run, making data_end always equal to zero (data_meta is
> not accessible for cgroup_skb).
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: fix cgroup_skb prog test run direct packet access
    https://git.kernel.org/bpf/bpf-next/c/a4bc2d977a67
  - [bpf-next,2/2] selftests/bpf: add cgroup skb direct packet access test
    https://git.kernel.org/bpf/bpf-next/c/6398ef949aba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



