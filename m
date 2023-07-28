Return-Path: <bpf+bounces-6185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BCF7669B2
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB01C21843
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C011196;
	Fri, 28 Jul 2023 10:03:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009CD300
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 10:03:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794871FF5
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690538585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vZv9+FlKmE7Vh0kL6CAyZx9KLR01Jb2NTkoTJTS194=;
	b=dwqVp0Zua1qNEiRV1V+pV8lhmr5Qqw2BYFPOeoC2blrMGLlPYr+41fpn6y0kEz7X6ThEvg
	aIJ2LtZXULeO5/yeoH07Om0o2U9YRwpoNLznXtJcuFmHoYjtLlCouKlG7n4M+W627IkiAp
	l//VpCgLiqsSEdfSA3zRkAXFUwgmde8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-5Pxqcpb4O2O3-npDAU0RvA-1; Fri, 28 Jul 2023 06:03:02 -0400
X-MC-Unique: 5Pxqcpb4O2O3-npDAU0RvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D10E5881B25;
	Fri, 28 Jul 2023 10:03:01 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.194.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B33E72166B25;
	Fri, 28 Jul 2023 10:03:00 +0000 (UTC)
From: Yauheni Kaliuta <ykaliuta@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,  andrii@kernel.org,  ast@kernel.org
Subject: Re: [PATCH bpf-next] tracing: perf_call_bpf: use struct trace_entry
 in struct syscall_tp_t
References: <20230727150647.397626-1-ykaliuta@redhat.com>
	<33b93245-6740-e2e7-3a2a-6a9375d7ddc4@linux.dev>
Date: Fri, 28 Jul 2023 13:02:58 +0300
In-Reply-To: <33b93245-6740-e2e7-3a2a-6a9375d7ddc4@linux.dev> (Yonghong Song's
	message of "Thu, 27 Jul 2023 10:37:10 -0700")
Message-ID: <xunyzg3gxsj1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Yonghong!

>>>>> On Thu, 27 Jul 2023 10:37:10 -0700, Yonghong Song  wrote:

 > On 7/27/23 8:06 AM, Yauheni Kaliuta wrote:
 >> bpf tracepoint program uses struct trace_event_raw_sys_enter as
 >> argument where trace_entry is the first field. Use the same instead
 >> of unsigned long long since if it's amended (for example by RT
 >> patch) it accesses data with wrong offset.

 > Is this 'amended by RT patch' a real thing?

Yes for me.

>> Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
 >> ---
 >> kernel/trace/trace_syscalls.c | 10 ++++++++--
 >> 1 file changed, 8 insertions(+), 2 deletions(-)
 >> diff --git a/kernel/trace/trace_syscalls.c
 >> b/kernel/trace/trace_syscalls.c
 >> index 942ddbdace4a..07f4fa395e99 100644
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
 >> } param;

 > I suspect we may have issues for 32bit kernel.
 > In 32bit kernel, with the change, the alignment for
 > param could be 4. That means, the 'ctx' pointer
 > may have an alignment 4 for bpf program, if user
 > tries to do ctx->regs, which will be a mis-aligned
 > access and it may not work for all architectures.

well, will __aligned(8) save the world?

 >> int i;
 >> +	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
 >> +
 >> +	/* __bpf_prog_run() requires *regs as the first parameter */
 >> *(struct pt_regs **)&param = regs;
 >> param.syscall_nr = rec->nr;
 >> for (i = 0; i < sys_data->nb_args; i++)
 >> @@ -657,11 +660,14 @@ static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_regs *reg
 >> struct syscall_trace_exit *rec)
 >> {
 >> struct syscall_tp_t {
 >> -		unsigned long long regs;
 >> +		struct trace_entry ent;
 >> unsigned long syscall_nr;
 >> unsigned long ret;
 >> } param;
 >> +	BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));

 > You already have BUILD_BUG_ON in perf_call_enter. There is no need
 > to have another one here.

Oh yes, thanks  :)

 >> +
 >> +	/* __bpf_prog_run() requires *regs as the first parameter */
 >> *(struct pt_regs **)&param = regs;
 >> param.syscall_nr = rec->nr;
 >> param.ret = rec->ret;


-- 
WBR,
Yauheni Kaliuta


