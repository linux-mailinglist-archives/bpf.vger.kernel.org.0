Return-Path: <bpf+bounces-9786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE479D9FD
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7BB281CB2
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA71FB669;
	Tue, 12 Sep 2023 20:20:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E15B647
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 20:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7AFEC433C8;
	Tue, 12 Sep 2023 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694550027;
	bh=qcOXM0cVBmy9bKgRtSElnIjmRIk9WoM9JMQ+/ejaCj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EfF0d5/jE8m9NV3n/3f+5mKd12i8ib1tVBt2SLELCBOCehdJO38JO7+5kJTxjUbnF
	 DYMWMCdGCyrk/Q8OFeum3aKZw1wDVEz5LUdSwARY6yq56rhQxwKXQ2usDqaLQ5qUtl
	 RNITbMHvmwXqNHdeA3OzlIYwFM2aJ/LeHDLuifDf1kK1ajWIwRzGTtRAEqWcEKB7Rf
	 vAlBDdPIn6GT4WbUUjxaZJUmsSmh8Y+ZmaXuT7IUR4vuOdKl1mO/cGMi7Y/IKHtRW5
	 2mV7WokAv//eIZPpqFbYASdGQXzrTWLWzknYMSLVasPAfJVMU+vArYdMZPBt2hMH1f
	 Izclp2a2kLj6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3667E1C282;
	Tue, 12 Sep 2023 20:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] bpf, x64: Fix tailcall infinite loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169455002685.29579.6381172628752155950.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 20:20:26 +0000
References: <20230912150442.2009-1-hffilwlqm@gmail.com>
In-Reply-To: <20230912150442.2009-1-hffilwlqm@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, maciej.fijalkowski@intel.com, song@kernel.org,
 iii@linux.ibm.com, xukuohai@huawei.com, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Sep 2023 23:04:39 +0800 you wrote:
> This patch series fixes a tailcall infinite loop on x64.
> 
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
> 
> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf, x64: Comment tail_call_cnt initialisation
    https://git.kernel.org/bpf/bpf-next/c/2bee9770f3c6
  - [bpf-next,2/3] bpf, x64: Fix tailcall infinite loop
    https://git.kernel.org/bpf/bpf-next/c/2b5dcb31a19a
  - [bpf-next,3/3] selftests/bpf: Add testcases for tailcall infinite loop fixing
    https://git.kernel.org/bpf/bpf-next/c/e13b5f2f3ba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



