Return-Path: <bpf+bounces-67603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5045B46363
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F38A0756C
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5D129B233;
	Fri,  5 Sep 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S52JWWkh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E928D8E8
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099705; cv=none; b=qo/X6c34psPlTvr0aPvAVzwFHK2GgilLsYjRXpmm3gvZp9oQSagP/Yd/yfEdeMJQiFPI/HXU8hVUuBzaDh6556lREloDxzQ5ZVO9sZX09hZkNAZvmv+KozyN/F/kPgAcadrarwVuh0ux8Dfr6Qgcbcy85nnBMJkUj2EBuShPqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099705; c=relaxed/simple;
	bh=PEd2SGPcY5MuXl5iNA9YZHFnRjmTM2Mok4E92pBi08M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlL5nJQtpbI6N2h9U5YnHsWovQKqoW3JUInULyGgr6iOCdO2P3Lpmp4w64DXoFBgwBO3nTupQxUKlr5Nal1LCDxmwuR/fdCox+e22kgQPLVVs8fhDklzIMs1C68Zg3K2p8YfKuMDIzVoTsUVnYTbRwRoAJlLEa6+ObipLecpV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S52JWWkh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b2337d1bfso32705ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757099703; x=1757704503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+kpXVupuNFcf3FddTJg7lxWfMT+iAwMf9hSE3P7sk8=;
        b=S52JWWkhKoEh2xauAp/kuy43FatTrrgSiV3jfkBjT46AbzIJXWzbd1LC3C9ByIXyQd
         JbXyBo/NlMhcBd1FN9UJezMnqvqoKHjMX5LFTpXKFiRKcPkqPVLCIuTk7u70kWUzojtR
         MDkM8UnmUKxw1EGjTVfda2gHYwSK/oMUXxASThHGgnBttgCV6Dqi54h6kF46Pe/huEWt
         OXj2VD0jf+YSmyvVUhXDUv7v4WVJ0FKPCTY1b1cAcHY5kL+84fg2xHjChjnw9FdLF9uA
         F890+mCYyV36AMAT5cUbqXikhg25bhYPOG04g9lH++X11rL+3C5SuvmN4BkoUvsfYIKw
         WiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099703; x=1757704503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+kpXVupuNFcf3FddTJg7lxWfMT+iAwMf9hSE3P7sk8=;
        b=r2T5WcbFB+k9UXTJVQM1/0F31nDX45iZEMQgPZeRihWaeyNc7E7mQetDxpsn0BNAzx
         6Q+pI+0YpNWoYYg1UxtxOFMTim2pS18EhCb4uYnDCbc+joMG7c1uFgE3Jqu2Tzv180Gz
         4ObI/ZCyUtFjfBNmn4ucKrDzNcUBnmxtmZDn2+DE6nMpdmABzLRSfZqNWGRqZvfpOvAZ
         PMMqAI26zccvvSzVGPeHHTVLKFmlFLV7E6r1Zw89f+kfuesBFxgxuZXRWfSfvnLiS8yt
         ykMDrWWu1V8NKYrEvhhQIw9Z/1ebhc842ifuaJ9cxO+SJY/tlufSs7crHAMsuzxr2YC1
         +F0w==
X-Forwarded-Encrypted: i=1; AJvYcCUt0iVdH6HL0Ah/THhBYL2onO8VjTB0Gi856fSMNxo9XG8JkwpY8aMhH3No2BoiXZtr3Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPscaMm+620ewxE5TZzKoRswIOOH4UUbBk+Wq3KTNH7ZF3wKxR
	X6QfUQpnhemQLbS0nbTaysCLr0kW6YSTchyy/CZwFpPrCEfE1/rmKyop5xDV/WZmEA==
