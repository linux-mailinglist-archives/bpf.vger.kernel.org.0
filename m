Return-Path: <bpf+bounces-75673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90301C90AD8
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 03:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD19A3AD96B
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6B2BD5A8;
	Fri, 28 Nov 2025 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irEmi44f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042D2857CD
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298474; cv=none; b=t3eNGsd5aY1+vey2ngvLX7/pdRhKe/h8yuFnQ0e8IJaI8mR7hNdp4QGoVAaPk0NAhOlgQ9YrcD3aNyiMxGoKyT4RXxxer4dRIiK6rneHN+rFLAVKI0ZoOHLE3uEYeYpVYMEGnu/hFkQnAdwKh6R5Oqu1skEX8Uh6x2OvaS2CnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298474; c=relaxed/simple;
	bh=UkSQ1lPGAcUi0fvCYCujyD3kmPxcJ9rH1gCav9ZCc7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWv+US4t3+TCRN9OBAWIT4L7HnL1dynVkcKU52YSfhYx29uobu0kW2fJFFr00ASe6Q8B67w8TQOxb4kdBNLzaPYI29RKiNH6ushrqqq2ibngWkEDYg5vhMAeaw1VYhX4MmrqpVsLOmMgncwWSDePhfKQp8jqgfJ4GsFw7oTztDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irEmi44f; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78a6a7654a4so13074397b3.0
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 18:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764298471; x=1764903271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lcq0U/Dc8Pp3M2TfIJmaeonW/ToT1uiOgY5yXQu+oMA=;
        b=irEmi44f1N0tdSA9nhWYQ8F+OQ+FYqrV+eQNzCGVgG0KGLqEkD9A9Bs5x/63e8sB/q
         96HSeaaMZKoZT89reShfqd88E5Dfrccm8+FHkln+7c+xDNBW+UkOc8YIh++OWuSThFLm
         85xydWCQ9csFsx3JpdvhmBnw0wh9a/lC4XLVsgdPfvWcVxat7jk5szxRUhU6isijLjFq
         m3jXojIFAEeIBFSqqdOzgqLhGEwaL9XtK+kSHxLxBR/1ks0xixeBmmJqDBFSlPu6kNaz
         zLTaZRYriCwUh18F0x/lBaAokekcKdEfZVzIWKE2PVYqA3EMPeD4vQmv976/FMqc0nBF
         ULTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764298471; x=1764903271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lcq0U/Dc8Pp3M2TfIJmaeonW/ToT1uiOgY5yXQu+oMA=;
        b=r+Mq5fPGNfBX/Jw+6lT3f/tpOHrS5/itGQ3sx9cfZv/AlT1ZJAq5qOlnrr6ewizF//
         R6F3Wdjzf0khK765nLDq4vitNqMZO7cvLatY3YPuyD8GZKdxXcv7NOFca4vu4T5korN2
         CL+NQQvVId96DWnoFEKeYIQON1uMsPsAIofjILeFS5EZc26zurb5Gj/ZLTFv2rYw3OuM
         79rYawCpElHZfV6iCqndlR2Pe4sX9WjpVj07/LTNiBoAk6/mJH3dNgd2IpjB6FQhodUM
         1TIb6NqE6cw1XGsnTINXvVo1fSfceSJLe4jkVT65cURHVSoYhNewpFdy/cmjS25IOOXN
         LnRA==
X-Forwarded-Encrypted: i=1; AJvYcCUAF99i8fRDT2BfsRg+GDJc3X8OqfQzATtZc6tafSVTJiIvw801LOOuSvku3iYVe63/jF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyrhlE5mXbHO9DhWovpMnbUz8pxV+WFi6uDQtnnXFtBhPl4Qrl
	8LEJb0WURJM4g66oj5atfr9A3TRL7TaO/jj3niF9+zwTWztTqVLMhzk7KbhcG3T32cuqJSyhxkh
	GBPqiEaRmoizJ7fjeK5glla7KKulV3PQ=
X-Gm-Gg: ASbGncsoEkdA6kZgc1VH4hfZpE3KkvXNk0JSrwebC89XAIf0Shkfas+PgmMZL8tVJT4
	WG6ua9mmtH2wiLAjKu9ESREiENN0xtYDtvDzu4ywAQ7seezyNTi1BzRmlHVqrXLxqE1pj53leFj
	iDxXf8XgTH/N1znYxJ2yAYoZRTOmo3OUrJQNlQ/aTt+KQhQBsjVS3EfJK/pxZI8DPHA6KpvdupU
	xiRrJWDWPtVjV+4NAj3dyebYMzqjL2pK2RR5G5Zlvwdr5vzknbNyk6NqiFfYGC9T8xHVm0k
