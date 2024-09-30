Return-Path: <bpf+bounces-40533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB316989919
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 04:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BC0283565
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 02:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A88F62;
	Mon, 30 Sep 2024 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvhEU7jz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1613C39;
	Mon, 30 Sep 2024 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662118; cv=none; b=mw+wcHL+rIdov5qohwdL5V3eNWsLrUs7inRrxCDteWCbuBV4aaZn0d/IuyF1BKPv2TB/SOM/RJGTGcGbfrWvacdxBx4OBzdHUOztPlCxZQG3DHCicEVEw5XbDziCwmKwBcOUD9G5zXfjbH+92YR6rDVoJvkER9mZX1riuhOLlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662118; c=relaxed/simple;
	bh=OUonpseR6pJPGe8VGSeGWmeUScOwYYqu4kkrnSeXGf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDSzsJbbdFxGbwUx6Nm+hG62zxfnFuiBGi32x1a8wGeFgpBit7iOtuqxDiN0ESiUMqA/T6OdOD3CCpztVTwvq0zffVNqlJ/ihTayH+VrxDYdLZV4ik6B5jOXALmWdznhXBbU3e0gf6ilP7XpqkipWQlgwSORjlftpI26PUKcDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvhEU7jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DEAC4CEC5;
	Mon, 30 Sep 2024 02:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662118;
	bh=OUonpseR6pJPGe8VGSeGWmeUScOwYYqu4kkrnSeXGf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvhEU7jz/GlZS2Y5SRMHRqC00fg3ROMhjb2IVGCdCoSygbQ8ybdXoDL2gJhL6N+SM
	 qypDZIx81N51BvC/0Dm+8K24kPENXEPk+VNqg6cZtQSdxSqhTbc+6u5lFVNH7TNMVm
	 vmec0sC+P/O5KS2eclw4dtkkx5EU3NBJG52uL3eleQQ4CpX+puai5/w0oX0ls4vBuk
	 LNOI7ilAKPtv7UljqNZquY8k11WAR4knhRGUNa5WqskwAtADNNX1j3kqv35jiQtjh4
	 //g6utAwDxQBzWW6xWB6gtXbd6X0ECtfi6dxmiimC64og2quy2Orwh6Kdg63QXKxGF
	 aMUhEVPfMp1RQ==
Date: Sun, 29 Sep 2024 19:08:34 -0700
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
Subject: Re: [RFC/PATCH bpf-next 1/3] bpf: Add kmem_cache iterator
Message-ID: <ZvoIIoxQvL7sHy__@google.com>
References: <20240927184133.968283-1-namhyung@kernel.org>
 <20240927184133.968283-2-namhyung@kernel.org>
 <CAADnVQJBKCHJKqjNe9AHEnSbvAZ5Jf_0ULw=v7v3BEW8Pv=_6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJBKCHJKqjNe9AHEnSbvAZ5Jf_0ULw=v7v3BEW8Pv=_6w@mail.gmail.com>

On Sun, Sep 29, 2024 at 10:04:00AM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 27, 2024 at 11:41 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > +static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +       loff_t cnt = 0;
> > +       struct kmem_cache *s = NULL;
> > +
> > +       mutex_lock(&slab_mutex);
> 
> It would be better to find a way to iterate slabs without holding
> the mutex for the duration of the loop.
> Maybe use refcnt to hold the kmem_cache while bpf prog is looking at it?

Do you mean that you want to not hold slab_mutex while BPF program is
running?  Maybe we can allocates an arary of pointers to the slab cahe
(with refcounts) at the beginning and iterate them instead.  And call
kmem_cache_destroy() for each entry at the end.  Is it ok to you?

Thanks,
Namhyung


