Return-Path: <bpf+bounces-70568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977BBC326F
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 04:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FDB188526F
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 02:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9EC29B777;
	Wed,  8 Oct 2025 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LNObAgyX"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10729B200
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 02:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759889751; cv=none; b=LSX1egbV0vDIMX3pLOffpMs1rA2IoII67QQeI+J1F79iy5X+NAxXTUSDB12ejp93hapQVROULnbJFRug3/Dehn5bw1S3ciaoj8STlom+zO/9rdLz73x/aL3ZultUYjuALpcyY9bgkOb6uVe2huMfH5EFGq6RBLgAC9ovr+hGQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759889751; c=relaxed/simple;
	bh=vIg33BOFvu2DJKTJckDWopI10BTYzh0CRGfWO2QY7n0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnrWbnzxb1gMAxcqmtDqKzgSqwjFJl9pV82TVlAcQIMOd9bBjGNj9SQ2gl0QjRYYnvLWRi8PxS+EKlaojnAU/6Cs2A2Sr9lCQWPPtbHnNJfDjyecALqGkE0og6Fpq8qEYOlJ1Voy7SoVXbdqe5atPdXdx1bWwqmt+LD5jRdIhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LNObAgyX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759889746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIg33BOFvu2DJKTJckDWopI10BTYzh0CRGfWO2QY7n0=;
	b=LNObAgyXn7QpbbMMaXccMVDeUIbaqghyVb6uU4GzlJVkCU97y3ZDswl/JuAogn3IQOXnLX
	hX0kezR1H8s/664IJ/6vqK1EU6TH4K5Sogf2p48mnjJCsdnIluI91xgIH7kLl23hNZVr8A
	4TSArLy+pby/78AvJ5HuB9Zh2kqTpDg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Song Liu <song@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  linux-mm <linux-mm@kvack.org>,  bpf
 <bpf@vger.kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David
 Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Alexei Starovoitov <ast@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <CAHzjS_v+N7UO-yEt-d0w3nE5_Y1LExQ5hFWYnHqARp9L-5P_cg@mail.gmail.com>
	(Song Liu's message of "Tue, 7 Oct 2025 18:07:03 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
	<87wm6rwd4d.fsf@linux.dev>
	<ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
	<CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
	<87iki0n4lm.fsf@linux.dev>
	<a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev>
	<877bxb77eh.fsf@linux.dev>
	<CAEf4BzafXv-PstSAP6krers=S74ri1+zTB4Y2oT6f+33yznqsA@mail.gmail.com>
	<871pnfk2px.fsf@linux.dev>
	<CAEf4BzaVvNwt18eqVpigKh8Ftm=KfO_EsB2Hoh+LQCDLsWxRwg@mail.gmail.com>
	<87tt0bfsq7.fsf@linux.dev>
	<CAHzjS_v+N7UO-yEt-d0w3nE5_Y1LExQ5hFWYnHqARp9L-5P_cg@mail.gmail.com>
Date: Tue, 07 Oct 2025 19:15:40 -0700
Message-ID: <87playf8ab.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Song Liu <song@kernel.org> writes:

> On Mon, Oct 6, 2025 at 5:42=E2=80=AFPM Roman Gushchin <roman.gushchin@lin=
ux.dev> wrote:
> [...]
>> >> >
>> >> > So, there cannot be bpf_link__attach_cgroup(), but there can be (at
>> >> > least conceptually) bpf_map__attach_cgroup(), where map is struct_o=
ps
>> >> > map.
>> >>
>> >> I see...
>> >> So basically when a struct ops map is created we have a fd and then
>> >> we can attach it (theoretically multiple times) using BPF_LINK_CREATE.
>> >
>> > Yes, exactly. "theoretically" part is true right now because of how
>> > things are wired up internally, but this must be fixable
>>
>> Ok, one more question: do you think it's better to alter the existing
>> bpf_struct_ops.reg() callback and add the bpf_attr parameter
>> or add the new .attach() callback?
>
> IIUC, bpf_struct_ops_link is just for bpf_struct_ops.reg(). The
> attach() operation can be separate, and it doesn't need to be
> implemented in sys_bpf() syscall. BPF TCP congestion control
> uses setsockopt() to do the attach(). Current sched_ext does
> the attach as part of reg(). Tejun is proposing to use reg() for
> sub scheduler [1]. In my earlier patch set for fanotify-bpf, I
> was planning to use ioctl on the fanotify fd [2]. I think these
> all work for the given use case.
>
> I am not sure what is the best option for cgroup oom killer. There
> are multiple options. Technically, it can even be a sysfs entry.
> We can use it as:
>
> # load and pin oom killers first
> $ cat /sys/fs/cgroup/user.slice/oom.killer
> [oom_a] oom_b oom_c
> $ echo oom_b > /sys/fs/cgroup/user.slice/oom.killer
> $ cat /sys/fs/cgroup/user.slice/oom.killer
> oom_a [oom_b] oom_c

It actually looks nice!
But I expect that most users of bpf_oom won't use it directly,
but through some sort of middleware (e.g. systemd), so Idk if
such a user-oriented interface makes a lot of sense.

> Note that, I am not proposing to use sysfs entries for oom killer.
> I just want to say it is an option.
>
> Given attach() can be implemented in different ways, we probably
> don't need to add it to bpf_struct_ops. But if that turns out to be
> the best option, I would not argue against it. OTOH, I think it is
> better to keep reg() and attach() separate, though sched_ext is
> using reg() for both options.

I'm inclining towards a similar approach, except that I don't want
to embed cgroup_id into the struct_ops, but keep it in the link,
as Martin suggested. But I need to implement it end-to-end before I can
be sure that it's the best option. Working on it...

>
> Does this make sense?

Yes, thank you for the great summary!

