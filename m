Return-Path: <bpf+bounces-70472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23961BBFDCA
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96883C2FCE
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC301C84B2;
	Tue,  7 Oct 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FYgek9SA"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B034BA50
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797727; cv=none; b=QoKoAYFOHjv0AytoO9forHa1cn27iv+ZhbzP3TcQTzYQr8WQFcOTlNrys2Sj8YD0Bfp6yi0jm2n5DK63eq4Lvry4bUtmrzdB2VfrgzW/VVmdyVQYTHmpWEvHhk4qz0M43SDUCUJy0UU2tCIVycJGzB8D06m4BrJtFOv54oSxJCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797727; c=relaxed/simple;
	bh=mv3+xA9kD1I985ghdrUGEDO1hqGIeV/sS/Ttd+zrLjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgIFvTb2qnOVfkz/lZ1rKir2Jd+Vs3gLSRmg8jSQFqQuRl32tmeOziNkBKS9b3IucLyby5V3QQFMJs9sVPVAIPJa6zyYypmrKrdAQn/G8B7h8M/iuACGbsrMfNQ06BnB20OPpI+vMEosmRN7ytHSgkb0mBChv+KSEmhCXRRSVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FYgek9SA; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759797720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mv3+xA9kD1I985ghdrUGEDO1hqGIeV/sS/Ttd+zrLjc=;
	b=FYgek9SAutdY9P9IZoaZxz3kLUJrlT4rgo6GJPU5sc+EYaxjQ+hsU7m65t3uU1p2wU1V5h
	Tg+gjsHHq9uuA0CVNrKV2LJEhBu7ifbgCFvb4tfS7+8s1H7s3e3vCQvCWDx/ZTFMAqzZpm
	pwM8Y9NRrjhqcHsARSu6Rk8RqOYqvo0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,  Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  linux-mm <linux-mm@kvack.org>,  bpf
 <bpf@vger.kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David
 Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <CAEf4BzaVvNwt18eqVpigKh8Ftm=KfO_EsB2Hoh+LQCDLsWxRwg@mail.gmail.com>
	(Andrii Nakryiko's message of "Mon, 6 Oct 2025 16:57:22 -0700")
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
Date: Mon, 06 Oct 2025 17:41:52 -0700
Message-ID: <87tt0bfsq7.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Oct 6, 2025 at 4:52=E2=80=AFPM Roman Gushchin <roman.gushchin@lin=
ux.dev> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Oct 3, 2025 at 7:01=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
>> >>
>> >> Martin KaFai Lau <martin.lau@linux.dev> writes:
>> >>
>> >> > On 9/2/25 10:31 AM, Roman Gushchin wrote:
>> >> >> Btw, what's the right way to attach struct ops to a cgroup, if the=
re is
>> >> >> one? Add a cgroup_id field to the struct and use it in the .reg()
>> >> >
>> >> > Adding a cgroup id/fd field to the struct bpf_oom_ops will be hard =
to
>> >> > attach the same bpf_oom_ops to multiple cgroups.
>> >> >
>> >> >> callback? Or there is something better?
>> >> >
>> >> > There is a link_create.target_fd in the "union bpf_attr". The
>> >> > cgroup_bpf_link_attach() is using it as cgroup fd. May be it can be
>> >> > used here also. This will limit it to link attach only. Meaning the
>> >> > SEC(".struct_ops.link") is supported but not the older
>> >> > SEC(".struct_ops"). I think this should be fine.
>> >>
>> >> I thought a bit more about it (sorry for the delay):
>> >> if we want to be able to attach a single struct ops to multiple cgrou=
ps
>> >> (and potentially other objects, e.g. sockets), we can't really
>> >> use the existing struct ops's bpf_link.
>> >>
>> >> So I guess we need to add a new .attach() function beside .reg()
>> >> which will take the existing link and struct bpf_attr as arguments and
>> >> return a new bpf_link. And in libbpf we need a corresponding new
>> >> bpf_link__attach_cgroup().
>> >>
>> >> Does it sound right?
>> >>
>> >
>> > Not really, but I also might be missing some details (I haven't read
>> > the entire thread).
>> >
>> > But conceptually, what you describe is not how things work w.r.t. BPF
>> > links and attachment.
>> >
>> > You don't attach a link to some hook (e.g., cgroup). You attach either
>> > BPF program or (as in this case) BPF struct_ops map to a hook (i.e.,
>> > cgroup), and get back the BPF link. That BPF link describes that one
>> > attachment of prog/struct_ops to that hook. Each attachment gets its
>> > own BPF link FD.
>> >
>> > So, there cannot be bpf_link__attach_cgroup(), but there can be (at
>> > least conceptually) bpf_map__attach_cgroup(), where map is struct_ops
>> > map.
>>
>> I see...
>> So basically when a struct ops map is created we have a fd and then
>> we can attach it (theoretically multiple times) using BPF_LINK_CREATE.
>
> Yes, exactly. "theoretically" part is true right now because of how
> things are wired up internally, but this must be fixable

Ok, one more question: do you think it's better to alter the existing
bpf_struct_ops.reg() callback and add the bpf_attr parameter
or add the new .attach() callback?

