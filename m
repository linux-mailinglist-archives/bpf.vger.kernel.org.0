Return-Path: <bpf+bounces-63310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13A0B05656
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48753A6FC0
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13032475E3;
	Tue, 15 Jul 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EuvzzO3B"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5F214811
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571893; cv=none; b=G4zzYxVMGpE6/8tTRHm0q6vINWtRCx9qM07mtuSGY8GmWcB02Fmg+5xDqWKywONuJSqqY0Hi2TLFi7wK1FuRb0vMPx0cdKxVon8WP4mHr9cXM+olchy0D69hX0dH3u4sVwrN0HCNjBhoxeeRTbAbzOySFijdAc/lF4IAPT/vR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571893; c=relaxed/simple;
	bh=O6JvNQl9xBY2bpg9LmsVRPGmuCcGyKF26AwgbCaUKes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poEXRkNnY4IZu8NkSQ/wGFz6PXiSladVKgz+MXXFPVD+dwLeJLl1yBnkuv0jYG7ey0R/erPYiW5aQX2NgIPHcXggEav7DnmPalqhQXGbxpm2zyAoVkFMRTgvndUrU5BRjXJtjvXgexd+aQMC6p1w9QBA77fYoy2hBrdwZ/MXkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EuvzzO3B; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752571879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeb/5krIjlgFOYTQ1dg8crO5sGUnJfkG9s1zmFFtH8Y=;
	b=EuvzzO3B/H/e5s4kCNrtS+wt9dPXsnn0AgakROKGTq+yeKTtz8On47cQoohDsrc3Watfqv
	/q8qpaNKC2KQvfLz4cXso5ZF9T+MYK5sCHmvqf3FnjZtWdrkuYvhwby9VxL99rxSNcyUAk
	ZrjOy28AcgB7oZApVxf0z4uE2IKxLrM=
Date: Tue, 15 Jul 2025 17:30:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 02/18] x86,bpf: add bpf_global_caller for
 global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, Menglong Dong <dongml2@chinatelecom.cn>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn>
 <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 16:36, Menglong Dong wrote:
>
> On 7/15/25 10:25, Alexei Starovoitov wrote:
>> Pls share top 10 from "perf report" while running the bench.
>> I'm curious about what's hot.
>> Last time I benchmarked fentry/fexit migrate_disable/enable were
>> one the hottest functions. I suspect it's the case here as well.
>
>
> You are right, the migrate_disable/enable are the hottest functions in
> both bpf trampoline and global trampoline. Following is the perf top
> for fentry-multi:
> 36.36% bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi [k] 
> bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi 20.54% [kernel] 
> [k] migrate_enable 19.35% [kernel] [k] bpf_global_caller_5_run 6.52% 
> [kernel] [k] bpf_global_caller_5 3.58% libc.so.6 [.] syscall 2.88% 
> [kernel] [k] entry_SYSCALL_64 1.50% [kernel] [k] memchr_inv 1.39% 
> [kernel] [k] fput 1.04% [kernel] [k] migrate_disable 0.91% [kernel] 
> [k] _copy_to_user
>
> And I also did the testing for fentry:
>
> 54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k] 
> bpf_prog_2dcccf652aac1793_bench_trigger_fentry
> 10.43% [kernel] [k] migrate_enable
> 10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
> 8.06% [kernel] [k] __bpf_prog_exit_recur 4.11% libc.so.6 [.] syscall 
> 2.15% [kernel] [k] entry_SYSCALL_64 1.48% [kernel] [k] memchr_inv 
> 1.32% [kernel] [k] fput 1.16% [kernel] [k] _copy_to_user 0.73% 
> [kernel] [k] bpf_prog_test_run_raw_tp
> The migrate_enable/disable are used to do the recursive checking,
> and I even wanted to perform recursive checks in the same way as
> ftrace to eliminate this overhead :/
>

Sorry that I'm not familiar with Thunderbird yet, and the perf top
messed up. Following are the test results for fentry-multi:
   36.36% bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi [k] 
bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi
   20.54% [kernel] [k] migrate_enable
   19.35% [kernel] [k] bpf_global_caller_5_run
   6.52% [kernel] [k] bpf_global_caller_5
   3.58% libc.so.6 [.] syscall
   2.88% [kernel] [k] entry_SYSCALL_64
   1.50% [kernel] [k] memchr_inv
   1.39% [kernel] [k] fput
   1.04% [kernel] [k] migrate_disable
   0.91% [kernel] [k] _copy_to_user

And I also did the testing for fentry:
   54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k] 
bpf_prog_2dcccf652aac1793_bench_trigger_fentry
   10.43% [kernel] [k] migrate_enable
   10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
   8.06% [kernel] [k] __bpf_prog_exit_recur
   4.11% libc.so.6 [.] syscall
   2.15% [kernel] [k] entry_SYSCALL_64
   1.48% [kernel] [k] memchr_inv
   1.32% [kernel] [k] fput
   1.16% [kernel] [k] _copy_to_user
   0.73% [kernel] [k] bpf_prog_test_run_raw_tp

The migrate_enable/disable are used to do the recursive checking,
and I even wanted to perform recursive checks in the same way as
ftrace to eliminate this overhead :/

Thanks!
Menglong Dong

