Return-Path: <bpf+bounces-11381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505ED7B83D2
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 05345281814
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75A1B272;
	Wed,  4 Oct 2023 15:40:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D91B26B
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 15:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 887BBC433C7;
	Wed,  4 Oct 2023 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696434028;
	bh=1ohuaw1fkG6+BlaP2psmIM5NBfEvII8ZebNym21BJDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IfWDGoEOrHo8ct1WEjAu7bkxQRZ5Ne8dZ7SpOdd9yHSIiyseg18m+uBZODNeA1vfh
	 UhXr3XyaKGhjJjIePdmrF5ZfkhZKg3rOTOgMuo8i1xk9pHHDidUxBk3kJw9TogzsYN
	 knTGqym6sqfGkobIDvh/5UPSJzGgK29/oHl4t+9KuHPkWMfrspT1lZMZT9XkiMmgAZ
	 ZzoZJmHkBmGy5vS1xfZABdQjdUH6MJ56MJO58yEnp7DMawmJ1HNdcSJWIhfBGif3NQ
	 xlrnVJKw1W18Yrbh9PkN9yZ9ivZWNuSCfHc0sMLuv9ICq5HvTMm96YtGuQ+mE0O46s
	 1EIqL0pRGjaUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DBCDE632D7;
	Wed,  4 Oct 2023 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/8] Allocate bpf trampoline on bpf_prog_pack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169643402844.27884.17605341056103086153.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 15:40:28 +0000
References: <20230926190020.1111575-1-song@kernel.org>
In-Reply-To: <20230926190020.1111575-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
 iii@linux.ibm.com, bjorn@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 26 Sep 2023 12:00:12 -0700 you wrote:
> This set enables allocating bpf trampoline from bpf_prog_pack on x86. The
> majority of this work, however, is the refactoring of trampoline code.
> This is needed because we need to handle 4 archs and 2 users (trampoline
> and struct_ops).
> 
> 1/8 is a dependency that is already applied to bpf tree.
> 2/8 through 7/8 refactors trampoline code. A few helpers are added.
> 8/8 finally let bpf trampoline on x86 use bpf_prog_pack.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/8] s390/bpf: Let arch_prepare_bpf_trampoline return program size
    https://git.kernel.org/netdev/net/c/cf094baa3e0f
  - [v3,bpf-next,2/8] bpf: Let bpf_prog_pack_free handle any pointer
    (no matching commit)
  - [v3,bpf-next,3/8] bpf: Adjust argument names of arch_prepare_bpf_trampoline()
    (no matching commit)
  - [v3,bpf-next,4/8] bpf: Add helpers for trampoline image management
    (no matching commit)
  - [v3,bpf-next,5/8] bpf, x86: Adjust arch_prepare_bpf_trampoline return value
    (no matching commit)
  - [v3,bpf-next,6/8] bpf: Add arch_bpf_trampoline_size()
    (no matching commit)
  - [v3,bpf-next,7/8] bpf: Use arch_bpf_trampoline_size
    (no matching commit)
  - [v3,bpf-next,8/8] x86, bpf: Use bpf_prog_pack for bpf trampoline
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



