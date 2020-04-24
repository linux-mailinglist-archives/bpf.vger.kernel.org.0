Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8BB1B7709
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgDXNek (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 09:34:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41722 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbgDXNej (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Apr 2020 09:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587735275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5DY+lGi8g9w9nCI5Df2cQ081KFUIKCLbmRg5QMsT6I=;
        b=Lavj050mKUh6seZtmzOUHkbvT8wk7DXxm98LFSrMhd0lzjV1028vkKhLkEDm7ZmFH9Nca2
        DZ23wiYz5e7OlEl0K75a/neiUCaZWfQe24hrzyt9NZClbvB47oQUykGkFO6YhCQwszXy+x
        9XA9xx7p3C5RGGIrdHStJEiMOg5FFl8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-KhDEMymqNqaPDs7ZQ7ZxGg-1; Fri, 24 Apr 2020 09:34:33 -0400
X-MC-Unique: KhDEMymqNqaPDs7ZQ7ZxGg-1
Received: by mail-lj1-f198.google.com with SMTP id k15so1798475ljj.5
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 06:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=z5DY+lGi8g9w9nCI5Df2cQ081KFUIKCLbmRg5QMsT6I=;
        b=CrMdXSF63JOYsI6aOBYGq6MNqk7iKnt2W3C9dNGpXOospoHhc6LqIwNnsKv5d4ys1o
         v9vnIUUYQLjA79jraP95Wr0ZLPoWNWSlsBlOxP2gfP9jy+Z4WQPTZDJIE0+VM2iRJq+N
         HKWDNFuTojZ7ryKKmU5vt7R4+p7625pKGkGIgVRtCIPW4GAGVWwZ13kMSiqs8O1CfCqy
         RWjI1QatBNzmVq56IM3AgEK8c6WJ54ErutPQlfk59358Os6M83oQEbgK85P5QP4D0FQQ
         IVHeSTW3+rpGn5qQ5w9LqCnwPN0O+O3T7zKWg8POavsDO/NF69oXGK29p3g5hOrkFBn/
         +J0Q==
X-Gm-Message-State: AGi0PuZHOYCkxLqubZMm/RrgA3vCbEPQYmxSFX0E+AIqmWGiNUVd1Y9u
        np4xS+hKXvyB9o2jFepaiNEZXXh0z6rTsGN9XqVJHOK6TWTVWZH6ADkZvsoh/wo9Wl8ZE3dqC4u
        vUqUqRgEQaxRG
X-Received: by 2002:a2e:990f:: with SMTP id v15mr4890624lji.7.1587735271883;
        Fri, 24 Apr 2020 06:34:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypItklZB3hj62dn5ydT9fqk/Dtcj/tKKOlyYWKTWRgUhYs3IKWDFQmydjDHffySKL5rdeLBu7Q==
X-Received: by 2002:a2e:990f:: with SMTP id v15mr4890605lji.7.1587735271627;
        Fri, 24 Apr 2020 06:34:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b16sm4524073lfj.2.2020.04.24.06.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 06:34:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 63667181501; Fri, 24 Apr 2020 15:34:28 +0200 (CEST)
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for freplace program with
 expected_attach_type
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>
Date:   Fri, 24 Apr 2020 15:34:28 +0200
Message-ID: <158773526831.293902.16011743438619684815.stgit@toke.dk>
In-Reply-To: <158773526726.293902.13257293296560360508.stgit@toke.dk>
References: <158773526726.293902.13257293296560360508.stgit@toke.dk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds a new selftest that tests the ability to attach an freplace
program to a program type that relies on the expected_attach_type of the
target program to pass verification.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |   30 ++++++++++++++++----
 tools/testing/selftests/bpf/progs/connect4_prog.c  |   28 +++++++++++--------
 .../selftests/bpf/progs/freplace_connect4.c        |   18 ++++++++++++
 3 files changed, 58 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_connect4.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index cde463af7071..c2642517e1d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -5,7 +5,8 @@
 static void test_fexit_bpf2bpf_common(const char *obj_file,
 				      const char *target_obj_file,
 				      int prog_cnt,
-				      const char **prog_name)
+				      const char **prog_name,
+				      bool run_prog)
 {
 	struct bpf_object *obj = NULL, *pkt_obj;
 	int err, pkt_fd, i;
@@ -18,7 +19,8 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 
 	err = bpf_prog_load(target_obj_file, BPF_PROG_TYPE_UNSPEC,
 			    &pkt_obj, &pkt_fd);
-	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
+	if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
+		  target_obj_file, err, errno))
 		return;
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
 			    .attach_prog_fd = pkt_fd,
