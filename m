Return-Path: <bpf+bounces-2851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E3073567C
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 14:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1286B2810EC
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B37210975;
	Mon, 19 Jun 2023 12:10:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F40D539
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 12:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10C2EC433C0;
	Mon, 19 Jun 2023 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687176621;
	bh=ZocE6lmGQJgAIcjvNlhtHFL+RP9Bh97sqnRM5LgZWtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fz4rgBpGD+HQ9rr3SVYVebhVmZNcUQy3pXI9oaEgQGZZtQcKV4JJq2EZYJ2OCUHGV
	 aqNzJV3aO2OYyqXKRB/c8INLIvljgQvL80ffEsS1mznvFjtwKa/GCUpCjKTh0wqsET
	 1IFUGkCrdm9Lu008SuIRrBe0UcQr2n4KfhMdtXsKGZJVveENyMdOwqbF1geIiGfte7
	 o4IhqJzElEbka+eMBh6g5f4E+XJWtvclvDmk5O+5cvxvTQuACerC3MH+heVs8zuaDh
	 ZpxyQjxI/brzbFDLVChZGoA04ne7K41QZsBAxrfx2iPLJoGQ+7qiM60PjJ+Nx/lktV
	 ZBosvMZsgxibg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAA6BE301F6;
	Mon, 19 Jun 2023 12:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] Clean up BPF permissions checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168717662095.5239.16025212755558078216.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jun 2023 12:10:20 +0000
References: <20230613223533.3689589-1-andrii@kernel.org>
In-Reply-To: <20230613223533.3689589-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 13 Jun 2023 15:35:29 -0700 you wrote:
> This patch set contains a few refactorings to BPF map and BPF program creation
> permissions checks, which were originally part of BPF token patch set ([0]),
> but are logically completely independent and useful in their own right.
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=755113&state=*
> 
> Andrii Nakryiko (4):
>   bpf: move unprivileged checks into map_create() and bpf_prog_load()
>   bpf: inline map creation logic in map_create() function
>   bpf: centralize permissions checks for all BPF map types
>   bpf: keep BPF_PROG_LOAD permission checks clear of validations
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] bpf: move unprivileged checks into map_create() and bpf_prog_load()
    https://git.kernel.org/bpf/bpf-next/c/1d28635abcf1
  - [bpf-next,2/4] bpf: inline map creation logic in map_create() function
    https://git.kernel.org/bpf/bpf-next/c/22db41226b67
  - [bpf-next,3/4] bpf: centralize permissions checks for all BPF map types
    https://git.kernel.org/bpf/bpf-next/c/6c3eba1c5e28
  - [bpf-next,4/4] bpf: keep BPF_PROG_LOAD permission checks clear of validations
    https://git.kernel.org/bpf/bpf-next/c/7f6719f7a866

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



