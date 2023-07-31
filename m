Return-Path: <bpf+bounces-6420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B6B768FA0
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523E128157D
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0203F8C0D;
	Mon, 31 Jul 2023 08:07:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9372117
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 08:07:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB711B8
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690790873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uSQ6W5Zoa0gBagmi/y4T86ZEvZFNbTljOVuJZIYMvgo=;
	b=Oajc7IVXCe++Pr6shKndVqFTG/wwjV+YHBpSPxvsUNQtkJ8FYjMDYV6/Tfi8Px4K53tVni
	hjpisVBAWw16gLm+YPyJB41cAAMOXnzR1SDGMS32el4hdMSkkDWRTTAqSivCtcaWuRoEoL
	aUeDdfTKWktjnhfGg+rbMJfa4kwcN1Y=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-2Wf4NzK3MCaTVosRuM4RZA-1; Mon, 31 Jul 2023 04:07:50 -0400
X-MC-Unique: 2Wf4NzK3MCaTVosRuM4RZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 508981C07248;
	Mon, 31 Jul 2023 08:07:50 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.194.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 72D7EC57964;
	Mon, 31 Jul 2023 08:07:49 +0000 (UTC)
From: Yauheni Kaliuta <ykaliuta@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,  andrii@kernel.org,  ast@kernel.org
Subject: Re: [PATCH bpf-next v2] tracing: perf_call_bpf: use struct
 trace_entry in struct syscall_tp_t
References: <33b93245-6740-e2e7-3a2a-6a9375d7ddc4@linux.dev>
	<20230728142740.483431-1-ykaliuta@redhat.com>
	<225ed430-dfd1-bf0b-8481-58f5f0d3f7eb@linux.dev>
Date: Mon, 31 Jul 2023 11:07:48 +0300
In-Reply-To: <225ed430-dfd1-bf0b-8481-58f5f0d3f7eb@linux.dev> (Yonghong Song's
	message of "Fri, 28 Jul 2023 09:44:20 -0700")
Message-ID: <xunytttky04r.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Yonghong!

>>>>> On Fri, 28 Jul 2023 09:44:20 -0700, Yonghong Song  wrote:

 > On 7/28/23 7:27 AM, Yauheni Kaliuta wrote:
 >> bpf tracepoint program uses struct trace_event_raw_sys_enter as
 >> argument where trace_entry is the first field. Use the same instead
 >> of unsigned long long since if it's amended (for example by RT
 >> patch) it accesses data with wrong offset.
 >> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
 >> ---
 >> v2:
 >> - remove extra BUILD_BUG_ON
 >> - add structure alignement
 >> ---
 >> kernel/trace/trace_syscalls.c | 12 ++++++++----
 >> 1 file changed, 8 insertions(+), 4 deletions(-)
 >> diff --git a/kernel/trace/trace_syscalls.c
 >> b/kernel/trace/trace_syscalls.c
 >> index 942ddbdace4a..b7139f8f4ce8 100644
 >> --- a/kernel/trace/trace_syscalls.c
 >> +++ b/kernel/trace/trace_syscalls.c
 >> @@ -555,12 +555,15 @@ static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_regs *re
 >> struct syscall_trace_enter *rec)
 >> {
 >> struct syscall_tp_t {
 >> -		unsigned long long regs;
 >> +		struct trace_entry ent;
 >> unsigned long syscall_nr;
 >> unsigned long args[SYSCALL_DEFINE_MAXARGS];
 >> -	} param;
 >> +	} __aligned(8) param;
 >> int i;
 >> +	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));

 > Considering we used 'unsigned long long regs' before, should
 > the above BUILD_BUG_ON should be
 > 	BUILD_BUG_ON(sizeof(param.ent) < sizeof(long long));
 > ?

Since the pointer's value is assigned I agree with Alexei (in the
thread [1]) to use void *.

 >> +
 >> +	/* __bpf_prog_run() requires *regs as the first parameter */

 > This comment is not correct.

 > static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 >                                           const void *ctx,
 >                                           bpf_dispatcher_fn dfunc)
 > {
 > 	...
 > }

 > The first parameter is 'prog'.

 > Also there is no __bpf_prog_run() referenced in this function
 > so this comment may confuse readers. So I suggest removing
 > this comment. The same for perf_call_bpf_exit() below.

Again, in [1] we agreed that it's better to have the comment
since it's even more confusing.

Could you help to formulate it?

"__bpf_prog_run() requires *regs as the first argument for bpf
prog" or something?

But yes, I can remove it of course.

 >> *(struct pt_regs **)&param = regs;
 >> param.syscall_nr = rec->nr;
 >> for (i = 0; i < sys_data->nb_args; i++)
 >> @@ -657,11 +660,12 @@ static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *reg
 >> struct syscall_trace_exit *rec)
 >> {
 >> struct syscall_tp_t {
 >> -		unsigned long long regs;
 >> +		struct trace_entry ent;
 >> unsigned long syscall_nr;
 >> unsigned long ret;
 >> -	} param;
 >> +	} __aligned(8) param;
 >> +	/* __bpf_prog_run() requires *regs as the first parameter */
 >> *(struct pt_regs **)&param = regs;
 >> param.syscall_nr = rec->nr;
 >> param.ret = rec->ret;


[1] https://lore.kernel.org/bpf/xunyjzy64q9b.fsf@redhat.com/T/#u

-- 
WBR,
Yauheni Kaliuta


