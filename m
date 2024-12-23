Return-Path: <bpf+bounces-47549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA19FB30E
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 17:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6629B164F5C
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236C71BC9FF;
	Mon, 23 Dec 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFSqSvYg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3712C544;
	Mon, 23 Dec 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971901; cv=none; b=kKUlq5e8I8f5Wph1cqZ1HWGankNsRDq06D8pY7oxGQCt2Wjw8pQ9joup4BhREr64A3L/lVZQnIjQoLbH7ri7UXX0/LOrO7RqsoUwS7E/MmfcQWFRIEr8/OgmWk7oN0yXh6soN/K/7xRcK0PJoKFbNjbVqMyKLk9mrUdYjyDRnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971901; c=relaxed/simple;
	bh=4C3hD57TU0AeYPwwfm3/2pwkbpPtKf/jt6Q/NWlFPuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD1JscUIBpHLfosnIYipNfK5aYbSRoyf/b1St901zZn8q/b2rNJg5TsTCXiKSfAJpc6y9kERj/tuMw5Sm1ut3xpsSdKd8/mJvZ8GQOkUM0KdgQXE/hdO+eiYUYP60bupGVf1gQuMEEqzs4Zn+vC0eluR+XnimpJIGW7Qq0jOpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFSqSvYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BEFC4CED3;
	Mon, 23 Dec 2024 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734971901;
	bh=4C3hD57TU0AeYPwwfm3/2pwkbpPtKf/jt6Q/NWlFPuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFSqSvYgNPKFMPDGHJo3iL8X/N/K6/2zrBGht9rL280lml8hWguzV8sfEQ+PNnDsm
	 lW5uMquSM0cME9+js7vnOsdcsQqdHSGWabVGrtq0DmzjXbF5IeeExEac5UQ/AbDmvh
	 867icruXvirkzdpmG5IUOAA+U/Z/UXTx6RhgCDn5QLfqTW5sa6auspI3VFrpIgb42P
	 mpD4bfGUNR5L+GMfmgrshXtu43tBZhZhyFNomWSpip9WqPEXbLB/QflJa11Ifyus3r
	 2O64r9G2XvW5GFOdg5qRivyh4hbBjDSgIaRVB3mb+HIt7kU8c5ldsEklAkzHSy100U
	 1Gkm8vjcVhJ/Q==
Date: Mon, 23 Dec 2024 13:38:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>
Subject: Re: [PATCH v3 2/4] perf lock contention: Run BPF slab cache iterator
Message-ID: <Z2mR-o9I3CobBoNB@x1>
References: <20241220060009.507297-1-namhyung@kernel.org>
 <20241220060009.507297-3-namhyung@kernel.org>
 <CAADnVQLm-jA5-39-LUKybO2oGbDRr2RgPtJH5iXoeKnYqdJUuw@mail.gmail.com>
 <Z2dVdH3o5iF-KrWj@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2dVdH3o5iF-KrWj@google.com>

On Sat, Dec 21, 2024 at 03:55:32PM -0800, Namhyung Kim wrote:
> Hi Alexei,
> 
> On Fri, Dec 20, 2024 at 03:52:36PM -0800, Alexei Starovoitov wrote:
> > On Thu, Dec 19, 2024 at 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > +struct bpf_iter__kmem_cache___new {
> > > +       struct kmem_cache *s;
> > > +} __attribute__((preserve_access_index));
> > > +
> > > +SEC("iter/kmem_cache")
> > > +int slab_cache_iter(void *ctx)
> > > +{
> > > +       struct kmem_cache *s = NULL;
> > > +       struct slab_cache_data d;
> > > +       const char *nameptr;
> > > +
> > > +       if (bpf_core_type_exists(struct bpf_iter__kmem_cache)) {
> > > +               struct bpf_iter__kmem_cache___new *iter = ctx;
> > > +
> > > +               s = BPF_CORE_READ(iter, s);
> > > +       }
> > > +
> > > +       if (s == NULL)
> > > +               return 0;
> > > +
> > > +       nameptr = BPF_CORE_READ(s, name);
> > 
> > since the feature depends on the latest kernel please use
> > direct access. There is no need to use BPF_CORE_READ() to
> > be compatible with old kernels.
> > Just iter->s and s->name will work and will be much faster.
> > Underneath these loads will be marked with PROBE_MEM flag and
> > will be equivalent to probe_read_kernel calls, but faster
> > since the whole thing will be inlined by JITs.
> 
> Oh, thanks for your review.  I thought it was requried, but it'd
> be definitely better if we can access them directly.  I'll fold
> the below to v4, unless Arnaldo does it first. :)

I'll check and adjust, thanks everybody :-)

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> ---8<---
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 6c771ef751d83b43..6533ea9b044c71d1 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -635,13 +635,13 @@ int slab_cache_iter(void *ctx)
>         if (bpf_core_type_exists(struct bpf_iter__kmem_cache)) {
>                 struct bpf_iter__kmem_cache___new *iter = ctx;
>  
> -               s = BPF_CORE_READ(iter, s);
> +               s = iter->s;
>         }
>  
>         if (s == NULL)
>                 return 0;
>  
> -       nameptr = BPF_CORE_READ(s, name);
> +       nameptr = s->name;
>         bpf_probe_read_kernel_str(d.name, sizeof(d.name), nameptr);
>  
>         d.id = ++slab_cache_id << LCB_F_SLAB_ID_SHIFT;

