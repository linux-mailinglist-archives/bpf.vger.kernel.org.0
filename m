Return-Path: <bpf+bounces-59052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCDDAC5F11
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BFD189DC72
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A791B0F1E;
	Wed, 28 May 2025 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtCZlflN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A031531E3
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748397939; cv=none; b=ngjYcSOFLoV5KJDhvpvKPjMypMgW5T3pJXnMOVVD9tF1gGQpqw/fgPH2QG/iL4mRrpMs97niaZafsYD4Rf084vr8Tw4/1xxlrN8oddUi41rVDz7pKqLlMpHOA7iNwHs3jrdG1FIm701KaxchOnsOHYKuaZaE0EqgNEs23trJpFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748397939; c=relaxed/simple;
	bh=IFfQKAij5BIJu4eTh80So3Iagi8L59yy3jPUOxxE6qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1asho8b2jG8J7N0yxvhTmtuHFjDbHif6lll/dRCtLMjfYMIG/R0lIBL9P7r+75ikokmi5AJLu8N7ASC6wy1MnI2mYss/BTen5Aobwn55OZTPvypdRdCpHXvYiKPbHaiF1cf8CZYQ0eOIA1N0BirbkNgYtdXTurojc0U6Bbx3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtCZlflN; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8d663fa22so52168216d6.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 19:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748397936; x=1749002736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cew7xGCjKJyTF9UQgzRcATvY1dIa35IHDV0I0x7sUac=;
        b=HtCZlflNRzst1TqG+0nqxm/MOFtSq5QfT2DiblIL8CB/Tf2lGsJBIo7YRxiBcrijvG
         bTWMMM9TRPvurmIGz3DbBOYb/mka61hqMUM6tvuZbC7xJTOYdUdY7SwhzQT2r5wuaOzD
         6P/bCc9w6qScAtgmHsxy+dfvASIHRAXgDjanENHNSyaCK7Gx9AMJOhsZ3VS6bDdPa/Lp
         Kril7IHJBAq3n1IyydvFEqj1uT7hL5cIvifiC1kCezhAHTnN2/pXOYFO6th5GarMIeFy
         /gY0gzJdSt3MASQDnG7OxYQcbvquTNnXF+Kwv4+P6cEbyI7F+cxDNdPWmHAEPbVTJeVK
         a7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748397936; x=1749002736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cew7xGCjKJyTF9UQgzRcATvY1dIa35IHDV0I0x7sUac=;
        b=LPFkRXDd/SZ6eto2Go3jV5Y3mjKCZNl/4gNtQvQ7Dk2Q8vFvH8gJ5ocKaHhtCPTseI
         +FDUmE/WtltCTT75dCuYtx2C3JqwF8wHVDKQgAhMAdSvkkd2NfC2JXuD1NBNG0bcWlCC
         nTDQ85KgEPr3tzbQjOm/W2jnASpEWTdJ30ABgT6BqzFGaFmivPAqfcUNGktXjV4RUTPR
         kCVNFPFj6J/iOLVmQcbdiZfV7v8ayKEWV1GC/gA8tO1BbvVOGhm5N6kFf7LDGxxWHzoA
         6uBBBDj8DZ1RSP+HA/lcnld/c0Qeb0uAQmc9uGbE+PwXwFSZFHti0S4e24B+51K2L16P
         UP8w==
X-Forwarded-Encrypted: i=1; AJvYcCVYxkhRuDUzNxzijdfo0kdIs2Om+MaaIcKhpxK9amcY8PnNC28EGJsLvwJs7XWEI24f+aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhHcgfVWakYl8mGsLGydKip5gfCJWCpsUToVUXPO7LKDNBTha
	6ujoDUgzJ0bL4rQwFdzjCISLWTdMckQYuXDAxUYCzME+QAMagY6hp8npP4bkShNl392qSYGRnk4
	/VnKJzbUGeGQy6GsuHuXAxZml7sH9zHw=
X-Gm-Gg: ASbGncvPkxZxg50/YZAXkL25bt3or9F/w6f8TI04N4nmrob0R3PUXr6EOpZZyFfGj+B
	749DeqaNj4Az7CaTkBi+ONFusNI2J2zSBTFeW0dKrQd4c7B0deJnKuO+/YMXtzi3JTaURIXKVwf
	9qqE47BbPxqjMREAtbLNDJVWUQDSzOrr3Vdytn7ic/ZRA9
