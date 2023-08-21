Return-Path: <bpf+bounces-8196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565AA7835F8
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 00:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DC61C203A7
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47D11C9C;
	Mon, 21 Aug 2023 22:50:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9C1FC4;
	Mon, 21 Aug 2023 22:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D039C433C9;
	Mon, 21 Aug 2023 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692658226;
	bh=9hSlkdavW23lm/+WlfHkmQmhA43fSiwydxdnmahOoLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PqwN7TAHr9369Dtdvzna5ifDVdBGAXuwVJalx0svNK+xOn+7QcvuTnfwgq16TqUJ2
	 VP2tLRgdawuuaB2oZE1omsPZqUW1TQ+jB0EbmJ3MNgNSFP+5Cjxlt27wPHJWPCOsG5
	 ACXOqZSRUxKrI9nLdCLVry9UbOWBE9GIYUlv6d7+lz7iR2oCZ3T40PykJhLChHKJ4S
	 QzdnQQY98kT61ZNPTzEw7cIWVjiga6/m4YJFrpMJ++J9oo37d34MAwHjzKV+cW3iqw
	 JNJuuJtaBleTxSanNtYHA8cJWQa3W73Eh0pjcuwADeoJmQQKg1A8NlmjCYR2LctCXm
	 sQYv+OfsW7zTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70F3BE4EAFB;
	Mon, 21 Aug 2023 22:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next 0/9] samples/bpf: make BPF programs more libbpf aware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169265822645.19025.15250374334018816513.git-patchwork-notify@kernel.org>
Date: Mon, 21 Aug 2023 22:50:26 +0000
References: <20230818090119.477441-1-danieltimlee@gmail.com>
In-Reply-To: <20230818090119.477441-1-danieltimlee@gmail.com>
To: Daniel T. Lee <danieltimlee@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 18 Aug 2023 18:01:10 +0900 you wrote:
> The existing tracing programs have been developed for a considerable
> period of time and, as a result, do not properly incorporate the
> features of the current libbpf, such as CO-RE. This is evident in
> frequent usage of functions like PT_REGS* and the persistence of "hack"
> methods using underscore-style bpf_probe_read_kernel from the past.
> These programs are far behind the current level of libbpf and can
> potentially confuse users.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/9] samples/bpf: fix warning with ignored-attributes
    https://git.kernel.org/bpf/bpf-next/c/34f6e38f58db
  - [bpf-next,2/9] samples/bpf: convert to vmlinux.h with tracing programs
    https://git.kernel.org/bpf/bpf-next/c/e7e6c774f5d4
  - [bpf-next,3/9] samples/bpf: unify bpf program suffix to .bpf with tracing programs
    https://git.kernel.org/bpf/bpf-next/c/4a0ee7889069
  - [bpf-next,4/9] samples/bpf: fix symbol mismatch by compiler optimization
    https://git.kernel.org/bpf/bpf-next/c/02dabc247ad6
  - [bpf-next,5/9] samples/bpf: make tracing programs to be more CO-RE centric
    https://git.kernel.org/bpf/bpf-next/c/11430421b440
  - [bpf-next,6/9] samples/bpf: fix bio latency check with tracepoint
    https://git.kernel.org/bpf/bpf-next/c/92632115fb57
  - [bpf-next,7/9] samples/bpf: fix broken map lookup probe
    https://git.kernel.org/bpf/bpf-next/c/d93a7cf6ca2c
  - [bpf-next,8/9] samples/bpf: refactor syscall tracing programs using BPF_KSYSCALL macro
    https://git.kernel.org/bpf/bpf-next/c/8dc805514631
  - [bpf-next,9/9] samples/bpf: simplify spintest with kprobe.multi
    https://git.kernel.org/bpf/bpf-next/c/456d53554ca7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



