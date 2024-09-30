Return-Path: <bpf+bounces-40538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF54D9899BF
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 06:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BAC1F2174E
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D1D6F2FE;
	Mon, 30 Sep 2024 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYu0OAiD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B12A47;
	Mon, 30 Sep 2024 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727670788; cv=none; b=GQf26pmsRvUMNkquMV5oOvCSTmjneg9PC9eX73PsMHYNsybnvxd7K7zLKhtPu2ncUrfRJwaO76xjs7YCRU6PTr9e5wTKT/usyYCUb0A6C8o1YPd5tLZCKg8HH6pzmp1Zxz9wlNMl3qL5/t3g1oyg2rLc0X1QvT3+0zLOjJeN5VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727670788; c=relaxed/simple;
	bh=3amIbln7dnz+oo73FF/zE0cL2D9f0zkJP2DspgBmvv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaejGfLpddioFfMH4vc+oOdwmMsZoGysoExh2wZLuSyU27MEsYExZ44F/Gb/VZjQvSoWQf1PSnCI75uzYUbe9wTUwzJOhjpx0hTv2zcy2BwsPpuW7/2jpeVjTShp9zx9/sfRcL5xa9WLbXKfiBG3j7ggS0o3gW5W2qhPaBLbEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYu0OAiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC259C4CECE;
	Mon, 30 Sep 2024 04:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727670787;
	bh=3amIbln7dnz+oo73FF/zE0cL2D9f0zkJP2DspgBmvv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYu0OAiD2VrZYQCc+iHdpCAxMMHgle1krR6quuKisBiZ+n3EYmuo6WwQuX9f6u9CZ
	 xJmZeh5vLMZysxoN+DXGofch7l8/88x3XZuFIR6Qh1t+avy+HOPeiZkYj64L8U4clL
	 maz4jPNnmhW9edA1CMyLaxsWmwVifcUPxI+llHbxgoUaFkX8q6jo3K3BPe8uw0/OA5
	 Ti0YVlv3UeYCsGxeQupJ7cBrQ07Id4x0o6hYqBTUcWgiMfKm+U56QNqRDBvr7rOfJb
	 Zxz+bjI4nAj61a6vE7Yv0U0niXdyGi6fKcEvJ8atsKV60bWcassWdbldUglFXbdZrW
	 DjR21CmSoDadg==
Date: Sun, 29 Sep 2024 21:33:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 3/3] selftests/bpf: Add a test for
 kmem_cache_iter
Message-ID: <ZvoqAV_YMH3xkSsr@google.com>
References: <20240927184133.968283-1-namhyung@kernel.org>
 <20240927184133.968283-4-namhyung@kernel.org>
 <ZvjwEH3QXkjUCu8Z@google.com>
 <CAB=+i9Sm4UEhGy-jzsZEs1Q6KQCVdbnu_eAiRzXz=sRC-3H6Uw@mail.gmail.com>
 <ZvoKYFEx9_h_6zyf@google.com>
 <CAB=+i9TQGnKdt+5Cdg4kjE1AqHgo3MiSvDmr_TarLHw6xGZGog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=+i9TQGnKdt+5Cdg4kjE1AqHgo3MiSvDmr_TarLHw6xGZGog@mail.gmail.com>

On Mon, Sep 30, 2024 at 12:24:52PM +0900, Hyeonggon Yoo wrote:
> On Mon, Sep 30, 2024 at 11:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello Hyeonggon,
> >
> > On Sun, Sep 29, 2024 at 11:27:25PM +0900, Hyeonggon Yoo wrote:
> > > On Sun, Sep 29, 2024 at 3:13 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > +SEC("raw_tp/bpf_test_finish")
> > > > > +int BPF_PROG(check_task_struct)
> > > > > +{
> > > > > +     __u64 curr = bpf_get_current_task();
> > > > > +     struct kmem_cache *s;
> > > > > +     char *name;
> > > > > +
> > > > > +     s = bpf_get_kmem_cache(curr);
> > > > > +     if (s == NULL) {
> > > > > +             found = -1;
> > > > > +             return 0;
> > > >
> > > > ... it cannot find a kmem_cache for the current task.  This program is
> > > > run by bpf_prog_test_run_opts() with BPF_F_TEST_RUN_ON_CPU.  So I think
> > > > the curr should point a task_struct in a slab cache.
> > > >
> > > > Am I missing something?
> > >
> > > Hi Namhyung,
> > >
> > > Out of curiosity I've been investigating this issue on my machine and
> > > running some experiments.
> >
> > Thanks a lot for looking at this!
> >
> > >
> > > When the test fails, calling dump_page() for the page the task_struct
> > > belongs to,
> > > shows that the page does not have the PGTY_slab flag set which is why
> > > virt_to_slab(current) returns NULL.
> > >
> > > Does the test always fails on your environment? On my machine, the
> > > test passed sometimes but failed some times.
> >
> > I'm using vmtest.sh but it succeeded mostly.  I thought I couldn't
> > reproduce it locally, but I also see the failure sometimes.  I'll take a
> > deeper look.
> >
> > >
> > > Maybe sometimes the value returned by 'current' macro belongs to a
> > > slab, but sometimes it does not.
> > > But that doesn't really make sense to me as IIUC task_struct
> > > descriptors are allocated from slab.
> >
> > AFAIK the notable exception is the init_task which lives in the kernel
> > data.  I'm not sure the if the test is running by PID 1.
> 
> I checked that the test is running under PID 0 (swapper) when it fails and
> non-0 PID when it succeeds. This makes sense as the task_struct for PID 0
> should be in the kernel image area, not in a slab.
> 
> Phew, fortunately, it's not a bug! :)

Thanks for the test, I've seen the same now.

> 
> Any plans on how to adjust the test program?

I thought the test runs in a separate task.  I'll think about how to
test this more reliably.

Thanks,
Namhyung

