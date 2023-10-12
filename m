Return-Path: <bpf+bounces-12101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2567C7A77
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 01:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B95B20976
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 23:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096A2B5EC;
	Thu, 12 Oct 2023 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlyQ8TTK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFEF3D03E;
	Thu, 12 Oct 2023 23:33:06 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DCEA9;
	Thu, 12 Oct 2023 16:33:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so1047136a12.2;
        Thu, 12 Oct 2023 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697153583; x=1697758383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naelrzab06bC9MMj4BGYD3OPqUStfN/T5v5pDuFLbLk=;
        b=dlyQ8TTKBsiPgdtUU8mgHMtGCQhTsCDGjcC5ztMpBg8aWlPcEXhKFCxYAcRS/xbSGC
         /KiHZafSMUXB+jaf4AEbXtfKo9GS+ndS0hStSCIAXISRDB6/UIhPwKt9ejxPA/OawkFZ
         rf/X2CToDLl65xYUQfryZ/REIvkQ5653DP6GfZUN9gf8GUGDTZPMTe2FCDsITScwb6aM
         gOhktB8XvMIJ0vCJMm/2tbllG6NlT7nHKIZsOUIu0z79rzHJ1GyxoJoTA1yZuT3te7II
         oJSLqMGRr0Uv9BIjYpw1NIh26i4Gnfj5v/YJsZmICeMS/cuexREYj0BiUga2B7zB3rlm
         5mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697153583; x=1697758383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naelrzab06bC9MMj4BGYD3OPqUStfN/T5v5pDuFLbLk=;
        b=XcPTA8QVU2LUG9kQM+Kw4jUx7xL7kDvCkxqof8gUyvMDC10Ke0SHj/Qn34yE2OdvsK
         uFrvvdzy1yX3fdArW6+9s1bgEHMjvfaY6aAc3XgIzqUsq3CqrEaetqcAdzTd36x1ypoA
         BAWyE+pSJd+BREb0a4KBiQEJGfJJc0A3SUc6kdjvOUBa7hCkKjwusyQ0rBOluxeLWAP3
         fyK0F4ak2KKFTI54+okjRlD/LWfJPHaeTi7PO7IgBtFXAcOTRzdmECS3mLySIPPKzJYL
         gMZcskk5S5oWLNFdIX36SrykKnIjIMbmcx5Z1z10znHtVXi6pgZEXpTEcnrdX/KUw4jk
         z7uA==
X-Gm-Message-State: AOJu0YznNrCwp2PboZtHnHcPlcz8dVNXHW7Lo45SQvyxnqWpy8ZABbMB
	/djDH99bp0hcKvtAIgrGTIf8r6fEGTV+QjUqpzg++V9yZ0Y=
X-Google-Smtp-Source: AGHT+IFktL1z+8uHtW7sSg/mm9ANSBxBw4G5ovXgGC7Jm0VRroUoXsw5G2EjR4YxqJnT4kE5+ExsDa7iJAWGsPaEWEM=
X-Received: by 2002:aa7:c302:0:b0:533:97c:8414 with SMTP id
 l2-20020aa7c302000000b00533097c8414mr23598044edq.7.1697153583101; Thu, 12 Oct
 2023 16:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
 <20231012114550.152846-1-asavkov@redhat.com> <20231012094444.0967fa79@gandalf.local.home>
In-Reply-To: <20231012094444.0967fa79@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 16:32:51 -0700
Message-ID: <CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in struct syscall_tp_t
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 6:43=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 12 Oct 2023 13:45:50 +0200
> Artem Savkov <asavkov@redhat.com> wrote:
>
> > linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add suppor=
t
> > for lazy preemption")) that adds an extra member to struct trace_entry.
> > This causes the offset of args field in struct trace_event_raw_sys_ente=
r
> > be different from the one in struct syscall_trace_enter:
> >
> > struct trace_event_raw_sys_enter {
> >         struct trace_entry         ent;                  /*     0    12=
 */
> >
> >         /* XXX last struct has 3 bytes of padding */
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         long int                   id;                   /*    16     8=
 */
> >         long unsigned int          args[6];              /*    24    48=
 */
> >         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
> >         char                       __data[];             /*    72     0=
 */
> >
> >         /* size: 72, cachelines: 2, members: 4 */
> >         /* sum members: 68, holes: 1, sum holes: 4 */
> >         /* paddings: 1, sum paddings: 3 */
> >         /* last cacheline: 8 bytes */
> > };
> >
> > struct syscall_trace_enter {
> >         struct trace_entry         ent;                  /*     0    12=
 */
> >
> >         /* XXX last struct has 3 bytes of padding */
> >
> >         int                        nr;                   /*    12     4=
 */
> >         long unsigned int          args[];               /*    16     0=
 */
> >
> >         /* size: 16, cachelines: 1, members: 3 */
> >         /* paddings: 1, sum paddings: 3 */
> >         /* last cacheline: 16 bytes */
> > };
> >
> > This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
> > test_profiler testcase because max_ctx_offset is calculated based on th=
e
> > former struct, while off on the latter:
> >
> >   10488         if (is_tracepoint || is_syscall_tp) {
> >   10489                 int off =3D trace_event_get_offsets(event->tp_e=
vent);
> >   10490
> >   10491                 if (prog->aux->max_ctx_offset > off)
> >   10492                         return -EACCES;
> >   10493         }
> >
> > What bpf program is actually getting is a pointer to struct
> > syscall_tp_t, defined in kernel/trace/trace_syscalls.c. This patch fixe=
s
> > the problem by aligning struct syscall_tp_t with with struct
> > syscall_trace_(enter|exit) and changing the tests to use these structs
> > to dereference context.
> >
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
>

I think these changes make sense regardless, can you please resend the
patch without RFC tag so that our CI can run tests for it?

> Thanks for doing a proper fix.
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

But looking at [0] and briefly reading some of the discussions you,
Steven, had. I'm just wondering if it would be best to avoid
increasing struct trace_entry altogether? It seems like preempt_count
is actually a 4-bit field in trace context, so it doesn't seem like we
really need to allocate an entire byte for both preempt_count and
preempt_lazy_count. Why can't we just combine them and not waste 8
extra bytes for each trace event in a ring buffer?

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git=
/commit/?id=3Db1773eac3f29cbdcdfd16e0339f1a164066e9f71

>
> -- Steve

