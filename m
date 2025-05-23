Return-Path: <bpf+bounces-58823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB117AC1F0D
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EC01BC71CF
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB772236F4;
	Fri, 23 May 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N62MAUSW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7601DB366
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990724; cv=none; b=mnQ9ApSsoFGAMYpbZeIYHmhN8lnvAdNoaEp//VVP4W4MWlzFZTKhpYzxLO2lfq6pZEbFMCdF7sy4LchYIs94IYVtHxhSC9jzF8mbH9c3VmQ7uDMSxz02MN1qLyCVdLR81mC3mkBaYzUiZtyGtxxsoY9Yf40ubbcDcC6VI2K+9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990724; c=relaxed/simple;
	bh=zDRzq9Tfty91GtEb71CtKU6V6XsJ8Gw0d9DOAy5jhc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R7VWft106RPEHGgIRtDy7QiBkjXt/+MBYRGXubNhASerCwjeRUA1nAFLvbV46pqNOZ36n+IAfL62N/nmdXN2Xt/St8FwR3rYb6TvlIHhveWPdaIJwoAn/XH2DHQ3/2aIiBpUUH8jx7UFMAcwyVqpxVcT59fSB21OW+VwO9EWp9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N62MAUSW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747990721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6J/RUYS6OBOPvuZyXgo5WgF2pNpessZJIoWwbAcSf0A=;
	b=N62MAUSWPqMvB9zMaUDQUYlVbYDGBrEmdZc2fcaWsEhRSAPj0XjfRdLFMPFIEHQvoXyz5n
	OxDDHRTJDRqKaDM2Ax/cQeMjhGlHe7+N74gKmcDVwH3ontyxEotFaycuXqPXem9RUFZKPx
	xuGQNo0GdfCyLkqHpp/B1HFkA3UvS2k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-PIK8VNuWOYGnBhXrueVeRQ-1; Fri, 23 May 2025 04:58:39 -0400
X-MC-Unique: PIK8VNuWOYGnBhXrueVeRQ-1
X-Mimecast-MFC-AGG-ID: PIK8VNuWOYGnBhXrueVeRQ_1747990717
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5510e2a9d79so3201350e87.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 01:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747990717; x=1748595517;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J/RUYS6OBOPvuZyXgo5WgF2pNpessZJIoWwbAcSf0A=;
        b=u/RGaHCuQMh32cOYEHIe0AtcJHtu+i1qhcyoFzjk4ETMz7UM4SirCRzrgV1Clbcw/Q
         0K6hyMj55OlP8iV57qPnXg53py2dpdzWNYc1darAYcqEdsvNIl0cGaEhsbNkRFeO1MNV
         dHWNnnBeewRKgSfDFwDWNF/NS41QJngVzgwLdEYxmLoh9m1dVH03iNoTPB5+JnJ9UZSs
         TERyMhNQ13lSF8Ncp4kdGaXNnZY/Kq8r2v6AJ3hd65XtF4eEcUqgPDZZhd00Rl8S+Q8U
         A/2jftTqqJQQ2rttel+59CQ4FtCu+9wFWPgF7OjrRVULRnFB2IQgdsUC855lKG12dXB9
         cuTg==
X-Forwarded-Encrypted: i=1; AJvYcCUWi8hCfXUdnAj0+MmuAxCsOYz3vMJLuZ5nw3VFTkFuDglwhgXfOoEwUK9oEl4MFlUBtfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyPfaB274Z0Ib/ah1d8HqTTzdvPhRC2CIfF9KUAxDn2jR0F45
	eLL5lBpTBiBb4EGwd9ikm5z7TsED3XHm2zFXrEE4AKg3VQ+2z6hMHlsvMZX7urPTUDbLW6jyB1X
	fDqFADki0rJGb8DxgVwQCtUE7IvT7jPvInY4a4cZf7kTZItO7IuMQ2Q==
X-Gm-Gg: ASbGncvd5gU9FDgV+1aH8pJTzgX/rysAabrtG9OaQMYFCycH/Y/odcrIo4MbuLSUVkf
	EozslDgfjIJSXfpxfrEJfOhC4WxGhp2XLJTFpWTG+sm2dEMLRqQBPpeqi/51g9Kb1BVzgyDz2Dx
	4XQl4Dx8wmZ1CafhC1L8QfDBvUF//NmNgDWhuK19oXTWDTvCxxK2AmPS0ObHrwHnhFos74bth8u
	XXxx7BagW92jprYussCl/eyI6iUWbXJX0NW+DaWNZt6uAC8hAlwy3IBoaeWfRDph79PjyVH8XX9
	JvsjqNu9FnlemgH4Kzwfav977VQG/7UvZGo3
X-Received: by 2002:a05:6512:3083:b0:552:31c:d27f with SMTP id 2adb3069b0e04-55216e18aa5mr550252e87.6.1747990717429;
        Fri, 23 May 2025 01:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGupqC+46X0tt6Ygg6tbBTVVOo7BQlw5aLij8Bq0jPcx2TjqKILidIf2WS35eedcHMuDdsdg==
X-Received: by 2002:a05:6512:3083:b0:552:31c:d27f with SMTP id 2adb3069b0e04-55216e18aa5mr550242e87.6.1747990716968;
        Fri, 23 May 2025 01:58:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e702e03dsm3786008e87.195.2025.05.23.01.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 01:58:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D7C101AA3B8A; Fri, 23 May 2025 10:58:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
In-Reply-To: <20250523032609.16334-13-byungchul@sk.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 23 May 2025 10:58:33 +0200
Message-ID: <87ecwfn1om.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> To simplify struct page, the effort to seperate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> To achieve that, all the code should avoid accessing page pool members
> of struct page directly, but use safe APIs for the purpose.
>
> Use netmem_is_pp() instead of directly accessing page->pp_magic in
> page_pool_page_is_pp().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm.h   | 5 +----
>  net/core/page_pool.c | 5 +++++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8dc012e84033..3f7c80fb73ce 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>  
>  #ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> -}
> +bool page_pool_page_is_pp(struct page *page);

Here you're turning an inline function into a function call, which has
performance implications. Please try to avoid that.

-Toke


