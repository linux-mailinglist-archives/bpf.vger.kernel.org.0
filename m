Return-Path: <bpf+bounces-37267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB726952E64
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 14:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7581F24A3E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 12:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1517C9B1;
	Thu, 15 Aug 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGxtI2Fg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DA1494C5;
	Thu, 15 Aug 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725454; cv=none; b=cbGD7g0GJ/JUXgZIiLc6CrX6bgsQELVGlAdONnPAqBde7GIKue31aqCEGxtjULzpikW5LGLcavpaSxPNEsb7oTY3tBMIzQuLHIkpciSVu6dlwRd9IhPSDcNBN0pokX+4fbJ8MejIpv2o/xyNGLqT4d6cMNsYSXRtdxSAD/QOEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725454; c=relaxed/simple;
	bh=kbj8dDHta3loI3qZr0Co4zV9eXpMDtRWKuw7X/ujz1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox26gejYmwVe7bFRu/pV7CGFb2/L4V4x4EF5Q6QNFM9FyPeI/bZKjwKD/M5sge0tPba/P6EIX4XCsLSKSJ+kgDepUI4AqyBiAMUDZJQW9nFcGZtBTh7nS93l7s0vfsDUCWneHGisE9NkTgcnkSZzgiXc2d856K8lKAfT3+OpDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGxtI2Fg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4281c164408so5382805e9.1;
        Thu, 15 Aug 2024 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725450; x=1724330250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMFPhyPDje4jpSd10o9JuI8B2RI6fxXR4CqzNjcD9RI=;
        b=EGxtI2Fga7jMIl2ygdMQmZ/rBshx3WE2zedNiFK7BEqXZOuJgUyHGd+MLmTs1y4odo
         mFunRu+/mxhpTqNoLZWM6Vtmo9h/TBpy5c0bZE+iQV7vLWjr7q5GF68OgBgWWtl8ren9
         rrdQX0PPpDADKRIVpXeMOh0OnlwkAj3yoFmK6+TGhqwxnN4HETyM8xKQ55kPRAOMxqsk
         mvIMlxkv/aMgLc7zBXuFaGKRtATTxcuJRfFnoj9SHGGHfOnc9iB9cbuPpV2jsacpuatz
         7gXXuS8fcntvZPvXrQcSta9fjf2w4CVhzfbaQ54uid84cJIHGXmn2B9UvcvhHqs3UyXk
         azKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725450; x=1724330250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMFPhyPDje4jpSd10o9JuI8B2RI6fxXR4CqzNjcD9RI=;
        b=cQAT8dpRjpaoKugtDeE5N9KDqcpBBviZ9qbx21hcup0I04mAceFqVPH7fY3qbNmroZ
         ZE5r8K3GnLBdXKhSbP4UUrilG19gi+Mz4KfptSxV2FhOgQRFGSdH7jCpMWzDtb5S9nHR
         eBx+5c9i4tyWbAdDpPCWumg+UKKE8yQD7ZY6FAWMPBaP5bkGwZQODh/D3Y9w004XNnxT
         DaAspIzeHsc6uQJqwagh6IdZBpZqx47XlYtq/9kBNMPoyr8RRBWZf9ByAL3Z1V9+1Rw3
         JuYSJk0ppfgcko62I73v5/FOL+liZf1TnD0MraKOI94z1FJ/YSWOp18srgscXJUy5Vxo
         4Z1A==
X-Forwarded-Encrypted: i=1; AJvYcCVK9IWBGsc6ldRqoH2kOQ/X3lDovwFsrBoZJN4NwvRJGpohZ4X0kG6jOU1dIyYzL9JM0e5eaj3xxXC1fcoRG4Xk9/a8ipOSwZUXU6/h9fzXxHSLZ14R1q/LoHuBNfHUJARo
X-Gm-Message-State: AOJu0YxPgospCVwXO+YS0uor2k0OpLtufPkD/KwS0xSMPjwpCm9CzLkD
	uXZRbgOQ9Q96usLoPZvphilGpFdfJJD1gc2iP8WLVEZZYtwnjRt75sCgoDOOW9A+0grekbJykh2
	I9U9h4z8/NeRr7c6pg2JJnC+vagkGdW71
