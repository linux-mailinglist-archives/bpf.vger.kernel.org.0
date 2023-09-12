Return-Path: <bpf+bounces-9787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF3D79DA0B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3197281DA0
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B5944B;
	Tue, 12 Sep 2023 20:30:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A8B652
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 20:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E30C433C9;
	Tue, 12 Sep 2023 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694550625;
	bh=zXCDZFTO01xoImfcl+dUbQZMa1RpogyFvPuN2zJYzXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fozq2vKZPnqiyEp8QVvRW0C2wAJctNWoOZATMzHGpzV4ebQY5bW6cp4CSN6WoedyJ
	 XKCAT2tUfLH+Ey2rBAOKJirjwfoQFMRovWesItpBorJUb+5OFUCgulAaGC5hKV2Tgf
	 yAx1My+tr5LDUukIlbAoFbkbz5UCC6jrusTGGJeSgozGqUOUFq2rtVnRUEOdouaL0n
	 AAKdvKVg3dS+AOvv547dy4GFLkBPx63n7FjzixPHk/ydmyUWo8EdiLbuZS9+W96s9c
	 JtRjQ4U/OX5SVJUQR5gPOYM4zGoWjUtVQxZIa5wavcIzU88VRH3nWzzGFot0TDtSn1
	 Dv9DqSCEhBuDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FA2CE1C282;
	Tue, 12 Sep 2023 20:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf, cgroup: fix multiple kernel-doc warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169455062532.1892.17786090077134413792.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 20:30:25 +0000
References: <20230912060812.1715-1-rdunlap@infradead.org>
In-Reply-To: <20230912060812.1715-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, martin.lau@linux.dev, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 Sep 2023 23:08:12 -0700 you wrote:
> Fix missing or extra function parameter kernel-doc warnings
> in cgroup.c:
> 
> kernel/bpf/cgroup.c:1359: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_skb'
> kernel/bpf/cgroup.c:1359: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_skb'
> kernel/bpf/cgroup.c:1439: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_sk'
> kernel/bpf/cgroup.c:1439: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_sk'
> kernel/bpf/cgroup.c:1467: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_sock_addr'
> kernel/bpf/cgroup.c:1467: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_sock_addr'
> kernel/bpf/cgroup.c:1512: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_sock_ops'
> kernel/bpf/cgroup.c:1512: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_sock_ops'
> kernel/bpf/cgroup.c:1685: warning: Excess function parameter 'type' description in '__cgroup_bpf_run_filter_sysctl'
> kernel/bpf/cgroup.c:1685: warning: Function parameter or member 'atype' not described in '__cgroup_bpf_run_filter_sysctl'
> kernel/bpf/cgroup.c:795: warning: Excess function parameter 'type' description in '__cgroup_bpf_replace'
> kernel/bpf/cgroup.c:795: warning: Function parameter or member 'new_prog' not described in '__cgroup_bpf_replace'
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, cgroup: fix multiple kernel-doc warnings
    https://git.kernel.org/bpf/bpf/c/214bfd267f49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



