Return-Path: <bpf+bounces-58388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FAEAB96CD
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 09:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005E4501A70
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB27227BB6;
	Fri, 16 May 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeXQZuaf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C9229B23;
	Fri, 16 May 2025 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381714; cv=none; b=AoylL5EZQE09byIoXqFregTE4RSnn8fHblZnFo4Ri1nr+/E/Zbe2siDjlOcCWBUownrhubMw72fG5uw9pCuQ9GhXwNyB8lBGWrCKcQuvwVQdyOp07a7LXvnoKX/a+STWNLLVIYjxLYZE/9k9mFvJWaIyFhnDpPeeIc4zW5CPb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381714; c=relaxed/simple;
	bh=yJ4eeh3gaJOcoU4+afEl+yxc4psLx6TXSfoqGfCoUvk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pps2u6O4CMJ7QaGIEFkyTbgcevP+Rxoi5S5//WWSzqRjJShbWUuLEX2EQ+o12gWIx2M+7QR+9/Q3+CknHPHysB7NCgDQkGW4GXNLC5oCYoWyA/N9KrwjL7oN/gLwHsQCH9sMl9p2OqXBLr33cx8lNS1xkyWcQ0gVlb9c7hl5nSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeXQZuaf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so1044052f8f.1;
        Fri, 16 May 2025 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747381711; x=1747986511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zj81kqK8affdtjubv87y2JDhLX7IQ97jJyY8iNhrq0o=;
        b=EeXQZuafi71fZywGEmb1yf3iDP3P9RYpfMEqo16D7AI+yvqc5mzx7rDDwmNQFa+bfp
         9PlZ7a5pvu6Rft3kl7W6SDkl3UUxQeyfAOWRifSrkvbsJOnDkJtMj3XPBH8dat1MJDc/
         /ku1JH1aEHiOZnbXXUcNAo2zrQmRW1muUV+WY45dV2CtPu6Syz06q9ygHsoWe7MV70ME
         oB1qa4sIpHwslcHQlXMmzbFcH5Fl2pPaPJYGXnEFcTN1T4K2FNkXn5yE3QYyMCg1/wTr
         dtoUQjtu6LPIkfmOVsSFUeOFvmGAY7uDhPLoGr7GT9dhYuc6KnxXAFmsE7Byw4K+z0jT
         e8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747381711; x=1747986511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj81kqK8affdtjubv87y2JDhLX7IQ97jJyY8iNhrq0o=;
        b=LA83cHFK2XdtD69TLIabhB/ttB/9qpq7DfcFfeEM8OaKnMss1NYvKcFv6o4v8KQWki
         fDoNXcL5OLX3LGNsxt4PwykOtJBrNENmPXqThpIUH9WNjzQCz5qXrrtrFGEbRChJNvJg
         KeRpzk0wyxEfhiVEipGaFQr2fth1FyV5ZVF+4a5CZ/8i5pA5ja4L2fklsBE34CN7EA/f
         EvbNiyz3NemzfUtylPtj/eD25FX5cGp6sY3etel30uQs8RZ+Yp07o/lBlpGpMvv2ZlEx
         Y4HG3fp5HW2bWlVajHAppd8MtHCfqERykbRcG2F/tgzGYMMY/+s2qptSdmAxkEutEzXI
         nR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhP6UcTzeD1Fuoi5cJCkYB+e3Wi3HbRsin6upDKhTODtHBojx32BniLGs/EsbcCIcWjRV7qFG1ZXBFDiQ2@vger.kernel.org, AJvYcCVQ5RuBSKojyRnxAYH6KI13kk+Jeq2bQRPITBFFfM7LZf4+qpR+PRN4KJQKeusBU1NhMsfVe5Hi/canzeP5bQcjWrDv@vger.kernel.org, AJvYcCX+D4MNjUTZ3L2p1OxeNoawDMqMYcJTEul6i0hRHw9yewGPuO066q4sZ/CTGYUDSnaw66U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwszpG4zhOMuJ07F4m3khvooc0hFNs5XYhVFnWYB2E9uEipBR/A
	xBUIfHLKXzbKNMM9tmuxCNlpw/Lfvjraq6cAt/zY0sgKPBfV8c3RH8WR
