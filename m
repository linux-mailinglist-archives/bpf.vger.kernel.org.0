Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8410C4A7B5F
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 23:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347968AbiBBW7k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Feb 2022 17:59:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242439AbiBBW7j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 17:59:39 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212LV8g7026546
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 14:59:39 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dygsu6n2a-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 14:59:39 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:59:38 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 662B7103F6E70; Wed,  2 Feb 2022 14:59:32 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 6/6] samples/bpf: get rid of bpf_prog_load_xattr() use
Date:   Wed, 2 Feb 2022 14:59:16 -0800
Message-ID: <20220202225916.3313522-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202225916.3313522-1-andrii@kernel.org>
References: <20220202225916.3313522-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kHRdVXhKAd0DfrjSrhseRkOyvEEpw7hS
X-Proofpoint-ORIG-GUID: kHRdVXhKAd0DfrjSrhseRkOyvEEpw7hS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=953 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove all the remaining uses of deprecated bpf_prog_load_xattr() API.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 samples/bpf/xdp1_user.c            | 16 +++++++++++-----
 samples/bpf/xdp_adjust_tail_user.c | 17 ++++++++++++-----
 samples/bpf/xdp_fwd_user.c         | 15 +++++++++------
 samples/bpf/xdp_router_ipv4_user.c | 17 ++++++++++-------
 samples/bpf/xdp_rxq_info_user.c    | 16 +++++++++++-----
 samples/bpf/xdp_tx_iptunnel_user.c | 17 ++++++++++-------
 6 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/samples/bpf/xdp1_user.c b/samples/bpf/xdp1_user.c
index 3ec8ad9c1750..631f0cabe139 100644
--- a/samples/bpf/xdp1_user.c
+++ b/samples/bpf/xdp1_user.c
@@ -79,13 +79,11 @@ static void usage(const char *prog)
 
 int main(int argc, char **argv)
 {
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_XDP,
-	};
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	const char *optstr = "FSN";
 	int prog_fd, map_fd, opt;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_map *map;
 	char filename[256];
@@ -123,11 +121,19 @@ int main(int argc, char **argv)
 	}
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj))
+		return 1;
+
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
 
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
+	err = bpf_object__load(obj);
+	if (err)
 		return 1;
 
