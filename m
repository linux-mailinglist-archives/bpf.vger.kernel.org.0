Return-Path: <bpf+bounces-56985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C182AAA3AE8
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D94B4E0CA7
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0526FA6E;
	Tue, 29 Apr 2025 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usrq9h2j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4A26A0CA
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963805; cv=none; b=Y3ZjH/c6K9qyrkrPnMM95t769ooYESGsAgxzAO6Xp3va1Y2kUrR+gMBo+lDlL+69yn9lu0XRu6ViCqzyOxAfhywuFwUDFVAde1VqPosYcqqBVISA3jnIFzhmOCOjGQpvFW4n4m2Pq/COl7LB67NS3P3iWSXtZnqLPjDk85kQrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963805; c=relaxed/simple;
	bh=G7glrdtwa55zyuDZmnQGTuV3cqpStTyHqlHnn6fYgJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFpPkfA95hWt1BzoVefN0Sa03yn5gLEfCmNehmlZSNvevwhikHoQLLOTa+Q3DPY1vvw5N0SDfHnhC9rQiKuQAi8wWges6ixIcvWrK/VcSjzg3Z4snwxR0DhKtO0mjjSBHcGS7JqTbtowXrDdBTSlhFdc4qCxusvp0YAGODRXqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usrq9h2j; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4774611d40bso368101cf.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745963802; x=1746568602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHPStCfNoeO92wT2yn6jdgylDS3AOWBgTDjw60mOQWk=;
        b=usrq9h2jDgOFEUG2XrQxAZi+KWoyKhHFxvy3TzxXwSDymrwDW16FeZUvHFjiTwEMCS
         f5i6tBym5xZS2DfuaPh/25BRUcrVAdUUselWJfODDAZ+nOM/tZbXpTeQfh9Ao7DkoNx7
         pZ0X2GE6h3nDmrb7XsvJJrY2zKfshyy0OTk+q95U4CVP5nAk377K1+AHmtLC4G+/9Z7o
         2xNxuPJSnOMYAhK8inCaViGdXqBT3hOBdnJSjuotB2soeGARs4QO1vumSg/8NfoUURph
         UqqsIA+mEi3wz7jOx1BrjIOlU/+p+Spy55bRPpj45BxZASJjQCDMtXcJb4N4BoES5hrN
         nxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745963802; x=1746568602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHPStCfNoeO92wT2yn6jdgylDS3AOWBgTDjw60mOQWk=;
        b=D+8GMM5fo/QMz+JNZASQ2SRX50rloOQ/TvMISHua+MM9QG0joGg06nVbe8DvFeoQLu
         vLy/CseO3ORPgNj2Cy8r6QuboxKLcIG/v/xF1DCLmDWVGecCOuEz4kgkeOzJrIY+UhbB
         x527fjzdeYqwNmD+n+3P0u2WbN1dN7XsCnpiUGPCR1aCoGBCD410U4GU2ZxAedzhF+qx
         NGsyN/M78sni4Zxw4vT/LEfmezjTBpYvH2zusHHf0mJx6d3hNGCgibNC1AsglY/tg+DG
         H37H4rZgajaOC/bXQ3r3MWtWRoDssy5NMQSTSkSppYx1+EKITkge9AXIgi8RqNf2J3r9
         H5uA==
X-Forwarded-Encrypted: i=1; AJvYcCXnP7G/3qisnJWoqEbh8yGKdVX2mJmjv26oWx0a9SAJ4/AifhyBFScKL/Rd/eY/JYba24A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfTLwwlIekMRcI2NA0YUZG9+4xx5zquxFfQ1BVHyFIcCL/u2Y
	FQdt4k8NdiEKx7bHZ4ZA0AWJkCQv4BMg4BC2SXCEP4lu8PJBzUx699K3ljzNGMps84u3ERTeZ18
	Gf+KbUTeLjSIWzGgNqAijI0eRgeY2x5wxpql88Wa1xfXWqj1+PGSz
