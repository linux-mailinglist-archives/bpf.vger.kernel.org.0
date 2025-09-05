Return-Path: <bpf+bounces-67611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE828B464F0
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4847BD008
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296E2D8781;
	Fri,  5 Sep 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSYl2b4t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81142E36F6
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105334; cv=none; b=C45wQ64gqw9fvs1e6t69ngzoUzqbdS+UdLPFlq2q98V0pOzPDYoxlsngtnIFVsEQQuIs0izOcKKofcF5izCraxowxhz8v5Z/H4UpTZocT8WjMu4k8LyNjWHClvQGdzS5zbtGAQl65Sj+wHdzvi86Qaj8W03DqWIb6qB/52NN9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105334; c=relaxed/simple;
	bh=Lddiy/CUg8ag5U9qRcSe06M8YgtvRJvYOtgl2OT0pcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVfb3/GSaGbNjOeDi7pCI0U45LAN38g8Xc4TGecfLZPzKqTwvnqBC+6D9xMY/XZGzvOjw0hXzx4POSsTfwllVkb8WuznOecaLDMpYEmnTzgErMaomQhLTv+4tXCMlbQNpnUBDutEpFnO4H/6j24dE9vZC3tEWbhRpyhWiAjq7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSYl2b4t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24cca557085so17295ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757105332; x=1757710132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GiODW3jiNFo5GcWlFYzIpqNrxA7Q2Lf72MRDCRU/DQ=;
        b=RSYl2b4tliMhv335SHVfOaEmGWxePnqCHaoRrniMsbveAJG9TioX7pB+XDbGOnduHG
         64l1myOpVNV0wriOAlmTGsaIq9sfVutpOSLY/zybUt97T7hZH83oZhsnsiHfL5AQkOr4
         6olDxSxG//JRPglwmw/juWEOfdA6DqQNLk/oXffKWh9BkAGKgM/3gRtu2czamRKZAF7R
         8zYu+fhSMaEAdEI4VpnMuwN1b+bbeO3AfRliRiXXM5I69rrRRFetkiXAlmuIhZFUUKDj
         5npOySA6E6bza7dk5ChUq8xKaSlCOmAQ1YG037feuJ/aNKgscuOlHtIT8TiUhuLHyXjG
         li7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757105332; x=1757710132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GiODW3jiNFo5GcWlFYzIpqNrxA7Q2Lf72MRDCRU/DQ=;
        b=UgboKeYd+Q+NmnMF7l2mcfDYU7o0CJOtQNBnI4pHG0+UeAcUgPYNAWdPaHQPyqXUpi
         D6XwCtq+azM5JsJP0cJRlrD/pwc8qop9CXH6c+VjRBY1FW/9103zRBQgEs1MUgOwVx22
         XTqnV5Bsrlbm6yb3ROoO6w+NwDhheYoXCjMNAfgWOOhpsQ1ubQw+1+BMK6x5wFS4atHO
         dJzD4C9qGUHkheGOXiBZuHzolZlbwYfi9MrLR/Jd9kh33PPgqQfmc0DUyaZyHyYzgSqg
         J8cOuFL2VYzIs+N8MaMW9UjaZWdEtsy8VlV0gWLIHbHmatsUgmZVHySyzGbbzPPf+QZa
         ZNkg==
X-Forwarded-Encrypted: i=1; AJvYcCXAeP1/qDfji2J3cSUwNCTMyomvADyFR160s8x8LQvTQKK0e0XVAQ7qpslcy6DjiTWZcW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfw6lYxuM5kUrWw10ZNprofAAt/ss6qTZ24Y7+2oZs02MXfNYq
	IbG71dTgSOsnzfqF4bfAuhnKGEERSLGSX8AhzBpxOw4OxM8ZuAImyTOHEMeChXtVdQ==
X-Gm-Gg: ASbGncuEH8GkJPtIhDNKODNYPpAkUdDIPIDwIhQWZASiCAyLc+iDgZS+ewuQgXyM32O
	+yEOaFHuNYBg3nW6wbOq4sCJj/UcV9TUfj+KCQqtOlQiRcWErcWmKO7w5s8DD6p2xWr3wQCX3M2
	NPU8Gz2kgre06txo4ML9X5Jb7SF8yGSkbopq4K6PDeYam/HRNq+cz2XjDG0wENLM9sQwXX1HL31
	wciH7Sz59nqnWJTe7/SVUCWvS8868yuOU6NhzdqKKL82dGVRgPl6yO3xkUNTsaFmuX/MNMECN1u
	HPW1XYE2i4uPGrkA1PundeGS6aTBtUBQZHcywTHDz+Me7j/eVHZyrGMpH1WFeDiof0E8+jc3HPs
	z9Cq1kNL5X94nD9yurZxW4zogT8XvnpI/HVGz1wcH45fgaddNJXUM3e4/DzUHz2MsbFY=
X-Google-Smtp-Source: AGHT+IGxaodK2oxo1/T0jE66aVjXGi/uDMun6FTCnFGDt00e/yHDWzq7NKgwd2BLevagOtIH+S35aA==
X-Received: by 2002:a17:902:e850:b0:24b:131c:48b4 with SMTP id d9443c01a7336-2517446fa94mr26065ad.5.1757105331740;
        Fri, 05 Sep 2025 13:48:51 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced566602sm31649925ad.126.2025.09.05.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:48:51 -0700 (PDT)
Date: Fri, 5 Sep 2025 20:48:46 +0000
From: Peilin Ye <yepeilin@google.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <aLtMrlSDP7M5GZ27@google.com>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905201606.66198-1-shakeel.butt@linux.dev>

On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> Generally memcg charging is allowed from all the contexts including NMI
> where even spinning on spinlock can cause locking issues. However one
> call chain was missed during the addition of memcg charging from any
> context support. That is try_charge_memcg() -> memcg_memory_event() ->
> cgroup_file_notify().
> 
> The possible function call tree under cgroup_file_notify() can acquire
> many different spin locks in spinning mode. Some of them are
> cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> just skip cgroup_file_notify() from memcg charging if the context does
> not allow spinning.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Tested-by: Peilin Ye <yepeilin@google.com>

The repro described in [1] no longer triggers locking issues after
applying this patch and making __bpf_async_init() use __GFP_HIGH
instead of GFP_ATOMIC:

--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1275,7 +1275,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
        }

        /* allocate hrtimer via map_kmalloc to use memcg accounting */
-       cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
+       cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
        if (!cb) {
                ret = -ENOMEM;
                goto out;

[1] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/#t

Thanks,
Peilin Ye


