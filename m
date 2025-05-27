Return-Path: <bpf+bounces-58980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C367AC4BB2
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 11:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84793A8B04
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB92505A5;
	Tue, 27 May 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhJEs09f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5E24DFF3
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339044; cv=none; b=G11Mb06kuTdm/Pk/TO6IjvaW+XfgfHCBO+0/KQiSbQzSa5NRHx3TB3J4fbxc6ZJ+aPhVHUes+ndmG83za8YuVE8QhvccPI9DBdKQDQtooalf2qHDMxaHpflb4yodew6up8d6bhDIAtLtykwZ93a2NB2FTSFjsK/KTlpXaJS6cq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339044; c=relaxed/simple;
	bh=NJJPjuQeSdz0JJuO7figqiC29r8w4NK0aoY3IEPxM0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwC9Y6i0kN4eqxmCYVJbk2ENJ65ol+HwZ1otWej8w11Oq5hojTnTlnnxn5/pXPvbBmeeSdvXVHZoGrYuPeSw+dJxSNUwulE/wCtz0I9VJYd/VqJtbyN2BzL/z8vfnnz2fsq3cusD0AIbFjNadg4eLU8uQTqOlO7PZCpTgdpj5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhJEs09f; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f2b04a6169so33686796d6.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748339041; x=1748943841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N63HG5Y92FVIyGYtF9GWHOZMWzYb14mgOGmeAq1M4Zk=;
        b=WhJEs09fGg9FlVtxJwzwM1AOkJ2SUNBMutom/Wc0aKCLqGRA3vbvvdfvMLv54q0wIv
         F3HViKQAnOHcOzUKHcmztuhmTC5WOQ01EzjTQBQNIkAMq5q60oU/B56QUMUgyYbwvYwG
         jravFoLgA23GLgk7LLLfJbcnbv8/qfqxRhf7F/b7updTvyIVxyxUBnhlWUNW8WmUPfl0
         D6GTisnBN2RhrJN7jP6z5ZTvdMlZpIwG3GgJc1VFqaymvR0Q8aO9usfVi22uVTXHzu5r
         9kXVmekv0+ZoRi3RNztnvbE+xHnzVuveIaV9vBjW2n6b97GOE5nLeQmiF+togoOHD/gP
         tXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748339041; x=1748943841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N63HG5Y92FVIyGYtF9GWHOZMWzYb14mgOGmeAq1M4Zk=;
        b=MLTd+mc/oRnRSOQCVhtkyVp3+Gv50RD5G4n9xaby199TI0LD/u/4zsx5XpbRFPDGao
         vdjRGtk6DsFNMB2VsYA16ldTdgGc19B/QbKBAGAOy0XxHHpm4IKysIc3iFhKSvwYPPvo
         simJ9VIHROMDL9k/FfuUwCqNuEHph6ZRXOiN80MSxpXKuJBr6QSl5J56v1KDqT/pZ2jq
         7HAExa5W4nwLg0r7MiMxIqknI1ZibwMjJUh8X5y3QWPsTDhYwRtxc9n4VHPDOIK/hH6J
         SWU6Sem4dsMCom76COiDuMItXiKODgMFeDPqWoWa8dAyzz9KXFu7YgA+SJj6r/qoVLfm
         Lqng==
X-Forwarded-Encrypted: i=1; AJvYcCXd/nhSz8Lp+5YHNrkAtC9TzCEPyngiIelsu801pdSoMKV5zCdNocW6ElfmbYCVxm0vKyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMAF6yjeFVGVWQMaOaFg+Bv0GTIuIBaQRh1meZr4Ow1CsthmXu
	idnbHWZ0coRwj/kVFnWpyzNrXDjEXgXpUNvpkmvlW+nYJGEcx6giBWFsgiHjumXq7vv9whYbrQU
	bgbHBWPmod03XE4PMEkPVC7WlvFUYWUk=