X-Gm-Gg: ASbGnct1ptq/n8kc5g17KYFG6+joJArmve/X9p9sJpI7t0lTx7xDafP5yfjR9igTHx2
	T5Ugspw5zrMT6hB3vBPMgug3VuoJihQ+SgSkm57UhjMskTMBWSZebC9F42rOqKKeu7toQEV0szc
	MAMKOBHhwiYs3DDEVY4eZqlR28IbT7A74cs5IN2uRy3LxXbcnVh26q
X-Google-Smtp-Source: AGHT+IHnm3oxMMCggQ4zYDBc/EviFjkF3Acb+O+Bqo5djYoDiGVrrZLyLpU3ATh7ELc5quPVw0I9UjhXoBryKd7Lkk4=
X-Received: by 2002:ac8:7f93:0:b0:486:be94:7c21 with SMTP id
 d75a77b69052e-489b9b3576bmr1402081cf.14.1745963802313; Tue, 29 Apr 2025
 14:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <aBC7E487qDSDTdBH@tiehlicka> <87selrrpqz.fsf@linux.dev>
In-Reply-To: <87selrrpqz.fsf@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 14:56:31 -0700
X-Gm-Features: ATxdqUGmHhJ_UTjKXo9nohfLLfKUi3iJT5843r-eaFIU3HLqrfEhnF9PVMNh5vQ
Message-ID: <CAJuCfpEToCmf6rdA6tNpWrzw70Er6Q4ZWOwn+ruCWpU=ZEEkmA@mail.gmail.com>
Subject: Re: [PATCH rfc 00/12] mm: BPF OOM
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:45=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Michal Hocko <mhocko@suse.com> writes:
>
> > On Mon 28-04-25 03:36:05, Roman Gushchin wrote:
> >> This patchset adds an ability to customize the out of memory
> >> handling using bpf.
> >>
> >> It focuses on two parts:
> >> 1) OOM handling policy,
> >> 2) PSI-based OOM invocation.
> >>
> >> The idea to use bpf for customizing the OOM handling is not new, but
> >> unlike the previous proposal [1], which augmented the existing task
> >> ranking-based policy, this one tries to be as generic as possible and
> >> leverage the full power of the modern bpf.
> >>
> >> It provides a generic hook which is called before the existing OOM
> >> killer code and allows implementing any policy, e.g.  picking a victim
> >> task or memory cgroup or potentially even releasing memory in other
> >> ways, e.g. deleting tmpfs files (the last one might require some
> >> additional but relatively simple changes).
> >
> > Makes sense to me. I still have a slight concern though. We have 3
> > different oom handlers smashed into a single one with special casing
> > involved. This is manageable (although not great) for the in kernel
> > code but I am wondering whether we should do better for BPF based OOM
> > implementations. Would it make sense to have different callbacks for
> > cpuset, memcg and global oom killer handlers?
>
> Yes, it's certainly possible. If we go struct_ops path, we can even
> have both the common hook which handles all types of OOM's and separate
> hooks for each type. The user then can choose what's more convenient.
> Good point.
>
> >
> > I can see you have already added some helper functions to deal with
> > memcgs but I do not see anything to iterate processes or find a process=
 to