X-Google-Smtp-Source: AGHT+IGfsngmc2uR3246bSBu8tPpAzIjuUSq5Fvdcl6iRw+RohQUN0l4Gzidi3At0vL+hNX1ANFgG//pGdvJcmBnMJw=
X-Received: by 2002:a05:690c:e1f:b0:786:4fd5:e5de with SMTP id
 00721157ae682-78a8b56e89cmr228233257b3.67.1764298470734; Thu, 27 Nov 2025
 18:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-1-laoar.shao@gmail.com> <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
 <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
 <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com> <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org>
In-Reply-To: <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Nov 2025 10:53:53 +0800
X-Gm-Features: AWmQ_bmysuEqpvhEOPrApMgR5cGI13LIBRddMelimiNbsk0QVptl6S6SfKPaNSM
Message-ID: <CALOAHbCR3Y=GCpX8S9CctONO=Emh4RvYAibHU=ZQyLP1s0MOVQ@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Barry Song <21cnbao@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@meta.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 7:48=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> >> To move forward, I'm happy to set the global mode aside for now and
> >> potentially drop it in the next version. I'd really like to hear your
> >> perspective on the per-process mode. Does this implementation meet
> >> your needs?
>
> I haven't had the capacity to follow the evolution of this patch set
> unfortunately, just to comment on some points from my perspective.
>
> First, I agree that the global mode is not what we want, not even as a
> fallback.
>
> >
> > Attaching st_ops to task_struct or to mm_struct is a can of worms.
> > With cgroup-bpf we went through painful bugs with lifetime
> > of cgroup vs bpf, dying cgroups, wq deadlock, etc. All these
> > problems are behind us. With st_ops in mm_struct it will be more
> > painful. I'd rather not go that route.
>
> That's valuable information, thanks. I would have hoped that per-MM
> policies would be easier.

The per-MM approach has a performance advantage over per-MEMCG
policies. This is because it accesses the policy hook directly via

  vma->vm_mm->bpf_mm->policy_hook()

whereas the per-MEMCG method requires a more expensive lookup:

  memcg =3D get_mem_cgroup_from_mm(vma->vm_mm);
  memcg->bpf_memcg->policy_hook();

This lookup could be a concern in a critical path. However, this
performance issue in the per-MEMCG mode can be mitigated. For
instance, when a task is added to a new memcg, we can cache the hook
pointer:

  task->mm->bpf_mm->policy_hook =3D memcg->bpf_memcg->policy_hook

Ultimately, we might still introduce a mm_struct:bpf_mm field to
provide an efficient interface.

>
> Are there some pointers to explore regarding the "can of worms" you
> mention when it comes to per-MM policies?
>
> >
> > And revist cgroup instead, since you were way too quick
> > to accept the pushback because all you wanted is global mode.
> >
> > The main reason for pushback was:
> > "
> > Cgroup was designed for resource management not for grouping processes =
and
> > tune those processes
> > "
> >
> > which was true when cgroup-v2 was designed, but that ship sailed
> > years ago when we introduced cgroup-bpf.
>
> Also valuable information.
>
> Personally I don't have a preference regarding per-mm or per-cgroup.
> Whatever we can get working reliably.

I am open to either approach, as long as it's acceptable to the maintainers=
.

> Sounds like cgroup-bpf has sorted
> out most of the mess.

No, the attach-based cgroup-bpf has proven to be ... a "can of worms"
in practice ...
 (I welcome corrections from the BPF maintainers if my assessment is
inaccurate.)

While the struct-ops-based cgroup-bpf is still under discussion.

>
> memcg/cgroup maintainers might disagree, but it's probably worth having
> that discussion once again.
>
> > None of the progs are doing resource management and lots of infrastruct=
ure,
> > container management, and open source projects use cgroup-bpf
> > as a grouping of processes. bpf progs attached to cgroup/hook tuple
> > only care about processes within that cgroup. No resource management.
> > See __cgroup_bpf_check_dev_permission or __cgroup_bpf_run_filter_sysctl
> > and others.
> > The path is current->cgroup->bpf_progs and progs do exactly
> > what cgroup wasn't designed to do. They tune a set of processes.
> >
> > You should do the same.
> >
> > Also I really don't see a compelling use case for bpf in THP.
>
> There is a lot more potential there to write fine-tuned policies that
> thack VMA information into account.
>
> The tests likely reflect what Yafang seems to focus on: IIUC primarily
> enabling+disabling traditional THPs (e.g., 2M) on a per-process basis.

Right.

>
> Some of what Yafang might want to achieve could maybe at this point be
> maybe achieved through the prctl(PR_SET_THP_DISABLE) support, including
> extensions we recently added [1].
>
> Systemd support still seems to be in the works [2] for some of that.
>
>
> [1] https://lwn.net/Articles/1032014/
> [2] https://github.com/systemd/systemd/pull/39085

Thank you for sharing this.
However, BPF-THP is already deployed across our server fleet and both
our users and my boss are satisfied with it. As such, we are not
considering a switch. The current solution also offers us a valuable
opportunity to experiment with additional policies in production.

In summary, I am fine with either the per-MM or per-MEMCG method.
Furthermore, I don't believe this is an either-or decision; both can
be implemented to work together.


--
Regards
Yafang

