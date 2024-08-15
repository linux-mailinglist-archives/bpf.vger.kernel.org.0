Return-Path: <bpf+bounces-37264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE9952DBE
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E87285331
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A961714AE;
	Thu, 15 Aug 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKc9TphB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C261AC898;
	Thu, 15 Aug 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723722488; cv=none; b=pm0GsD58Xolg1xhnZyd/Z7qZ7C9PfchbXL06Hg/triPjCx+VdnyOE1FcjpZQv09XaDxiM9GBWUF+ST5w7wg5QZw1ggFhxt5HxdOyU5P4ZOpkM8Y3Uy9kMKnsrkMC472ZxAfU3gHSlYA+uBnpHcq2gNgHJnmAcxbuGvMOwPvU9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723722488; c=relaxed/simple;
	bh=zNYNdL72jJz8+Mk5NTXI9N3t6gF8bK29wCQHDJg8THs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BykcYSQWHAMfzbz3lRsHP2ctsU/Uaykf1z5aHVo3Al86L0DSkzxRh1zowagrNL/zsZPrtzMmW689OmrkYkZmUBl7ibWD1WCc92Sd9XGNma9EfxKE807pBsKUiCzwmy0KcujyM0ts2/TwDbM3apXjbKARNjbbMBUW65neMbPMzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKc9TphB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so900019a12.0;
        Thu, 15 Aug 2024 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723722485; x=1724327285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=je2XXukMXSdwR0sNDdOOZ1Rp0QK/nwINiVcd0flvlkU=;
        b=CKc9TphBp/7JdFNF/x8rua5jkgJ9cMCJy2oFR4LGAM6MFMUW2MwpDXpVRN+K5XcbEB
         /QlVVOkMYaWr5xHt+IF35NefMR17xfuH/TkbXkZ6i/cz1Y1AUhtWooYDrA3JfGCrp2G1
         LUGvglyJ3zO481HadoWS3J1YWQcGpFkVz7Ir+rL8PF8s6wnTXQGKSrJ2NJNXTHyjbi4N
         JvnSLoEQU0pBrZyGG9KLXuh9lyAnues8NpBlyAZqhFKsaTXIrieYQ6MbEzop57yN+sfd
         Al7KRcmGXNw3ZmZbmTbLdDatmbuEWIUt9gUquD8wHeiNxxxeajaXOSFo5GobDkJmDtnE
         M7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723722485; x=1724327285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=je2XXukMXSdwR0sNDdOOZ1Rp0QK/nwINiVcd0flvlkU=;
        b=c/G7Kyj4oEJyKuDDwBj+xwfNHpnN/fPsaN5Yu3Tp7bWiGrurvgl/MhzVmTj+s42keb
         15xlrnSaRsMZ1CyjuFBioLKzwXy/SVffdg5M5bLHFNzlvnXEBHW1Wjmm+hQjzSP3nG/A
         8mh1cfc5GZxsRpkcG0cv7VOaF3cTcHgwvXyiIy6GSYmUZd2vDD195FSLjNXEyrHYlcxx
         0cv1rRN7tjxFSLBcESkCcqRo/OZBdUtGrq579b2qcaVJ0i2MsNy89ZrpP2St7D5tet9b
         +Sf3QJXMzp8PCnY5RiK4uc6YXM0NitYd53kUNnnxfwZvqiRDSZA1CPO6TuLpk/iqjCBH
         GM7g==
X-Forwarded-Encrypted: i=1; AJvYcCU79xsLwc9Ul9Kjgh/pSj1L5gofwdky8qn9XmldXvO3rIcGLH7PO2iaJQPjj2N2PGO+oC8ZNzxyODKTFeXyqWidW9uFgOSQHunkuEzgayKVPXG853h76z8R/SppIDtHlrDX
X-Gm-Message-State: AOJu0Yw5m+dx2VuSce9mS/nOAPOgurFAehHyWm/MK8aiaPmPVX6jq/Hw
	pU2RvUjRgEmPAcYl1j6bjm01pPluZllqurWN8fe9Xk3oaF/A1eu8
X-Google-Smtp-Source: AGHT+IHUc7Z245cJLlM1B+vwBpPa5aSH6wU1srPtErh6w97HlhdMIvYFD0qVcDmVJHto+wr24Qbl1w==
X-Received: by 2002:a05:6402:35d3:b0:5a3:5218:5d83 with SMTP id 4fb4d7f45d1cf-5bea1c6f86cmr4743106a12.4.1723722484784;
        Thu, 15 Aug 2024 04:48:04 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe29c3sm822534a12.14.2024.08.15.04.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:48:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Aug 2024 13:48:02 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <Zr3q8ihbe8cUdpfp@krava>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava>
 <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
 <ZrIj9jkXqpKXRuS7@krava>
 <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
 <ZrSh8AuV21AKHfNg@krava>
 <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>

