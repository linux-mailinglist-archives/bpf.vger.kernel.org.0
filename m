Return-Path: <bpf+bounces-76985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB51CCBC3D
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 13:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749CC309A46E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC52232E13D;
	Thu, 18 Dec 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eSXjjlDu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FA32E6B5
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060250; cv=none; b=MB16PFYuWRPTwYAcTvSrVdi5GLjOgej6WIMRBv7TjCZ0KOM8rJwzHROP5N9IL7rr4Ba881SY21WdLWqmQ6j8R1zY3wn4bAXmsFkPRzwFuf+lw9B3myX2QyUEYmCQNGi4/Hdy9c7bL2ocKl0FX4gGi8axTqs2eg5DpduZtViNPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060250; c=relaxed/simple;
	bh=TK3q9Qn/Pe4y7lyna7D732vtlt/WgAJ3OxwB0ciLL7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI5vJDWGDRAQNpvpn1Icyx8ZLeo1RsUePbAYjhjrpfSUDwiVjDUEw7obUF+3oo/RgXsHWgRsIL3AxHqjP3Vszw1qqYwXZlM+tHG3UO/+K6dW8DcqRupgmeBbadTni/eKuOQowmfSKM4QCl+IcT79kpqa4Ql0oNu2io+ohXtt5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eSXjjlDu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477aa218f20so3698705e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 04:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766060246; x=1766665046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82ryBTb0OYajbtmHnpP2vY6hULmAqRanYTWCsyHvjaM=;
        b=eSXjjlDuYzsJ8jklmmUNqKAd6QmQQ95OtAe77JetPa8o4oTWylnDwQjo0qMEEIyT9v
         Su0VOGOUmd7HNyVuCS13ftVzZvzieD5wkBqF616l29nozYgStoh5AhuDeYigyuGiIVhp
         o/fEA6WkFc3M2htmgnNzl6AkTwapn/XE9A6HafNk/QLMVK+9o6gobHDGsL1UODTZ6JSR
         m8dSPq1I39MppYyAnl6Vcv5oF5tM+67iVYcW6v+qHUrg/+UktxwKcNZL8/owszU/UvQq
         eFfuN2Z9PY/KPEo68Hs9eAa82ds/JhqVVciXSf+f9do9LNfjTSSy73Y2mzG+SNaNK9V3
         Oy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060246; x=1766665046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82ryBTb0OYajbtmHnpP2vY6hULmAqRanYTWCsyHvjaM=;
        b=eQYBSQccymiMdPcC4+ryjuFVkwzv4LngBeQtL+vkP6IhekiBnXLrIVPtvLV+Fgjfei
         3ZRjhW9OeXYD7V7s5/bNlnQEbT/Tg5YRhv/T1ras7h7bWonoEnum3xZkduslDma+/oSk
         3+bvK0J731RxwpNea0o6Kiz+KVx2eF19PyvPCfqgIR0fexT3+VT45sAidAsVIWspETsC
         ty3TwgW43uzqYN1csgTdWXC7+mbyiThJth+K1xBtlahmtWv6zTGIxvfZjgGNKOpdZl+Y
         EQh93s09AJhLeLKKKotIzFW5eEYfIX70TduuNRWUyNKCvG84uBY+DJ0gotmLNmO+chpe
         r8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqtmGTupD0R6DuNrZ2nBqhECOQ3cdlrdHvkP4LUCIMujoXhV9u8AJjah0cC38MUO3apx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLB0fziYw+FWYnVwVz1DLdSfWu4R06ohhhXz9ASJK4bfAZyeA
	DdkaeM+0VOx/32BevWQEpyWWQiW/gB3cnfBmcNLVVIaejQvoEGlYNdQXZ5Km4h8Lvfo=
X-Gm-Gg: AY/fxX4O8GhpFPaLQmkP/wvkwM9PwnOFAGq5sCoI+mZRnLM2F7SCYY077EAMYzg9+DN
	uCgwBGaDfjiCm3Dr7s6q4mtdxx3J416jGpozpa6baRef7o9KCGkF4kyyeG9AtiNmxtCnhFLNCsX
	uLTfC8HvduUYZawaav2GNc1r3eADkDh+CAoesAKkpA0MSk2C0Chw3qdaMqgICzo1noDlOoI8OMh
	a/Y+McpUYBn5FzUYXepre9nC+4pYMgJ2lxJWA7TO8pULqUPliIx3rUbdEfzvfgLnNTDnmn+fTUJ
	bYokfWMKiwd9j2qzWGOYvDLhMUdOHJ6ktcz1I1QVjGP+SQXzArnDsKwLoMkcyO/qG7ItGUKR9hC
	/6id2AlACj1Iw09UsTIiVh19DwfnF1gzYSFMDHX9Uyb0J0QGnmRMsexhzAsc0Tpmrx2slXwjHwu
	CbQrSRtPtlQkEJ+uJqRyn0ewk3tT/OzywEDwk=
X-Google-Smtp-Source: AGHT+IGTUeEzz8tNPQ2pmX/MnRbtFTT5HvfYasuVnspclS+oD1dD2L49trQ2Os59ODIZ3jVEB6x5aw==
X-Received: by 2002:a05:600d:6405:20b0:47a:935f:618e with SMTP id 5b1f17b1804b1-47a935f64d7mr172794535e9.15.1766060246405;
        Thu, 18 Dec 2025 04:17:26 -0800 (PST)
Received: from localhost (109-81-80-251.rct.o2.cz. [109.81.80.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449ae0ffsm4488541f8f.39.2025.12.18.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 04:17:26 -0800 (PST)
Date: Thu, 18 Dec 2025 13:17:25 +0100
From: Michal Hocko <mhocko@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Message-ID: <aUPw1YFNLf7ONqe9@tiehlicka>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <aUPJuZINNuNxddRX@tiehlicka>
 <aUPLCPAyxkPeBaoD@e129823.arm.com>
 <0d08b4bf-35c5-4c63-964b-ef886b8262d9@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d08b4bf-35c5-4c63-964b-ef886b8262d9@arm.com>

On Thu 18-12-25 12:02:14, Ryan Roberts wrote:
> On 18/12/2025 09:36, Yeoreum Yun wrote:
> > Hi,
> >> On Fri 12-12-25 16:18:32, Yeoreum Yun wrote:
> >>> linear_map_split_to_ptes() and __kpti_install_ng_mappings()
> >>> are called as callback of stop_machine().
> >>> That means these functions context are preemption disabled.
> >>>
> >>> Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
> >>> __get_free_pages() couldn't be called in this context
> >>> since spin lock that becomes sleepable on RT,
> >>> potentially causing a sleep during page allocation.
> >>>
> >>> To address this, pagetable_alloc_nolock().
> >>
> >> As you cannot tolerate allocation failure and this is pretty much
> >> permanent allocation (AFAIU) why don't you use a static allocation?
> > 
> > Because of when bbl2_noabort is supported, that pages doesn't need to.
> > If static alloc, that would be a waste in the system where bbl2_noabort
> > is supported.
> > 
> > When I tested, these extra pages are more than 40 in my FVP.
> > So, it would be better dynamic allocation and I think since it's quite a
> > early time, it's probably not failed that's why former code runs as it
> > is.
> 
> The required allocation size is also a function of the size of the installed RAM
> so a static worst case allocation would consume all the RAM on small systems.

Understood. But is it possible to pre-allocate early on so that the
allocation itself doesn't have to happen from a constrained context.
-- 
Michal Hocko
SUSE Labs

