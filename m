Return-Path: <bpf+bounces-36082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F894217F
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DB11F2563D
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82A218C910;
	Tue, 30 Jul 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBqTJiid"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7051AA3DE
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370700; cv=none; b=nt8VHSDJUku8Wb0ai0OFspfBOkcVr6bYCM04VTtzmq9zhPP92Rh41VnIKyhsuGbb/3m5F1wvHz6l1uRW+/W0o037AVczooXabyEQlJBl+J/MaH+HeO01HVrjE3IxhMDJBRSZsD5MNPQLtJDhBiPd1KXU+S5siA2yM+uIDZsrXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370700; c=relaxed/simple;
	bh=C42cIP36MLqvBoxp370ozn/ZfYI4UpAPTben7i0wJEI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAf3EsocOOS3+GO1+lTSV5W+yHZFAMCvoQPrOFcq6xTFOATy/S0As6pVOOn+8PQInYMtZBWX8JHpnbbCfIIvzsaJE11ILATJtY+0qVcQ/oBi/CcGeXZPZjnCl1ZSFPD/N8AV7Lh//Nuz8PQT5i08dpa4owob/FU3WkvcObRt2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBqTJiid; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280c55e488so1413325e9.0
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722370697; x=1722975497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FlhooE7niwo1WBnVupTrKx8b0vXnwiGF9kNI8j5y/Hk=;
        b=VBqTJiidUxh8T24Jg6tuqqtFSuaMjAaJ7jaxq98jv7mPrhfcpr7Bh0Od7RabODh4+N
         rkgULE4OcNg7z88XwiPK9HeLKs7fifMBenWnmQ9QwkYyktenSjayqDVqTzSgxm+u0mB5
         8T7p5c2BQoeuC4ljegJNRkGwp9LdjOJThmHxxRLfJGIZJcGe7shHBeZufzEsPIsayiIc
         LrnkdZki7JsPPvOEbAeOeKyOm2bmTBvoNhRTBtjORIUoDT0ZRCJCeb3Dfcl2bR4MF1KM
         5u5Z9H5sg6+vQgLRXtbcWryHqeh4uiw+FHmcpXEzpS++7GASr8P0L/bF0NRe9W6lmDvg
         L6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722370697; x=1722975497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlhooE7niwo1WBnVupTrKx8b0vXnwiGF9kNI8j5y/Hk=;
        b=hqEo8MycxCRn5U6pOBI8BOU3WX68gzwCnfOMf8g29M5n/s/0jUogJK6Ip3UI8LKPNN
         m6DdS0R5buRLRA7tWIaffmaAezQqiwe0xw3MXLElv5W6yK3cv2Jd0dcdzzfB/ElG6Yul
         s2SNdXOQPhltiZsaQz0T+rjKQJkveB9Q+0otfkYrYNiUmjGzbGvArlINrQbBpDrdZrGx
         S3AyJrIUr9lfSS/XkR4C2ZftCvkERiKF/X6p8Yxoj2nT6LgvSY2O95IlpMrtQiXCDNnj
         v6tHdGwP+Z1tltpWdkTekFXvZZzdre9+rxj0PA+PUkNc5bUcT+rEb1GXhN1uqpKLgggy
         kaWA==
X-Forwarded-Encrypted: i=1; AJvYcCXrNUICjm+WyV3B3Itrzw3w7DMBUKoOKnZxLLBTG8nKewCiovp8mimGGDL4NYlBTbYC5MXBXmXXf2l6aGU/WLmFNu4y
X-Gm-Message-State: AOJu0YwQqW4XIp+98MaB+/41pPK9qQWO/en7WZ5/MXrpn4sXcdhtf9Pz
	oI6tkzz3t5C4KYFgNw1Zi7CJ/tdQKIx6EE/0FIP49cGM/nuBGe8b
X-Google-Smtp-Source: AGHT+IGMm9oFkni0kDXLqhoSNz4U1Okan6JCJTR+tGpNho6VJ6EXoc8DPyxFVyUBjH3zwL/q4i92tw==
X-Received: by 2002:a05:600c:3511:b0:426:67f9:a7d8 with SMTP id 5b1f17b1804b1-4282440e013mr21800865e9.9.1722370696441;
        Tue, 30 Jul 2024 13:18:16 -0700 (PDT)
