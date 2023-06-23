Return-Path: <bpf+bounces-3232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D6873AF54
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 06:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B611C20DD2
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 04:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF32F17C7;
	Fri, 23 Jun 2023 04:14:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBE17C2
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 04:14:27 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FAA26AB
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:14:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5f9d084c9so360048276.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493662; x=1690085662;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ai2lt5OXlbg2xibr5qc+Wf7Z0ZxmmScMUvbx2hwx4o=;
        b=i6JMRQKJse9xdriW6sN1y3oU7Pmdm0X/tfZLFVuGr7Qy5Xvv6Bk2LiBt6lGdWaN2m5
         WkOHxDeZ5GFOwfdEyr8yKNo6xUAr0SKyujoJ2vYt0MUH50G524NCf+IU6TWfk3LbfE7F
         m1qOHpsF6yNlWremKE+D63U+q84y57TzPt0Y9djKgU80NXuNlflx3+DmEZ50zz3G1Y3q
         6qZEnyKYtMyjy2Ly46Cnv79i5ZSNFGLmqTCYo/7K1Zlz9oo2pMmmukJ0zWVUzJzM7Vq6
         6o3yon9f3xJIMgIyY120p/xIbAf84PMc9cvDW/ics5umym/bom1SzjhELttNr7xzasjI
         n/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493662; x=1690085662;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ai2lt5OXlbg2xibr5qc+Wf7Z0ZxmmScMUvbx2hwx4o=;
        b=adwy3b7amBq5lbN+U8FS5MzDfO3f68SDc08dzPrrnyPdaNw7enKpEEk1ISnJI1Kv1A
         s6k2MANXKGBiF6QWE3Z7yFqUYr28lyQlLeYQvyl/g+uWclwBQWYqYFxleC8aJ8NbY+VJ
         CCKpmLteTs+nFaQ+kRJyVJAp45yoBERu41DNeuv+vbxmIwFCMRE/NaMcrJ37YVVrZ3wX
         lUYNQdatSLlkNZ7DrJWB1gadd+jdDSxaxOoiIqKwo9+EDvfeR/D1i0XzQDp/BJQxz8w2
         pyx86mxNwANBiquGaFyCCkSVrLFFszyU4/kkz+RUOT8gyj4lFucCuPW78NPqy+t/LSSy
         BFkA==
X-Gm-Message-State: AC+VfDw47cghD9zfcHrqwNbcU+1zV4vsS0iG+sXFj2AuBkGQvBD6cknJ
	DwYa5ep5ZnZybXXc6VYmAOXUDgdoUtW6
X-Google-Smtp-Source: ACHHUZ4av1Md+P50HHhit3siIeZinqjGeMjKrlX3Hguw5x3mNqN/hkSq5KyK0AqscXGomtYmaoVFKFdwLala
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:8046:0:b0:bd7:545e:ab35 with SMTP id
 a6-20020a258046000000b00bd7545eab35mr8897557ybn.10.1687493662218; Thu, 22 Jun
 2023 21:14:22 -0700 (PDT)
Date: Thu, 22 Jun 2023 21:14:05 -0700
In-Reply-To: <20230623041405.4039475-1-irogers@google.com>
Message-Id: <20230623041405.4039475-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230623041405.4039475-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 4/4] perf build: Filter out BTF sources without a .BTF section
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.perf | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 80d772cc5fcb..8f442419a895 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -197,6 +197,7 @@ FLEX    ?= flex
 BISON   ?= bison
 STRIP   = strip
 AWK     = awk
+READELF ?= readelf
 
 # include Makefile.config by default and rule out
 # non-config cases
@@ -1084,12 +1085,34 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
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
+				if [ -f $$file ] && ($(READELF) -S "$$file" | grep -q .BTF); \
+				then \
+					echo "$$file"; \
+				fi; \
+			done) \
+			$(wildcard $(VMLINUX_BTF_BTF_PATHS))
+
+# Select the first as the source of vmlinux.h.
+VMLINUX_BTF ?= $(firstword $(VMLINUX_BTF_PATHS))
+
+ifeq ($(VMLINUX_H),)
+  ifeq ($(VMLINUX_BTF),)
+    $(error Missing bpftool input for generating vmlinux.h)
+  endif
+endif
 
 $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
 ifeq ($(VMLINUX_H),)
-- 
2.41.0.162.gfafddb0af9-goog


