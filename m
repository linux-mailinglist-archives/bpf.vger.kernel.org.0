Return-Path: <bpf+bounces-7201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E56773537
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 01:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF692814AD
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB5B1989A;
	Mon,  7 Aug 2023 23:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14391988F
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 23:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C3BBC433C7;
	Mon,  7 Aug 2023 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691452222;
	bh=OH4uHW78MJBwQyscC2EOuCKqDFFV7pO7jX4wLGDWVPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UL5n6ojHaSt0O8Zx08dkwsOa2UsuiztQGeBS44ILt3jLaDhunyo4CSEnqn4XOiQ96
	 WqQk89cTxEdxAs8M09X+orBCdjwQ8xnezWMXAgIai/5pIvQuzkUOEXy2uaawymPMDG
	 Scd4nZPMDxlKXdi9ZH1/Bjd22fIejn6f+2733dGQ9j+vrp4WYVDSxggcMp09bT1n4C
	 +mcyEzcuYUDuOjzbppasiga+cTGr/rsBR0Dm6yOWqwep8eec20I9fFe1OGR4tZnyJc
	 q4bbRtpVw5t4ZpNg+KYrn4jpgJsgpJgtrQMmGHiy5pvz6RqfYGJcAaSjEFymVH70g2
	 9BUcWAqQ5PDXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51080E505D5;
	Mon,  7 Aug 2023 23:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix an incorrect verification success with
 movsx insn
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169145222232.5057.14232029916065724489.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 23:50:22 +0000
References: <20230807175721.671696-1-yonghong.song@linux.dev>
In-Reply-To: <20230807175721.671696-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon,  7 Aug 2023 10:57:21 -0700 you wrote:
> syzbot reports a verifier bug which triggers a runtime panic.
> The test bpf program is:
>    0: (62) *(u32 *)(r10 -8) = 553656332
>    1: (bf) r1 = (s16)r10
>    2: (07) r1 += -8
>    3: (b7) r2 = 3
>    4: (bd) if r2 <= r1 goto pc+0
>    5: (85) call bpf_trace_printk#-138320
>    6: (b7) r0 = 0
>    7: (95) exit
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix an incorrect verification success with movsx insn
    https://git.kernel.org/bpf/bpf-next/c/db2baf82b098
  - [bpf-next,2/2] selftests/bpf: Add a movsx selftest for sign-extension of R10
    https://git.kernel.org/bpf/bpf-next/c/a5c0a42bd374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



