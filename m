Return-Path: <bpf+bounces-58974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A21AC4A6B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC63317BA2B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED1E21C16B;
	Tue, 27 May 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILT3wfBM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70D202F8B
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335294; cv=none; b=BB6F0EXhXFAIMPhYc1D5A0a8uqX/6DSHqjdBlABXSnrY046I+BLDA3Hpfmu2rjESjOdOBrhOjcq3Qe3eIVOINEKDZBSx8HC1vmU0O+EOi0xR81Z8EG/kK/iL/CUfchLTsoyDINrWSvcspHzWMdy1Z/VA7HdioGO38PUsJ/LS3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335294; c=relaxed/simple;
	bh=cUnsFstUzy8xqPklaETnBhhsrmIrWsvn1tabp2LJk9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmhvSVL8DbM8b6QeLs4HCSg9XZTmpew8N7MstF4Bawk7jrrWmZPWiV2HnQfTMjg+/F26x6Y2MXJHrvisbbulr7pGjRITeaY339AvFWH3YsfprF1FJBSPzm/8iyYt7+uw5LslHZCU3C7j/r6Io3P7QtkpnmIWbvHhw8GeyuIuaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILT3wfBM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so39551636d6.2
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748335292; x=1748940092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7koMvbwJk44nT5CGAwVYivi7QHUEWn5brvCgXni+H0=;
        b=ILT3wfBM3xR+Oj27j6shbxoZ6NCAy5odkksaPvegXCv06e8ZVSP+/w0pevsEmwi4YJ
         nR9em77gdSphK5BMk2gizNFbkYK6eunUhouwwmbrbaRxT2HC2Xr4kpm6LnkUSqgACM/i
         JP9OV+LWkvoWqpoi/ZDGrfp73H+/X8lNXrjo8wixENGcO3rjAX7LcEJl4FKHIU6E0Jfw
         mtXSZTC4Eq/R+VPt2E61FyM2PTVhQIsI7l8m9gWBcG1ncZFyl8kJSuaansapa2jkuzRb
         7sWIY9RNEQ5uE0vtqnkMCh9uTpPb/ZnY87U5l35ZuktbkH/gpMqCTmWHjXvbWc3e8mlV
         Piuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748335292; x=1748940092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7koMvbwJk44nT5CGAwVYivi7QHUEWn5brvCgXni+H0=;
        b=aQDJPivhyLuS/SPKgKkpNW+qxOvQCeh9nAzBC4RjGxAhhg8kwEHCSqdX7mughV1e3U
         73My5RyV9ZiNvBxr5BpK9iKAjVROmnuMXIpGhQKgyFA9xxBb4vKWh+LDmm/nGK3EKGQ1
         desS1oUZv2pyo9Xk6A0J65WDBcQwSJOUezD6m0lzllQd9nr7oK6k8ecbk/7lchX0OAFu
         XJszfeX5HlN46UPhlSkpcMXxmV6qyajTdDCuhC479AXdT11C4iPKPh5WQFywnQQ5WOT4
         8yiYZ0Xcp8J5pQoaUElukoeFVKgv7LxQYDMuL5qNZa61xvR//Dm4Zw1Fxw1lX64M7lM2
         KMWA==
X-Forwarded-Encrypted: i=1; AJvYcCVmDQWXrKtkvxUazjNUTLrIt4Fow97qirAnp8BuZXTYNQzyH3ltgydo7Aa/BNCVNZ74vfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXlvhDdAbDzabGcDYtB0hlgccRTSECoQI7ENkULfRO4OY2a8hC
	ndY6g7R9prOQAI7Gx760+q1NsixasYcGTDKkxQGcYDu+yTg6dvPTevPwUgiae0rk+uRnS0kmdlz
	gTAEge/86OUzDGa7GUhSW/QpiWQkhrl4=
X-Gm-Gg: ASbGncuZGlTb0lBmFOnjKQ8mgo47QDJ7ha2Kgq9CpBvVpLpoTBNWt308wa7WairdwsE
	LnPRBtSgvYgv3R6u4b5/Fl//ByUemwAnFdguq9xDOgzfCpRy8D035GGd/hIl5cAm+HxqoSj5ZQB
	TEKTt9WmzDCHBIFDZQ74N5h930cnqQ/N+PiQ==
X-Google-Smtp-Source: AGHT+IHuCrWzUG0fJT8OJIIsUPBPrsS4ysWMb6JECnMWI9zkMLwYmv1B/AxHyD8tyxk+USC7j0jzwg+WbHsrmMz0dSo=
X-Received: by 2002:a05:6214:1d0d:b0:6f8:e2ab:cb8a with SMTP id
 6a1803df08f44-6fa9cfff18fmr210571496d6.5.1748335292009; Tue, 27 May 2025
 01:41:32 -0700 (PDT)
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
 <5f0aadb1-28a8-4be0-bad9-16b738840e57@redhat.com>
