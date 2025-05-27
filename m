Return-Path: <bpf+bounces-58970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFEAC49F7
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 10:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E572167D10
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8813E1D6195;
	Tue, 27 May 2025 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYMDnDAf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDB1F4624
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333670; cv=none; b=CEtal47HN351SUrGHs4vc3QZ8N4nN2Rz+QlfiJ3lJwPJmxgMRFI7bxlDI1y04i+AC/YyFO3PmZFcex/reGo3Pwu1EH04yjJO/d7rpLWpKnrNAd8L5GCybxJE1tnchf7uotxm33ufRV9JzgW4SQ6RP0nATgakKIXW24Ne21gZkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333670; c=relaxed/simple;
	bh=diiGlRrYjOALVg+hO+cX2xhOeDnSiPH8EHcMMf93uDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btTx5Tj6/oR67HGocfHOt61JIg7pongs8xgvhUDs52cedHtgtfuEW4Jn8ZhYpi176oCr663aS1FHvJfmzf0JJOlHlTXEXvLwmgKbJZlUOobAPLY2mnzlOc1JjZABuB6T8SL2dOwNjaIV0TMqvc+Z9WLkrJHFZYrIRt+5yf2BIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYMDnDAf; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6faa19e0661so25714796d6.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748333667; x=1748938467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaNQTaEyUd3zGpDeyMxKJHVSUTBrFb5+VNEBkzCYBC0=;
        b=OYMDnDAfgW8VaP/b3c0rmlHEbALaZLRrvVmEs5AUiF8+xvFVuv+1y478F6iwZEovoG
         /EDxaXV7gUdSVEeNmUYnt4iTLQgZtZtNHwc2wzdmrG1fdMXlZ1h4EVCj4IgLRjt5Pren
         SYBic5vyqXpK2FMnabQ7Cia9Pzvj2Fu0yBm5P9jdVDFNq2j8jSRhjWV4YKQ7GQInH3Qw
         1UZlwA9ZoI3TUydFNbCmyMoZzJBcHHYVoC/A47qTKMJtvmCrr8An3Izvq6ewAjzP867l
         OGW6IfuDWU0JN5n4OS7DTkHf1Zuqi/TQQtKHDBd21bkymIivt4vDSyR7lS75Mx1KUYXG
         MkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748333667; x=1748938467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaNQTaEyUd3zGpDeyMxKJHVSUTBrFb5+VNEBkzCYBC0=;
        b=wkr0+EN+bzBAanvLWlc3B51Z6Kt7rNaFISC1gpHdydQB3sralSPpCA89fLiRxg95KV
         iCSzwAzPtFxHvvrpligxVHSHCYXbNLxXhjPUtA5KP+P1oOQc5OI7s5GcdjTEVfmujula
         OKhBnHgknbI2qeus9Cg6sCF7OhQ36tJfyHqPbXf2l9yu+InbI6rDiw8T/O5xnmqRRw9a
         dE6KS3ZvqEYOsZfr/rAN9+kALCJXiiS5otXIO6/1cw6HXHGyfrfhmhSlwlVi9PUno2JV
         CbFDsZAeHOPaGV6Sxk/X72Xdc7GY2V3HgtUzWoX9DY0hiBEbrGxFVjJHxjzflOfTW19A
         /z1A==
X-Forwarded-Encrypted: i=1; AJvYcCUcPbgm37AkjoqKYrIPlIoH7iKyEnDQQxlCfDTluJHb+LNlQ2hEy+aJRyNfyFa4pmuJsN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoIiZLkqvrmHD/eWIyfl19Lnjkv7kEiRhfDD0hGXLlwOoPL3p
	XHHxK9SF8mW4MdqDOtlIQdj6TxCbfNB0908+CusqRtvp2pbo4VeSTHzxcXPHUK1+WzGohI5vl4Y
	S7JMu90tdenR/uLuXLK/tzH1+VmJkoP0=
X-Gm-Gg: ASbGncsy8HZI6Wgb6US66LtlT0ytcfCHs46ZwU4fSLPsKJDGrpguZigobigs6sgZ96X
	WzjVdJJ6XYlRlJnN927BalrodgxjB1zLh8f1hURSl4kDyRHk3+bvWJsjTklv50UJk5hJcJUOqrf
	8ve+/JGwjM95sB4pUavCFiX9D2Dz9WdLqv+Q==
X-Google-Smtp-Source: AGHT+IF6UnFIGNe0BPCY8Q18oxqWJXZOD7gK9UnA0fz8D/U6DdNI3gV5KMfQ980OtKU+zyTPjxjZ5DIsXeoV3uwV0sw=
X-Received: by 2002:a05:6214:5c4:b0:6fa:9d5a:ae6e with SMTP id
 6a1803df08f44-6fa9d5ab650mr108180316d6.6.1748333667026; Tue, 27 May 2025
 01:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com> <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com> <CALOAHbBjueZhwrzp81FP-7C7ntEp5Uzaz26o2s=ZukVSmidEOA@mail.gmail.com>
 <ada2fcc0-3915-40e7-8908-b4d73a2eb050@redhat.com>
In-Reply-To: <ada2fcc0-3915-40e7-8908-b4d73a2eb050@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 May 2025 16:13:50 +0800
X-Gm-Features: AX0GCFsz_Jg5WjvVW8_sdkCN2L2PMZnv99cPfGyCRD3M5sN8ZyrxgdPDk13oj7Y
Message-ID: <CALOAHbB9kuZ_8XJbTw98VuNtSdeUT=m9PAfO0uxsf4WaC3LXrA@mail.gmail.com>
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