X-Google-Smtp-Source: AGHT+IEKATzPXIuqHcL5ZBrvKEZEeieT7ZMFkhyr5jG9qSLWBFz8VFn5TTUzc8QRrnJ/aL0wyoEOlkwvVJVTQN9KyJE=
X-Received: by 2002:a05:600c:1e0c:b0:426:6f38:8974 with SMTP id
 5b1f17b1804b1-429dd22f3eemr37482005e9.6.1723725449568; Thu, 15 Aug 2024
 05:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava> <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
 <ZrIj9jkXqpKXRuS7@krava> <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
 <ZrSh8AuV21AKHfNg@krava> <CAADnVQLYxdKn-J2-2iXKKKTg=o6xkKWzV2WyYrnmQ-j62b9STA@mail.gmail.com>
 <Zr3q8ihbe8cUdpfp@krava>
In-Reply-To: <Zr3q8ihbe8cUdpfp@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Aug 2024 14:37:18 +0200
Message-ID: <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Artem Savkov <asavkov@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 1:48=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Aug 08, 2024 at 08:43:05AM -0700, Alexei Starovoitov wrote:
> > On Thu, Aug 8, 2024 at 3:46=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Tue, Aug 06, 2024 at 11:44:52AM -0700, Alexei Starovoitov wrote:
> > > > On Tue, Aug 6, 2024 at 6:24=E2=80=AFAM Jiri Olsa <olsajiri@gmail.co=
m> wrote:
> > > > >
> > > > > > Jiri,
> > > > > >
> > > > > > the verifier removes the check because it assumes that pointers
> > > > > > passed by the kernel into tracepoint are valid and trusted.
> > > > > > In this case:
> > > > > >         trace_sched_pi_setprio(p, pi_task);
> > > > > >
> > > > > > pi_task can be NULL.
> > > > > >
> > > > > > We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_=
MAYBE_NULL
> > > > > > by default, since it will break a bunch of progs.
> > > > > > Instead we can annotate this tracepoint arg as __nullable and
> > > > > > teach the verifier to recognize such special arguments of trace=
points.
> > > > >
> > > > > ok, so you mean to be able to mark it in event header like:
> > > > >
> > > > >   TRACE_EVENT(sched_pi_setprio,
> > > > >         TP_PROTO(struct task_struct *tsk, struct task_struct *pi_=
task __nullable),
> > > > >
> > > > > I guess we could make pahole to emit DECL_TAG for that argument,
> > > > > but I'm not sure how to propagate that __nullable info to pahole
> > > > >
> > > > > while wondering about that, I tried the direct fix below ;-)
> > > >
> > > > We don't need to rush such a hack below.
> > > > No need to add decl_tag and change pahole either.
> > > > The arg name is already vmlinux BTF:
> > > > [51371] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D3
> > > >         '__data' type_id=3D61
> > > >         'tsk' type_id=3D77
> > > >         'pi_task' type_id=3D77
> > > > [51372] FUNC '__bpf_trace_sched_pi_setprio' type_id=3D51371 linkage=
=3Dstatic
> > > >
> > > > just need to rename "pi_task" to "pi_task__nullable"
> > > > and teach the verifier.
> > >
> > > the problem is that btf_trace_<xxx> is typedef
> > >
> > >   typedef void (*btf_trace_##call)(void *__data, proto);
> > >
> > > and dwarf does not store argument names for subroutine type entry,
> > > so it's not in BTF's TYPEDEF either
> > >
> > > it's the btf_trace_##call typedef ID that verifier has to work with,
> > > I wonder we could somehow associate that ID with __bpf_trace_##call
> > > subroutine entry which has the argument names
> > >
> > > we could store __bpf_trace_##call's BTF_ID in __bpf_raw_tp_map record=
,
> > > but we'd need to do the lookup based on the tracepoint name when load=
ing
> > > the program .. ATM we do the lookup __bpf_raw_tp_map record only when
> > > doing attach, so we would need to move it to program load time
> > >
> > > or we could 'fix' the argument names in pahole, but that'd probably
> > > mean extra setup and hash lookup, so also not great
> >
> > I would do a simple string search in vmlinux BTF for "__bpf_trace" + tp=
 name.
> > No need to add btf_id-s and waste memory to speed up the slow path.
>
> I checked bit more and there are more tracepoints with the same issue,
> the first diff stat looks like:
>
>          include/trace/events/afs.h                            | 44 +++++=
+++++++++++++++++----------------------
>          include/trace/events/cachefiles.h                     | 96 +++++=
+++++++++++++++++++++++++++++++++++++++++++--------------------------------=
----------------
>          include/trace/events/ext4.h                           |  6 +++--=
-
>          include/trace/events/fib.h                            | 16 +++++=
+++--------
>          include/trace/events/filelock.h                       | 38 +++++=
++++++++++++++-------------------
>          include/trace/events/host1x.h                         | 10 +++++=
-----
>          include/trace/events/huge_memory.h                    | 24 +++++=
+++++++------------
>          include/trace/events/kmem.h                           | 18 +++++=
++++---------
>          include/trace/events/netfs.h                          | 16 +++++=
+++--------
>          include/trace/events/power.h                          |  6 +++--=
-
>          include/trace/events/qdisc.h                          |  8 ++++-=
---
>          include/trace/events/rxrpc.h                          | 12 +++++=
+------
>          include/trace/events/sched.h                          | 12 +++++=
+------
>          include/trace/events/sunrpc.h                         |  8 ++++-=
---
>          include/trace/events/tcp.h                            | 14 +++++=
++-------
>          include/trace/events/tegra_apb_dma.h                  |  6 +++--=
-
>          include/trace/events/timer_migration.h                | 10 +++++=
-----
>          include/trace/events/writeback.h                      | 16 +++++=
+++--------
>
> plus there's one case where pointer needs to be checked with IS_ERR in
> include/trace/events/rdma_core.h trace_mr_alloc/mr_integ_alloc
>
> I'm not excited about the '_nullable' argument suffix, because it's lot
> of extra changes/renames in TP_fast_assign and it does not solve the
> IS_ERR case above
>
> I checked on the type tag and with llvm build we get the TYPE_TAG info
> nicely in BTF:
>
>         [119148] TYPEDEF 'btf_trace_sched_pi_setprio' type_id=3D119149
>         [119149] PTR '(anon)' type_id=3D119150
>         [119150] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D3
>                 '(anon)' type_id=3D27
>                 '(anon)' type_id=3D678
>                 '(anon)' type_id=3D119152
>         [119151] TYPE_TAG 'nullable' type_id=3D679
>         [119152] PTR '(anon)' type_id=3D119151
>
>         [679] STRUCT 'task_struct' size=3D15424 vlen=3D277
>
> which we can easily check in verifier.. the tracepoint definition would l=
ook like:
>
>         -       TP_PROTO(struct task_struct *tsk, struct task_struct *pi_=
task),
>         +       TP_PROTO(struct task_struct *tsk, struct task_struct __nu=
llable *pi_task),
>
> and no other change in TP_fast_assign is needed
>
> I think using the type tag for this is nicer, but I'm not sure where's
> gcc at with btf_type_tag implementation, need to check on that

Unfortunately last time I heard gcc was still far.
So we cannot rely on decl_tag or type_tag yet.
Aside from __nullable we would need another suffix to indicate is_err.

Maybe we can do something with the TP* macro?
So the suffix only seen one place instead of search-and-replace
through the body?

but imo above diff stat doesn't look too bad.

