Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF784242B82
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHLOkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgHLOkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 10:40:23 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622BC061383
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 07:40:23 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so2536880ejb.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2020 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Usp7GMaZ0ABjxaU9mNoLDit8I1PgMcstrZVKWuqDiks=;
        b=APXFtXgEHkcenWyb/RRr60FadFCgHl7GQfc90NdJITjEYAmbxGyp9UMbkGqH1Us3Hb
         j3H+G7S4HahI/+odTHTtoICJZeTk2aYrd1q7YLr4jZCqtxTlevjOluS0t/dUMpSSgvb/
         X9wRiSy+CRLrsPwwjMHsT1HTCXE5oaBSkn/7kDCbpAG1Nopqw/aLBOGtHLJYVJmGY7YC
         xsQX1crwYi7Chfy9o3pdXNmaZ6wxLjZwtyyS+hXeneSh8mB2UrD1tkzzpyz1rh/BRrAn
         8A3tOTWIdEliKmUIiFJXV/cxqqa0FNp3xWO4e/zuOP31/ckV9nPlxuXnOyqsbC4ezSkI
         jbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Usp7GMaZ0ABjxaU9mNoLDit8I1PgMcstrZVKWuqDiks=;
        b=frgSRfQutEM+tkoXklCzVOo/YMnguu8xoLnrjthuj6mtHL7m/1x4ueLBejJWpb8gqT
         ZOsde8Imq2rLnhYfhMaek6jBg3+06QSsgxeyBqeT9XkCz2UrHCg/hjOSEiGOyVcCfJb3
         MpjjYOFdV1pyZFN2nHwY8NigeV+iYncVrR6tEj5HUW9ZjjhYAGbsYnewneGzcGS3wgkJ
         eIBzOIgYiOsxwt0rYIDai5cmeeO/f+V6oisOSWjeuNhV96Avc7SlsUxYhEg0qM+fFf6G
         URMbdfj+HyyGy3Z8SjRwKlVFs9Ryb0SJMIzQAm99DerEu53rjI86VK2r+ZK7TK8lzkca
         J4NQ==
X-Gm-Message-State: AOAM531Qfn1tuiQMMYlEvSzYmEegeWPaKpHAUczEJSLcUuW8a0figTpC
        16SqTdm/Yzn28mmd7ynT15v71A==
X-Google-Smtp-Source: ABdhPJyhWGPAXEmTSKjkSNXSl5qCnpv2gqmTLmKnclGw/AJr+WOI0sS4p0Dn5Z4EOv5sTOFbOMTqWQ==
X-Received: by 2002:a17:906:6d54:: with SMTP id a20mr58789ejt.501.1597243222097;
        Wed, 12 Aug 2020 07:40:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b2sm1677617ejg.70.2020.08.12.07.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 07:40:21 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: [PATCH bpf v2] libbpf: Handle GCC built-in types for Arm NEON
Date:   Wed, 12 Aug 2020 16:39:10 +0200
Message-Id: <20200812143909.3293280-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When building Arm NEON (SIMD) code from lib/raid6/neon.uc, GCC emits
DWARF information using a base type "__Poly8_t", which is internal to
GCC and not recognized by Clang. This causes build failures when
building with Clang a vmlinux.h generated from an arm64 kernel that was
built with GCC.

	vmlinux.h:47284:9: error: unknown type name '__Poly8_t'
	typedef __Poly8_t poly8x16_t[16];
	        ^~~~~~~~~

The polyX_t types are defined as unsigned integers in the "Arm C
Language Extension" document (101028_Q220_00_en). Emit typedefs based on
standard integer types for the GCC internal types, similar to those
emitted by Clang.

Including linux/kernel.h to use ARRAY_SIZE() incidentally redefined
max(), causing a build bug due to different types, hence the seemingly
unrelated change.

Reported-by: Jakov Petrina <jakov.petrina@sartura.hr>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2:
* Tried to clarify the commit message a bit.
* Made __Poly64_t an unsigned long long, for portability.
* Improve names.
---
 tools/lib/bpf/btf_dump.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cf711168d34a..ac81f3f8957a 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <linux/err.h>
 #include <linux/btf.h>
+#include <linux/kernel.h>
 #include "btf.h"
 #include "hashmap.h"
 #include "libbpf.h"
@@ -549,6 +550,9 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 	}
 }
 
+static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id,
+					  const struct btf_type *t);
+
 static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
 				     const struct btf_type *t);
 static void btf_dump_emit_struct_def(struct btf_dump *d, __u32 id,
@@ -671,6 +675,9 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 
 	switch (kind) {
 	case BTF_KIND_INT:
+		/* Emit type alias definitions if necessary */
+		btf_dump_emit_missing_aliases(d, id, t);
+
 		tstate->emit_state = EMITTED;
 		break;
 	case BTF_KIND_ENUM:
@@ -870,7 +877,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 			btf_dump_printf(d, ": %d", m_sz);
 			off = m_off + m_sz;
 		} else {
-			m_sz = max(0, btf__resolve_size(d->btf, m->type));
+			m_sz = max(0LL, btf__resolve_size(d->btf, m->type));
 			off = m_off + m_sz * 8;
 		}
 		btf_dump_printf(d, ";");
@@ -890,6 +897,32 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 		btf_dump_printf(d, " __attribute__((packed))");
 }
 
+static const char *missing_base_types[][2] = {
+	/*
+	 * GCC emits typedefs to its internal __PolyX_t types when compiling Arm
+	 * SIMD intrinsics. Alias them to standard base types.
+	 */
+	{ "__Poly8_t",		"unsigned char" },
+	{ "__Poly16_t",		"unsigned short" },
+	{ "__Poly64_t",		"unsigned long long" },
+	{ "__Poly128_t",	"unsigned __int128" },
+};
+
+static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id,
+					  const struct btf_type *t)
+{
+	const char *name = btf_dump_type_name(d, id);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(missing_base_types); i++) {
+		if (strcmp(name, missing_base_types[i][0]) == 0) {
+			btf_dump_printf(d, "typedef %s %s;\n\n",
+					missing_base_types[i][1], name);
+			break;
+		}
+	}
+}
+
 static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
 				   const struct btf_type *t)
 {
-- 
2.27.0