On Tue, May 27, 2025 at 3:58=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.05.25 07:46, Yafang Shao wrote:
> > On Mon, May 26, 2025 at 6:49=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 26.05.25 11:37, Yafang Shao wrote:
> >>> On Mon, May 26, 2025 at 4:14=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>>> Hi all,
> >>>>>
> >>>>> Let=E2=80=99s summarize the current state of the discussion and ide=
ntify how
> >>>>> to move forward.
> >>>>>
> >>>>> - Global-Only Control is Not Viable
> >>>>> We all seem to agree that a global-only control for THP is unwise. =
In
> >>>>> practice, some workloads benefit from THP while others do not, so a
> >>>>> one-size-fits-all approach doesn=E2=80=99t work.
> >>>>>
> >>>>> - Should We Use "Always" or "Madvise"?
> >>>>> I suspect no one would choose 'always' in its current state. ;)
> >>>>
> >>>> IIRC, RHEL9 has the default set to "always" for a long time.
> >>>
> >>> good to know.
> >>>
> >>>>
> >>>> I guess it really depends on how different the workloads are that yo=
u
> >>>> are running on the same machine.
> >>>
> >>> Correct. If we want to enable THP for specific workloads without
> >>> modifying the kernel, we must isolate them on dedicated servers.
> >>> However, this approach wastes resources and is not an acceptable
> >>> solution.
> >>>
> >>>>
> >>>>    > Both Lorenzo and David propose relying on the madvise mode. How=
ever,>
> >>>> since madvise is an unprivileged userspace mechanism, any user can
> >>>>> freely adjust their THP policy. This makes fine-grained control
> >>>>> impossible without breaking userspace compatibility=E2=80=94an unde=
sirable
> >>>>> tradeoff.
> >>>>
> >>>> If required, we could look into a "sealing" mechanism, that would
> >>>> essentially lock modification attempts performed by the process (i.e=
.,
> >>>> MADV_HUGEPAGE).
> >>>
> >>> If we don=E2=80=99t introduce a new THP mode and instead rely solely =
on
> >>> madvise, the "sealing" mechanism could either violate the intended
> >>> semantics of madvise(), or simply break madvise() entirely, right?
> >>
> >> We would have to be a bit careful, yes.
> >>
> >> Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, because
> >> these options also fail with -EINVAL on kernels without THP support.
> >>
> >> Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.
> >>
> >> What you likely really want to do is seal when you configured
> >> MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.
> >>
> >>>>
> >>>> The could be added on top of the current proposals that are flying
> >>>> around, and could be done e.g., per-process.
> >>>
> >>> How about introducing a dedicated "process" mode? This would allow
> >>> each process to use different THP modes=E2=80=94some in "always," oth=
ers in
> >>> "madvise," and the rest in "never." Future THP modes could also be
> >>> added to this framework.
> >>
> >> We have to be really careful about not creating even more mess with mo=
re
> >> modes.
> >>
> >> How would that design look like in detail (how would we set it per
> >> process etc?)?
> >
> > I have a preliminary idea to implement this using BPF.
>
> I don't think we want to add such a mechanism (new mode) where the
> primary configuration mechanism is through bpf.
>
> Maybe bpf could be used as an alternative, but we should look into a
> reasonable alternative first, like the discussed mctrl()/.../ raised in
> the process_madvise() series.
>
> No "bpf" mode in disguise, please :)

This goal can be readily achieved using a BPF program. In any case, it
is a feasible solution.

>
> > We could define
> > the API as follows:
> >
> > struct bpf_thp_ops {
> >         /**
> >          * @task_thp_mode: Get the THP mode for a specific task
> >          *
> >          * Return:
> >          * - TASK_THP_ALWAYS: "always" mode
> >          * - TASK_THP_MADVISE: "madvise" mode
> >          * - TASK_THP_NEVER: "never" mode
> >          * Future modes can also be added.
> >          */
> >         int (*task_thp_mode)(struct task_struct *p);
> > };
> >
> > For observability, we could add a "THP mode" field to
> > /proc/[pid]/status. For example:
> >
> > $ grep "THP mode" /proc/123/status
> > always
> > $ grep "THP mode" /proc/456/status
> > madvise
> > $ grep "THP mode" /proc/789/status
> > never
> >
> > The THP mode for each task would be determined by the attached BPF
> > program based on the task's attributes. We would place the BPF hook in
> > appropriate kernel functions. Note that this setting wouldn't be
> > inherited during fork/exec - the BPF program would make the decision
> > dynamically for each task.
>
> What would be the mode (default) when the bpf program would not be active=
?
>
> > This approach also enables runtime adjustments to THP modes based on
> > system-wide conditions, such as memory fragmentation or other
> > performance overheads. The BPF program could adapt policies
> > dynamically, optimizing THP behavior in response to changing
> > workloads.
>
> I am not sure that is the proper way to handle these scenarios: I never
> heard that people would be adjusting the system-wide policy dynamically
> in that way either.
>
> Whatever we do, we have to make sure that what we add won't
> over-complicate things in the future. Having tooling dynamically adjust
> the THP policy of processes that coarsely sounds ... very wrong long-term=
.

This is just an example demonstrating how BPF can be used to adjust
its flexibility. Notably, all these policies can be implemented
without modifying the kernel.

>
>  > > As Liam pointed out in another thread, naming is challenging here -
> > "process" might not be the most accurate term for this context.
>
> No, it's not even a per-process thing. It is per MM, and a MM might be
> used by multiple processes ...

I consistently use 'thread' for the latter case. Additionally, this
can be implemented per-MM without kernel code modifications.
With a well-designed API, users can even implement custom THP
policies=E2=80=94all without altering kernel code.

--=20
Regards
Yafang

