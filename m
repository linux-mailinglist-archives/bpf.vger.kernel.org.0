Return-Path: <bpf+bounces-6096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F4765A86
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 19:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D611C2163D
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2FCD2F2;
	Thu, 27 Jul 2023 17:37:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D72715A
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 17:37:19 +0000 (UTC)
Received: from out-126.mta0.migadu.com (out-126.mta0.migadu.com [91.218.175.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09C02D75
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 10:37:17 -0700 (PDT)
Message-ID: <33b93245-6740-e2e7-3a2a-6a9375d7ddc4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690479435; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmYcv7Y5/PHxPdb/zk2/s1dYvUUXpuRKM+86zdFbkwE=;
	b=VWRx8rNU2ROnaauFQkcCHq/OifSe31EudaAxSaLfN/7qCCAItjVZ5d2pv+m97PTIezrQyH
	XeVV2O0+WhvvI4aCV1YFLv+8z8Ia/mYkBnhpFmOYDP2wxGRRs73ckE0aYgH7mu1NHFRBto
	UQN7f4RJH1rc9CMBsJ3ymu5XSAxXcq0=
Date: Thu, 27 Jul 2023 10:37:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] tracing: perf_call_bpf: use struct trace_entry
 in struct syscall_tp_t
Content-Language: en-US
To: Yauheni Kaliuta <ykaliuta@redhat.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org
References: <20230727150647.397626-1-ykaliuta@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230727150647.397626-1-ykaliuta@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 8:06 AM, Yauheni Kaliuta wrote:
> bpf tracepoint program uses struct trace_event_raw_sys_enter as
> argument where trace_entry is the first field. Use the same instead
> of unsigned long long since if it's amended (for example by RT
> patch) it accesses data with wrong offset.

Is this 'amended by RT patch' a real thing?

> 
> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
> ---
>   kernel/trace/trace_syscalls.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 942ddbdace4a..07f4fa395e99 100644
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
>   	} param;

I suspect we may have issues for 32bit kernel.
In 32bit kernel, with the change, the alignment for
param could be 4. That means, the 'ctx' pointer
may have an alignment 4 for bpf program, if user
tries to do ctx->regs, which will be a mis-aligned
access and it may not work for all architectures.

>   	int i;
>   
> +	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
> +
> +	/* __bpf_prog_run() requires *regs as the first parameter */
>   	*(struct pt_regs **)&param = regs;
>   	param.syscall_nr = rec->nr;
>   	for (i = 0; i < sys_data->nb_args; i++)
> @@ -657,11 +660,14 @@ static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *reg
>   			      struct syscall_trace_exit *rec)
>   {
>   	struct syscall_tp_t {
> -		unsigned long long regs;
> +		struct trace_entry ent;
>   		unsigned long syscall_nr;
>   		unsigned long ret;
>   	} param;
>   
> +	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));

You already have BUILD_BUG_ON in perf_call_enter. There is no need
to have another one here.

> +
> +	/* __bpf_prog_run() requires *regs as the first parameter */
>   	*(struct pt_regs **)&param = regs;
>   	param.syscall_nr = rec->nr;
>   	param.ret = rec->ret;

