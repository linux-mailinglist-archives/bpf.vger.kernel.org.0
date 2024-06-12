Return-Path: <bpf+bounces-31972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AEE905B10
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51FB2873DA
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369B7CF1F;
	Wed, 12 Jun 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JD9QIzGo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DC6BB4B
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217214; cv=none; b=RAKzQEyDGDCKNf+QKxKq6dtXpb8n6tHwmmleyWgm9SLUFDdQ1TLMlxs5H+d8c+8Dic3H9jwYn9lcWB+WmtZkXTIQRjL+YmecEy7HqCXmttaw+jrnaK/6n5zSOYe38QzP5Ti2vG/s+QZkub5D92YuNACWWHZ1x7uI0dn7JC8QHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217214; c=relaxed/simple;
	bh=NNqeYFueEGmiFs0MppMDPJRfzajeEqe5rFYPlwNa4Qw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=h3nQ5VcD5fGjjcfYggt/KyjuIJA8i7wZX3p44Ufusf3ja3UXASjj0VCtzlDE/Ojvpc3QKMLCTq0JX3pvbVkL0hJdk293/KH78RfC05+xjbT/INF+Zqbo4P4CxI0BSwWqhxvPxTqOwyw3pC3ki21XDUJEi/TGZ+u0W2M4bUeQcuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JD9QIzGo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62cec76c2f2so2795287b3.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718217211; x=1718822011; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5Va0kqcQZC3C24SRwLWszsblcvKrIdDi6DATMgrSLY=;
        b=JD9QIzGoRfajXPrqApcGe/gP3YVOTvNVWEg/OBLn5Kinqu0TXfOTC50NadlfSiPw8w
         vSVZKjthcQAeLv22+zLymL1oaYbfft9QHkioisMlqKrpTg1Tk8gaD8Jt7fu8aygq0I6B
         h+sLiP9xU5jfwnCKtmEG85yXOwDL1zk9ybk9Qi3o3oEvQBtY+icz+c10u8QBhZRa4rw/
         09Mz8lSxw/ivg9gPxGHiSMOJY7yUPWOghEmHLdgB7h0ydjMWApbWG8Uf3uFeZeW3JfO/
         ttZm6YX6JBDLhDoJZjLpaD1/RjU/d3teIVpW7p/aaPJeDCS5fFIczx44lwL21wFyFrMy
         jApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217211; x=1718822011;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5Va0kqcQZC3C24SRwLWszsblcvKrIdDi6DATMgrSLY=;
        b=Adp2D0diMZ6zsgeVTxXDBqrFE3rjYq2KRMCaTLZzPdvIXuh6FIz3OcqrZ8XM1WXAe3
         njXCbEt85kr6e6HQq+Gbp0R3NHEpHiPyzCuc5O+zDwjAnTZ0cSP2Pv/1jrMlQCm5YahM
         qKthXFJ+g1+S0sgF29tvyL95IWc30uuVlzdZGL3h8beNMYw4f+7d8DT51LkE0b7Rvk13
         /7LcMLUp4AyEYS0LxaPKQUNhl0JfJyOyfskwQ5my3puQitXB5GhWd5QN0jTvDhU4aG+4
         E/b6B9JEBUyEKtztd4EGNFqbb8Ste/F1REarXObM86HZM/1KaA5cE696Xcha8OJiP3h3
         PsRw==
X-Forwarded-Encrypted: i=1; AJvYcCVLL8KBLMWVTAU+NluEzLht64BFUZ2CRjPQHRS3J6v0SfO7BVhHZygntxlp1Yr26qrAaPkn8021GrWDtV+2830QbwQ3
X-Gm-Message-State: AOJu0YwoDXCKrNkAYTvqdWWw+XTFEpB/VNBRfQ9rIXTUCEs1ER+40Ua5
	mmTCuj6G8Csz+yrrQGyYz/R6g7E/N2goi0jugkD9XGehXzzLltdWjkB4XP1o8gSxUeHSWaiBpzX
	jbxl4gA==
X-Google-Smtp-Source: AGHT+IFUjDHCGs84lPZNlYc/Q/ZUwcsW2T3rfw8kPPl4R6rItL56LbKeXSgs9qEESLh60H5wgpjHWSuTCdXt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:959d:4302:db0e:d12a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b8a:b0:dfa:849d:3a59 with SMTP
 id 3f1490d57ef6-dfe68d0a82bmr656820276.13.1718217211451; Wed, 12 Jun 2024
 11:33:31 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:32:00 -0700
In-Reply-To: <20240612183205.3120248-1-irogers@google.com>
Message-Id: <20240612183205.3120248-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612183205.3120248-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1 2/7] perf pmu-events: Make pmu-events a library
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make pmu-events into a library so it may be linked against things like
the python module and not built from source.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 350b65088fc1..ff1ff1e739b7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -428,11 +428,14 @@ export PERL_PATH
 LIBPERF_UI_IN := $(OUTPUT)perf-ui-in.o
 LIBPERF_UI := $(OUTPUT)libperf-ui.a
 
+LIBPMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+LIBPMU_EVENTS := $(OUTPUT)libpmu-events.a
+
 PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
-PERFLIBS += $(LIBPERF_UI)
+PERFLIBS += $(LIBPERF_UI) $(LIBPMU_EVENTS)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -721,8 +724,6 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
-
-PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
 export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
@@ -730,18 +731,21 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(PMU_EVENTS_IN): FORCE prepare
+$(LIBPMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
+$(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(LIBPERF_UI_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=perf-ui
 
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
-		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
+		$(PERF_IN) $(LIBS) -o $@
 
 $(GTK_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=gtk
-- 
2.45.2.505.gda0bf45e8d-goog