X-Google-Smtp-Source: AGHT+IGy9AW7RTT4Jh6tlgVPViqs58QoT+47agRa9FVD8kOyFA4Mvk23OuiwU4jifYLb00X2c8boUK2mylQSqQF3MyI=
X-Received: by 2002:ad4:5ec9:0:b0:6e8:f3ec:5406 with SMTP id
 6a1803df08f44-6fa9d13624dmr263259046d6.19.1748397936285; Tue, 27 May 2025
 19:05:36 -0700 (PDT)
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
 <5d48d0c3-89a3-44da-bc1a-9a4601f146a4@redhat.com> <CALOAHbBUK=oPihkG22Z7L92rHNw-fB=p8zSk+1NFmzBjBENmVg@mail.gmail.com>
 <aa7ea2f4-da94-4850-8225-0fb6e0e32767@redhat.com>
In-Reply-To: <aa7ea2f4-da94-4850-8225-0fb6e0e32767@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 28 May 2025 10:04:59 +0800
X-Gm-Features: AX0GCFtA_GfBosUVJr0x5-sgy2b7fijVdN8EBjj7HnWXkYTnkE3TdA3OmWFSgPg
Message-ID: <CALOAHbCRc=t9o7HGqxAHpgzKmt4xBYjwQ6zGWZXm2E-zu1SjHQ@mail.gmail.com>
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

On Tue, May 27, 2025 at 8:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.05.25 11:43, Yafang Shao wrote:
> > On Tue, May 27, 2025 at 5:27=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 27.05.25 10:40, Yafang Shao wrote:
> >>> On Tue, May 27, 2025 at 4:30=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>>>> I don't think we want to add such a mechanism (new mode) where the
> >>>>>> primary configuration mechanism is through bpf.
> >>>>>>
> >>>>>> Maybe bpf could be used as an alternative, but we should look into=
 a
> >>>>>> reasonable alternative first, like the discussed mctrl()/.../ rais=
ed in
> >>>>>> the process_madvise() series.
> >>>>>>
> >>>>>> No "bpf" mode in disguise, please :)
> >>>>>
> >>>>> This goal can be readily achieved using a BPF program. In any case,=
 it
> >>>>> is a feasible solution.
> >>>>
> >>>> No BPF-only solution.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>> We could define
> >>>>>>> the API as follows:
> >>>>>>>
> >>>>>>> struct bpf_thp_ops {
> >>>>>>>            /**
> >>>>>>>             * @task_thp_mode: Get the THP mode for a specific tas=
k
> >>>>>>>             *
> >>>>>>>             * Return:
> >>>>>>>             * - TASK_THP_ALWAYS: "always" mode
> >>>>>>>             * - TASK_THP_MADVISE: "madvise" mode
> >>>>>>>             * - TASK_THP_NEVER: "never" mode
> >>>>>>>             * Future modes can also be added.
> >>>>>>>             */
> >>>>>>>            int (*task_thp_mode)(struct task_struct *p);
> >>>>>>> };
> >>>>>>>
> >>>>>>> For observability, we could add a "THP mode" field to
> >>>>>>> /proc/[pid]/status. For example:
> >>>>>>>
> >>>>>>> $ grep "THP mode" /proc/123/status
> >>>>>>> always
> >>>>>>> $ grep "THP mode" /proc/456/status
> >>>>>>> madvise
> >>>>>>> $ grep "THP mode" /proc/789/status
> >>>>>>> never
> >>>>>>>
> >>>>>>> The THP mode for each task would be determined by the attached BP=
F
> >>>>>>> program based on the task's attributes. We would place the BPF ho=
ok in
> >>>>>>> appropriate kernel functions. Note that this setting wouldn't be
> >>>>>>> inherited during fork/exec - the BPF program would make the decis=
ion
> >>>>>>> dynamically for each task.
> >>>>>>
> >>>>>> What would be the mode (default) when the bpf program would not be=
 active?
> >>>>>>
> >>>>>>> This approach also enables runtime adjustments to THP modes based=
 on
