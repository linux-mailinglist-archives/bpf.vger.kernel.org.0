Return-Path: <bpf+bounces-15316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C63FE7F02C4
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B341C209B6
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A471A711;
	Sat, 18 Nov 2023 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg4rsstl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AE11711
	for <bpf@vger.kernel.org>; Sat, 18 Nov 2023 19:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C771C433C7;
	Sat, 18 Nov 2023 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700337030;
	bh=3yWzyMwpz4JOkjQugNeVvdWIQVGCx6HrF/QkURwZHYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tg4rsstlFYQZwS2y0B/XKNZtNW4vkOAW/cGN08DnxH9DzwMeXqpD6/sbtm1c5izTP
	 GVzukbQ+tEXwjsGPeD7nHzm9TKaEmF6lSmFqfraFLJRtuDEeBZIEgdevaW/ne2/K40
	 vE0tZ27xxZeL6F68F5XH/fjWfIEm9IwzKXAruFJPRXf9lSCPfjLvMPz1tkr/FscOR1
	 KdLLEEC1r1dNj1GaXe1hYZC/+ZeYUVRCQeowwciK/agck07gK3bJuLOxD80imLgU2q
	 MGyjgMKKhZ/dTTWRbU2Cz2zIgdGtashsYis3kY0ysO48kXqO1hB9EU81ZS4zYwYIlO
	 Q92tMDZaoERyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24E00EA6303;
	Sat, 18 Nov 2023 19:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/8] BPF verifier log improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170033703014.19891.11451927195007871211.git-patchwork-notify@kernel.org>
Date: Sat, 18 Nov 2023 19:50:30 +0000
References: <20231118034623.3320920-1-andrii@kernel.org>
In-Reply-To: <20231118034623.3320920-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Nov 2023 19:46:15 -0800 you wrote:
> This patch set moves a big chunk of verifier log related code from gigantic
> verifier.c file into more focused kernel/bpf/log.c. This is not essential to
> the rest of functionality in this patch set, so I can undo it, but it felt
> like it's good to start chipping away from 20K+ verifier.c whenever we can.
> 
> The main purpose of the patch set, though, is in improving verifier log
> further.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/8] bpf: move verbose_linfo() into kernel/bpf/log.c
    https://git.kernel.org/bpf/bpf-next/c/db840d389bad
  - [v3,bpf-next,2/8] bpf: move verifier state printing code to kernel/bpf/log.c
    https://git.kernel.org/bpf/bpf-next/c/42feb6620acc
  - [v3,bpf-next,3/8] bpf: extract register state printing
    https://git.kernel.org/bpf/bpf-next/c/009f5465be36
  - [v3,bpf-next,4/8] bpf: print spilled register state in stack slot
    https://git.kernel.org/bpf/bpf-next/c/67d43dfbb42d
  - [v3,bpf-next,5/8] bpf: emit map name in register state if applicable and available
    https://git.kernel.org/bpf/bpf-next/c/0c95c9fdb696
  - [v3,bpf-next,6/8] bpf: omit default off=0 and imm=0 in register state log
    https://git.kernel.org/bpf/bpf-next/c/1db747d75b1d
  - [v3,bpf-next,7/8] bpf: smarter verifier log number printing logic
    https://git.kernel.org/bpf/bpf-next/c/0f8dbdbc641b
  - [v3,bpf-next,8/8] bpf: emit frameno for PTR_TO_STACK regs if it differs from current one
    https://git.kernel.org/bpf/bpf-next/c/46862ee854b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