On Thu, Aug 08, 2024 at 08:43:05AM -0700, Alexei Starovoitov wrote:
> On Thu, Aug 8, 2024 at 3:46 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Aug 06, 2024 at 11:44:52AM -0700, Alexei Starovoitov wrote:
> > > On Tue, Aug 6, 2024 at 6:24 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > > Jiri,
> > > > >
> > > > > the verifier removes the check because it assumes that pointers
> > > > > passed by the kernel into tracepoint are valid and trusted.
> > > > > In this case:
> > > > >         trace_sched_pi_setprio(p, pi_task);
> > > > >
> > > > > pi_task can be NULL.
> > > > >
> > > > > We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
> > > > > by default, since it will break a bunch of progs.
> > > > > Instead we can annotate this tracepoint arg as __nullable and
> > > > > teach the verifier to recognize such special arguments of tracepoints.
> > > >
> > > > ok, so you mean to be able to mark it in event header like:
> > > >
> > > >   TRACE_EVENT(sched_pi_setprio,
> > > >         TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task __nullable),
> > > >
> > > > I guess we could make pahole to emit DECL_TAG for that argument,
> > > > but I'm not sure how to propagate that __nullable info to pahole
> > > >
> > > > while wondering about that, I tried the direct fix below ;-)
> > >
> > > We don't need to rush such a hack below.
> > > No need to add decl_tag and change pahole either.
> > > The arg name is already vmlinux BTF:
> > > [51371] FUNC_PROTO '(anon)' ret_type_id=0 vlen=3
> > >         '__data' type_id=61
> > >         'tsk' type_id=77
> > >         'pi_task' type_id=77
> > > [51372] FUNC '__bpf_trace_sched_pi_setprio' type_id=51371 linkage=static
> > >
> > > just need to rename "pi_task" to "pi_task__nullable"
> > > and teach the verifier.
> >
> > the problem is that btf_trace_<xxx> is typedef
> >
> >   typedef void (*btf_trace_##call)(void *__data, proto);
> >
> > and dwarf does not store argument names for subroutine type entry,
> > so it's not in BTF's TYPEDEF either
> >
> > it's the btf_trace_##call typedef ID that verifier has to work with,
> > I wonder we could somehow associate that ID with __bpf_trace_##call
> > subroutine entry which has the argument names
> >
> > we could store __bpf_trace_##call's BTF_ID in __bpf_raw_tp_map record,
> > but we'd need to do the lookup based on the tracepoint name when loading
> > the program .. ATM we do the lookup __bpf_raw_tp_map record only when
> > doing attach, so we would need to move it to program load time
> >
> > or we could 'fix' the argument names in pahole, but that'd probably
> > mean extra setup and hash lookup, so also not great
> 
> I would do a simple string search in vmlinux BTF for "__bpf_trace" + tp name.
> No need to add btf_id-s and waste memory to speed up the slow path.

I checked bit more and there are more tracepoints with the same issue,
the first diff stat looks like:

	 include/trace/events/afs.h                            | 44 ++++++++++++++++++++++----------------------
	 include/trace/events/cachefiles.h                     | 96 ++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
	 include/trace/events/ext4.h                           |  6 +++---
	 include/trace/events/fib.h                            | 16 ++++++++--------
	 include/trace/events/filelock.h                       | 38 +++++++++++++++++++-------------------
	 include/trace/events/host1x.h                         | 10 +++++-----
	 include/trace/events/huge_memory.h                    | 24 ++++++++++++------------
	 include/trace/events/kmem.h                           | 18 +++++++++---------
	 include/trace/events/netfs.h                          | 16 ++++++++--------
	 include/trace/events/power.h                          |  6 +++---
	 include/trace/events/qdisc.h                          |  8 ++++----
	 include/trace/events/rxrpc.h                          | 12 ++++++------
	 include/trace/events/sched.h                          | 12 ++++++------
	 include/trace/events/sunrpc.h                         |  8 ++++----
	 include/trace/events/tcp.h                            | 14 +++++++-------
	 include/trace/events/tegra_apb_dma.h                  |  6 +++---
	 include/trace/events/timer_migration.h                | 10 +++++-----
	 include/trace/events/writeback.h                      | 16 ++++++++--------

plus there's one case where pointer needs to be checked with IS_ERR in
include/trace/events/rdma_core.h trace_mr_alloc/mr_integ_alloc

I'm not excited about the '_nullable' argument suffix, because it's lot
of extra changes/renames in TP_fast_assign and it does not solve the
IS_ERR case above

I checked on the type tag and with llvm build we get the TYPE_TAG info
nicely in BTF:

	[119148] TYPEDEF 'btf_trace_sched_pi_setprio' type_id=119149
	[119149] PTR '(anon)' type_id=119150
	[119150] FUNC_PROTO '(anon)' ret_type_id=0 vlen=3
		'(anon)' type_id=27
		'(anon)' type_id=678
		'(anon)' type_id=119152
	[119151] TYPE_TAG 'nullable' type_id=679
	[119152] PTR '(anon)' type_id=119151

	[679] STRUCT 'task_struct' size=15424 vlen=277

which we can easily check in verifier.. the tracepoint definition would look like:

	-       TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task),
	+       TP_PROTO(struct task_struct *tsk, struct task_struct __nullable *pi_task),

and no other change in TP_fast_assign is needed

I think using the type tag for this is nicer, but I'm not sure where's
gcc at with btf_type_tag implementation, need to check on that

jirka

