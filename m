Return-Path: <bpf+bounces-78420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161BFD0C755
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14570301A1E9
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8923340D93;
	Fri,  9 Jan 2026 22:33:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120250095C;
	Fri,  9 Jan 2026 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998019; cv=none; b=MHSJxFIDA8Gud3/V6ogwZyc2V9lt0xaMefvGDYkO4S6d3DQqZ1PE4b7QqOsM1nB702W9rJrtv73lvPSLSPoQa/HqX6E3cZ66sS+5Bs65Ud7CI9TwGY814ftMkSVNPWMEJlVoUBbNK0jviEITe4cMhlUXsomhthJ4uRXTIYDSVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998019; c=relaxed/simple;
	bh=jVGm04hsWuGL1PwazJ2rA9TnX9cGN7mlgIYvUL3hEZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQ3TJ9bXgQpnElKc4+nkc6lJNEBNaMjECO+CtyanNFssUP+uHipRc5r+YSw5rQvZjyekQGnO2h0bSwq5fQpHoK6rWy7cA/1zH8/5BGFAsBDD3r22QwaADaOYGKapcUPJGMF9/vde/rBU5M0hmD7joJS7piUB9zlnELnoY29+mq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 2118613BFF1;
	Fri,  9 Jan 2026 22:33:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 06EDF2002A;
	Fri,  9 Jan 2026 22:33:27 +0000 (UTC)
Date: Fri, 9 Jan 2026 17:33:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260109173326.616e873c@fedora>
In-Reply-To: <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
References: <20260108220550.2f6638f3@fedora>
	<da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
	<CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
	<20260109141930.6deb2a0a@gandalf.local.home>
	<3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
	<CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
	<20260109170028.0068a14d@fedora>
	<CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 3ktik7ehheta84gzdr3mmby4hw471tcn
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 06EDF2002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/lfGP0I/fLnzCyheaWjwC/3piEHz0tFVw=
X-HE-Tag: 1767998007-127265
X-HE-Meta: U2FsdGVkX1+jF85+F8fKFvVoD89LjK8YFX5kCfeVLu3OHHB9/18/5gU0sVvJhUuc8a1Hu0Vf1RDa5k8NjQgUazkVzmnFJZKlgMAAzi8IgB5h3PymQe8V5JnoSch39V8buqhc7SjDwHPjurnXGBc1OCXiYLkxFnonRso8/Ldvqx2jowNarZw0FdvNRbXQICRPfO7CLx2+d8cKYkFSlzD5WOnqINogm1N1XhkW3LT+06elo29nMdcs5PNA/7lLr3MGYqGBirbaUmvGpLGh31z3oMGjRJCOtNxG49/XPGyh7dJZj9E6GrbDrmLRQKOZWQbQc6w9mE56t2C5U573n21IkqkTxFMHE/+C7Y+5eUX97XyJPIDHXyvOQX/1ariRqbSwrFCOkhBhWIwGCGbzHY5gLg+nSiS558CVfIITl0D8MK8EB0kN16b0umX51Kk0OUQRGndUnSrCTu7DRl/9DzbDZQ==

On Fri, 9 Jan 2026 14:18:36 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Jan 9, 2026 at 2:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Fri, 9 Jan 2026 13:54:34 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > =20
> > > On Fri, Jan 9, 2026 at 12:21=E2=80=AFPM Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote: =20
> > > >
> > > >
> > > > * preempt disable/enable pair:                                     =
1.1 ns
> > > > * srcu-fast lock/unlock:                                           =
1.5 ns
> > > >
> > > > CONFIG_RCU_REF_SCALE_TEST=3Dy
> > > > * migrate disable/enable pair:                                     =
3.0 ns =20
> > >
> > > .. and you're arguing that 3ns vs 1ns difference is so important
> > > for your out-of-tree tracer that in-tree tracers need to do
> > > some workarounds?! wtf =20
> >
> > This has nothing to do with out of tree tracers. The overhead of the
> > 22ns is for any tracepoint in an in-tree module. That's because the
> > rq->nr_pinned isn't exported for modules to use. =20
>=20
> None of the driver's tracepoints are in the critical path.
> You perfectly know that Mathieu argued about not slowing down lttng.

How is this about lttng? Sure he cares about that, but even tracepoints
that lttng uses doesn't get affected any more than ftrace or bpf.
Because lttng is one of the callbacks. The migrate disable happens in
the in-tree portion of the code.

So you are saying that all the tracepoints for xfs are not in a fastpath?

-- Steve

