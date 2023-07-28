Return-Path: <bpf+bounces-6223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB176724B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337E02822CE
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335E14AA6;
	Fri, 28 Jul 2023 16:45:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B812B95
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:45:10 +0000 (UTC)
Received: from out-71.mta1.migadu.com (out-71.mta1.migadu.com [IPv6:2001:41d0:203:375::47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352AD59F3
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:44:49 -0700 (PDT)
Message-ID: <225ed430-dfd1-bf0b-8481-58f5f0d3f7eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690562664; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lysOf4A1ERFgF/RuVLfp3N4io1lWmxNURi9aE3vz+c=;
	b=Wb6PiXv7ZWop5+B/U+ldJtQbi/Xd3cIGCIAQltefL7zb2jRv6S/Il5MykP492GsABSClQd
	UAjAy2/1K+v5DbZzMXY13hGcXW6i/nq456Oy0Pmb0tFzi9te/D+9y8URvww1hRlWgVMFox
	ZuAPOIOcOPFOo9ZOOwGMlntxduevmXM=
Date: Fri, 28 Jul 2023 09:44:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2] tracing: perf_call_bpf: use struct
 trace_entry in struct syscall_tp_t
Content-Language: en-US
To: Yauheni Kaliuta <ykaliuta@redhat.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org
References: <33b93245-6740-e2e7-3a2a-6a9375d7ddc4@linux.dev>
 <20230728142740.483431-1-ykaliuta@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230728142740.483431-1-ykaliuta@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/23 7:27 AM, Yauheni Kaliuta wrote:
> bpf tracepoint program uses struct trace_event_raw_sys_enter as
> argument where trace_entry is the first field. Use the same instead
> of unsigned long long since if it's amended (for example by RT
> patch) it accesses data with wrong offset.
> 
> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
> ---
> v2:
> - remove extra BUILD_BUG_ON
> - add structure alignement
> 
> ---
>   kernel/trace/trace_syscalls.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 942ddbdace4a..b7139f8f4ce8 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -555,12 +555,15 @@ static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *re
>   			       struct syscall_trace_enter *rec)
>   {
>   	struct syscall_tp_t {
> -		unsigned long long regs;
> +		struct trace_entry ent;
>   		unsigned long syscall_nr;
>   		unsigned long args[SYSCALL_DEFINE_MAXARGS];
> -	} param;
> +	} __aligned(8) param;
>   	int i;
>   
> +	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));

Considering we used 'unsigned long long regs' before, should
the above BUILD_BUG_ON should be
	BUILD_BUG_ON(sizeof(param.ent) < sizeof(long long));
?

> +
> +	/* __bpf_prog_run() requires *regs as the first parameter */

This comment is not correct.

static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
                                           const void *ctx,
                                           bpf_dispatcher_fn dfunc)
{
	...
}

The first parameter is 'prog'.

Also there is no __bpf_prog_run() referenced in this function
so this comment may confuse readers. So I suggest removing
this comment. The same for perf_call_bpf_exit() below.

>   	*(struct pt_regs **)&param = regs;
>   	param.syscall_nr = rec->nr;
>   	for (i = 0; i < sys_data->nb_args; i++)
> @@ -657,11 +660,12 @@ static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *reg
>   			      struct syscall_trace_exit *rec)
>   {
>   	struct syscall_tp_t {
> -		unsigned long long regs;
> +		struct trace_entry ent;
>   		unsigned long syscall_nr;
>   		unsigned long ret;
> -	} param;
> +	} __aligned(8) param;
>   
> +	/* __bpf_prog_run() requires *regs as the first parameter */
>   	*(struct pt_regs **)&param = regs;
>   	param.syscall_nr = rec->nr;
>   	param.ret = rec->ret;

