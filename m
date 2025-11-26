Return-Path: <bpf+bounces-75545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E282C88A28
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C96C5353E9D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBCC3164CD;
	Wed, 26 Nov 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyZ00Fo/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2F2D29C7
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764145779; cv=none; b=YsOvCZGVK0TXmI/akZnT9yfB2ZZ9eb6pSvkDZi0PBku8B8VI89F4DzFxEEEevoZS8lC3/PmcCI6sbKuExWxqsjYrr0yYqrLOdsutP1hqktaHKZCKEqpYB/ADm6GeWj+OFq1cae0LCAYD1MFDrkz4sA1HgLVXDQQjJ0rxklfacjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764145779; c=relaxed/simple;
	bh=Fj/H8GtoC7Lv7YBEqyRgHiGtF6bA+y+/0v3L6P5/oBY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl7/1zWoiPmcukvk4BFs7IGDTcOsWyTWVsPOUCCpBOWgLvLxHoJXv5TuY8D7bla16fuDibPHigavTYOYEgLjiw6xeEuzILGn3j1htwa2efBZk3e52cuLCXQptPzAP/1ht/g6uDZaOObv5++BRMl+PuX5QptuGXT1EesbiARtWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyZ00Fo/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so45036755e9.2
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764145776; x=1764750576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YBiD1eNXL57VH/myk+1e2UVUfOZ7Wljk4dl2rbdSRk=;
        b=eyZ00Fo/VZhIxv9EcAqdyZf6Ok+nDqrpY3WLSr75Qr+OcezyuLnLFB42chYvio+Rra
         u0oBpYh1IOaoTNt8VLE/e+ZwbMjUuh1nE6AxrVCejGYS3Afs98rVAfbz2mVoDP+6FB1B
         L08YhRmnQRLlllhNIom4cQzVzO1x8pWINfcehKzrd46+xYmHtZ+lqwrxLewrWTgPjhbY
         uG1D9FyoLEk0CzMEtNWNIjHalJMijFRPzR6uUH90O++XQkoxFDAZMRUnFadi5ZdNEXTd
         41rzumCVhlfOHSr5RxQoH44wxeutypmeQ/7AztW1KvrTPBzQljzogdbIy6NtBV+9vHOB
         pzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764145776; x=1764750576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YBiD1eNXL57VH/myk+1e2UVUfOZ7Wljk4dl2rbdSRk=;
        b=lDCydMXKRN7Zdmmtevm1f2Pk9apYKB1E80O/ayK7MZV+Mk+QFSmrJfjbEheSkdNkgq
         zadwpOyT3BvYKyPTKQKQAjHtyWWURoteYQnROnpUP31UFd9QDlax2Rjxkh9Ytcdm50Po
         y8Tt61bYKib92pUwwErAGsZ/2zf21lTIfI2E9SS0tHc00t3UahglhYf9ZXjhiFHe8hlf
         c/nozi7iqLJlma6rqLyWf4Zzv136z7ZrI1sE7pMD90YISiQ+w6BKtuuZRePUCX5vZgfm
         rVFwWPr4kHsZ0Q60H+ORzQdxY5RxtNC3cm1oYEC2avFv20u//gtrng+2Gj1GG8YrNsIW
         Tdgg==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZsjcOfX6pYfnpS+dEKPwEohlWiqfua3K+OEeb+jFz7X3XMxWwvZmrAFnyQJHCPPb8sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jFCx8FPClTS3cBMKpj6XQD+yYGBqXk+m+tniFne5juynZrwR
	zH/REDC3TDeaRCU2rcerCAMbBUjmNRfMg1+a5xuvAxbUq+n0OjxuLncm
X-Gm-Gg: ASbGnctT6DjI/qkT5QZOA9puX2OnelbX+hP3EsarzR92Rzwe6t6pgkuvZBJsemhbLg3
	YkqrwTmm2u5bepvB+4ynDJxbxHdnrJcymqNtrfGzwZcNoRh1Lu2PohUSZFWayAiC7wc73F50oRb
	olmK462qjz3mXdSbAiowgVk/Q9JbF61IezLC3aaWT9qCoAc9/JNBELzrCI1VGl/DmFAP0uEIhB3
	Gvuqje/Ktki6sIFZa/RIZ9txTJK2OWBSW4bO7lkVRbnJ2FEzt++fx0z0dC9iVvOVPn9IPfqCFVi
	Yny34QfDbnSIJClWCK+AihuygFyWdyRH3zDCINIMbKxZ5+xevCSY9IWMVw1/ivuyfN9mc+hx5K1
	PvAYm8cNoMXzcLYhpjLtGxlJwsDHRmhJYpQ8A0gjy67UzdlHVqcfgvAx0Sw/5
X-Google-Smtp-Source: AGHT+IGtL/u/j9YWsyVWNlFi4rIReU+8tAA0EpazadN9+phB7KRu8ZYycmV+h5JEOdRiOCEneJ6XkA==
X-Received: by 2002:a05:600c:354e:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47904ac4380mr49638245e9.5.1764145775525;
        Wed, 26 Nov 2025 00:29:35 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adf0b2asm28932705e9.11.2025.11.26.00.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:29:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Nov 2025 09:29:33 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add test for checking
 correct nop of optimized usdt
