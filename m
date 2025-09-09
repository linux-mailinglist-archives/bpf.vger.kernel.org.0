Return-Path: <bpf+bounces-67866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5EB4FBB2
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CB47A5A0C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921B33CEB3;
	Tue,  9 Sep 2025 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxgA3kkr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923933CE8A;
	Tue,  9 Sep 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422135; cv=none; b=DSDv0PFof7Nj5pSckE11+DmkPuD3t9u2V5SYQDmj66pP/LRFr+WZMhRsLG3E0iATern6BZ2wJomOqnWd93QCnsq3ImXA3NNclZuaaDbSVd+rfg5OggScuAAMY1HmrX/Ua9U9CjpUK2OAj6bPvGamCEy7vclru/AH9ty/23vrFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422135; c=relaxed/simple;
	bh=+JMovtK9qa9KEq5NZgWWnT3tGAs3RwWeeUf1gpYqEv8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz+kRkaMlOiD0/jxkidRwbqwjAEi+AY9cneEXy9MugKaEh+UBV5jry48EmH5L1UZ7dpxPVHHHQ3UVeX0Os3poL8C6XTWOGxo7qH7RnJzGBSE8cmWqyXPHFg2AwiySnycfdhlSh3s7t/8kPETGyftmOmPsA5WcOm9snhQHEif9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxgA3kkr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dce6eed889so4387340f8f.0;
        Tue, 09 Sep 2025 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757422132; x=1758026932; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pAPLfkkPj67rHhBhVqzI9PsMjjg5E3qJ7gcxueQzy1E=;
        b=hxgA3kkrQp9ZgvKDFmFDFfa5siQmdD0poM31cINBvQt/1Hy5fpdEqHdlHp8pobQ2Vi
         JtgNGtGknkb2a1/hl7VAXwkpts5Pa+e3Q2IfwPWLmf2pzG7Pd0AhLDfDPTMaVOVxgcCg
         8+QJ3siLTQXQboScL388yueIPXcK3zh8ZS/CFEefsxI2B1iDE6qcEn3a1KKJJY/hisqL
         HeCaBirKeo+chu9c6w23sbbIMfr7g1lo5pPEtPt5ltAsGk5jGcQJnXXKlJzTgfFvSK2B
         YHcGT6BQ9GxgnsXFIDPp36yz0LzOxMXKc2bzXPoE5sl1ytqpcu4o2VyY4vwHip5kuDSe
         nUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757422132; x=1758026932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAPLfkkPj67rHhBhVqzI9PsMjjg5E3qJ7gcxueQzy1E=;
        b=viL3Dnaf6l++9iEc/vvcVxz5p9juOHfcesHpqedlMGI3Pf8qLfwX4XVVosgVQBhTgJ
         F0MMKeFVgx9MmDlVUcoUjNgdmj+/uizbu4I7NkyvDjFyNKNyl2cN0irIIsZLKOt4KThv
         hUf9o7aDxJL7hQe8k5tD2jDLBemSh+YMHwe2GaIwHh5bZVswVQj/695E93lCZJligcTr
         bUvVGKEwLMfq++ARLqZp2+6ZLnqwPg7UVhOw7Tjyqjslju5rmmgbpaCZSS/hOw5XP4uv
         3DukMYu9Lq3RKONwE2kaMhH024Jmrj48yX3dcrz6nbdb1VmkzDWb+VzSePXMKn02QQ1I
         aoIg==
X-Forwarded-Encrypted: i=1; AJvYcCUWkAkfNC0b/rsm7VZn+PmQRHENURD7B4mlpGj5EOaXZJcOHzFTzjMqFVLSOr2g6Jri8V0=@vger.kernel.org, AJvYcCUnpBpwdVGoF0mZvwfxI2yJVBoX2o8+KlvTO48sp/3nYUkVas/EnJTlv65yNfoOrHcLCHl8KA2GslsVUOon@vger.kernel.org, AJvYcCVxRmgoCgWuHf+5Sw1LvcWcQygU/s+Dv7ZvBv7ELlCED4zAqcnQXfazoeHc/id84zTOYtQkl6UTDQpOnVaxEehwk8k2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoxqq+JNZxAYMq+7JdLcyLy+SlK3y4vPaYw9poqQHzSCQmf6ty
	dfiqv92IqXmjg4IacwvMVq+D+C62kB8VudyE6xerQX/6391CS2Qd+OJ1
