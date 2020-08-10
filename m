Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF31240607
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 14:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgHJMkp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 08:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHJMkn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 08:40:43 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3ECC061756
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 05:40:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so9172589ejb.11
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 05:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jozky3iNUilNi92WXOcNWoi6GSxB0Ejr0u+yMbhGh4=;
        b=XsYETe4Wj4k8cTZdzC12eoTAI3QhsCa+r1R3+l67mAQGW3RT5kcVwmnegXs5K5EMTp
         IMpgOB1+IZDhIouVtRKtuvlnh2lD2J/pza+MQTPqiXyC8uPsBnGiWz4DL3PA8dvIkz5c
         cQAQXhE5qJexHLV/YCPy2wbMhQkDoxfn9VvPzNhhGJ9bTWT4HPU8kMZong+6RfwqOnCR
         hbEmC7wDohtQLyIrASLbZtyPnDeklcteL6jOq4a8/6BJHNKR2zn2uID2IK2zOvZMIlxC
         YYCc+L7ybH3i9NzqRLdeok/5C6Rc7tIJOc0pqNn8qCrZCc7gMTacqrMlSPnrYY/293Jz
         2Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jozky3iNUilNi92WXOcNWoi6GSxB0Ejr0u+yMbhGh4=;
        b=DNTlx665kyzfTLid8SH+lfqQMroJEOXBn1sskzHIQ6k8BGN4ttisXKAopjN5sGRX4w
         jfFFhf9lBstLp8fblKW/GfOxzOmfpktoH/TX5bDHemAW5i3lsjNg5wcg9OOHKg6S+a5o
         hmHTw0FtwycFvei3m+nXKkV1Pf5wa27OD6wN7k5lbsC07Jj9L6EcF827eeuFm3t4NkRW
         EDUoXjEc3TNGndNL+2OIYXifjk+8/J8s8JE2Z0hZ56La1ssoiaBzFy4OMiufJC92PSF1
         RBULC91l6M2lKEvGS0W+3sujb2o9X9kCZ6PW82BYiBtnJeCfsW21ZzHjELVJTU22Fth1
         xK3A==
X-Gm-Message-State: AOAM531wnDcL8USCq5VA6HNJH0JPEp2/aa042MZoBVQ9DFslNV4DxrD7
        9K9KyA3MfhKpgH0DhaIvspIzcg==
X-Google-Smtp-Source: ABdhPJxz2LAgBDmCKJWiBsGk130LsHhKh7fSGHlvuZTr9dl1h7uD8JkceN96LNyOkKCXbvAGdXFZDA==
X-Received: by 2002:a17:906:37c3:: with SMTP id o3mr22588144ejc.54.1597063242060;
        Mon, 10 Aug 2020 05:40:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b62sm12395285edf.61.2020.08.10.05.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:40:41 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Subject: [PATCH bpf] libbpf: Handle GCC built-in types for Arm NEON
Date:   Mon, 10 Aug 2020 14:28:36 +0200
Message-Id: <20200810122835.2309026-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When building Arm NEON (SIMD) code, GCC emits built-in types __PolyXX_t,
which are not recognized by Clang. This causes build failures when
including vmlinux.h generated from a kernel built with CONFIG_RAID6_PQ=y
and CONFIG_KERNEL_MODE_NEON. Emit typedefs for these built-in types,
based on the Clang definitions. poly64_t is unsigned long because it's
only defined for 64-bit Arm.

Including linux/kernel.h to use ARRAY_SIZE() incidentally redefined
max(), causing a build bug due to different types, hence the seemingly
unrelated change.

Reported-by: Jakov Petrina <jakov.petrina@sartura.hr>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/lib/bpf/btf_dump.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cf711168d34a..3162d7b1880c 100644
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
 
+static void btf_dump_emit_int_def(struct btf_dump *d, __u32 id,
+				  const struct btf_type *t);
+
 static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
 				     const struct btf_type *t);
 static void btf_dump_emit_struct_def(struct btf_dump *d, __u32 id,
@@ -671,6 +675,9 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 
 	switch (kind) {
 	case BTF_KIND_INT:
+		/* Emit type alias definitions if necessary */
+		btf_dump_emit_int_def(d, id, t);
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
 
+static const char *builtin_types[][2] = {
+	/*
+	 * GCC emits typedefs to its internal __PolyXX_t types when compiling
+	 * Arm SIMD intrinsics. Alias them to the same standard types as Clang.
+	 */
+	{ "__Poly8_t",		"unsigned char" },
+	{ "__Poly16_t",		"unsigned short" },
+	{ "__Poly64_t",		"unsigned long" },
+	{ "__Poly128_t",	"unsigned __int128" },
+};
+
+static void btf_dump_emit_int_def(struct btf_dump *d, __u32 id,
+				  const struct btf_type *t)
+{
+	const char *name = btf_dump_type_name(d, id);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(builtin_types); i++) {
+		if (strcmp(name, builtin_types[i][0]) == 0) {
+			btf_dump_printf(d, "typedef %s %s;\n\n",
+					builtin_types[i][1], name);
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

