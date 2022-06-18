Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6855061E
	for <lists+bpf@lfdr.de>; Sat, 18 Jun 2022 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiFRQbp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Jun 2022 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiFRQbo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Jun 2022 12:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F089C12767;
        Sat, 18 Jun 2022 09:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87CB160F0C;
        Sat, 18 Jun 2022 16:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE232C3411A;
        Sat, 18 Jun 2022 16:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655569902;
        bh=26jE2uXz7Qy0ouBoZd/MG6kDUODEbjwsPVOfy5Rn33U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/JL2qcn4Y4ykRH/mIy2DLOvKHGwN1grE8aLIidEdzoENnwp06Lwi6DbRtes/jhOn
         VNKMV1r+VWgLQlhMHuAI5ohexBKGWZXgdGmVDVsamXSY4CPKAnOV1Lt5UidGC4Mlv9
         mLMeBD3RdGXagLapbSIFcEsKCvaG4aCRDz+oALKEvSC5tugA2LMN7hbhmyi4bgdLO+
         B4nEKsdvzYopZcWKf7NzCXhU7Cvmk+TF3UzqW6kBFnj1SCrMhFXmBaKTdzsx13FpMt
         Go9mHwz1RY6YxRgBnMfWb5qkwHJHoNFIYvr8c7TcP01WiGov389Aw/C6FqQKPmgaFK
         peYUzV4er3uKA==
Date:   Sun, 19 Jun 2022 01:31:37 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 1/1] perf/kprobe: maxactive for fd-based kprobe
Message-Id: <20220619013137.6d10a232246be482a5c0db82@kernel.org>
In-Reply-To: <20220615211559.7856-1-9erthalion6@gmail.com>
References: <20220615211559.7856-1-9erthalion6@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 15 Jun 2022 23:15:59 +0200
Dmitrii Dolgov <9erthalion6@gmail.com> wrote:

> From: Song Liu <songliubraving@fb.com>
> 
> Enable specifying maxactive for fd based kretprobe. This will be useful
> for tracing tools like bcc and bpftrace (see for example discussion [1]).
> Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.

I'm not sure what environment you are considering to use this
feature, but is 4095 enough, and are you really need to specify
the maxactive by linear digit?
I mean you may need the logarithm of maxactive? In this case, you
only need 4 bits for 2 - 65546 (1 = 2^0 will be used for the default
value). 

Thank you,

