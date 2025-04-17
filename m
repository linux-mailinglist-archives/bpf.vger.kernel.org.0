Return-Path: <bpf+bounces-56201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687AA92DCD
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1593618991EE
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4B254B12;
	Thu, 17 Apr 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lg337xSK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46A22AE4E
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931311; cv=none; b=nKdrgwcciBwGcTU1B9KzL76eOGelIF0zmZDZF6hKzcAWKoxVosUf8NgwQdPcBLgN3kZWdN0STWFTWz6emo539MSVFmqj7EDCMuP08+O38D6NYbRjT+6xcejo5j4O0tCVUJqt3ke+G7JQybNV7TrQZcks5nNuX9LJOtgn7L5/vhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931311; c=relaxed/simple;
	bh=foSoET0IF18/f5J0V+ZIUsKXop/FvoFoqTKnlWhCxVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mxglvFBDmlP1OWct4TN60vUYCW/tHfRDSdscNu8+oNyLGJMCbi1ObD25It4pQ3HBXiw/IIPh4WsrmS2qVCWYQT9jqOceMKQqholw/itpgy04cb0g3/Y4YhYN1m3aJJKA9RQI2uAO2lmCCyKwn379WmILvahvsrkVYpSUE/r8M7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lg337xSK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224192ff68bso12623615ad.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931306; x=1745536106; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ztzt+tF3nTRYCrcDqKNMajzSGAzjCJLiKGSSFxPrQ=;
        b=lg337xSK5nvTDG2CvM+95trPXVKmEFO8unl/6Yo1b50uYKtDUWywDiQD7MWqYj6+81
         r7nDO6RFRB6VOVcL7i41RYYxRudizFuoB7ZtpPA+Mt4hAUzMKDlaVCrMoDlrKqf3Q2xd
         zPdsNrV4c21g+z00IgB2RypGXwjc07XDyniJgZx18TyN5gU22AKHKXY0qrgbrrBge+Ny
         3Mw0zRv/HFid1oulzNk+5jSJZAyF/kGzCdq1mS9h8zmLsdp8pQZFepofHHhjeYswMPLu
         aHx0RmSt7WdvpFL8Ik+Y6VIQtEXNumKHjcudAuOTtEJkUW/1VvdZEox/AT2mddX8iUzT
         +3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931306; x=1745536106;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ztzt+tF3nTRYCrcDqKNMajzSGAzjCJLiKGSSFxPrQ=;
        b=W+8LWrn1rNR8v5IIgvUhx74DkkPDuENoT/pKBJMwSEToB63pKYG4C3Bj6uVISDWCg0
         v0CH7UlDlJha1bm5RKkHhDLPxiBN2uXZ128Ss6iUSlGnSvs1Vk5HWD9lrwsiRtHVzHH0
         HrDwRtdyQN46Df/1UAcofi35tl9nv5MOTGzH1d4cGEfNSO2cDVoMagmZoUq8CuhjGwzM
         qMxlbH6QeO3GqiH4/lBcr10a+S+xn0nR2qYjy53Sj+dzTq3qtq31zEGvk55cq7qxlhtA
         ct4GraCQSZsogK25IbkQDJq3xGE8EtbfdfTVbyD6mNilXj9Ek3pXk2sSAtSkYbXCZVe8
         1yYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD7wWEXcLWl9t0g6bWY3NsHCJa2f6g6N6fbUvAOMG2i2IZ8JddQ3XAll9wHORIvDBqV7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcg8/EwaCHgkQTjJiv1tg8tme7zjQTqM2Xdet3+mCQfnSLEi0Z
	oeSGD/f17x25U1KxP64r62RkrgM9ZhojEtHEMiw+q5WoEUoXz2oYsIlGKXEWR9rb4FkgLcXylLH
	movm6RA==
X-Google-Smtp-Source: AGHT+IEWSA4fDbg0ibRFGPSZKCMBCSJeYgY5UAGASEYAWSOWOvfZ2A76/t8FmAXO8wa38rFjn6xU2QPybjdA
X-Received: from pfod7.prod.google.com ([2002:aa7:8687:0:b0:736:38af:afeb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1744:b0:224:249f:9723
 with SMTP id d9443c01a7336-22c536204c8mr9101135ad.51.1744931305689; Thu, 17
 Apr 2025 16:08:25 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:36 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-16-irogers@google.com>
Subject: [PATCH v4 15/19] perf build: Remove unused defines
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

DISASM_FOUR_ARGS_SIGNATURE and DISASM_INIT_STYLED were used with
libbfd support. Remove now that libbfd support is removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3ed047ffb4f5..bb4d31b1e1df 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -320,9 +320,6 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
-
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
@@ -349,7 +346,7 @@ endif
 
 ifeq ($(FEATURES_DUMP),)
 # We will display at the end of this Makefile.config, using $(call feature_display_entries)
-# As we may retry some feature detection here, see the disassembler-four-args case, for instance
+# As we may retry some feature detection here.
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -1006,14 +1003,6 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
-ifeq ($(feature-disassembler-four-args), 1)
-    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
-endif
-
-ifeq ($(feature-disassembler-init-styled), 1)
-    CFLAGS += -DDISASM_INIT_STYLED
-endif
-
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
@@ -1288,6 +1277,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-- 
2.49.0.805.g082f7c87e0-goog


