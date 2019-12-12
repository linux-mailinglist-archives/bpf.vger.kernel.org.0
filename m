Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A3B11CA91
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfLLKXS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41302 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfLLKXR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so1259084lfp.8
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyzNgfvIQPsbgWviXx2hMdxr6M+S9mKgdEbf40iED/w=;
        b=jIRzddHbRBp6Z5a/0vbTe/grTLEY4fA1S6jlHv5E4KLbBkl1wsaVhVmzrqCkmZUf0I
         9QkXkj7ejv+jWP11u9omCOEDYX02lrr0/TMPLgr5la6RrQsrgo/b1FLNomQE1GaUpJQC
         E259T/4uL3TAZLWxjGwo0vJJ4tw/xntxKuIWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyzNgfvIQPsbgWviXx2hMdxr6M+S9mKgdEbf40iED/w=;
        b=k8Z6Ttuqdque93DpnRNtlD5nn090Y2dadWWpIu6d1FJRL0mMDwy/gKsdKXpiW1aD74
         fA+s544lEr5M4WpfLEkhnZGfYGu4D0Yfddmf2CuWHY6EAercL4nH0p3x0t6r/NoTLhXO
         xUyJDX8vT2OyJ1HIci/PQYMknjNR2K3QuC1T9ZDJoJ9gHEEYPnQWqYfN65OOFObacnH7
         BDlnlKlzqCMi7ZG64zsu5KJp0gI47a1zbRTwlRi0KqWTSiMeIc7ZEza5Vvh9ZIg+s8kD
         merKCYLNeWhZj64HkNYL33MNuSVwBEzjAwOv50Ei/VRIdTnLW3q50sAvRctW0Dfi2aAG
         wl7g==
X-Gm-Message-State: APjAAAWz/kmxcvmK7Y7ppBgQm5Cxceb/g359JRDbl+nrDd55sXjbUnAI
        IjdUW78rgTSpRCX+NVp+wp+WmJTWy5Y3vg==
X-Google-Smtp-Source: APXvYqwi7CnmftIcPUTvK4YaK4s/c9/tlIe79yRHLt+QRhVqNMJ6HMQ42elhnAXXWz/t7rp2Pemcfg==
X-Received: by 2002:a19:86d7:: with SMTP id i206mr4996057lfd.119.1576146194372;
        Thu, 12 Dec 2019 02:23:14 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id u16sm2983693lfi.36.2019.12.12.02.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:13 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 10/10] selftests/bpf: Switch reuseport tests for test_progs framework
Date:   Thu, 12 Dec 2019 11:22:59 +0100
Message-Id: <20191212102259.418536-11-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The tests were originally written in abort-on-error style. With the switch
to test_progs we can no longer do that. So at the risk of not cleaning up
some resource on failure, we now return to the caller on error.

That said, failure inside one test should not affect others because we run
setup/cleanup before/after every test.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/select_reuseport.c         | 267 +++++++++---------
 1 file changed, 131 insertions(+), 136 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 0d5687feb689..2c37ae7dc214 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -20,8 +20,11 @@
 #include <bpf/libbpf.h>
 #include "bpf_rlimit.h"
 #include "bpf_util.h"
+
+#include "test_progs.h"
 #include "test_select_reuseport_common.h"
 
+#define MAX_TEST_NAME 80
 #define MIN_TCPHDR_LEN 20
 #define UDPHDR_LEN 8
 
@@ -34,9 +37,9 @@ static enum result expected_results[NR_RESULTS];
 static int sk_fds[REUSEPORT_ARRAY_SIZE];
 static int reuseport_array = -1, outer_map = -1;
 static int select_by_skb_data_prog;
-static int saved_tcp_syncookie;
+static int saved_tcp_syncookie = -1;
 static struct bpf_object *obj;
-static int saved_tcp_fo;
+static int saved_tcp_fo = -1;
 static __u32 index_zero;
 static int epfd;
 
@@ -46,20 +49,16 @@ static union sa46 {
 	sa_family_t family;
 } srv_sa;
 
