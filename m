Return-Path: <bpf+bounces-54217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B1A65A8E
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A461896391
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BDB1B3956;
	Mon, 17 Mar 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePmGmhB1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E01A2860
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231786; cv=none; b=JojwYGfwqY3omQVMBMUlvCKVIzZqCpjilt/F2O19S09to+SZdBQDf+bukWNzhNvdmKIj+YVlRiznms+4r9lXQfbvZM7yvpRtCq1McnN06RyMoKkvf5oqJuX1A5ZlS+SUNjVMrTke+3cswShpgzbjs00Ge59r0mCg2lY2+6TaliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231786; c=relaxed/simple;
	bh=y6+fLLQ7kbH+0CzU5m2E0zr82FtMW+14mkUqDwtuBgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4SxoGJ+paaUtXFrpDUlPdiHXalBi/5xS5JO6VrAxnwIi9xRJeoo6D/gorz3q1n0awRY0meTi+jygb7WDRISMZLudGlf+KNk7SNS26RV+1iYUP07zk5yrbaiHjVni0a8JARelWptMb358Sj6d5c+R9WhTGt/UltuNy1hGuBJyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePmGmhB1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242ac37caeso9125ad.1
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742231783; x=1742836583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfFvXsXXQ4EwlZ+MVnsfd4i68TdMbHdFmvhxBUmT1PY=;
        b=ePmGmhB1uKNtuXQYhldQphoFZOkE7v9H9pgnT+SuGwLzzGvJmpDJ7NpdnEPMBeFD9f
         /eXbdWbyZExF0FhHz2NEBzuhr0vWEfb0n0qtKKF5BA9NZeuGHIT/9nSuDj6825oao94L
         C8+EqVtGvfovKmAIfwQp4FHWXeQ3vnZvrTcu/mH6C0HrlOJZ5iPNNXyxk/gg/FoaAVQT
         By9Rf7VNpwXbHt70fFNdM7mk7lFvnKV418JkisPm8ELeRBYUF+N+5VeAXkSQQO0dpCYe
         VJflBM+h+a5lLmEqVW6fBnkJ1bySyPW9cruMx06RLN89pmQq3Ur68ifMDyTxXuU5nAwj
         K7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231783; x=1742836583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfFvXsXXQ4EwlZ+MVnsfd4i68TdMbHdFmvhxBUmT1PY=;
        b=PMJxK0CEiyM4UNVAEiguoYOPW6A0oYOuiVMPjF3BaF61GCt0vEe1izITQ2rv+vfVtX
         ppYqeCOwTZ/nXy5IJOMEA+AbGu2h/jUf04tolX9wstW0FCYgyxVzkBOwo7K/gAaJTPpa
         A1XYiUpGG04rQREjpXhwb4l6bXbe7Q67rWv2gXwXCaLCt/ET/LfRh6DGgFLUlih8fGIK
         PYMadysVr/pB++gitu2PCu7LWh4A9bq8S2yO7wpvUUvr7SAUAcXc4RVeHke0Ek14hvsp
         QLvKAnpKXucTbudduyhvxOFsiTIVSkexWkCrq7FpJNhkCDrcCdYMdl/Bg/JjvVDFJ4uC
         GxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJX6QuPyXuAzzaoo8KBvmzPyOC3LAu+wWJz9nRlWq+0Pk1fVqeRkEFj8cF3KQtxCZWYdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYNm45XDt22WVc8WJDziAxVhw2jvTe2fT4GYMrir/idgK4x0A
	8+f2/adireW+2Mj4uHEZmmWxPUbaXme4+1ap0ld/9CpN3s7vfqm/1sNzXpL7ZagjabkEuAuou9e
	uRBl+YD7qQjp7Ovp4ZikXwna6lOg0Chx4qR0q
X-Gm-Gg: ASbGnctVEtAQ3j+kAL/Vxl3oy5A8PXYW8zsJlr87koUKFlXqTGKf/hyhE//a8Pa/N5Q
	9uQ8jDOb3I8nSioaLTq2vuckZdWigJq3OCyLBeD5hgqHXRDGBBIMOhBTR5sHRr2M7rvRJuijiCC
	NRC5oH6zjdtOVzSyOaoA4qA8nKTO9j5xaPzbBACHio5XCWOZuvyHZyZrQ=
X-Google-Smtp-Source: AGHT+IFhZ062stJ/0U82tGKw9QwiiDMz/O63ruW8fttZu4gPEgpShZspW4XGSrAF3kxnv/LvZFzzf24xhBBDXgeBowk=
X-Received: by 2002:a17:903:2441:b0:20c:f40e:6ec3 with SMTP id
 d9443c01a7336-225f3eb1adbmr4633195ad.22.1742231783195; Mon, 17 Mar 2025
 10:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzpfAUi8zeiFOp@x1> <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
 <Z9hWqwvNQO0GqH09@google.com>
In-Reply-To: <Z9hWqwvNQO0GqH09@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 10:16:11 -0700
X-Gm-Features: AQ5f1Jp2d5UNDltp-P8jxNkRsUA61xne765QTZDlm7pFAHdCAdLEjY7qowx3yLY
Message-ID: <CAP-5=fWCWD5Rq5RR7NSMxrxmc1SUkK=8gg+D-JxGOgaHA7_WBA@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-devel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:06=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Mon, Mar 17, 2025 at 09:10:29AM -0700, Ian Rogers wrote:
> > On Wed, Dec 11, 2024 at 7:45=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > We have a tools/build/feature/test-all.c that has the most common set=
 of
> > > features that perf uses and are expected to have its development file=
s
> > > available when building perf.
> > >
> > > When we made libwunwind opt-in we forgot to remove them from the list=
 of
> > > features that are assumed to be available when test-all.c builds, rem=
ove
> > > them.
> > >
> > > Before this patch:
> > >
> > >   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=3D/tmp/b feat=
ure-dump ; grep feature-libunwind-aarch64=3D /tmp/b/FEATURE-DUMP
> > >   feature-libunwind-aarch64=3D1
> > >   $
> > >
> > > Even tho this not being test built and those header files being
> > > available:
> > >
> > >   $ head -5 tools/build/feature/test-libunwind-aarch64.c
> > >   // SPDX-License-Identifier: GPL-2.0
> > >   #include <libunwind-aarch64.h>
> > >   #include <stdlib.h>
> > >
> > >   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> > >   $
> > >
> > > After this patch:
> > >
> > >   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
> > >   $
> > >
> > > Now an audit on what is being enabled when test-all.c builds will be
> > > performed.
> > >
> > > Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind d=
evel files by default")
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: James Clark <james.clark@linaro.org>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Sorry for the delay on this.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks for the review, but I think this part is used by other tools like
> BPF and tracing.  It'd be nice to get reviews from them.

Sgtm. The patch hasn't had attention for 3 months. A quick grep for
"unwind" and "UNW_" shows only use in perf and the feature tests.

Thanks,
Ian

