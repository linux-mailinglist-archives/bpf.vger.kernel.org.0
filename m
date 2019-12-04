Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 343E9113578
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2019 20:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfLDTJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Dec 2019 14:09:58 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:55349 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfLDTJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Dec 2019 14:09:58 -0500
Received: by mail-pj1-f74.google.com with SMTP id e7so378980pjt.22
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 11:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7/u5MtE8GGNIkQpF6GaFbkK4Dp87PRCQ92z7Xcrt0r4=;
        b=od3x94Imhn9QFPESnWqo3LZpm72cU0JXU8qOH3aVeJtVMRS+9HPtIaetT3aIzyfpuP
         YCxVQI8wvyJCZ/qY810YxmgpO6bNAjoboyfxfB+Y4GeenjvXOM+BJhJ+wZlRjQsa16sp
         aB2Y46ExUYl94wgj7e/RJhkiyMo68tAhoEIR1hYdLMiqaJ6SERuWHUrkOtE/fLYYMfMK
         0r64psNmU9qn37TA/xA/oT3cVgvYaaJInvUII9XN49w6vD4ohs7ATWynBP7BaJQZL5Wu
         heri2Z8n6vSOj10t7wm0HVUnEQk1zD6d7ednoy9KBqLY7SOsrpC1qBS3giHGgJHELVph
         d8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7/u5MtE8GGNIkQpF6GaFbkK4Dp87PRCQ92z7Xcrt0r4=;
        b=gVt5vFbf5sJTUbESWrrvrcnfz5K6R3dM5kLWEeITLEla7fH4wMbCTwLvOK5NtR6V4j
         7cSFyd8pJ4ga3u3l2H3XgfNbnG9Elv4boL28XoaqyeeIriU+1qHfbsUcSAx5gt/azy3H
         oIuqbKLgLOc4vrzkGJiSZbSxjxT8GO9WIR1llxbGtzjXYdEqbv4a+n3zRkVUujxcHXhb
         Jpc4mfXxpnGq9R34NEYtJnhu/G9ymopD1901HbmQl3aHPibMmuovMBqKasNkE2PrXrhm
         6GJeM18+NqLq9UMCSrQYi/LbUfSx2ik9xCczKSY2/QfS7tfqiHsLYQaGRVOp/aw2CF6o
         srcQ==
X-Gm-Message-State: APjAAAVI7XMGsQYWxV5toHaWJB1jgSnKATEgCDMtx2SOUI83Wefjn2QC
        oFZwqdKXZaSH1wTIOJmQbGayZyE=
X-Google-Smtp-Source: APXvYqyM4s5RLWgvanS19DTCJlKXLvyiNbMBZkTY1/otUJXKxR104SfiOlCx8wrBqhUbDH/8LKjnyc0=
X-Received: by 2002:a63:5104:: with SMTP id f4mr5134286pgb.192.1575486597837;
 Wed, 04 Dec 2019 11:09:57 -0800 (PST)
Date:   Wed,  4 Dec 2019 11:09:55 -0800
Message-Id: <20191204190955.170934-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH bpf] selftests/bpf: de-flake test_tcpbpf
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Lawrence Brakmo <brakmo@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It looks like BPF program that handles BPF_SOCK_OPS_STATE_CB state
can race with the bpf_map_lookup_elem("global_map"); I sometimes
see the failures in this test and re-running helps.

Since we know that we expect the callback to be called 3 times (one
time for listener socket, two times for both ends of the connection),
let's export this number and add simple retry logic around that.

Also, let's make EXPECT_EQ() not return on failure, but continue
evaluating all conditions; that should make potential debugging
easier.

With this fix in place I don't observe the flakiness anymore.

Cc: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |  1 +
 tools/testing/selftests/bpf/test_tcpbpf.h     |  1 +
 .../testing/selftests/bpf/test_tcpbpf_user.c  | 25 +++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 2e233613d1fc..7fa4595d2b66 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -131,6 +131,7 @@ int bpf_testcb(struct bpf_sock_ops *skops)
 				g.bytes_received = skops->bytes_received;
 				g.bytes_acked = skops->bytes_acked;
 			}
