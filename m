Return-Path: <bpf+bounces-43967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F29BC026
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084FC1C21421
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6311FDF80;
	Mon,  4 Nov 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uKqG2jrk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C01FCC75
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755979; cv=none; b=VLiTpAEPU0i62EmTA9YVAoVKMg+H3NECCQ+sM5xYtGME31u7PWuM9PrUNDXbrlVyqGKuMf2hNdAQPu/VQGmPXfFp21Py7avGS7u84by/cJCCAE0yO1OrLj0fTR9fPpmHWzmLLYcwzm6qijon/SkpkOLRfIJ49ktihP+k6UbqAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755979; c=relaxed/simple;
	bh=fdBVewMiYACcHTkjuVH8eoAcByaa4rdMJHtffZ8NRzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CirRnbjRuj+EmxV+3d4meLQAPm7pEpHoRjeuDf0v6Oqr206qEzWox9SK2mHT35k72wIh9Pof5LkCUMcFoGn56Ac+z9o75LdG443dTPuv4EUM/LpUGf96erkXPEVHX4oWVqAlhJsXTi/aNTZGxQnMnvM970z5tuCMCLJd0be9LEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uKqG2jrk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-723db2798caso1268276b3a.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 13:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730755977; x=1731360777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EzIIL5jV51s8QxZDArUoUfDkcHu/NNqV1EZULNrSbms=;
        b=uKqG2jrkpUbqp9onmjHwE05Gj/mClK5YVTKtwVC640w8OrdgAtBYJhzbhQ+BndMu5j
         qMcRQfAtI/EgCWGBZhLufrqBlbWL57fGQXTh624wUksdZHq9Mp3unmS7p8RHhT/rFPAS
         En20N+I9K4R2J0+bJ/ofplkIffJjBNNLpzqq8a4E1G3r3aQ0IKG9uBF50TGzax9RFBhf
         ZmyERaLGBfwetqYNL7vLn6PJ2O0rgqgPDtDeItioJ5bXCGhgmJXoG0Li/6AktWNwj39P
         TJfCH3emoc/2U0mowVBjsGTXg+gyAcXCbPENsK1OmLyNfPDzpNhpaEt/4WxLg3k4bxpt
         tvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755977; x=1731360777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzIIL5jV51s8QxZDArUoUfDkcHu/NNqV1EZULNrSbms=;
        b=lrXdRNXmJijRpTeov/njLRL3ql0F5iW7zVsg7iCAI9QtbRaoz0/G1mYwXT0Bh7az4i
         bH3gmU75OQgN2z37/NVSfMHpfo4YTBMujc8PEwY4RwOwlNcgRktLk5Fs58DIBAk7xpm5
         esltZKcV2EFl52CZjy73dBJ3Js0gS6StiH58OnBuM94skcwg5FbhZeP1HiQA0TBzXh25
         do6Ho3sTwzAgOXHdlUd7IKe7mhtWuRB+krHQ4o5M/KA5J/5l/YnPe2kcxbF6/gDWRZlD
         x02QTrrFXzxo2WxQhT8nBEXFNowaEJPGFNzylH5iLIE6yZc9pQeRatFmgtjFQuOEwD73
         i4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUizWx5ZopPdQCS3HUe0bAlFjQEqXzZEESuQCkm6IAOGChGKlcBDkRYnIg61MKr+RFJUak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3JcOft4h5mxCAhKPd8AHujhNtx96InDPwA84qdbnXFLkuKnZ
	cJCVSOrzus1T42IL+zUJ0PGhb1DpSbQ4LdptAbYkbPlRLuu83YEYKXjpIEdq/QQ=
X-Google-Smtp-Source: AGHT+IE1gCnZHDhbNSzOxIsLAwqp2zm4KQPfqsRjT/TyxizeRL+Gzx/ZXVxE+GJ5uzuO8nBhG5XzOQ==
X-Received: by 2002:a05:6a21:9993:b0:1db:d8df:8c4e with SMTP id adf61e73a8af0-1dbd8dfc276mr7417523637.12.1730755977373;
        Mon, 04 Nov 2024 13:32:57 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ef7d9sm8114469b3a.83.2024.11.04.13.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:32:56 -0800 (PST)
Date: Mon, 4 Nov 2024 13:32:53 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, guoren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFT 00/16] perf tools: Use generic syscall scripts for
 all archs
Message-ID: <Zyk9hX8CB_2rbWsi@ghost>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
 <3b56fc50-4c6c-4520-adba-461797a3b5ec@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b56fc50-4c6c-4520-adba-461797a3b5ec@app.fastmail.com>

On Mon, Nov 04, 2024 at 10:13:18PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 4, 2024, at 22:06, Charlie Jenkins wrote:
> > Standardize the generation of syscall headers around syscall tables.
> > Previously each architecture independently selected how syscall headers
> > would be generated, or would not define a way and fallback onto
> > libaudit. Convert all architectures to use a standard syscall header
> > generation script and allow each architecture to override the syscall
> > table to use if they do not use the generic table.
> >
> > As a result of these changes, no architecture will require libaudit, and
> > so the fallback case of using libaudit is removed by this series.
> >
> > Testing:
> >
> > I have tested that the syscall mappings of id to name generation works
> > as expected for every architecture, but I have only validated that perf
> > trace compiles and runs as expected on riscv, arm64, and x86_64.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> Thanks for doing this, I had plans to do this myself, but hadn't
> completed that bit so far. I'm travelling at the moment, so I'm
> not sure I have time to look at it in enough detail this week.
> 
> One problem I ran into doing this previously was the incompatible
> format of the tables for x86 and s390, which have conflicting
> interpretations of what the '-' character means. It's possible
> that this is only really relevant for the in-kernel table,
> not the version in tools.
> 

I don't think that is an issue for this usecase because the only
information that is taken from the syscall table is the number and the
name of the syscall. '-' doesn't appear in either of these columns! 

- Charlie

>      Arnd

