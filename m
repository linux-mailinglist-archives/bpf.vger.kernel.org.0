Return-Path: <bpf+bounces-41022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF78991170
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD2D1C23775
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F71D8A1F;
	Fri,  4 Oct 2024 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxvE+Uxp"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BA1AE008
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077146; cv=none; b=ET2jhbfDhpD+ybEZJ9MAchatwqZrVlc86bEkQs64tEPRS5FeGfWuAdU4MqEc7t9NtU+d3LkC/7VvHmtX1TH0LNMvqjcVXBk74dkTqEruPokXsqKwrN8fyGqDr94oZrmkP5RigyhbObzA4YbItdMcD7wAsNpfJLn/fIvAGDjYRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077146; c=relaxed/simple;
	bh=jANsz80qnisMNU35j5tgfQhGH2pfxSnXspLE31Mdo1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXbjsithL63sHqz2iwqlqjq+HhdxplX17YLoCeUTGlTUFFCdG3rOLMhmvDQba+pVYYGKcY0d0tAyX9tlXVzFVlucOIQtRS3GcYpnzjW9G4adL3QEqwnjSzGtEAGvzn8YWDqbfgzxHL9dKcQ6yIsPJDPFQ6/0KVQYSHbEURuhXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxvE+Uxp; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 4 Oct 2024 21:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728077141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYKtCoATsBvcWFCPa9gSKY/ijfwd28CJD3PnHOgkIHI=;
	b=FxvE+UxpYBlx5VXP9BMFUDR0DbPw5dRg4ki38HZdOgHbyUHZOCjxs+3RCBzrk9Ul3dR6ES
	WCgCACAbUMJ96/3xlLzK18PATEwAjKsgYjN1+pCyQm+rqJ008fos8JS4p6WzI+g0NsqNib
	dzRBetNMBukPqAoUfVQf5oo1WKjAPeI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Song Liu <song@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <ZwBdS86yBtOWy3iD@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-3-namhyung@kernel.org>
 <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 04, 2024 at 01:10:58PM -0700, Song Liu wrote:
> On Wed, Oct 2, 2024 at 11:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The bpf_get_kmem_cache() is to get a slab cache information from a
> > virtual address like virt_to_cache().  If the address is a pointer
> > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > NULL is returned.
> >
> > It doesn't grab a reference count of the kmem_cache so the caller is
> > responsible to manage the access.  The intended use case for now is to
> > symbolize locks in slab objects from the lock contention tracepoints.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> > Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/bpf/helpers.c |  1 +
> >  mm/slab_common.c     | 19 +++++++++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 4053f279ed4cc7ab..3709fb14288105c6 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> >  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
> >  BTF_KFUNCS_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set = {
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 7443244656150325..5484e1cd812f698e 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
> >  }
> >  EXPORT_SYMBOL(ksize);
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +#include <linux/btf.h>
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> > +{
> > +       struct slab *slab;
> > +
> > +       if (!virt_addr_valid(addr))
> > +               return NULL;
> > +
> > +       slab = virt_to_slab((void *)(long)addr);
> > +       return slab ? slab->slab_cache : NULL;
> > +}
> 
> Do we need to hold a refcount to the slab_cache? Given
> we make this kfunc available everywhere, including
> sleepable contexts, I think it is necessary.

It's a really good question.

If the callee somehow owns the slab object, as in the example
provided in the series (current task), it's not necessarily.

If a user can pass a random address, you're right, we need to
grab the slab_cache's refcnt. But then we also can't guarantee
that the object still belongs to the same slab_cache, the
function becomes racy by the definition.

