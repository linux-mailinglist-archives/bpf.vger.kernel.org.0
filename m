Return-Path: <bpf+bounces-54368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E807A688DC
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 10:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778768A12CB
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFAA256C98;
	Wed, 19 Mar 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOkLejXc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515FF2566CC;
	Wed, 19 Mar 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377666; cv=none; b=b8ZxWM4dgHgNUnoTvpT6b2u9iNJiuitpUCLNsBbuIp2Lj7QvTv2i5qPCHfZbbsdxH6OpHldZAyMc+Nn3SPkfYoXS4CM1t3mhi/nZdTOnmSHuR0L1zqCOn62HJvxVQIvT6KbB42aiDTn9MPDY02jSyziNwuWPYtP6+MzGWzLQSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377666; c=relaxed/simple;
	bh=GEjYP46691TzJJ8gbfyakXZjQK5z9OmyqU3rVbxsGmw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu16uhX5ft8qEgk7h6rx2MhPu6zcBCvxwD+jX/TqLUk9/XSUZ7GE3llwjgoz4PlBTs4YHVnfVcOv0Zi0zQQEdjcQVxMaT64MAWXEQq4VLJBLzWuO7wwTph1evL8GOK9w7NMpeL7jFJyIlm3kbsPXH5t2UPKrXG4XLkRDOBGndIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOkLejXc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso31105465e9.0;
        Wed, 19 Mar 2025 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742377662; x=1742982462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2NZ23mVd1n9qSytnKBZpLN6PwJEeGdSdjRzESloq8e8=;
        b=QOkLejXcWe01/J0I8RRG/trYJlGKf8FBe86lNHGxfOpKau/CdkSGWZtVgs8BPN25/Y
         6C1KaIw2GtIrDzOx8KQfQ5vpJfLNkgVxeCaPJlXwE7enRem2pbUxQHXWHHL+h+395QRE
         djK+8BeHfgz+C8w3QozzdBaey9CvIyDl7SlMeP4InCsPFmNEG+6fiaJSpkBFq4B5YGmG
         Amx6+r7lzi2hL+B4lBmI0Iukkm+/pb168UVzqq+thV3ExyC4uNXFX6+gA3vyad/sPRoP
         86mjEJc88sK/y7O0rsaZJHXA4KoWwF08BB43CAmDIV1n3TuoHKJKVpaSQu5Adqt6aGVg
         ioGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377662; x=1742982462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NZ23mVd1n9qSytnKBZpLN6PwJEeGdSdjRzESloq8e8=;
        b=AdrueQLVJH+0V1BefNeEhHO7W/yq21KvkS+XzPg8ntG+JMePb+yWWWtAAo216IsXMe
         ign4i6z7qAGG9eq7TpnWScfxycv81lvP3tial0A8yTaAHirU6XlHCy3ZL1t3/oaPU8o9
         eS3ghjCLBRQELvaSEZq55MRbCTiH2mjIDrkiSm/cFlrpNp836v/DxOWrnDBHYOmiDbUJ
         MnxqK6U5w/p46t2OKO5dGlkAEoZm3bcHDtfJsLTCQFRcuIe0+0JKfedmy+N9qEoLJ7St
         dgjicMBctsUojGG7fZGg/MIrQNSmNKEfOjgf+sfKoJQPfhVMT4/1RT+nRboATHljP7+n
         1pWw==
X-Forwarded-Encrypted: i=1; AJvYcCUoWCJZsTzYRHLW+ByOiqGnvZa2yuWH0ZCl/lZiLGo83nwWqENKyJlKiR0HOaq5hgwW1Fk=@vger.kernel.org, AJvYcCVEcEcvoPx0wiZHej4qC1tE27+RiIw9+4BQ6K+RbAMYfZHlWlvmvhuVTy4yKXeBjcFZCPE07XtCmzcL47hYh4nhDsM=@vger.kernel.org, AJvYcCVPEqLj7kSVhziFP1phmpa93p9lgs9HklOjKph1sHZEnWEScLUj9CeuGn4imZWj5S4C3phVu03l3PA3QvUH@vger.kernel.org, AJvYcCVg7JwYX78eaOO1zVDS8gc2nc8t6j8VcL0ZaVBEt7bHDRhw+GtcAxTo7dXSFa8ehYnfj2FL+WJ1fP4MsuS0fXLEGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzotYN2Niwm0UDdwih3D8yqaWkyTqwId+BKR6uSNs2QKp0z8gPz
	7iQozPuYVporF9bL7WDan2P8fA4hMYTTTwlnYEyM/cIk3kjEfrNu
X-Gm-Gg: ASbGncsJghSC+Gpbo5PbdOnvXjPKms1Zo1DG3NTNao7ZzYXwe2uWH4ufRn9cvxOeAV6
	iGEl9+zl+cceS2pbU6g+T08nzWbc9p5YNVBABsuUBSMeqgu3GcewqceDWmzUY8ZzySsshFWRh/i
	N62Tp43KTIrqdhtM2mae1eQHif65/vm0n21nBHs+ZYFmMid6n3MkSP8uMYAnJcoqnwNNyxR5g01
	uxCuj/U4BY1IPUmVv6FvpbpulzruaM9CV2+HeXNhS2EN4o/5aHQYn+0HDyf0yh5ETV+O7bEYBHG
	9krxSHFvE/3GwESPyJJDK1I8OKDsLus=