Received: from krava (85-193-35-46.rib.o2.cz. [85.193.35.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d71sm15335919f8f.80.2024.07.30.13.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:18:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 Jul 2024 22:18:09 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
Message-ID: <ZqlKgdb59gPL6Z3D@krava>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-11-andrii@kernel.org>
 <ZqJBK4loBv030jj_@krava>
 <CAEf4BzZkGur_zPrPCEo6=asFGO1uBShvf1wwEoBhaKk-46ctAQ@mail.gmail.com>
 <ZqOWGvrrubXbVDlY@krava>
 <CAEf4BzbF+Q14fW-z2Fg02AEcFaF+dU53FVpDO_K_Tz-xQP_k5g@mail.gmail.com>
 <ZqaeOl8c_Jwl3ieR@krava>
 <CAEf4BzZtu_LWu82z9RFDf00a77uJuEpqYtuJWqz2zvm8jG3UWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZtu_LWu82z9RFDf00a77uJuEpqYtuJWqz2zvm8jG3UWA@mail.gmail.com>

On Tue, Jul 30, 2024 at 01:03:17PM -0700, Andrii Nakryiko wrote:
> On Sun, Jul 28, 2024 at 12:38 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 05:37:55PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Jul 26, 2024 at 5:27 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Thu, Jul 25, 2024 at 01:03:55PM -0700, Andrii Nakryiko wrote:
> > > > > On Thu, Jul 25, 2024 at 5:12 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wrote:
> > > > > > > Add a new set of tests validating behavior of capturing stack traces
> > > > > > > with build ID. We extend uprobe_multi target binary with ability to
> > > > > > > trigger uprobe (so that we can capture stack traces from it), but also
> > > > > > > we allow to force build ID data to be either resident or non-resident in
> > > > > > > memory (see also a comment about quirks of MADV_PAGEOUT).
> > > > > > >
> > > > > > > That way we can validate that in non-sleepable context we won't get
> > > > > > > build ID (as expected), but with sleepable uprobes we will get that
> > > > > > > build ID regardless of it being physically present in memory.
> > > > > > >
> > > > > > > Also, we add a small add-on linker script which reorders
> > > > > > > .note.gnu.build-id section and puts it after (big) .text section,
> > > > > > > putting build ID data outside of the very first page of ELF file. This
> > > > > > > will test all the relaxations we did in build ID parsing logic in kernel
> > > > > > > thanks to freader abstraction.
> > > > > > >
> > > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > >
> > > > > > one of my bpf selftests runs showed:
> > > > > >
> > > > > > test_build_id:PASS:parse_build_id 0 nsec
> > > > > > subtest_nofault:PASS:skel_open 0 nsec
> > > > > > subtest_nofault:PASS:link 0 nsec
> > > > > > subtest_nofault:PASS:trigger_uprobe 0 nsec
> > > > > > subtest_nofault:PASS:res 0 nsec
> > > > > > subtest_nofault:FAIL:build_id_status unexpected build_id_status: actual 1 != expected 2
> > > > > > #42/1    build_id/nofault-paged-out:FAIL
> > > > > > #42/2    build_id/nofault-paged-in:OK
> > > > > > #42/3    build_id/sleepable:OK
> > > > > > #42      build_id:FAIL
> > > > > >
> > > > > > I could never reproduce again.. but I wonder the the page could sneak
> > > > > > in before the bpf program is hit and the buildid will get parsed?
> > > > > >
> > > > >
> > > > > Yes, and I just realized that I forgot to mark this test as serial. If
> > > > > there is parallel test that also runs uprobe_multi and that causes
> > > > > build_id page to be paged in into page cache, then this might succeed.
> > > > > So I need to mark the test itself serial.
> > > > >
> > > > > Another issue which I was debugging (and fixed) yesterday was that if
> > > > > the memory passed for MADV_PAGEOUT is not yet memory mapped into the
> > > > > current process, then it won't be really removed from the page cache.
> > > > > I avoid that by first paging it in, and then MADV_PAGEOUT.
> > > >
> > > > ok, I triggered that in serial run, so I probably hit this one
> > > >
> > >
> > > you did it with v2 of the patch set? I had this bug in v1, but v2
> > > should be fine, as far as I understand (due to unconditional
> > > madvise(addr, page_sz, MADV_POPULATE_READ); before madvise(addr,
> > > page_sz, MADV_PAGEOUT)). At least I haven't been able to reproduce
> > > that anymore and BPF CI is now happy as well.
> >
> > yes, it's with v2 and I can still see that.. but only for the first run of
> > the test after reboot.. so far I have no clue.. I can see the successful
> > page-out madvise (still not sure how much is that telling about the page
> > being paged out), and then the build id code sees the page just fine
> >
> > attaching my .config in case
> >
> 
> I wasn't able to repro this, sorry. It works very reliably for me with
> your or my config. Given it also seems to work reliably in BPF CI, I'm
> still inclined to add this tests, I think it's good to have that
> coverage.
> 
> I'll monitor, and if it becomes flaky, we'll need to reassess this, of course.

np, I'll try to spend some more time on it

jirka

