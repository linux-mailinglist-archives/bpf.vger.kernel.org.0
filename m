Return-Path: <bpf+bounces-6225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E9767262
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5CA28247F
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719214ABF;
	Fri, 28 Jul 2023 16:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CA14009
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39868C433CB;
	Fri, 28 Jul 2023 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690563021;
	bh=SRc/qD11tFzS8XRDaeKwqUmEP20eOTYIR/Am1kGzHKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UFFMMh8bB1hiA4WVwsp5KiHc5JLPZIN4j3EgSBlFfMhs3uVkJObqYTLbrssoRlea6
	 EF8LHsJm1PRlL52lzPQe4jFEe+BKVT1ZIbYeR6XuJWcuarQycW8s7vQ/ALSp8RSpsT
	 Umu3hgMdPZKYDg7+x71Y4aqYIXzfmUsMvI1gGjl8s88k2UL/k8lwQ8vyTUCFfB2lvM
	 qJMMpOhMXXQ4Rgj/p+7rDsonK+WFPHNZtxMP2JMC00rrLUaPDmi4Pg99Ea441hFYPs
	 2doc4G52+NNoXdKBu4qXGBUdkMSOqbPIgwMoM55z6KMG+hjxc/uegLOvM2FO919F3F
	 08QwTcgP9XU8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C094C4166F;
	Fri, 28 Jul 2023 16:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] bpf/memalloc: Non-atomically allocate freelist
 during prefill
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169056302111.15046.9436134761640107327.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 16:50:21 +0000
References: <20230728043359.3324347-1-zhuyifei@google.com>
In-Reply-To: <20230728043359.3324347-1-zhuyifei@google.com>
To: YiFei Zhu <zhuyifei@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
 martin.lau@linux.dev, andrii@kernel.org, houtao@huaweicloud.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Jul 2023 04:33:59 +0000 you wrote:
> In internal testing of test_maps, we sometimes observed failures like:
>   test_maps: test_maps.c:173: void test_hashmap_percpu(unsigned int, void *):
>     Assertion `bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0' failed.
> where the errno is ENOMEM. After some troubleshooting and enabling
> the warnings, we saw:
>   [   91.304708] percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left
>   [   91.304716] CPU: 51 PID: 24145 Comm: test_maps Kdump: loaded Tainted: G                 N 6.1.38-smp-DEV #7
>   [   91.304719] Hardware name: Google Astoria/astoria, BIOS 0.20230627.0-0 06/27/2023
>   [   91.304721] Call Trace:
>   [   91.304724]  <TASK>
>   [   91.304730]  [<ffffffffa7ef83b9>] dump_stack_lvl+0x59/0x88
>   [   91.304737]  [<ffffffffa7ef83f8>] dump_stack+0x10/0x18
>   [   91.304738]  [<ffffffffa75caa0c>] pcpu_alloc+0x6fc/0x870
>   [   91.304741]  [<ffffffffa75ca302>] __alloc_percpu_gfp+0x12/0x20
>   [   91.304743]  [<ffffffffa756785e>] alloc_bulk+0xde/0x1e0
>   [   91.304746]  [<ffffffffa7566c02>] bpf_mem_alloc_init+0xd2/0x2f0
>   [   91.304747]  [<ffffffffa7547c69>] htab_map_alloc+0x479/0x650
>   [   91.304750]  [<ffffffffa751d6e0>] map_create+0x140/0x2e0
>   [   91.304752]  [<ffffffffa751d413>] __sys_bpf+0x5a3/0x6c0
>   [   91.304753]  [<ffffffffa751c3ec>] __x64_sys_bpf+0x1c/0x30
>   [   91.304754]  [<ffffffffa7ef847a>] do_syscall_64+0x5a/0x80
>   [   91.304756]  [<ffffffffa800009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] bpf/memalloc: Non-atomically allocate freelist during prefill
    https://git.kernel.org/bpf/bpf-next/c/d1a02358d48d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