Message-ID: <aSa6bdRQ29wqu_zZ@krava>
References: <20251117083551.517393-1-jolsa@kernel.org>
 <20251117083551.517393-5-jolsa@kernel.org>
 <CAEf4Bzb1Du11wwUK=qXeWi0V-nN7qc7VsomGiaOM_8eSH2oHtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb1Du11wwUK=qXeWi0V-nN7qc7VsomGiaOM_8eSH2oHtg@mail.gmail.com>

On Mon, Nov 24, 2025 at 09:34:45AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 17, 2025 at 12:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that attaches bpf program on usdt probe in 2 scenarios;
> >
> > - attach program on top of usdt_1 which is standard nop probe
> >   incidentally followed by nop5. The usdt probe does not have
> >   extra data in elf note record, so we expect the probe to land
> >   on the first nop without being optimized.
> >
> > - attach program on top of usdt_2 which is probe defined on top
> >   of nop,nop5 combo. The extra data in the elf note record and
> >   presence of upeobe syscall ensures that the probe is placed
> >   on top of nop5 and optimized.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/.gitignore        |  2 +
> >  tools/testing/selftests/bpf/Makefile          |  7 +-
> >  tools/testing/selftests/bpf/prog_tests/usdt.c | 82 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/test_usdt.c |  9 ++
> >  tools/testing/selftests/bpf/usdt_1.c          | 14 ++++
> >  tools/testing/selftests/bpf/usdt_2.c          | 13 +++
> >  6 files changed, 126 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/usdt_1.c
> >  create mode 100644 tools/testing/selftests/bpf/usdt_2.c
> >
> 
> can you please add a simple uprobe benchmark so that we can compare
> nop1 vs nop5 performance easily? See below, I'd actually force nop1
> for existing test with custom USDT_NOP override, and assume nop1+nop5
> as a default case for nop5 bench.

yes, will add it

> 
> > diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> > index be1ee7ba7ce0..89f480729a6b 100644
> > --- a/tools/testing/selftests/bpf/.gitignore
> > +++ b/tools/testing/selftests/bpf/.gitignore
> > @@ -45,3 +45,5 @@ xdp_synproxy
> >  xdp_hw_metadata
> >  xdp_features
> >  verification_cert.h
> > +usdt_1
> > +usdt_2
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 34ea23c63bd5..4a21657e45f7 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -733,6 +733,10 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
> >  $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
> >         $(Q)xxd -i -n test_progs_verification_cert $< > $@
> >
> > +ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
> > +USDTX := usdt_1.c usdt_2.c
> > +endif
> > +
> 
> why not compile it unconditionally, why complicating makefile if we
> can do x86-64-specific logic in corresponding files?

ok

> 
> >  # Define test_progs test runner.
> >  TRUNNER_TESTS_DIR := prog_tests
> >  TRUNNER_BPF_PROGS_DIR := progs
> > @@ -754,7 +758,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c               \
> >                          json_writer.c          \
> >                          $(VERIFY_SIG_HDR)              \
> >                          flow_dissector_load.h  \
> > -                        ip_check_defrag_frags.h
> > +                        ip_check_defrag_frags.h \
> > +                        $(USDTX)
> >  TRUNNER_LIB_SOURCES := find_bit.c
> >  TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read                          \
> >                        $(OUTPUT)/liburandom_read.so                     \
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index f4be5269fa90..a8ca2920c009 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > @@ -247,6 +247,86 @@ static void subtest_basic_usdt(bool optimized)
> >  #undef TRIGGER
> >  }
> >
> > +#ifdef __x86_64
> > +extern void usdt_1(void);
> > +extern void usdt_2(void);
> > +
> > +/* nop, nop5 */
> > +static unsigned char nop15[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
> 
> nop15 is a very confusing name for this :) nop1_nop5_combo ?

ok :)

> 
> > +
> > +static void *find_nop15(void *fn)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < 10; i++) {
> > +               if (!memcmp(nop15, fn + i, 5))
> > +                       return fn + i;
> > +       }
> > +       return NULL;
> > +}
> > +
> 
> [...]
> 
> >  char _license[] SEC("license") = "GPL";
> > diff --git a/tools/testing/selftests/bpf/usdt_1.c b/tools/testing/selftests/bpf/usdt_1.c
> > new file mode 100644
> > index 000000000000..0e00702b1701
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/usdt_1.c
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Include usdt.h with defined USDT_NOP macro will switch
> > + * off the extra info in usdt probe.
> > + */
> > +#define USDT_NOP .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00
> > +#include "usdt.h"
> 
> upstream usdt.h will use nop1+nop5 on x86-64 unconditionally, so I'd
> invert this, and *force* one of the cases to a single nop1 with custom
> USDT_NOP, wdyt?

ok, it's basically what it's doing now, just with the extra nop5,
but I agree that having just nop1 makes more sense

thanks,
jirka

