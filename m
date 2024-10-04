Return-Path: <bpf+bounces-41024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C899117D
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737211C22E1B
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3DF14831E;
	Fri,  4 Oct 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMv0f0gv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3871231C9D;
	Fri,  4 Oct 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077873; cv=none; b=eVF/2fOeolHA+uNJQf/SNZhFswyQamABFKbyDBKFL05WqneP+EOjj8z1nDLSC41homTBV9VgjeHNjsD8JKwjEkYhljKxmdFMXwCH0NIymkNiPgrSwrmughbzQr5IjnvF1ZZzafxDvm8RchxWuQIUnsBC9CXbvlpQ2oQyAsIoTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077873; c=relaxed/simple;
	bh=uI51PM2JAvMx0e80REFOC0KFBkahpgGyS8qZnr+qSDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqsX9LUiC87/3Jr1hrj32shwjyAeSriXRCE+xzAHG16hblNtJ2zXDVCo2iwJFYXsC7dLVcX6nVeOQqN0mBG1TkRPc4GxFMERuIKbTEAmWJjvNmyPV3XFpNo1PQuYw3iBxk6xHeCiO+jmO247YuyR3uzlvXrg7FZHGoRhKVQ2FxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMv0f0gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B1DC4CEC6;
	Fri,  4 Oct 2024 21:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728077872;
	bh=uI51PM2JAvMx0e80REFOC0KFBkahpgGyS8qZnr+qSDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMv0f0gvdQfc6M4qtQBPEKUHyIEbj1Ud6IouO+vTfHOJP+nyt/oraBHLdCLVS1GRK
	 26RiTZnyedWV2n7jlKDeKGRrrWKIwHw9f0KWTGpYmiEHUSgZWaYk5E/EX2eQCCF3p1
	 pikveRcfVe6Coi89DV+lznTKT5/hand3Fk3aa8ayAV59G6/K7z2NM7YTrqVnTtJoN3
	 DTv0LAYG5zixINz0foPJvaUfAmHTHy48eToMUPx2AG16ZAoDBLqhwtSz36B5kjFwt0
	 kUomy5v/tEdydhJdzjTTtiwPR0hX7mHWC3zy5ZBd4d4BjlkscJEw7UK+poMeYSpkob
	 IBk95lK65lgiQ==
Date: Fri, 4 Oct 2024 14:37:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
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
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add kmem_cache iterator
Message-ID: <ZwBgLmcEwuplwNSt@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-2-namhyung@kernel.org>
 <CAPhsuW4HLM=v=eGyT5F7epEKc_tfh=Y643wvkDOJRLdow-RWpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4HLM=v=eGyT5F7epEKc_tfh=Y643wvkDOJRLdow-RWpg@mail.gmail.com>

Hi Song,

On Fri, Oct 04, 2024 at 01:33:19PM -0700, Song Liu wrote:
> On Wed, Oct 2, 2024 at 11:09 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> [...]
> > +
> > +       mutex_lock(&slab_mutex);
> > +
> > +       /*
> > +        * Find an entry at the given position in the slab_caches list instead
> 
> Nit: style of multi-line comment: "/* Find ...".

Ok, will update.

> 
> > +        * of keeping a reference (of the last visited entry, if any) out of
> > +        * slab_mutex. It might miss something if one is deleted in the middle
> > +        * while it releases the lock.  But it should be rare and there's not
> > +        * much we can do about it.
> > +        */
> > +       list_for_each_entry(s, &slab_caches, list) {
> > +               if (cnt == *pos) {
> > +                       /*
> > +                        * Make sure this entry remains in the list by getting
> > +                        * a new reference count.  Note that boot_cache entries
> > +                        * have a negative refcount, so don't touch them.
> > +                        */
> > +                       if (s->refcount > 0)
> > +                               s->refcount++;
> > +                       found = true;
> > +                       break;
> > +               }
> > +               cnt++;
> > +       }
> > +       mutex_unlock(&slab_mutex);
> > +
> > +       if (!found)
> > +               return NULL;
> > +
> > +       ++*pos;
> > +       return s;
> > +}
> > +
> > +static void kmem_cache_iter_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +       struct bpf_iter_meta meta;
> > +       struct bpf_iter__kmem_cache ctx = {
> > +               .meta = &meta,
> > +               .s = v,
> > +       };
> > +       struct bpf_prog *prog;
> > +       bool destroy = false;
> > +
> > +       meta.seq = seq;
> > +       prog = bpf_iter_get_info(&meta, true);
> > +       if (prog)
> > +               bpf_iter_run_prog(prog, &ctx);
> > +
> > +       if (ctx.s == NULL)
> > +               return;
> > +
> > +       mutex_lock(&slab_mutex);
> > +
> > +       /* Skip kmem_cache_destroy() for active entries */
> > +       if (ctx.s->refcount > 1)
> > +               ctx.s->refcount--;
> > +       else if (ctx.s->refcount == 1)
> > +               destroy = true;
> > +
> > +       mutex_unlock(&slab_mutex);
> > +
> > +       if (destroy)
> > +               kmem_cache_destroy(ctx.s);
> > +}
> > +
> > +static void *kmem_cache_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> > +{
> > +       struct kmem_cache *s = v;
> > +       struct kmem_cache *next = NULL;
> > +       bool destroy = false;
> > +
> > +       ++*pos;
> > +
> > +       mutex_lock(&slab_mutex);
> > +
> > +       if (list_last_entry(&slab_caches, struct kmem_cache, list) != s) {
> > +               next = list_next_entry(s, list);
> > +               if (next->refcount > 0)
> > +                       next->refcount++;
> 
> What if next->refcount <=0? Shall we find next of next?

The slab_mutex should protect refcount == 0 case so it won't see that.
The negative refcount means it's a boot_cache and we shouldn't touch the
refcount.

Thanks,
Namhyung

> 
> > +       }
> > +
> > +       /* Skip kmem_cache_destroy() for active entries */
> > +       if (s->refcount > 1)
> > +               s->refcount--;
> > +       else if (s->refcount == 1)
> > +               destroy = true;
> > +
> > +       mutex_unlock(&slab_mutex);
> > +
> > +       if (destroy)
> > +               kmem_cache_destroy(s);
> > +
> > +       return next;
> > +}
> [...]

