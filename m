Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3185D1C6203
	for <lists+bpf@lfdr.de>; Tue,  5 May 2020 22:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgEEU1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729037AbgEEU1o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 May 2020 16:27:44 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F7C061A0F
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 13:27:42 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id fe18so3430064qvb.11
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4tyugyVAAYd9pLHhzPA6LyrLOrFWWfrUrNoaTQVy348=;
        b=T6iFtIik86xhqn09RhVTekWP6onReLV0IvSxqXVtRjTvfxBwO8v3y5fmRuZQRIXTor
         JDhpKmto/5ZtC1Hfo7om0hrYbAE1wYeC5qhvZORelOvWSRvGDeL14wcIf+6OKPr3AS2W
         UX/h0UeTqlLipfHfpdCbRXlmaLAF8n+cROtUyDt/j90OHOGta/E59vM8CQj6niWD2NBJ
         LkHokahqd6tJtB67xWxIJFDHdZSPUvNxouD7Z0wRdopdo7ZjPElf/n0SBxbZrsKaACqu
         2qXNk0qMumJDTQ48ckNjFP8C/h/raG4Odwk7YCnKIY8TX6AdxCh2Yh73qKwfQH/2vHpZ
         Hdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4tyugyVAAYd9pLHhzPA6LyrLOrFWWfrUrNoaTQVy348=;
        b=MgMQDeWp6EkGKiletjnGiP94Cu7U3iVnsr3jsjfSz7Mjcqe5pUM0Mj6MURrjQr+rvw
         Y1bBQyvZoXR0oL03uBu4AacsMZAuHIfosyEoQg2RnVeHmxQGeTJlFl/b3hzfaq90aMtp
         TEkc8BJ5FyFG+yw3pxWM9LGVgGTYz4kovPjYL7NbA714f02Ko5QaJTG17abWw17DwdJq
         REEV/A90IKS0zp98/kLRFMUilP+YYU4EsP7UkZpwvkjgpRFQ/amqvV1vBXjm6yZTKK2A
         3lIjdQ8YggnhYFoBSy08CSNY5dsyS/sZacwTmrhyCY1EL/7sVwEkeYTD8oHlv+kKSHdb
         LQMw==
X-Gm-Message-State: AGi0Pub1r15ppZomGPmadixVGF5VkRQVzNoyDQvHnCXTlz2tbdhqDQUr
        GUraJNeHwXkFsOCICmO6VMRbs1Q=
X-Google-Smtp-Source: APiQypJvXmuPzJYpMvT6NvTN5Toznq2+h7E/GGKYv8xQPA7ndnqtbKBE3jDcVB8fywMEMJRu09mgz/I=
X-Received: by 2002:a0c:f54e:: with SMTP id p14mr4799131qvm.200.1588710461706;
 Tue, 05 May 2020 13:27:41 -0700 (PDT)
Date:   Tue,  5 May 2020 13:27:30 -0700
In-Reply-To: <20200505202730.70489-1-sdf@google.com>
Message-Id: <20200505202730.70489-6-sdf@google.com>
Mime-Version: 1.0
References: <20200505202730.70489-1-sdf@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: move existing common
 networking parts into network_helpers
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

1. Move pkt_v4 and pkt_v6 into network_helpers and adjust the users.
2. Copy-paste spin_lock_thread into two tests that use it.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 17 +++++++++++
 tools/testing/selftests/bpf/network_helpers.h | 29 ++++++++++++++++++
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  1 +
 .../selftests/bpf/prog_tests/flow_dissector.c |  1 +
 .../prog_tests/flow_dissector_load_bytes.c    |  1 +
 .../selftests/bpf/prog_tests/global_data.c    |  1 +
 .../selftests/bpf/prog_tests/kfree_skb.c      |  1 +
 .../selftests/bpf/prog_tests/l4lb_all.c       |  1 +
 .../selftests/bpf/prog_tests/map_lock.c       | 14 +++++++++
 .../selftests/bpf/prog_tests/pkt_access.c     |  1 +
 .../selftests/bpf/prog_tests/pkt_md_access.c  |  1 +
 .../selftests/bpf/prog_tests/prog_run_xattr.c |  1 +
 .../bpf/prog_tests/queue_stack_map.c          |  1 +
 .../selftests/bpf/prog_tests/signal_pending.c |  1 +
 .../selftests/bpf/prog_tests/skb_ctx.c        |  1 +
 .../selftests/bpf/prog_tests/spinlock.c       | 14 +++++++++
 tools/testing/selftests/bpf/prog_tests/xdp.c  |  1 +
 .../bpf/prog_tests/xdp_adjust_tail.c          |  1 +
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  1 +
 .../selftests/bpf/prog_tests/xdp_noinline.c   |  1 +
 tools/testing/selftests/bpf/test_progs.c      | 30 -------------------
 tools/testing/selftests/bpf/test_progs.h      | 23 --------------
 22 files changed, 90 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 30ef0c7edebf..159ca9225596 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -25,6 +25,23 @@
 #define log_err(MSG, ...) fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
 	__FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
 