> 
> The original patch [2] seems to be fallen through the cracks and wasn't
> applied. I've merely rebased the work done by Song Liu and verififed it
> still works.
> 
> Note that changes in rethook implementation may render maxactive
> obsolete.
> 
> [1]: https://github.com/iovisor/bpftrace/issues/835
> [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Changes in v3:
>     - Set correct author
> 
> Changes in v2:
>     - Fix comment about number bits for the offset
> 
>  include/linux/trace_events.h    |  3 ++-
>  kernel/events/core.c            | 20 ++++++++++++++++----
>  kernel/trace/trace_event_perf.c |  5 +++--
>  kernel/trace/trace_kprobe.c     |  4 ++--
>  kernel/trace/trace_probe.h      |  2 +-
>  5 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index e6e95a9f07a5..7ca453a73252 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -850,7 +850,8 @@ extern void perf_trace_destroy(struct perf_event *event);
>  extern int  perf_trace_add(struct perf_event *event, int flags);
>  extern void perf_trace_del(struct perf_event *event, int flags);
>  #ifdef CONFIG_KPROBE_EVENTS
> -extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe);
> +extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe,
> +			     int max_active);
>  extern void perf_kprobe_destroy(struct perf_event *event);
>  extern int bpf_get_kprobe_info(const struct perf_event *event,
>  			       u32 *fd_type, const char **symbol,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 23bb19716ad3..e8127f9b4df5 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9809,24 +9809,34 @@ static struct pmu perf_tracepoint = {
>   * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
>   *                               if not set, create kprobe/uprobe
>   *
> - * The following values specify a reference counter (or semaphore in the
> - * terminology of tools like dtrace, systemtap, etc.) Userspace Statically
> - * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
> + * PERF_UPROBE_REF_CTR_OFFSET_* specify a reference counter (or semaphore
> + * in the terminology of tools like dtrace, systemtap, etc.) Userspace
> + * Statically Defined Tracepoints (USDT). Currently, we use 32 bit for the
> + * offset.
>   *
>   * PERF_UPROBE_REF_CTR_OFFSET_BITS	# of bits in config as th offset
>   * PERF_UPROBE_REF_CTR_OFFSET_SHIFT	# of bits to shift left
> + *
> + * PERF_KPROBE_MAX_ACTIVE_* defines max_active for kretprobe.
> + * KRETPROBE_MAXACTIVE_MAX is 4096. We allow 4095 here to save a bit.
>   */
>  enum perf_probe_config {
>  	PERF_PROBE_CONFIG_IS_RETPROBE = 1U << 0,  /* [k,u]retprobe */
>  	PERF_UPROBE_REF_CTR_OFFSET_BITS = 32,
>  	PERF_UPROBE_REF_CTR_OFFSET_SHIFT = 64 - PERF_UPROBE_REF_CTR_OFFSET_BITS,
> +	PERF_KPROBE_MAX_ACTIVE_BITS = 12,
> +	PERF_KPROBE_MAX_ACTIVE_SHIFT = 64 - PERF_KPROBE_MAX_ACTIVE_BITS,
>  };
>  
>  PMU_FORMAT_ATTR(retprobe, "config:0");
>  #endif
>  
>  #ifdef CONFIG_KPROBE_EVENTS
> +/* KRETPROBE_MAXACTIVE_MAX is 4096, only allow 4095 here to save a bit */
> +PMU_FORMAT_ATTR(max_active, "config:52-63");
> +
>  static struct attribute *kprobe_attrs[] = {
> +	&format_attr_max_active.attr,
>  	&format_attr_retprobe.attr,
>  	NULL,
>  };
> @@ -9857,6 +9867,7 @@ static int perf_kprobe_event_init(struct perf_event *event)
>  {
>  	int err;
>  	bool is_retprobe;
> +	int max_active;
>  
>  	if (event->attr.type != perf_kprobe.type)
>  		return -ENOENT;
> @@ -9871,7 +9882,8 @@ static int perf_kprobe_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
> -	err = perf_kprobe_init(event, is_retprobe);
> +	max_active = event->attr.config >> PERF_KPROBE_MAX_ACTIVE_SHIFT;
> +	err = perf_kprobe_init(event, is_retprobe, max_active);
>  	if (err)
>  		return err;
>  
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a114549720d6..129000327809 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -245,7 +245,8 @@ void perf_trace_destroy(struct perf_event *p_event)
>  }
>  
>  #ifdef CONFIG_KPROBE_EVENTS
> -int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
> +int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe,
> +					 int max_active)
>  {
>  	int ret;
>  	char *func = NULL;
> @@ -271,7 +272,7 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
>  
>  	tp_event = create_local_trace_kprobe(
>  		func, (void *)(unsigned long)(p_event->attr.kprobe_addr),
> -		p_event->attr.probe_offset, is_retprobe);
> +		p_event->attr.probe_offset, is_retprobe, max_active);
>  	if (IS_ERR(tp_event)) {
>  		ret = PTR_ERR(tp_event);
>  		goto out;
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 47cebef78532..3ad30cfce9c3 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1784,7 +1784,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
>  /* create a trace_kprobe, but don't add it to global lists */
>  struct trace_event_call *
>  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> -			  bool is_return)
> +			  bool is_return, int max_active)
>  {
>  	enum probe_print_type ptype;
>  	struct trace_kprobe *tk;
> @@ -1799,7 +1799,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	event = func ? func : "DUMMY_EVENT";
>  
>  	tk = alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event, (void *)addr, func,
> -				offs, 0 /* maxactive */, 0 /* nargs */,
> +				offs, max_active, 0 /* nargs */,
>  				is_return);
>  
>  	if (IS_ERR(tk)) {
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 92cc149af0fd..26fe21980793 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -376,7 +376,7 @@ extern int traceprobe_set_print_fmt(struct trace_probe *tp, enum probe_print_typ
>  #ifdef CONFIG_PERF_EVENTS
>  extern struct trace_event_call *
>  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> -			  bool is_return);
> +			  bool is_return, int max_active);
>  extern void destroy_local_trace_kprobe(struct trace_event_call *event_call);
>  
>  extern struct trace_event_call *
> -- 
> 2.32.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
