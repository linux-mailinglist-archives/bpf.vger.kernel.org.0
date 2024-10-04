Return-Path: <bpf+bounces-41025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF2399118A
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB91284E41
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5FB1AE009;
	Fri,  4 Oct 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajnja5FB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28EB231CB1;
	Fri,  4 Oct 2024 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078137; cv=none; b=VqvbPQUOe0/LztkdKaquMVGktRCgt8qAtblxHWTkGSuf2b0RxMM4RRCwsiuHESHgcAEeKEggMgx0eb/obJG6aOrj4RVqoexEfWrRG/MBcyNPSwKZoIlEnOvmOOFI5dFaA0julpgg2ZrW0IdOA3eD9kBD+bee6DkW/z/M5Qitt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078137; c=relaxed/simple;
	bh=T6ND5IS9IVDBJQXIdIciM8H0/qv1eAB0bim1yDiTA6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jebApUqPSKS/BLKsBW6PGbmcDvrO5CaxtxvuU9xinRz+gIep+4bUHgtkvzxnZX+XJbG3WV9YBPlhylWzQs56pprEgY38lIZOLpQaQ+SxAdS6YXC0D5OyN3mN/MiEys9kxjjx/sksdkTEQtXdPORftpLmZ3EaXG6H6KBaHKBRTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajnja5FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7596AC4CEC6;
	Fri,  4 Oct 2024 21:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728078136;
	bh=T6ND5IS9IVDBJQXIdIciM8H0/qv1eAB0bim1yDiTA6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajnja5FBPNJcg+31yWLZiDkKdwWDDk/OSBrGkuPtPdj5rQPT7fL6Htv44QDMQ9roS
	 CgxDWl0cZh/jvIWxGSLDIDvqY4mHEur6XVMUPTbBCxslgMUzZuPMY9+WlLj3rWisX7
	 26QpbIXOw3Mt1J1FyNRFWnbfVRFHYdPbJb/szlcVW6N0qRPYxYBNX662XOvkRCZzr1
	 nIbPvBDRGYodqM/ZC2pQtimKIPbtEgjVqTvQWsUxDA+o0s/cEvR5P1ARrRgNbG5KbQ
	 Lp6ljSvqBAiAC+Fx0Q3xs1ByEsxuUBq4gk37eE8AJ0g+GcIx4UqmfqSbW81xeqnesu
	 BHis6NzgGscPA==
Date: Fri, 4 Oct 2024 14:42:14 -0700
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
Message-ID: <ZwBhNqXbn5R1JN1Y@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-2-namhyung@kernel.org>
 <CAPhsuW5BKxZH2EA=fuQa_3man5_qcUt3euwtfwsqD4g36JngaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5BKxZH2EA=fuQa_3man5_qcUt3euwtfwsqD4g36JngaA@mail.gmail.com>

On Fri, Oct 04, 2024 at 01:45:09PM -0700, Song Liu wrote:
> On Wed, Oct 2, 2024 at 11:09 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> [...]
> > +
> > +static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +       loff_t cnt = 0;
> > +       bool found = false;
> > +       struct kmem_cache *s;
> > +
> > +       mutex_lock(&slab_mutex);
> > +
> > +       /*
> > +        * Find an entry at the given position in the slab_caches list instead
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
> 
> This should be
> 
> if (*pos == 0)
>     ++*pos;

Oh, I thought there's check for seq->count after the seq->op->show()
for the ->start().  I need to check this logic again, thanks for
pointing this out.

Thanks,
Namhyung

> 
> > +       return s;
> > +}
> > +
> > +static void kmem_cache_iter_seq_stop(struct seq_file *seq, void *v)
> [...]

