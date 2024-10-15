Return-Path: <bpf+bounces-42094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C57099F84E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 22:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2910F284434
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F81FBF4F;
	Tue, 15 Oct 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaSX1VpI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFC1FBF41;
	Tue, 15 Oct 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025649; cv=none; b=i1ujXZSRBIPAKyQbUrXGcVhVPBmiGQW1hFrxetvnFwfRF3vzViyIoGYxnzm5dddugb9RHl7h4aF9+ydrDjpoDLKatArd9bJZc07Opmtd5uWd01pStordKru9h80eHSRDieuNgSOWYLAnG+ynW4mdSKml1fhjqrCAM1Wr+HfcFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025649; c=relaxed/simple;
	bh=dxLe8pq5mSXA6ZyikQ6T09dXj2SPF/PaIf6/4RUjGlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjH1dKkhLImqZUBfvCk7BMcRlM1Hy6atYAcP5maLNrxLbbE538HYjH8ZEp+zkzv03RKUUFbqTYPCriUfmiViNICLPhXkWhjTzdx+4RbGDPNLjp0qgtop03REb6SqN/o2yEUJvNXuVjgwb+Q2uwxsNx01tfm4f2VXaJ8McFhTvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaSX1VpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9900CC4CED1;
	Tue, 15 Oct 2024 20:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729025648;
	bh=dxLe8pq5mSXA6ZyikQ6T09dXj2SPF/PaIf6/4RUjGlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaSX1VpIDaWjr+PVKj8bGzgc9Ohnj1XK9heWLlIQmOFARXxwjtxyX3leqNijRdssf
	 BC0+MQ8fYZa1L8/LFnZV5+COBaJYPuvg0RMjQ5QUxi2AXyCIvKBGpp1KuyEKuPQFKf
	 O+l7DDHJDEJKZ13PMAD5JyJ62oiDx8ZWVHpdPihLhou+EXQSCflDUwhkkH2DSv6sNY
	 EGcen9Zh7PIXGeBogdau9wUoLV4P8FrgRyfk7RYtNS1KTLxlwOO6OK36zraQ/0z/5P
	 bgh3YBoRlRJ2Aoz4Ny7k3Uqpk42RAKaIY8S4eLKTZ3Latf5074NjD3vvDQ9UUUBtS7
	 iHOctD3I9RoAg==
Date: Tue, 15 Oct 2024 13:54:06 -0700
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
Message-ID: <Zw7WbhSXnOlUf1lD@google.com>
References: <20241010232505.1339892-1-namhyung@kernel.org>
 <20241010232505.1339892-3-namhyung@kernel.org>
 <CAADnVQLN1De95WqUu2ESAdX-wNvaGhSNeboar1k-O+z_d7-dNA@mail.gmail.com>
 <Zwl5BkB-SawgQ9KY@google.com>
 <Zw1fN1WqjvoCeT_s@google.com>
 <CAADnVQJ2M953da8_gnGgWR9x6_-ztqFO8xvRU=bKcwmsH4ewvg@mail.gmail.com>
 <Zw6yToBbtOBPvUWx@google.com>
 <CAADnVQ+Y8BG80=8vcipKVnOL0Htd7W60f4LOPB5shG4eSORVcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+Y8BG80=8vcipKVnOL0Htd7W60f4LOPB5shG4eSORVcg@mail.gmail.com>

On Tue, Oct 15, 2024 at 11:25:11AM -0700, Alexei Starovoitov wrote:
> On Tue, Oct 15, 2024 at 11:20 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Oct 14, 2024 at 06:50:49PM -0700, Alexei Starovoitov wrote:
> > > On Mon, Oct 14, 2024 at 11:13 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Alexei,
> > > >
> > > > On Fri, Oct 11, 2024 at 12:14:14PM -0700, Namhyung Kim wrote:
> > > > > On Fri, Oct 11, 2024 at 11:35:27AM -0700, Alexei Starovoitov wrote:
> > > > > > On Thu, Oct 10, 2024 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > >
> > > > > > > The bpf_get_kmem_cache() is to get a slab cache information from a
> > > > > > > virtual address like virt_to_cache().  If the address is a pointer
> > > > > > > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > > > > > > NULL is returned.
> > > > > > >
> > > > > > > It doesn't grab a reference count of the kmem_cache so the caller is
> > > > > > > responsible to manage the access.  The returned point is marked as
> > > > > > > PTR_UNTRUSTED.  And the kfunc has KF_RCU_PROTECTED as the slab object
> > > > > > > might be protected by RCU.
> > > > > >
> > > > > > ...
> > > > > > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RCU_PROTECTED)
> > > > > >
> > > > > > This flag is unnecessary. PTR_UNTRUSTED can point to absolutely any memory.
> > > > > > In this case it likely points to a valid kmem_cache, but
> > > > > > the verifier will guard all accesses with probe_read anyway.
> > > > > >
> > > > > > I can remove this flag while applying.
> > > > >
> > > > > Ok, I'd be happy if you would remove it.
> > > >
> > > > You will need to update the bpf_rcu_read_lock/unlock() in the test code
> > > > (patch 3).  I can send v6 with that and Vlastimil's Ack if you want.
> > >
> > > Fixed all that while applying.
> > >
> > > Could you please follow up with an open-coded iterator version
> > > of the same slab iterator ?
> > > So that progs can iterate slabs as a normal for/while loop ?
> >
> > I'm not sure I'm following.  Do you want a new test program to iterate
> > kmem_caches by reading list pointers manually?  How can I grab the
> > slab_mutex then?
> 
> No.
> See bpf_iter_task_new/_next/_destroy kfuncs and
> commit c68a78ffe2cb ("bpf: Introduce task open coded iterator kfuncs").

Oh, ok.  Thanks for the pointer, I'll take a look and add the open code
version.

Thanks,
Namhyung


