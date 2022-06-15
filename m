Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1105F54CC7F
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbiFOPRf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348953AbiFOPRd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 11:17:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5CE6165
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 08:17:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o10so16663370edi.1
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zxHUk/GfIhfOHa/GSNAjcvN5sqLhVkUytfRHVP0LF8=;
        b=E/D7uzT6mxUKKN1191it7WfQmI1aUU5Ij9K4+R2eaM7R1uep22kPp615vCfDzWncm8
         IUd3XbZJtxncS/r6Y4Gev5XNAKJQNzpLQq8aryfTE2Hj7HbBUzVSUXS54iYBGE5LdRP1
         1ir5MBZBItKYsDq2QyTHLzHZXAYFZCx2Fkndk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zxHUk/GfIhfOHa/GSNAjcvN5sqLhVkUytfRHVP0LF8=;
        b=NFUBcfbX6Z9xd/YuqiYv6OAdy+JPeMR6ZB0VkiuThM4mG/OL7ogzWLQGJ8T2ubv9wV
         DMX3HA1mYnrNcldkYRVgwti3+u64f24sYjqA9qMWXiKuYf9Vp3KOBhpTED/IEzuKDf7w
         6j7NnykdCLZFoUeLvw0Pu+qG6SY1MZG77LSuWIAx3l2DGqBdGBIGJPO6fLxflqIFypbL
         B/FvP4iox7awowksPbIEm6iA6EqHqaOLQjKS/3UnxykNzXHEXtvCp8EDDVzjUr44uGM4
         b6uiLXkl7FZN7MB1nfbcDymW0kNQezyL7kYZlE82X7RDHyVrwgJW+1HzMKpclyPU43tD
         SqwA==
X-Gm-Message-State: AJIora+XcT8dPmDFo5MvdUO+HVG/UdVisQqoCWJIr0vf/stkIR+oT2+P
        sIe99eFSBNTcgiOHpo+ZM+j38GKHLG4FIg==
X-Google-Smtp-Source: AGRyM1sJk67Jz10AaKalpsmiJDrZcXSc2FqoKY+gpQMalPVhI8cRjIKcp5lLve0QDpNJYyc7TqVb4w==
X-Received: by 2002:a05:6402:1851:b0:42d:c904:d73b with SMTP id v17-20020a056402185100b0042dc904d73bmr223231edy.417.1655306246862;
        Wed, 15 Jun 2022 08:17:26 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id h8-20020aa7c5c8000000b0042e21f8c412sm9549087eds.42.2022.06.15.08.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:17:26 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        kernel-team@cloudflare.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test tail call counting with bpf2bpf and data on stack
Date:   Wed, 15 Jun 2022 17:17:21 +0200
Message-Id: <20220615151721.404596-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615151721.404596-1-jakub@cloudflare.com>
References: <20220615151721.404596-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cover the case when tail call count needs to be passed from BPF function to
BPF function, and the caller has data on stack. Specifically when the size
of data allocated on BPF stack is not a multiple on 8.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 55 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_bpf2bpf6.c   | 42 ++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index c4da87ec3ba4..19c70880cfb3 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -831,6 +831,59 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	bpf_object__close(obj);
 }
 
+#include "tailcall_bpf2bpf6.skel.h"
+
+/* Tail call counting works even when there is data on stack which is
+ * not aligned to 8 bytes.
+ */
+static void test_tailcall_bpf2bpf_6(void)
+{
+	struct tailcall_bpf2bpf6 *obj;
+	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+
+	obj = tailcall_bpf2bpf6__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "open and load"))
+		return;
+
+	main_fd = bpf_program__fd(obj->progs.entry);
+	if (!ASSERT_GE(main_fd, 0, "entry prog fd"))
+		goto out;
+
+	map_fd = bpf_map__fd(obj->maps.jmp_table);
+	if (!ASSERT_GE(map_fd, 0, "jmp_table map fd"))
+		goto out;
+
+	prog_fd = bpf_program__fd(obj->progs.classifier_0);
+	if (!ASSERT_GE(prog_fd, 0, "classifier_0 prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "jmp_table map update"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "entry prog test run");
+	ASSERT_EQ(topts.retval, 0, "tailcall retval");
+
+	data_fd = bpf_map__fd(obj->maps.bss);
+	if (!ASSERT_GE(map_fd, 0, "bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "bss map lookup");
+	ASSERT_EQ(val, 1, "done flag is set");
+
+out:
+	tailcall_bpf2bpf6__destroy(obj);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -855,4 +908,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_4(false);
 	if (test__start_subtest("tailcall_bpf2bpf_5"))
 		test_tailcall_bpf2bpf_4(true);
+	if (test__start_subtest("tailcall_bpf2bpf_6"))
+		test_tailcall_bpf2bpf_6();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
new file mode 100644
index 000000000000..256de9bcc621
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define __unused __attribute__((always_unused))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int done = 0;
+
+SEC("tc")
+int classifier_0(struct __sk_buff *skb __unused)
+{
+	done = 1;
+	return 0;
+}
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb)
+{
+	/* Don't propagate the constant to the caller */
+	volatile int ret = 1;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return ret;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	/* Have data on stack which size is not a multiple of 8 */
+	volatile char arr[1] = {};
+
+	return subprog_tail(skb);
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.35.3