X-Gm-Gg: ASbGncvnV9wFS3bMm3MKPVP6YNJUZJq+YCp0HHfJFkWr2L1Rw56upjAGcnEsci54cbr
	c4Tg3HBoJnytPSM4lCSMpAOq7GQSyKKNkaevX5Kkfo6xw7bg0jAw+MvmbZ7lPdtwKiqfZduYtu1
	HXZ7vX5X23SIRGWPUTNED0JSDFHHNW6nMteQ==
X-Google-Smtp-Source: AGHT+IGdNv2zziVNbElhr3cJOToNZON9YtqVKI7OLlWGgXLHr0FzfwqC0eobYdVSCnSNLAAsmfJTU+Op/72SKVtawQU=
X-Received: by 2002:a05:6214:ac6:b0:6e8:f17e:e00d with SMTP id
 6a1803df08f44-6fa9d01da5amr215870256d6.14.1748339041560; Tue, 27 May 2025
 02:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com> <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com> <CALOAHbBjueZhwrzp81FP-7C7ntEp5Uzaz26o2s=ZukVSmidEOA@mail.gmail.com>
 <ada2fcc0-3915-40e7-8908-b4d73a2eb050@redhat.com> <CALOAHbB9kuZ_8XJbTw98VuNtSdeUT=m9PAfO0uxsf4WaC3LXrA@mail.gmail.com>
 <5f0aadb1-28a8-4be0-bad9-16b738840e57@redhat.com> <CALOAHbB-HtU9ERzxDaz8NoC4-BG5Lb7-dF0v16Bp2Ckr1M7JEw@mail.gmail.com>
 <5d48d0c3-89a3-44da-bc1a-9a4601f146a4@redhat.com>
In-Reply-To: <5d48d0c3-89a3-44da-bc1a-9a4601f146a4@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 May 2025 17:43:24 +0800
X-Gm-Features: AX0GCFtwWKoF-RQmtZjDpQX-Dit9jZ_VJEAtyOSuVMZ9pHRZFkDt07JSG21M9Tw
Message-ID: <CALOAHbBUK=oPihkG22Z7L92rHNw-fB=p8zSk+1NFmzBjBENmVg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 5:27=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.05.25 10:40, Yafang Shao wrote:
> > On Tue, May 27, 2025 at 4:30=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >>>> I don't think we want to add such a mechanism (new mode) where the
> >>>> primary configuration mechanism is through bpf.
> >>>>
> >>>> Maybe bpf could be used as an alternative, but we should look into a
> >>>> reasonable alternative first, like the discussed mctrl()/.../ raised=
 in
> >>>> the process_madvise() series.
> >>>>
> >>>> No "bpf" mode in disguise, please :)
> >>>
> >>> This goal can be readily achieved using a BPF program. In any case, i=
t
> >>> is a feasible solution.
> >>
> >> No BPF-only solution.
> >>
> >>>
> >>>>
> >>>>> We could define
> >>>>> the API as follows:
> >>>>>
> >>>>> struct bpf_thp_ops {
> >>>>>           /**
> >>>>>            * @task_thp_mode: Get the THP mode for a specific task
> >>>>>            *
> >>>>>            * Return:
> >>>>>            * - TASK_THP_ALWAYS: "always" mode
> >>>>>            * - TASK_THP_MADVISE: "madvise" mode
> >>>>>            * - TASK_THP_NEVER: "never" mode
> >>>>>            * Future modes can also be added.
> >>>>>            */
> >>>>>           int (*task_thp_mode)(struct task_struct *p);
> >>>>> };
> >>>>>
> >>>>> For observability, we could add a "THP mode" field to
> >>>>> /proc/[pid]/status. For example:
> >>>>>
> >>>>> $ grep "THP mode" /proc/123/status
> >>>>> always
> >>>>> $ grep "THP mode" /proc/456/status
> >>>>> madvise
> >>>>> $ grep "THP mode" /proc/789/status
> >>>>> never
> >>>>>
> >>>>> The THP mode for each task would be determined by the attached BPF
> >>>>> program based on the task's attributes. We would place the BPF hook=
 in
