Return-Path: <bpf+bounces-29666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CE8C4848
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 22:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B2B2820E1
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCF380027;
	Mon, 13 May 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Lb93Tpoj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919011E4B3
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632577; cv=none; b=rWikYtbWliJ6MntMP7w7tnPgbowNtvaV97MTKFoIbZ71CpcJaIG/+mHpzv2HuX9uTsp2VhMW+cUGIL6riX8qR+y2t191T/870YU5mgAia82plTGxnRjlCd26JUhd6NjdPARbQ4nhY7h75z5iKVPT20tgOM3W0KlQ6sLrqqKgA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632577; c=relaxed/simple;
	bh=Vm5ffhlsGkE2Y3R2YiSsCMLraUbkncQ+RgFFPCJX4rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvudAhqkkKNZXy15Cqxo7pXBot2gGFViMFY0d3zkYXgCFZlFLil36ea3ehoEMgt7SZJQJFK/aCcNJlJRDLxOwtFxHRr8DdC47Ts2zs4oaF3p665B5kmG7HGION1A0Tt75kDiIzH7IYqAtE2ev36tvaWHUMh95FGEloFYkOTKTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Lb93Tpoj; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B321041070
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715632565;
	bh=iHGP+H/HM9flCIvET231fhltqpSgxNj3NFbnCTXeM88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Lb93Tpoj5NT3cg6oePgcLrP1YZ2ageIcPZ/1u5Hgmv6daj6njEOktlC9cj6XXNqBU
	 ZXnu8VanvzVhBBUdLjRUAnmMZk5UGJoEDgmtvjxbMsjD4PyiJiIlA65eeVBN6A2uxY
	 YOVkzPrS3Y/BmGM2qvcg/lBAIG1q/bF+QBgucoi6pqSTFZhncYMo7wANeKSsJI/WHm
	 u05vFRM5ATDk6/NBJIL5kzIOdJYAhUo3w/MJEdDQUrMiWjDoPXSxtLRpcRDSxgep6A
	 rAzNrcfAdARa3ax26OIjfJDDwcEdSZ9mwOROxm198w04xLJzXq3vUqmjz5CClvxRCg
	 pZ9/ckg++df3A==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5a5fdd6185so190864366b.1
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 13:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632564; x=1716237364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHGP+H/HM9flCIvET231fhltqpSgxNj3NFbnCTXeM88=;
        b=cGJvcb8JPYr+y3lrfM8DuTFEj7iMkFE4htwFQSc9jbwWoaAU55Cs1+SyXYx6g+DOgz
         od+449RqdBskjZ+5rmrDT/PiqJvoKDta3kLgntJ31WhEGNm19QKsA2nHlrBH2qEDOciZ
         pNX8F37lTbO7fGTvnPGiM6jVP/iW7LkefJmbqzN/kEUmVCmDR0cJG7CHbOyXRnnNj0Kr
         ewomNKVYGJQk9B7Yywu5V3Pt/f6lj+5dob+2GnCtg32lnDbQoUOpzk7wPQsxuT/uoy6c
         +jRwjJ49MEaM54nX8vjvF4iIvXh9iwRUvnnecMx+el5396viiuyIlWJ1w0en9EWC47FK
         j+nA==
X-Forwarded-Encrypted: i=1; AJvYcCW9L7Ao1ZE4mQSV0ooH8cDuaLTzC+Jr+pPJWA1oE+nlWs8bAJSo8pud/PilKhKZ8FiEjIfMYldsNqK3dK2+3v+hvd82
X-Gm-Message-State: AOJu0YwCdv2DnuPnXG/vY/PNMMjmpB+EM19rhWmpANKYIDQ+MxRQMGKT
	UI+9v2gPIpUPPcu+vlYm7H4zzxlBmZnmObPAyWjs9ruGNoKEKV/vLxngX5r2o5/jJ3UlnCa/AGp
	RxmNMcsiHNFojHC4Mfs6miuhdEZFu7MuAmOdS8+7wkihQ2Z7WQvp5USaQz6HN/5gTHw==
X-Received: by 2002:a17:906:bc50:b0:a59:cb28:a8ae with SMTP id a640c23a62f3a-a5a1123b477mr1149341666b.0.1715632564553;
        Mon, 13 May 2024 13:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1kQyCjjCLZOhI8xB5fNDStLR4XHod0qoVMqxPP86DQNq5z5g3CRr53iNeRzv+ZRIvZoBqQ==
X-Received: by 2002:a17:906:bc50:b0:a59:cb28:a8ae with SMTP id a640c23a62f3a-a5a1123b477mr1149339166b.0.1715632564003;
        Mon, 13 May 2024 13:36:04 -0700 (PDT)
Received: from localhost ([149.11.192.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17d02sm638065566b.218.2024.05.13.13.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:36:03 -0700 (PDT)
Date: Mon, 13 May 2024 22:36:02 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <ZkJ5spNSP2Hzj-Xq@gpd>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:35AM -1000, Tejun Heo wrote:
...
> - Ubuntu is considering to include sched_ext in the upcoming 24.10 release.
>   Andrea Righi of Canonical has been actively working on a userspace
>   scheduling framework since the end of the last year.
> 
>     https://github.com/sched-ext/scx/tree/main/scheds/rust/scx_rustland
>     https://discourse.ubuntu.com/t/introducing-kernel-6-8-for-the-24-04-noble-numbat-release/41958

Regarding this topic, I can confirm that Ubuntu intends to provide
official support for a sched_ext kernel in the 24.10 release.

We still have to finalize all the specific details of the plan, but
essentially, there will be a separate "derivative" kernel featuring
sched_ext, alongside a user-space scx package(s) for the schedulers and
tools (which, ideally, we would also like to upstream into Debian).

-Andrea

