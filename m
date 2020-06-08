Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F91F1DA1
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgFHQnc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 12:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgFHQnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 12:43:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C719206A4;
        Mon,  8 Jun 2020 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591634609;
        bh=poD2j79xftnkyVeVqoS2PoHl9GnQGkmyzAxMsg36dZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYbrOqLb/OiVLfd+eqEBq2dpFNz9zufzclJoTzUwBuF+KtJ/aHIWVtkCt9rzLFqK6
         rzfGZbkoKpBcMLo53KgKfHWkSvH+pdJDxjJ1T0bxjAuEw9Pz3mR3JBi7rPXAUzaSGb
         FqpkMqdRXxKCnVGk2fm0tAoY7yK5UhxhVniAfrEw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B29540AFD; Mon,  8 Jun 2020 13:43:27 -0300 (-03)
Date:   Mon, 8 Jun 2020 13:43:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        jolsa@redhat.com, tmricht@linux.ibm.com, heiko.carstens@de.ibm.com,
        mhiramat@kernel.org, iii@linux.ibm.com
Subject: Re: [PATCH] perf: Fix bpf prologue generation, user attribute access
 in kprobes
Message-ID: <20200608164327.GD3073@kernel.org>
References: <20200604091028.101569-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604091028.101569-1-sumanthk@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 04, 2020 at 11:10:28AM +0200, Sumanth Korikkar escreveu:
> Issues:
> 1. bpf_probe_read is no longer available for architecture which has
>    overlapping address space. Hence bpf prologue generation fails
> 2. perf probe -a 'do_sched_setscheduler  pid policy
>    param->sched_priority@user' did not work before.

This looks super nice, thanks for working on this!

But please split this into multiple patches, one for the 'perf probe'
part, add the Acked-by provided by Masami to that one, and the other for
the part fixing the lack of bpf_probe_read(), ok?

Thanks!

- Arnaldo
 
