Return-Path: <bpf+bounces-51573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E800A3629F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EAC7A469B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0406E26738D;
	Fri, 14 Feb 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnxfsNb3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8B156C40;
	Fri, 14 Feb 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549071; cv=none; b=pz8r0Cmpvh5GfC83OaEMWFAGGIoaUhUjy1x4YKeSs5E5pxlmmabH5Z8iKdBdnAa0akao0BYOitlN/IoCpgrVEWvcLaL0vpfeHug4ZiK6XxwlRHRFiEsePnLa+KRmHDrT1ENdXeSVs3nIw1xPzacMTlu7MnU0OgZeVUe3OefCCR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549071; c=relaxed/simple;
	bh=40k2bFaPMVCxdWgPTG5Q+U8Nu9Zmh+DnNr+UJ2CsL7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kq7EWSlwgXAe9mxZ2UBFLCEA0gtHiZ1l8VNDGGGS28dxm1iBVfVKyYzcJgRIjgB0+osJjJcbeSwKdCeXYhJqVYgpaecFkGul30jHn24B2tYrKIrQBT8M4rRgzg8+tKaTJuMWBLi6QypOr+3FRgosQeS7Yn1pz/QeZWUsmQzbBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnxfsNb3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e549be93d5eso2468673276.1;
        Fri, 14 Feb 2025 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739549069; x=1740153869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg65XI36kch2lKh7M7ZeZJ4/dXm/KQiHYNWC0zJbbwg=;
        b=KnxfsNb3gLClVUg9bqPT+hLbzwqwHL/zaR2HAZujVJqPpTSGNZRJny21UsbhHtFGEM
         wpOgrV8qsw3WTvM3yP70aEdpfAOwGS6Tdx3rrhSwrHsAlpJIuBXlhb8mQLH6FOie/DDa
         zKi6CZtapVDNn38V3hrVlzfbuMunqE8XmTlGjP59AjazU2uK2RLlqFGr6jk1cLeRPtv9
         Unzbl/NxIaJ8njotjDkCJ6K6WAX6vEP+Ed0a4oAFaXmKdne+ylIkLeAwjSVUbtxXVMx6
         2HBOEDwihTsu5myM70AlzPXOZWtlT7Sqrpei/xXRfftizkhENygCKrbvHQrl7MUWiV9K
         BFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739549069; x=1740153869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg65XI36kch2lKh7M7ZeZJ4/dXm/KQiHYNWC0zJbbwg=;
        b=wZ1axPYshR3ZPxVdfI6S0s3ttjLrlGDiHaR4Z9xiayJmhIwSe/HUOBvNYYFgXZx3AC
         Tkb0t3r2AGHtKJ1YM9csDVUq+8uFiDYDQuGRXWr64ONLPUoFh35H2uV8/iHtTNUmSotd
         tWxFNpiCe0hDt1oZVwzE2DlsgAP06zELK7YL6qxk8/RLW0qbpmYSy0mv1YFguXN1kTMz
         7cjf66VYqyukiTzvzyEcGFrnx9R1D3L9pkhnnhVktMj59eWDbykeVGWFv+FZZRHC4zyX
         +YjbaS3y2l9OIkeaeXytXnuU7QckIFTQT1oUYTpP/ctTa6hExYZoT6iXUnuTBmOQuPaD
         0y1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKL3HuJxXOWtYXYIotXKwccvIVTNOaU3f2Ex5SqGHefnxY1Jum3+XoOUDFpmNEIEqdw7k=@vger.kernel.org, AJvYcCUljlmIhsySALP/O1IYKFDIcIlyTRGPAiyeSoi16cQXdIS0xgYpHPDJwv9v+UZIXuY7vYc3hB350M8xxgQc@vger.kernel.org
X-Gm-Message-State: AOJu0YxOLQt6xBE9JscrzsJbURBPpMSJ8zz1D5oCUZS6+vj+bIPbtxE9
	jmUllbhINCRu6MTurTMrJZz6XMz9pkUx204yRdp2wxemM2B+aojg
