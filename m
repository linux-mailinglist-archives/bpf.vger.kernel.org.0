Return-Path: <bpf+bounces-40534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1839E98991B
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 04:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75D51C215FD
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427ACC2E9;
	Mon, 30 Sep 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct16NQPZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C43C39;
	Mon, 30 Sep 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662185; cv=none; b=GT6Qx4RBuqyyM/nqZEmXBCIqRZsqU+xuv9Njn+MooH7SL6PVKEqFtWAmTQ6qPKU+bdgTjpcTOLVC6Tpqw7yUJ3sIUk4/PRj4+aEeo23F8aO9NU4DyIeSujoZ8betyTtumYpyf2E0HE+ftPMTAB7z9I9DF0uhR3BSNmHzj8g9FVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662185; c=relaxed/simple;
	bh=8qMICbzT4XtRFiL9y52Kc0zRBSFZP7xkacMj3/zADPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW7ga0zBP52GBAvI8PQ7ArN8rhWWhSvqlqacA/eOLYVHsrkrEZpfFCtSKT2VicC/3a9iklFR/hCzZ6eC30rftA4RPDCs66qYpfCTn5EGJG5nryB2Hm7PjT/62LZxrFj97JCCLdFSv+OG36ubI947q7kU64MZJNDppyiYAOD+ieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct16NQPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D25C4CEC5;
	Mon, 30 Sep 2024 02:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662185;
	bh=8qMICbzT4XtRFiL9y52Kc0zRBSFZP7xkacMj3/zADPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ct16NQPZWfiUZ8/FMrxohrlQowfYn1wUM+qQKvQjD0RPu/xTzonbu6WZ3KoGGG3jL
	 Ku6qi5H6jXmHT+ph7KgUkreOZRvhnjoJORWFNUnjxLr6j3tuDfRGeJVIl8aX7uWc6u
	 Bfy2Cg8tDTVc1J2awGQj08t+4DIx4UQJKbVnJBp7IeKiL21KBk67oL+7LwkLJDeyJS
	 AeQ9YykyrZsJ92TPmEfa33L7K0C3ZGoP4JmE0RIVOG8lzlv17nc5q2WUCiptduwyV0
	 yXoP7Uj4EDkGYZxVPza0NdUI/ZKQ3ku2gUDGSJfYlh4fLxXED6Wx6exvv/7Z64vtT6
	 ita4tr3SIddGw==
Date: Sun, 29 Sep 2024 19:09:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <ZvoIZYyyl73A-D51@google.com>
References: <20240927184133.968283-1-namhyung@kernel.org>
 <20240927184133.968283-3-namhyung@kernel.org>
 <CAADnVQKuR2-My5jYevwQS4K6QmOQVyfK3MYFngWMrc62ZET4ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKuR2-My5jYevwQS4K6QmOQVyfK3MYFngWMrc62ZET4ZA@mail.gmail.com>

On Sun, Sep 29, 2024 at 10:05:42AM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 27, 2024 at 11:41 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> > +{
> > +       struct slab *slab;
> > +
> > +       slab = virt_to_slab((void *)(long)addr);
> > +       return slab ? slab->slab_cache : NULL;
> > +}
> 
> I think this needs more safety guards on 'addr'.
> It needs to check the valid range of 'addr' before doing virt_to_slab.

Ok, I think we can use virt_addr_valid() for that.

Thanks,
Namhyung


