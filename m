Return-Path: <bpf+bounces-41591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA00998DFE
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1814B27C7C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EF199384;
	Thu, 10 Oct 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6Ix0bf3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC8198A24;
	Thu, 10 Oct 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578765; cv=none; b=DCMTkt/C2+8nbNEs3e6lM4nYBwee4HZrg78QMXhJrQDQrUbgdFtI+QHr00NivUKdFS9ZSEnFip8szwG3VjrKo9qwL4URCFaapwugseFqQqgYtsvinDm3l+B/EVHIEo8ipV4qoiKP0SeDNlhSnoeekI79a3RnGjh3K6w1wj4ctas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578765; c=relaxed/simple;
	bh=08oJ1Ty/lrHxJqMnlNGf1Ch3DicmHiyZz4nCpw21uTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBIor1wkxdKFAH3I1qRrh+siVg2iwGUUowS+oxncSFB0AcESswULCjWEbiu5zbJoNAZmslgtCKgEIJ158Kx4NmGFCKZQAHxHNxaL/UdcyeE10ygvY8j9+sAJluDTvvCz+La3qujHKPu6Yl7NiMgld8xCTbcX+ZkOgnHyj9D7DMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6Ix0bf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C578C4CEC5;
	Thu, 10 Oct 2024 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728578765;
	bh=08oJ1Ty/lrHxJqMnlNGf1Ch3DicmHiyZz4nCpw21uTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6Ix0bf3cc4FRzmp91azgETmOFuE1wfVYXinRRyp/GD+FEuglq4TSdz9649GSdcug
	 0SYmCsewJ/UiaKzoy9ydisL4moKN3CEBN2+blXvMpwfEJkE+N9G+GGLGgDu2kAUQQ7
	 GbIEOhxWfoQmkdZaloxwfgYsdCdfcdKI3l9c8rlRClxSNqJxVPvZJ3m9Ld5lmnQKFl
	 4eguRKzkJpu5ZhMzDRvgm/SoBWRz33hySRLia5MnJpQ5q62NT0FVOP0DGZbXm7QO1y
	 Hlf3uE9SKbY6T/2PeGYHYsWHacXMGWVSUVEuKEF7Tbdb6IMv9M7epOv6zWu8rOn+om
	 Nmzi5alsOz6RQ==
Date: Thu, 10 Oct 2024 09:46:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <ZwgEykf_XmVpEE8_@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
 <ZwBdS86yBtOWy3iD@google.com>
 <37ca3072-4a0b-470f-b5b2-9828a2b708e5@suse.cz>
 <ZwYt-GJfzMoozTOU@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwYt-GJfzMoozTOU@google.com>

On Wed, Oct 09, 2024 at 12:17:12AM -0700, Namhyung Kim wrote:
> On Mon, Oct 07, 2024 at 02:57:08PM +0200, Vlastimil Babka wrote:
> > On 10/4/24 11:25 PM, Roman Gushchin wrote:
> > > On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> > >> On Wed, Oct 2, 2024 at 11:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >>>
> > >>> The bpf_get_kmem_cache() is to get a slab cache information from a
> > >>> virtual address like virt_to_cache().  If the address is a pointer
> > >>> to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > >>> NULL is returned.
> > >>>
> > >>> It doesn't grab a reference count of the kmem_cache so the caller is
> > >>> responsible to manage the access.  The intended use case for now is to
> > >>> symbolize locks in slab objects from the lock contention tracepoints.
> > >>>
> > >>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > >>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > >>> Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > 
> > So IIRC from our discussions with Namhyung and Arnaldo at LSF/MM I
> > thought the perf use case was:
> > 
> > - at the beginning it iterates the kmem caches and stores anything of
> > possible interest in bpf maps or somewhere - hence we have the iterator
> > - during profiling, from object it gets to a cache, but doesn't need to
> > access the cache - just store the kmem_cache address in the perf record
> > - after profiling itself, use the information in the maps from the first
> > step together with cache pointers from the second step to calculate
> > whatever is necessary
> 
> Correct.
> 
> > 
> > So at no point it should be necessary to take refcount to a kmem_cache?
> > 
> > But maybe "bpf_get_kmem_cache()" is implemented here as too generic
> > given the above use case and it should be implemented in a way that the
> > pointer it returns cannot be used to access anything (which could be
> > unsafe), but only as a bpf map key - so it should return e.g. an
> > unsigned long instead?
> 
> Yep, this should work for my use case.  Maybe we don't need the
> iterator when bpf_get_kmem_cache() kfunc returns the valid pointer as
> we can get the necessary info at the moment.  But I think it'd be less
> efficient as more work need to be done at the event (lock contention).
> It'd better setting up necessary info in a map before monitoring (using
> the iterator), and just looking up the map with the kfunc while
> monitoring the lock contention.

Maybe it's still better to return a non-refcounted pointer for future
use.  I'll leave it for v5.

Thanks,
Namhyung