X-Gm-Gg: ASbGncvHAd6+y9Z0uou88zt+ukUHp4nfzsgXun+UWAxlVgqm8x/NcxBFl2x0MMFoEUq
	OvPq69XzJXXYekHgZjUm7Dgx/mlZtIabISAuWzQ0LOpQfExn0j5HpInx95F4JG40QChUJSKvz2l
	mwQgur6sQPlTatQX3AOfHwNvC4xyxh1ZnT+6Hyp+K04ap+M/1CFya2G7ZmdXiT3H4ZBf6lO8E74
	Ls1en3lXr0ZmZdGhU4qP/VIYtQCwwYQIgUrfQoQcwMd1X76Ih6J4pLORC/sCZfhlBQWYkRjPCFx
	AvL0fG1T1EyMjcrDdBACRpewLzcVyn6u0XySnQwmpzmU77QtTAA=
X-Google-Smtp-Source: AGHT+IEWTnBUObZ6GvHUjh4EkZcsg8NKWXrSgXJJN83DtepcFqo4+s4XqmFyx30JrAF6ZlzyLuDa7A==
X-Received: by 2002:a05:6902:2304:b0:e57:d3c8:554b with SMTP id 3f1490d57ef6-e5da815c9a7mr7031668276.22.1739549068704;
        Fri, 14 Feb 2025 08:04:28 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dade8c815sm1084946276.10.2025.02.14.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:04:28 -0800 (PST)
Date: Fri, 14 Feb 2025 11:04:27 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/numa: Introduce nearest_node_nodemask()
Message-ID: <Z69pi2KDLB5eZ29A@thinkpad>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-3-arighi@nvidia.com>
 <Z64WTLPaSxixbE2q@thinkpad>
 <Z64brsSMAR7cLPUU@gpd3>
 <Z64oDlh9vzvRYziL@thinkpad>
 <Z68E_ar8l7vNOxgh@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z68E_ar8l7vNOxgh@gpd3>

On Fri, Feb 14, 2025 at 09:55:25AM +0100, Andrea Righi wrote:
> Hi Yury,
> 
> On Thu, Feb 13, 2025 at 12:12:46PM -0500, Yury Norov wrote:
> ...
> > > > >  include/linux/numa.h |  7 +++++++
> > > > >  mm/mempolicy.c       | 32 ++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 39 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > > > > index 31d8bf8a951a7..e6baaf6051bcf 100644
> > > > > --- a/include/linux/numa.h
> > > > > +++ b/include/linux/numa.h
> > > > > @@ -31,6 +31,8 @@ void __init alloc_offline_node_data(int nid);
> > > > >  /* Generic implementation available */
> > > > >  int numa_nearest_node(int node, unsigned int state);
> > > > >  
> > > > > +int nearest_node_nodemask(int node, nodemask_t *mask);
> > > > > +
> > > > 
> > > > See how you use it. It looks a bit inconsistent to the other functions:
> > > > 
> > > >   #define for_each_node_numadist(node, unvisited)                                \
> > > >          for (int start = (node),                                                \
> > > >               node = nearest_node_nodemask((start), &(unvisited));               \
> > > >               node < MAX_NUMNODES;                                               \
> > > >               node_clear(node, (unvisited)),                                     \
> > > >               node = nearest_node_nodemask((start), &(unvisited)))
> > > >   
> > > > 
> > > > I would suggest to make it aligned with the rest of the API:
> > > > 
> > > >   #define node_clear(node, dst) __node_clear((node), &(dst))
> > > >   static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
> > > >   {
> > > >           clear_bit(node, dstp->bits);
> > > >   }
> > > 
> > > Sorry Yury, can you elaborate more on this? What do you mean with
> > > inconsistent, is it the volatile nodemask_t *?
> > 
> > What I mean is:
> >   #define nearest_node_nodemask(start, srcp)
> >                 __nearest_node_nodemask((start), &(srcp))
> >   int __nearest_node_nodemask(int node, nodemask_t *mask);
> 
> This all makes sense assuming that nearest_node_nodemask() is placed in
> include/linux/nodemask.h and is considered as a nodemask API, but I thought
> we determined to place it in include/linux/numa.h, since it seems more of a
> NUMA API, similar to numa_nearest_node(), so under this assumption I was
> planning to follow the same style of numa_nearest_node().
> 
> Or do you think it should go in linux/nodemask.h and follow the style of
> the other nodemask APIs?

Ok, I see. I have no strong opinion. I like to have the API looking
consistent, but I also like to have all functions of the same family
together. If we move nearest_node_nodemask to linux/nodemask.h, it
will help with consistency, but will separate it from the sibling
numa_nearest_node().

So, at your discretion. If you don't want to change anything - I'm OK
with that.

This is anyways the very final nits, and I feel like the series now is
in a good shape, almost ready to be merged.

Thanks,
Yury