-#define CHECK(condition, tag, format...) ({				\
-	int __ret = !!(condition);					\
-	if (__ret) {							\
-		printf("%s(%d):FAIL:%s ", __func__, __LINE__, tag);	\
-		printf(format);						\
-		exit(-1);						\
+#define RET_IF(condition, tag, format...) ({				\
+	if (CHECK_FAIL(condition)) {					\
+		printf(tag " " format);					\
+		return;							\
 	}								\
 })
 
 #define RET_ERR(condition, tag, format...) ({				\
-	int __ret = !!(condition);					\
-	if (__ret) {							\
-		printf("%s(%d):FAIL:%s ", __func__, __LINE__, tag);	\
-		printf(format);						\
+	if (CHECK_FAIL(condition)) {					\
+		printf(tag " " format);					\
 		return -1;						\
 	}								\
 })
@@ -202,8 +201,10 @@ static int write_int_sysctl(const char *sysctl, int v)
 
 static void restore_sysctls(void)
 {
-	write_int_sysctl(TCP_FO_SYSCTL, saved_tcp_fo);
-	write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, saved_tcp_syncookie);
+	if (saved_tcp_fo != -1)
+		write_int_sysctl(TCP_FO_SYSCTL, saved_tcp_fo);
+	if (saved_tcp_syncookie != -1)
+		write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, saved_tcp_syncookie);
 }
 
 static int enable_fastopen(void)
@@ -227,14 +228,14 @@ static int disable_syncookie(void)
 	return write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, 0);
 }
 
-static __u32 get_linum(void)
+static long get_linum(void)
 {
 	__u32 linum;
 	int err;
 
 	err = bpf_map_lookup_elem(linum_map, &index_zero, &linum);
-	CHECK(err == -1, "lookup_elem(linum_map)", "err:%d errno:%d\n",
-	      err, errno);
+	RET_ERR(err == -1, "lookup_elem(linum_map)", "err:%d errno:%d\n",
+		err, errno);
 
 	return linum;
 }