+			g.num_close_events++;
 			bpf_map_update_elem(&global_map, &key, &g,
 					    BPF_ANY);
 		}
diff --git a/tools/testing/selftests/bpf/test_tcpbpf.h b/tools/testing/selftests/bpf/test_tcpbpf.h
index 7bcfa6207005..6220b95cbd02 100644
--- a/tools/testing/selftests/bpf/test_tcpbpf.h
+++ b/tools/testing/selftests/bpf/test_tcpbpf.h
@@ -13,5 +13,6 @@ struct tcpbpf_globals {
 	__u64 bytes_received;
 	__u64 bytes_acked;
 	__u32 num_listen;
+	__u32 num_close_events;
 };
 #endif
diff --git a/tools/testing/selftests/bpf/test_tcpbpf_user.c b/tools/testing/selftests/bpf/test_tcpbpf_user.c
index 716b4e3be581..3ae127620463 100644
--- a/tools/testing/selftests/bpf/test_tcpbpf_user.c
+++ b/tools/testing/selftests/bpf/test_tcpbpf_user.c
@@ -16,6 +16,9 @@
 
 #include "test_tcpbpf.h"
 
+/* 3 comes from one listening socket + both ends of the connection */
+#define EXPECTED_CLOSE_EVENTS		3
+
 #define EXPECT_EQ(expected, actual, fmt)			\
 	do {							\
 		if ((expected) != (actual)) {			\
@@ -23,13 +26,14 @@
 			       "    Actual: %" fmt "\n"		\
 			       "  Expected: %" fmt "\n",	\
 			       (actual), (expected));		\
-			goto err;				\
+			ret--;					\
 		}						\
 	} while (0)
 
 int verify_result(const struct tcpbpf_globals *result)
 {
 	__u32 expected_events;
+	int ret = 0;
 
 	expected_events = ((1 << BPF_SOCK_OPS_TIMEOUT_INIT) |
 			   (1 << BPF_SOCK_OPS_RWND_INIT) |
@@ -48,15 +52,15 @@ int verify_result(const struct tcpbpf_globals *result)
 	EXPECT_EQ(0x80, result->bad_cb_test_rv, PRIu32);
 	EXPECT_EQ(0, result->good_cb_test_rv, PRIu32);
 	EXPECT_EQ(1, result->num_listen, PRIu32);
+	EXPECT_EQ(EXPECTED_CLOSE_EVENTS, result->num_close_events, PRIu32);
 
-	return 0;
-err:
-	return -1;
+	return ret;
 }
 
 int verify_sockopt_result(int sock_map_fd)
 {
 	__u32 key = 0;
+	int ret = 0;
 	int res;
 	int rv;
 
@@ -69,9 +73,7 @@ int verify_sockopt_result(int sock_map_fd)
 	rv = bpf_map_lookup_elem(sock_map_fd, &key, &res);
 	EXPECT_EQ(0, rv, "d");
 	EXPECT_EQ(1, res, "d");
-	return 0;
-err:
-	return -1;
+	return ret;
 }
 
 static int bpf_find_map(const char *test, struct bpf_object *obj,
@@ -96,6 +98,7 @@ int main(int argc, char **argv)
 	int error = EXIT_FAILURE;
 	struct bpf_object *obj;
 	int cg_fd = -1;
+	int retry = 10;
 	__u32 key = 0;
 	int rv;
 
@@ -134,12 +137,20 @@ int main(int argc, char **argv)
 	if (sock_map_fd < 0)
 		goto err;
 
+retry_lookup:
 	rv = bpf_map_lookup_elem(map_fd, &key, &g);
 	if (rv != 0) {
 		printf("FAILED: bpf_map_lookup_elem returns %d\n", rv);
 		goto err;
 	}
 
+	if (g.num_close_events != EXPECTED_CLOSE_EVENTS && retry--) {
+		printf("Unexpected number of close events (%d), retrying!\n",
+		       g.num_close_events);
+		usleep(100);
+		goto retry_lookup;
+	}
+
 	if (verify_result(&g)) {
 		printf("FAILED: Wrong stats\n");
 		goto err;
-- 
2.24.0.393.g34dc348eaf-goog

