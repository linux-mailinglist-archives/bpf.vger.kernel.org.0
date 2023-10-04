Return-Path: <bpf+bounces-11371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEA27B7FEF
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A2DE1281D4E
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953014267;
	Wed,  4 Oct 2023 12:56:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EC11C93
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 12:56:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45483A9
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696424158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zd7dDQrkdg8NYwSdUP30Izn8MjE92lW/tVkoCZd/bK0=;
	b=Q8s6jKiFPWeAK6SLbmLgorvbyePXbgBwa90b8KYr1oeO7cwDEoloxM23asUnkq5XTkx0mU
	9GwlYd4033Xly62hT7hYVkkq+GfvAN6DZwAAL9DVNf4MZafZu2FJQsHZjiT4V8eLtzUAgw
	/7/p6Nja25zNICGaj2DHi8+LF/tz1p0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-6a6H2pFoPvuCDR2JEXASjw-1; Wed, 04 Oct 2023 08:55:53 -0400
X-MC-Unique: 6a6H2pFoPvuCDR2JEXASjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DE4A380673C;
	Wed,  4 Oct 2023 12:55:52 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AE17B10EE402;
	Wed,  4 Oct 2023 12:55:50 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:55:47 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH] tracing: change syscall number type in struct
 syscall_trace_*
Message-ID: <20231004125547.GA409268@alecto.usersys.redhat.com>
References: <20231002135242.247536-1-asavkov@redhat.com>
 <20231003213844.1de0c138@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003213844.1de0c138@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 09:38:44PM -0400, Steven Rostedt wrote:
> On Mon,  2 Oct 2023 15:52:42 +0200
> Artem Savkov <asavkov@redhat.com> wrote:
> 
> > linux-rt-devel tree contains a patch that adds an extra member to struct
> > trace_entry. This causes the offset of args field in struct
> > trace_event_raw_sys_enter be different from the one in struct
> > syscall_trace_enter:
> 
> This patch looks like it's fixing the symptom and not the issue. No code
> should rely on the two event structures to be related. That's an unwanted
> coupling, that will likely cause issues down the road (like the RT patch
> you mentioned).

I agree, but I didn't see a better solution and that was my way of
starting conversation, thus the RFC.

> > 
> > struct trace_event_raw_sys_enter {
> >         struct trace_entry         ent;                  /*     0    12 */
> > 
> >         /* XXX last struct has 3 bytes of padding */
> >         /* XXX 4 bytes hole, try to pack */
> > 
> >         long int                   id;                   /*    16     8 */
> >         long unsigned int          args[6];              /*    24    48 */
> >         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> >         char                       __data[];             /*    72     0 */
> > 
> >         /* size: 72, cachelines: 2, members: 4 */
> >         /* sum members: 68, holes: 1, sum holes: 4 */
> >         /* paddings: 1, sum paddings: 3 */
> >         /* last cacheline: 8 bytes */
> > };
> > 
> > struct syscall_trace_enter {
> >         struct trace_entry         ent;                  /*     0    12 */
> > 
> >         /* XXX last struct has 3 bytes of padding */
> > 
> >         int                        nr;                   /*    12     4 */
> >         long unsigned int          args[];               /*    16     0 */
> > 
> >         /* size: 16, cachelines: 1, members: 3 */
> >         /* paddings: 1, sum paddings: 3 */
> >         /* last cacheline: 16 bytes */
> > };
> > 
> > This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
> > test_profiler testcase because max_ctx_offset is calculated based on the
> > former struct, while off on the latter:
> 
> The above appears to be pointing to the real bug. The "is calculated based
> on the former struct while off on the latter" Why are the two being used
> together? They are supposed to be *unrelated*!
> 
> 
> > 
> >   10488         if (is_tracepoint || is_syscall_tp) {
> >   10489                 int off = trace_event_get_offsets(event->tp_event);
> 
> So basically this is clumping together the raw_syscalls with the syscalls
> events as if they are the same. But the are not. They are created
> differently. It's basically like using one structure to get the offsets of
> another structure. That would be a bug anyplace else in the kernel. Sounds
> like it's a bug here too.
> 
> I think the issue is with this code, not the tracing code.
> 
> We could expose the struct syscall_trace_enter and syscall_trace_exit if
> the offsets to those are needed.

I don't think we need syscall_trace_* offsets, looks like
trace_event_get_offsets() should return offset trace_event_raw_sys_enter
instead. I am still trying to figure out how all of this works together.
Maybe Alexei or Andrii have more context here.

-- 
 Artem