@@ -250,12 +251,12 @@ static void check_data(int type, sa_family_t family, const struct cmd *cmd,
 	addrlen = sizeof(cli_sa);
 	err = getsockname(cli_fd, (struct sockaddr *)&cli_sa,
 			  &addrlen);
-	CHECK(err == -1, "getsockname(cli_fd)", "err:%d errno:%d\n",
-	      err, errno);
+	RET_IF(err == -1, "getsockname(cli_fd)", "err:%d errno:%d\n",
+	       err, errno);
 
 	err = bpf_map_lookup_elem(data_check_map, &index_zero, &result);
-	CHECK(err == -1, "lookup_elem(data_check_map)", "err:%d errno:%d\n",
-	      err, errno);
+	RET_IF(err == -1, "lookup_elem(data_check_map)", "err:%d errno:%d\n",
+	       err, errno);
 
 	if (type == SOCK_STREAM) {
 		expected.len = MIN_TCPHDR_LEN;
@@ -297,22 +298,22 @@ static void check_data(int type, sa_family_t family, const struct cmd *cmd,
 		printf("expected: (0x%x, %u, %u)\n",
 		       expected.eth_protocol, expected.ip_protocol,
 		       expected.bind_inany);
-		CHECK(1, "data_check result != expected",
-		      "bpf_prog_linum:%u\n", get_linum());
+		RET_IF(1, "data_check result != expected",
+		       "bpf_prog_linum:%ld\n", get_linum());
 	}
 
-	CHECK(!result.hash, "data_check result.hash empty",
-	      "result.hash:%u", result.hash);
+	RET_IF(!result.hash, "data_check result.hash empty",
+	       "result.hash:%u", result.hash);
 
 	expected.len += cmd ? sizeof(*cmd) : 0;
 	if (type == SOCK_STREAM)
-		CHECK(expected.len > result.len, "expected.len > result.len",
-		      "expected.len:%u result.len:%u bpf_prog_linum:%u\n",
-		      expected.len, result.len, get_linum());
+		RET_IF(expected.len > result.len, "expected.len > result.len",
+		       "expected.len:%u result.len:%u bpf_prog_linum:%ld\n",
+		       expected.len, result.len, get_linum());
 	else
-		CHECK(expected.len != result.len, "expected.len != result.len",
-		      "expected.len:%u result.len:%u bpf_prog_linum:%u\n",
-		      expected.len, result.len, get_linum());
+		RET_IF(expected.len != result.len, "expected.len != result.len",
+		       "expected.len:%u result.len:%u bpf_prog_linum:%ld\n",
+		       expected.len, result.len, get_linum());
 }
 
 static void check_results(void)
@@ -323,8 +324,8 @@ static void check_results(void)
 
 	for (i = 0; i < NR_RESULTS; i++) {
 		err = bpf_map_lookup_elem(result_map, &i, &results[i]);
-		CHECK(err == -1, "lookup_elem(result_map)",
-		      "i:%u err:%d errno:%d\n", i, err, errno);
+		RET_IF(err == -1, "lookup_elem(result_map)",
+		       "i:%u err:%d errno:%d\n", i, err, errno);
 	}
 
 	for (i = 0; i < NR_RESULTS; i++) {
@@ -350,10 +351,10 @@ static void check_results(void)
 		printf(", %u", expected_results[i]);
 	printf("]\n");
 
-	CHECK(expected_results[broken] != results[broken],
-	      "unexpected result",
-	      "expected_results[%u] != results[%u] bpf_prog_linum:%u\n",
-	      broken, broken, get_linum());
+	RET_IF(expected_results[broken] != results[broken],
+	       "unexpected result",
+	       "expected_results[%u] != results[%u] bpf_prog_linum:%ld\n",
+	       broken, broken, get_linum());
 }
 
 static int send_data(int type, sa_family_t family, void *data, size_t len,
@@ -363,17 +364,17 @@ static int send_data(int type, sa_family_t family, void *data, size_t len,
 	int fd, err;
 
 	fd = socket(family, type, 0);
-	CHECK(fd == -1, "socket()", "fd:%d errno:%d\n", fd, errno);
+	RET_ERR(fd == -1, "socket()", "fd:%d errno:%d\n", fd, errno);
 
 	sa46_init_loopback(&cli_sa, family);
 	err = bind(fd, (struct sockaddr *)&cli_sa, sizeof(cli_sa));
-	CHECK(fd == -1, "bind(cli_sa)", "err:%d errno:%d\n", err, errno);
+	RET_ERR(fd == -1, "bind(cli_sa)", "err:%d errno:%d\n", err, errno);
 
 	err = sendto(fd, data, len, MSG_FASTOPEN, (struct sockaddr *)&srv_sa,
 		     sizeof(srv_sa));
-	CHECK(err != len && expected >= PASS,
-	      "sendto()", "family:%u err:%d errno:%d expected:%d\n",
-	      family, err, errno, expected);
+	RET_ERR(err != len && expected >= PASS,
+		"sendto()", "family:%u err:%d errno:%d expected:%d\n",
+		family, err, errno, expected);
 
 	return fd;
 }
@@ -388,47 +389,49 @@ static void do_test(int type, sa_family_t family, struct cmd *cmd,
 
 	cli_fd = send_data(type, family, cmd, cmd ? sizeof(*cmd) : 0,
 			   expected);
+	if (cli_fd < 0)
+		return;
 	nev = epoll_wait(epfd, &ev, 1, expected >= PASS ? 5 : 0);
-	CHECK((nev <= 0 && expected >= PASS) ||
-	      (nev > 0 && expected < PASS),
-	      "nev <> expected",
-	      "nev:%d expected:%d type:%d family:%d data:(%d, %d)\n",
-	      nev, expected, type, family,
-	      cmd ? cmd->reuseport_index : -1,
-	      cmd ? cmd->pass_on_failure : -1);
+	RET_IF((nev <= 0 && expected >= PASS) ||
+	       (nev > 0 && expected < PASS),
+	       "nev <> expected",
+	       "nev:%d expected:%d type:%d family:%d data:(%d, %d)\n",
+	       nev, expected, type, family,
+	       cmd ? cmd->reuseport_index : -1,
+	       cmd ? cmd->pass_on_failure : -1);
 	check_results();
 	check_data(type, family, cmd, cli_fd);
 
 	if (expected < PASS)
 		return;
 
-	CHECK(expected != PASS_ERR_SK_SELECT_REUSEPORT &&
-	      cmd->reuseport_index != ev.data.u32,
-	      "check cmd->reuseport_index",
-	      "cmd:(%u, %u) ev.data.u32:%u\n",
-	      cmd->pass_on_failure, cmd->reuseport_index, ev.data.u32);
+	RET_IF(expected != PASS_ERR_SK_SELECT_REUSEPORT &&
+	       cmd->reuseport_index != ev.data.u32,
+	       "check cmd->reuseport_index",
+	       "cmd:(%u, %u) ev.data.u32:%u\n",
+	       cmd->pass_on_failure, cmd->reuseport_index, ev.data.u32);
 
 	srv_fd = sk_fds[ev.data.u32];
 	if (type == SOCK_STREAM) {
 		int new_fd = accept(srv_fd, NULL, 0);
 
-		CHECK(new_fd == -1, "accept(srv_fd)",
-		      "ev.data.u32:%u new_fd:%d errno:%d\n",
-		      ev.data.u32, new_fd, errno);
+		RET_IF(new_fd == -1, "accept(srv_fd)",
+		       "ev.data.u32:%u new_fd:%d errno:%d\n",
+		       ev.data.u32, new_fd, errno);
 
 		nread = recv(new_fd, &rcv_cmd, sizeof(rcv_cmd), MSG_DONTWAIT);
-		CHECK(nread != sizeof(rcv_cmd),
-		      "recv(new_fd)",
-		      "ev.data.u32:%u nread:%zd sizeof(rcv_cmd):%zu errno:%d\n",
-		      ev.data.u32, nread, sizeof(rcv_cmd), errno);
+		RET_IF(nread != sizeof(rcv_cmd),
+		       "recv(new_fd)",
+		       "ev.data.u32:%u nread:%zd sizeof(rcv_cmd):%zu errno:%d\n",
+		       ev.data.u32, nread, sizeof(rcv_cmd), errno);
 
 		close(new_fd);
 	} else {
 		nread = recv(srv_fd, &rcv_cmd, sizeof(rcv_cmd), MSG_DONTWAIT);
-		CHECK(nread != sizeof(rcv_cmd),
-		      "recv(sk_fds)",
-		      "ev.data.u32:%u nread:%zd sizeof(rcv_cmd):%zu errno:%d\n",
-		      ev.data.u32, nread, sizeof(rcv_cmd), errno);
+		RET_IF(nread != sizeof(rcv_cmd),
+		       "recv(sk_fds)",
+		       "ev.data.u32:%u nread:%zd sizeof(rcv_cmd):%zu errno:%d\n",
+		       ev.data.u32, nread, sizeof(rcv_cmd), errno);
 	}
 
 	close(cli_fd);
@@ -443,14 +446,12 @@ static void test_err_inner_map(int type, sa_family_t family)
 
 	expected_results[DROP_ERR_INNER_MAP]++;
 	do_test(type, family, &cmd, DROP_ERR_INNER_MAP);
-	printf("OK\n");
 }
 
 static void test_err_skb_data(int type, sa_family_t family)
 {
 	expected_results[DROP_ERR_SKB_DATA]++;
 	do_test(type, family, NULL, DROP_ERR_SKB_DATA);
-	printf("OK\n");
 }
 
 static void test_err_sk_select_port(int type, sa_family_t family)
@@ -462,7 +463,6 @@ static void test_err_sk_select_port(int type, sa_family_t family)
 
 	expected_results[DROP_ERR_SK_SELECT_REUSEPORT]++;
 	do_test(type, family, &cmd, DROP_ERR_SK_SELECT_REUSEPORT);
-	printf("OK\n");
 }
 
 static void test_pass(int type, sa_family_t family)
@@ -476,7 +476,6 @@ static void test_pass(int type, sa_family_t family)
 		cmd.reuseport_index = i;
 		do_test(type, family, &cmd, PASS);
 	}
