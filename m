Return-Path: <bpf+bounces-35910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADB193FCDD
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 19:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0B1C21BE3
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D931741D1;
	Mon, 29 Jul 2024 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vqIana4k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539843D9E
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275710; cv=none; b=VEVxRGxz2owjUySDOrdgWVw7hxYY4aQBLdmHm+d9PJAkfce6SRssVthrn9c8Ld6fgNtRsrAMFLMasS9CUTd3DnE0MLPBH3rT02kDDsXUz+QEakZ3UVOZ8ImGHPI8q8KgKtor9lGDltl9Nu17RJXS9azundvT1Vm8fTelRZQuB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275710; c=relaxed/simple;
	bh=DoIJpy99FTW+bEHlnX3jUMPvg+d8O+WGv+hlbXue1HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlqS+TxMwgWYuDY/VPTn7dIDX8FtxhkaOvq4AEVrREC77z3DPcHlpnjVoK8QRe0yQsua4F1MsZpjfh5USToMKBTZD+DOfJWWRLQ7Ww5DOZya4feEn6lg9EGJXn+cP8IMwOz43rLvFUf8XK4/Oh5BPg6+sAYh9elZrdz8VEKGPLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vqIana4k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fed72d23a7so22713435ad.1
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275709; x=1722880509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TabnT56p6n6u7EjWMrlt9344sgcBYi9lrb3FrnTUST4=;
        b=vqIana4kvSTUptqKLC8rSirKY9x0Xk33osDrfUMm4nL9Dg3pgY0JaQHLB6UX+j2L6D
         YhHrC0bvka1g1B61v+S+GR7yJZMQkhYzROwmkqCN6RaOuYLW1mjkmzDDBCt1m2EV4xRE
         IVk8lLQ7rl38SOOjZaiIHoJvkdgQU35c61qM/Ll8gmYOW2AY2czHYOMzurqdPoGakSBH
         P5e8bLIkHx11c76zheUBDuqy9I1XSY4xg5LXXtiJT4FswWzcnH2H7eFeUb+r9e1xc/4k
         hGwbamDjyyGJ1vIXkSi6HcPxdEKIr5bRzIavUD0/4EWvDXyVLnaXKaHA1UTa8eFBppzo
         zedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275709; x=1722880509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TabnT56p6n6u7EjWMrlt9344sgcBYi9lrb3FrnTUST4=;
        b=gfXxDnhrwR11ivJvnI5G5svUr8kReo8yJ43Or7gAnNBlGp8rlYkoTv54YR8s+hfJF8
         3kYlpt3Igd1y3AWaQq2PSPDomksD80r0EAwedOCezrBDdBHvhLv1J1LEIG81blDNv2R9
         MbBspyEW/jboGO3/enFczmtVhY15vOrMXpb1GntcR2IXOLi+mrFH/NRrhlkG9XVahOFw
         4iIi+NJOF4rHp5Rg/xkoWLL1RC7PQG+j4DdSY8QpvK2tvSy1+lVCUc9kKA8b1nygr9Lh
         CTQ0qbgZj26KZ/g8UHd/6UZy+Gc+D0OiQAiDHUCVm3mopGrjTDoJRXuAyrKzbNM/dEhI
         Nc2w==
X-Forwarded-Encrypted: i=1; AJvYcCWBK9dwRcYfjJ2wmKmzeuNJCK7jSiVPjT+m7/8VWZzbq7dIbya1OchuYrCMABW25iSU7qT6gY9FHitJTzCOVEl3unxy
X-Gm-Message-State: AOJu0YwGQJP3FdsGc7oDzS8VuJizNaB+rdcpM6oscFJ/XmDW5skzYqhq
	V4Rf+wrQcRCyPHFoCtFAnn+xuRtLBCEYPfPlB5EOOp4vLeDlzBMAbCAGLdMgHJA=
X-Google-Smtp-Source: AGHT+IEC0OBdLKSfBqiPGkG2qzUWP07kZSB5gov01yr1ZIEZz1rTwFjiFPH+JlVAD639mT74NrOcOg==
X-Received: by 2002:a17:902:e547:b0:1fd:d3db:bd06 with SMTP id d9443c01a7336-1ff047deaf1mr67630745ad.2.1722275708599;
        Mon, 29 Jul 2024 10:55:08 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee15a9sm85993855ad.151.2024.07.29.10.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:55:08 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:55:03 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/8] libbpf: Move opts code into dedicated header
Message-ID: <ZqfXd0FKtXCJ5dwH@ghost>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
 <20240726-overflow_check_libperf-v2-2-7d154dcf6bea@rivosinc.com>
 <CAEf4BzZ8MGa8Ywp_9ztJh6naywqtfrbeGWs4=izw-e-p4GGxcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ8MGa8Ywp_9ztJh6naywqtfrbeGWs4=izw-e-p4GGxcA@mail.gmail.com>

On Mon, Jul 29, 2024 at 10:01:05AM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 29, 2024 at 9:46 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/include/tools/opts.h      | 68 +++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/bpf.c             |  1 +
> >  tools/lib/bpf/btf.c             |  1 +
> >  tools/lib/bpf/btf_dump.c        |  1 +
> >  tools/lib/bpf/libbpf.c          |  3 +-
> >  tools/lib/bpf/libbpf_internal.h | 48 -----------------------------
> >  tools/lib/bpf/linker.c          |  1 +
> >  tools/lib/bpf/netlink.c         |  1 +
> >  tools/lib/bpf/ringbuf.c         |  1 +
> >  9 files changed, 76 insertions(+), 49 deletions(-)
> >
> 
> Nope, sorry, I don't think I want to do this for libbpf. This will
> just make Github synchronization trickier, and I don't really see a
> point.
> 
> I'm totally fine with libperf making a copy of these helpers, though
> (this is not complicated or tricky code). I also don't think it will
> change much, so there is little risk of any sort of divergence.

I did this because there were two comments on the previous version of
this patch that asked to change the functions that were copied over.  I
had a couple of choices, have the implementations diverge, not change
the implementation in perf to keep it the same as bpf, update both perf
and bpf, or share the implementations. I figured the last option was the
best to avoid immediate divergence. However, both of the comments can be
safely ignored, and also perhaps divergence doesn't matter.

- Charlie

> 
> [...]

