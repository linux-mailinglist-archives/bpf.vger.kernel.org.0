Return-Path: <bpf+bounces-51064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E6EA2FE26
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2503A50B1
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839425D539;
	Mon, 10 Feb 2025 23:05:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2B259487;
	Mon, 10 Feb 2025 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228727; cv=none; b=OV7b7hFPd7+WZEfME8Z2183wH4bkBYCo3V+3a3hhQPDZR1+y86fEFd7R9J46MS6ktqlmxhS2PQ0QLgdkU9YvwhwL8bzEHbmVu5fzGo3ycpfmc5c9tLv8mgffC7dmvB7iRm1LWyTy/TZ8xRV/VJXssCU/+xB7XzMczSNE1fqm7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228727; c=relaxed/simple;
	bh=8L0eOoa57DQYzqthF2KJubMJik6qRQp8eVAjf9JUQkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byyHpjwWVDVxTgXUa67A+4KtFhihmsP5vupdjsJZQKdK3Qk+6PmeV/GZD3ogCcE1v85JkvYMSXKBSZITtNnQm3Xrxfp0V3vuVRCTeVIArkUbbuFUG/1Ot4/rG6hFsKze9mCpqkYrMDhv+L5M5caS8duuCaUcAd6qfojKG3xtZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10343C4CED1;
	Mon, 10 Feb 2025 23:05:24 +0000 (UTC)
Date: Mon, 10 Feb 2025 18:05:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, x86@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 dongml2@chinatelecom.cn, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH] x86: add function metadata support
Message-ID: <20250210180528.01118537@gandalf.local.home>
In-Reply-To: <20250210104034.146273-1-dongml2@chinatelecom.cn>
References: <20250210104034.146273-1-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 18:40:34 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> With CONFIG_CALL_PADDING enabled, there will be 16-bytes(or more) padding
> space before all the kernel functions. And some kernel features can use
> it, such as MITIGATION_CALL_DEPTH_TRACKING, CFI_CLANG, FINEIBT, etc.

Please start your change log off with why you are doing this. Then you can
go into the details of what you are doing.

Explain what and how kernel features can use this.

> 
> In this commit, we add supporting to store per-function metadata in the

Don't ever say "In this commit" in a change long. We know this is a commit.
The above can be written like:

"Support per-function metadata storage.." Although that should be after you
explain why this is being submitted.

