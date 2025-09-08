Return-Path: <bpf+bounces-67800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15590B49B59
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 23:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7A83B514F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53723535C;
	Mon,  8 Sep 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRghxTVD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC3274B35;
	Mon,  8 Sep 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365244; cv=none; b=OCFuT3eRYY4m5tiYIKxpQNGzWAKT4vLSE0vlPPkmq16wyM8C7kzP94JIuuYIxh6fWYL3Y9HKl7fi1OGG+98Ti3dmck06z8sYFAgLjnDWUTbkt/eGoxYFWgAlilF8jEjWR4DqlWfvhZm2j+P0dHbrkeGqUaJTj4JQPJtVW3y01TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365244; c=relaxed/simple;
	bh=jjf+aHsPpbrLWSDIt9QKsf5MQvphLbS4gLwD5a1BFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKCwRQU6Guabt//apOHUBRo0mLmLTzOD/MR5vDsFFDxt2joi3V8ZLnWHtkBlDcvuvktPoMnMzsVzD9SjR0JtcHnORp0PFZvx3UC3DoWAwfwNz7xsw8Z9ces5a4runwKe/7T9DZ7hfhfhBIFtVLbZ42RrULdugfhAixDWIJ2RIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRghxTVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C32BC4CEF1;
	Mon,  8 Sep 2025 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757365243;
	bh=jjf+aHsPpbrLWSDIt9QKsf5MQvphLbS4gLwD5a1BFes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRghxTVDtXnkHUprmyWWSLe/gyt5uG8/I8SN4ih8EZeMb7Bxgr9/Q+ognLI0EiW4t
	 HcuT2KFU+1M+Oc8fJmxcKZl54p7nFWAs9Cxi/KLN5YJrxKyd7P9pP6XWdaY63gmU/n
	 8kZt1JsIO+ZF3Zq+rrWbYkgRmURZq93dnh7f5hbqNx0mzoO7e1autXoW/QEQ+FE6V1
	 KI7tr9tRAFWwbjkDtMZ7aCbkK6w7Od3iIe35gVepG/lyb//uEEiuJou1HWFcbUnxWP
	 nmZaQFk/+wEFJWmKIhNFpxin+r9zszGmdTigV29UE7tcPzdpZDo+3Mxswq5AHMu5KK
	 1nD3icjzd8qYA==
Date: Mon, 8 Sep 2025 14:00:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <song@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Jakub Brnak <jbrnak@redhat.com>
Subject: Re: [PATCH 1/5] perf trace: use standard syscall tracepoint structs
 for augmentation
Message-ID: <aL9D-ZzdNFxD8hkn@google.com>
References: <20250814071754.193265-1-namhyung@kernel.org>
 <20250814071754.193265-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814071754.193265-2-namhyung@kernel.org>

On Thu, Aug 14, 2025 at 12:17:50AM -0700, Namhyung Kim wrote:
> From: Jakub Brnak <jbrnak@redhat.com>
> 
> Replace custom syscall structs with the standard trace_event_raw_sys_enter
> and trace_event_raw_sys_exit from vmlinux.h.
> This fixes a data structure misalignment issue discovered on RHEL-9, which
> prevented BPF programs from correctly accessing syscall arguments.
> This change also aims to improve compatibility between different version
> of the perf tool and kernel by using CO-RE so BPF code can correclty
> adjust field offsets.
> 
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> [ coding style updates and fix a BPF verifier issue ]
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
[SNIP]
> @@ -489,9 +477,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>  			index = -(size + 1);
>  			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>  			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
> -			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
> +			aug_size = args->args[index];
>  
>  			if (aug_size > 0) {
> +				if (aug_size > TRACE_AUG_MAX_BUF)
> +					aug_size = TRACE_AUG_MAX_BUF;
>  				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>  					augmented = true;
>  			}

Does it help if you just revert this hunk?
(But actually my kernel doesn't like this...)


diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 979d60d7dce6565b..c4088bdd4916b0e6 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -493,11 +493,9 @@ static int augment_sys_enter(void *ctx, struct trace_event_raw_sys_enter *args)
                        index = -(size + 1);
                        barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
                        index &= 7;         // Satisfy the bounds checking with the verifier in some kernels.
-                       aug_size = args->args[index];
+                       aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
 
                        if (aug_size > 0) {
-                               if (aug_size > TRACE_AUG_MAX_BUF)
-                                       aug_size = TRACE_AUG_MAX_BUF;
                                if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
                                        augmented = true;
                        }


