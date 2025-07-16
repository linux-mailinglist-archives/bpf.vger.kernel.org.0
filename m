Return-Path: <bpf+bounces-63446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF4DB079D4
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C16F188E224
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B5245006;
	Wed, 16 Jul 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CM1TTu0F"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0D1ADC97
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679456; cv=none; b=dKW4QVKkM/Rq2U3cBSqsYrRw9DRYiKORZUmQfLZk74fCPedofuPpFEojCPhQgtWtC3dBTQ9YTJXs3M4p0wsO8m9RcSLt+v6pCWz6qIG5GpBSkCYJfUDoMJAuGXiLWSqoL8BKyZpZZGZKeEaDpc8U8sMetEScPUHFlqoxYQaMjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679456; c=relaxed/simple;
	bh=0fdoyK6vJqa1Pw1pbkER+5BhSUgIQU3RtL6LAGPeubs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgnaEbzpM/83wq3jTwzqKBUcRa6yQ+Hbjp3j0bq0x1DSBIJ6d724u0mmYycrxhfChsGtwzQ+UxRLDtRtNaB1M7lAFinqAjS/ng7Z50AFwcnj6H68JmquXQ9jRTeyGoZJuo+Zy6p6x//EyI8ASCq4C5U4+fXXU8E5kh8TSlXQiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CM1TTu0F; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b09a15b7-a57e-419f-8e78-28b5ef27ca86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752679450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3+kVpN3jTyEkRbDQ8IRvJB3MFw1lUbszjJIVvuCVSM=;
	b=CM1TTu0FD+QxnZiqawM9n8wCojjI4O1uGEGyr0PSTKSFsyKVoWXjJYJvAp84AUSagtV4Bt
	jMp8u/L6wv6L5UsN9A3mbNSJfSz6dHQPTzdkD1PA3hC8YDT4Fi3ysS665DxXOeZg5LCEn4
	vQbkTcBo8sMURLrU6a6jYk1fou75RO8=
Date: Wed, 16 Jul 2025 08:24:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: Fix macro redefined
Content-Language: en-GB
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716080616.1357793-1-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250716080616.1357793-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/16/25 1:06 AM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>
> When compiling a program that include <linux/bpf.h> and <bpf/bpf_helpers.h>, (For example: make samples/bpf)
> the following warning will be generated:
> In file included from tcp_dumpstats_kern.c:7:
> samples/bpf/libbpf/include/bpf/bpf_helpers.h:321:9: warning: 'bpf_stream_printk' macro redefined [-Wmacro-redefined]
>    321 | #define bpf_stream_printk(stream_id, fmt, args...)                              \
>        |         ^
> include/linux/bpf.h:3626:9: note: previous definition is here
>   3626 | #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
>        |         ^
>
> Therefore, similar to bpf_vprintk,
> two underscores are added to distinguish it from bpf_stream_printk in bpf.h.
>
> Fixes: 21a3afc76a31 ("libbpf: Add bpf_stream_printk() macro")
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>   tools/lib/bpf/bpf_helpers.h                | 2 +-
>   tools/testing/selftests/bpf/progs/stream.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 80c028540656..56391a7bee48 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -318,7 +318,7 @@ enum libbpf_tristate {
>   extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
>   			      __u32 len__sz, void *aux__prog) __weak __ksym;
>   
> -#define bpf_stream_printk(stream_id, fmt, args...)				\
> +#define __bpf_stream_printk(stream_id, fmt, args...)				\

I think we should not change here. If absolutely necessary, we should change
kernel side (which is not exposed to uapi). E.g., just remove this line
   #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
and directly use bpf_stream_stage_printk(&ss, ...)

The main reason is due to below in sample/bpf/Makefile:

$(obj)/%.o: $(src)/%.c
         @echo "  CLANG-bpf " $@
         $(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
                 -I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
                 -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
                 -D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
                 -D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
                 -Wno-gnu-variable-sized-type-not-at-end \
                 -Wno-address-of-packed-member -Wno-tautological-compare \
                 -Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
                 -fno-asynchronous-unwind-tables \
                 -I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
                 -O2 -emit-llvm -Xclang -disable-llvm-passes -c $< -o - | \
                 $(OPT) -O2 -mtriple=bpf-pc-linux | $(LLVM_DIS) | \
                 $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@

Here, some kernel data structure is needed for some particular architecture so
the initial from source to IR is compiled with native arch and after IR optimization
is done, it is switched to bpf.

Since we have vmlinux.h now. Maybe we can remove such a hack at all.
Also, sample/bpf is not really tested. Maybe trying to convert some
useful things to selftests and discard others and eventually remove sample/bpf?

>   ({										\
>   	static const char ___fmt[] = fmt;					\
>   	unsigned long long ___param[___bpf_narg(args)];				\
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
> index 35790897dc87..1d0663d56c0a 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -29,7 +29,7 @@ int stream_exhaust(void *ctx)
>   	/* Use global variable for loop convergence. */
>   	size = 0;
>   	bpf_repeat(BPF_MAX_LOOPS) {
> -		if (bpf_stream_printk(BPF_STDOUT, _STR) == -ENOSPC && size == 99954)
> +		if (__bpf_stream_printk(BPF_STDOUT, _STR) == -ENOSPC && size == 99954)
>   			return 0;
>   		size += sizeof(_STR) - 1;
>   	}
> @@ -72,7 +72,7 @@ SEC("syscall")
>   __success __retval(0)
>   int stream_syscall(void *ctx)
>   {
> -	bpf_stream_printk(BPF_STDOUT, "foo");
> +	__bpf_stream_printk(BPF_STDOUT, "foo");
>   	return 0;
>   }
>   


