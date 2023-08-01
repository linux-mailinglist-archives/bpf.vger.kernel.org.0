Return-Path: <bpf+bounces-6496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B8376A5A4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2192B281746
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B71C62D;
	Tue,  1 Aug 2023 00:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A87E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 00:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FF47C433CA;
	Tue,  1 Aug 2023 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690850420;
	bh=aqFZdTPAhIo3aADjyRJ3QkIJoXZDnKszUv7ozgPWOxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NBxn65hwTz03oByZkT+UIScZmmTP2Ctu2e9Wx0M4PdKUpqsuvl8U/w3qlbvIIVriC
	 AP8Mt9zfE6GbHJC+hOQxvR3eK5EjIfD+vnyoR6dpUKIuo4IgFSeQk+gTtosLGHausp
	 JSc6w2wk64TTfn2nNckWyElcUYI2CNAmxZDc3DYxplmheyXxDGbzMYiQ4n0IJJIRm/
	 egBsyLc/xVfbTh94dGS8RwUOcFvTJgnvDI7WaLS7fIhrQxdkyY0fKXtZZvg/CNL89r
	 P/lqm5KzcpgmLDVd5EeaBhfeW37HG47zeln/0cM3cR7C0oRFojiKGpb0A6qIEqKLq3
	 85wrvVjTiNXtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12AEDC595C0;
	Tue,  1 Aug 2023 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] kernel/bpf: Fix an array-index-out-of-bounds issue
 in disasm.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169085042006.2613.6575059402578434436.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 00:40:20 +0000
References: <20230731204534.1975311-1-yonghong.song@linux.dev>
In-Reply-To: <20230731204534.1975311-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 syzbot+3758842a6c01012aa73b@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 31 Jul 2023 13:45:34 -0700 you wrote:
> syzbot reported an array-index-out-of-bounds when printing out bpf
> insns. Further investigation shows the insn is illegal but
> is printed out due to log level 1 or 2 before actual insn verification
> in do_check().
> 
> This particular illegal insn is a MOVSX insn with offset value 2.
> The legal offset value for MOVSX should be 8, 16 and 32.
> The disasm sign-extension-size array index is calculated as
>  (insn->off / 8) - 1
> and offset value 2 gives an out-of-bound index -1.
> 
> [...]

Here is the summary with links:
  - [bpf-next] kernel/bpf: Fix an array-index-out-of-bounds issue in disasm.c
    https://git.kernel.org/bpf/bpf-next/c/e99688eba2e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