-	printf("OK\n");
 }
 
 static void test_syncookie(int type, sa_family_t family)
@@ -505,17 +504,16 @@ static void test_syncookie(int type, sa_family_t family)
 	 */
 	err = bpf_map_update_elem(tmp_index_ovr_map, &index_zero,
 				  &tmp_index, BPF_ANY);
-	CHECK(err == -1, "update_elem(tmp_index_ovr_map, 0, 1)",
-	      "err:%d errno:%d\n", err, errno);
+	RET_IF(err == -1, "update_elem(tmp_index_ovr_map, 0, 1)",
+	       "err:%d errno:%d\n", err, errno);
 	do_test(type, family, &cmd, PASS);
 	err = bpf_map_lookup_elem(tmp_index_ovr_map, &index_zero,
 				  &tmp_index);
-	CHECK(err == -1 || tmp_index != -1,
-	      "lookup_elem(tmp_index_ovr_map)",
-	      "err:%d errno:%d tmp_index:%d\n",
-	      err, errno, tmp_index);
+	RET_IF(err == -1 || tmp_index != -1,
+	       "lookup_elem(tmp_index_ovr_map)",
+	       "err:%d errno:%d tmp_index:%d\n",
+	       err, errno, tmp_index);
 	disable_syncookie();
-	printf("OK\n");
 }
 
 static void test_pass_on_err(int type, sa_family_t family)
