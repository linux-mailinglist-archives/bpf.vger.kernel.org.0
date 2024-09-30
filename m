Return-Path: <bpf+bounces-40531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B5E98990A
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 03:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360B41C210D4
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 01:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D9848E;
	Mon, 30 Sep 2024 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmVvqDai"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11214566A;
	Mon, 30 Sep 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661124; cv=none; b=GpGjEx86CkWKvYd84TKNDGuyU0MWTKo9JydcmXmPSMFk3QdbEBIQoLXi/7L7Q5skHAd1H5pWAt0yAJyftqVG/nAkOE6y3kOBJ6qzL2x6ft2dWYkuE1J0k9wEMRCzzyB2WItdKshiFOKDIaaDddMMi9vHu65POiu2QsDgJBP4wzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661124; c=relaxed/simple;
	bh=Ygv82u8MaTIGw4j1VwEn56lzxTjIHWN4CaJ19mHyz0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW+dPwIMwwV+ZK0ABGxli6tGkk2ux7ym7yB9DEIJnLPJ/pAlFPeFdmG3kxYIVxPNrc1ozNN3Zngt2Ia9xUSD7Tt22X5/ZQICf/rxjF35vFUCX08S9B6ELhOnz1RG53KPlQ8YyMC8jgOVlZsxC10kiPMu7ypjn7D5te5meVYgfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmVvqDai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F90C4CEC6;
	Mon, 30 Sep 2024 01:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727661123;
	bh=Ygv82u8MaTIGw4j1VwEn56lzxTjIHWN4CaJ19mHyz0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmVvqDaip7ffiKitmaimglVXV49v4LM2VaFEG3Ryx439qSXFIadR68oSzwx/OmVK/
	 mfR4/mgtN3wUkXUmW+YEUKvb/DPxKNTmnffTXCtAMJi8JX09MyyALtPVxe6/3+aLwq
	 FDfm3Ozt0hBKI/P1GBmIQZGiuwdUfTCuuA+bumITf3wl4ELL/1gEhmneinCvhn2y0m
	 Rm6oj8tOhSoYFq50CH4pylzEraDiuP0qyEZ0gbUhW63/f9QUd16nCf5FF65bmrJrPQ
	 e8dBlbFU9OGOBvi+diPRBZBLKTyhN7ptXXYWVV08PVq83B2e4cgErbWdED8KeUNO4R
	 8LjtXqEiT2+8A==
Date: Sun, 29 Sep 2024 18:51:59 -0700
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
Subject: Re: [RFC/PATCH bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc
 (v2)
Message-ID: <ZvoEPyrJF4uk1_LI@google.com>
References: <20240927184133.968283-1-namhyung@kernel.org>
 <CAADnVQLeARMvSqg0aqgBS0vncV-m6e+sM9C_Ox0r3SL1=GpRgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLeARMvSqg0aqgBS0vncV-m6e+sM9C_Ox0r3SL1=GpRgA@mail.gmail.com>

Hello Alexei,

On Sun, Sep 29, 2024 at 10:00:56AM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 27, 2024 at 11:41 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > I'm proposing a new iterator and a kfunc for the slab memory allocator
> > to get information of each kmem_cache like in /proc/slabinfo or
> > /sys/kernel/slab in more flexible way.
> >
> > v2 changes)
> 
> The subject is confusing CI and human readers.
> Please use [PATCH v3 bpf-next ..] in the future.
> 
> Also note that RFC patches are never going to be applied and they are
> ignored by BPF CI.
> If you want things to land then drop the RFC tag.

Ok, I'll change the subject line in the next version.

Thanks,
Namhyung

