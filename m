Return-Path: <bpf+bounces-75449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2FAC84EE3
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 13:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 875F1342187
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85C319852;
	Tue, 25 Nov 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lwsxcfxg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069331A565
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072783; cv=none; b=pia3Pr02HLHupdap2Bg5N3xzobZILPOEW1ng7pwiaulC/mxZbamsw5vx3x3tb9yxIHoHuWBc65J0gqjhT+cYScaxGp7qKN9hT94RBKEa2RmEdjf1mRHSLtwDZXRngLVEDTzN6xglMN43ASPK6yTzU0V5vrKfLij9cy/TkxtHilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072783; c=relaxed/simple;
	bh=CwP644Bw/wTUEOIYembKp5pq5/shG4Vtk2t3qMFJQFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6ObL/+NMQ9Z89L49drMbclXLi/+DXy4SE9e/cxgZH1b0b1w6MeQgTKKXCRc5g1aEggmfEtspM2yesSb27A2+ejMkfTwawwDq5AOTL8hU3vzM6AjgY08laB0yPaXFKxYA7a57FThP0dE0pDi6TVNoIn+hLGb3nCCjnbiPO40RXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lwsxcfxg; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso4502531f8f.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 04:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764072780; x=1764677580; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dxJGiJOjFGbJrN6TdFxredys8Cq/gwxxT5DnbpdfeGc=;
        b=LwsxcfxgEAna6Ht0IsaXQmq96Syh21XGEqBc4biKD4skz9U1lvY8HZRfndWJY/MxVJ
         Kig7AMZSgv7Rqf8TAxp2SGyUDvEJpTT31OSc+LyMj7NGJf1CqQ0Meh2zRJ8gmGor7QtN
         VzBml2H7l3hiXSUxPhPNwI7lNIs//xTfZdO//116PpR1rpbaCcKGBs4TiQy0RlfORian
         Vujjt7ztosBg63wPPZyEu2XcbMXzMxLAj9pONHFQoLqfPNVjCL0Haur9SgiiKJqwESJ/
         x3+y4IE12Ori3zag+w7iOMtPN1Xgv3MWabPOkxkVQWxwTwRYozhyVkSHby/1K1pJUmu0
         DrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072780; x=1764677580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxJGiJOjFGbJrN6TdFxredys8Cq/gwxxT5DnbpdfeGc=;
        b=v0IBcgy/UDtgDVpo4k8SsRvqaA59YDEZlZLooIKo9ittGZSC0JzNPLafU2etfMuDYo
         IHUgtLqdLG9J6kKYJSaKE0CGgC2AB96oJL82myU5TSNtjlZI0KL0inGpWgdG3ggBbRGt
         EuqfMg+rdKRsANEuF0NrQONTKEq4pbIvKfDcRx0ZO1NYeSGspiPdfZK0ugzVrZrAaTtu
         h+pbS4zKCqzzyusvWxOJ7DLDbcj2SKuNFun3P6UwQD/x19G4Yg8ardBKaN+H7CTdLtpG
         cKMM9L0TvKGUxdfWcUDPFx4GM/jP1SuE26CLqtNUCsyxwqr8iifDUgajBqJRNf09lOVy
         MvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxa6DlBX9HjgB63RZNuPB9rMKW1DjVpYOSs1Kr6WL72G/NihLz+4C2zIy8R9U5Vl4Q0NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn0kGgYSQIk76glJvhiqjx3OZNw2yf8iGYhR8cw1xc8ga2SPLL
	Dfm9yCFn12mDpXz5r98bUkVK2idjo+cyPVVO5XMcJOejMfurU+qDzFY9XELywSjXJnU=
X-Gm-Gg: ASbGncvgGgQnjzXO4R7IdS/fi+WNH5RiqA4WoooIiFjSe+bYYf8aDeT/3Ox6GEWt5Jl
	xLBbGmTro3aYhXoxQrknvsXb7bE20wvixxqlqE5OStDn1YnjUay9QMcxmvq9ykqNU8Oozwllq62
	U3jbTNCB+g5uxoA4o09q6W9zGFj5PFPi1jJMjypOMamLg1qz2VwJFYBa5DIyJnNspguyummwrgW
	GLaACrO2CCOYdzQJxyL36YgOk4TLozGDMYLn8CWp31LudU0px1S4EjATCrcoevSM1t5nhxgvmTg
	lkDd7YLFNdULkwMDkeFRdEaGUH3+S62thRKGeQ2Q46wmBN84LZeqBeIbBdHVZiZOYypu3yKIPcM
	+UGI6lmZzTE6XLEHSLtorUFc8SG4ZCPhhcb47ttWI4N7rcl1qdhv/Bdys473pFfzElDDnXlD0NA
	eJ8MpVF+PX35+Y4170Ykj0Lkw1
