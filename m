Return-Path: <bpf+bounces-59856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FC4AD02E3
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 15:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D84A3AE966
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3C288C93;
	Fri,  6 Jun 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="egF/NlpP"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DA20330;
	Fri,  6 Jun 2025 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215616; cv=none; b=NNmWkXt7v/9Mvd6T8iWHSSUVXDqKJMyh8Ic04ep+3QF2y4WZq7PtWPmTZ1Ku1J2X34cq2QG06Nkud0UAQsNcie9CoopibSiMfK5aTFwBXdcjGMF2ejKVcn3e/ddOc0R6XjXW95zMlDqKVwAqIMLUEos+6fqKO6xoaSRbJzFiC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215616; c=relaxed/simple;
	bh=j9EZE4q62ThuV+2Zjfct90iVgC2ZOI9xeRJnbY5SyJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=az/RTgSBZU33hzbq6A4M/CeBh6Kw/eNDrx+yS2oyYFxxlcTPPP4Myl4fGfWXKVl2RStVsNRX/VkTVefTSFd9EduFragaiar63fSMZLZlr63b+aB2gAZt3q3sHe6aoyiYxbA0RD9ufz7mmrAAjV/Ptwd24o3I7VTvk7BLdQuQryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=egF/NlpP; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749215588; x=1749820388; i=spasswolf@web.de;
	bh=Ci2Fs3IVjrOw8jayotgpd7SLmlfduGsH2A1mfElURos=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=egF/NlpP+TElqXVs2mcG+eaItU2by5xIeuqRUmkCZKLo7f35Ukts3s2rynZaTAJk
	 0RUD14ZtXWFsGi/q5VB5Y+ozjbbJIN5e0tcPPJbKjXg9evKH0DhJ3vQ35Vq/fsh95
	 2jyIPXI5dZ7/Xr0R4VoAYrOjM+7rI2QG00YjJNODPc9pko5yG8EvHe6dl5F+jueLa
	 5FDmgHjoOgnDBbOgaTWU45HBNJmQnsa166cfSfy43hw6VDotSlQKY7ilx53l+YWsw
	 pQ2ewRtR9p/lpLCaougCTy5jMAoAOhC45L6ZSINA41KCBDFBfU8Rd1H64648rirGx
	 eWmNi19oS0Q1L1TzOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXZf-1uW1K42g6N-00HKnx; Fri, 06
 Jun 2025 15:13:07 +0200
Message-ID: <b86bd98b23d1299981c4e95b593eb5a144fbf822.camel@web.de>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
From: Bert Karwatzki <spasswolf@web.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-rt-users@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Thomas Gleixner	 <tglx@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, 	spasswolf@web.de
Date: Fri, 06 Jun 2025 15:13:05 +0200
In-Reply-To: <20250605084816.3e5d1af1@gandalf.local.home>
References: <20250605091904.5853-1-spasswolf@web.de>
	 <20250605084816.3e5d1af1@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EUfzu2r5Y+S6E6zcWCk+pUUGDD4dSlli2Qs7FhrVxk7lXtsBA1/
 91m2kpTjo2XQTfbdHTSuVobgtf0CsoG9Y7+hDzXN8XdiCWggM9JTL38j6cA+vPng7rlHSmf
 k6oNjdeh5IuWeJHLz0dM6gVJue7QHdatTgNQ6ebnqdFGM6xFaMqCIdAPQX2lv2MyxD+wlTt
 uJbPtvdTMMryI44Hl7rkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ibbMtDxjIug=;XuACQFZ/BJa1YM82rdBjToQk8cB
 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

Am Donnerstag, dem 05.06.2025 um 08:48 -0400 schrieb Steven Rostedt:
> On Thu,  5 Jun 2025 11:19:03 +0200
> Bert Karwatzki <spasswolf@web.de> wrote:
>=20
> > This patch seems to create so much output that the orginal error messa=
ge and
> > backtrace often get lost, so I needed several runs to get a meaningful=
 message
> > when running
>=20
> Are you familiar with preempt count tracing?

Thanks for pointing me to this, I only very briefly tried out the function=
 tracer
judging by an old file I found on 22.01.2022:

-rw-r--r-- 1 root root  75529450 22. Jan 2022  trace.log

