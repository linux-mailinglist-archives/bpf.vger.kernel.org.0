Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221B33E4F6B
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 00:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhHIWnf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 18:43:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:55048 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhHIWnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 18:43:33 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDDzB-0006Gr-ED; Tue, 10 Aug 2021 00:43:09 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDDzB-000Exo-8D; Tue, 10 Aug 2021 00:43:09 +0200
Subject: Re: [PATCH v3 bpf-next 01/14] bpf: refactor BPF_PROG_RUN into a
 function
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
 <20210730053413.1090371-2-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <21246244-fa7e-700f-e767-3f9edf9e4c19@iogearbox.net>
Date:   Tue, 10 Aug 2021 00:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210730053413.1090371-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26258/Mon Aug  9 10:18:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/30/21 7:34 AM, Andrii Nakryiko wrote:
> Turn BPF_PROG_RUN into a proper always inlined function. No functional and
> performance changes are intended, but it makes it much easier to understand
> what's going on with how BPF programs are actually get executed. It's more
> obvious what types and callbacks are expected. Also extra () around input
> parameters can be dropped, as well as `__` variable prefixes intended to avoid
> naming collisions, which makes the code simpler to read and write.
> 
> This refactoring also highlighted one possible issue. BPF_PROG_RUN is both
> a macro and an enum value (BPF_PROG_RUN == BPF_PROG_TEST_RUN). Turning
> BPF_PROG_RUN into a function causes naming conflict compilation error. So
> rename BPF_PROG_RUN into lower-case bpf_prog_run(), similar to
> bpf_prog_run_xdp(), bpf_prog_run_pin_on_cpu(), etc. To avoid unnecessary code
> churn across many networking calls to BPF_PROG_RUN, #define BPF_PROG_RUN as an
> alias to bpf_prog_run.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Change itself looks good, small nit below:

> ---
>   include/linux/filter.h | 58 +++++++++++++++++++++++++++---------------
>   1 file changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index ba36989f711a..18518e321ce4 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -585,25 +585,41 @@ struct sk_filter {
>   
>   DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>   
> -#define __BPF_PROG_RUN(prog, ctx, dfunc)	({			\
> -	u32 __ret;							\
> -	cant_migrate();							\
> -	if (static_branch_unlikely(&bpf_stats_enabled_key)) {		\
> -		struct bpf_prog_stats *__stats;				\
> -		u64 __start = sched_clock();				\
> -		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
> -		__stats = this_cpu_ptr(prog->stats);			\
> -		u64_stats_update_begin(&__stats->syncp);		\
> -		__stats->cnt++;						\
> -		__stats->nsecs += sched_clock() - __start;		\
> -		u64_stats_update_end(&__stats->syncp);			\
> -	} else {							\
> -		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
> -	}								\
> -	__ret; })
> -
> -#define BPF_PROG_RUN(prog, ctx)						\
> -	__BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func)
> +typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
> +					  const struct bpf_insn *insnsi,
> +					  unsigned int (*bpf_func)(const void *,
> +								   const struct bpf_insn *));
> +
> +static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> +					  const void *ctx,
> +					  bpf_dispatcher_fn dfunc)
> +{
> +	u32 ret;
> +
> +	cant_migrate();
> +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
> +		struct bpf_prog_stats *stats;
> +		u64 start = sched_clock();
> +
> +		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> +		stats = this_cpu_ptr(prog->stats);
> +		u64_stats_update_begin(&stats->syncp);
> +		stats->cnt++;
> +		stats->nsecs += sched_clock() - start;
> +		u64_stats_update_end(&stats->syncp);
> +	} else {
> +		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> +	}
> +	return ret;
> +}
> +
> +static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog, const void *ctx)
> +{
> +	return __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
> +}
> +
> +/* avoids name conflict with BPF_PROG_RUN enum definedi uapi/linux/bpf.h */

(definedi)

> +#define BPF_PROG_RUN bpf_prog_run

Given the unfortunate conflict in BPF_PROG_RUN, can't we just toss the BPF_PROG_RUN to
bpf_prog_run altogether and bite the bullet once to remove it from the tree? (Same as the
other macro names in next patch.) There are a number of instances, but still to the extend
that it should be doable.

>   /*
>    * Use in preemptible and therefore migratable context to make sure that
> @@ -622,7 +638,7 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
>   	u32 ret;
>   
>   	migrate_disable();
> -	ret = __BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func);
> +	ret = bpf_prog_run(prog, ctx);
>   	migrate_enable();
>   	return ret;
>   }
> @@ -768,7 +784,7 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
>   	 * under local_bh_disable(), which provides the needed RCU protection
>   	 * for accessing map entries.
>   	 */
> -	return __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
> +	return __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
>   }
>   
>   void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog);
> 

