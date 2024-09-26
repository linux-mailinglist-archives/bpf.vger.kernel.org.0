Return-Path: <bpf+bounces-40361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B549878D2
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 20:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7705283708
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9461662E7;
	Thu, 26 Sep 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBYdNH+I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B54A24;
	Thu, 26 Sep 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373867; cv=none; b=Wmj5+0T5wBV72s4Ndc3N5Iv20EHZyleLACCMxkn3KxdZWe/b1ySf0OCEujMT7BIkAHw4etPf5NtLoSUtOiStckbzr/MQgCHRVQbkMY5hSjwHF2rBLbRClwng2ATWCnLj+iRK+HZXrcXJX942I+vPvXVtNvGYFBfBs+yLLEDB+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373867; c=relaxed/simple;
	bh=gj9eNFEeiWVEaaqEkkwhe3PeLqdetTJaVkbInymCKyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd+t8bdWw1goE9g9ABsL973ZYz17euNfnU1bA7Bl0U7+j3T1DtvyMT0URSpQBz35N2Qx1BDNqnzvLyeZmfx4EqzHYc3SbOB2bOMGpgvFCCL7hZX3Cd87GCS7quaqQX1XIJ0KwZl5phU7/fwV35De4GYFntLa0+szdUxNnCR3WPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBYdNH+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CF1C4CEC5;
	Thu, 26 Sep 2024 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727373865;
	bh=gj9eNFEeiWVEaaqEkkwhe3PeLqdetTJaVkbInymCKyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBYdNH+I4AK26SkyPpnSkEDEL6ETqz9yHPijs8bPR8r/vSQ4Z9QCMUvjBqTnLwDkO
	 t2MgFmsZcKotLMgPMs0Co29Zh0nzuSOYs5D92soiZpo7XF+GdoH57C+njD16nQmY4l
	 mAi/o6llL25D/ll3uL7y7iSgI5zmI09l0e9HIy6LYr4LzmXns6iZ85ZQBIkQpr7eo2
	 CsbSboz0Lp5Yq5EmsYHDzYMMZICxzKX7GtjgddHsy4DuPbSOiV8xclcDPK+vYWmUiS
	 2zODvxiO7dmWn5+5buvL/ZNjFk7U/dcjHGnkuOdqmfrc9/hhbHruZT+Hc1TE9bNiG7
	 BDvX1XYPVA35w==
Date: Thu, 26 Sep 2024 11:04:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
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
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Subject: Re: [RFC/PATCH bpf-next 0/3] bpf: Add slab iterator and kfunc (v1)
Message-ID: <ZvWiJ_Mcb5zbE2Dm@google.com>
References: <20240925223023.735947-1-namhyung@kernel.org>
 <ZvSnz4F7gDFa9_ue@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvSnz4F7gDFa9_ue@google.com>

On Thu, Sep 26, 2024 at 12:16:15AM +0000, Roman Gushchin wrote:
> On Wed, Sep 25, 2024 at 03:30:20PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > I'm proposing a new iterator and a kfunc for the slab memory allocator
> > to get information of each kmem_cache like in /proc/slabinfo or
> > /sys/kernel/slab.
> 
> Hello, Namhyung!

Hello Roman!

> 
> I personally like the idea very much. With a growing number of kmem_caches
> /proc/slabinfo getting close to it's limit, so having a more flexible
> interface makes a lot of sense.
> 
> > Maybe I need to call it kmem_cache iter but slab
> > was short and easier to call. :)
> 
> I'd personally prefer kmem_cache or slab_cache, just in case somebody later
> would propose an iterator over individual slab objects within a kmem_cache.

I think we can add a parameter to limit or extend the functionality
like task iter and cgroup iter.  But I'm not sure we need to use a
different name for that.  Anyway I'm ok to rename it kmem_cache iter.

> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)

Thanks for your review!
Namhyung