X-Gm-Gg: ASbGncvdl9vmd3Slmj/TQ2yWV8kwlDKHa8BM/xO7V4KKJ+wxtDEdFtZ7DRsunxrwTa+
	NcAmSFt1hg6XFABuaWWyvt38WVm4Pk3X89PJh1xNvLgJ/f5SFaGfmI2S+EY0cC1GJBtcLW0ijyi
	xisDptwd+vhqwRq/R/hWjELKp4o5CgjLJ7uUuS6yfqX6QX2R+Gym88CyCbtBZQ7YG87o5ONA5gh
	6KqY4OY7vvShqIJX3Iqx93+wa/g9eUlGY7ALteRZA4BkgfpG4ufS+rP0zOAq/O1CoBJQSvC5sgd
	hJDvPXd4QxFHyA+iQ10YTo0W5epL88CcMEtnjTbG2qnR
X-Google-Smtp-Source: AGHT+IGHTU82kXZx6lIN7IxPuoTuMuTDQwYaf4gBEapadFPqcunG55jLDUgKzk0cTALdy1+y7y5BeA==
X-Received: by 2002:a05:6000:228a:b0:3a1:2df6:822c with SMTP id ffacd0b85a97d-3a35fead9ebmr1200262f8f.31.1747381710912;
        Fri, 16 May 2025 00:48:30 -0700 (PDT)
Received: from krava ([2a00:102a:401a:bc81:9db7:192e:9f02:9c0c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdcccsm25151935e9.6.2025.05.16.00.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 00:48:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 May 2025 09:48:27 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 15/22] selftests/bpf: Add hit/attach/detach
 race optimized uprobe test
Message-ID: <aCbtyzGX-5UPjiaL@krava>
References: <20250515121121.2332905-1-jolsa@kernel.org>
 <20250515121121.2332905-16-jolsa@kernel.org>
 <CAEf4Bza3cd5cMRvouUiVNrt5MRU4Nhpo7i0KEy1Gm5DTgOFszw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza3cd5cMRvouUiVNrt5MRU4Nhpo7i0KEy1Gm5DTgOFszw@mail.gmail.com>

On Thu, May 15, 2025 at 10:31:28AM -0700, Andrii Nakryiko wrote:

SNIP

> > +static void test_uprobe_race(void)
> > +{
> > +       int err, i, nr_threads;
> > +       pthread_t *threads;
> > +
> > +       nr_threads = libbpf_num_possible_cpus();
> > +       if (!ASSERT_GT(nr_threads, 0, "libbpf_num_possible_cpus"))
> > +               return;
> > +       nr_threads = max(2, nr_threads);
> > +
> > +       threads = malloc(sizeof(*threads) * nr_threads);
> 
> leaking this? maybe just use `pthread_t thread[nr_threads];`? or alloca()?

ugh.. will fix

> 
> > +       if (!ASSERT_OK_PTR(threads, "malloc"))
> > +               return;
> > +
> > +       for (i = 0; i < nr_threads; i++) {
> > +               err = pthread_create(&threads[i], NULL, i % 2 ? worker_trigger : worker_attach,
> > +                                    NULL);
> > +               if (!ASSERT_OK(err, "pthread_create"))
> > +                       goto cleanup;
> > +       }
> > +
> > +       sleep(4);
> 
> 4 seconds... can we make it much shorter and allow to define the
> actual runtime with envvar? So for thorough testing you'll define
> something multi-second, but once things land and settle we can run it
> for 100ms at most and not slow down CI significantly? All these slow
> tests do add up :(

ok, makes sense

thanks,
jirka