X-Google-Smtp-Source: AGHT+IF4OvZGanUh1jWZlL5uEktGdGZ5zMVRYf9shgP8va0gBvYxVKRQVQGxiDCBfvtWURNFZmoTug==
X-Received: by 2002:a05:6000:2c7:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39973af9236mr1303964f8f.36.1742377662183;
        Wed, 19 Mar 2025 02:47:42 -0700 (PDT)
Received: from krava ([173.38.220.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b09sm20832843f8f.57.2025.03.19.02.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:47:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 19 Mar 2025 10:47:40 +0100
To: Namhyung Kim <namhyung@kernel.org>
Cc: Quentin Monnet <qmo@kernel.org>, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
Message-ID: <Z9qSvGTlMCzktlZJ@krava>
References: <Z1mzpfAUi8zeiFOp@x1>
 <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
 <Z9hWqwvNQO0GqH09@google.com>
 <CAP-5=fWCWD5Rq5RR7NSMxrxmc1SUkK=8gg+D-JxGOgaHA7_WBA@mail.gmail.com>
 <c4f4a1d0-aed8-4b09-a3d2-067fdd04bed3@kernel.org>
 <Z9oHGfAffX2Bfl7a@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9oHGfAffX2Bfl7a@google.com>

On Tue, Mar 18, 2025 at 04:51:53PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Mar 17, 2025 at 09:19:22PM +0000, Quentin Monnet wrote:
> > 2025-03-17 10:16 UTC-0700 ~ Ian Rogers <irogers@google.com>
> > > On Mon, Mar 17, 2025 at 10:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >>
> > >> Hello,
> > >>
> > >> On Mon, Mar 17, 2025 at 09:10:29AM -0700, Ian Rogers wrote:
> > >>> On Wed, Dec 11, 2024 at 7:45 AM Arnaldo Carvalho de Melo
> > >>> <acme@kernel.org> wrote:
> > >>>>
> > >>>> We have a tools/build/feature/test-all.c that has the most common set of
> > >>>> features that perf uses and are expected to have its development files
> > >>>> available when building perf.
> > >>>>
> > >>>> When we made libwunwind opt-in we forgot to remove them from the list of
> > >>>> features that are assumed to be available when test-all.c builds, remove
> > >>>> them.
> > >>>>
> > >>>> Before this patch:
> > >>>>
> > >>>>   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=/tmp/b feature-dump ; grep feature-libunwind-aarch64= /tmp/b/FEATURE-DUMP
> > >>>>   feature-libunwind-aarch64=1
> > >>>>   $
> > >>>>
> > >>>> Even tho this not being test built and those header files being
> > >>>> available:
> > >>>>
> > >>>>   $ head -5 tools/build/feature/test-libunwind-aarch64.c
> > >>>>   // SPDX-License-Identifier: GPL-2.0
> > >>>>   #include <libunwind-aarch64.h>
> > >>>>   #include <stdlib.h>
> > >>>>
> > >>>>   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> > >>>>   $
> > >>>>
> > >>>> After this patch:
> > >>>>
> > >>>>   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
> > >>>>   $
> > >>>>
> > >>>> Now an audit on what is being enabled when test-all.c builds will be
> > >>>> performed.
> > >>>>
> > >>>> Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind devel files by default")
> > >>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
> > >>>> Cc: Ian Rogers <irogers@google.com>
> > >>>> Cc: James Clark <james.clark@linaro.org>
> > >>>> Cc: Jiri Olsa <jolsa@kernel.org>
> > >>>> Cc: Kan Liang <kan.liang@linux.intel.com>
> > >>>> Cc: Namhyung Kim <namhyung@kernel.org>
> > >>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >>>
> > >>> Sorry for the delay on this.
> > >>>
> > >>> Reviewed-by: Ian Rogers <irogers@google.com>
> > >>
> > >> Thanks for the review, but I think this part is used by other tools like
> > >> BPF and tracing.  It'd be nice to get reviews from them.
> > > 
> > > Sgtm. The patch hasn't had attention for 3 months. A quick grep for
> > > "unwind" and "UNW_" shows only use in perf and the feature tests.
> > > 
> > > Thanks,
> > > Ian
> > 
> > 
> > Indeed, bpftool does not rely on libunwind, and I don't remember other
> > BPF components doing so, either.
> 
> Right, but my concern was about the feature test itself and the related
> changes in the build files.
> 
> Can I get your Acked-by then?

hi,
I might be missing something, but I see following commit in git already:
  b40fbeb0b1cd tools build: Remove the libunwind feature tests from the ones detected when test-all.o builds

jirka

