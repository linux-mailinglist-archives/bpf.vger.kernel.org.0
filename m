Return-Path: <bpf+bounces-15737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1B7F591B
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 08:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DB52817FD
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 07:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1616424;
	Thu, 23 Nov 2023 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6gEeW/I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF5CD42
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 23:21:28 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cd573c2cccso1349317b3.1
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 23:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700724088; x=1701328888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8JBfcJ8qyLmIM0+mXWtuL3nULYBHmRUxetXZ1VMVrE=;
        b=k6gEeW/I7K1+U+pkAV/RxMcpfNO+Fi8SyIv4pGYH3H+bnZeBtkFIWt1XFZQZNSBCPe
         vjNgiLxHWyssJx+3SAtKuhfrSqZ8nQ163CMiSjU0jPo5d3ZdHwXefYcqO64tpf2N9PBU
         6iLzdWcW0lAebJ9OIQ3Q3L0BtiIiLYI2tBc6fCbQ6Bm9T+4L6YbjaCcKaZePMzh3irCw
         7NX231zmLmMXuO5Sem6pZW1xZFUE22j1J3wxUs554LxPmYQaWpRlrhwvSg1mNaHTwIlp
         tTUxwRg3MAE3Iu00d0xxtXrZAhEINnttcJ9pbjyDIjjkfRKJWCLCrSXW+gqUkIdNrRW/
         Td2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700724088; x=1701328888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8JBfcJ8qyLmIM0+mXWtuL3nULYBHmRUxetXZ1VMVrE=;
        b=DRI1LxHMkSDX9nbhetJ9sJ5LLliCMns6HoSlnRmZO59+CC++DmgzI6X1kgfnTEHwvS
         uFK2MY6ZZBXjPlZXX37EBRu7F/yzv3wwSIIVDy1zAUsm/rnoDPN9PkRLY2b9pDau4mkz
         60WQSMk48f1jKkhrmggJaMck2OAZaEdBUJ4g8fs6WtdU07Kq0K1T6HuMRNJmtx9nvMYP
         ebrxJ/nu5AqXJmoLs38S+FBb7pd0d2uk1uZYP5b6GgUqB0FYYr9dLbWgCKAI/4U1J6jx
         shDUaE6EAd52d7yzzantEB3LtbrimsLWiZ3dLNg1saQlwdCdTBMoBSwhxxGgrI5AzGik
         fUnQ==
X-Gm-Message-State: AOJu0Yzi7wP5slYS/zQISAHDI1QLKZ4I/EXppTOAe7Vn88iCg1DTEZsT
	OgNGmy+lwvcIZQTEuaF0sOL+n4kGCEh/CA==
X-Google-Smtp-Source: AGHT+IFYdCsJQiQuLcEuCdROYl30YmhIrJJ8nUSo92pShPtyIO5a4M+pfwcgYC77/VUh4eoadKQB9NuNUVtgUQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:4091:b0:5cc:a957:2557 with SMTP
 id gb17-20020a05690c409100b005cca9572557mr62016ywb.0.1700724088168; Wed, 22
 Nov 2023 23:21:28 -0800 (PST)
Date: Thu, 23 Nov 2023 07:21:26 +0000
In-Reply-To: <20231122100156.6568-2-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231122100156.6568-1-ddrokosov@salutedevices.com> <20231122100156.6568-2-ddrokosov@salutedevices.com>
Message-ID: <20231123072126.jpukmc6rqmzckdw2@google.com>
Subject: Re: [PATCH v2 1/2] mm: memcg: print out cgroup name in the memcg tracepoints
From: Shakeel Butt <shakeelb@google.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, kernel@sberdevices.ru, rockosov@gmail.com, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 22, 2023 at 01:01:55PM +0300, Dmitry Rokosov wrote:
> Sometimes it is necessary to understand in which memcg tracepoint event
> occurred. The function cgroup_name() is a useful tool for this purpose.
> To integrate cgroup_name() into the existing memcg tracepoints, this
> patch introduces a new tracepoint template for the begin() and end()
> events, utilizing static __array() to store the cgroup name.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  include/trace/events/vmscan.h | 77 +++++++++++++++++++++++++++++------
>  mm/vmscan.c                   | 10 ++---
>  2 files changed, 70 insertions(+), 17 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index d2123dd960d5..9b49cd120ae9 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -141,19 +141,47 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_b
>  );
>  
>  #ifdef CONFIG_MEMCG
> -DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
>  
> -	TP_PROTO(int order, gfp_t gfp_flags),
> +DECLARE_EVENT_CLASS(mm_vmscan_memcg_reclaim_begin_template,
>  
> -	TP_ARGS(order, gfp_flags)
> +	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
> +
> +	TP_ARGS(order, gfp_flags, memcg),
> +
> +	TP_STRUCT__entry(
> +		__field(int, order)
> +		__field(unsigned long, gfp_flags)
> +		__array(char, name, NAME_MAX + 1)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->order = order;
> +		__entry->gfp_flags = (__force unsigned long)gfp_flags;
> +		cgroup_name(memcg->css.cgroup,
> +			__entry->name,
> +			sizeof(__entry->name));

Any reason not to use cgroup_ino? cgroup_name may conflict and be
ambiguous.

