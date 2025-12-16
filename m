Return-Path: <bpf+bounces-76649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACBFCC0612
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D1E30142F1
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC121257A;
	Tue, 16 Dec 2025 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NDWNp4+h"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F02248B8
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846425; cv=none; b=BYL8BDJfj5t9i1YQ8+V45S4Xa5rXDzzvZZ0pZc0jHqrTeNurgJtfaYLcBrLNYYHbHiXrSS8d+Cn8i0uWxbZfEM+iNARwDlF2mb6L208wwTXlde+iSY/iYj3Awe1rR5VMKU1CWvAJRnK8k+hazN1/NHTuNiNcWj5NccJvttxk+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846425; c=relaxed/simple;
	bh=g8dd2+50g3C7ueh5H4s2zjV3Wsr7/07dzwZEEIIoxuw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M8n9Ml7UnAdNMLKSNmpxCM/ASQlUJPiYIwO3JU6ur1/VDmHc9XnPcxQvETequoBPjw2nHQWYMMGeYer7j8VGKFRxpoFXPbl/fDgynyvQl9hYNLYLyLHcumaNMbCmjZRxo0sLoE6quHUCM5I3EpnNdyiaGf7sz+R9f40jpT1fhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NDWNp4+h; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d80c77cf-c570-4f3b-960f-bbd2d0316fac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765846411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YPG5Go2q8EMKBcWnB1wvifkfYUqgU7NabtpWDLAxbY=;
	b=NDWNp4+h3Xg6nq8e0UBzasz1zD2mMYAandnw5dK2yB4d0MaUKgPhgJ9hSYlvDpjdPRS7CH
	ku0+HoHG66WzUMFPCBZCTNsG7ZUypLflgoHSbgnZVFmP6ewvimzodhvQvZYr225sGubzUg
	mAx4TM7m4YMOOCDupq1ZdNVmfkza55c=
Date: Mon, 15 Dec 2025 16:53:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] bpf: Disable -Wsuggest-attribute=format
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kernel test robot <lkp@intel.com>
References: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
 <982ded3a-a973-4c2e-ae7e-af01d346d582@linux.dev>
Content-Language: en-US
In-Reply-To: <982ded3a-a973-4c2e-ae7e-af01d346d582@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/15/25 4:11 PM, Ihor Solodrai wrote:
> On 12/10/25 5:12 AM, Andy Shevchenko wrote:
>> [...]
>> -obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
>> +obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o tnum.o log.o token.o liveness.o
>> +
>> +obj-$(CONFIG_BPF_SYSCALL) += helpers.o stream.o
>> +# The ____bpf_snprintf() uses the format string that triggers a compiler warning.
>> +CFLAGS_helpers.o += -Wno-suggest-attribute=format
>> +# The bpf_stream_vprintk_impl() uses the format string that triggers a compiler warning.
>> +CFLAGS_stream.o += -Wno-suggest-attribute=format
> 
> Hi Andy,
> 
> This flag does not exist in clang:
> 
> $ LLVM=1 make -j$(nproc) 
>   [...]
> $ LLVM=1 make
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   DESCEND bpf/resolve_btfids
>   INSTALL libsubcmd_headers
>   CC      kernel/trace/bpf_trace.o
> error: unknown warning option '-Wno-suggest-attribute=format'; did you mean '-Wno-property-attribute-mismatch'? [-Werror,-Wunknown-warning-option]
> make[4]: *** [scripts/Makefile.build:287: kernel/trace/bpf_trace.o] Error 1
> make[3]: *** [scripts/Makefile.build:556: kernel/trace] Error 2
> make[2]: *** [scripts/Makefile.build:556: kernel] Error 2
> make[1]: *** [/home/isolodrai/kernels/bpf-next/Makefile:2030: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> We should probably conditionalize the flag addition in the makefile.

Just confirmed that the patch below fixes LLVM=1 build:

From 842b31ff3384df65bb6f13763464daa03ba4f025 Mon Sep 17 00:00:00 2001
From: Ihor Solodrai <isolodrai@meta.com>
Date: Mon, 15 Dec 2025 16:45:19 -0800
Subject: [PATCH] bpf: Ensure CC is set to GCC for
 -Wno-suggest-attribute=format

LLVM=1 kernel build got broken because clang does not have
-Wno-suggest-attribute=format option.

Check for CONFIG_CC_IS_GCC before setting this option.

Fixes: ba34388912b5 ("bpf: Disable false positive -Wsuggest-attribute=format warning")
Closes: https://lore.kernel.org/bpf/20251210131234.3185985-1-andriy.shevchenko@linux.intel.com/
Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
---
 kernel/bpf/Makefile   | 2 ++
 kernel/trace/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index d7bcdb1fd35a..7a33c701e5fb 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -17,8 +17,10 @@ obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o
 # Disable incorrect warning. bpf printf-like helpers cannot use
 # gnu_printf attribute.
+ifeq ($(CONFIG_CC_IS_GCC),y)
 CFLAGS_helpers.o += -Wno-suggest-attribute=format
 CFLAGS_stream.o += -Wno-suggest-attribute=format
+endif
 ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
 obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
 endif
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 5869c1f1af89..06705d6fed2c 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -90,7 +90,9 @@ obj-$(CONFIG_USER_EVENTS) += trace_events_user.o
 obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
 # Disable incorrect warning. bpf printf-like helpers cannot use
 # gnu_printf attribute.
+ifeq ($(CONFIG_CC_IS_GCC),y)
 CFLAGS_bpf_trace.o += -Wno-suggest-attribute=format
+endif
 obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
 obj-$(CONFIG_TRACEPOINTS) += error_report-traces.o
 obj-$(CONFIG_TRACEPOINTS) += power-traces.o
-- 
2.47.3

> 
> Or better yet, address the root cause as suggested in the thread.
> 
> BPF CI is red on bpf branch at the moment:
> https://github.com/kernel-patches/bpf/actions/runs/20243520506/job/58144348281
> 
>>
>>  [...]
> 


