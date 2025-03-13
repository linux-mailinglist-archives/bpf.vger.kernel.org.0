Return-Path: <bpf+bounces-53936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E1A5EE47
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 09:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B2A3BC8AD
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9885C26157E;
	Thu, 13 Mar 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HPMcx3wT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672926156B
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855495; cv=none; b=MR3x4GH4XGNmv1SVDXIrIea8/rvLgXsOv8yaYAn+AprB2Li2cqk54MCk0yJbO7Su0VajTXcunAp43DXFdXiCXNeDAhOKsBPUcKIxjcOiZNyW7Plzy68aoapbQOSpl5TzupY7DH2u1CWGBAE43IadZ1yBI4xqtbjVgNohlYyJ+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855495; c=relaxed/simple;
	bh=SbZwyQXod9h7OYwnG/1aPmp8w8agLpaZM4upf1suQlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM5ZEIo7P0XbA4Di8QbH1grF2uOFwbdCCxiZvdUoz+IyrdLoZJAB6PVGoEpesS9wOmFa3Si5xYKmj2NSbFQdxm8uXgrFQXhve0DnvLgI9kFAAoE1NKbhxcvQi55d6zANvQ7Wc1t6hFVPs3T8Nnomak67RtCzDnG9D0FKf3aoy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HPMcx3wT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so3810765e9.1
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741855490; x=1742460290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8oSuQ5bCsZRMab/7sf0LHNteyynOseZc+tj2NZOxBKI=;
        b=HPMcx3wTbAKZ6qOdbFJBfupm1Xr1jlb0uwRIJx75PMnriZO1lUFd0AYTtZFyE9RW87
         WZVEz2h1wp6sFHm/z4S84H1C8e8ukbJ2cJIN6lLH2se8s1kqsM2N6XB4MxT0sjDWFQm3
         rV2QZuEaxhcAjhiRUccIcgA+YxT3TxWkHpbW8QGZWin/9r+coYjboutG9Ok075627wiC
         skZM/j1BXRmjWfGWLReMH89iPH/beNWlWr+ESE8Fm3vAynBmPiMyBXwgV696IHaGrnxE
         ahvZQqw+fYDqkui3zByUdI+2GIpJAovfUIHv3JN06pjtU/gMvpG07NBM//bue/mrYwFV
         /tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855490; x=1742460290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oSuQ5bCsZRMab/7sf0LHNteyynOseZc+tj2NZOxBKI=;
        b=rrpLMa5FEGbJ10ISLt/DSDznlj2hVik28KFpzqdU+TGfFLR7COIo+A3pNIUtWgJ23t
         S4pFHSCZYAJerCKS2F3iERKaAy1gyuxJol0OXrqCiputk+dmTcwf63kIyhsCoED3iv3c
         L2KnqeCDQOT4OQ15U0WO3k3FkWIvsQmE5CvggQzDFHkr8U6Y5kZlUo+spjfE+2khnD5X
         CwUYWbyy2BG7yoaE7ASTQn4NzpnIPRURNermTVPEmcGzcEFJ2eKZ5BKLcTjDQTWlAzna
         4wajfaRFM9vYfZgfUe8a5VWCSdnIEouYfToXaK3/LJZZtwjsyOPe4WP9SN2cJoBl10Z/
         AfPA==
X-Forwarded-Encrypted: i=1; AJvYcCUIBySVj6RpO4h2ywZyCU7j2KK0+BKUAPSsGHgGY+oacHhjCkQI7tjx2qHoNejUuyL6tEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOoqZ9ciY3wVeCisYl43XF+JBd4lQADgcUbJ5diWQjRcks3Hu
	KnqBxBGQRtd8cM99eaSj2d+8elpNIR824i6Grt4ezPfPzQwqo2DnAKr6pRCFn+g=
X-Gm-Gg: ASbGncv6huslvzfXgGSTTj4mo6WlFqfexXt0r8gy/ujul+AzH6ljzR1Td1yY2TQ8OkQ
	PC8OvQL97pyOdfHVyI2I2/YiTQOmWcj+9klqwfd9l/Y89JznHdVWQPNkc4TjwEO3hxQGPQCKh47
	IVjZ/TQEVHXKcg3ZABTTS1N63Q58+LBlS+tivAvlz84XkRDijbdNZ1zIy/Prr97hnaybyvy4CvD
	V/UOrb42MrCelW0w6GtS9GIX6Nn0ffAwd+Cv9qIEvSww/K+KTjRdO3/jEixJXGsrWZlAlvLgXVV
	7PumOiFdmp94rvUPDG4wk31Phig+fydaFuEOrYZJF72T/u7xnneIkLY/vw==
X-Google-Smtp-Source: AGHT+IF2WBcUxm2qMhuOccsrLef56PO1H1TCxjQU7ShnaGYX0WOxshTc3Iz502MmCBGFMin1Qcj6jQ==
X-Received: by 2002:a05:600c:45c9:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-43d0abdafd5mr40005465e9.6.1741855490618;
        Thu, 13 Mar 2025 01:44:50 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d0a8d1666sm46259995e9.40.2025.03.13.01.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:44:50 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:44:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <Z9KbAZJh5uENfQtn@tiehlicka>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com>
 <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
 <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
 <igjisv7v3o2efey3qkhcrqjchlqvjn54c4dneo2atmown6pweq@jwohzvtldfzf>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <igjisv7v3o2efey3qkhcrqjchlqvjn54c4dneo2atmown6pweq@jwohzvtldfzf>

On Wed 12-03-25 12:06:10, Shakeel Butt wrote:
> On Wed, Mar 12, 2025 at 11:00:20AM +0100, Vlastimil Babka wrote:
> [...]
> > 
> > But if we can achieve the same without such reserved objects, I think it's
> > even better. Performance and maintainability doesn't need to necessarily
> > suffer. Maybe it can even improve in the process. E.g. if we build upon
> > patches 1+4 and swith memcg stock locking to the non-irqsave variant, we
> > should avoid some overhead there (something similar was tried there in the
> > past but reverted when making it RT compatible).
> 
> In hindsight that revert was the bad decision. We accepted so much
> complexity in memcg code for RT without questioning about a real world
> use-case. Are there really RT users who want memcg or are using memcg? I
> can not think of some RT user fine with memcg limits enforcement
> (reclaim and throttling).

I do not think that there is any reasonable RT workload that would use
memcg limits or other memcg features. On the other hand it is not
unusual to have RT and non-RT workloads mixed on the same machine. They
usually use some sort of CPU isolation to prevent from CPU contention
but that doesn't help much if there are other resources they need to
contend for (like shared locks). 

> I am on the path to bypass per-cpu memcg stocks for RT kernels.

That would cause regressions for non-RT tasks running on PREEMPT_RT
kernels, right?

-- 
Michal Hocko
SUSE Labs

