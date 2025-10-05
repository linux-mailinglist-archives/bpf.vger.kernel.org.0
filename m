Return-Path: <bpf+bounces-70402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA16BBCC43
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353853B8A94
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 21:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218082BE03D;
	Sun,  5 Oct 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXg33RJl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3662BDC19
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699344; cv=none; b=qcBDMTukIUMXDjZvzQrihr9wxjB4VN02VPRfMj9dh5a9OHX7p82tR1oDdRiG9EMaOzAvQX9ofjjsVeJcu9BIK9hYt60FUAkRPhCwczaVA1/WEUuDD3Gt/u//JzDgoLr7ZhmG9ycueZV9u/yZwNU9p4p9GjoSWc/MkGWvIb/vqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699344; c=relaxed/simple;
	bh=/luZGaDcmbSsI2ELFDFE/EBkhdco1hXagnVGpUVsYwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AbgTi1eWY00dodRMtw7kNE9ot0/8m6cJGwYYf5U++5s6X5sz717+IvA30tSeKrNek7sXFzk8WpAXLHQPPDeUZXNinuPQ3GEoy8zDMmZC7czswyRtF2fdD6/02U9/nfUXyb+f5wnOyXGKNAP21jddmFN6+8zljqo4xg/lpCg+sN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXg33RJl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b551338c2c9so2436604a12.1
        for <bpf@vger.kernel.org>; Sun, 05 Oct 2025 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699342; x=1760304142; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHVoU7VdAErJHQsuyUDkFaSuPa656SpDfPesPL1Iw7A=;
        b=IXg33RJlj48b2bkYOpkR0XWqYzep0REFMiUaUYvH9UfvnRQy6a2KIrV1R+tsyO60Yg
         FNKDIFwQpUv7L8CX/e1Oh0HtAeezREx6kOil8bB00vd0unfWmxZ/NOEMxAwTJpUJsNRw
         1SnBASv9l7OlI8NKalSqK5KNYGx7KECqY5/HQ9S2OT7zoj2dB9Yt9hNGHRa77+aks4nz
         WnCmxb6h74FjAFyQVA/Xe4gqrQM9HOmEkFRDGo0nw3jn87wezKvI2qNwT7gYspywh3N/
         /jyWAwZ/weLeDXTasBTTMBCRt5i5tM2PAVe3m95imxNvC4hVxlvQIzDky8LmWSY3ojBq
         uwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699342; x=1760304142;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHVoU7VdAErJHQsuyUDkFaSuPa656SpDfPesPL1Iw7A=;
        b=D3DFNYd+mTbQzLHg/tgiWuOtkEutiRJTKr7Yrc8OSd6pL2AdBzyaiclTNd6rf0o/ff
         jkHtk/7oGIMZ2hbtmeuvkGSOkwA/H8kxb7I6LXnJwLELmEjfP4glQug1oKJHb8f1PVcx
         MJ4f9/XUbeKluh1YGxzybfu2jFuS8pSV0IP05V7BphVRYk/4zYs451KEpnuQ8ooc0YGD
         XkHX+oPObzlcR+Vs2v0Ov4spKU0/S/fC2UHZ//WsBsU983f+4XGf/0hCh6zUYEvHtRiI
         /c0V6XnxIrm7NAlCOMxi9zhoUIidt3Sh/caJMSAD/xrOmA8HVJnsutNN1gYbp4H1qho/
         G/8A==
X-Forwarded-Encrypted: i=1; AJvYcCVIrfO8tAkkGDbG7MqlVZe3k4xSOOYIInZGhuscMfeh/jFmHd4cfYV/8+HpIaFlb2gHovk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxTd/4dm1YCkQucMfOJmqmBTnnF6uJSsv2XeogEQsCkKB5Fuz
	/lYL+Dl+7T44/C5Vf98IkxKKoCBlibphgRnJjxeSj4XULWF6S1G3MpWvsIbhfKxZm0RKSL5uS0t
	d3weEfdZv1g==
X-Google-Smtp-Source: AGHT+IF9xACFD4NCBC8YA4+1DxHgAs4tVBez0mS1xBu199M+awLsaSCkEQ1/ioP2OUdMojXU72RjQE/JWxIn
X-Received: from pjbpf16.prod.google.com ([2002:a17:90b:1d90:b0:330:6c04:207])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e211:b0:240:1a3a:d7bc
 with SMTP id adf61e73a8af0-32b61dff87emr14700817637.3.1759699342575; Sun, 05
 Oct 2025 14:22:22 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:02 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-2-irogers@google.com>
Subject: [PATCH v7 01/11] perf check: Add libLLVM feature
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Advertise when perf is built with the HAVE_LIBLLVM_SUPPORT option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-check.txt | 1 +
 tools/perf/builtin-check.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index ee92042082f7..4c9ccda6ce91 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -56,6 +56,7 @@ feature::
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
                 libelf                  /  HAVE_LIBELF_SUPPORT
+                libLLVM                 /  HAVE_LIBLLVM_SUPPORT
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
                 libperl                 /  HAVE_LIBPERL_SUPPORT
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 8c0668911fb1..9ce2e71999df 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -48,6 +48,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
+	FEATURE_STATUS("libLLVM", HAVE_LIBLLVM_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
 	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it"),
-- 
2.51.0.618.g983fd99d29-goog


