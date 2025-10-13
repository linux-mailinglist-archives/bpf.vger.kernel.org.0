Return-Path: <bpf+bounces-70838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C609BD63EB
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 22:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 305394FBED9
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA430BB9A;
	Mon, 13 Oct 2025 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxSNtELP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857430B517
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388091; cv=none; b=VNzmGhnvJ7M4CJG++OrLj2vWYzTTHkeU0FuW8EavkhFOB7xfzQcS9gXWSc4fmOQTqLCiSEsmm2qw9RuFCLC74TSxlujiHqrcXA5PWJnnmrreEVi74MwGQC01LIMsC1Bu+UaTHa/wtI/U4S8PXFiVO4t7r9UKdOdJftyen72/P2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388091; c=relaxed/simple;
	bh=GsSWfFlXkBsxiUZoCz6mvqXlZhLEzpwSFRwMJKX6ek4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2HWrk1Qdfj5SsI+RdS6b+GoYZL+bOwWUX9KCPcNnci9Bo1gYXVN1V1dw5iyhGk8h9Zb4lhAPk6tP2gOcHGNbPLMuhl1bWdglA+i9nKKLuW9mu1KrAWdCnLQfGAeaTnvzvqQ912xoP5/gLS02ur6p9tArrflbz4hnv2oovsW9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxSNtELP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b48d8deafaeso991300466b.1
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760388088; x=1760992888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCLtlY+GpSdapckAq80Uoda7FwoX2xkIrZqjiQg1jTI=;
        b=UxSNtELP/KctQLvknOMJ1+RLheRIKAsMqeuMzsPGnNHZOkQlhZhuccp7kF1IQ4pBXE
         y5kfnrMAXMCt/nZw9DzPEgvAkoPmxmrjF+O/NQc64D0CahamIUAucqFk+BIJ+i1DAXan
         lz9+mfdjiaMTFtHqWUvhsJW2obb0oB7iAMGYK8luUbrr8F927b0EVY1En53yGR3gxXhJ
         RaDfMGVARLqWxMN5LsuSMkSyVc/xHS9OH1iql0sdq2hegd+015elbsSDOt4w8GebaOpr
         ITWTFtG/UducX4UVpZxOhHDurzf8sy/mcfPAZCc+VaN77UP55zNI0IKCR8roYM8GZ/LT
         wqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388088; x=1760992888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCLtlY+GpSdapckAq80Uoda7FwoX2xkIrZqjiQg1jTI=;
        b=YmFlmpjolzDmWQ4/V/XPMq2P+eUpEg7O3JF65a+c7lcSKuHKWlJ/39IkDi7glJ92fV
         p/MJy7gE3cyx6PsCsJFmxhfZA71zq+Q22qUrN5pEgjYfyrZKqYboDmhv8QeVGB1PIizQ
         2P/L1o/JwL42JNlxkInttKugWC0C7c12WX/Fw9bYd9+hDukYL8TJy/b2+JiZ/cwzo+I7
         HuGS3ISVvfjda6Q3yG+kp1A04Efv4lZmhuYsuFfEFpAMem+JkKXP5K3iSGdu9WNithAD
         pcKCl5/DhxDvrQhUuKU5fBxMQzcLyPVXTr2plV5M11EH0qrj/uVdzISZ811aTo1tfPiC
         AFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJZDFki7P3ay1LzLyy1wiLWmNX48/NikpVmjsNEz63PZtkVXwwHpj1NoJ+4wLG/KArtL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YXVAOVlgnyGL+/lNhOyNpnAebhly7jVWPF3R8jrV6P9U0m/R
	B3WAYr1oi1b839zt3/jH6hNzWnVNYsjh7Cc5bwqvOvNRl2M/t+1Xxajn
X-Gm-Gg: ASbGnctk03RyyG+PtQJlg/iUTFSNs+A9WGEuzyrqyT9E92jQOweQMbODac8pIz2WC7J
	HMI3mPxPqt22DmJhu1OaMT3/ZqVf/f/UpkmrFVHZYzKMsEdVqgUfhQNSiBJlJKRYHGj6d7aq7jn
	FjdwX3X+MIErUJ98Y3g76CdP7X1q3PgRbDBpeV3+1uuXWxVGcSHR8qLygy0VslefhqvuRF74Xzv
	ZCqAgOConrCdOEPS7ZH8+MRVMP4djkeA7i/nEdYE7ARrh8zz+lLVvgiLwJQ5xDC1S5xgoSZYJ+C
	E9aPMljSYSzXlId/W56t5Q4q2ZFb5meWBtMFE60XKSbgglisbBvLhmMVmHyld+SPKc9ZV4jJpob
	5iOYG56qq9N+Y0TTa5dqebSwHigckag==
X-Google-Smtp-Source: AGHT+IFrDpANwGND6n4Bq/nSFTErKeDAVitiuC4/ag/cLsjoNuy/l3zpqrheKMdvIEEFGo6yIOFj0w==
X-Received: by 2002:a17:907:7e88:b0:b3f:b7ca:26ca with SMTP id a640c23a62f3a-b50aaa96b30mr2242003166b.21.1760388087782;
        Mon, 13 Oct 2025 13:41:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12b9dsm1000097266b.45.2025.10.13.13.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:41:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 13 Oct 2025 22:41:19 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next RFC 0/2] Pass external callchain entry to
 get_perf_callchain
Message-ID: <aO1j747N7pkBTBAb@krava>
References: <20251013174721.2681091-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013174721.2681091-1-chen.dylane@linux.dev>

On Tue, Oct 14, 2025 at 01:47:19AM +0800, Tao Chen wrote:
> Background
> ==========
> Alexei noted we should use preempt_disable to protect get_perf_callchain
> in bpf stackmap.
> https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com
> 
> A previous patch was submitted to attempt fixing this issue. And Andrii
> suggested teach get_perf_callchain to let us pass that buffer directly to
> avoid that unnecessary copy.
> https://lore.kernel.org/bpf/20250926153952.1661146-1-chen.dylane@linux.dev
> 
> Proposed Solution
> =================
> Add external perf_callchain_entry parameter for get_perf_callchain to
> allow us to use external buffer from BPF side. The biggest advantage is
> that it can reduce unnecessary copies.
> 
> Todo
> ====
> If the above changes are reasonable, it seems that get_callchain_entry_for_task
> could also use an external perf_callchain_entry.
> 
> But I'm not sure if this modification is appropriate. After all, the
> implementation of get_callchain_entry in the perf subsystem seems much more
> complex than directly using an external buffer.
> 
> Comments and suggestions are always welcome.
> 
> Tao Chen (2):
>   perf: Use extern perf_callchain_entry for get_perf_callchain
>   bpf: Pass external callchain entry to get_perf_callchain

hi,
I can't get this applied on bpf-next/master, what do I miss?

thanks,
jirka


> 
>  include/linux/perf_event.h |  5 +++--
>  kernel/bpf/stackmap.c      | 19 +++++++++++--------
>  kernel/events/callchain.c  | 18 ++++++++++++------
>  kernel/events/core.c       |  2 +-
>  4 files changed, 27 insertions(+), 17 deletions(-)
> 
> -- 
> 2.48.1
> 

