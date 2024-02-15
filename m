Return-Path: <bpf+bounces-22109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EAE856FB5
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 23:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB101C20BD8
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4A145344;
	Thu, 15 Feb 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5StUsSn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D91420A8
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034429; cv=none; b=noaFdPBQ93236gltUDfsoQ/5ad3N7m39VvFaztFDIBU+iIqOG33rRT1iEkLQkEvsrQyGZN1SwiDhkCjLClxOxMzeVI1W4MrediHztlmJ+1S4r9CugRtBM/05BrmFMbxBe5yUv7IIbgyG9r4A2F8G06YDCmkMb9DXeMlJ+omZImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034429; c=relaxed/simple;
	bh=R5ID4P1wAS6NUQ+LMkLJazGr7DspcasxQT40OE5chpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kUgAvu1i7EMSkPtHxVtS4eafXtViE9fOFyPFztFMGcFe7kRC/YOjibrYi7+LZVSjx9nEcRz3XpbwAX2mCranKOIM18B75oWnHoTpDSzpMd++EFyIFhqLJULppo7tKHvkEu9t9ovxc1MsabzUKYJsbCyC2OpxfqVF5ZyvU+3fjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5StUsSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C7B8C43330;
	Thu, 15 Feb 2024 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708034429;
	bh=R5ID4P1wAS6NUQ+LMkLJazGr7DspcasxQT40OE5chpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o5StUsSnhXIsKRaattH02yUyp1QW32cRzjUQvHnkFSawxn8C3lEPYOnk/+oHk4Rzl
	 5OCLLY/F99S2RpgkwHlgQ2ydtNKKMUEgVobGTj1sqRceLEn6EFqv2An4l7APM7cK77
	 Gcn9OZJBS6d9A0XzsZ6PE+kVHFm5sDfQ8m7TdetxufCrf73xrHRtFKevRhglX80/6p
	 n1CVwJMhZPZcYSmMPMiKnrmtKdvWV0jDDf/w8SCvIHrSotktnoMFttD+V4CHny2xqN
	 6t4p/VYLZdtKhgcF1Sl+qjUGBvJZowlcYHTD5XYaztZoMldMehz5qZnd0QbNo7K9qU
	 dUg+vgQhB0sUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0288ED8C97D;
	Thu, 15 Feb 2024 22:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpf: Fix test verif_scale_strobemeta_subprogs
 failure due to llvm19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170803442900.22703.11941141637840510871.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 22:00:29 +0000
References: <20240214232951.4113094-1-yonghong.song@linux.dev>
In-Reply-To: <20240214232951.4113094-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 14 Feb 2024 15:29:51 -0800 you wrote:
> With latest llvm19, I hit the following selftest failures with
> 
>   $ ./test_progs -j
>   libbpf: prog 'on_event': BPF program load failed: Permission denied
>   libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>   combined stack size of 4 calls is 544. Too large
>   verification time 1344153 usec
>   stack depth 24+440+0+32
>   processed 51008 insns (limit 1000000) max_states_per_insn 19 total_states 1467 peak_states 303 mark_read 146
>   -- END PROG LOAD LOG --
>   libbpf: prog 'on_event': failed to load: -13
>   libbpf: failed to load object 'strobemeta_subprogs.bpf.o'
>   scale_test:FAIL:expect_success unexpected error: -13 (errno 13)
>   #498     verif_scale_strobemeta_subprogs:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf: Fix test verif_scale_strobemeta_subprogs failure due to llvm19
    https://git.kernel.org/bpf/bpf-next/c/682158ab532a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