X-Google-Smtp-Source: AGHT+IEV2rB8yUe2NCUZIw4moQNsZpTQgAmZgRSSfaXojAIWU3YqaEOZQPUbkzKEE+rrVogbayao5A==
X-Received: by 2002:a05:6000:22ca:b0:42b:30a6:9c10 with SMTP id ffacd0b85a97d-42cc1d22e12mr16592650f8f.56.1764072780019;
        Tue, 25 Nov 2025 04:13:00 -0800 (PST)
Received: from localhost (109-81-29-251.rct.o2.cz. [109.81.29.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm34815638f8f.26.2025.11.25.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 04:12:59 -0800 (PST)
Date: Tue, 25 Nov 2025 13:12:58 +0100
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
Message-ID: <aSWdSlhU3acQ9Rq1@tiehlicka>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
 <87ldk1mmk3.fsf@linux.dev>
 <895f996653b3385e72763d5b35ccd993b07c6125@linux.dev>
 <aR9p8n3VzpNHdPFw@tiehlicka>
 <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5c4c443f8ba855d329a180a6816fc259eb8dfca@linux.dev>

On Fri 21-11-25 02:46:31, hui.zhu@linux.dev wrote:
> 2025年11月21日 03:20, "Michal Hocko" <mhocko@suse.com mailto:mhocko@suse.com?to=%22Michal%20Hocko%22%20%3Cmhocko%40suse.com%3E > 写到:
> 
> 
> > 
> > On Thu 20-11-25 09:29:52, hui.zhu@linux.dev wrote:
> > [...]
> > 
> > > 
> > > I generally agree with an idea to use BPF for various memcg-related
> > >  policies, but I'm not sure how specific callbacks can be used in
> > >  practice.
> > >  
> > >  Hi Roman,
> > >  
> > >  Following are some ideas that can use ebpf memcg:
> > >  
> > >  Priority‑Based Reclaim and Limits in Multi‑Tenant Environments:
> > >  On a single machine with multiple tenants / namespaces / containers,
> > >  under memory pressure it’s hard to decide “who should be squeezed first”
> > >  with static policies baked into the kernel.
> > >  Assign a BPF profile to each tenant’s memcg:
> > >  Under high global pressure, BPF can decide:
> > >  Which memcgs’ memory.high should be raised (delaying reclaim),
> > >  Which memcgs should be scanned and reclaimed more aggressively.
> > >  
> > >  Online Profiling / Diagnosing Memory Hotspots:
> > >  A cgroup’s memory keeps growing, but without patching the kernel it’s
> > >  difficult to obtain fine‑grained information.
> > >  Attach BPF to the memcg charge/uncharge path:
> > >  Record large allocations (greater than N KB) with call stacks and
> > >  owning file/module, and send them to user space via a BPF ring buffer.
> > >  Based on sampled data, generate:
> > >  “Top N memory allocation stacks in this container over the last 10 minutes,”
> > >  Reports of which objects / call paths are growing fastest.
> > >  This makes it possible to pinpoint the root cause of host memory
> > >  anomalies without changing application code, which is very useful
> > >  in operations/ops scenarios.
> > >  
> > >  SLO‑Driven Auto Throttling / Scale‑In/Out Signals:
> > >  Use eBPF to observe memory usage slope, frequent reclaim,
> > >  or near‑OOM behavior within a memcg.
> > >  When it decides “OOM is imminent,” instead of just killing/raising
> > >  limits, it can emit a signal to a control‑plane component.
> > >  For example, send an event to a user‑space agent to trigger
> > >  automatic scaling, QPS adjustment, or throttling.
> > >  
> > >  Prevent a cgroup from launching a large‑scale fork+malloc attack:
> > >  BPF checks per‑uid or per‑cgroup allocation behavior over the
> > >  last few seconds during memcg charge.
> > > 
> > AFAIU, these are just very high level ideas rather than anything you are
> > trying to target with this patch series, right?
> > 
> > All I can see is that you add a reclaim hook but it is not really clear
> > to me how feasible it is to actually implement a real memory reclaim
> > strategy this way.
> > 
> > In prinicipal I am not really opposed but the memory reclaim process is
> > rather involved process and I would really like to see there is
> > something real to be done without exporting all the MM code to BPF for
> > any practical use. Is there any POC out there?
> 
> Hi Michal,
> 
> I apologize for not delivering a more substantial POC.
> 
> I was hesitant to add extensive eBPF support to memcg
> because I wasn't certain it aligned with the community's
> vision—and such support would require introducing many
> eBPF hooks into memcg.
> 
> I will add more eBPF hook to memcg and provide a more
> meaningful POC in the next version.

Just to make sure we are on the same page. I am not suggesting we need
more of those hooks. I just want to see how many do we really need in
order to have a sensible eBPF driven reclaim policy which seems to be
the main usecase you want to puruse, right?
-- 
Michal Hocko
SUSE Labs