+	prog_fd = bpf_program__fd(prog);
+
 	map = bpf_object__next_map(obj, NULL);
 	if (!map) {
 		printf("finding a map in obj file failed\n");
diff --git a/samples/bpf/xdp_adjust_tail_user.c b/samples/bpf/xdp_adjust_tail_user.c
index 6c61d5f570fb..b3f6e49676ed 100644
--- a/samples/bpf/xdp_adjust_tail_user.c
+++ b/samples/bpf/xdp_adjust_tail_user.c
@@ -82,15 +82,13 @@ static void usage(const char *cmd)
 
 int main(int argc, char **argv)
 {
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_XDP,
-	};
 	unsigned char opt_flags[256] = {};
 	const char *optstr = "i:T:P:SNFh";
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	unsigned int kill_after_s = 0;
 	int i, prog_fd, map_fd, opt;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	__u32 max_pckt_size = 0;
 	__u32 key = 0;
@@ -148,11 +146,20 @@ int main(int argc, char **argv)
 	}
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
 
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj))
 		return 1;
 
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
+
+	err = bpf_object__load(obj);
+	if (err)
+		return 1;
+
+	prog_fd = bpf_program__fd(prog);
+
 	/* static global var 'max_pcktsz' is accessible from .data section */
 	if (max_pckt_size) {
 		map_fd = bpf_object__find_map_fd_by_name(obj, "xdp_adju.data");
diff --git a/samples/bpf/xdp_fwd_user.c b/samples/bpf/xdp_fwd_user.c
index 79ccd9891924..1828487bae9a 100644
--- a/samples/bpf/xdp_fwd_user.c
+++ b/samples/bpf/xdp_fwd_user.c
@@ -75,14 +75,11 @@ static void usage(const char *prog)
 
 int main(int argc, char **argv)
 {
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_XDP,
-	};
 	const char *prog_name = "xdp_fwd";
 	struct bpf_program *prog = NULL;
 	struct bpf_program *pos;
 	const char *sec_name;
-	int prog_fd, map_fd = -1;
+	int prog_fd = -1, map_fd = -1;
 	char filename[PATH_MAX];
 	struct bpf_object *obj;
 	int opt, i, idx, err;
@@ -119,7 +116,6 @@ int main(int argc, char **argv)
 
 	if (attach) {
 		snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-		prog_load_attr.file = filename;
 
 		if (access(filename, O_RDONLY) < 0) {
 			printf("error accessing file %s: %s\n",
@@ -127,7 +123,14 @@ int main(int argc, char **argv)
 			return 1;
 		}
 
-		err = bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd);
+		obj = bpf_object__open_file(filename, NULL);
+		if (libbpf_get_error(obj))
+			return 1;
+
+		prog = bpf_object__next_program(obj, NULL);
+		bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
+
+		err = bpf_object__load(obj);
 		if (err) {
 			printf("Does kernel support devmap lookup?\n");
 			/* If not, the error message will be:
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 2d565ba54b8c..6dae87d83e1c 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -640,12 +640,10 @@ static void usage(const char *prog)
 
 int main(int ac, char **argv)
 {
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_XDP,
-	};
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	const char *optstr = "SF";
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	char filename[256];
 	char **ifname_list;
@@ -653,7 +651,6 @@ int main(int ac, char **argv)
 	int err, i = 1;
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
 
 	total_ifindex = ac - 1;
 	ifname_list = (argv + 1);
@@ -684,14 +681,20 @@ int main(int ac, char **argv)
 		return 1;
 	}
 
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj))
 		return 1;
 
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
+
 	printf("\n******************loading bpf file*********************\n");
-	if (!prog_fd) {
-		printf("bpf_prog_load_xattr: %s\n", strerror(errno));
+	err = bpf_object__load(obj);
+	if (err) {
+		printf("bpf_object__load(): %s\n", strerror(errno));
 		return 1;
 	}
+	prog_fd = bpf_program__fd(prog);
 
 	lpm_map_fd = bpf_object__find_map_fd_by_name(obj, "lpm_map");
 	rxcnt_map_fd = bpf_object__find_map_fd_by_name(obj, "rxcnt");
diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
index fb2532d13aac..f2d90cba5164 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -450,14 +450,12 @@ static void stats_poll(int interval, int action, __u32 cfg_opt)
 int main(int argc, char **argv)
 {
 	__u32 cfg_options= NO_TOUCH ; /* Default: Don't touch packet memory */
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_XDP,
-	};
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	int prog_fd, map_fd, opt, err;
 	bool use_separators = true;
 	struct config cfg = { 0 };
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_map *map;
 	char filename[256];
@@ -471,11 +469,19 @@ int main(int argc, char **argv)
 	char *action_str = NULL;
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
 
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj))
 		return EXIT_FAIL;
 
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
+
+	err = bpf_object__load(obj);
+	if (err)
+		return EXIT_FAIL;
+	prog_fd = bpf_program__fd(prog);
+
 	map =  bpf_object__find_map_by_name(obj, "config_map");
 	stats_global_map = bpf_object__find_map_by_name(obj, "stats_global_map");
 	rx_queue_index_map = bpf_object__find_map_by_name(obj, "rx_queue_index_map");
diff --git a/samples/bpf/xdp_tx_iptunnel_user.c b/samples/bpf/xdp_tx_iptunnel_user.c
index 7370c03c96fc..2e811e4331cc 100644
--- a/samples/bpf/xdp_tx_iptunnel_user.c
+++ b/samples/bpf/xdp_tx_iptunnel_user.c
@@ -152,9 +152,6 @@ static int parse_ports(const char *port_str, int *min_port, int *max_port)
 
 int main(int argc, char **argv)
 {
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_XDP,
-	};
 	int min_port = 0, max_port = 0, vip2tnl_map_fd;
 	const char *optstr = "i:a:p:s:d:m:T:P:FSNh";
 	unsigned char opt_flags[256] = {};
@@ -162,6 +159,7 @@ int main(int argc, char **argv)
 	__u32 info_len = sizeof(info);
 	unsigned int kill_after_s = 0;
 	struct iptnl_info tnl = {};
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct vip vip = {};
 	char filename[256];
@@ -259,15 +257,20 @@ int main(int argc, char **argv)
 	}
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
 
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj))
 		return 1;
 
-	if (!prog_fd) {
-		printf("bpf_prog_load_xattr: %s\n", strerror(errno));
+	prog = bpf_object__next_program(obj, NULL);
+	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
+
+	err = bpf_object__load(obj);
+	if (err) {
+		printf("bpf_object__load(): %s\n", strerror(errno));
 		return 1;
 	}
+	prog_fd = bpf_program__fd(prog);
 
 	rxcnt_map_fd = bpf_object__find_map_fd_by_name(obj, "rxcnt");
 	vip2tnl_map_fd = bpf_object__find_map_fd_by_name(obj, "vip2tnl");
-- 
2.30.2

