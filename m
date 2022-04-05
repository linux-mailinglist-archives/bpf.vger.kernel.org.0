Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031294F4D99
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450048AbiDEXqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446430AbiDEPog (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 11:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E78488BC
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 07:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DA160A67
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 14:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F219BC385A4;
        Tue,  5 Apr 2022 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649168133;
        bh=26eUpDS5X0LbP28fq3djkrhwJiEr7QUiBzt7rIliHMY=;
        h=From:To:Cc:Subject:Date:From;
        b=DJyB2YOrY/3bFQ53umDkEgXHQStxbaewXA724hNrbNA4lHQgx/RArTflre0BR+Os3
         FbuNXCVwoCIXuNCmO3TuqHynFxbyzmJD3cNkKQg537fxqDKNM60mJCR/5WQZyaAb3x
         gn12TddaEQoLAxC3nMH+uqN2ONWg/5a2BkQXtY82oGNAKR3OCHj0a4Kb0UHDTCExUo
         wg1aLAReWqW2EG20zFtiQex+SVkVOgkZLZkwg70dhUOJ3MXIx4pc/HBIKguNwRq043
         dsGkkSw7Eq9B1n9xMS5YO9C+aMm0tZpjqLvkwf2/JfgaSujD2rr8X4dLJ9iQQEwagK
         LNuodmTEBfZeA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, lorenzo.bianconi@redhat.com,
        andrii@kernel.org
Subject: [PATCH bpf-next] samples: bpf: xdp_router_ipv4: move routes monitor in a dedicated thread
Date:   Tue,  5 Apr 2022 16:15:14 +0200
Message-Id: <e364b817c69ded73be24b677ab47a157f7c21b64.1649167911.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to not miss any netlink message from the kernel, move routes
monitor to a dedicated thread.

Fixes: 85bf1f51691c ("samples: bpf: Convert xdp_router_ipv4 to XDP samples helper")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 samples/bpf/Makefile               |  2 +-
 samples/bpf/xdp_router_ipv4_user.c | 86 +++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 342a41a10356..8fff5ad3444b 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -219,7 +219,7 @@ TPROGLDLIBS_xdp_redirect	+= -lm
 TPROGLDLIBS_xdp_redirect_cpu	+= -lm
 TPROGLDLIBS_xdp_redirect_map	+= -lm
 TPROGLDLIBS_xdp_redirect_map_multi += -lm
-TPROGLDLIBS_xdp_router_ipv4	+= -lm
+TPROGLDLIBS_xdp_router_ipv4	+= -lm -pthread
 TPROGLDLIBS_tracex4		+= -lrt
 TPROGLDLIBS_trace_output	+= -lrt
 TPROGLDLIBS_map_perf_test	+= -lrt
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 7828784612ec..f32bbd5c32bf 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -25,6 +25,7 @@
 #include <sys/resource.h>
 #include <libgen.h>
 #include <getopt.h>
+#include <pthread.h>
 #include "xdp_sample_user.h"
 #include "xdp_router_ipv4.skel.h"
 
@@ -38,6 +39,9 @@ static int arp_table_map_fd;
 static int exact_match_map_fd;
 static int tx_port_map_fd;
 
+static bool routes_thread_exit;
+static int interval = 5;
+
 static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
 		  SAMPLE_DEVMAP_XMIT_CNT_MULTI | SAMPLE_EXCEPTION_CNT;
 
@@ -445,7 +449,7 @@ static int get_arp_table(int rtm_family)
 /* Function to keep track and update changes in route and arp table
  * Give regular statistics of packets forwarded
  */
-static void monitor_route(void *ctx)
+static void *monitor_routes_thread(void *arg)
 {
 	struct pollfd fds_route, fds_arp;
 	struct sockaddr_nl la, lr;
@@ -455,7 +459,7 @@ static void monitor_route(void *ctx)
 	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 	if (sock < 0) {
 		fprintf(stderr, "open netlink socket: %s\n", strerror(errno));
-		return;
+		return NULL;
 	}
 
 	fcntl(sock, F_SETFL, O_NONBLOCK);
@@ -465,7 +469,7 @@ static void monitor_route(void *ctx)
 	if (bind(sock, (struct sockaddr *)&lr, sizeof(lr)) < 0) {
 		fprintf(stderr, "bind netlink socket: %s\n", strerror(errno));
 		close(sock);
-		return;
+		return NULL;
 	}
 
 	fds_route.fd = sock;
@@ -475,7 +479,7 @@ static void monitor_route(void *ctx)
 	if (sock_arp < 0) {
 		fprintf(stderr, "open netlink socket: %s\n", strerror(errno));
 		close(sock);
-		return;
+		return NULL;
 	}
 
 	fcntl(sock_arp, F_SETFL, O_NONBLOCK);
@@ -490,35 +494,51 @@ static void monitor_route(void *ctx)
 	fds_arp.fd = sock_arp;
 	fds_arp.events = POLL_IN;
 
-	memset(buf, 0, sizeof(buf));
-	if (poll(&fds_route, 1, 3) == POLL_IN) {
-		nll = recv_msg(lr, sock);
-		if (nll < 0) {
-			fprintf(stderr, "recv from netlink: %s\n",
-				strerror(nll));
-			goto cleanup;
-		}
+	/* dump route and arp tables */
+	if (get_arp_table(AF_INET) < 0) {
+		fprintf(stderr, "Failed reading arp table\n");
+		goto cleanup;
+	}
 
-		nh = (struct nlmsghdr *)buf;
-		read_route(nh, nll);
+	if (get_route_table(AF_INET) < 0) {
+		fprintf(stderr, "Failed reading route table\n");
+		goto cleanup;
 	}
 
-	memset(buf, 0, sizeof(buf));
-	if (poll(&fds_arp, 1, 3) == POLL_IN) {
-		nll = recv_msg(la, sock_arp);
-		if (nll < 0) {
-			fprintf(stderr, "recv from netlink: %s\n",
-				strerror(nll));
-			goto cleanup;
+	while (!routes_thread_exit) {
+		memset(buf, 0, sizeof(buf));
+		if (poll(&fds_route, 1, 3) == POLL_IN) {
+			nll = recv_msg(lr, sock);
+			if (nll < 0) {
+				fprintf(stderr, "recv from netlink: %s\n",
+					strerror(nll));
+				goto cleanup;
+			}
+
+			nh = (struct nlmsghdr *)buf;
+			read_route(nh, nll);
 		}
 
-		nh = (struct nlmsghdr *)buf;
-		read_arp(nh, nll);
+		memset(buf, 0, sizeof(buf));
+		if (poll(&fds_arp, 1, 3) == POLL_IN) {
+			nll = recv_msg(la, sock_arp);
+			if (nll < 0) {
+				fprintf(stderr, "recv from netlink: %s\n",
+					strerror(nll));
+				goto cleanup;
+			}
+
+			nh = (struct nlmsghdr *)buf;
+			read_arp(nh, nll);
+		}
+
+		sleep(interval);
 	}
 
 cleanup:
 	close(sock_arp);
 	close(sock);
+	return NULL;
 }
 
 static void usage(char *argv[], const struct option *long_options,
@@ -531,10 +551,11 @@ static void usage(char *argv[], const struct option *long_options,
 int main(int argc, char **argv)
 {
 	bool error = true, generic = false, force = false;
-	int opt, interval = 5, ret = EXIT_FAIL_BPF;
+	int opt, ret = EXIT_FAIL_BPF;
 	struct xdp_router_ipv4 *skel;
 	int i, total_ifindex = argc - 1;
 	char **ifname_list = argv + 1;
+	pthread_t routes_thread;
 	int longindex = 0;
 
 	if (libbpf_set_strict_mode(LIBBPF_STRICT_ALL) < 0) {
@@ -653,24 +674,25 @@ int main(int argc, char **argv)
 			goto end_destroy;
 	}
 
-	if (get_route_table(AF_INET) < 0) {
-		fprintf(stderr, "Failed reading routing table\n");
+	ret = pthread_create(&routes_thread, NULL, monitor_routes_thread, NULL);
+	if (ret) {
+		fprintf(stderr, "Failed creating routes_thread: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
 		goto end_destroy;
 	}
 
-	if (get_arp_table(AF_INET) < 0) {
-		fprintf(stderr, "Failed reading arptable\n");
-		goto end_destroy;
-	}
+	ret = sample_run(interval, NULL, NULL);
+	routes_thread_exit = true;
 
-	ret = sample_run(interval, monitor_route, NULL);
 	if (ret < 0) {
 		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
 		ret = EXIT_FAIL;
-		goto end_destroy;
+		goto end_thread_wait;
 	}
 	ret = EXIT_OK;
 
+end_thread_wait:
+	pthread_join(routes_thread, NULL);
 end_destroy:
 	xdp_router_ipv4__destroy(skel);
 end:
-- 
2.35.1

