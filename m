Return-Path: <bpf+bounces-6153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4990D7662A2
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 05:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03644282620
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8DA441B;
	Fri, 28 Jul 2023 03:52:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9917EC
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 03:52:37 +0000 (UTC)
Received: from out-76.mta0.migadu.com (out-76.mta0.migadu.com [91.218.175.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F72D45
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 20:52:35 -0700 (PDT)
Message-ID: <8a7a1960-1678-6949-b4e0-b3621d31ea9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690516352; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xca0fbgynp4YpJaFG42+C3Unmv24xUnm5jqMs1cBm6w=;
	b=LYdWv563hDZrLdby8OHTM5QHEQmjOD/RWvRdZDmjqcpaD6ZOLSF+tRrqoMQluZ8orDYG+q
	5wyXyc6GlUAV6nEvUZ8/m+nmW4HQYgWCWxXhaqKWE8wI2YTxyMeR3Pfkgag6xVkXPe2zVa
	+Ly0IEXTX4DSRu88z6M7P4Y0OHH4G5Y=
Date: Thu, 27 Jul 2023 20:52:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH] [v4] bpf: fix bpf_probe_read_kernel prototype mismatch
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Dave Marchevsky <davemarchevsky@fb.com>, David Vernet <void@manifault.com>,
 Kees Cook <keescook@chromium.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230725204149.3411961-1-arnd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230725204149.3411961-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/25/23 1:41 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bpf_probe_read_kernel() has a __weak definition in core.c and another
> definition with an incompatible prototype in kernel/trace/bpf_trace.c,
> when CONFIG_BPF_EVENTS is enabled.
> 
> Since the two are incompatible, there cannot be a shared declaration in
> a header file, but the lack of a prototype causes a W=1 warning:
> 
> kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]
> 
> On 32-bit architectures, the local prototype
> 
> u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
> 
> passes arguments in other registers as the one in bpf_trace.c
> 
> BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
>              const void *, unsafe_ptr)
> 
> which uses 64-bit arguments in pairs of registers.
> 
> As both versions of the function are fairly simple and only really
> differ in one line, just move them into a header file as an inline
> function that does not add any overhead for the bpf_trace.c callers
> and actually avoids a function call for the other one.
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/ac25cb0f-b804-1649-3afb-1dc6138c2716@iogearbox.net/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM but there are some additional changes in kernel so you need to
rebase on top of master branch with the following additional change:

@@ -2082,7 +2076,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct 
bpf_insn *insn)
                 DST = *(SIZE *)(unsigned long) (SRC + insn->off);       \
                 CONT;                                                   \
         LDX_PROBE_MEMSX_##SIZEOP:                                       \
-               bpf_probe_read_kernel(&DST, sizeof(SIZE),               \
+               bpf_probe_read_kernel_common(&DST, sizeof(SIZE), 
        \
                                       (const void *)(long) (SRC + 
insn->off));  \
                 DST = *((SIZE *)&DST);                                  \
                 CONT;

Thanks!

> --
> v4: rewrite again to use a shared inline helper
> v3: clarify changelog text further.
> v2: rewrite completely to fix the mismatch.
> ---
>   include/linux/bpf.h      | 12 ++++++++++++
>   kernel/bpf/core.c        | 10 ++--------
>   kernel/trace/bpf_trace.c | 11 -----------
>   3 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ceaa8c23287fc..abe75063630b8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2661,6 +2661,18 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
>   }
>   #endif /* CONFIG_BPF_SYSCALL */
>   
> +static __always_inline int
> +bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
> +{
> +	int ret = -EFAULT;
> +
> +	if (IS_ENABLED(CONFIG_BPF_EVENTS))
> +		ret = copy_from_kernel_nofault(dst, unsafe_ptr, size);
> +	if (unlikely(ret < 0))
> +		memset(dst, 0, size);
> +	return ret;
> +}
> +
>   void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
>   			  struct btf_mod_pair *used_btfs, u32 len);
>   
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index dd70c58c9d3a3..9cdf53bfb8bd3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1634,12 +1634,6 @@ bool bpf_opcode_in_insntable(u8 code)
>   }
>   
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> -u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
> -{
> -	memset(dst, 0, size);
> -	return -EFAULT;
> -}
> -
>   /**
>    *	___bpf_prog_run - run eBPF program on a given context
>    *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> @@ -1930,8 +1924,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
>   		CONT;							\
>   	LDX_PROBE_MEM_##SIZEOP:						\
> -		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
> -				      (const void *)(long) (SRC + insn->off));	\
> +		bpf_probe_read_kernel_common(&DST, sizeof(SIZE),	\
> +			      (const void *)(long) (SRC + insn->off));	\
>   		DST = *((SIZE *)&DST);					\
>   		CONT;
>   
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c92eb8c6ff08d..83bde2475ae54 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -223,17 +223,6 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
>   	.arg3_type	= ARG_ANYTHING,
>   };
>   
> -static __always_inline int
> -bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
> -{
> -	int ret;
> -
> -	ret = copy_from_kernel_nofault(dst, unsafe_ptr, size);
> -	if (unlikely(ret < 0))
> -		memset(dst, 0, size);
> -	return ret;
> -}
> -
>   BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
>   	   const void *, unsafe_ptr)
>   {

