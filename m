Return-Path: <bpf+bounces-42807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5398A9AB575
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97CAB22D23
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19161C3F3C;
	Tue, 22 Oct 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPnNWxOL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FB1C2DCC;
	Tue, 22 Oct 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619421; cv=none; b=Z/rPj6V/UygBJeoOJCa9zPxc19XVlI3UAUKRtt5+Fj+B2yUBxKRYE7hwQOYLE01EA/u75BjiTGrUJrGCVtFE/pKqMBTGLGWvrLrn0SDb7M54TZmi9kixuvEftnwWc2XFRkCmhnXyVviWSgYN3DT3MqWU07PmmHEOjoXoi5PYnEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619421; c=relaxed/simple;
	bh=G+M/C1JGj4HUMyATMntPBe0/cN0QPJXlysf5bNo5dtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+KlH2KBqACF3QwCNOYciKYfwibwzfhRdWy/2kaqbMiYYc13MdlU/SOq5B7qjInHLvEb+D/TfNymrV99qQTghas7lpulcXpZzrB3RE/BwVVwyb9vD/P6wK2AtQrSBKUVVtX+fgVIsPZ02MjW1iRZ1I11cQLZAMu+nJFMgUnkSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPnNWxOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DEFC4CEC3;
	Tue, 22 Oct 2024 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619421;
	bh=G+M/C1JGj4HUMyATMntPBe0/cN0QPJXlysf5bNo5dtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPnNWxOLX/2EAdhnjyuRKA8Nlsexqz1WmC/7jqh3O2Y/BclABN7gji3LdeMw1mZvr
	 p1oWXKpRZQt/1MJPul0JJdklevQ3499S+wL3QahdzkXn9C7HptYifJeMwPWkxu/M/X
	 CF5WIfNUJdb2YnKmi22VDhdjfUFDRRPaP215rEqfLiQ2a77fZuzIC0ZOxwZ/bMvW9/
	 lJG966Anm0SlqegQ8xOrEnwaLn1jmIsdwsxejU3JWXi7FcPNBLg3GHfOQ/AWtHZH5P
	 u4UDWWhC8pIyoGLEJjnE6LBQnI/q+uIvsJxJgfgYpIf8JoJNsHAa0AQ8JaHfinep/J
	 ARw+kNEtYQmbg==
Date: Tue, 22 Oct 2024 10:50:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add open coded version of kmem_cache
 iterator
Message-ID: <Zxfl2kaFGA5GDOqo@google.com>
References: <20241017080604.541872-1-namhyung@kernel.org>
 <CAEf4BzYB-KbDh+h3YXEGeWXcvaVchjf-2m2-nSQoWPE67zY68Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYB-KbDh+h3YXEGeWXcvaVchjf-2m2-nSQoWPE67zY68Q@mail.gmail.com>

Hello,

On Mon, Oct 21, 2024 at 04:32:10PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 17, 2024 at 1:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add a new open coded iterator for kmem_cache which can be called from a
> > BPF program like below.  It doesn't take any argument and traverses all
> > kmem_cache entries.
> >
> >   struct kmem_cache *pos;
> >
> >   bpf_for_each(kmem_cache, pos) {
> >       ...
> >   }
> >
> > As it needs to grab slab_mutex, it should be called from sleepable BPF
> > programs only.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/bpf/helpers.c         |  3 ++
> >  kernel/bpf/kmem_cache_iter.c | 87 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 90 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 073e6f04f4d765ff..d1dfa4f335577914 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3111,6 +3111,9 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> >  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, bpf_get_kmem_cache)
> > +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
> 
> I'm curious. Having bpf_iter_kmem_cache_{new,next,destroy} functions,
> can we rewrite kmem_cache_iter_seq_next in terms of these ones, so
> that we have less duplication of iteration logic? Or there will be
> some locking concerns preventing this? (I haven't looked into the
> actual logic much, sorry, lazy question)

It should be fine with locking, I think there's a subtle difference
between seq interface and the open coded iterator.  But I'll think about
how to reduce the duplication.

Thanks for your review!
Namhyung


