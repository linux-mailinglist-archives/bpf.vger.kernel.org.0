Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25873E4FFD
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 01:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhHIXbO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 19:31:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:36060 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhHIXbO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 19:31:14 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDEjL-0009y9-SO; Tue, 10 Aug 2021 01:30:51 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDEjL-000PKg-Kk; Tue, 10 Aug 2021 01:30:51 +0200
Subject: Re: [PATCH v3 bpf-next 05/14] bpf: allow to specify user-provided
 bpf_cookie for BPF perf links
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
 <20210730053413.1090371-6-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5e026f3e-d94a-b8b0-8564-e16b73d6bbcc@iogearbox.net>
Date:   Tue, 10 Aug 2021 01:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210730053413.1090371-6-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26258/Mon Aug  9 10:18:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/30/21 7:34 AM, Andrii Nakryiko wrote:
> Add ability for users to specify custom u64 value (bpf_cookie) when creating
> BPF link for perf_event-backed BPF programs (kprobe/uprobe, perf_event,
> tracepoints).
> 
> This is useful for cases when the same BPF program is used for attaching and
> processing invocation of different tracepoints/kprobes/uprobes in a generic
> fashion, but such that each invocation is distinguished from each other (e.g.,
> BPF program can look up additional information associated with a specific
> kernel function without having to rely on function IP lookups). This enables
> new use cases to be implemented simply and efficiently that previously were
> possible only through code generation (and thus multiple instances of almost
> identical BPF program) or compilation at runtime (BCC-style) on target hosts
> (even more expensive resource-wise). For uprobes it is not even possible in
> some cases to know function IP before hand (e.g., when attaching to shared
> library without PID filtering, in which case base load address is not known
> for a library).
> 
> This is done by storing u64 bpf_cookie in struct bpf_prog_array_item,
> corresponding to each attached and run BPF program. Given cgroup BPF programs
> already use two 8-byte pointers for their needs and cgroup BPF programs don't
> have (yet?) support for bpf_cookie, reuse that space through union of
> cgroup_storage and new bpf_cookie field.
> 
> Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
> This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
> program execution code, which luckily is now also split from
> BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
> giving access to this user-provided cookie value from inside a BPF program.
> Generic perf_event BPF programs will access this value from perf_event itself
> through passed in BPF program context.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[...]
>   
> +struct bpf_trace_run_ctx {
> +	struct bpf_run_ctx run_ctx;
> +	u64 bpf_cookie;
> +};
> +
>   #ifdef CONFIG_BPF_SYSCALL
>   static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
>   {
> @@ -1247,6 +1256,8 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
>   	const struct bpf_prog_array_item *item;
>   	const struct bpf_prog *prog;
>   	const struct bpf_prog_array *array;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_trace_run_ctx run_ctx;
>   	u32 ret = 1;
>   
>   	migrate_disable();
> @@ -1254,11 +1265,14 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
>   	array = rcu_dereference(array_rcu);
>   	if (unlikely(!array))
>   		goto out;
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>   	item = &array->items[0];
>   	while ((prog = READ_ONCE(item->prog))) {
> +		run_ctx.bpf_cookie = item->bpf_cookie;
>   		ret &= run_prog(prog, ctx);
>   		item++;
>   	}
> +	bpf_reset_run_ctx(old_run_ctx);
>   out:
>   	rcu_read_unlock();
>   	migrate_enable();
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2d510ad750ed..fe156a8170aa 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -762,6 +762,7 @@ struct perf_event {
>   #ifdef CONFIG_BPF_SYSCALL
>   	perf_overflow_handler_t		orig_overflow_handler;
>   	struct bpf_prog			*prog;
> +	u64				bpf_cookie;
>   #endif
>   
>   #ifdef CONFIG_EVENT_TRACING
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 8ac92560d3a3..8e0631a4b046 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -675,7 +675,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
>   
>   #ifdef CONFIG_BPF_EVENTS
>   unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
> -int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> +int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
>   void perf_event_detach_bpf_prog(struct perf_event *event);
>   int perf_event_query_prog_array(struct perf_event *event, void __user *info);
>   int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
> @@ -692,7 +692,7 @@ static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *c
>   }
>   
>   static inline int
> -perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog)
> +perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie)
>   {
>   	return -EOPNOTSUPP;
>   }
> @@ -803,7 +803,7 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
>   void perf_trace_buf_update(void *record, u16 type);
>   void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
>   
> -int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
>   void perf_event_free_bpf_prog(struct perf_event *event);
>   
>   void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 94fe8329b28f..63ee482d50e1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1448,6 +1448,13 @@ union bpf_attr {
>   				__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
>   				__u32		iter_info_len;	/* iter_info length */
>   			};
> +			struct {
> +				/* black box user-provided value passed through
> +				 * to BPF program at the execution time and
> +				 * accessible through bpf_get_attach_cookie() BPF helper
> +				 */
> +				__u64		bpf_cookie;

 From API PoV, should we just name this link_id to avoid confusion around gen_cookie_next()
users? Do we expect other link types to implement similar mechanism? I'd think probably yes
if the prog would be common and e.g. do htab lookups based on that opaque value.

Is the 8b chosen given function IP fits, or is there a different rationale size-wise? Should
this be of dynamic size to be more future proof, e.g. hidden map like in prog's global sections
that libbpf sets up / prepopulates internally, but tied to link object instead?

> +			} perf_event;
>   		};
>   	} link_create;
>   
Thanks,
Daniel
