Return-Path: <bpf+bounces-11350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9F7B784F
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 09:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2DA92281C8D
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2C6FD4;
	Wed,  4 Oct 2023 07:03:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9963DC
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 07:03:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871CBAF
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696402987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDu6btx99QXs0kSLMHh2AKh2KZqG8BWNFgkrbgEVHdw=;
	b=fyWBgOfTQkDbZ1e6NNJtWVmBlXHDvQMx7Dc743WDQKMCy/25uejtDHLKRMF1hw3peo8Y/I
	jC6+kHlFU6uCOCVW2rUXJhh7/9fRoZ0vCx8Qr7rCRCI39YRh+bNXSf7K7bCd3Tb3PEUjpd
	p71jvCo7DO3Us/lXXiayysglyQPK08k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-uQEUgsEkNvisFnqZy2eq6Q-1; Wed, 04 Oct 2023 03:03:02 -0400
X-MC-Unique: uQEUgsEkNvisFnqZy2eq6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68D80382135E;
	Wed,  4 Oct 2023 07:03:01 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E9D2140E950;
	Wed,  4 Oct 2023 07:02:59 +0000 (UTC)
Date: Wed, 4 Oct 2023 09:02:57 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH] tracing: change syscall number type in struct
 syscall_trace_*
Message-ID: <20231004070257.GA311687@alecto.usersys.redhat.com>
References: <20231002135242.247536-1-asavkov@redhat.com>
 <CAEf4BzbM1z-ccRq-gH7UkVrSa6Vhewu3R7wV3sHW6BKxhm9k2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbM1z-ccRq-gH7UkVrSa6Vhewu3R7wV3sHW6BKxhm9k2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 03:11:15PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 2, 2023 at 6:53 AM Artem Savkov <asavkov@redhat.com> wrote:
> >
> > linux-rt-devel tree contains a patch that adds an extra member to struct
> 
> can you please point to the patch itself that makes that change?

Of course, some context would be useful. The patch in question is b1773eac3f29c
("sched: Add support for lazy preemption") from rt-devel tree [0]. It came up
a couple of times before: [1] [2] [3] [4].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=b1773eac3f29cbdcdfd16e0339f1a164066e9f71
[1] https://lore.kernel.org/linux-rt-users/20200221153541.681468-1-jolsa@kernel.org/t/#u
[2] https://github.com/iovisor/bpftrace/commit/a2e3d5dbc03ceb49b776cf5602d31896158844a7
[3] https://lore.kernel.org/bpf/xunyjzy64q9b.fsf@redhat.com/t/#u
[4] https://lore.kernel.org/bpf/20230727150647.397626-1-ykaliuta@redhat.com/t/#u

> > trace_entry. This causes the offset of args field in struct
> > trace_event_raw_sys_enter be different from the one in struct
> > syscall_trace_enter:
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
> >
> >   10488         if (is_tracepoint || is_syscall_tp) {
> >   10489                 int off = trace_event_get_offsets(event->tp_event);
> >   10490
> >   10491                 if (prog->aux->max_ctx_offset > off)
> >   10492                         return -EACCES;
> >   10493         }
> >
> > This patch changes the type of nr member in syscall_trace_* structs to
> > be long so that "args" offset is equal to that in struct
> > trace_event_raw_sys_enter.
> >
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > ---
> >  kernel/trace/trace.h          | 4 ++--
> >  kernel/trace/trace_syscalls.c | 7 ++++---
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 77debe53f07cf..cd1d24df85364 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -135,13 +135,13 @@ enum trace_type {
> >   */
> >  struct syscall_trace_enter {
> >         struct trace_entry      ent;
> > -       int                     nr;
> > +       long                    nr;
> >         unsigned long           args[];
> >  };
> >
> >  struct syscall_trace_exit {
> >         struct trace_entry      ent;
> > -       int                     nr;
> > +       long                    nr;
> >         long                    ret;
> >  };
> >
> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> > index de753403cdafb..c26939119f2e4 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -101,7 +101,7 @@ find_syscall_meta(unsigned long syscall)
> >         return NULL;
> >  }
> >
> > -static struct syscall_metadata *syscall_nr_to_meta(int nr)
> > +static struct syscall_metadata *syscall_nr_to_meta(long nr)
> >  {
> >         if (IS_ENABLED(CONFIG_HAVE_SPARSE_SYSCALL_NR))
> >                 return xa_load(&syscalls_metadata_sparse, (unsigned long)nr);
> > @@ -132,7 +132,8 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
> >         struct trace_entry *ent = iter->ent;
> >         struct syscall_trace_enter *trace;
> >         struct syscall_metadata *entry;
> > -       int i, syscall;
> > +       int i;
> > +       long syscall;
> >
> >         trace = (typeof(trace))ent;
> >         syscall = trace->nr;
> > @@ -177,7 +178,7 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
> >         struct trace_seq *s = &iter->seq;
> >         struct trace_entry *ent = iter->ent;
> >         struct syscall_trace_exit *trace;
> > -       int syscall;
> > +       long syscall;
> >         struct syscall_metadata *entry;
> >
> >         trace = (typeof(trace))ent;
> > --
> > 2.41.0
> >
> >
> 

-- 
 Artem


