Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E307E3141CB
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 22:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhBHVaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 16:30:10 -0500
Received: from www62.your-server.de ([213.133.104.62]:40496 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhBHV3l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 16:29:41 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l9E5W-0002W8-0u; Mon, 08 Feb 2021 22:28:54 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l9E5V-000FHz-RT; Mon, 08 Feb 2021 22:28:53 +0100
Subject: Re: [PATCH v2 bpf-next 1/7] bpf: Optimize program stats
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     bpf@vger.kernel.org, kernel-team@fb.com
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
 <20210206170344.78399-2-alexei.starovoitov@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ae1b3d4b-59fd-4ad2-1e72-f9d987250757@iogearbox.net>
Date:   Mon, 8 Feb 2021 22:28:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210206170344.78399-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26074/Mon Feb  8 13:20:40 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/6/21 6:03 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Move bpf_prog_stats from prog->aux into prog to avoid one extra load
> in critical path of program execution.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   include/linux/bpf.h     |  8 --------
>   include/linux/filter.h  | 10 +++++++++-
>   kernel/bpf/core.c       |  8 ++++----
>   kernel/bpf/syscall.c    |  2 +-
>   kernel/bpf/trampoline.c |  2 +-
>   kernel/bpf/verifier.c   |  2 +-
>   6 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 321966fc35db..026fa8873c5d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -14,7 +14,6 @@
>   #include <linux/numa.h>
>   #include <linux/mm_types.h>
>   #include <linux/wait.h>
> -#include <linux/u64_stats_sync.h>
>   #include <linux/refcount.h>
>   #include <linux/mutex.h>
>   #include <linux/module.h>
> @@ -507,12 +506,6 @@ enum bpf_cgroup_storage_type {
>    */
>   #define MAX_BPF_FUNC_ARGS 12
>   
> -struct bpf_prog_stats {
> -	u64 cnt;
> -	u64 nsecs;
> -	struct u64_stats_sync syncp;
> -} __aligned(2 * sizeof(u64));
> -
>   struct btf_func_model {
>   	u8 ret_size;
>   	u8 nr_args;
> @@ -845,7 +838,6 @@ struct bpf_prog_aux {
>   	u32 linfo_idx;
>   	u32 num_exentries;
>   	struct exception_table_entry *extable;
> -	struct bpf_prog_stats __percpu *stats;
>   	union {
>   		struct work_struct work;
>   		struct rcu_head	rcu;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 5b3137d7b690..c6592590a0b7 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -22,6 +22,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/sockptr.h>
>   #include <crypto/sha1.h>
> +#include <linux/u64_stats_sync.h>
>   
>   #include <net/sch_generic.h>
>   
> @@ -539,6 +540,12 @@ struct bpf_binary_header {
>   	u8 image[] __aligned(BPF_IMAGE_ALIGNMENT);
>   };
>   
> +struct bpf_prog_stats {
> +	u64 cnt;
> +	u64 nsecs;
> +	struct u64_stats_sync syncp;
> +} __aligned(2 * sizeof(u64));
> +
>   struct bpf_prog {
>   	u16			pages;		/* Number of allocated pages */
>   	u16			jited:1,	/* Is our filter JIT'ed? */
> @@ -559,6 +566,7 @@ struct bpf_prog {
>   	u8			tag[BPF_TAG_SIZE];
>   	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
>   	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
> +	struct bpf_prog_stats __percpu *stats;
>   	unsigned int		(*bpf_func)(const void *ctx,
>   					    const struct bpf_insn *insn);

nit: could we move aux & orig_prog while at it behind bpf_func just to avoid it slipping
into next cacheline by accident when someone extends this again? (Or maybe build_bug_on
to enforce it being in first cacheline could also be an option.)

>   	/* Instructions for interpreter */
> @@ -581,7 +589,7 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
>   		struct bpf_prog_stats *__stats;				\
>   		u64 __start = sched_clock();				\
>   		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
> -		__stats = this_cpu_ptr(prog->aux->stats);		\
> +		__stats = this_cpu_ptr(prog->stats);			\
>   		u64_stats_update_begin(&__stats->syncp);		\
>   		__stats->cnt++;						\
>   		__stats->nsecs += sched_clock() - __start;		\
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5bbd4884ff7a..fa3da4cda476 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -114,8 +114,8 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
>   	if (!prog)
>   		return NULL;
>   
> -	prog->aux->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
> -	if (!prog->aux->stats) {
> +	prog->stats = alloc_percpu_gfp(struct bpf_prog_stats, gfp_flags);
> +	if (!prog->stats) {
>   		kfree(prog->aux);
>   		vfree(prog);
>   		return NULL;
> @@ -124,7 +124,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
>   	for_each_possible_cpu(cpu) {
>   		struct bpf_prog_stats *pstats;
>   
> -		pstats = per_cpu_ptr(prog->aux->stats, cpu);
> +		pstats = per_cpu_ptr(prog->stats, cpu);
>   		u64_stats_init(&pstats->syncp);
>   	}
>   	return prog;
> @@ -249,7 +249,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
>   	if (fp->aux) {
>   		mutex_destroy(&fp->aux->used_maps_mutex);
>   		mutex_destroy(&fp->aux->dst_mutex);
> -		free_percpu(fp->aux->stats);
> +		free_percpu(fp->stats);

This doesn't look correct, stats is now /not/ tied to fp->aux anymore which this if block
is taking care of freeing. It needs to be moved outside so we don't leak fp->stats.

>   		kfree(fp->aux->poke_tab);
>   		kfree(fp->aux);
>   	}
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e5999d86c76e..f7df56a704de 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1739,7 +1739,7 @@ static void bpf_prog_get_stats(const struct bpf_prog *prog,
>   		unsigned int start;
>   		u64 tnsecs, tcnt;
>   
> -		st = per_cpu_ptr(prog->aux->stats, cpu);
> +		st = per_cpu_ptr(prog->stats, cpu);
>   		do {
>   			start = u64_stats_fetch_begin_irq(&st->syncp);
>   			tnsecs = st->nsecs;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 35c5887d82ff..5be3beeedd74 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -412,7 +412,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
>   	     * Hence check that 'start' is not zero.
>   	     */
>   	    start) {
> -		stats = this_cpu_ptr(prog->aux->stats);
> +		stats = this_cpu_ptr(prog->stats);
>   		u64_stats_update_begin(&stats->syncp);
>   		stats->cnt++;
>   		stats->nsecs += sched_clock() - start;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 15694246f854..4189edb41b73 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10889,7 +10889,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>   		/* BPF_PROG_RUN doesn't call subprogs directly,
>   		 * hence main prog stats include the runtime of subprogs.
>   		 * subprogs don't have IDs and not reachable via prog_get_next_id
> -		 * func[i]->aux->stats will never be accessed and stays NULL
> +		 * func[i]->stats will never be accessed and stays NULL
>   		 */
>   		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
>   		if (!func[i])
> 

