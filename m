Return-Path: <bpf+bounces-40592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709EB98AB5A
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BED51F237C8
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0961198A24;
	Mon, 30 Sep 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjVQMSNb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E718C31;
	Mon, 30 Sep 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718499; cv=none; b=JD3uEU90eNVZL3fDdaLWUZelUhM67CXJiHRaIf/PxHUdJJbWH03SytG05ncZu4pvJqM7S+NS8iOkp2Zz4nyiWeyhY924HNcK745pJGT6Vm/ng5okR8TzH8pOWimJ4fBecI9AldpB/d7oeC4mS7snCujwiX6f+7VB6GrHa76ofak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718499; c=relaxed/simple;
	bh=QtxA2Gn1aPRs/9qbO2VdoDhSsNonNYdVRLyEOTPcCrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFYB52nwaEawy0SREQJFL4GfEU1XA5PcPvrpMx84l/E0j7LYEkpVyRgk/s4CNPmGQ1iR9iGINX+X4TUg0ffD20TZor2IMsjqjFQPnAqwUa3K7SqgKlS7DLGqUu9+FAB8kGGUUja8cA+dBcUMjm1EFcCEWKe+HISuENfI16v+cw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjVQMSNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EEFC4CECE;
	Mon, 30 Sep 2024 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727718498;
	bh=QtxA2Gn1aPRs/9qbO2VdoDhSsNonNYdVRLyEOTPcCrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjVQMSNbjcfK0va4WqlUman7lD7aD6LhM6v5t1lWhSqmqwouwNKP/jb+xZKHV/WFG
	 LFHyuWRgcsztTkv3ttZjUNi4VgVy/lsS9074kviNwyfinHyLqEv+wy/baKrKS374FN
	 ebiGgGg6A5gdNIKvLWZb3Q2N8MfagY/WYAdCoPurnjbn+YMbQ4NBgbM+eQ9H1KDT2o
	 yRFzuzHiVSxG0mg8wEg1uLT/bLIFxhghq1VpCyD78L7XB+AobiBumyvRmaUntxgcn7
	 gqOZ5ZUmAaymnj9gzwUrC3+ewiu91Ito5DK5Vl3GE9mDWmuK+xFBLLUdvowbRrdNjW
	 hfy/lQ38GpD7A==
Date: Mon, 30 Sep 2024 10:48:14 -0700
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
Message-ID: <ZvrkXj_JSYl9866W@google.com>
References: <20240927184133.968283-1-namhyung@kernel.org>
 <20240927184133.968283-4-namhyung@kernel.org>
 <ZvjwEH3QXkjUCu8Z@google.com>
 <CAB=+i9Sm4UEhGy-jzsZEs1Q6KQCVdbnu_eAiRzXz=sRC-3H6Uw@mail.gmail.com>
 <ZvoKYFEx9_h_6zyf@google.com>
 <CAB=+i9TQGnKdt+5Cdg4kjE1AqHgo3MiSvDmr_TarLHw6xGZGog@mail.gmail.com>
 <ZvoqAV_YMH3xkSsr@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvoqAV_YMH3xkSsr@google.com>

On Sun, Sep 29, 2024 at 09:33:05PM -0700, Namhyung Kim wrote:
> On Mon, Sep 30, 2024 at 12:24:52PM +0900, Hyeonggon Yoo wrote:
> > On Mon, Sep 30, 2024 at 11:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello Hyeonggon,
> > >
> > > On Sun, Sep 29, 2024 at 11:27:25PM +0900, Hyeonggon Yoo wrote:
> > > > On Sun, Sep 29, 2024 at 3:13 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > +SEC("raw_tp/bpf_test_finish")
> > > > > > +int BPF_PROG(check_task_struct)
> > > > > > +{
> > > > > > +     __u64 curr = bpf_get_current_task();
> > > > > > +     struct kmem_cache *s;
> > > > > > +     char *name;
> > > > > > +
> > > > > > +     s = bpf_get_kmem_cache(curr);
> > > > > > +     if (s == NULL) {
> > > > > > +             found = -1;
> > > > > > +             return 0;
> > > > >
> > > > > ... it cannot find a kmem_cache for the current task.  This program is
> > > > > run by bpf_prog_test_run_opts() with BPF_F_TEST_RUN_ON_CPU.  So I think
> > > > > the curr should point a task_struct in a slab cache.
> > > > >
> > > > > Am I missing something?
> > > >
> > > > Hi Namhyung,
> > > >
> > > > Out of curiosity I've been investigating this issue on my machine and
> > > > running some experiments.
> > >
> > > Thanks a lot for looking at this!
> > >
> > > >
> > > > When the test fails, calling dump_page() for the page the task_struct
> > > > belongs to,
> > > > shows that the page does not have the PGTY_slab flag set which is why
> > > > virt_to_slab(current) returns NULL.
> > > >
> > > > Does the test always fails on your environment? On my machine, the
> > > > test passed sometimes but failed some times.
> > >
> > > I'm using vmtest.sh but it succeeded mostly.  I thought I couldn't
> > > reproduce it locally, but I also see the failure sometimes.  I'll take a
> > > deeper look.
> > >
> > > >
> > > > Maybe sometimes the value returned by 'current' macro belongs to a
> > > > slab, but sometimes it does not.
> > > > But that doesn't really make sense to me as IIUC task_struct
> > > > descriptors are allocated from slab.
> > >
> > > AFAIK the notable exception is the init_task which lives in the kernel
> > > data.  I'm not sure the if the test is running by PID 1.
> > 
> > I checked that the test is running under PID 0 (swapper) when it fails and
> > non-0 PID when it succeeds. This makes sense as the task_struct for PID 0
> > should be in the kernel image area, not in a slab.
> > 
> > Phew, fortunately, it's not a bug! :)
> 
> Thanks for the test, I've seen the same now.
> 
> > 
> > Any plans on how to adjust the test program?
> 
> I thought the test runs in a separate task.  I'll think about how to
> test this more reliably.

Oh, I think BPF_F_TEST_RUN_ON_CPU was the problem since it requires to
run the test on the given CPU (cpu0 in this case).  If the cpu0 was
idle, it would fail like this.  I think removing the flag will run the
test on the current CPU so it won't get the swapper task anymore.

Thanks,
Namhyung