> Fixes:
> 1. Use bpf_probe_read_kernel for kernel member access. For user
>    attribute access in kprobes, bpf_probe_read_user is utilized
> 2. Make (perf probe -a 'do_sched_setscheduler  pid policy
>    param->sched_priority@user') output equivalent to ftrace
>    ('p:probe/do_sched_setscheduler _text+517384 pid=%r2:s32
>    policy=%r3:s32 sched_priority=+u0 (%r4):s32' > kprobe_events)
> 
> Other:
> 1. Right now, __match_glob() does not handle [u]<offset>. For now, use
>   *u]<offset>.
> 2. @user attribute was introduced in commit 1e032f7cfa14 ("perf-probe:
>    Add user memory access attribute support")
> 
> Test:
> 1. ulimit -l 128 ; ./perf record -e tests/bpf_sched_setscheduler.c
> 2. cat tests/bpf_sched_setscheduler.c
> 
> static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
>         (void *) 6;
> static int (*bpf_probe_read_user)(void *dst, __u32 size,
>                                   const void *unsafe_ptr) = (void *) 112;
> static int (*bpf_probe_read_kernel)(void *dst, __u32 size,
>         const void *unsafe_ptr) = (void *) 113;
> 
> SEC("func=do_sched_setscheduler  pid policy param->sched_priority@user")
> int bpf_func__setscheduler(void *ctx, int err, pid_t pid, int policy,
>                            int param)
> {
>         char fmt[] = "prio: %ld";
>         bpf_trace_printk(fmt, sizeof(fmt), param);
>         return 1;
> }
> 
> char _license[] SEC("license") = "GPL";
> int _version SEC("version") = LINUX_VERSION_CODE;
> 
> 3. ./perf script
>    sched 305669 [000] 1614458.838675: perf_bpf_probe:func: (2904e508)
>    pid=261614 policy=2 sched_priority=1
> 
> 4. cat /sys/kernel/debug/tracing/trace
>    <...>-309956 [006] .... 1616098.093957: 0: prio: 1
> 
> 5. bpf_probe_read_user is used when @user attribute is used. Otherwise,
>    defaults to bpf_probe_read_kernel
> 
> 6. ./perf test bpf (null_lseek - kernel member access)
> 42: BPF filter                                            :
> 42.1: Basic BPF filtering                                 : Ok
> 42.2: BPF pinning                                         : Ok
> 42.3: BPF prologue generation                             : Ok
> 42.4: BPF relocation checker                              : FAILED!
> 
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/bpf-prologue.c | 14 ++++++++++----
>  tools/perf/util/probe-event.c  |  7 +++++--
>  tools/perf/util/probe-file.c   |  2 +-
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
> index b020a8678eb9..9887ae09242d 100644
> --- a/tools/perf/util/bpf-prologue.c
> +++ b/tools/perf/util/bpf-prologue.c
> @@ -142,7 +142,8 @@ static int
>  gen_read_mem(struct bpf_insn_pos *pos,
>  	     int src_base_addr_reg,
>  	     int dst_addr_reg,
> -	     long offset)
> +	     long offset,
> +	     int probeid)
>  {
>  	/* mov arg3, src_base_addr_reg */
>  	if (src_base_addr_reg != BPF_REG_ARG3)
> @@ -159,7 +160,7 @@ gen_read_mem(struct bpf_insn_pos *pos,
>  		ins(BPF_MOV64_REG(BPF_REG_ARG1, dst_addr_reg), pos);
>  
>  	/* Call probe_read  */
> -	ins(BPF_EMIT_CALL(BPF_FUNC_probe_read), pos);
> +	ins(BPF_EMIT_CALL(probeid), pos);
>  	/*
>  	 * Error processing: if read fail, goto error code,
>  	 * will be relocated. Target should be the start of
> @@ -241,7 +242,7 @@ static int
>  gen_prologue_slowpath(struct bpf_insn_pos *pos,
>  		      struct probe_trace_arg *args, int nargs)
>  {
> -	int err, i;
> +	int err, i, probeid;
>  
>  	for (i = 0; i < nargs; i++) {
>  		struct probe_trace_arg *arg = &args[i];
> @@ -276,11 +277,16 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
>  				stack_offset), pos);
>  
>  		ref = arg->ref;
> +		probeid = BPF_FUNC_probe_read_kernel;
>  		while (ref) {
>  			pr_debug("prologue: arg %d: offset %ld\n",
>  				 i, ref->offset);
> +
> +			if (ref->user_access)
> +				probeid = BPF_FUNC_probe_read_user;
> +
>  			err = gen_read_mem(pos, BPF_REG_3, BPF_REG_7,
> -					   ref->offset);
> +					   ref->offset, probeid);
>  			if (err) {
>  				pr_err("prologue: failed to generate probe_read function call\n");
>  				goto errout;
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index eea132f512b0..7cdb66ef3baa 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1565,7 +1565,7 @@ static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
>  	}
>  
>  	tmp = strchr(str, '@');
> -	if (tmp && tmp != str && strcmp(tmp + 1, "user")) { /* user attr */
> +	if (tmp && tmp != str && !strcmp(tmp + 1, "user")) { /* user attr */
>  		if (!user_access_is_supported()) {
>  			semantic_error("ftrace does not support user access\n");
>  			return -EINVAL;
> @@ -1986,7 +1986,10 @@ static int __synthesize_probe_trace_arg_ref(struct probe_trace_arg_ref *ref,
>  		if (depth < 0)
>  			return depth;
>  	}
> -	err = strbuf_addf(buf, "%+ld(", ref->offset);
> +	if (ref->user_access)
> +		err = strbuf_addf(buf, "%s%ld(", "+u", ref->offset);
> +	else
> +		err = strbuf_addf(buf, "%+ld(", ref->offset);
>  	return (err < 0) ? err : depth;
>  }
>  
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 8c852948513e..064b63a6a3f3 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -1044,7 +1044,7 @@ static struct {
>  	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
>  	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
>  	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
> -	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
> +	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*u]<offset>*"),
>  	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
>  	DEFINE_TYPE(FTRACE_README_IMMEDIATE_VALUE, "*\\imm-value,*"),
>  };
> -- 
> 2.25.4
> 

-- 

- Arnaldo
