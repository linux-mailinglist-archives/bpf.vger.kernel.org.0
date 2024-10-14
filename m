Return-Path: <bpf+bounces-41880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE599D631
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 20:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0459E1C2167C
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844D1C82F4;
	Mon, 14 Oct 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzEo7rHp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF371B85E2;
	Mon, 14 Oct 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929594; cv=none; b=dfbDTV/WTUgyFyNd6ep20w33SHs8wh9/vYfOC1Qzg28TkdpF7dBnul5KeIFZR/gIo/z68PUcg3v+3ViabUY1wR9Nly4B4GkzY4A5k6BVB7L5dzEbP8uWsQOureC/F3eA3saR9vCsp9DWezr+7gooilSQE0fj7KRGtVgDiitLeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929594; c=relaxed/simple;
	bh=nAMNq9di7aJMeg6Q0KPWYdeTOE2mztm0/Afx8ugwNTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8equAx0+OL8sxjvYbyTxZV0iGRx2dkwchfobp80hT8DgDBVi2kfReLDrL089/YY/qaVj7gxkfj8kQTiCkB4bxXhgVYDzop393RBThDu9k+PMtrb1XIIEV205+nGvEFHdzkgoqE4unFG9U8wn4DE5t1lbR6ps4zFDf90OFWeebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzEo7rHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5633C4CEC3;
	Mon, 14 Oct 2024 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728929593;
	bh=nAMNq9di7aJMeg6Q0KPWYdeTOE2mztm0/Afx8ugwNTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzEo7rHp4KrNvu35axVfnu5G/hih8dG7eUDYpWFhivoUeBFqY8KbaUVFcHCMwmRxv
	 rprQTUaLaY1sc4mUSVHjzmfxy+z0YC2lzWifzjcwY33QsjkEqTKuRW/P69XNOawCqa
	 YmLbRJPkNqG/kgrjK2jYzEZEZMlkPaTo1HRq2dNc/pFeltOlGkzVeCmX7Sa9Ax/Tox
	 kC4mF1QyPnMypvnmstw/82NgeY80qBsIPmFjdDsGFioMeO9gEP+7ViESwo917uzG9q
	 Q0JzVI/gPUQK8UWFwZJ3MFfT8RjEu8ifhlqlXbdmISaNV87QgqGHWr8rCYc8K5MJFF
	 iTxHiC3eLGNBQ==
Date: Mon, 14 Oct 2024 11:13:11 -0700
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
Message-ID: <Zw1fN1WqjvoCeT_s@google.com>
References: <20241010232505.1339892-1-namhyung@kernel.org>
 <20241010232505.1339892-3-namhyung@kernel.org>
 <CAADnVQLN1De95WqUu2ESAdX-wNvaGhSNeboar1k-O+z_d7-dNA@mail.gmail.com>
 <Zwl5BkB-SawgQ9KY@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zwl5BkB-SawgQ9KY@google.com>

Hi Alexei,

On Fri, Oct 11, 2024 at 12:14:14PM -0700, Namhyung Kim wrote:
> On Fri, Oct 11, 2024 at 11:35:27AM -0700, Alexei Starovoitov wrote:
> > On Thu, Oct 10, 2024 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The bpf_get_kmem_cache() is to get a slab cache information from a
> > > virtual address like virt_to_cache().  If the address is a pointer
> > > to a slab object, it'd return a valid kmem_cache pointer, otherwise
> > > NULL is returned.
> > >
> > > It doesn't grab a reference count of the kmem_cache so the caller is
> > > responsible to manage the access.  The returned point is marked as
> > > PTR_UNTRUSTED.  And the kfunc has KF_RCU_PROTECTED as the slab object
> > > might be protected by RCU.
> > 
> > ...
> > > +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RCU_PROTECTED)
> > 
> > This flag is unnecessary. PTR_UNTRUSTED can point to absolutely any memory.
> > In this case it likely points to a valid kmem_cache, but
> > the verifier will guard all accesses with probe_read anyway.
> > 
> > I can remove this flag while applying.
> 
> Ok, I'd be happy if you would remove it.

You will need to update the bpf_rcu_read_lock/unlock() in the test code
(patch 3).  I can send v6 with that and Vlastimil's Ack if you want.

Thanks,
Namhyung