In-Reply-To: <5f0aadb1-28a8-4be0-bad9-16b738840e57@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 May 2025 16:40:55 +0800
X-Gm-Features: AX0GCFvuLlCWLi1cQHi5Z4H4JSeykG8tUlPJcDn10xANbbMNlkhwr2Sz-BwyJ30
Message-ID: <CALOAHbB-HtU9ERzxDaz8NoC4-BG5Lb7-dF0v16Bp2Ckr1M7JEw@mail.gmail.com>
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

On Tue, May 27, 2025 at 4:30=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> I don't think we want to add such a mechanism (new mode) where the
> >> primary configuration mechanism is through bpf.
> >>
> >> Maybe bpf could be used as an alternative, but we should look into a
> >> reasonable alternative first, like the discussed mctrl()/.../ raised i=
n
> >> the process_madvise() series.
> >>
> >> No "bpf" mode in disguise, please :)
> >
> > This goal can be readily achieved using a BPF program. In any case, it
> > is a feasible solution.
>
> No BPF-only solution.
>
> >
> >>
> >>> We could define
> >>> the API as follows:
> >>>
> >>> struct bpf_thp_ops {
> >>>          /**
> >>>           * @task_thp_mode: Get the THP mode for a specific task
> >>>           *
> >>>           * Return:
> >>>           * - TASK_THP_ALWAYS: "always" mode
> >>>           * - TASK_THP_MADVISE: "madvise" mode
> >>>           * - TASK_THP_NEVER: "never" mode
> >>>           * Future modes can also be added.
> >>>           */
> >>>          int (*task_thp_mode)(struct task_struct *p);
> >>> };
> >>>
> >>> For observability, we could add a "THP mode" field to
> >>> /proc/[pid]/status. For example:
> >>>
> >>> $ grep "THP mode" /proc/123/status
> >>> always
> >>> $ grep "THP mode" /proc/456/status
> >>> madvise
> >>> $ grep "THP mode" /proc/789/status
> >>> never
> >>>
> >>> The THP mode for each task would be determined by the attached BPF
> >>> program based on the task's attributes. We would place the BPF hook i=
n
> >>> appropriate kernel functions. Note that this setting wouldn't be
> >>> inherited during fork/exec - the BPF program would make the decision
> >>> dynamically for each task.
> >>
> >> What would be the mode (default) when the bpf program would not be act=
ive?
> >>
> >>> This approach also enables runtime adjustments to THP modes based on
> >>> system-wide conditions, such as memory fragmentation or other
> >>> performance overheads. The BPF program could adapt policies
> >>> dynamically, optimizing THP behavior in response to changing
> >>> workloads.
> >>
> >> I am not sure that is the proper way to handle these scenarios: I neve=
r
> >> heard that people would be adjusting the system-wide policy dynamicall=
y
> >> in that way either.
> >>
> >> Whatever we do, we have to make sure that what we add won't
> >> over-complicate things in the future. Having tooling dynamically adjus=
t
> >> the THP policy of processes that coarsely sounds ... very wrong long-t=
erm.
> >
> > This is just an example demonstrating how BPF can be used to adjust
> > its flexibility. Notably, all these policies can be implemented
> > without modifying the kernel.
>
> See below on "policy".
>
> >
> >>
> >>   > > As Liam pointed out in another thread, naming is challenging her=
e -
> >>> "process" might not be the most accurate term for this context.
> >>
> >> No, it's not even a per-process thing. It is per MM, and a MM might be
> >> used by multiple processes ...
> >
> > I consistently use 'thread' for the latter case.
>
> You can use CLONE_VM without CLONE_THREAD ...

If I understand correctly, this can only occur for shared THP but not
anonymous THP. For instance, if either process allocates an anonymous
THP, it would trigger the creation of a new MM. Please correct me if
I'm mistaken.

>
> Additionally, this
> > can be implemented per-MM without kernel code modifications.
> > With a well-designed API, users can even implement custom THP
> > policies=E2=80=94all without altering kernel code.
>
> You can switch between modes, that' all you can do. I wouldn't really
> call that "custom policy" as it is extremely limited.
>
> And that's exactly my point: it's basic switching between modes ... a
> reasonable policy in the future will make placement decisions and not
> just state "always/never/madvise".

Could you please elaborate further on 'make placement decisions'? As
previously mentioned, we (including the broader community) really need
the user input to determine whether THP allocation is appropriate in a
given case.

--=20
Regards
Yafang