@@ -527,7 +525,6 @@ static void test_pass_on_err(int type, sa_family_t family)
 
 	expected_results[PASS_ERR_SK_SELECT_REUSEPORT] += 1;
 	do_test(type, family, &cmd, PASS_ERR_SK_SELECT_REUSEPORT);
-	printf("OK\n");
 }
 
 static void test_detach_bpf(int type, sa_family_t family)
@@ -541,43 +538,45 @@ static void test_detach_bpf(int type, sa_family_t family)
 
 	err = setsockopt(sk_fds[0], SOL_SOCKET, SO_DETACH_REUSEPORT_BPF,
 			 &optvalue, sizeof(optvalue));
-	CHECK(err == -1, "setsockopt(SO_DETACH_REUSEPORT_BPF)",
-	      "err:%d errno:%d\n", err, errno);
+	RET_IF(err == -1, "setsockopt(SO_DETACH_REUSEPORT_BPF)",
+	       "err:%d errno:%d\n", err, errno);
 
 	err = setsockopt(sk_fds[1], SOL_SOCKET, SO_DETACH_REUSEPORT_BPF,
 			 &optvalue, sizeof(optvalue));
-	CHECK(err == 0 || errno != ENOENT, "setsockopt(SO_DETACH_REUSEPORT_BPF)",
-	      "err:%d errno:%d\n", err, errno);
+	RET_IF(err == 0 || errno != ENOENT,
+	       "setsockopt(SO_DETACH_REUSEPORT_BPF)",
+	       "err:%d errno:%d\n", err, errno);
 
 	for (i = 0; i < NR_RESULTS; i++) {
 		err = bpf_map_lookup_elem(result_map, &i, &tmp);
-		CHECK(err == -1, "lookup_elem(result_map)",
-		      "i:%u err:%d errno:%d\n", i, err, errno);
+		RET_IF(err == -1, "lookup_elem(result_map)",
+		       "i:%u err:%d errno:%d\n", i, err, errno);
 		nr_run_before += tmp;
 	}
 
 	cli_fd = send_data(type, family, &cmd, sizeof(cmd), PASS);
+	if (cli_fd < 0)
+		return;
 	nev = epoll_wait(epfd, &ev, 1, 5);
-	CHECK(nev <= 0, "nev <= 0",
-	      "nev:%d expected:1 type:%d family:%d data:(0, 0)\n",
-	      nev,  type, family);
+	RET_IF(nev <= 0, "nev <= 0",
+	       "nev:%d expected:1 type:%d family:%d data:(0, 0)\n",
+	       nev,  type, family);
 
 	for (i = 0; i < NR_RESULTS; i++) {
 		err = bpf_map_lookup_elem(result_map, &i, &tmp);
-		CHECK(err == -1, "lookup_elem(result_map)",
-		      "i:%u err:%d errno:%d\n", i, err, errno);
+		RET_IF(err == -1, "lookup_elem(result_map)",
+		       "i:%u err:%d errno:%d\n", i, err, errno);
 		nr_run_after += tmp;
 	}
 
-	CHECK(nr_run_before != nr_run_after,
-	      "nr_run_before != nr_run_after",
-	      "nr_run_before:%u nr_run_after:%u\n",
-	      nr_run_before, nr_run_after);
+	RET_IF(nr_run_before != nr_run_after,
+	       "nr_run_before != nr_run_after",
+	       "nr_run_before:%u nr_run_after:%u\n",
+	       nr_run_before, nr_run_after);
 
