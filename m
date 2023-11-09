Return-Path: <bpf+bounces-14623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC87E71D4
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6639280F4C
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830E62230C;
	Thu,  9 Nov 2023 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxzfz0N+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04C20334
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A5B6C433C8;
	Thu,  9 Nov 2023 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699556426;
	bh=puQlvSHm1B1OglzLAZwFObMy+Twm4qjYI86SUIQUB18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kxzfz0N+BP5UApgsoiwlZqSJaF5ehKZNqhOr9JL99cnlOq852cNGGb3XttMpEevJE
	 +jQM2zATEyYWEN9aOmWHGKlsqLpw3zUKQYqvskyKwCjn3j8QbsA5p4+FOGt39zUsHe
	 Ngye0ZjkWZtuORLmnjlNtyW0MNMv7DO9eTV50eyUW9Dw6H/MM/dpiURs4Z8fRgoN1O
	 2gB+PqYngGBSt1yerirVZIO1R2tFQdKIMY8X4UI9uAeKFkhOclPFjc7QMv2+yK08eS
	 G9iRoMCzdCuFRsvlD192wUA8VEpBqoLUAnn7r8shdb76LGkCB+09F6nJkvT2HyONun
	 8taJyJLhC45NQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 472DBC561EE;
	Thu,  9 Nov 2023 19:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/6] Allow bpf_refcount_acquire of mapval obtained
 via direct LD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169955642628.28609.1667943374596782197.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 19:00:26 +0000
References: <20231107085639.3016113-1-davemarchevsky@fb.com>
In-Reply-To: <20231107085639.3016113-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 7 Nov 2023 00:56:33 -0800 you wrote:
> Consider this BPF program:
> 
>   struct cgv_node {
>     int d;
>     struct bpf_refcount r;
>     struct bpf_rb_node rb;
>   };
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/6] bpf: Add KF_RCU flag to bpf_refcount_acquire_impl
    https://git.kernel.org/bpf/bpf-next/c/8a53f8c65c9f
  - [v2,bpf-next,2/6] selftests/bpf: Add test passing MAYBE_NULL reg to bpf_refcount_acquire
    https://git.kernel.org/bpf/bpf-next/c/315bbb93dafc
  - [v2,bpf-next,3/6] bpf: Use bpf_mem_free_rcu when bpf_obj_dropping non-refcounted nodes
    https://git.kernel.org/bpf/bpf-next/c/cf1ec20de34b
  - [v2,bpf-next,4/6] bpf: Move GRAPH_{ROOT,NODE}_MASK macros into btf_field_type enum
    https://git.kernel.org/bpf/bpf-next/c/a7b6ab9481d0
  - [v2,bpf-next,5/6] bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref
    https://git.kernel.org/bpf/bpf-next/c/6eba51e33182
  - [v2,bpf-next,6/6] selftests/bpf: Test bpf_refcount_acquire of node obtained via direct ld
    https://git.kernel.org/bpf/bpf-next/c/3975f7e7494b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