X-Gm-Gg: ASbGncslYkUCz6d+y6T82MmOdjiFdnwFV0aRYVAXi5C5prju3SI/Qv2X+2ECOGgDMOg
	QPukyqmDmGPsr5Uj0Fu65Zn/wrR0zCxJxiIs+mAsQkcPqr5t+uicPvV+x19iXjIBbSL0jMyiEy2
	f7qlbZT7sLfqCKAEz73h3/IQgUoYiE6cBFqus425ozHbmVZMUBmr4TQLnxlSMgWrogLukOq5HBw
	STk9gZbOTR9A/OTUwCgt64eyV9CR1vi4WvRcTnGgdEHbt/zNs4hzfvolcQK/rkoM523jg1qm/oq
	kizVNiscty7H+uAAC50btGi//nFRZunwUNxfOyRzOFcb1goTYAyHykXLu4UauG50xp/ezt0YSlO
	MM2fVlLaIVEnAZvCrkv8xi663/lRFzQFFsUZP5tO8wIx/Ws8KgT8uNbInvfWdhF55u86uZ13D94
	sUew==
X-Google-Smtp-Source: AGHT+IGrTZAo1Pwzq4wGeEHaAM4ResrlO4dBNEf3yV/+ZqHKlvh6siKtNSeJxQFtJyxYZtMnaM2DbA==
X-Received: by 2002:a17:902:f682:b0:24b:131c:48b4 with SMTP id d9443c01a7336-2511e4303c0mr369745ad.5.1757099702858;
        Fri, 05 Sep 2025 12:15:02 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a090c77sm22449850b3a.0.2025.09.05.12.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:15:02 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:14:57 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH bpf] bpf/helpers: Skip memcg accounting in
 __bpf_async_init()
Message-ID: <aLs2sV72B98i3i1Q@google.com>
References: <20250905061919.439648-1-yepeilin@google.com>
 <CAADnVQKAd-jubdQ9ja=xhTqahs+2bk2a+8VUTj1bnLpueow0Lg@mail.gmail.com>
 <qwrl5ivlaou2qqbrj4wh2vi4uqmeny2zyfidkjizkyyzta3uo3@z6bjemb7om6y>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qwrl5ivlaou2qqbrj4wh2vi4uqmeny2zyfidkjizkyyzta3uo3@z6bjemb7om6y>

On Fri, Sep 05, 2025 at 10:31:07AM -0700, Shakeel Butt wrote:
> On Fri, Sep 05, 2025 at 08:18:25AM -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 4, 2025 at 11:20 PM Peilin Ye <yepeilin@google.com> wrote:
> > > As pointed out by Kumar, we can use bpf_mem_alloc() and friends for
> > > bpf_hrtimer and bpf_work, to skip memcg accounting.
> > 
> > This is a short term workaround that we shouldn't take.
> > Long term bpf_mem_alloc() will use kmalloc_nolock() and
> > memcg accounting that was already made to work from any context
> > except that the path of memcg_memory_event() wasn't converted.
> > 
> > Shakeel,
> > 
> > Any suggestions how memcg_memory_event()->cgroup_file_notify()
> > can be fixed?
> > Can we just trylock and skip the event?
> 
> Will !gfpflags_allow_spinning(gfp_mask) be able to detect such call
> chains? If yes, then we can change memcg_memory_event() to skip calls to
> cgroup_file_notify() if spinning is not allowed.

I tried the below diff, but unfortunately __bpf_async_init() calls
bpf_map_kmalloc_node() with GFP_ATOMIC, so gfpflags_allow_spinning()
would return true.  I'll try the trylock-and-skip approach.

Thanks,
Peilin Ye

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2350,11 +2350,12 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
        if (unlikely(task_in_memcg_oom(current)))
                goto nomem;
 
-       if (!gfpflags_allow_blocking(gfp_mask))
+       if (!gfpflags_allow_blocking(gfp_mask)) {
                goto nomem;
-
-       memcg_memory_event(mem_over_limit, MEMCG_MAX);
-       raised_max_event = true;
+       } else if (gfpflags_allow_spinning(gfp_mask)) {
+               memcg_memory_event(mem_over_limit, MEMCG_MAX);
+               raised_max_event = true;
+       }
 
        psi_memstall_enter(&pflags);
        nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
@@ -2419,7 +2420,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
         * If the allocation has to be enforced, don't forget to raise
         * a MEMCG_MAX event.
         */
-       if (!raised_max_event)
+       if (!raised_max_event && gfpflags_allow_spinning(gfp_mask))
                memcg_memory_event(mem_over_limit, MEMCG_MAX);
 
        /*


