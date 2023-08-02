Return-Path: <bpf+bounces-6757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F6076D963
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 23:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339801C212B1
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEC612B67;
	Wed,  2 Aug 2023 21:20:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C2125BC
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 21:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53901C433C7;
	Wed,  2 Aug 2023 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691011221;
	bh=r3kCRVSYFBLItWe2GV/TfNk+pBsHmyVL2Z8MBrXrPg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KfzHGHMko0UeGp/f2ND5mAbBMYnRoflMYUXrOCIrcKUS2s+QQwiHjK8oIKAzyCbub
	 RKxePwuIa8y+637dazizHtwLEoUZkgCLyh03bGBDvp46nZ66fmHqG8dQnpZnPFgAF0
	 Y40jmjeZiFYBByXk5XQ/tqHpuMLg2GDMIsewf7ioYwzjOGogm6oz4AJ1ikb4JUL19e
	 OtK6eUQ0HqjrU02q8IUiqmu4N5WnPq6G6PSLAJzD8ILUzc37XkGGtO18sqFpi2l4n7
	 1HnJ00IZk+JwweFreVP19PhWZ6o5FXkBHWiuMsDxTb2TK1fP+6ChiDT7jiL7ZACtUG
	 vyJdLb+Fw4LyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 339AFE270D7;
	Wed,  2 Aug 2023 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v5] bpf: fix bpf_probe_read_kernel prototype mismatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169101122119.28051.8597932529135437329.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 21:20:21 +0000
References: <20230801111449.185301-1-arnd@kernel.org>
In-Reply-To: <20230801111449.185301-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de,
 stable@vger.kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, davemarchevsky@fb.com,
 void@manifault.com, peterz@infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  1 Aug 2023 13:13:58 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bpf_probe_read_kernel() has a __weak definition in core.c and another
> definition with an incompatible prototype in kernel/trace/bpf_trace.c,
> when CONFIG_BPF_EVENTS is enabled.
> 
> Since the two are incompatible, there cannot be a shared declaration in
> a header file, but the lack of a prototype causes a W=1 warning:
> 
> [...]

Here is the summary with links:
  - [v5] bpf: fix bpf_probe_read_kernel prototype mismatch
    https://git.kernel.org/bpf/bpf-next/c/6a5a148aaf14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



