Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80183DA8D5
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhG2QVA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhG2QUt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 12:20:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860FC0613C1
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:20:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so7657516wrr.2
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8W7uiFN+SJdzF6xclbZpXJzf6AmnLjLyfeJ7DbdGIKw=;
        b=aN+EuT3ZbVqP3J1wjy1Cn9wS0dzKMuCTPu1TIbaHVuNJNLRzHQmhj9Ej6vpmIVCcMI
         TbPDhMU0gHjPKY7m2AqoSnezCttz3VLqMAZCdQ29j7yg88+aGT/Dva+PHrOUveFWNjy4
         HKh2ewKKEemz/QOlkJi467GYG0O8UphXEGJxZnqiZ034RZVG1dl+Ltk+75VJkiIZ9P0m
         P0HFO9L7P1RuD/eBa9BVBYBqn966KpUf4ALQFbNqN+rsYgRq1smV+JQQPONnBYDT/4jJ
         OOAxCKbm3YN0d5WeI69jE4x2kimtL6GxJkLnMWLfSLhPVkTJEQVkBFiqm4AwwFWbKIIq
         hgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8W7uiFN+SJdzF6xclbZpXJzf6AmnLjLyfeJ7DbdGIKw=;
        b=hAcXk9FD/WTBu0gXxecjeYGzSYLP1+sFn528wNXIlJLT5HQI627qWGR+A26fhSmiYZ
         5S7i9aOkxeyUAsRVhbjlKtjZssWRxp+9d3Tlpr2gu4yzSjnRIoeVKxLA7KdZDf1Wp/P3
         eUOH0o9KA1zvhU8l4LO2r6BNQzzHG2TdyEmbKRapis/RI75H1/4b5Y8xYfEfLnGCZ0mP
         QoLBs2dN41XINhy5O97wG9iiiLKnMv51t/NTqbRlDT5m0YlifJDy22Hv1Fh3Ob08iVJ6
         lfGyh/tf9xU2A4LLnG4bzMVLAOQ5bujC+rIaJZACPl4zXlVBS4iyoO4/7qWStaZiWYI8
         6/qA==
X-Gm-Message-State: AOAM532yf1y7K3TBj53vhp/7R/BCfdzluuNV2V+NGqpU+3Lrbo94/c8/
        aSStBvUKYofviwMh2iI8W/ByBIR2JYaQaJGgMv0=
X-Google-Smtp-Source: ABdhPJzonNAIxUh4oB78IxcbYHXNkyO+8Z0KxQRHu9BshNTcAZlUYkcfOmCrcF/BRJJ/a5Eursx+TQ==
X-Received: by 2002:a5d:4e8f:: with SMTP id e15mr5603050wru.415.1627575643732;
        Thu, 29 Jul 2021 09:20:43 -0700 (PDT)
Received: from localhost.localdomain ([149.86.66.250])
        by smtp.gmail.com with ESMTPSA id c10sm3854853wmb.40.2021.07.29.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:20:43 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 6/8] libbpf: prepare deprecation of btf__get_from_id(), btf__load()
Date:   Thu, 29 Jul 2021 17:20:26 +0100
Message-Id: <20210729162028.29512-7-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729162028.29512-1-quentin@isovalent.com>
References: <20210729162028.29512-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a macro LIBBPF_DEPRECATED_SINCE(major, minor, message) to
prepare the deprecation of two API functions. This macro mark the
functions as deprecated when libbpf's version reaches the values passed
as an argument.

Prepare deprecation for btf__get_from_id() and btf__load(), respectively
replaced by btf__load_from_kernel_by_id() and btf__load_into_kernel(),
for version 0.6 of the library.

References:

- https://github.com/libbpf/libbpf/issues/278
- https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#btfh-apis

Side notes:

- Because of the constraints from the preprocessor, we have to write a
  few lines of macro magic for each version used to prepare deprecation
  (0.6 for now).
- Checkpatch complains about the absence of parentheses around the
  definition for LIBBPF_DEPRECATED_SINCE, but the compiler profusely
  complains if we attempt to add them.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/lib/bpf/Makefile        |  3 +++
 tools/lib/bpf/btf.h           |  2 ++
 tools/lib/bpf/libbpf_common.h | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index ec14aa725bb0..095d5dc30d50 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -8,6 +8,7 @@ LIBBPF_VERSION := $(shell \
 	grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
 	sort -rV | head -n1 | cut -d'_' -f2)
 LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))
+LIBBPF_MINOR_VERSION := $(firstword $(subst ., ,$(subst $(LIBBPF_MAJOR_VERSION)., ,$(LIBBPF_VERSION))))
 
 MAKEFLAGS += --no-print-directory
 
@@ -86,6 +87,8 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
+override CFLAGS += -DLIBBPF_MAJOR_VERSION=$(LIBBPF_MAJOR_VERSION)
+override CFLAGS += -DLIBBPF_MINOR_VERSION=$(LIBBPF_MINOR_VERSION)
 
 # flags specific for shared library
 SHLIB_FLAGS := -DSHARED -fPIC
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 698afde03c2e..a6039ca66895 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -44,9 +44,11 @@ LIBBPF_API struct btf *btf__parse_elf_split(const char *path, struct btf *base_b
 LIBBPF_API struct btf *btf__parse_raw(const char *path);
 LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
 LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
+LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__load_from_kernel_by_id instead")
 LIBBPF_API int btf__get_from_id(__u32 id, struct btf **btf);
 
 LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
+LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__load_into_kernel instead")
 LIBBPF_API int btf__load(struct btf *btf);
 LIBBPF_API int btf__load_into_kernel(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 947d8bd8a7bb..7218d6156ed7 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -17,6 +17,25 @@
 
 #define LIBBPF_DEPRECATED(msg) __attribute__((deprecated(msg)))
 
+#define __LIBBPF_GET_VERSION(major, minor) (((major) << 8) + (minor))
+#define __LIBBPF_CURRENT_VERSION					    \
+	__LIBBPF_GET_VERSION(LIBBPF_MAJOR_VERSION, LIBBPF_MINOR_VERSION)
+#define __LIBBPF_CURRENT_VERSION_GEQ(major, minor)			    \
+	(__LIBBPF_CURRENT_VERSION >= __LIBBPF_GET_VERSION(major, minor))
+/* Add checks for other versions below when planning deprecation of API symbols
+ * with the LIBBPF_DEPRECATED_SINCE macro.
+ */
+#if __LIBBPF_CURRENT_VERSION_GEQ(0, 6)
+#define __LIBBPF_MARK_DEPRECATED_0_6(X) X
+#else
+#define __LIBBPF_MARK_DEPRECATED_0_6(X)
+#endif
+
+/* Mark a symbol as deprecated when libbpf version is >= {major}.{minor} */
+#define LIBBPF_DEPRECATED_SINCE(major, minor, msg)			    \
+	__LIBBPF_MARK_DEPRECATED_ ## major ## _ ## minor		    \
+		(LIBBPF_DEPRECATED("v" # major "." # minor "+, " msg))
+
 /* Helper macro to declare and initialize libbpf options struct
  *
  * This dance with uninitialized declaration, followed by memset to zero,
-- 
2.30.2