>=20
> ~# trace-cmd start -e preempt_enable -e preempt_disable
> ~# trace-cmd show
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 177552/177552   #P:8
> #
> #                                _-----=3D> irqs-off/BH-disabled
> #                               / _----=3D> need-resched
> #                              | / _---=3D> hardirq/softirq
> #                              || / _--=3D> preempt-depth
> #                              ||| / _-=3D> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>        trace-cmd-1131    [001] ...1.   965.046684: preempt_disable: call=
er=3Dvfs_write+0x89c/0xe90 parent=3Dvfs_write+0x89c/0xe90
>        trace-cmd-1131    [001] ...1.   965.046695: preempt_enable: calle=
r=3Dvfs_write+0x923/0xe90 parent=3Dvfs_write+0x923/0xe90
>        trace-cmd-1131    [001] ...1.   965.046729: preempt_disable: call=
er=3D_raw_spin_lock+0x17/0x40 parent=3D0x0
>        trace-cmd-1131    [001] ...1.   965.046746: preempt_enable: calle=
r=3D_raw_spin_unlock+0x2d/0x50 parent=3D0x0
>        trace-cmd-1131    [001] ...1.   965.046749: preempt_disable: call=
er=3Dcount_memcg_events+0x74/0x480 parent=3Dcount_memcg_events+0x74/0x480
>        trace-cmd-1131    [001] ...1.   965.046751: preempt_enable: calle=
r=3Dcount_memcg_events+0x2b4/0x480 parent=3Dcount_memcg_events+0x2b4/0x480
>        trace-cmd-1131    [001] ...1.   965.046765: preempt_disable: call=
er=3D_raw_spin_lock+0x17/0x40 parent=3D0x0
>        trace-cmd-1131    [001] ...1.   965.046769: preempt_enable: calle=
r=3D_raw_spin_unlock+0x2d/0x50 parent=3D0x0
>        trace-cmd-1131    [001] ...1.   965.046771: preempt_disable: call=
er=3Dcount_memcg_events+0x74/0x480 parent=3Dcount_memcg_events+0x74/0x480
>        trace-cmd-1131    [001] ...1.   965.046773: preempt_enable: calle=
r=3Dcount_memcg_events+0x2b4/0x480 parent=3Dcount_memcg_events+0x2b4/0x480
>        trace-cmd-1131    [001] ...1.   965.046787: preempt_disable: call=
er=3D_raw_spin_lock+0x17/0x40 parent=3D0x0
>        trace-cmd-1131    [001] ...1.   965.046801: preempt_enable: calle=
r=3D_raw_spin_unlock+0x2d/0x50 parent=3D0x0
>        trace-cmd-1131    [001] ...1.   965.046803: preempt_disable: call=
er=3Dcount_memcg_events+0x74/0x480 parent=3Dcount_memcg_events+0x74/0x480
>        trace-cmd-1131    [001] ...1.   965.046805: preempt_enable: calle=
r=3Dcount_memcg_events+0x2b4/0x480 parent=3Dcount_memcg_events+0x2b4/0x480
>        trace-cmd-1131    [001] d..1.   965.046812: preempt_disable: call=
er=3D_raw_spin_lock_irq+0x2b/0x60 parent=3D0x0
>        trace-cmd-1131    [001] ...1.   965.046815: preempt_enable: calle=
r=3D_raw_spin_unlock_irq+0x38/0x60 parent=3D0x0
> [..]
>=20
> It's very light weight. There's also trace_printk() that is also very li=
ght
> weight to use.

> It's enabled when you enable CONFIG_PREEMPT_TRACER.
>=20
> -- Steve

I tried this and first thought my kernel did not have the right configurat=
ion as

# trace-cmd record -e preempt_disable -e preempt_enable

seemed to do nothing in particular, but it turns out it takes a long time =
to start
(~1min) when the kernel is compiled with CONFIG_LOCKDEP=3Dy. (on the stand=
ard debian
kernel starting to record takes less time, but it does not have CONFIG_PRE=
EMPT_TRACER.)

So after the trace-cmd was running I ran the bpf example and got a trace.d=
at:

# ls -lh trace.dat=20
-rw-r--r-- 1 root root 152M  6. Jun 14:41 trace.dat

turning this into a report with

# trace-cmd report > preemp_trace.rep

gives a rather unwieldly large file

# ls -lh preempt_trace.rep=20
-rw-rw-r-- 1 root root 7,4G  6. Jun 14:46 preempt_trace.rep

This file has about 61 million lines

# wc -l preempt_trace.rep
61627360 preempt_trace.rep

but only 742104 corresponding to the bpf example program "test_progs"

# grep test_progs preempt_trace.rep | wc -l
742104

Is it possible to filter the preempt_{en,dis}able events by task name (i.e=
.
get_current()->comm)?

I tried this (from=C2=A0https://code.tools/man/1/trace-cmd-report/) but it
fails with an error message:
# trace-cmd record -e preempt_enable -F '.*:COMM =3D=3D "test_progs"' -e p=
reempt_disable -F '.*:COMM =3D=3D "test_progs"'

********************
 Unable to exec .*:COMM =3D=3D "test_progs"
********************
trace-cmd: No such file or directory
  Failed to exec .*:COMM =3D=3D "test_progs"
libtracecmd: No such file or directory
  can not stat 'trace.dat.cpu0'


Bert Karwatzki