X-Gm-Gg: ASbGncv1kKpmtl4YuGYbrH11JqZITeXUu624JIiao65WqDDfzs7ZOadnbijmnoHXojf
	4aoLKH4LnS8YGHDCU8RthqPAcwR7LNyzMKEZBkzSa4/8ymVpcySSbBCEXVh92NFXOqLlCYlTdvj
	GvQngqA2e9PLiZ224v2V5PlZmNe+cntiSojh6wOY2N/AHz/Sb4yq3SuL6Kt4dcR3+0CU8QsVTi4
	bYdijncz6eX/jUSZ453/YK5bwuSfuJAQzY89rI2JmO7yEaKD87+WnlO3VHMymXemAOrRnKJ/OVE
	VH8MZGFUALN+ObBD9T6DGxDc80SSaODi8IQwlZ+ibJepXMJ/0t8kYKzR/ZDHV4F5ot8sd8R08el
	sNBFhemU=
X-Google-Smtp-Source: AGHT+IGc0xGnEdIpwDEeQeQ0CM6RtTnogfjsoF30A9jrLCsnWoMgQOhwiGxBIapBm9YYHXX34EEDKw==
X-Received: by 2002:a05:6000:1789:b0:3e4:e4e:343c with SMTP id ffacd0b85a97d-3e646257512mr9879355f8f.31.1757422132258;
        Tue, 09 Sep 2025 05:48:52 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df15f7051sm9330885e9.3.2025.09.09.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:48:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Sep 2025 14:48:50 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, alx@kernel.org,
	eyal.birger@gmail.com, kees@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	haoluo@google.com, rostedt@goodmis.org, alan.maguire@oracle.com,
	David.Laight@aculab.com, thomas@t-8ch.de, mingo@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Message-ID: <aMAiMrLlfmG9FbQ3@krava>
References: <20250821122822.671515652@infradead.org>
 <aKcqm023mYJ5Gv2l@krava>
 <aKgtaXHtQvJ0nm_b@krava>
 <CAEf4BzYg9jsEK1XdKW4dKFdOSrY4CAspaCAAv6ZJZScHxkHSyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYg9jsEK1XdKW4dKFdOSrY4CAspaCAAv6ZJZScHxkHSyA@mail.gmail.com>

On Fri, Aug 22, 2025 at 11:05:59AM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 22, 2025 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Aug 21, 2025 at 04:18:03PM +0200, Jiri Olsa wrote:
> > > On Thu, Aug 21, 2025 at 02:28:22PM +0200, Peter Zijlstra wrote:
> > > > Hi,
> > > >
> > > > These are cleanups and fixes that I applied on top of Jiri's patches:
> > > >
> > > >   https://lkml.kernel.org/r/20250720112133.244369-1-jolsa@kernel.org
> > > >
> > > > The combined lot sits in:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> > > >
> > > > Jiri was going to send me some selftest updates that might mean rebasing that
> > > > tree, but we'll see. If this all works we'll land it in -tip.
> > > >
> > >
> > > hi,
> > > sent the selftest fix in here:
> > >   https://lore.kernel.org/bpf/20250821141557.13233-1-jolsa@kernel.org/T/#u
> >
> > Andrii,
> > do we want any special logistic for the bpf/selftest changes or it could
> > go through the tip tree?
> 
> let's route selftest changes through tip together with the rest of
> uprobe changes, it's unlikely to conflict

fyi, there's conflict now between tip/perf/core and bpf-next/master
in the selftests.. due to usdt SIB argument support changes

please let me know if you need any help in resolving that

jirka

