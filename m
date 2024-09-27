Return-Path: <bpf+bounces-40447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8649A988C85
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 00:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384A91F22187
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707E1B3F39;
	Fri, 27 Sep 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNUrVH5X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2621B375A
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476828; cv=none; b=VaFWBSiDh8ooaRSXWhd/QVBs2PHopPxFRjF9O+Hc5pZOisqkwGnYiRya3Poh1wc2z4gLVxDi1Qeen0j68FPNQ1lygYv49TxI9jupWq9BnyKe1k6xCbJw8z8gfFMlOwCLOPgj/3p4FJLvdMinqDi/u5DUmYiOO9UF5dMU26ptaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476828; c=relaxed/simple;
	bh=7H0++jbOS3POOrqOOe9/sEn4R9ax47hscQbGO4RrvQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n4/RpnCGdhkjay3wa8dCXeEkGSEBas71lafs+GqoUviQy5DDmKNKS+EmNcz9NOOLEZVIFhzohH43rxmv0+kQulx3CvFceHoMbXZdx9Y/7KF9COXpVrOt9SsVYlZH3Mp6hXgQ+HQOGguCfP7lAc4sHs9MQdy+9xCDkbh8M3oqy+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNUrVH5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC037C4CEC4;
	Fri, 27 Sep 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727476827;
	bh=7H0++jbOS3POOrqOOe9/sEn4R9ax47hscQbGO4RrvQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JNUrVH5XDVs4v9ooO55lvBXS+qzpWD+o5S0yobUVyPTF5gZB6NbEk9zkeVfS/3ZE6
	 mxGZBXnUvrTO6/PvtWEbN0dlWd8FTlTealdWw5nhu31QlXJaxqSI1Tx8is9wNFoE4y
	 lYjaNShr4Pha8DGe7zufeNXBwOYgTtXP0LcwZljaEpeG+BuEO9OlOYRU+OPGPsg+fK
	 t5EWoHWuTcp9Xc1ow/4jTJmcxLjB4j4LkP7usOG7tTklMyFWncTEVPN89L5zyEY4Z6
	 E1eWamJdyh0Xbp3H69Jf0qv+kCoRo1CnkDUoAINJ5eHzPNY7bBlYvhFsjSredZ8ML4
	 c6Jskq9Xxqbnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4483809A80;
	Fri, 27 Sep 2024 22:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/4] 'bpf_fastcall' attribute in vmlinux.h and
 bpf_helper_defs.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172747683052.2103547.5959881424986859558.git-patchwork-notify@kernel.org>
Date: Fri, 27 Sep 2024 22:40:30 +0000
References: <20240916091712.2929279-1-eddyz87@gmail.com>
In-Reply-To: <20240916091712.2929279-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, arnaldo.melo@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 16 Sep 2024 02:17:08 -0700 you wrote:
> The goal of this patch-set is to reflect attribute bpf_fastcall
> for supported helpers and kfuncs in generated header files.
> For helpers this requires a tweak for scripts/bpf_doc.py and an update
> to uapi/linux/bpf.h doc-comment.
> For kfuncs this requires:
> - introduction of a new KF_FASTCALL flag;
> - modification to pahole to read kfunc flags and generate
>   DECL_TAG "bpf_fastcall" for marked kfuncs;
> - modification to bpftool to scan for DECL_TAG "bpf_fastcall"
>   presence.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/4] bpf: allow specifying bpf_fastcall attribute for BPF helpers
    https://git.kernel.org/bpf/bpf-next/c/8143f960d915
  - [bpf-next,v1,2/4] bpf: __bpf_fastcall for bpf_get_smp_processor_id in uapi
    https://git.kernel.org/bpf/bpf-next/c/f399d418c5f2
  - [bpf-next,v1,3/4] bpf: use KF_FASTCALL to mark kfuncs supporting fastcall contract
    https://git.kernel.org/bpf/bpf-next/c/f49520133c3a
  - [bpf-next,v1,4/4] bpftool: __bpf_fastcall for kfuncs marked with special decl_tag
    https://git.kernel.org/bpf/bpf-next/c/00df87ce7eac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