> >>>>>>> system-wide conditions, such as memory fragmentation or other
> >>>>>>> performance overheads. The BPF program could adapt policies
> >>>>>>> dynamically, optimizing THP behavior in response to changing
> >>>>>>> workloads.
> >>>>>>
> >>>>>> I am not sure that is the proper way to handle these scenarios: I =
never
> >>>>>> heard that people would be adjusting the system-wide policy dynami=
cally
> >>>>>> in that way either.
> >>>>>>
> >>>>>> Whatever we do, we have to make sure that what we add won't
> >>>>>> over-complicate things in the future. Having tooling dynamically a=
djust
> >>>>>> the THP policy of processes that coarsely sounds ... very wrong lo=
ng-term.
> >>>>>
> >>>>> This is just an example demonstrating how BPF can be used to adjust
> >>>>> its flexibility. Notably, all these policies can be implemented
> >>>>> without modifying the kernel.
> >>>>
> >>>> See below on "policy".
> >>>>
> >>>>>
> >>>>>>
> >>>>>>     > > As Liam pointed out in another thread, naming is challengi=
ng here -
> >>>>>>> "process" might not be the most accurate term for this context.
> >>>>>>
> >>>>>> No, it's not even a per-process thing. It is per MM, and a MM migh=
t be
> >>>>>> used by multiple processes ...
> >>>>>
> >>>>> I consistently use 'thread' for the latter case.
> >>>>
> >>>> You can use CLONE_VM without CLONE_THREAD ...
> >>>
> >>> If I understand correctly, this can only occur for shared THP but not
> >>> anonymous THP. For instance, if either process allocates an anonymous
> >>> THP, it would trigger the creation of a new MM. Please correct me if
> >>> I'm mistaken.
> >>
> >> What clone(CLONE_VM) will do is essentially create a new process, that
> >> shares the MM with the original process. Similar to a thread, just tha=
t
> >> the new process will show up in /proc/ as ... a new process, not as a
> >> thread under /prod/$pid/tasks of the original process.
> >>
> >> Both processes will operate on the shared MM struct as if they were
> >> ordinary threads. No Copy-on-Write involved.
> >>
> >> One example use case I've been involved in is async teardown in QEMU [=
1].
> >>
> >> [1] https://kvm-forum.qemu.org/2022/ibm_async_destroy.pdf
> >
> > I understand what you mean, but what I'm really confused about is how
> > this relates to allocating anonymous THP.  If either one allocates
> > anon THP, it will definitely create a new MM, right ?
>
> No. They work on the same address space - same MM. Either can allocate a
> new anon THP and the other one would be able to modify it. No fork/CoW.
>
> I only bring it up because it's two "processes" sharing the same MM. And
> the THP mode in your proposal would actually be per-MM and not per proces=
s.
>
> It's confusing ... :)

Thanks for the explanation.

>
> >
> >>
> >>>
> >>>>
> >>>> Additionally, this
> >>>>> can be implemented per-MM without kernel code modifications.
> >>>>> With a well-designed API, users can even implement custom THP
> >>>>> policies=E2=80=94all without altering kernel code.
> >>>>
> >>>> You can switch between modes, that' all you can do. I wouldn't reall=
y
> >>>> call that "custom policy" as it is extremely limited.
> >>>>
> >>>> And that's exactly my point: it's basic switching between modes ... =
a
> >>>> reasonable policy in the future will make placement decisions and no=
t
> >>>> just state "always/never/madvise".
> >>>
> >>> Could you please elaborate further on 'make placement decisions'? As
> >>> previously mentioned, we (including the broader community) really nee=
d
> >>> the user input to determine whether THP allocation is appropriate in =
a
> >>> given case.
> >>
> >> The glorious future were we make smarter decisions where to actually
> >> place THPs even in the "always" mode.
> >>
> >> E.g., just because we enable "always" for a process does not mean that
> >> we really want a THP everywhere; quite the opposite.
> >
> > So 'always' simply means "the system doesn't guarantee THP allocation
> > will succeed" ?
>
> I mean, with THPs, there are no guarantees, ever :(
>
> > If that's the case, we should revisit RFC v1 [0],
> > where we proposed rejecting THP allocations in certain scenarios for
> > specific tasks.
>
> Hooking into actual page allocation during page faults (e.g., THP size,
> khugepaged collapse decisions) is IMHO a much better application of ebpf
> than setting a THP mode per process (or MM ... ) using epbf.
>
> So yes, you could drive the system in "always" mode and decide to not
> allocate THPs during page faults / khugepaged for specific processes.
>
> IMHO that also does not contradict the VM_HUGEPAGE / VM_NOHUGEPAGE
> default setting proposal: VM_HUGEPAGE could feed into the epbf program
> as yet another parameter to make a decision.

That seems like a viable solution. Thank you for your help.

--=20
Regards
Yafang

