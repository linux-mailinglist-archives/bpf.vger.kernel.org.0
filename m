Return-Path: <bpf+bounces-47531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA09FA2FA
	for <lists+bpf@lfdr.de>; Sun, 22 Dec 2024 00:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC161889EA4
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0E1DE4C2;
	Sat, 21 Dec 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3+UX8c3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439B1CF8B;
	Sat, 21 Dec 2024 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734825336; cv=none; b=henF1cuBN0rlOI1pnMdVZgljpVR7yf8thvrB0Kti8UchbtL4IY4QVKvCNxbBcF1XSUFt3RcDt4aZCFQonfXL0tCEf5TRRd7C6X31v/4pi4C3ZtJIMnDcpysY0ZOnaSLeb3uPwtBYMwwwR0edB4zKjjCd5t0fYurKYpf9hn76dZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734825336; c=relaxed/simple;
	bh=jE4sDUPRqABCV6IyyDL4ZlWY5L0sgZddlRag2s0wQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdSZvJZB2S0Xca2DxnYhEbLdgC/t0pWmxfwfbFJlvh+aHpv6CXIibnQYA1ktPLYIcb2i815PYX6gF3DusaWuN4Iohfo0reSnfHViQpFH7VCZLM5l+Jhjggg7A+lRrMOUoJ5bEeoANBFbY9SJtmRlomDGmebRHM5HcsemrhuBsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3+UX8c3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042D9C4CECE;
	Sat, 21 Dec 2024 23:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734825335;
	bh=jE4sDUPRqABCV6IyyDL4ZlWY5L0sgZddlRag2s0wQaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3+UX8c3o7hSE44jiOWg1t176J45ykcQspnhpma+if24wQ6UMkhnuppAl1k1NeaX4
	 cBsl9qi6+4qyPQudSBjjqh180MNloVS+7J6RpbN9Tb11YoknZAZvL5iQS7nMB+bfWT
	 MWNb7Oa9dKWa4F21MDxppInhos2tfhYnaD/myfslyFUCk8dPrymuKL7Xy3Ec48p0hW
	 JBr1mjuLYEnA7R9QRIGyQdIhuqUqa8bREqbxXvWtKfuT/ati1qsk0liOP6/xsTgfyg
	 O8idMv10Z2U627egd7/odS6XVeJL4H/AqJ8z/PtORfVQ0vFL1xcaebVYYao1que2BG
	 QnhGLWSYL6MAA==
Date: Sat, 21 Dec 2024 15:55:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <Z2dVdH3o5iF-KrWj@google.com>
References: <20241220060009.507297-1-namhyung@kernel.org>
 <20241220060009.507297-3-namhyung@kernel.org>
 <CAADnVQLm-jA5-39-LUKybO2oGbDRr2RgPtJH5iXoeKnYqdJUuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLm-jA5-39-LUKybO2oGbDRr2RgPtJH5iXoeKnYqdJUuw@mail.gmail.com>

Hi Alexei,

On Fri, Dec 20, 2024 at 03:52:36PM -0800, Alexei Starovoitov wrote:
> On Thu, Dec 19, 2024 at 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > +struct bpf_iter__kmem_cache___new {
> > +       struct kmem_cache *s;
> > +} __attribute__((preserve_access_index));
> > +
> > +SEC("iter/kmem_cache")
> > +int slab_cache_iter(void *ctx)
> > +{
> > +       struct kmem_cache *s = NULL;
> > +       struct slab_cache_data d;
> > +       const char *nameptr;
> > +
> > +       if (bpf_core_type_exists(struct bpf_iter__kmem_cache)) {
> > +               struct bpf_iter__kmem_cache___new *iter = ctx;
> > +
> > +               s = BPF_CORE_READ(iter, s);
> > +       }
> > +
> > +       if (s == NULL)
> > +               return 0;
> > +
> > +       nameptr = BPF_CORE_READ(s, name);
> 
> since the feature depends on the latest kernel please use
> direct access. There is no need to use BPF_CORE_READ() to
> be compatible with old kernels.
> Just iter->s and s->name will work and will be much faster.
> Underneath these loads will be marked with PROBE_MEM flag and
> will be equivalent to probe_read_kernel calls, but faster
> since the whole thing will be inlined by JITs.

Oh, thanks for your review.  I thought it was requried, but it'd
be definitely better if we can access them directly.  I'll fold
the below to v4, unless Arnaldo does it first. :)

Thanks,
Namhyung


---8<---
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 6c771ef751d83b43..6533ea9b044c71d1 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -635,13 +635,13 @@ int slab_cache_iter(void *ctx)
        if (bpf_core_type_exists(struct bpf_iter__kmem_cache)) {
                struct bpf_iter__kmem_cache___new *iter = ctx;
 
-               s = BPF_CORE_READ(iter, s);
+               s = iter->s;
        }
 
        if (s == NULL)
                return 0;
 
-       nameptr = BPF_CORE_READ(s, name);
+       nameptr = s->name;
        bpf_probe_read_kernel_str(d.name, sizeof(d.name), nameptr);
 
        d.id = ++slab_cache_id << LCB_F_SLAB_ID_SHIFT;