> function padding, and previous discussion can be found in [1]. Generally
> speaking, we have two way to implement this feature:
> 
> 1. create a function metadata array, and prepend a 5-bytes insn
> "mov %eax, 0x12345678", and store the insn to the function padding.
> And 0x12345678 means the index of the function metadata in the array.
> By this way, 5-bytes will be consumed in the function padding.
> 
> 2. prepend a 10-bytes insn "mov %rax, 0x12345678aabbccdd" and store
> the insn to the function padding, and 0x12345678aabbccdd means the address
> of the function metadata.
> 
> Compared with way 2, way 1 consume less space, but we need to do more work
> on the global function metadata array. And in this commit, we implemented
> the way 1.
> 
> In my research, MITIGATION_CALL_DEPTH_TRACKING will consume the tail
> 9-bytes in the function padding, and FINEIBT+CFI_CLANG will consume
> the head 7-bytes. So there will be no space for us if
> MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are both enabled. So I have
> following logic:
> 1. use the head 5-bytes if CFI_CLANG is not enabled
> 2. use the tail 5-bytes if MITIGATION_CALL_DEPTH_TRACKING is not enabled
> 3. compile the kernel with extra 5-bytes padding if
>    MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are both enabled.
> 
> In the third case, we compile the kernel with a function padding of
> 21-bytes, which means the real function is not 16-bytes aligned any more.
> And in [2], I tested the performance of the kernel with different padding,
> and it seems that extra 5-bytes don't have impact on the performance.
> However, it's a huge change to make the kernel function unaligned in
> 16-bytes, and I'm sure if there are any other influence. So another choice
> is to compile the kernel with 32-bytes aligned if there is no space
> available for us in the function padding. But this will increase the text
> size ~5%. (And I'm not sure with method to use.)
> 
> The beneficiaries of this feature can be BPF and ftrace. For BPF, we can
> implement a "dynamic trampoline" and add tracing multi-link supporting
> base on this feature. And for ftrace, we can optimize its performance
> base on this feature.
> 
> This commit is not complete, as the synchronous of func_metas is not
> considered :/
> 
> Link: https://lore.kernel.org/bpf/CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/bpf/CADxym3af+CU5Mx8myB8UowdXSc3wJOqWyH4oyq+eXKahXBTXyg@mail.gmail.com/ [2]
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/x86/Kconfig          |  15 ++++
>  arch/x86/Makefile         |  17 ++--
>  include/linux/func_meta.h |  17 ++++
>  kernel/trace/Makefile     |   1 +
>  kernel/trace/func_meta.c  | 184 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 228 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/func_meta.h
>  create mode 100644 kernel/trace/func_meta.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 6df7779ed6da..0ff3cb74cfc0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2510,6 +2510,21 @@ config PREFIX_SYMBOLS
>  	def_bool y
>  	depends on CALL_PADDING && !CFI_CLANG
>  
> +config FUNCTION_METADATA
> +	bool "Enable function metadata support"
> +	select CALL_PADDING
> +	default y
> +	help
> +	  This feature allow us to set metadata for kernel functions, and

Who's "us"?

> +	  get the metadata of the function by its address without any
> +	  costing.
> +
> +	  The index of the metadata will be stored in the function padding,
> +	  which will consume 5-bytes. The spare space of the padding
> +	  is enough for us with CALL_PADDING and FUNCTION_ALIGNMENT_16B if
> +	  CALL_THUNKS or CFI_CLANG not enabled. Or, we need extra 5-bytes
> +	  in the function padding, which will increases text ~1%.
> +
>  menuconfig CPU_MITIGATIONS
>  	bool "Mitigations for CPU vulnerabilities"
>  	default y
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 5b773b34768d..05689c9a8942 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -240,13 +240,18 @@ ifdef CONFIG_MITIGATION_SLS
>  endif
>  
>  ifdef CONFIG_CALL_PADDING
> -PADDING_CFLAGS := -fpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
> -KBUILD_CFLAGS += $(PADDING_CFLAGS)
> -export PADDING_CFLAGS
> +  __padding_bytes := $(CONFIG_FUNCTION_PADDING_BYTES)
> +  ifneq ($(and $(CONFIG_FUNCTION_METADATA),$(CONFIG_CALL_THUNKS),$(CONFIG_CFI_CLANG)),)
> +    __padding_bytes := $(shell echo $(__padding_bytes) + 5 | bc)
> +  endif
> +
> +  PADDING_CFLAGS := -fpatchable-function-entry=$(__padding_bytes),$(__padding_bytes)
> +  KBUILD_CFLAGS += $(PADDING_CFLAGS)
> +  export PADDING_CFLAGS

Arm64 and other archs add meta data before the functions too. Can we have
an effort to perhaps share these methods?

>  
> -PADDING_RUSTFLAGS := -Zpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
> -KBUILD_RUSTFLAGS += $(PADDING_RUSTFLAGS)
> -export PADDING_RUSTFLAGS
> +  PADDING_RUSTFLAGS := -Zpatchable-function-entry=$(__padding_bytes),$(__padding_bytes)
> +  KBUILD_RUSTFLAGS += $(PADDING_RUSTFLAGS)
> +  export PADDING_RUSTFLAGS
>  endif
>  
>  KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
> diff --git a/include/linux/func_meta.h b/include/linux/func_meta.h
> new file mode 100644
> index 000000000000..840cbd858c47
> --- /dev/null
> +++ b/include/linux/func_meta.h

If this is x86 only, why is this in generic code?

> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_FUNC_META_H
> +#define _LINUX_FUNC_META_H
> +
> +#include <linux/kernel.h>
> +
> +struct func_meta {
> +	int users;
> +	void *func;
> +};
> +
> +extern struct func_meta *func_metas;
> +
> +struct func_meta *func_meta_get(void *ip);
> +void func_meta_put(void *ip, struct func_meta *meta);
> +
> +#endif
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 057cd975d014..4042c168dcfc 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile

Same here.

> @@ -106,6 +106,7 @@ obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
>  obj-$(CONFIG_FPROBE) += fprobe.o
>  obj-$(CONFIG_RETHOOK) += rethook.o
>  obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
> +obj-$(CONFIG_FUNCTION_METADATA) += func_meta.o
>  
>  obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
>  obj-$(CONFIG_RV) += rv/
> diff --git a/kernel/trace/func_meta.c b/kernel/trace/func_meta.c
> new file mode 100644
> index 000000000000..9ce77da81e71
> --- /dev/null
> +++ b/kernel/trace/func_meta.c

Unless this file will support arm64 meta data and other architectures
besides x86, then it should not be in the kernel/trace directory.

-- Steve


> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/slab.h>
> +#include <linux/memory.h>
> +#include <linux/func_meta.h>
> +#include <linux/text-patching.h>
> +

