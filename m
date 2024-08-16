Return-Path: <bpf+bounces-37372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39987954C06
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 16:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C23E1C2086B
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F81BC9EB;
	Fri, 16 Aug 2024 14:10:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3081BC09F;
	Fri, 16 Aug 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817435; cv=none; b=nUlhaPQFaQMUlWAEmSzNmoOznVfeevtGYukv0f7RYvuZZjEIn/5zBDgvBXlowIOvcGf1sJz0IY8AiHb1y0x2mB2H6Mj6PggRIDONmo79MTEIbgjphBp8H/2Qwa0ZNL0PRhIvbOqLmgn1a9+69a54oXCY60jitm/Vmxbq3HxCvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817435; c=relaxed/simple;
	bh=87SzsDRbL6xxSmRijTCJnf5oPTeax2odjliZBG9cjSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUorDPQ65Hu1LuZOgcBF/oj4N1l8wgJyyQdy/9hjLhkoadGuWQGWAGLkVXrGbe6SRugMQcgRE+3LryRaxrPN1UbkgNn/A275VeW6ts6/OTVcXZANxl09OvygsSNLrKFYGTDORex3gZeQus7pE6gFuonXfElqtRTWpK8Cr3Ugaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC932C32782;
	Fri, 16 Aug 2024 14:10:33 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:10:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Artem Savkov
 <asavkov@redhat.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program
 (6.11.0-rc1)
Message-ID: <20240816101031.6dd1361b@rorschach.local.home>
In-Reply-To: <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
	<ZrECsnSJWDS7jFUu@krava>
	<CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
	<ZrIj9jkXqpKXRuS7@krava>
	<CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
	<ZrSh8AuV21AKHfNg@krava>
	<CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
	<Zr3q8ihbe8cUdpfp@krava>
	<CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 14:37:18 +0200
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > I checked bit more and there are more tracepoints with the same issue,
> > the first diff stat looks like:
> >
> >          include/trace/events/afs.h                            | 44 ++++++++++++++++++++++----------------------
> >          include/trace/events/cachefiles.h                     | 96 ++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
> >          include/trace/events/ext4.h                           |  6 +++---
> >          include/trace/events/fib.h                            | 16 ++++++++--------
> >          include/trace/events/filelock.h                       | 38 +++++++++++++++++++-------------------
> >          include/trace/events/host1x.h                         | 10 +++++-----
> >          include/trace/events/huge_memory.h                    | 24 ++++++++++++------------
> >          include/trace/events/kmem.h                           | 18 +++++++++---------
> >          include/trace/events/netfs.h                          | 16 ++++++++--------
> >          include/trace/events/power.h                          |  6 +++---
> >          include/trace/events/qdisc.h                          |  8 ++++----
> >          include/trace/events/rxrpc.h                          | 12 ++++++------
> >          include/trace/events/sched.h                          | 12 ++++++------
> >          include/trace/events/sunrpc.h                         |  8 ++++----
> >          include/trace/events/tcp.h                            | 14 +++++++-------
> >          include/trace/events/tegra_apb_dma.h                  |  6 +++---
> >          include/trace/events/timer_migration.h                | 10 +++++-----
> >          include/trace/events/writeback.h                      | 16 ++++++++--------
> >
> > plus there's one case where pointer needs to be checked with IS_ERR in
> > include/trace/events/rdma_core.h trace_mr_alloc/mr_integ_alloc
> >
> > I'm not excited about the '_nullable' argument suffix, because it's lot
> > of extra changes/renames in TP_fast_assign and it does not solve the
> > IS_ERR case above
> >
> > I checked on the type tag and with llvm build we get the TYPE_TAG info
> > nicely in BTF:
> >
> >         [119148] TYPEDEF 'btf_trace_sched_pi_setprio' type_id=119149
> >         [119149] PTR '(anon)' type_id=119150
> >         [119150] FUNC_PROTO '(anon)' ret_type_id=0 vlen=3
> >                 '(anon)' type_id=27
> >                 '(anon)' type_id=678
> >                 '(anon)' type_id=119152
> >         [119151] TYPE_TAG 'nullable' type_id=679
> >         [119152] PTR '(anon)' type_id=119151
> >
> >         [679] STRUCT 'task_struct' size=15424 vlen=277
> >
> > which we can easily check in verifier.. the tracepoint definition would look like:
> >
> >         -       TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
> >         +       TP_PROTO(struct task_struct *tsk, struct task_struct __nullable *pi_task),
> >
> > and no other change in TP_fast_assign is needed
> >
> > I think using the type tag for this is nicer, but I'm not sure where's
> > gcc at with btf_type_tag implementation, need to check on that  
> 
> Unfortunately last time I heard gcc was still far.
> So we cannot rely on decl_tag or type_tag yet.
> Aside from __nullable we would need another suffix to indicate is_err.
> 
> Maybe we can do something with the TP* macro?
> So the suffix only seen one place instead of search-and-replace
> through the body?
> 
> but imo above diff stat doesn't look too bad.

I'm fine with annotation of parameters, but I really don't want this
being part of the TP_fast_assign() content. What would that look like
anyway?

-- Steve

