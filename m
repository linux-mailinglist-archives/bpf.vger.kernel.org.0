Return-Path: <bpf+bounces-9090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E578F40C
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 22:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A551C20B27
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582F19BDC;
	Thu, 31 Aug 2023 20:30:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB81AA6A
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 20:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85AD4C433C8;
	Thu, 31 Aug 2023 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693513823;
	bh=z1ngC7zIGvLrM807z+IsyfcsFsJXzA8xbW0X2MiXEvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eC6tgIN99/MrfO8eLbeewGCDiBnepgszrVvw5t18dKoSImWlNnF8fOOgG3rwozaA4
	 NlGKn6Sz9HMQ73bWIyUf8M9enz9wfCCv7X2L5MNZ8lzBH96HbEQWgt2ipFwULhW4AM
	 bjnlpwmjlEG/+cp3CVH4+QyA7N9B2TqR/G60cZvZ8qbRQRE2O9bFh272m8U8bJqPdJ
	 c0YHElAN6+DXtGnlXprZ9fnZf99QdrXJIVqn2y3ymB1SuNHUnzZGKtRPwM4fD8zt1Y
	 NqC/A704O12knQTsUyvlEmBMST05Krr3mEyxqGA922YNjsulZd7uEYF0hXPRH/0Ir1
	 gP2VAL5RlbbuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D0EBC595D2;
	Thu, 31 Aug 2023 20:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Annotate bpf_long_memcpy with data_race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169351382344.13181.5151687407861972063.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 20:30:23 +0000
References: <57628f7a15e20d502247c3b55fceb1cb2b31f266.1693342186.git.daniel@iogearbox.net>
In-Reply-To: <57628f7a15e20d502247c3b55fceb1cb2b31f266.1693342186.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
 syzbot+97522333291430dd277f@syzkaller.appspotmail.com, elver@google.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 29 Aug 2023 22:53:52 +0200 you wrote:
> syzbot reported a data race splat between two processes trying to
> update the same BPF map value via syscall on different CPUs:
> 
>   BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update
> 
>   write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
>    bpf_long_memcpy include/linux/bpf.h:428 [inline]
>    bpf_obj_memcpy include/linux/bpf.h:441 [inline]
>    copy_map_value_long include/linux/bpf.h:464 [inline]
>    bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
>    bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
>    generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
>    bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
>    __sys_bpf+0x28a/0x780
>    __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
>    __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
>    __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Annotate bpf_long_memcpy with data_race
    https://git.kernel.org/bpf/bpf/c/6a86b5b5cd76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



