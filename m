Return-Path: <bpf+bounces-71385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5482BF0533
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467F518953E0
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CB82F5306;
	Mon, 20 Oct 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZD5z2o6U"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431D2ED167
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954075; cv=none; b=jgqsnhmCiEjfFC27FYu/nF0+4EPX179G7XwPqeR4+Wh+mTurENmKnxhfZI47g4ytozDVYzZHzpRNcLQQJSgAcWZsR7S+UejcN2vPeMYG6hHq+3VQyDfwePq1YZfbkLnUPzeFssgQGhhkm3yyRDT1IWweNbhtiw59Z9H+A9DaZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954075; c=relaxed/simple;
	bh=EDh2hY7KcsoLCVNbqCrydEKfepj9ENE7y3LCCo74QDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahyYnnoDEDv1/2mnMng5KmQQES6Ck9sreACGEHYDBWOdMbiqNfBqmLi6v0cu2baIASEC1HOGdvewBu1ncuwFoCjm+1/ldE2i/YCVMRhadmgVH/CcbxK39mHwY8mfxzD4OlSTLljHALOKNGDapCG49fwqrfJWCkSWvs0dI9cQiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZD5z2o6U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760954073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOvPujFryMZ7+AgeMw1kh2ZO5Xa2du80EwXqsZUS+1A=;
	b=ZD5z2o6UtjtJmVOkMKRPwAnZFTAWSglCX8QHsHYo8MIgvIEUIcWzYX47STLcOJG9ornSYp
	bcX2QfP68C0thUPUf6A0OQyDN40Osnr59ZLj3vawijvGvZiQ/fO+JaTDP652FmGJb/uVgm
	S0ih44x1CaSNJ+WU2KKUE+KzlxZcB0w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-nZ_t3kALPHKY98iqwGb-Tw-1; Mon, 20 Oct 2025 05:54:31 -0400
X-MC-Unique: nZ_t3kALPHKY98iqwGb-Tw-1
X-Mimecast-MFC-AGG-ID: nZ_t3kALPHKY98iqwGb-Tw_1760954070
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so22351625e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954070; x=1761558870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOvPujFryMZ7+AgeMw1kh2ZO5Xa2du80EwXqsZUS+1A=;
        b=JTDSUOiTfCm3+2flas/cwkp/Zcy9avPg2g4Smv8gbte66i6U2e59FxXhNVhfj4rIus
         8P3YVs0+2j9k4tRPIjbKF/p/jwtXkmnP6I+VlEc5X9FMtDso92pMwCShcImBkpseCrJQ
         hv2kTBxq1QlSv8t1bvssgSSZXbtjuOJNR6MeF9DPTWK84/f7mGPzRTyM/Ur1ev3ntNJW
         N0ZweNJoFq10peFsnoxvK4tL5pREFhQzNMAKJ5Lrhr/iIrn3pCFtK3EK+wbPEod069pN
         990/dluaook1J85+zhS14+YSo7WyA+3g1Vo8f/q7RvLpeGxhsTkv80khBj1Kf+SDoYg8
         0Wag==
X-Forwarded-Encrypted: i=1; AJvYcCWMtnEgCfXMliq9KECs87D/pkS4w7fHVhBmh0nI3bvbfPK7dIgzUBWTVxZSJDKd12hyLQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7OC9dV1xcM0f5IXecMmGKmoPNEHoWY4TMMfY/N3M1wa/ptDr
	Fw0nviwNMh1dyoI9THnc99hHJXG7fBGUNsL5wyX6sL2t9besLZA1g9ebiwmk0bTanlOW9F9wt73
	bRsIuqRELEX/LChmp259Mt6s9EnfoCiSXsPQFR4RxxoHDxrYrW6tBvg==
X-Gm-Gg: ASbGncuxz8TAyDX9q4zOyk0gC+CQu+NdL9MpzjYBVHhsqhBW9fXTHn4obMqFA/BP8xM
	z6iqLLvDfr9jttzXHbVCGggvBTiAz5aUKrbEeg50iYKMV67a+T9BTY4yfy/D11Q4O3ujdNSmEVS
	8RninZqkf60EERsIcp9VoVV3sUfvCOto+SFLYIxsJrbi7F3a9Lp8uzgLgjpvwohoppx4kXvWa5g
	VH/rii3daSp2OBGc8t9d+0jsAhFV1ZeDegss5/Ty9IPgHhRZc/2+bYZ2zIxE+S3l2hTznu7oHuK
	zBuBCoyiYew0h1b0EcBSCm6YuQkyUGP8pHfvMgRhcVYloOCIlOv7vB2F36hW1AABU0YTi1ekaEn
	cAOZtRL8wm8nJMBPn9hefz9JsGKpT+IU=
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr98205665e9.33.1760954070235;
        Mon, 20 Oct 2025 02:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwQc8jHbyCjws7r+xEl2xJJIVq9zC6q6jCBAIB087YXtxrslD/Tbf+7AnvpKx9nVNS0eYmew==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr98205355e9.33.1760954069891;
        Mon, 20 Oct 2025 02:54:29 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442d9e8sm224260885e9.7.2025.10.20.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:54:29 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:54:27 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] sched: Add a server arg to
 dl_server_update_idle_time()
Message-ID: <aPYG0w4dYZIws9sr@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-6-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Since we are adding more servers, make dl_server_update_idle_time()
> accept a server argument than a specific server.

Nit,                      ^ rather?

> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


