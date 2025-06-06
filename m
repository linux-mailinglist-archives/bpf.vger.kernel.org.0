Return-Path: <bpf+bounces-59857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F47AD038F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F88617173D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A3228937B;
	Fri,  6 Jun 2025 13:56:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C1A289353;
	Fri,  6 Jun 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749218163; cv=none; b=NrUYG/z2k0DiUhAsvscLKhpYunpGC9fOCUoNjBxObGZefApFsiVt2HzIAdWZYGHglmL+RCT5Ep+w/GpEZaIi6jFCS8IwcbQPwFkpfKfWHyW+n+IbpA+KkZf0hci7777/BGxZpEa7Fo7r4IBXDOnSrgI3iMUL3dx3Wb3X95PYk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749218163; c=relaxed/simple;
	bh=T+xV+4L5kYc18ASh5RZNYLy6c0+J111f8iQGQAuhVOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apPhDatMOZbIzK7D9dTn8kt8+VjVAY2ElNEmOVeNyAi+MZsPADaTPjRHq/J5DbuOGbbX4vEwxjjDu/jhtDgZ65yqk2taEcjLgpGU4sgGlKhTzlJ1zf/Kzk65sffyqk/KlxeBqU2ZLgLBNsm22Xb3um4QoAi48yPNBrdz6C0UQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 9ADE0C03B6;
	Fri,  6 Jun 2025 13:55:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 908C82002B;
	Fri,  6 Jun 2025 13:55:51 +0000 (UTC)
Date: Fri, 6 Jun 2025 09:57:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 bpf@vger.kernel.org, linux-rt-users@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Thomas Gleixner	 <tglx@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf
 selftests
Message-ID: <20250606095712.7287fa31@gandalf.local.home>
In-Reply-To: <b86bd98b23d1299981c4e95b593eb5a144fbf822.camel@web.de>
References: <20250605091904.5853-1-spasswolf@web.de>
	<20250605084816.3e5d1af1@gandalf.local.home>
	<b86bd98b23d1299981c4e95b593eb5a144fbf822.camel@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: gjpoyntgruu9ygjckensj914ib3c1f8u
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 908C82002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18wYnWS6mag3f3tRHCDwUyD3HZnkmZJDHk=
X-HE-Tag: 1749218151-743164
X-HE-Meta: U2FsdGVkX1/TAoqV8oNEos9TrqNq41Y49RWqAr+8SwyGA/Uy8la/u8oAjQAmA5e4WoyryKetbdmbRDPXfaqTTnZnl25CcHILPiF0Q/7sQo2elCXM9IX4dQxLaE9HVOKlNpQFSOIUCe3vu+lLdwmPBCOffcKiaF7i7U8T12XpoK4Ujjue3e4UO74Szo3B2cRHZS5hzpRhdN4Kh6+KskN0XkuLgKwbb9t4h3SQngOkPgOHVw7jc6U8nHVPOIUHY+53Cvtxh8KHPHXQqsDYUk4cUrurNlTtCZcXoQqf0eavMvO6Nv3DAO+TbkN1sO9i1jGwDjo/IJDON0cfZ9P39tD8EZh52P/YkmUs3uopnfRu3sbH70V/3aR5Z1C3jqtfVQAhHujB6VdxESXZdQo/BnW0bQ==

On Fri, 06 Jun 2025 15:13:05 +0200
Bert Karwatzki <spasswolf@web.de> wrote:

> I tried this and first thought my kernel did not have the right configura=
tion as
>=20
> # trace-cmd record -e preempt_disable -e preempt_enable
>=20
> seemed to do nothing in particular, but it turns out it takes a long time=
 to start
> (~1min) when the kernel is compiled with CONFIG_LOCKDEP=3Dy. (on the stan=
dard debian

Yeah, that's a recent regression in the code which I'm currently testing a
fix for:

   https://lore.kernel.org/linux-trace-kernel/20250605161701.35f7989a@ganda=
lf.local.home


> kernel starting to record takes less time, but it does not have CONFIG_PR=
EEMPT_TRACER.)
>=20
> So after the trace-cmd was running I ran the bpf example and got a trace.=
dat:
>=20
> # ls -lh trace.dat=20
> -rw-r--r-- 1 root root 152M  6. Jun 14:41 trace.dat
>=20
> turning this into a report with
>=20
> # trace-cmd report > preemp_trace.rep
>=20
> gives a rather unwieldly large file

Of course, it's recording every time preemption is enabled and disabled ;-)

I usually run it with a test:

 # trace-cmd record -e preempt_disable -e preempt_enable ./myprog

Where it will stop when ./myprog is done.

>=20
> # ls -lh preempt_trace.rep=20
> -rw-rw-r-- 1 root root 7,4G  6. Jun 14:46 preempt_trace.rep
>=20
> This file has about 61 million lines
>=20
> # wc -l preempt_trace.rep
> 61627360 preempt_trace.rep
>=20
> but only 742104 corresponding to the bpf example program "test_progs"
>=20
> # grep test_progs preempt_trace.rep | wc -l
> 742104

 # trace-cmd record -e preempt_disable -e preempt_enable -F ./test_progs

where "-F" means "follow" and will only record when "./test_progs" is runni=
ng.
Add "-c" to also trace its children.

>=20
> Is it possible to filter the preempt_{en,dis}able events by task name (i.=
e.
> get_current()->comm)?
>=20
> I tried this (from=C2=A0https://code.tools/man/1/trace-cmd-report/) but it
> fails with an error message:
> # trace-cmd record -e preempt_enable -F '.*:COMM =3D=3D "test_progs"' -e =
preempt_disable -F '.*:COMM =3D=3D "test_progs"'

 -F means to execute. The -F in trace-cmd report is filter (that's because
 -f was already taken :-p)

-- Steve

>=20
> ********************
>  Unable to exec .*:COMM =3D=3D "test_progs"
> ********************
> trace-cmd: No such file or directory
>   Failed to exec .*:COMM =3D=3D "test_progs"
> libtracecmd: No such file or directory
>   can not stat 'trace.dat.cpu0'
>=20
>=20
> Bert Karwatzki


