Return-Path: <bpf+bounces-60007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F6AD1195
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 10:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3223AC340
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343271FDE09;
	Sun,  8 Jun 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="hEHPKKK3"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0F156CA;
	Sun,  8 Jun 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749372358; cv=none; b=SCcXiZhxp5TNhq/bC+f1QJoNE1O+hcIrrhwut39g54xnBI4WWYRn9YSvpNCVQY3AWec2qIPlKd2JV5ZKxSyvwtM4v8TXmT4fyrTZaZ6jwTvwajFgzmnuCesEjeauhDh/2mRK45Y10/I1PfP8j7+SpJFXrwOeGlwxsIlKl+FneTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749372358; c=relaxed/simple;
	bh=v4PkM/Ar22LVKA1uuGEftCXiCqmcHBsUUBjFLYyvYiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ExTaebQla9ryWNBp0BJXFPVvC2hKkBdZPWr84BFW0fqCPIpW+LCUZt7hFv2Prloj2uW2ujGVWTURAn1bbGhxYEiDm1Zh6qyWFC98O2KUrn2kUJbemRvZq4P/225sJyZN71QS75L0OFicfUOVey8NPCwX/Dc5zg7BGTD4fyXCo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=hEHPKKK3; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749372338; x=1749977138; i=spasswolf@web.de;
	bh=EdEG80i6V1qMQITbp6edf3dtJZUmhxxsKi7heRnjiwg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hEHPKKK3kdkSbkgnyzXo3MrxRSvK6LwLLb7qKRPXzWD9KGC17Z9IErE3Z9qRZNvB
	 vbpMyvcgxaUvqAtEo9laPpcSPVgEL9jkJH0WgAifPhcfjD/mAHECBdZ8rfaxAlQeR
	 wKMLA4IBZ90yWs8CO6Wa7GoOrC9dRtpGWsA2i67uDuXTVFeu2mtWHfXwWmqgFQWLX
	 pPmK1cCyvItwktisbU2K3BoXWkqoZqLlkOdtAQoPaKpmDFgx7fE0MYt7kuP2VEv32
	 Z7dJmWSXDteH8QZIHEuKF8hMr1yBr8TTl2mxJT3wuMRcuSgiDWTX2Lo12xof4Lb4r
	 dg0x37OFPhDP7mw8Gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sXj-1uNMJR1tHL-0091Bv; Sun, 08
 Jun 2025 10:45:38 +0200
Message-ID: <0b1f48ba715a16c4d4874ae65bc01914de4d5a90.camel@web.de>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, spasswolf@web.de
Date: Sun, 08 Jun 2025 10:45:36 +0200
In-Reply-To: <20250605125133.RSTingmi@linutronix.de>
References: <20250605091904.5853-1-spasswolf@web.de>
		 <20250605084816.3e5d1af1@gandalf.local.home>
		 <20250605125133.RSTingmi@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Avuy5UJuZKURJRTxQ764K+K7sZX230PJvIemxiufXAdVCKOLnBJ
 doNxe9ya2SO8EH2duok+ueOTbm8cZCc4GLSAK7En2qdmqPZFIN7jrZBeUqo/rUAxm2tzaaL
 f9EA6sZrqgu/F40AxBI9SvI6Wo5/i1ufEjFlbMI5riowijuk7bvxF7cqfoVFOsBQVcDG/52
 r0UWHzHzHRiJGTK0ztbwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BA8NKV7akWg=;dBQYN42GqmZDJpDPPWyybh4vwaO
 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

Am Donnerstag, dem 05.06.2025 um 14:51 +0200 schrieb Sebastian Andrzej Sie=
wior:
> On 2025-06-05 08:48:38 [-0400], Steven Rostedt wrote:
> > On Thu,  5 Jun 2025 11:19:03 +0200
> > Bert Karwatzki <spasswolf@web.de> wrote:
> >=20
> > > This patch seems to create so much output that the orginal error mes=
sage and
> > > backtrace often get lost, so I needed several runs to get a meaningf=
ul message
> > > when running
> >=20
> > Are you familiar with preempt count tracing?
>=20
> I have an initial set of patches to tackle this problem, I'm going to
> send them after the merge window.
>=20
> Sebastian

I've found the reason for the "mysterious" increase of preempt_count:

[   70.821750] [   T2746] bpf_link_settle calling fd_install() preemt_coun=
t =3D 0
[   70.821751] [   T2746] preempt_count_add 5898: preempt_count =3D 0x0 co=
unter =3D 0x1b232c
[   70.821752] [   T2746] preempt_count_add 5900: preempt_count =3D 0x1 co=
unter =3D 0x1b232d
[   70.821754] [   T2746] preempt_count_sub 5966: preempt_count =3D 0x1 co=
unter =3D 0x1b232e
[   70.821755] [   T2746] preempt_count_sub 5968: preempt_count =3D 0x0 co=
unter =3D 0x1b232f
[   70.821761] [   T2746] __bpf_trace_sys_enter 18: preempt_count =3D 0x0
[   70.821762] [   T2746] __bpf_trace_sys_enter 18: preempt_count =3D 0x1
[   70.821764] [   T2746] __bpf_trace_run: preempt_count =3D 1
[   70.821765] [   T2746] bpf_prog_run: preempt_count =3D 1
[   70.821766] [   T2746] __bpf_prog_run: preempt_count =3D 1

It's caused by this macro from include/trace/bpf_probe.h (with my pr_err()=
):

#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args) \
static notrace void \
__bpf_trace_##call(void *__data, proto) \
{ \
 might_fault(); \
 if (!strcmp(get_current()->comm, "test_progs")) \
 pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_count=
());\
 preempt_disable_notrace(); \
 if (!strcmp(get_current()->comm, "test_progs")) \
 pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_count=
());\
 CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args)); =
\
 preempt_enable_notrace(); \
}

The preempt_{en,dis}able_notrace were introduced in
commit 4aadde89d81f ("tracing/bpf: disable preemption in syscall probe")
This commit is present in v6.14 and v6.15, but the bug already appears in
v6.12 so in that case preemption is disable somewhere else.=20

Bert Karwatzki

