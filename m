Return-Path: <bpf+bounces-41032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25529912FE
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442051F23D14
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23431537AA;
	Fri,  4 Oct 2024 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHaa71hy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CC146A68;
	Fri,  4 Oct 2024 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084555; cv=none; b=LP5x2LjFw4Wevqu8D6yFGBPkxZgFWuIJZzN+P1usEO29ybiOY78nUSRw4XbWEssQe6OtR2//ndZh5bd92GFMSXEF4O/zD9o0InFJkxsdX8mWZ1Fv12ehEskAKqbxW5CuqhszLUYTIP6tUrXAPuwQCHfxEO7S++AF35xC3WQB0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084555; c=relaxed/simple;
	bh=aoLXUpmnj6nq/Dgd/ap+0tK44YWQD7Jz9lgBXXobjUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFodghrE7fR/tS1rwIYiinw9o+ujSw4KyaG5xGhxmL+f+KBhuU4ldKIB5JQsMt0bCALfUmPGJKQxOG76upcIHljgUnjByrWzkHuwbSl1XCUKGdJVEWrol3xLgPIUNy5j2QVsM9K/gWwk/QH/xsdT5x+1ZusoB81qF68nWulAu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHaa71hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35122C4CEC6;
	Fri,  4 Oct 2024 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084555;
	bh=aoLXUpmnj6nq/Dgd/ap+0tK44YWQD7Jz9lgBXXobjUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHaa71hytBhkcRCER9vhf4Q9rxZIjF9OQ5sO2kKHtj3OQ91zpf7NZ1aREWs/VSANr
	 J7ZiQ2wcu/az1zTeuG+OCJxD+C2ARp5q//rA/l9QYtb2WCT7BegQQralN5a5nx+8ZD
	 MK6WEV9uPYLtDIjEFqOmX2idf35dczSXUlgUQe5+rBe8X7yXVv+2h5P9fGNTq+3u8b
	 4Y/R87lEWp3wwNvtqofRIVE9j4tJOq67ykUylqukmZOm2Mq91BY1zP+/OKwWOn0bd0
	 ePOa9gxo3VvB7OGIo9qVmhR8ZJ3W/QTWdIZCkHWxPpbnakyi4OCISh1IR9zzLSocFN
	 euzIafjVSmrCw==
Date: Fri, 4 Oct 2024 16:29:12 -0700
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
Message-ID: <ZwB6SO4ARLMBquku@google.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <20241002180956.1781008-2-namhyung@kernel.org>
 <CAPhsuW4HLM=v=eGyT5F7epEKc_tfh=Y643wvkDOJRLdow-RWpg@mail.gmail.com>
 <ZwBgLmcEwuplwNSt@google.com>
 <CAPhsuW7NFHbt0yPxh81gkRo8q_z_6JSrGGGLXtPMqvrbxk6b5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7NFHbt0yPxh81gkRo8q_z_6JSrGGGLXtPMqvrbxk6b5w@mail.gmail.com>

On Fri, Oct 04, 2024 at 02:46:43PM -0700, Song Liu wrote:
> On Fri, Oct 4, 2024 at 2:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Song,
> >
> > On Fri, Oct 04, 2024 at 01:33:19PM -0700, Song Liu wrote:
> [...]
> > > > +
> > > > +static void *kmem_cache_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> > > > +{
> > > > +       struct kmem_cache *s = v;
> > > > +       struct kmem_cache *next = NULL;
> > > > +       bool destroy = false;
> > > > +
> > > > +       ++*pos;
> > > > +
> > > > +       mutex_lock(&slab_mutex);
> > > > +
> > > > +       if (list_last_entry(&slab_caches, struct kmem_cache, list) != s) {
> > > > +               next = list_next_entry(s, list);
> > > > +               if (next->refcount > 0)
> > > > +                       next->refcount++;
> > >
> > > What if next->refcount <=0? Shall we find next of next?
> >
> > The slab_mutex should protect refcount == 0 case so it won't see that.
> > The negative refcount means it's a boot_cache and we shouldn't touch the
> > refcount.
> 
> I see. Thanks for the explanation!
> 
> Please add a comment here, and maybe also add
> 
>   WARN_ON_ONCE(next ->refcount == 0).

Sure, thanks for your review!
Namhyung


