Return-Path: <bpf+bounces-781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759AA706B13
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA691C20F69
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3B31137;
	Wed, 17 May 2023 14:27:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037231128
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8431DC433EF;
	Wed, 17 May 2023 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684333678;
	bh=AoRYpT1YLThZVxUKY9ePgVwDgIFfFF9PtIMUgbNxJyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WUNzXiJRJbiyKq9aqV065F7GO6DlSJst8wqq9ksE45jev/z5BNZjACDIsU+CKWd2p
	 YgjGdckmgkxBOYGmqbO/Q7DmiNaGJvtGLhQQtz66t4NP/id+Uo0xu+RUnqZF6ypu4X
	 FFZtvKjWpBheV7AQNhVpo1Hp4lfMZ0AfY5VaaItM8xbTSl5SojwEZIseT1QiWOyUeJ
	 LeYUIrL2ez1oYq8e4XSBAeTn2ReJaBV8RZFEYpvmNI4OQI6b//O81nIMFwAGKKM2qy
	 d5iS608w4+1IOEz2k6JrXrTWYbS3l4RsjV0WCQ9ODtU1E64QoYkryjNgQo+2XTUAyC
	 R+33bZ4yB6rVg==
Date: Wed, 17 May 2023 23:27:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 x86@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>, Ze Gao
 <zegao@tencent.com>
Subject: Re: [PATCH v3 2/4] fprobe: make fprobe_kprobe_handler recursion
 free
Message-Id: <20230517232751.09126a6cec8786a954e54bcf@kernel.org>
In-Reply-To: <20230517034510.15639-3-zegao@tencent.com>
References: <20230517034510.15639-1-zegao@tencent.com>
	<20230517034510.15639-3-zegao@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 May 2023 11:45:07 +0800
Ze Gao <zegao2021@gmail.com> wrote:

> Current implementation calls kprobe related functions before doing
> ftrace recursion check in fprobe_kprobe_handler, which opens door
> to kernel crash due to stack recursion if preempt_count_{add, sub}
> is traceable in kprobe_busy_{begin, end}.
> 
> Things goes like this without this patch quoted from Steven:
> "
> fprobe_kprobe_handler() {
>    kprobe_busy_begin() {
>       preempt_disable() {
>          preempt_count_add() {  <-- trace
>             fprobe_kprobe_handler() {
> 		[ wash, rinse, repeat, CRASH!!! ]
> "
> 
> By refactoring the common part out of fprobe_kprobe_handler and
> fprobe_handler and call ftrace recursion detection at the very beginning,
> the whole fprobe_kprobe_handler is free from recursion.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Link: https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-3-zegao@tencent.com
> ---
>  kernel/trace/fprobe.c | 59 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 9abb3905bc8e..097c740799ba 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
>  	char data[];
>  };
>  
> -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> -			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +static inline void __fprobe_handler(unsigned long ip, unsigned long
> +		parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fregs)

OK, I picked up this series to probes/fixes. Note that I fixed this line 
because the "unsigned long parent_ip" was split into 2 lines.

Thank you,


>  {
>  	struct fprobe_rethook_node *fpr;
>  	struct rethook_node *rh = NULL;
>  	struct fprobe *fp;
>  	void *entry_data = NULL;
> -	int bit, ret;
> +	int ret;
>  
>  	fp = container_of(ops, struct fprobe, ops);
> -	if (fprobe_disabled(fp))
> -		return;
> -
> -	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> -	if (bit < 0) {
> -		fp->nmissed++;
> -		return;
> -	}
>  
>  	if (fp->exit_handler) {
>  		rh = rethook_try_get(fp->rethook);
>  		if (!rh) {
>  			fp->nmissed++;
> -			goto out;
> +			return;
>  		}
>  		fpr = container_of(rh, struct fprobe_rethook_node, node);
>  		fpr->entry_ip = ip;
> @@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  		else
>  			rethook_hook(rh, ftrace_get_regs(fregs), true);
>  	}
> -out:
> +}
> +
> +static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> +		struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct fprobe *fp;
> +	int bit;
> +
> +	fp = container_of(ops, struct fprobe, ops);
> +	if (fprobe_disabled(fp))
> +		return;
> +
> +	/* recursion detection has to go before any traceable function and
> +	 * all functions before this point should be marked as notrace
> +	 */
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0) {
> +		fp->nmissed++;
> +		return;
> +	}
> +	__fprobe_handler(ip, parent_ip, ops, fregs);
>  	ftrace_test_recursion_unlock(bit);
> +
>  }
>  NOKPROBE_SYMBOL(fprobe_handler);
>  
>  static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
>  				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> -	struct fprobe *fp = container_of(ops, struct fprobe, ops);
> +	struct fprobe *fp;
> +	int bit;
> +
> +	fp = container_of(ops, struct fprobe, ops);
> +	if (fprobe_disabled(fp))
> +		return;
> +
> +	/* recursion detection has to go before any traceable function and
> +	 * all functions called before this point should be marked as notrace
> +	 */
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0) {
> +		fp->nmissed++;
> +		return;
> +	}
>  
>  	if (unlikely(kprobe_running())) {
>  		fp->nmissed++;
>  		return;
>  	}
> +
>  	kprobe_busy_begin();
> -	fprobe_handler(ip, parent_ip, ops, fregs);
> +	__fprobe_handler(ip, parent_ip, ops, fregs);
>  	kprobe_busy_end();
> +	ftrace_test_recursion_unlock(bit);
>  }
>  
>  static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