-	printf("OK\n");
 	close(cli_fd);
 #else
-	printf("SKIP\n");
+	test__skip();
 #endif
 }
 
@@ -600,58 +599,58 @@ static void prepare_sk_fds(int type, sa_family_t family, bool inany)
 	 */
 	for (i = first; i >= 0; i--) {
 		sk_fds[i] = socket(family, type, 0);
-		CHECK(sk_fds[i] == -1, "socket()", "sk_fds[%d]:%d errno:%d\n",
-		      i, sk_fds[i], errno);
+		RET_IF(sk_fds[i] == -1, "socket()", "sk_fds[%d]:%d errno:%d\n",
+		       i, sk_fds[i], errno);
 		err = setsockopt(sk_fds[i], SOL_SOCKET, SO_REUSEPORT,
 				 &optval, sizeof(optval));
-		CHECK(err == -1, "setsockopt(SO_REUSEPORT)",
-		      "sk_fds[%d] err:%d errno:%d\n",
-		      i, err, errno);
+		RET_IF(err == -1, "setsockopt(SO_REUSEPORT)",
+		       "sk_fds[%d] err:%d errno:%d\n",
+		       i, err, errno);
 
 		if (i == first) {
 			err = setsockopt(sk_fds[i], SOL_SOCKET,
 					 SO_ATTACH_REUSEPORT_EBPF,
 					 &select_by_skb_data_prog,
 					 sizeof(select_by_skb_data_prog));
-			CHECK(err == -1, "setsockopt(SO_ATTACH_REUEPORT_EBPF)",
-			      "err:%d errno:%d\n", err, errno);
+			RET_IF(err == -1, "setsockopt(SO_ATTACH_REUEPORT_EBPF)",
+			       "err:%d errno:%d\n", err, errno);
 		}
 
 		err = bind(sk_fds[i], (struct sockaddr *)&srv_sa, addrlen);
-		CHECK(err == -1, "bind()", "sk_fds[%d] err:%d errno:%d\n",
-		      i, err, errno);
+		RET_IF(err == -1, "bind()", "sk_fds[%d] err:%d errno:%d\n",
+		       i, err, errno);
 
 		if (type == SOCK_STREAM) {
 			err = listen(sk_fds[i], 10);
-			CHECK(err == -1, "listen()",
-			      "sk_fds[%d] err:%d errno:%d\n",
-			      i, err, errno);
+			RET_IF(err == -1, "listen()",
+			       "sk_fds[%d] err:%d errno:%d\n",
+			       i, err, errno);
 		}
 
 		err = bpf_map_update_elem(reuseport_array, &i, &sk_fds[i],
 					  BPF_NOEXIST);
-		CHECK(err == -1, "update_elem(reuseport_array)",
-		      "sk_fds[%d] err:%d errno:%d\n", i, err, errno);
+		RET_IF(err == -1, "update_elem(reuseport_array)",
+		       "sk_fds[%d] err:%d errno:%d\n", i, err, errno);
 
 		if (i == first) {
 			socklen_t addrlen = sizeof(srv_sa);
 
 			err = getsockname(sk_fds[i], (struct sockaddr *)&srv_sa,
 					  &addrlen);
-			CHECK(err == -1, "getsockname()",
-			      "sk_fds[%d] err:%d errno:%d\n", i, err, errno);
+			RET_IF(err == -1, "getsockname()",
+			       "sk_fds[%d] err:%d errno:%d\n", i, err, errno);
 		}
 	}
 
 	epfd = epoll_create(1);
-	CHECK(epfd == -1, "epoll_create(1)",
-	      "epfd:%d errno:%d\n", epfd, errno);
+	RET_IF(epfd == -1, "epoll_create(1)",
+	       "epfd:%d errno:%d\n", epfd, errno);
 
 	ev.events = EPOLLIN;
 	for (i = 0; i < REUSEPORT_ARRAY_SIZE; i++) {
 		ev.data.u32 = i;
 		err = epoll_ctl(epfd, EPOLL_CTL_ADD, sk_fds[i], &ev);
-		CHECK(err, "epoll_ctl(EPOLL_CTL_ADD)", "sk_fds[%d]\n", i);
+		RET_IF(err, "epoll_ctl(EPOLL_CTL_ADD)", "sk_fds[%d]\n", i);
 	}
 }
 
