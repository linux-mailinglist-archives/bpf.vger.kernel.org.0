Return-Path: <bpf+bounces-75453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22260C85086
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A3384E90DB
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE13321F48;
	Tue, 25 Nov 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CxbVjZRH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F01320CA0
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075330; cv=none; b=b3Ev5z4FiHUIw92JS3mQRNuRd6K90v/VVaEOBG67BIADgULGo6PzUBkLftXV8AE271Vh1MFfO/KL4Q0h8tjyW4lZe4RI3Qt5mpSqv1nrRUYlGrtQ8/cwqbT3NfGpyWWQBCYoL/eGSbssOKKi4igrRdUo/Y3cnSlJPW6SW6Bin2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075330; c=relaxed/simple;
	bh=TcIehyyg9NOgFB+aqxQUl1XQcbzEAynNMvyg8CX0Iz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHfHUVbzj/3uB5PM+TsN0ns9PI5LlcTqlJ63tvEcpAAVjG5mHzxCO8pSXr4vSWTwHsF3bOMqcnQOKPVti/iYxyyNp5mGiLiYtQ36ENEWr0PbWiKew28CXwj53BhZxnjDjo/LmOhzd8WtGbk5vR721v1lbcc3A87PtnLsf+6UlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CxbVjZRH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47118259fd8so48005905e9.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 04:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764075327; x=1764680127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=usCzcCtVI6XgCiCu4NS8NEIAX55CiKwZAm0iUXb+TsA=;
        b=CxbVjZRHmdeNmVkpr656+7d2ejK+CRH5xbGN7WoQ1OQ6RSHHh4OemSB+Ts4ZVLydJa
         i+P2cmzrjX+PHuVDpSmB/Rm9YpkTSjr/pqoFg8pmTCY/FU1MR7Fkzv6of1c8WVTwAWZC
         135wz6s+2WNVkWja+VN3+41e2gX8oILAA+CmXxTzb2eCA8TN6kSPJSsa/CAGpSao6x/E
         366acJ67JjjaSN/7Qo7z6pX4zvh4Blwk1y6BDbdG83jvOAAFht2r91fp8EcdeKpQGh6W
         B8EslKrt8PU6/IWPUadQR1+AT7OaBclYJMHoYdCaXlDof4m/Z7u+f4TwtlnX1jH6KJW5
         CXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075327; x=1764680127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usCzcCtVI6XgCiCu4NS8NEIAX55CiKwZAm0iUXb+TsA=;
        b=B/hpe8MU06coy4v50oDhreQwpNlWTzCaiW+0pB2Wfyadx+hcDJIIeYv6z54AInKz2P
         XA2XYVqRaj8l7020spIiyHWrT8prM4mGh4DP056oNo+A3ZD7Hk7/5wNmpq64K8udJVSU
         pML/A/E/f0atndCcdSCW84IyLqfzJa1AdY0NAgpj5UxCm/HMnDlqTHSgzrLZR1eE+OO3
         F+T79GIlwIyHJ7LK/rV/hkJQkjGpYN99NiY8LUsWx6L89LF72iAiD3sK7gCa+0KC3tyM
         stN82e+Q8hGOygeD3CGfuDzcJNIO1HoNq45PaLVU253gkResr2QqnQgs+WtxzRwgGEuB
         2Lbw==
X-Forwarded-Encrypted: i=1; AJvYcCVXjC4SzG6qpjm0Jv52ZUZd0ZMiSHsVndr819uSRPIx2L2CmgZ/Bz8Tv+H++C5JFVdkUSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFrGsDlsBFklYoTMYrxk19sKSMag0ldbyINhJBfiETBBHTCRW8
	OBy5/C2aITfeC0qwQR1nh1JWJRgqG6VbnyPOPUzQ8HoPxrncgOsnOMD6ftL59jIGZSI=
X-Gm-Gg: ASbGncvSQhBwXPuEtuzOfcJAc7tOQp9t+sVh01FxPCzVRlLD36J8oZZ+NN1sRYMB5Cr
	5du+iUrHfEG+4m2cRXVHRwsEkihd4y8YwOE5I0zXQLpUuAOEO8nBrzV3lQhvigtmni/O7GbEH5p
	JQqvV1MWOe7/uqIwAhc1A54hkj/T5GTtWW6nzTg0BMQ28YMmhPuCGR0kWTiDzmvqLM2UKQqVmMS
	hJEJ164KS1d4vXozSCCtNjl/DVoC7bhqqeEojW4KsrmqlRyvfpbpoLA299hnKDlAk27ZE8cpozy
	XoISqxX6ZgPj3+nIxFIIb8zRQfFb965sbA4OSYf36gNRIM1R0oL257JwOVJpOu8rI0zDfxYa3in
	J6fFGOtdP9Pgs+x6fdckISBLzAFJTVrTekotB3g7fRZf/Y/1JeZ0Y85uayezi8OZwooaRRxH/Kz
	dNhSOVllUtIrx5TcLB/AGoWiN6
X-Google-Smtp-Source: AGHT+IHeNFHz77PnS9U9y/LXSC6SdqMAwMHknNtAmvznPS8Yog8Q67/4L/1KHix1NRlDrhL8Rpv3qQ==
X-Received: by 2002:a05:600c:3112:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47904b2b2e0mr24822815e9.32.1764075327005;
        Tue, 25 Nov 2025 04:55:27 -0800 (PST)
Received: from localhost (109-81-29-251.rct.o2.cz. [109.81.29.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040bd209sm18794505e9.3.2025.11.25.04.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:55:26 -0800 (PST)
Date: Tue, 25 Nov 2025 13:55:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: hui.zhu@linux.dev
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH 0/3] Memory Controller eBPF support
Message-ID: <aSWnPfYXRYxCDXG3@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
 <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
 <aSWdSlhU3acQ9Rq1@tiehlicka>
 <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff7dad904bcb27323ea21977e1160ebfa5e283d@linux.dev>

On Tue 25-11-25 12:39:11, hui.zhu@linux.dev wrote:
> My goal is implement dynamic memory reclamation for memcgs without limits,
> triggered by specific conditions.
> 
> For instance, with memcg A and memcg B both unlimited, when memcg A faces
> high PSI pressure, ebpf control memcg B do some memory reclaim work when
> it try charge.

Understood. Please also think whether this is already possible with
existing interfaces and if not what are roadblocks in that direction.

Thanks!
-- 
Michal Hocko
SUSE Labs

