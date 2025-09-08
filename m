Return-Path: <bpf+bounces-67799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D7B49B15
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8E33AA401
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB452D9EF9;
	Mon,  8 Sep 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJ9LvDVr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52013221264
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363409; cv=none; b=gz4apVRAwik2O9k6McZKhV5Tt18mm/sZXducZJtY3a6j2XEtLUI1ILxMzLEE/W7ImLEHD7xNGVwbOf+Ove0Bb4ojFCGTfrlzg2xZpZ6RGEiFovSF33iSwwuBXqNUOprW4XBRQKal8Xf/rDrka2tACW9JkFfHv0R3LkbvGrPwuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363409; c=relaxed/simple;
	bh=h5EOFBHLqgbLt9f4op5gJ8NtlZvhWSn/dH3DpidGDOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjND3r9d1aLV3XQDP0cEjUPET/A8UF4kboQiBPwPxNfWDrAIFE4ihu2trXDOZypEpAwu+J3SAxrC7/jzI72BjOHWjq0kU9+xSnIzVJaS27HT9Co8bifcXhY1F6VoPEwZP4mINIn6Oz/k2N90G39zcwQx8XDoHOqCCingSq7SYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJ9LvDVr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24b2d018f92so488915ad.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757363408; x=1757968208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xh08NSX4A9iDLxHadhJ28F/iw7t67A2KAZWkf6OgAY=;
        b=BJ9LvDVr19hBRwHfOJKitI6RGN2pvrXKTJoTTuNzuvQyS+QhMCBAaF49YdJT7WFJha
         jrqsfEvGXX2Q4BIU3eunc9h74vCcprHzYegXzBedR2CM6xEdMda4IPL8d25d7ZhTEgXY
         YYx/uqOb6J0w/eQvvu+0p4rhp1YsCteRavq2kFG2hNhUD7VRS/z3uIkl6130gFCHWPo4
         YvzMAtslAuYNZVzdIa6RUdNO/fq/M9Pgh0GRGz7GGpqit1J8eQzyf1Cv5kY+NUHKAAQU
         E6xoojLJnEVHjF/X4TzposAot9N/Yx/b4etdVLQD/NVjSbEg7+XmUBbHvmTjTDi4zxVL
         Qo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757363408; x=1757968208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xh08NSX4A9iDLxHadhJ28F/iw7t67A2KAZWkf6OgAY=;
        b=goStvl7UGRnDB/HkzR6WUmosQ78HkgodmiHr5NlsuLYtWDl0MFvJBQi1A7cSgZlzzZ
         h9xvRnuGpa7ssvSYIJ7LSNzthaCeCynB1oUqM9ZGH+NGSUbJCmZZ4WP9dOW60ngfukIx
         p3Rvaro9EodeGieqEzOXsLIDQ0AuPD8X2ZORWl4TbIeY4RiH1lOsot7BBztZkxORuQkZ
         Kzlj9PMzAtumw+mmhkceOWzhY5YLoKMcyVtAUgL4r669IX1ahrSON6pBwx+M1ncypEOO
         B7ywElBJQv2neimrdHf3FMfY1tRxRqLS1ybrFuMfvkGq+uB+HfMnMyTkYiwyrQkrdAPs
         jVBQ==
X-Gm-Message-State: AOJu0Yy24ic57ioiyIDdNflsDiomzvUa6i/pPw9HzSE/mRVslEdT82xa
	7pWtOzpiCRlLxfdXY6dEQNuzicYnfQL7TLRhP27lO5uA+CO2YN+MM4HE5h5l1IRUYg==
X-Gm-Gg: ASbGncshzyY9eUu+wVhanvqQli/5K4zUN9eh8GzofmhgPWgAx45Hwvh55LZTcRIjGNG
	YwHNv3XLA9NXcP/WugOMB/nPtyoz0F/6fzgn5eF1Lh5ajxK+SC2WdUFw1NPC/UWlRLshQaPkyVO
	FCbqnm0D5SOlJ7XyZRWuF7FSVGlbFC8VUZ3A+1zznJfhTnEeMy5+aqmoZrprkuabTHenYdp5o86
	5hw851Qrbvu+GDJNV5HwDMBAeT8exYD/6c92+44Zp6x/qrSa1JLSC8aSoZXMPy4QtqvYuNjFhXf
	ZcRLoyDuGk6gkAg0MikGEsBXtGgtxtdI4Bc1oKb1dh3IFhDDsVxG16ki8K8xLncQWlmKikaJcB6
	7Y/g40yzzKpu70BXzjePNtKEALfSEKFuvVtyQFqtbMuF55KGW8K7+Pse+OgH3
X-Google-Smtp-Source: AGHT+IGAWt4InVNzIi+WTQd6F+c7wQ1SHfRY8vuJuaoIGxDjMz6TdxO28y6tB5fzmWEprBGtBzvINA==
X-Received: by 2002:a17:903:186:b0:24c:863a:4ccc with SMTP id d9443c01a7336-25114efbaaamr7841185ad.4.1757363407285;
        Mon, 08 Sep 2025 13:30:07 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b9be55c1esm13070183a91.9.2025.09.08.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:30:06 -0700 (PDT)
Date: Mon, 8 Sep 2025 20:30:01 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH bpf] bpf/helpers: Use __GFP_HIGH instead of GFP_ATOMIC in
 __bpf_async_init()
Message-ID: <aL88ydkqeVpLKeRz@google.com>
References: <20250905234547.862249-1-yepeilin@google.com>
 <b634rejnvxqu6knjqlijosxrcnxbbpagt4de4pl6env6dwldz2@hoofqufparh5>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b634rejnvxqu6knjqlijosxrcnxbbpagt4de4pl6env6dwldz2@hoofqufparh5>

On Mon, Sep 08, 2025 at 10:32:29AM -0700, Shakeel Butt wrote:
> On Fri, Sep 05, 2025 at 11:45:46PM +0000, Peilin Ye wrote:
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index b9b0c5fe33f6..508b13c24778 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1274,8 +1274,14 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
> >  		goto out;
> >  	}
> >  
> > -	/* allocate hrtimer via map_kmalloc to use memcg accounting */
> > -	cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
> > +	/* Allocate via bpf_map_kmalloc_node() for memcg accounting. Use
> > +	 * __GFP_HIGH instead of GFP_ATOMIC to avoid calling
> > +	 * cgroup_file_notify() if an MEMCG_MAX event is raised by
> > +	 * try_charge_memcg(). This prevents various locking issues, including
> > +	 * double-acquiring locks that may already be held here (e.g.,
> > +	 * cgroup_file_kn_lock, rq_lock).
> 
> Too much unnecessary information in the comment. Just mention that we
> want nolock allocations and for that we need to remove __GFP_RECLAIM
> flags until nolock allocation interfaces are available.

Got it - I'll reword in v2.

Thanks,
Peilin Ye


