Return-Path: <bpf+bounces-1867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49572316A
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B5B1C20D2B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BC2261FC;
	Mon,  5 Jun 2023 20:28:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0A261E0
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:28:25 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF0122
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 13:28:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-651afaa951fso1747504b3a.3
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685996903; x=1688588903;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qYHV5dndHRBhvbPRu9xCOpU+u+ZVanAjGEzSYR7+fE=;
        b=cRXKNn7+YSXxjSE82ZAWPBlWtgcRZW0a6eCJLqKXO+z9nfKhe3fAvCtkNzc9R20ATJ
         JTA8H8IoLKqChxw3bQIxPIsF+Yjm3YXEPvRajAl8/RU9TmDS4CfjlKJwFpCkG0rDxwQq
         4/2ZMmjUPim1BnCP0ZNfireRVukam04u9nXCM5u37eAtzr7gJBweyJsxhTQdxYWgQdks
         +cxVYRhaeVTQsXxPcznKJAHgraHO+FWFEVPI9QtV89IyO/76AWyNolwh2tDTs2C6SAgH
         KeEswJtIUw8Gd5rz2rvzs/xIAh/nXeYvOCElFv4R9sFqZJVG6IDtUH4L0wNU/LSSnJlF
         lpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996903; x=1688588903;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qYHV5dndHRBhvbPRu9xCOpU+u+ZVanAjGEzSYR7+fE=;
        b=SKS/shf49k7/ipJDO6QXWiviWZOMczsoYnbr5IFpfzxIbPRSnEwb1f3xsBJKwo3+EQ
         1F5bb9YLkm2rTdQWLEb8HLTcCmHyyBOrtsv2q6NHulcqrtZuff4sy9xOkzeBsrsrXoHL
         J+XF5ghKvIYl9uH87Mb3trn8uPi9s8nFFPS4hZ+xkLhAJtwnHifnvY+xuWNR4qFK+ryF
         oPEt6OFR4FAkeYIEZKNRi1p+9v0ksIRn02YIEmadUBngi670Lcf4wZTs2bhHpYzZ4Tf+
         swI1PvGhqDKFMgtFolppk3uVhFhDLHXs08YtDZcFQ6cQqTPLOdnpzufKa0qyVgcQhzE3
         ELiw==
X-Gm-Message-State: AC+VfDx9WRNunHVnAH8IA1+I7pBvN8prT8UkW+YixW0TXWweZAkoHPrB
	Dx1u2DkysKI0TYF3ioxTzdmImOm0HrdC
X-Google-Smtp-Source: ACHHUZ5kJFyJQnGfJxkrSLArQVibKLxmKB7BQc3RM1y2mYm7yqoiImIn/6Lx1E+t5ldnpaKwEkpEIhyFaBI5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bed9:39b9:3df1:2828])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2292:b0:658:747:c85e with SMTP id
 f18-20020a056a00229200b006580747c85emr331558pfe.6.1685996902955; Mon, 05 Jun
 2023 13:28:22 -0700 (PDT)
Date: Mon,  5 Jun 2023 13:27:12 -0700
In-Reply-To: <20230605202712.1690876-1-irogers@google.com>
Message-Id: <20230605202712.1690876-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230605202712.1690876-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 4/4] perf build: Filter out BTF sources without a .BTF section
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If generating vmlinux.h, make the code to generate it more tolerant by
filtering out paths to kernels that lack a .BTF section.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f1840af195c0..c3bb27a912b0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -193,6 +193,7 @@ FLEX    ?= flex
 BISON   ?= bison
 STRIP   = strip
 AWK     = awk
+READELF ?= readelf
 
 # include Makefile.config by default and rule out
 # non-config cases
@@ -1080,12 +1081,28 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+# Paths to search for a kernel to generate vmlinux.h from.
+VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
 		     ../../vmlinux					\
-		     /sys/kernel/btf/vmlinux				\
 		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+
+# Paths to BTF information.
+VMLINUX_BTF_BTF_PATHS ?= /sys/kernel/btf/vmlinux
+
+# Filter out kernels that don't exist or without a BTF section.
+VMLINUX_BTF_ELF_ABSPATHS ?= $(abspath $(wildcard $(VMLINUX_BTF_ELF_PATHS)))
+VMLINUX_BTF_PATHS ?= $(shell for file in $(VMLINUX_BTF_ELF_ABSPATHS); \
+			do \
+				if [ -f $$file ] && ($(READELF) -t "$$file" | grep .BTF); \
+				then \
+					echo "$$file"; \
+				fi; \
+			done) \
+			$(wildcard $(VMLINUX_BTF_BTF_PATHS))
+
+# Select the first as the source of vmlinux.h.
+VMLINUX_BTF ?= $(firstword $(VMLINUX_BTF_PATHS))
 
 $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
-- 
2.41.0.rc0.172.g3f132b7071-goog