@@ -33,7 +35,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 
 	obj = bpf_object__open_file(obj_file, &opts);
 	if (CHECK(IS_ERR_OR_NULL(obj), "obj_open",
-		  "failed to open fexit_bpf2bpf: %ld\n",
+		  "failed to open %s: %ld\n", obj_file,
 		  PTR_ERR(obj)))
 		goto close_prog;
 
@@ -49,6 +51,10 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 		if (CHECK(IS_ERR(link[i]), "attach_trace", "failed to link\n"))
 			goto close_prog;
 	}
+
+	if (!run_prog)
+		goto close_prog;
+
 	data_map = bpf_object__find_map_by_name(obj, "fexit_bp.bss");
 	if (CHECK(!data_map, "find_data_map", "data map not found\n"))
 		goto close_prog;
@@ -89,7 +95,7 @@ static void test_target_no_callees(void)
 	test_fexit_bpf2bpf_common("./fexit_bpf2bpf_simple.o",
 				  "./test_pkt_md_access.o",
 				  ARRAY_SIZE(prog_name),
-				  prog_name);
+				  prog_name, true);
 }
 
 static void test_target_yes_callees(void)
@@ -103,7 +109,7 @@ static void test_target_yes_callees(void)
 	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.o",
 				  "./test_pkt_access.o",
 				  ARRAY_SIZE(prog_name),
-				  prog_name);
+				  prog_name, true);
 }
 
 static void test_func_replace(void)
@@ -120,7 +126,18 @@ static void test_func_replace(void)
 	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.o",
 				  "./test_pkt_access.o",
 				  ARRAY_SIZE(prog_name),
-				  prog_name);
+				  prog_name, true);
+}
+
+static void test_func_replace_verify(void)
+{
+	const char *prog_name[] = {
+		"freplace/do_bind",
+	};
+	test_fexit_bpf2bpf_common("./freplace_connect4.o",
+				  "./connect4_prog.o",
+				  ARRAY_SIZE(prog_name),
+				  prog_name, false);
 }
 
 void test_fexit_bpf2bpf(void)
@@ -128,4 +145,5 @@ void test_fexit_bpf2bpf(void)
 	test_target_no_callees();
 	test_target_yes_callees();
 	test_func_replace();
+	test_func_replace_verify();
 }
diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index 75085119c5bb..ad3c498a8150 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -18,11 +18,25 @@
 
 int _version SEC("version") = 1;
 
+__attribute__ ((noinline))
+int do_bind(struct bpf_sock_addr *ctx)
+{
+	struct sockaddr_in sa = {};
+
+	sa.sin_family = AF_INET;
+	sa.sin_port = bpf_htons(0);
+	sa.sin_addr.s_addr = bpf_htonl(SRC_REWRITE_IP4);
+
+	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
+		return 0;
+
+	return 1;
+}
+
 SEC("cgroup/connect4")
 int connect_v4_prog(struct bpf_sock_addr *ctx)
 {
 	struct bpf_sock_tuple tuple = {};
-	struct sockaddr_in sa;
 	struct bpf_sock *sk;
 
 	/* Verify that new destination is available. */
@@ -56,17 +70,7 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
 	ctx->user_ip4 = bpf_htonl(DST_REWRITE_IP4);
 	ctx->user_port = bpf_htons(DST_REWRITE_PORT4);
 
-	/* Rewrite source. */
-	memset(&sa, 0, sizeof(sa));
-
-	sa.sin_family = AF_INET;
-	sa.sin_port = bpf_htons(0);
-	sa.sin_addr.s_addr = bpf_htonl(SRC_REWRITE_IP4);
-
-	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
-		return 0;
-
-	return 1;
+	return do_bind(ctx) ? 1 : 0;
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/freplace_connect4.c b/tools/testing/selftests/bpf/progs/freplace_connect4.c
new file mode 100644
index 000000000000..a0ae84230699
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_connect4.c
@@ -0,0 +1,18 @@
+#include <linux/stddef.h>
+#include <linux/ipv6.h>
+#include <linux/bpf.h>
+#include <linux/in.h>
+#include <sys/socket.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+SEC("freplace/do_bind")
+int new_do_bind(struct bpf_sock_addr *ctx)
+{
+  struct sockaddr_in sa = {};
+
+  bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa));
+  return 0;
+}
+
+char _license[] SEC("license") = "GPL";

