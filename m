Return-Path: <bpf+bounces-5206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D45758A16
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149692817D0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A7D17C4;
	Wed, 19 Jul 2023 00:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1C17F3
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 146DBC433C9;
	Wed, 19 Jul 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689726623;
	bh=hHyL/QYbQ5WqTW6mt4uNGXl8ZcgbB+3FWE34ZlwymYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qbABjTV5PZ6uG9RAW22VVxtwtEjrNE8WfYDs/T/+GeZKlXD/gunvaeJQvO3ycDTph
	 zaTN8DRw4ljWAezOdAjxv50P6hywRn0Z6fnk5SjiMh3hU/sJWKy9tcKvQhiRyGpAjm
	 Ov9NfE2m/H2QnBuiqVf+ADVUxgy7Z0p7Pz5r6t2E9lPLR8KUW/IzqRMGw0CAS9i0qE
	 EGbt/2Mj138UFRPYoAxhefyEIa0ubb59K/m+gj19MjF9+sYCbZXpsdMYkTzyZ0q3Lz
	 YNCGl5VE5U0i6bjY3JhGeWKlivXuxwmb+NJXajlQfUveqIlzGzdQdk6BdEVFLjcEeT
	 hjTYtB7EAwcFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB27DC64458;
	Wed, 19 Jul 2023 00:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 0/6] BPF Refcount followups 2: owner field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972662295.5728.6737046050379982493.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 00:30:22 +0000
References: <20230718083813.3416104-1-davemarchevsky@fb.com>
In-Reply-To: <20230718083813.3416104-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 18 Jul 2023 01:38:07 -0700 you wrote:
> This series adds an 'owner' field to bpf_{list,rb}_node structs, to be
> used by the runtime to determine whether insertion or removal operations
> are valid in shared ownership scenarios. Both the races which the series
> fixes and the fix itself are inspired by Kumar's suggestions in [0].
> 
> Aside from insertion and removal having more reasons to fail, there are
> no user-facing changes as a result of this series.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/6,DONOTAPPLY] Revert "bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"
    (no matching commit)
  - [v2,bpf-next,2/6] bpf: Introduce internal definitions for UAPI-opaque bpf_{rb,list}_node
    https://git.kernel.org/bpf/bpf-next/c/0a1f7bfe35a3
  - [v2,bpf-next,3/6] bpf: Add 'owner' field to bpf_{list,rb}_node
    https://git.kernel.org/bpf/bpf-next/c/c3c510ce431c
  - [v2,bpf-next,4/6] selftests/bpf: Add rbtree test exercising race which 'owner' field prevents
    https://git.kernel.org/bpf/bpf-next/c/fdf48dc2d054
  - [v2,bpf-next,5/6] selftests/bpf: Disable newly-added 'owner' field test until refcount re-enabled
    https://git.kernel.org/bpf/bpf-next/c/f3514a5d6740
  - [v2,bpf-next,6/6,DONOTAPPLY] Revert "selftests/bpf: Disable newly-added 'owner' field test until refcount re-enabled"
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



