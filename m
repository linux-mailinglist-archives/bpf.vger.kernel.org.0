Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D5C653AC7
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 03:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiLVCo5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 21:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiLVCo4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 21:44:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0B31B1E4;
        Wed, 21 Dec 2022 18:44:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w20so704143ply.12;
        Wed, 21 Dec 2022 18:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50e+rc76FX6NnQ/PJbD86Ddg3fIOGCMiwgvLcm7Z4zA=;
        b=hTMh95thyJnZQ/2t3RqHqb0NAyNk6lMUjNzpFtGHVwVcU3lhdNEGGzBpVNm+p5Ugn8
         TpcBsV3MHaUv1vpiJws0EuzybzLMtCH9mBbF/r/yy2/Bl+gngnE/XCcuELw8dCAZhocS
         5D9+H1c+VcVejnHlLSK30i8+bwjWeURy7ZIZyEjcD0bDhYvRCV5L2nY8PAJA5kxcLXSW
         fzhz6EaFFxOc9EfGj17X+GYfUrBtfBMCT62VSZ5oVjF5cdZ/OOtZNG6Ocs7ehL4uPIF4
         srnROYEmjeT60KVc4n1/UfuE/swwJBp+LRdHv0Y4kq8tVFCSEQYDokFbz6qHTqyMGdhq
         yEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50e+rc76FX6NnQ/PJbD86Ddg3fIOGCMiwgvLcm7Z4zA=;
        b=CWeHcAMiOnoNiei43HFyoQipPzJyjetqI30KgAnJ71EPtNMeLdHHOuulVfnsp7BCyB
         ZYXS7ajA8pzlLV9cLV4tJhEd9G/xNTgWeKlmpdUsVQIJjajW+gPcnSWmZfB9Ltpjc3qQ
         pNHjM+fQ9JbKAy9LwMGig0LYtPUhO4pfTdVlXxkFOH2xdu8cvPrGOGOKL/RbA4JIsTin
         103DkOEFyWVsKxFy3vqVpTyR1YCNH4k6n0L6oKbP68h6Z+8jKb+AH47RaIjlBjs7STe7
         oD/9GEsoUeINvm7yPeHG6DjuS0h8A7dZRPnvGwzHIuvPX/gmxT3Czcmq3Dw8ITBv0Fzj
         w67Q==
X-Gm-Message-State: AFqh2kpdoFy8x3CCAk4lcoHm8u1e5AzBOuJPKd3zKaWougE3hjgHrMli
        eld+i7Qqz3KVXHnVdWp1cT8Zo7lWpQ==
X-Google-Smtp-Source: AMrXdXt6XH0T/MPO4vwoAhy95kuAYmNyIX1wVG2mDvALRkoWWkQUWFZqJMzQLpuoiCwc53gz8w8h5Q==
X-Received: by 2002:a05:6a21:e302:b0:a3:d6:8795 with SMTP id cb2-20020a056a21e30200b000a300d68795mr5941938pzc.17.1671677094277;
        Wed, 21 Dec 2022 18:44:54 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id b3-20020a636703000000b004768b74f208sm10752587pgc.4.2022.12.21.18.44.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Dec 2022 18:44:53 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: check null propagation only neither reg is PTR_TO_BTF_ID
Date:   Thu, 22 Dec 2022 10:44:14 +0800
Message-Id: <20221222024414.29539-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221222024414.29539-1-sunhao.th@gmail.com>
References: <20221222024414.29539-1-sunhao.th@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verify that nullness information is not porpagated in the branches
of register to register JEQ and JNE operations if one of them is
PTR_TO_BTF_ID. Implement this in C level so we can use CO-RE.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/jeq_infer_not_null.c       |  9 ++++
 .../bpf/progs/jeq_infer_not_null_fail.c       | 42 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c b/tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c
new file mode 100644
index 000000000000..3add34df5767
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "jeq_infer_not_null_fail.skel.h"
+
+void test_jeq_infer_not_null(void)
+{
+	RUN_TESTS(jeq_infer_not_null_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
new file mode 100644
index 000000000000..f46965053acb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, u64);
+	__type(value, u64);
+} m_hash SEC(".maps");
+
+SEC("?raw_tp")
+__failure __msg("R8 invalid mem access 'map_value_or_null")
+int jeq_infer_not_null_ptr_to_btfid(void *ctx)
+{
+	struct bpf_map *map = (struct bpf_map *)&m_hash;
+	struct bpf_map *inner_map = map->inner_map_meta;
+	u64 key = 0, ret = 0, *val;
+
+	val = bpf_map_lookup_elem(map, &key);
+	/* Do not mark ptr as non-null if one of them is
+	 * PTR_TO_BTF_ID (R9), reject because of invalid
+	 * access to map value (R8).
+	 *
+	 * Here, we need to inline those insns to access
+	 * R8 directly, since compiler may use other reg
+	 * once it figures out val==inner_map.
+	 */
+	asm volatile("r8 = %[val];\n"
+		     "r9 = %[inner_map];\n"
+		     "if r8 != r9 goto +1;\n"
+		     "%[ret] = *(u64 *)(r8 +0);\n"
+		     : [ret] "+r"(ret)
+		     : [inner_map] "r"(inner_map), [val] "r"(val)
+		     : "r8", "r9");
+
+	return ret;
+}
-- 
2.39.0