+struct ipv4_packet pkt_v4 = {
+	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
+	.iph.ihl = 5,
+	.iph.protocol = IPPROTO_TCP,
+	.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+	.tcp.urg_ptr = 123,
+	.tcp.doff = 5,
+};
+
+struct ipv6_packet pkt_v6 = {
+	.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+	.iph.nexthdr = IPPROTO_TCP,
+	.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
+	.tcp.urg_ptr = 123,
+	.tcp.doff = 5,
+};
+
 static int start_server(int family)
 {
 	struct sockaddr_storage addr = {};
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 74e2c40667a2..205123b53a23 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -3,6 +3,35 @@
 #define __NETWORK_HELPERS_H
 #include <sys/socket.h>
 #include <sys/types.h>
+#include <linux/types.h>
+typedef __u16 __sum16;
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <netinet/tcp.h>
+#include <bpf/bpf_endian.h>
+
+#define MAGIC_VAL 0x1234
+#define NUM_ITER 100000
+#define VIP_NUM 5
+#define MAGIC_BYTES 123
+
+/* ipv4 test vector */
+struct ipv4_packet {
+	struct ethhdr eth;
+	struct iphdr iph;
+	struct tcphdr tcp;
+} __packed;
+extern struct ipv4_packet pkt_v4;
+
+/* ipv6 test vector */
+struct ipv6_packet {
+	struct ethhdr eth;
+	struct ipv6hdr iph;
+	struct tcphdr tcp;
+} __packed;
+extern struct ipv6_packet pkt_v6;
 
 int start_server_thread(int family);
 void stop_server_thread(int fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index c2642517e1d8..a895bfed55db 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
+#include <network_helpers.h>
 
 static void test_fexit_bpf2bpf_common(const char *obj_file,
 				      const char *target_obj_file,
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 92563898867c..2301c4d3ecec 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 #include <error.h>
 #include <linux/if.h>
 #include <linux/if_tun.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
index dc5ef155ec28..0e8a4d2f023d 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 void test_flow_dissector_load_bytes(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data.c b/tools/testing/selftests/bpf/prog_tests/global_data.c
index c680926fce73..e3cb62b0a110 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 static void test_global_data_number(struct bpf_object *obj, __u32 duration)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index 7507c8f689bc..42c3a3103c26 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 struct meta {
 	int ifindex;
diff --git a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
index eaf64595be88..c2d373e294bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
+++ b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 static void test_l4lb(const char *file)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/map_lock.c b/tools/testing/selftests/bpf/prog_tests/map_lock.c
index 8f91f1881d11..ce17b1ed8709 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_lock.c
@@ -1,5 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
+
+static void *spin_lock_thread(void *arg)
+{
+	__u32 duration, retval;
+	int err, prog_fd = *(u32 *) arg;
+
+	err = bpf_prog_test_run(prog_fd, 10000, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+	pthread_exit(arg);
+}
 
 static void *parallel_map_access(void *arg)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/pkt_access.c b/tools/testing/selftests/bpf/prog_tests/pkt_access.c
index a2537dfa899c..44b514fabccd 100644
--- a/tools/testing/selftests/bpf/prog_tests/pkt_access.c
+++ b/tools/testing/selftests/bpf/prog_tests/pkt_access.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 void test_pkt_access(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c b/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
index 5f7aea605019..939015cd6dba 100644
--- a/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
+++ b/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 void test_pkt_md_access(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c b/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
index 5dd89b941f53..dde2b7ae7bc9 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 void test_prog_run_xattr(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index faccc66f4e39..f47e7b1cb32c 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 enum {
 	QUEUE,
diff --git a/tools/testing/selftests/bpf/prog_tests/signal_pending.c b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
index 996e808f43a2..dfcbddcbe4d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/signal_pending.c
+++ b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 static void sigalrm_handler(int s) {}
 static struct sigaction sigalrm_action = {
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
index 4538bd08203f..7021b92af313 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 void test_skb_ctx(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/spinlock.c b/tools/testing/selftests/bpf/prog_tests/spinlock.c
index 1ae00cd3174e..7577a77a4c4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/spinlock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spinlock.c
@@ -1,5 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
+
+static void *spin_lock_thread(void *arg)
+{
+	__u32 duration, retval;
+	int err, prog_fd = *(u32 *) arg;
+
+	err = bpf_prog_test_run(prog_fd, 10000, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+	pthread_exit(arg);
+}
 
 void test_spinlock(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp.c b/tools/testing/selftests/bpf/prog_tests/xdp.c
index dcb5ecac778e..48921ff74850 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 void test_xdp(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 3744196d7cba..6c8ca1c93f9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 void test_xdp_adjust_tail(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
index a0f688c37023..2c6c570b21f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 #include <net/if.h>
 #include "test_xdp.skel.h"
 #include "test_xdp_bpf2bpf.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
index c9404e6b226e..f284f72158ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <network_helpers.h>
 
 void test_xdp_noinline(void)
 {
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 93970ec1c9e9..0f411fdc4f6d 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -222,23 +222,6 @@ int test__join_cgroup(const char *path)
 	return fd;
 }
 
-struct ipv4_packet pkt_v4 = {
-	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
-	.iph.ihl = 5,
-	.iph.protocol = IPPROTO_TCP,
-	.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
-	.tcp.urg_ptr = 123,
-	.tcp.doff = 5,
-};
-
-struct ipv6_packet pkt_v6 = {
-	.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
-	.iph.nexthdr = IPPROTO_TCP,
-	.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
-	.tcp.urg_ptr = 123,
-	.tcp.doff = 5,
-};
-
 int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
 {
 	struct bpf_map *map;
@@ -358,19 +341,6 @@ int extract_build_id(char *build_id, size_t size)
 	return -1;
 }
 
-void *spin_lock_thread(void *arg)
-{
-	__u32 duration, retval;
-	int err, prog_fd = *(u32 *) arg;
-
-	err = bpf_prog_test_run(prog_fd, 10000, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
-	pthread_exit(arg);
-}
-
 /* extern declarations for test funcs */
 #define DEFINE_TEST(name) extern void test_##name(void);
 #include <prog_tests/tests.h>
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 10188cc8e9e0..83287c76332b 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -87,24 +87,6 @@ extern void test__skip(void);
 extern void test__fail(void);
 extern int test__join_cgroup(const char *path);
 
-#define MAGIC_BYTES 123
-
-/* ipv4 test vector */
-struct ipv4_packet {
-	struct ethhdr eth;
-	struct iphdr iph;
-	struct tcphdr tcp;
-} __packed;
-extern struct ipv4_packet pkt_v4;
-
-/* ipv6 test vector */
-struct ipv6_packet {
-	struct ethhdr eth;
-	struct ipv6hdr iph;
-	struct tcphdr tcp;
-} __packed;
-extern struct ipv6_packet pkt_v6;
-
 #define PRINT_FAIL(format...)                                                  \
 	({                                                                     \
 		test__fail();                                                  \
@@ -143,10 +125,6 @@ extern struct ipv6_packet pkt_v6;
 #define CHECK_ATTR(condition, tag, format...) \
 	_CHECK(condition, tag, tattr.duration, format)
 
-#define MAGIC_VAL 0x1234
-#define NUM_ITER 100000
-#define VIP_NUM 5
-
 static inline __u64 ptr_to_u64(const void *ptr)
 {
 	return (__u64) (unsigned long) ptr;
@@ -156,7 +134,6 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
 int extract_build_id(char *build_id, size_t size);
-void *spin_lock_thread(void *arg);
 
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
-- 
2.26.2.526.g744177e7f7-goog

