Return-Path: <bpf+bounces-26391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC289EC06
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 09:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6582828C8
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 07:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FACD13CFB9;
	Wed, 10 Apr 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKcdXw2Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301113CFB3;
	Wed, 10 Apr 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734242; cv=none; b=MqHZycsQ4jESSroTea9ZH8kCfHuCxSqcCjnOJJ4hPcZuU9CwGPr5+dpgZKXSZurBHQxsJ2cEaKie9c0TSZqMek+qmlMsIhJYFKrrH03ornBa+CMzj/T2BVxTqO7PxPNJ5+g841JL5pnwsls9SlNkhQLf35hB3jU4bx8bsYBFHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734242; c=relaxed/simple;
	bh=mgqYB1+Oi/BXz0bANvnkyaMwR8Tdhukzp+HALE0rTuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUgPGJXeC9eibGrjg89CiNdDl9w2W7SsCxpK/4W7yULzVIKKOlFmz9pXpPhh5bqpX0V7hpXxHALdREpZcAD2RCcflCN3kbf/Qpl6anowYha3wGNLH+dqlu48ixdRYKYskfSt+WgPlFip7IJ+HQ/shaUaAfR4qujobYBgdQG+New=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKcdXw2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F110AC43394;
	Wed, 10 Apr 2024 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734242;
	bh=mgqYB1+Oi/BXz0bANvnkyaMwR8Tdhukzp+HALE0rTuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKcdXw2ZyfCwdNwosugMQdZI4RNNsdjX+/s+b7K7Fbcv4VZZ5StVcsLvuK6if5E5b
	 8SEEfuyIZrnQ0OYS8imne7oW3ggO5Lyt9HbZsIj/TNmUV8jHd7oebcehK4ID24iUTw
	 E36nALGN8bnHj3Ry2cYmxllhWaZP6KkJwab1Ldyp2dR3ChzKEF2b5yEyOYVyfzW1Gd
	 RO31e7lp6u7rP7PxZrfOGHsTpQyePFXlcwkvFD06n3V0Iy3VAFXS0Hc6wRLuxpQyy3
	 mK7TQ5zwLROvHEQiQ8CUYmo0ABphPO46Pk0ao7FfrfOAn85tvKwfCPc6QtFh6d464V
	 qN0hWnXixieDw==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 07/14] selftests/bpf: Use start_server_addr in test_sock_addr
Date: Wed, 10 Apr 2024 15:29:40 +0800
Message-Id: <2b5dc831a2978669e74415e34d9cf1fb06e31c1c.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in test_sock_addr.c, use the newly added
public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

In order to use functions defined in network_helpers.c, Makefile needs
to be updated and <Linux/err.h> needs to be included in network_helpers.h
to avoid compilation errors.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 tools/testing/selftests/bpf/test_sock_addr.c  | 38 ++-----------------
 3 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index eea5b8deaaf0..60c9edc04f73 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -290,11 +290,12 @@ UNPRIV_HELPERS  := $(OUTPUT)/unpriv_helpers.o
 TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
 JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
+NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 
 $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
-$(OUTPUT)/test_sock_addr: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_sock_addr: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(NETWORK_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/get_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 89f59b65ce76..738b1764f562 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -11,6 +11,7 @@ typedef __u16 __sum16;
 #include <linux/ipv6.h>
 #include <linux/ethtool.h>
 #include <linux/sockios.h>
+#include <linux/err.h>
 #include <netinet/tcp.h>
 #include <bpf/bpf_endian.h>
 #include <net/if.h>
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 80c42583f597..8fa6bec8f7a5 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -19,6 +19,7 @@
 #include <bpf/libbpf.h>
 
 #include "cgroup_helpers.h"
+#include "network_helpers.h"
 #include "testing_helpers.h"
 #include "bpf_util.h"
 
@@ -939,37 +940,6 @@ static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2)
 	return cmp_sock_addr(getpeername, sock1, addr2, /*cmp_port*/ 1);
 }
 
-static int start_server(int type, const struct sockaddr_storage *addr,
-			socklen_t addr_len)
-{
-	int fd;
-
-	fd = socket(addr->ss_family, type, 0);
-	if (fd == -1) {
-		log_err("Failed to create server socket");
-		goto out;
-	}
-
-	if (bind(fd, (const struct sockaddr *)addr, addr_len) == -1) {
-		log_err("Failed to bind server socket");
-		goto close_out;
-	}
-
-	if (type == SOCK_STREAM) {
-		if (listen(fd, 128) == -1) {
-			log_err("Failed to listen on server socket");
-			goto close_out;
-		}
-	}
-
-	goto out;
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static int connect_to_server(int type, const struct sockaddr_storage *addr,
 			     socklen_t addr_len)
 {
@@ -1178,7 +1148,7 @@ static int run_bind_test_case(const struct sock_addr_test *test)
 	if (init_addrs(test, &requested_addr, &expected_addr, NULL))
 		goto err;
 
-	servfd = start_server(test->type, &requested_addr, addr_len);
+	servfd = start_server_addr((struct sockaddr *)&requested_addr, addr_len, test->type);
 	if (servfd == -1)
 		goto err;
 
@@ -1214,7 +1184,7 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 		goto err;
 
 	/* Prepare server to connect to */
-	servfd = start_server(test->type, &expected_addr, addr_len);
+	servfd = start_server_addr((struct sockaddr *)&expected_addr, addr_len, test->type);
 	if (servfd == -1)
 		goto err;
 
@@ -1271,7 +1241,7 @@ static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
 		goto err;
 
 	/* Prepare server to sendmsg to */
-	servfd = start_server(test->type, &server_addr, addr_len);
+	servfd = start_server_addr((struct sockaddr *)&server_addr, addr_len, test->type);
 	if (servfd == -1)
 		goto err;
 
-- 
2.40.1


