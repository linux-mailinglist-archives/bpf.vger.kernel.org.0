Return-Path: <bpf+bounces-17328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B89480B888
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 04:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8965C280EE9
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1315B1;
	Sun, 10 Dec 2023 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3A0kimf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375887F
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 03:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86F67C433C9;
	Sun, 10 Dec 2023 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702178422;
	bh=qRLsQabxHlv3Wgla2OfXv1jtjzJEhzSrks56HtlwH+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W3A0kimfHA2f5AfosNEHYDNG/RM7tdxob9ZCDJcgOFhTEjyJ09kiXLiU4043MsG24
	 ibCVf7j19WzB6bq7x5mG9uVoP1oD8n7stosSv9qa1mNcjezuVEQlmsQq88ndENysDh
	 ZuqGECS5UfdZwC++7B4fsvpohS/wAkAlQfDiuezcEViB+H5hQyHIevpNL45njflepJ
	 VXq03KibPUUqi/vwfo4JZhYS2ft0XV76mkOoVrkvhAcG0lF3veasKLUtGiZYxE+kmb
	 aXHtU/o9hNb6Xfm9lsfPlwEb7kwqwmGOT1LppYga04NpZCbS3kRY+vVlEErBzh5ZDS
	 CMzV3ww6drkPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E8FCC04DD9;
	Sun, 10 Dec 2023 03:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: handle fake register spill to stack with
 BPF_ST_MEM instruction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170217842244.20852.7194635318072673450.git-patchwork-notify@kernel.org>
Date: Sun, 10 Dec 2023 03:20:22 +0000
References: <20231209010958.66758-1-andrii@kernel.org>
In-Reply-To: <20231209010958.66758-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 8 Dec 2023 17:09:57 -0800 you wrote:
> When verifier validates BPF_ST_MEM instruction that stores known
> constant to stack (e.g., *(u64 *)(r10 - 8) = 123), it effectively spills
> a fake register with a constant (but initially imprecise) value to
> a stack slot. Because read-side logic treats it as a proper register
> fill from stack slot, we need to mark such stack slot initialization as
> INSN_F_STACK_ACCESS instruction to stop precision backtracking from
> missing it.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: handle fake register spill to stack with BPF_ST_MEM instruction
    https://git.kernel.org/bpf/bpf-next/c/482d548d40b0
  - [bpf-next,2/2] selftests/bpf: validate fake register spill/fill precision backtracking logic
    https://git.kernel.org/bpf/bpf-next/c/7d8ed51bcb32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



