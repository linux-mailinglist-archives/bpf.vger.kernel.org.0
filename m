Return-Path: <bpf+bounces-42083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702F99F512
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01442848A0
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749FB1FC7DD;
	Tue, 15 Oct 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpkD4qeu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88DD1C4A2C;
	Tue, 15 Oct 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016401; cv=none; b=q6l+VkvkXDv5peJGaUywnsQW0NyNnTI2wcgmx7cm1Pv5HL1yMdBrfhkP0ZXHHv5JbZTL/4JR8MH0GtwbUKBRFmxtfXivqwF3yoiFb0PukmH4aH/SalTTUWzqiEkVzQ63uz2A1XFAuCMMEwrLdP6jGCGX1Dod6dbAe8wKbdU2n98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016401; c=relaxed/simple;
	bh=/qveEz4oH0ioXwKnVP9i6T15T8fGe8hnk98Bruxgq4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3ZXnlrywASd7UfnGm7Ks4MJMkkSnuiMKGzWX1GRt3FRSTK1uMkW0bQjpYuQUXWjMpf0tTp0NmrUUPwacoxsnBG4zsTf68ulMNVN8oxTrgvj+gb+rItJuXucnTmFHJB0t3vxN4UDyehruNI+3C4JO3+iIC97OWGTm/Q6rAKqerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpkD4qeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C24CC4CEC6;
	Tue, 15 Oct 2024 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729016400;
	bh=/qveEz4oH0ioXwKnVP9i6T15T8fGe8hnk98Bruxgq4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpkD4qeucXLibc1EBuv+su9vyzVuPHT3FT9j0xnD5ovdbZ9wANxdqAJ6GTLeIpsnv
	 X0ROdsgGwWCNTNErBIxQzNf06eLRV/6ns9fnfi0P4TxPboxsbIzNboGnkVcQ2TY5Lf
	 uLKb1pLbPK4fgZkuqRhbjKHxjnqm8rBmRyupxqJ2d/ldoNPOdd0czT7aQSHLcqf2/h
	 tcE5ht3pGEigGaWiAfvekuA5mkzbHoA+uMWgKk3LEBzGH07LSOKe6MTXXm3/u0zwMx
	 VPEpBA00r40JIwBrcTzdXJWmKwVEOgJ8QVEVNvcU5dnkaMHEHsG03UeSpkFp8wGUEb
	 toasnJB80NBbA==
Date: Tue, 15 Oct 2024 11:19:58 -0700
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Message-ID: <Zw6yToBbtOBPvUWx@google.com>
References: <20241010232505.1339892-1-namhyung@kernel.org>
 <20241010232505.1339892-3-namhyung@kernel.org>
 <CAADnVQLN1De95WqUu2ESAdX-wNvaGhSNeboar1k-O+z_d7-dNA@mail.gmail.com>
 <Zwl5BkB-SawgQ9KY@google.com>
 <Zw1fN1WqjvoCeT_s@google.com>
 <CAADnVQJ2M953da8_gnGgWR9x6_-ztqFO8xvRU=bKcwmsH4ewvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ2M953da8_gnGgWR9x6_-ztqFO8xvRU=bKcwmsH4ewvg@mail.gmail.com>

On Mon, Oct 14, 2024 at 06:50:49PM -0700, Alexei Starovoitov wrote:
> On Mon, Oct 14, 2024 at 11:13 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Alexei,
> >
> > On Fri, Oct 11, 2024 at 12:14:14PM -0700, Namhyung Kim wrote:
> > > On Fri, Oct 11, 2024 at 11:35:27AM -0700, Alexei Starovoitov wrote:
> > > > On Thu, Oct 10, 2024 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > The bpf_get_kmem_cache() is to get a slab cache information from a
> > > > > virtual address like virt_to_cache().  If the address is a pointer
> > > > > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > > > > NULL is returned.
> > > > >
> > > > > It doesn't grab a reference count of the kmem_cache so the caller is
> > > > > responsible to manage the access.  The returned point is marked as
> > > > > PTR_UNTRUSTED.  And the kfunc has KF_RCU_PROTECTED as the slab object
> > > > > might be protected by RCU.
> > > >
> > > > ...
> > > > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RCU_PROTECTED)
> > > >
> > > > This flag is unnecessary. PTR_UNTRUSTED can point to absolutely any memory.
> > > > In this case it likely points to a valid kmem_cache, but
> > > > the verifier will guard all accesses with probe_read anyway.
> > > >
> > > > I can remove this flag while applying.
> > >
> > > Ok, I'd be happy if you would remove it.
> >
> > You will need to update the bpf_rcu_read_lock/unlock() in the test code
> > (patch 3).  I can send v6 with that and Vlastimil's Ack if you want.
> 
> Fixed all that while applying.
> 
> Could you please follow up with an open-coded iterator version
> of the same slab iterator ?
> So that progs can iterate slabs as a normal for/while loop ?

I'm not sure I'm following.  Do you want a new test program to iterate
kmem_caches by reading list pointers manually?  How can I grab the
slab_mutex then?

Thanks,
Namhyung


