Return-Path: <bpf+bounces-56443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA1A9751F
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 21:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3201B61A6D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B72290BCF;
	Tue, 22 Apr 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G470giim"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFA1AE875;
	Tue, 22 Apr 2025 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348758; cv=none; b=eQHUlcu/gB5OmevoaT+I86t8be2BY7ssgPsWp9DcOPJF7rVAJSrP0xUUvKVTMljIentSmNumEDSj7zcDW3YAFiMTwuG20NUZw9FzWNsSN/eqZmlOzzXP9oR4zfd6aV2zU8nehPQFZGGmDenIDh7UuzsZ/Cd9yX9RvBW3cl+wYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348758; c=relaxed/simple;
	bh=ox3n7vqTRmaUjl5zlNSMs/7SpZ+Hew6klvq5n7FcVKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfgwsppoSIV/c0V6cn+b7tWe/pT3Qmhq+jkZOw+zfsyTMc3CREpU0nvRTT6BfjrFf2in1XXRsJt7uSWbZpkPqmy0GFlGM/Jh5pe96yiMH0vDtApcGayPhagl83T/tN0jcFn1ZpmBcbdw9ddSzHl6J4PD6dAn2F31xqhlZRQlh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G470giim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA95C4CEEB;
	Tue, 22 Apr 2025 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745348757;
	bh=ox3n7vqTRmaUjl5zlNSMs/7SpZ+Hew6klvq5n7FcVKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G470giimj570BGdmzoDFkKc9naA3AhDoFLWk4AK+FuKz5IXJkbOU8UPsnD0/JBcMU
	 uuS6niscYbR2kK/3GncoczZ+FFwL0lyl+AqPDRiOr/T1v8RkPhdkLQYjf5YMCP/gft
	 g1Hz80742PRImiE2f3CZcP2tMMQ0P3RBs9+GGKeQbI6wTJUXZXzOuEaZLGPfl17Nem
	 GxQ+zZctAEzH45GpQL74v96XmeJQb/sfev8MBgl3HbTvoLuSARUwd0Bf1zONtOCZqS
	 xw3bjQMK1Z/UTrC4Kr7lqHQ7FgLEUN1bGfHmAx50AHjhFrCdJ3daBtDDD6ijT4dgY1
	 UQFdIHANME10w==
Date: Tue, 22 Apr 2025 12:05:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next] libbpf: remove sample_period init in
 perf_buffer
Message-ID: <aAfok3ha8QQkP8VB@google.com>
References: <20250422091558.2834622-1-chen.dylane@linux.dev>
 <aAedDw7fWAF2ej1f@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAedDw7fWAF2ej1f@krava>

Hello,

On Tue, Apr 22, 2025 at 03:43:43PM +0200, Jiri Olsa wrote:
> On Tue, Apr 22, 2025 at 05:15:58PM +0800, Tao Chen wrote:
> > It seems that sample_period no used in perf buffer, actually only
> > wakeup_events valid about events aggregation for wakeup. So remove
> > it to avoid causing confusion.
> 
> I don't see too much confusion in keeping it, but I think it
> should be safe to remove it
> 
> PERF_COUNT_SW_BPF_OUTPUT is "trigered" by bpf_perf_event_output,
> AFAICS there's no path checking on sample_period for this event
> used in context of perf_buffer__new, Namhyung, thoughts?

It seems to be ok to call mmap(2) for non-sampling events.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> > 
> > Fixes: fb84b8224655 ("libbpf: add perf buffer API")
> > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > ---
> >  tools/lib/bpf/libbpf.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 194809da5172..1830e3c011a5 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -13306,7 +13306,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
> >  	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
> >  	attr.type = PERF_TYPE_SOFTWARE;
> >  	attr.sample_type = PERF_SAMPLE_RAW;
> > -	attr.sample_period = sample_period;
> >  	attr.wakeup_events = sample_period;
> >  
> >  	p.attr = &attr;
> > -- 
> > 2.43.0
> > 

