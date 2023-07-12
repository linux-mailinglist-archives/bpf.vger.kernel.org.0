Return-Path: <bpf+bounces-4854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB63750BF9
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA488281A07
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD6C2418F;
	Wed, 12 Jul 2023 15:10:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D524160
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD6BEC433CB;
	Wed, 12 Jul 2023 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689174622;
	bh=Be0fq1ijRTpTVISh0RyOEDD2ZOjzBrxC0GHTT9eudWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tdk6ENU23ypfT32wzEBsk6unIkmPgqS2n5k3aJGkoKMLl93ufshWorjv9B2zgO9D0
	 Ah9BEjuTlG8sMEePzKxA5LQ4osKNND4yx1U7Ky5Zea1gYuuh7HPB+W87FE98XqcVhC
	 jwF1ah2etn3dn68whHS8va6+3/Y3TtH2ItbVQ3ZHTa486aaR0CvbjHVEeV6TbEHaBI
	 iD8ADNSV8c4/xoFRKkRj4LEkPG6J1DV0rEzp0tqkM7z1CCg9LcdjwDsOCS9gkeG3pV
	 KoITjpW6U6CvlTtfDNdR3wOs7oSCM3H/s4adFl3/Obbtoup5I+98QJsOYE0yU8zyXQ
	 87tes8tWtt7PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91C4EE4D006;
	Wed, 12 Jul 2023 15:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: teach verifier actual bounds of
 bpf_get_smp_processor_id() result
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168917462259.27088.12288610158413976919.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 15:10:22 +0000
References: <20230711232400.1658562-1-andrii@kernel.org>
In-Reply-To: <20230711232400.1658562-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 11 Jul 2023 16:23:59 -0700 you wrote:
> bpf_get_smp_processor_id() helper returns current CPU on which BPF
> program runs. It can't return value that is bigger than maximum allowed
> number of CPUs (minus one, due to zero indexing). Teach BPF verifier to
> recognize that. This makes it possible to use bpf_get_smp_processor_id()
> result to index into arrays without extra checks, as demonstrated in
> subsequent selftests/bpf patch.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: teach verifier actual bounds of bpf_get_smp_processor_id() result
    https://git.kernel.org/bpf/bpf-next/c/f42bcd168d03
  - [bpf-next,2/2] selftests/bpf: extend existing map resize tests for per-cpu use case
    https://git.kernel.org/bpf/bpf-next/c/c21de5fc5ffd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



