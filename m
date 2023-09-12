Return-Path: <bpf+bounces-9759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C9279D439
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71991C20D00
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEADF18B13;
	Tue, 12 Sep 2023 15:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8BAA952
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 15:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A93F1C433CB;
	Tue, 12 Sep 2023 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694530826;
	bh=usxEpDgllv/UaJdsmPQPRxi/XZviUkX4/bQbuFUubtg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KOUv0NZi3ANPFzWDL0eyBkVfnu8yOKgLOrk/gjerf1ln0M5JRVyAEl/nTKj95Ixho
	 NHaAHP0Bx2sVvET5E0wPSi5+ye+IA3oatrkDFtlJlkgJIbtdcE0ZZ08zWsc8nfliuF
	 m2nzlpWi/2QyKKmqZo9uKH+HbfiGBZ7qmgB/GwNq2RyKwGt0R67OzKAnqV3KTPE57h
	 jYtjorM2WRnqEX30GPL3aDwC3ik4sXvDvv2TdACYg5wDCyWTlAIpW1FKfhh/rCEoWW
	 mG9sM7XriXT4PMwD8v9bfkUV4wviv/0wXYJ1HEHMvsg6ciFkuz8WenbfmcckVsIW+h
	 JST26krJE78gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94546E1C28F;
	Tue, 12 Sep 2023 15:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: ensure all CI arches set
 CONFIG_BPF_KPROBE_OVERRIDE=y
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169453082660.458.5580185363335845556.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 15:00:26 +0000
References: <20230912055928.1704269-1-andrii@kernel.org>
In-Reply-To: <20230912055928.1704269-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 Sep 2023 22:59:28 -0700 you wrote:
> Turns out CONFIG_BPF_KPROBE_OVERRIDE=y is only enabled in x86-64 CI, but
> is not set on aarch64, causing CI failures ([0]).
> 
> Move CONFIG_BPF_KPROBE_OVERRIDE=y to arch-agnostic CI config.
> 
>   [0] https://github.com/kernel-patches/bpf/actions/runs/6122324047/job/16618390535
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: ensure all CI arches set CONFIG_BPF_KPROBE_OVERRIDE=y
    https://git.kernel.org/bpf/bpf/c/4eb94a779307

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



