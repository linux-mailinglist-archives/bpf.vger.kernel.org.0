Return-Path: <bpf+bounces-12121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756C17C7D5E
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 08:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18B51C20A21
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6F6FAE;
	Fri, 13 Oct 2023 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1u6cRPX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403815691
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 06:01:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EABEBE
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697176903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uspCcCfbm2YmR5dZLZTo0epZzk54L6kfVVGxjNItAZs=;
	b=H1u6cRPXNGp1bzeyEQXh6MNW+bu/DY+e4cSNAd8jLh60QEFVQnc+o/2Hw6WFuqXJr3FqJ2
	hmeFmJbZUHunvkyCm8jpqBsW2lgz/tRfwRal7SdP7u0ElUaHieYAStn1fmmRd4PVbyWH37
	LJbATKFm52wT7tN1m0B1TRBsLvMzmWg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-QZR-wY5EOF-cukCasi9NeQ-1; Fri, 13 Oct 2023 02:01:39 -0400
X-MC-Unique: QZR-wY5EOF-cukCasi9NeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38EC73813BCD;
	Fri, 13 Oct 2023 06:01:38 +0000 (UTC)
Received: from wtfbox.lan (unknown [10.45.224.87])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 620D81C060DF;
	Fri, 13 Oct 2023 06:01:36 +0000 (UTC)
Date: Fri, 13 Oct 2023 08:01:34 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in
 struct syscall_tp_t
Message-ID: <ZSjdPqQiPdqa-UTs@wtfbox.lan>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
 <20231012114550.152846-1-asavkov@redhat.com>
 <20231012094444.0967fa79@gandalf.local.home>
 <CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 04:32:51PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 12, 2023 at 6:43 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 12 Oct 2023 13:45:50 +0200
> > Artem Savkov <asavkov@redhat.com> wrote:
> >
> > > linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add support
> > > for lazy preemption")) that adds an extra member to struct trace_entry.
> > > This causes the offset of args field in struct trace_event_raw_sys_enter
> > > be different from the one in struct syscall_trace_enter:
> > >
> > > struct trace_event_raw_sys_enter {
> > >         struct trace_entry         ent;                  /*     0    12 */
> > >
> > >         /* XXX last struct has 3 bytes of padding */
> > >         /* XXX 4 bytes hole, try to pack */
> > >
> > >         long int                   id;                   /*    16     8 */
> > >         long unsigned int          args[6];              /*    24    48 */
> > >         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> > >         char                       __data[];             /*    72     0 */
> > >
> > >         /* size: 72, cachelines: 2, members: 4 */
> > >         /* sum members: 68, holes: 1, sum holes: 4 */
> > >         /* paddings: 1, sum paddings: 3 */
> > >         /* last cacheline: 8 bytes */
> > > };
> > >
> > > struct syscall_trace_enter {
> > >         struct trace_entry         ent;                  /*     0    12 */
> > >
> > >         /* XXX last struct has 3 bytes of padding */
> > >
> > >         int                        nr;                   /*    12     4 */
> > >         long unsigned int          args[];               /*    16     0 */
> > >
> > >         /* size: 16, cachelines: 1, members: 3 */
> > >         /* paddings: 1, sum paddings: 3 */
> > >         /* last cacheline: 16 bytes */
> > > };
> > >
> > > This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
> > > test_profiler testcase because max_ctx_offset is calculated based on the
> > > former struct, while off on the latter:
> > >
> > >   10488         if (is_tracepoint || is_syscall_tp) {
> > >   10489                 int off = trace_event_get_offsets(event->tp_event);
> > >   10490
> > >   10491                 if (prog->aux->max_ctx_offset > off)
> > >   10492                         return -EACCES;
> > >   10493         }
> > >
> > > What bpf program is actually getting is a pointer to struct
> > > syscall_tp_t, defined in kernel/trace/trace_syscalls.c. This patch fixes
> > > the problem by aligning struct syscall_tp_t with with struct
> > > syscall_trace_(enter|exit) and changing the tests to use these structs
> > > to dereference context.
> > >
> > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> >
> 
> I think these changes make sense regardless, can you please resend the
> patch without RFC tag so that our CI can run tests for it?

Ok, didn't know it was set up like that.

> > Thanks for doing a proper fix.
> >
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> But looking at [0] and briefly reading some of the discussions you,
> Steven, had. I'm just wondering if it would be best to avoid
> increasing struct trace_entry altogether? It seems like preempt_count
> is actually a 4-bit field in trace context, so it doesn't seem like we
> really need to allocate an entire byte for both preempt_count and
> preempt_lazy_count. Why can't we just combine them and not waste 8
> extra bytes for each trace event in a ring buffer?
> 
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=b1773eac3f29cbdcdfd16e0339f1a164066e9f71

I agree that avoiding increase in struct trace_entry size would be very
desirable, but I have no knowledge whether rt developers had reasons to
do it like this.

Nevertheless I think the issue with verifier running against a wrong
struct still needs to be addressed.

-- 
Regards,
  Artem


