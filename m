Return-Path: <bpf+bounces-67301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C240BB423F0
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B516FB87
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9489921773F;
	Wed,  3 Sep 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Mnb8+Q"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCEA273FE
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910674; cv=none; b=Ob3ekEvGlVhDNIcKArHf7kJuF4BjurG/8uofcCJsp2EYI0sZw5HT1fVsIr80A5tlfoQcuixnhgtp1U+t+b9Nd3HsiBfCZ42tq6Ut9yk+fIw1ctKTK4Pfutmf8+WhfJtrmar0t953Ljt5WsrKbVvDsd7D7YXFTe+rGA28msSIxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910674; c=relaxed/simple;
	bh=K1yuBMDpnPOt4/KeRFVE2CusvjBh1MGwKZHLk7xzD4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNGw4FRFKJDAuD3EKEtkyGVeSgkFMyNaKs80bxYrTtuuQoe9YBSy/hSWcisy4k+1C0oEKIQxICyBHnbCSBIXEYY5XfCdTQtKPRrCs45QfQF+BLKqGo1veEoTglCABId1Kx3LAHofcFp/4Slc6LITi68+krnsdi7Eq7gbCetSvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4Mnb8+Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756910671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJy/79mHdukukK/k7N0QCn2psTcagRNxoMm4TPphiNQ=;
	b=V4Mnb8+QfGMolnwkYgJnEZAdvY1uCo9FDDfds9MB/z+wm5XF7hB4SzhR25NHUS1GwaaeGa
	h/J2yI2EzuP82xw96t4h2resTtJxG3T+lTnUEXKK/Zo9EXKFnNUHjtCWU4kt749tFmjPKM
	gttt0cQkyYlJV1bui/A1uisgWJWtFf8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-amQzkhYUN9yXyEqvaDQYWA-1; Wed, 03 Sep 2025 10:44:30 -0400
X-MC-Unique: amQzkhYUN9yXyEqvaDQYWA-1
X-Mimecast-MFC-AGG-ID: amQzkhYUN9yXyEqvaDQYWA_1756910669
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b8f4c2f7fso125565e9.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 07:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910669; x=1757515469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJy/79mHdukukK/k7N0QCn2psTcagRNxoMm4TPphiNQ=;
        b=RRNu40Nv925ZdwkXx7kjDN0i+q4NvZ7ZABfoKNUhSx6WGGouIMo13XtTsBq8X90hHq
         dfeLJpl3ipmoE7jqTHuEGPQ4QzMlr5vbvr0YlTRD/WraTnQ+p8bj+h1rjPK8SrjdzVlm
         M1yhVN8w431PbtDrNoe4qPAcV3ZYaceDekFhk0r/zuoGtJryTsUwnCqBtgZOHJj3N5Ol
         Um/a+ugWEpWZKVqhVsKBdxMv5msgVWWzAjhq/QFE/HzxVrR9pYVltyNf0EVkj0cxHvjo
         7KrYb+IDNCOPgQP1pVyq6gQe48rP4i/suNtmBprQ7flksATHa6xCVv41j767U1223HNR
         +lIA==
X-Forwarded-Encrypted: i=1; AJvYcCUk+7BwWyVircEsHwOk7njh/z9mG5FuBiJkzx2e+sCqBMsAv1SmZ+pGFhWUZoKsy1iSM1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnJxgqOT0N+Rr4hPDonNsTUNAekEtvhjMrM92vl5ILKyfarXA
	jGR9DPAVOg6jNvCOU6yuQUJUNpuEvPu3dTJTAB7SHyaxXSGWJCk5e6bPb9lFW/wY/vKjJLcbws+
	BtRad7e4zbiNDUWPk6nW/4d160eQBFNhTrClo9R18maIwtZ6AY2Bofw==
X-Gm-Gg: ASbGncse5r53CTR6eFo08fjHz24SxNOYXFMCNEesmAPu9IcOIIJzSrTamYKvl+Sh7oU
	5vpgbEqxHuKdg25NTrwIYzcomaynYU5nLxzhzy2O/EyiztI+S9TcGSu8mRIZZedVUb2kcGkIB3P
	q++z/91HtxJBnrazwLSwsO4vynAC8F+FrGBluKiYCdt3epU6ZwVIoWD4EAt7eqDx5PLAzF3BFz3
	MxhC473WCdR5YNH9ElMXddXlAq1lHXBrNBf0yqOnWNrtW/vLoBWsZImvlyTgspvzH6HgrxEccIH
	Lw2kuf+V5UoWfJA6xg4+EjRUrLbJGVyXQRvhZZLCdO7+szjxw6PMKyzgaFgd9t72GnS2r/4=
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:f5fe with SMTP id 5b1f17b1804b1-45b855c0d3dmr110370915e9.34.1756910669124;
        Wed, 03 Sep 2025 07:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKbkCMZ4LvPme/EuBzwbZA95CEfK10pvDin+qYg4BSO4x2L+ewZWsEmuElBxgPinCjh7EOCw==
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:f5fe with SMTP id 5b1f17b1804b1-45b855c0d3dmr110370615e9.34.1756910668723;
        Wed, 03 Sep 2025 07:44:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm242270935e9.3.2025.09.03.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:44:28 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:44:26 +0200
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
Subject: Re: [PATCH 04/16] sched/deadline: Clear the defer params
Message-ID: <aLhUSknzOOOU3lKJ@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095008.162049-5-arighi@nvidia.com>

Hi,

On 03/09/25 11:33, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> The defer params were not cleared in __dl_clear_params. Clear them.
> 
> Without this is some of my test cases are flaking and the DL timer is
> not starting correctly AFAICS.
> 
> Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