@@ -663,8 +662,8 @@ static void setup_per_test(int type, sa_family_t family, bool inany,
 	prepare_sk_fds(type, family, inany);
 	err = bpf_map_update_elem(tmp_index_ovr_map, &index_zero, &ovr,
 				  BPF_ANY);
-	CHECK(err == -1, "update_elem(tmp_index_ovr_map, 0, -1)",
-	      "err:%d errno:%d\n", err, errno);
+	RET_IF(err == -1, "update_elem(tmp_index_ovr_map, 0, -1)",
+	       "err:%d errno:%d\n", err, errno);
 
 	/* Install reuseport_array to outer_map? */
 	if (no_inner_map)
@@ -672,8 +671,8 @@ static void setup_per_test(int type, sa_family_t family, bool inany,
 
 	err = bpf_map_update_elem(outer_map, &index_zero, &reuseport_array,
 				  BPF_ANY);
-	CHECK(err == -1, "update_elem(outer_map, 0, reuseport_array)",
-	      "err:%d errno:%d\n", err, errno);
+	RET_IF(err == -1, "update_elem(outer_map, 0, reuseport_array)",
+	       "err:%d errno:%d\n", err, errno);
 }
 
 static void cleanup_per_test(bool no_inner_map)
@@ -689,8 +688,8 @@ static void cleanup_per_test(bool no_inner_map)
 		return;
 
 	err = bpf_map_delete_elem(outer_map, &index_zero);
-	CHECK(err == -1, "delete_elem(outer_map)",
-	      "err:%d errno:%d\n", err, errno);
+	RET_IF(err == -1, "delete_elem(outer_map)",
+	       "err:%d errno:%d\n", err, errno);
 }
 
 static void cleanup(void)
@@ -729,7 +728,7 @@ static const char *sotype_str(int sotype)
 
 #define TEST_INIT(fn, ...) { fn, #fn, __VA_ARGS__ }
 
-static void test_config(int type, sa_family_t family, bool inany)
+static void test_config(int sotype, sa_family_t family, bool inany)
 {
 	const struct test {
 		void (*fn)(int sotype, sa_family_t family);
@@ -744,20 +743,21 @@ static void test_config(int type, sa_family_t family, bool inany)
 		TEST_INIT(test_pass_on_err),
 		TEST_INIT(test_detach_bpf),
 	};
+	char s[MAX_TEST_NAME];
 	const struct test *t;
 
-	printf("######## %s/%s %s ########\n",
-	       family_str(family), sotype_str(type),
-	       inany ? " INANY  " : "LOOPBACK");
-
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
-		setup_per_test(type, family, inany, t->no_inner_map);
-		printf("%s: ", t->name);
-		t->fn(type, family);
+		snprintf(s, sizeof(s), "%s/%s %s %s",
+			 family_str(family), sotype_str(sotype),
+			 inany ? "INANY" : "LOOPBACK", t->name);
+
+		if (!test__start_subtest(s))
+			continue;
+
+		setup_per_test(sotype, family, inany, t->no_inner_map);
+		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
 	}
-
-	printf("\n");
 }
 
 #define BIND_INANY true
@@ -782,10 +782,8 @@ static void test_all(void)
 		test_config(c->sotype, c->family, c->inany);
 }
 
-int main(int argc, const char **argv)
+void test_select_reuseport(void)
 {
-	int ret = EXIT_FAILURE;
-
 	if (create_maps())
 		goto out;
 	if (prepare_bpf_obj())
@@ -795,7 +793,6 @@ int main(int argc, const char **argv)
 	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
 	if (saved_tcp_syncookie < 0 || saved_tcp_syncookie < 0)
 		goto out;
-	atexit(restore_sysctls);
 
 	if (enable_fastopen())
 		goto out;
@@ -803,9 +800,7 @@ int main(int argc, const char **argv)
 		goto out;
 
 	test_all();
-
-	ret = EXIT_SUCCESS;
 out:
 	cleanup();
-	return ret;
+	restore_sysctls();
 }
-- 
2.23.0

