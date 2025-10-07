Return-Path: <bpf+bounces-70494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9E8BC04EA
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 08:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C333C1EE0
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 06:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0A221F29;
	Tue,  7 Oct 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v/AxOXC8"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD81BC41
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759817699; cv=none; b=DELob1ANdGXZnIuazI3cQZCIrfc61p5tB5sHVC7/YUL42L3ED+zfYt+Vk1DTAViecSV9amwzaBUiwFwcI3YVZnEgVGd0Ha84UQSNCEtXScun1ipb8S8DTR6jnEpBvCv7yw5kuNrf1I6NPUdfuXjV3iYtDdVuPzhurYuWI9qIFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759817699; c=relaxed/simple;
	bh=F1u4iWMm+qcDMG+vr/1mGk7YuWuqcxw34EH+k+It1tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hlv6Nr6cFqRINX1PXuH5GJaW3tKVeWh0+LV1F+E9kVkPMHQ8KwYv8V9qd+e4jsSpov8s2xEOjHDbdhEEyU4Se7XgM13crnzQp/X7k6NzANTY2bqWUcUag/DZPjpHZ5M7hkezjRkmM4+N0lEqScuUfOb8b8r+UUX/Y+uiZK75p3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v/AxOXC8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759817685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9krF6e/yQ7masYGUY5rb2IPLnZ63vNRajRMzQDojwQ0=;
	b=v/AxOXC8xspU3EfvKkn8iOi7lVKw5gbna3dK8IanDYZbKs+Rd2FTYbXsD7zNPOXkN9VMOG
	Ev598DhJZ67GFBZbP/xqoKCRZv+Is0PgTQ68R+1ZE5QMtwwXr+vn0LBnLvR7JoS3CmHI8o
	jeiQGc9GU25B7N8WuCn6oqUjJVz7Piw=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF stderr
Date: Tue, 07 Oct 2025 14:14:35 +0800
Message-ID: <3571660.QJadu78ljV@7950hx>
In-Reply-To:
 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
References:
 <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev>
 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/2 10:03, Alexei Starovoitov wrote:
> On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > Introduce the function bpf_prog_report_probe_violation(), which is used
> > to report the memory probe fault to the user by the BPF stderr.
> >
> > Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
> > ---
> >  include/linux/bpf.h      |  1 +
> >  kernel/trace/bpf_trace.c | 18 ++++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 6338e54a9b1f..a31c5ce56c32 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2902,6 +2902,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr,=
 void *data,
> >  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
> >  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
> >  void bpf_prog_report_arena_violation(bool write, unsigned long addr, u=
nsigned long fault_ip);
> > +void bpf_prog_report_probe_violation(bool write, unsigned long fault_i=
p);
> >
> >  #else /* !CONFIG_BPF_SYSCALL */
> >  static inline struct bpf_prog *bpf_prog_get(u32 ufd)
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 8f23f5273bab..9bd03a9f53db 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2055,6 +2055,24 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event=
_map *btp)
> >         module_put(mod);
> >  }
> >
> > +void bpf_prog_report_probe_violation(bool write, unsigned long fault_i=
p)
> > +{
> > +       struct bpf_stream_stage ss;
> > +       struct bpf_prog *prog;
> > +
> > +       rcu_read_lock();
> > +       prog =3D bpf_prog_ksym_find(fault_ip);
> > +       rcu_read_unlock();
> > +       if (!prog)
> > +               return;
> > +
> > +       bpf_stream_stage(ss, prog, BPF_STDERR, ({
> > +               bpf_stream_printk(ss, "ERROR: Probe %s access faule, in=
sn=3D0x%lx\n",
> > +                                 write ? "WRITE" : "READ", fault_ip);
> > +               bpf_stream_dump_stack(ss);
> > +       }));
>=20
> Interesting idea, but the above message is not helpful.
> Users cannot decipher a fault_ip within a bpf prog.
> It's just a random number.

Yeah, I have noticed this too. What useful is the
bpf_stream_dump_stack(), which will print the code
line that trigger the fault.

> But stepping back... just faults are common in tracing.
> If we start printing them we will just fill the stream to the max,
> but users won't know that the message is there, since no one

You are right, we definitely can't output this message
to STDERR directly. We can add an extra flag for it, as you
said below.

Or, maybe we can introduce a enum stream_type, and
the users can subscribe what kind of messages they
want to receive.

> expects it. arena and lock errors are rare and arena faults
> were specifically requested by folks who develop progs that use arena.
> This one is different. These faults have been around for a long time
> and I don't recall people asking for more verbosity.
> We can add them with an extra flag specified at prog load time,
> but even then. Doesn't feel that useful.

Generally speaking, users can do invalid checking before
they do the memory reading, such as NULL checking. And
the pointer in function arguments that we hook is initialized
in most case. So the fault is someting that can be prevented.

I have a BPF tools which is writed for 4.X kernel and kprobe
based BPF is used. Now I'm planing to migrate it to 6.X kernel
and replace bpf_probe_read_kernel() with bpf_core_cast() to
obtain better performance. Then I find that I can't check if the
memory reading is success, which can lead to potential risk.
So my tool will be happy to get such fault event :)

Leon suggested to add a global errno for each BPF programs,
and I haven't dig deeply on this idea yet.

Thanks!
Menglong Dong

>=20
>=20





