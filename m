Return-Path: <bpf+bounces-2427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3C72CC00
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CAE281065
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426AB1B8FE;
	Mon, 12 Jun 2023 17:04:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5EA17AB7
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:04:19 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7FE0;
	Mon, 12 Jun 2023 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SEk2oG1exWilLsW4LKsvx0U7x1YxXGFcOLTdiLfMLYs=; b=nVfveCr4tjyjjGfnj5Oa1WEzMg
	ewhvrHkvj7t/91yelCB//j1zMkOgnODPX+wGcKaZAmfXBBGih1nByqLwH3Neqh4MMPu2SiRpMbL4B
	+0HnHkBHUS3m9LVag/zDKvxMupWvCEC0JiRtM5GtubX8DXLiSptZRADoOb2pDliYrHBY7oKerdkpI
	if0jcaAXhYfN30m2jAuUyWFiXn5pYa3Mh0vU0ZP6ehjBg9DiJcYMsE106BWf/lQ7zTLYvbqNfi4SF
	ff5zy1Nj8YzgmZl5p3CxLGrrclBUr9rDyvVSHcbz1pZcLIkjdz9GGxG0G4duIbhQiK+r/iZlgFuYm
	YYRcD53Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q8kxY-000Muz-6S; Mon, 12 Jun 2023 19:04:04 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q8kxX-0003Ok-Aa; Mon, 12 Jun 2023 19:04:03 +0200
Subject: Re: [PATCH 2/2] [v3] bpf: fix bpf_probe_read_kernel prototype
 mismatch
To: Arnd Bergmann <arnd@kernel.org>, Yonghong Song <yhs@meta.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Dave Marchevsky <davemarchevsky@fb.com>, Delyan Kratunov <delyank@fb.com>,
 Joanne Koong <joannelkoong@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230602135128.1498362-1-arnd@kernel.org>
 <20230602135128.1498362-2-arnd@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ac25cb0f-b804-1649-3afb-1dc6138c2716@iogearbox.net>
Date: Mon, 12 Jun 2023 19:04:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230602135128.1498362-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26937/Mon Jun 12 09:24:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/23 3:50 PM, Arnd Bergmann wrote:
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
> Change the core.c file to only reference the inner
> bpf_probe_read_kernel_common() helper and provide a prototype for that,
> to ensure this is compatible with both definitions.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry for the delay. I just took in patch 1/2, thanks!

Small comment below:

> --
> v3: clarify changelog text further.
> v2: rewrite completely to fix the mismatch.
> ---
>   include/linux/bpf.h      | 2 ++
>   kernel/bpf/core.c        | 9 ++++++---
>   kernel/trace/bpf_trace.c | 3 +--
>   3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830adae..55826398acfba 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2619,6 +2619,8 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
>   }
>   #endif /* CONFIG_BPF_SYSCALL */
>   
> +int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr);
> +
>   void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
>   			  struct btf_mod_pair *used_btfs, u32 len);
>   
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0926714641eb5..565ef6950c7a8 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -35,6 +35,7 @@
>   #include <linux/bpf_verifier.h>
>   #include <linux/nodemask.h>
>   #include <linux/nospec.h>
> +#include <linux/bpf.h>
>   #include <linux/bpf_mem_alloc.h>
>   #include <linux/memcontrol.h>
>   
> @@ -1635,11 +1636,13 @@ bool bpf_opcode_in_insntable(u8 code)
>   }
>   
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> -u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
> +#ifndef CONFIG_BPF_EVENTS
> +int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
>   {
>   	memset(dst, 0, size);
>   	return -EFAULT;
>   }
> +#endif
>   
>   /**
>    *	___bpf_prog_run - run eBPF program on a given context
> @@ -1931,8 +1934,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
> index 2bc41e6ac9fe0..290fdce2ce535 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -223,8 +223,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
>   	.arg3_type	= ARG_ANYTHING,
>   };
>   
> -static __always_inline int
> -bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
> +int bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
>   {
>   	int ret;

Given this is critical fast-path, please find a solution where we don't need
to penalize bpf_probe_read_kernel_common.

Thanks,
Daniel