> > kill etc. Is that functionality generally available (sorry I am not
> > really familiar with BPF all that much so please bear with me)?
>
> Yes, task iterator is available since v6.7:
> https://docs.ebpf.io/linux/kfuncs/bpf_iter_task_new/
>
> >
> > I like the way how you naturalely hooked into existing OOM primitives
> > like oom_kill_process but I do not see tsk_is_oom_victim exposed. Are
> > you waiting for a first user that needs to implement oom victim
> > synchronization or do you plan to integrate that into tasks iterators?
>
> It can be implemented in bpf directly, but I agree that it probably
> deserves at least an example in the test or a separate in-kernel helper.
> In-kernel helper is probably a better idea.
>
> > I am mostly asking because it is exactly these kind of details that
> > make the current in kernel oom handler quite complex and it would be
> > great if custom ones do not have to reproduce that complexity and only
> > focus on the high level policy.
>
> Totally agree.
>
> >
> >> The second part is related to the fundamental question on when to
> >> declare the OOM event. It's a trade-off between the risk of
> >> unnecessary OOM kills and associated work losses and the risk of
> >> infinite trashing and effective soft lockups.  In the last few years
> >> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> >> systemd-OOMd [4]). The common idea was to use userspace daemons to
> >> implement custom OOM logic as well as rely on PSI monitoring to avoid
> >> stalls.
> >
> > This makes sense to me as well. I have to admit I am not fully familiar
> > with PSI integration into sched code but from what I can see the
> > evaluation is done on regular bases from the worker context kicked off
> > from the scheduler code. There shouldn't be any locking constrains whic=
h
> > is good. Is there any risk if the oom handler took too long though?
>
> It's a good question. In theory yes, it can affect the timing of other
> PSI events. An option here is to move it into a separate work, however
> I'm not sure if it worth the added complexity. I actually tried this
> approach in an earlier version of this patchset, but the problem was
> that the code for scheduling this work should be dynamically turned
> on/off when a bpf program is attached/detached, otherwise it's an
> obvious cpu overhead.
> It's doable, but Idk if it's justified.
>
> >
> > Also an important question. I can see selftests which are using the
> > infrastructure. But have you tried to implement a real OOM handler with
> > this proposed infrastructure?
>
> Not yet. Given the size and complexity of the infrastructure of my
> current employer, it's not a short process. But we're working on it.

Hi Roman,
This might end up being very useful for Android. Since we have a
shared current employer, we might be able to provide an earlier test
environment for this concept on Android and speed up development of a
real OOM handler. I'll be following the development of this patchset
and will see if we can come up with an early prototype for testing.

>
> >
> >> [1]: https://lwn.net/ml/linux-kernel/20230810081319.65668-1-zhouchuyi@=
bytedance.com/
> >> [2]: https://lore.kernel.org/lkml/20171130152824.1591-1-guro@fb.com/
> >> [3]: https://github.com/facebookincubator/oomd
> >> [4]: https://www.freedesktop.org/software/systemd/man/latest/systemd-o=
omd.service.html
> >>
> >> ----
> >>
> >> This is an RFC version, which is not intended to be merged in the curr=
ent form.
> >> Open questions/TODOs:
> >> 1) Program type/attachment type for the bpf_handle_out_of_memory() hoo=
k.
> >>    It has to be able to return a value, to be sleepable (to use cgroup=
 iterators)
> >>    and to have trusted arguments to pass oom_control down to bpf_oom_k=
ill_process().
> >>    Current patchset has a workaround (patch "bpf: treat fmodret tracin=
g program's
> >>    arguments as trusted"), which is not safe. One option is to fake ac=
quire/release
> >>    semantics for the oom_control pointer. Other option is to introduce=
 a completely
> >>    new attachment or program type, similar to lsm hooks.
> >> 2) Currently lockdep complaints about a potential circular dependency =
because
> >>    sleepable bpf_handle_out_of_memory() hook calls might_fault() under=
 oom_lock.
> >>    One way to fix it is to make it non-sleepable, but then it will req=
uire some
> >>    additional work to allow it using cgroup iterators. It's intervened=
 with 1).
> >
> > I cannot see this in the code. Could you be more specific please? Where
> > is this might_fault coming from? Is this BPF constrain?
>
> It's in __bpf_prog_enter_sleepable(). But I hope I can make this hook
> non-sleepable (by going struct_ops path) and the problem will go away.
>
> >
> >> 3) What kind of hierarchical features are required? Do we want to nest=
 oom policies?
> >>    Do we want to attach oom policies to cgroups? I think it's too comp=
licated,
> >>    but if we want a full hierarchical support, it might be required.
> >>    Patch "mm: introduce bpf_get_root_mem_cgroup() bpf kfunc" exposes t=
he true root
> >>    memcg, which is potentially outside of the ns of the loading proces=
s. Does
> >>    it require some additional capabilities checks? Should it be remove=
d?
> >
> > Yes, let's start simple and see where we get from there.
>
> Agree.
>
> Thank you for taking a look and your comments/ideas!
>

