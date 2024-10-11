Return-Path: <bpf+bounces-41780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073DE99AC78
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321A61C260F8
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA01CC179;
	Fri, 11 Oct 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzosRCdb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAA1BDAA7;
	Fri, 11 Oct 2024 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674057; cv=none; b=abwSp1k0fyDWfeJ1iLWwif0AjYIoih2OptZvnYyYJQlQLOiX71vXpwsWDD2Nc/Zf0VwNg/HBpN+LgYKtYKGFB+vxJ0TxOddgpG9wpKG0HqToiHRJozftwd8TtapVc1HEzc3qFhX36Ek9qflSjbz9xay0r7i+G59fp7w1a88r33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674057; c=relaxed/simple;
	bh=eorYjDVDXwQ6GLRpWI1yz9IUKjUMSSgqg6DbEOas7f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGrPXthVMGwMT1i7h13d4J3LeQ2+WjPQnHVKCQvijQYSus5hm+dq/VX+O8i7nTYIVJKfihob8MMvXOycIYk0tmcjFfMXBFV2DinnPgdtcGqV7u5UKkGb410JKSem2bmaKxyw0jbfYvcbVBepfzPqsC3r8RNtetjvJw47AL/lBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzosRCdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4FAC4CEC3;
	Fri, 11 Oct 2024 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728674057;
	bh=eorYjDVDXwQ6GLRpWI1yz9IUKjUMSSgqg6DbEOas7f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzosRCdbS+iKZD58lx2uBd+wDkMLTbR2YdbzYe/7+5uzBCL9ml5kZaeZvl5jhXSVh
	 EjuxiDmCEmZnAQjv7KV+hnG6ot1G88NUCHRDKQ9dq3QeKChgwG/F6JPRJgxmZBlx2S
	 Fac7isaQtaM7V+1WWzA5PiDNcaxZLDpataTilpqVQiL8oTkuRVlYbyLBUgnqFGkTxB
	 RZXqJElib7cOvyPF+JAjsolDHOl+gYSZwtOI5sqS9xP4egz8I1Qdu4fS6Z/BkZ1hf/
	 OA0p0sfyaBzWmbbCDuoiZfBVE1WE2nDTz/2ADaMAckCRmtxu9Rde1q4BvRSG/+98kq
	 0f/wpJd5sdxIg==
Date: Fri, 11 Oct 2024 12:14:14 -0700
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
Message-ID: <Zwl5BkB-SawgQ9KY@google.com>
References: <20241010232505.1339892-1-namhyung@kernel.org>
 <20241010232505.1339892-3-namhyung@kernel.org>
 <CAADnVQLN1De95WqUu2ESAdX-wNvaGhSNeboar1k-O+z_d7-dNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLN1De95WqUu2ESAdX-wNvaGhSNeboar1k-O+z_d7-dNA@mail.gmail.com>

On Fri, Oct 11, 2024 at 11:35:27AM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The bpf_get_kmem_cache() is to get a slab cache information from a
> > virtual address like virt_to_cache().  If the address is a pointer
> > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > NULL is returned.
> >
> > It doesn't grab a reference count of the kmem_cache so the caller is
> > responsible to manage the access.  The returned point is marked as
> > PTR_UNTRUSTED.  And the kfunc has KF_RCU_PROTECTED as the slab object
> > might be protected by RCU.
> 
> ...
> > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RCU_PROTECTED)
> 
> This flag is unnecessary. PTR_UNTRUSTED can point to absolutely any memory.
> In this case it likely points to a valid kmem_cache, but
> the verifier will guard all accesses with probe_read anyway.
> 
> I can remove this flag while applying.

Ok, I'd be happy if you would remove it.

Thanks,
Namhyung