> >>>>> appropriate kernel functions. Note that this setting wouldn't be
> >>>>> inherited during fork/exec - the BPF program would make the decisio=
n
> >>>>> dynamically for each task.
> >>>>
> >>>> What would be the mode (default) when the bpf program would not be a=
ctive?
> >>>>
> >>>>> This approach also enables runtime adjustments to THP modes based o=
n
> >>>>> system-wide conditions, such as memory fragmentation or other
> >>>>> performance overheads. The BPF program could adapt policies
> >>>>> dynamically, optimizing THP behavior in response to changing
> >>>>> workloads.
> >>>>
> >>>> I am not sure that is the proper way to handle these scenarios: I ne=
ver
> >>>> heard that people would be adjusting the system-wide policy dynamica=
lly
> >>>> in that way either.
> >>>>
> >>>> Whatever we do, we have to make sure that what we add won't
> >>>> over-complicate things in the future. Having tooling dynamically adj=
ust
> >>>> the THP policy of processes that coarsely sounds ... very wrong long=
-term.
> >>>
> >>> This is just an example demonstrating how BPF can be used to adjust
> >>> its flexibility. Notably, all these policies can be implemented
> >>> without modifying the kernel.
> >>
> >> See below on "policy".
> >>
> >>>
> >>>>
> >>>>    > > As Liam pointed out in another thread, naming is challenging =
here -
> >>>>> "process" might not be the most accurate term for this context.
> >>>>
> >>>> No, it's not even a per-process thing. It is per MM, and a MM might =
be
> >>>> used by multiple processes ...
> >>>
> >>> I consistently use 'thread' for the latter case.
> >>
> >> You can use CLONE_VM without CLONE_THREAD ...
> >
> > If I understand correctly, this can only occur for shared THP but not
> > anonymous THP. For instance, if either process allocates an anonymous
> > THP, it would trigger the creation of a new MM. Please correct me if
> > I'm mistaken.
>
> What clone(CLONE_VM) will do is essentially create a new process, that
> shares the MM with the original process. Similar to a thread, just that
> the new process will show up in /proc/ as ... a new process, not as a
> thread under /prod/$pid/tasks of the original process.
>
> Both processes will operate on the shared MM struct as if they were
> ordinary threads. No Copy-on-Write involved.
>
> One example use case I've been involved in is async teardown in QEMU [1].
>
> [1] https://kvm-forum.qemu.org/2022/ibm_async_destroy.pdf

I understand what you mean, but what I'm really confused about is how
this relates to allocating anonymous THP.  If either one allocates
anon THP, it will definitely create a new MM, right ?

>
> >
> >>
> >> Additionally, this
> >>> can be implemented per-MM without kernel code modifications.
> >>> With a well-designed API, users can even implement custom THP
> >>> policies=E2=80=94all without altering kernel code.
> >>
> >> You can switch between modes, that' all you can do. I wouldn't really
> >> call that "custom policy" as it is extremely limited.
> >>
> >> And that's exactly my point: it's basic switching between modes ... a
> >> reasonable policy in the future will make placement decisions and not
> >> just state "always/never/madvise".
> >
> > Could you please elaborate further on 'make placement decisions'? As
> > previously mentioned, we (including the broader community) really need
> > the user input to determine whether THP allocation is appropriate in a
> > given case.
>
> The glorious future were we make smarter decisions where to actually
> place THPs even in the "always" mode.
>
> E.g., just because we enable "always" for a process does not mean that
> we really want a THP everywhere; quite the opposite.

So 'always' simply means "the system doesn't guarantee THP allocation
will succeed" ? If that's the case, we should revisit RFC v1 [0],
where we proposed rejecting THP allocations in certain scenarios for
specific tasks.

[0] https://lwn.net/Articles/1019290/

>
> Treat the "always"/"madvise"/"never" as a rough mode, not a future-proof
> policy that we would want to fine-tune dynamically ... that would be
> very limiting.


--=20
Regards
Yafang

