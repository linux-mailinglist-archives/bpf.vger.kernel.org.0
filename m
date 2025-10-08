Return-Path: <bpf+bounces-70597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D46BC61CC
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668A0403FC0
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66BC2580D7;
	Wed,  8 Oct 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ImEtogTh"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B41E32D3
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942974; cv=none; b=d0QBhCHI2gNP6Ee5vIoLnaUOas2CdJ9iK7gp5TC0lc6m8msNd9vYAv6WPV7/yyzCWHYgoG6F5Gis9H/Lniq4oB6QzEx7ni31ni6gxMOHI3EW/7LHoPjKQFJPJptENQLQNNFisG0KSC6grkGkXxl2NHrTVyNArdXCh7Bgd5RxwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942974; c=relaxed/simple;
	bh=BODKjR/Yrua4uagxV7JAKQu5Y6484FclXcvnVtP0Ids=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ie/cNRgz8yDGvxmWrqtOH6BfiBhP/pn5FjWDVKEo8aAJJmRV6FkG+PoB1Uzd1jwfYU/ZrVXRu24EVLvl8l5x54GBkRjY4xUDUYm19+3538TW3EzBv0XQ3L0FniswZt2zGD4JAJ0Ci+/OsZ9Vn7MjNr4rMUjJX98OQRWuPEdvchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ImEtogTh; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759942960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BODKjR/Yrua4uagxV7JAKQu5Y6484FclXcvnVtP0Ids=;
	b=ImEtogTh0Qu0BQbbsIQhE3xhi2kpV56iAk7nUKH+E+BrfzLTe1IFnAs1u2nKXZ4WwXK+rP
	N4Qk9gMKmXy+ZNj+q5FZFsQxoYmLp0idznsWNAYeTnVwQAUsZ+z4suI0RtYA3ZrCJZnGqD
	4lTBro4kASUXODnrVr2/PzmbAiart0s=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Song Liu <liu.song.linuxdev@gmail.com>
Cc: Song Liu <song@kernel.org>,  Andrii Nakryiko
 <andrii.nakryiko@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  linux-mm <linux-mm@kvack.org>,  bpf
 <bpf@vger.kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David
 Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Alexei Starovoitov <ast@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <CAHzjS_tq34QC4NDQd_L8crQii2QZCxZr28ywSw=gMnFnqD_z2A@mail.gmail.com>
	(Song Liu's message of "Wed, 8 Oct 2025 00:03:37 -0700")
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
	<87playf8ab.fsf@linux.dev>
	<CAHzjS_tq34QC4NDQd_L8crQii2QZCxZr28ywSw=gMnFnqD_z2A@mail.gmail.com>
Date: Wed, 08 Oct 2025 10:02:28 -0700
Message-ID: <871pnd2uor.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Song Liu <liu.song.linuxdev@gmail.com> writes:

> On Tue, Oct 7, 2025 at 7:15=E2=80=AFPM Roman Gushchin <roman.gushchin@lin=
ux.dev> wrote:
> [...]
>> >
>> > I am not sure what is the best option for cgroup oom killer. There
>> > are multiple options. Technically, it can even be a sysfs entry.
>> > We can use it as:
>> >
>> > # load and pin oom killers first
>> > $ cat /sys/fs/cgroup/user.slice/oom.killer
>> > [oom_a] oom_b oom_c
>> > $ echo oom_b > /sys/fs/cgroup/user.slice/oom.killer
>> > $ cat /sys/fs/cgroup/user.slice/oom.killer
>> > oom_a [oom_b] oom_c
>>
>> It actually looks nice!
>> But I expect that most users of bpf_oom won't use it directly,
>> but through some sort of middleware (e.g. systemd), so Idk if
>> such a user-oriented interface makes a lot of sense.
>>
>> > Note that, I am not proposing to use sysfs entries for oom killer.
>> > I just want to say it is an option.
>> >
>> > Given attach() can be implemented in different ways, we probably
>> > don't need to add it to bpf_struct_ops. But if that turns out to be
>> > the best option, I would not argue against it. OTOH, I think it is
>> > better to keep reg() and attach() separate, though sched_ext is
>> > using reg() for both options.
>>
>> I'm inclining towards a similar approach, except that I don't want
>> to embed cgroup_id into the struct_ops, but keep it in the link,
>> as Martin suggested. But I need to implement it end-to-end before I can
>> be sure that it's the best option. Working on it...
>
> If we add cgroup_id to the link, I guess this means we need the link
> (some fd in user space) to hold reference on the attachment of this
> oom struct_ops on this is cgroup. Do we also need this link to hold
> a reference on the cgroup?

Not necessarily. I agree that the struct_ops should not hold a reference
to the cgroup, it's better to do the opposite.
This is why the link can have cgroup_id, not cgroup pointer.
I think it's similar to Tejun's approach to embed cgroup_id into the
struct ops, but potentially more flexible.

Thanks!

