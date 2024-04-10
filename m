Return-Path: <bpf+bounces-26383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264889EBB1
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 09:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8268B269F7
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29EA13CF91;
	Wed, 10 Apr 2024 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRLgz9lv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2B13CF81;
	Wed, 10 Apr 2024 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733530; cv=none; b=rH0yDZ8Ec1Kqbq3ziuyBEFPtW51ZNWk98FR4NfODhnZ4JZhPtMpfAxBbr+c1egS4FruHNQieinEDWWQ9qNKSI36uv/GYRJY12KVrWeQk7lqB406v5lRzft6oFUHFEQP2anFmEkiXN31TEOghMoF/2T+kxrUO+ftk0UtdbKjeads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733530; c=relaxed/simple;
	bh=+p8EZ7ny+p4pzXyzpwaJvUcxWqhW4WlZRv4Z/0cASvc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXwiVEBTSVvESyNH6d/fekV2ETEc8z0YZ/7+lt5eV0lye5moDWOVgcm0eU1s6gnz9o4xOZPaatW4UzSlkGESZgXeQYLmWPbGKyN4WwZkGKsy5yvCPc9qDrZOzyBlRuV2tVCGCI0ZYGua/a4uI5W/AymlSn+A9FUb8FSi+WLYQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRLgz9lv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4166d58a71eso19849785e9.1;
        Wed, 10 Apr 2024 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712733527; x=1713338327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REbaDXtbXbPPn2VITYxiiPFxNxaFeriboyDgjG/9txo=;
        b=CRLgz9lv/WhWwS6RrGPbIqkTRBYkI16c62zdHy9FsDJV2ypT0JdWsOkWXIXu/tbM3C
         4GjnE4bGukXdkKpbqHzXhXd/yHg8C4XS/Pp/YnKrxhibXvXbfKjtW2zCY3tsC/0IieO+
         TCf6J6Jf53wOD7rsqb1rX2bCWX1O0a2H93OwcYfwQGjQNNGuwtTNK0kDTNMfNI2ZwHz7
         +gTWd5rn9F/tYwfsxkWPQe9vpIdyQoOC7mP0/EbY14QMKa6p761wdTpg6tK5dQVsXVLV
         Fplr4QGWIupaEmf2GXSZaHTxuS78CATHH3PnQjgwVpO0xhzZ2TiA/xvciRegTJOb/vfK
         Sqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733527; x=1713338327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REbaDXtbXbPPn2VITYxiiPFxNxaFeriboyDgjG/9txo=;
        b=ocKBbO7BpJdFZUAsOU2Nn0EzggHHotIv2px/M7HlXcrawbn3DfNgdvjN0+Hvx5d1bM
         k6ES6FvrUtBe/9PyAQe1arrhP/eqEpebhgJUWAJzs9Cu/jm/yV3cT8WEXHoBTmbKpKQj
         4PzoekNtVYgjr3hdI6eiY5FzKK0SVNt/TP7O1l5qwnL3s/WzuWkjw1bXe8pv48DdRVa3
         JwFEWxfWiXoaNJP9I5ztRFm31tM4Kwb7JZ/wWVj6gSmAVt8SMjgkqZLQcui+5CnoDi1G
         /JE3c85rOY0pXXy7tuThbbXnjFx2cHNI2S/aD1oqzUOYAOpSR8APhxLJnMpfKluFVp18
         ay1g==
X-Forwarded-Encrypted: i=1; AJvYcCXDPVD0kg5y3SFobylm3NYdO40vtqFaKHleWF1QVRFL+pLr/mJac7BkSr+p6FmP8QUd8ZG281IChg7CF9/zoOjzUWEV4B4rkKfX80LYie1e/p/M9GTFTODGfUcetOMsCvVZqZETbTWGWzLkgmUY0oqt9l3/HCgyNw8W/8mK+JB8FAEZWA==
X-Gm-Message-State: AOJu0YygJqzoAP7v8HtMA/7oEmdXJk16jR+EW/hXh04iHnrM0Rff7hTS
	Hr1FLl2HatlVdRu21bJWLw2pBBzAo5lFdd/REVrtJkpK46cm196y
X-Google-Smtp-Source: AGHT+IHfOWT59wWMwai4D3q1ku9mFPZxtzYZ94pxPITORAvb6tZphEFsRp44Z0Ow5y+geZ57CgSoNg==
X-Received: by 2002:a05:600c:4f47:b0:416:32b8:8f3b with SMTP id m7-20020a05600c4f4700b0041632b88f3bmr1339095wmq.17.1712733526754;
        Wed, 10 Apr 2024 00:18:46 -0700 (PDT)
Received: from krava ([2a02:168:f656:0:bbb9:17bc:93d7:223])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00416770871f7sm1374713wmq.25.2024.04.10.00.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:18:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Apr 2024 09:18:44 +0200
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf bench uprobe: Remove lib64 from libc.so.6
 binary path
Message-ID: <ZhY8xzVJ6_9BI-Vd@krava>
References: <20240406040911.1603801-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406040911.1603801-1-irogers@google.com>

On Fri, Apr 05, 2024 at 09:09:10PM -0700, Ian Rogers wrote:
> bpf_program__attach_uprobe_opts will search LD_LIBRARY_PATH and so
> specifying `/lib64` is unnecessary and causes failures for libc.so.6
> paths like `/lib/x86_64-linux-gnu/libc.so.6`.
> 
> Fixes: 7b47623b8cae ("perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk")
> Signed-off-by: Ian Rogers <irogers@google.com>

patchset lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/perf/bench/uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
> index 5c71fdc419dd..b722ff88fe7d 100644
> --- a/tools/perf/bench/uprobe.c
> +++ b/tools/perf/bench/uprobe.c
> @@ -47,7 +47,7 @@ static const char * const bench_uprobe_usage[] = {
>  #define bench_uprobe__attach_uprobe(prog) \
>  	skel->links.prog = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.prog, \
>  							   /*pid=*/-1, \
> -							   /*binary_path=*/"/lib64/libc.so.6", \
> +							   /*binary_path=*/"libc.so.6", \
>  							   /*func_offset=*/0, \
>  							   /*opts=*/&uprobe_opts); \
>  	if (!skel->links.prog) { \
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

