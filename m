Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8415494732
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 07:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiATGPC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 01:15:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42862 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1358746AbiATGOm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 01:14:42 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20K5OVbO015987
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:42 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dq1jhg78t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 22:14:42 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 22:14:40 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C79FCFBA1272; Wed, 19 Jan 2022 22:14:33 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/4] samples/bpf: adapt samples/bpf to bpf_xdp_xxx() APIs
Date:   Wed, 19 Jan 2022 22:14:22 -0800
Message-ID: <20220120061422.2710637-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120061422.2710637-1-andrii@kernel.org>
References: <20220120061422.2710637-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hjqzYgi2OWEyY15rZ_eH0sDfsIm9sQEj
X-Proofpoint-GUID: hjqzYgi2OWEyY15rZ_eH0sDfsIm9sQEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=937
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use new bpf_xdp_*() APIs across all XDP-related BPF samples.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 samples/bpf/xdp1_user.c            |  8 ++++----
 samples/bpf/xdp_adjust_tail_user.c |  8 ++++----
 samples/bpf/xdp_fwd_user.c         |  4 ++--
 samples/bpf/xdp_router_ipv4_user.c | 10 +++++-----
 samples/bpf/xdp_rxq_info_user.c    |  8 ++++----
 samples/bpf/xdp_sample_pkts_user.c |  8 ++++----
 samples/bpf/xdp_sample_user.c      |  9 ++++-----
 samples/bpf/xdp_tx_iptunnel_user.c | 10 +++++-----
 samples/bpf/xdpsock_ctrl_proc.c    |  2 +-
 samples/bpf/xdpsock_user.c         | 10 +++++-----
 samples/bpf/xsk_fwd.c              |  4 ++--
 11 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/samples/bpf/xdp1_user.c b/samples/bpf/xdp1_user.c
index 8675fa5273df..3ec8ad9c1750 100644
--- a/samples/bpf/xdp1_user.c
+++ b/samples/bpf/xdp1_user.c
@@ -26,12 +26,12 @@ static void int_exit(int sig)
 {
 	__u32 curr_prog_id = 0;
 
-	if (bpf_get_link_xdp_id(ifindex, &curr_prog_id, xdp_flags)) {
-		printf("bpf_get_link_xdp_id failed\n");
+	if (bpf_xdp_query_id(ifindex, xdp_flags, &curr_prog_id)) {
+		printf("bpf_xdp_query_id failed\n");
 		exit(1);
 	}
 	if (prog_id == curr_prog_id)
-		bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
+		bpf_xdp_detach(ifindex, xdp_flags, NULL);
 	else if (!curr_prog_id)
 		printf("couldn't find a prog id on a given interface\n");
 	else
@@ -143,7 +143,7 @@ int main(int argc, char **argv)
 	signal(SIGINT, int_exit);
 	signal(SIGTERM, int_exit);
 
-	if (bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags) < 0) {
+	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
 		printf("link set xdp fd failed\n");
 		return 1;
 	}
diff --git a/samples/bpf/xdp_adjust_tail_user.c b/samples/bpf/xdp_adjust_tail_user.c
index a70b094c8ec5..6c61d5f570fb 100644
--- a/samples/bpf/xdp_adjust_tail_user.c
+++ b/samples/bpf/xdp_adjust_tail_user.c
@@ -34,12 +34,12 @@ static void int_exit(int sig)
 	__u32 curr_prog_id = 0;
 
 	if (ifindex > -1) {
-		if (bpf_get_link_xdp_id(ifindex, &curr_prog_id, xdp_flags)) {
-			printf("bpf_get_link_xdp_id failed\n");
+		if (bpf_xdp_query_id(ifindex, xdp_flags, &curr_prog_id)) {
+			printf("bpf_xdp_query_id failed\n");
 			exit(1);
 		}
 		if (prog_id == curr_prog_id)
-			bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
+			bpf_xdp_detach(ifindex, xdp_flags, NULL);
 		else if (!curr_prog_id)
 			printf("couldn't find a prog id on a given iface\n");
 		else
@@ -173,7 +173,7 @@ int main(int argc, char **argv)
 	signal(SIGINT, int_exit);
 	signal(SIGTERM, int_exit);
 
-	if (bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags) < 0) {
+	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
 		printf("link set xdp fd failed\n");
 		return 1;
 	}
diff --git a/samples/bpf/xdp_fwd_user.c b/samples/bpf/xdp_fwd_user.c
index 4ad896782f77..79ccd9891924 100644
--- a/samples/bpf/xdp_fwd_user.c
+++ b/samples/bpf/xdp_fwd_user.c
@@ -33,7 +33,7 @@ static int do_attach(int idx, int prog_fd, int map_fd, const char *name)
 {
 	int err;
 
-	err = bpf_set_link_xdp_fd(idx, prog_fd, xdp_flags);
+	err = bpf_xdp_attach(idx, prog_fd, xdp_flags, NULL);
 	if (err < 0) {
 		printf("ERROR: failed to attach program to %s\n", name);
 		return err;
@@ -51,7 +51,7 @@ static int do_detach(int idx, const char *name)
 {
 	int err;
 
-	err = bpf_set_link_xdp_fd(idx, -1, xdp_flags);
+	err = bpf_xdp_detach(idx, xdp_flags, NULL);
 	if (err < 0)
 		printf("ERROR: failed to detach program from %s\n", name);
 
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index cfaf7e50e431..2d565ba54b8c 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -43,13 +43,13 @@ static void int_exit(int sig)
 	int i = 0;
 
 	for (i = 0; i < total_ifindex; i++) {
-		if (bpf_get_link_xdp_id(ifindex_list[i], &prog_id, flags)) {
-			printf("bpf_get_link_xdp_id on iface %d failed\n",
+		if (bpf_xdp_query_id(ifindex_list[i], flags, &prog_id)) {
+			printf("bpf_xdp_query_id on iface %d failed\n",
 			       ifindex_list[i]);
 			exit(1);
 		}
 		if (prog_id_list[i] == prog_id)
-			bpf_set_link_xdp_fd(ifindex_list[i], -1, flags);
+			bpf_xdp_detach(ifindex_list[i], flags, NULL);
 		else if (!prog_id)
 			printf("couldn't find a prog id on iface %d\n",
 			       ifindex_list[i]);
@@ -716,12 +716,12 @@ int main(int ac, char **argv)
 	}
 	prog_id_list = (__u32 *)calloc(total_ifindex, sizeof(__u32 *));
 	for (i = 0; i < total_ifindex; i++) {
-		if (bpf_set_link_xdp_fd(ifindex_list[i], prog_fd, flags) < 0) {
+		if (bpf_xdp_attach(ifindex_list[i], prog_fd, flags, NULL) < 0) {
 			printf("link set xdp fd failed\n");
 			int recovery_index = i;
 
 			for (i = 0; i < recovery_index; i++)
-				bpf_set_link_xdp_fd(ifindex_list[i], -1, flags);
+				bpf_xdp_detach(ifindex_list[i], flags, NULL);
 
 			return 1;
 		}
diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
index 4033f345aa29..fb2532d13aac 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -62,15 +62,15 @@ static void int_exit(int sig)
 	__u32 curr_prog_id = 0;
 
 	if (ifindex > -1) {
-		if (bpf_get_link_xdp_id(ifindex, &curr_prog_id, xdp_flags)) {
-			printf("bpf_get_link_xdp_id failed\n");
+		if (bpf_xdp_query_id(ifindex, xdp_flags, &curr_prog_id)) {
+			printf("bpf_xdp_query_id failed\n");
 			exit(EXIT_FAIL);
 		}
 		if (prog_id == curr_prog_id) {
 			fprintf(stderr,
 				"Interrupted: Removing XDP program on ifindex:%d device:%s\n",
 				ifindex, ifname);
-			bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
+			bpf_xdp_detach(ifindex, xdp_flags, NULL);
 		} else if (!curr_prog_id) {
 			printf("couldn't find a prog id on a given iface\n");
 		} else {
@@ -582,7 +582,7 @@ int main(int argc, char **argv)
 	signal(SIGINT, int_exit);
 	signal(SIGTERM, int_exit);
 
-	if (bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags) < 0) {
+	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
 		fprintf(stderr, "link set xdp fd failed\n");
 		return EXIT_FAIL_XDP;
 	}
diff --git a/samples/bpf/xdp_sample_pkts_user.c b/samples/bpf/xdp_sample_pkts_user.c
index 587eacb49103..0a2b3e997aed 100644
--- a/samples/bpf/xdp_sample_pkts_user.c
+++ b/samples/bpf/xdp_sample_pkts_user.c
@@ -30,7 +30,7 @@ static int do_attach(int idx, int fd, const char *name)
 	__u32 info_len = sizeof(info);
 	int err;
 
-	err = bpf_set_link_xdp_fd(idx, fd, xdp_flags);
+	err = bpf_xdp_attach(idx, fd, xdp_flags, NULL);
 	if (err < 0) {
 		printf("ERROR: failed to attach program to %s\n", name);
 		return err;
@@ -51,13 +51,13 @@ static int do_detach(int idx, const char *name)
 	__u32 curr_prog_id = 0;
 	int err = 0;
 
-	err = bpf_get_link_xdp_id(idx, &curr_prog_id, xdp_flags);
+	err = bpf_xdp_query_id(idx, xdp_flags, &curr_prog_id);
 	if (err) {
-		printf("bpf_get_link_xdp_id failed\n");
+		printf("bpf_xdp_query_id failed\n");
 		return err;
 	}
 	if (prog_id == curr_prog_id) {
-		err = bpf_set_link_xdp_fd(idx, -1, xdp_flags);
+		err = bpf_xdp_detach(idx, xdp_flags, NULL);
 		if (err < 0)
 			printf("ERROR: failed to detach prog from %s\n", name);
 	} else if (!curr_prog_id) {
diff --git a/samples/bpf/xdp_sample_user.c b/samples/bpf/xdp_sample_user.c
index 8740838e7767..ae70a7943d85 100644
--- a/samples/bpf/xdp_sample_user.c
+++ b/samples/bpf/xdp_sample_user.c
@@ -1265,7 +1265,7 @@ static int __sample_remove_xdp(int ifindex, __u32 prog_id, int xdp_flags)
 	int ret;
 
 	if (prog_id) {
-		ret = bpf_get_link_xdp_id(ifindex, &cur_prog_id, xdp_flags);
+		ret = bpf_xdp_query_id(ifindex, xdp_flags, &cur_prog_id);
 		if (ret < 0)
 			return -errno;
 
@@ -1278,7 +1278,7 @@ static int __sample_remove_xdp(int ifindex, __u32 prog_id, int xdp_flags)
 		}
 	}
 
-	return bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
+	return bpf_xdp_detach(ifindex, xdp_flags, NULL);
 }
 
 int sample_install_xdp(struct bpf_program *xdp_prog, int ifindex, bool generic,
@@ -1295,8 +1295,7 @@ int sample_install_xdp(struct bpf_program *xdp_prog, int ifindex, bool generic,
 
 	xdp_flags |= !force ? XDP_FLAGS_UPDATE_IF_NOEXIST : 0;
 	xdp_flags |= generic ? XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE;
-	ret = bpf_set_link_xdp_fd(ifindex, bpf_program__fd(xdp_prog),
-				  xdp_flags);
+	ret = bpf_xdp_attach(ifindex, bpf_program__fd(xdp_prog), xdp_flags, NULL);
 	if (ret < 0) {
 		ret = -errno;
 		fprintf(stderr,
@@ -1308,7 +1307,7 @@ int sample_install_xdp(struct bpf_program *xdp_prog, int ifindex, bool generic,
 		return ret;
 	}
 
-	ret = bpf_get_link_xdp_id(ifindex, &prog_id, xdp_flags);
+	ret = bpf_xdp_query_id(ifindex, xdp_flags, &prog_id);
 	if (ret < 0) {
 		ret = -errno;
 		fprintf(stderr,
diff --git a/samples/bpf/xdp_tx_iptunnel_user.c b/samples/bpf/xdp_tx_iptunnel_user.c
index 1d4f305d02aa..7370c03c96fc 100644
--- a/samples/bpf/xdp_tx_iptunnel_user.c
+++ b/samples/bpf/xdp_tx_iptunnel_user.c
@@ -32,12 +32,12 @@ static void int_exit(int sig)
 	__u32 curr_prog_id = 0;
 
 	if (ifindex > -1) {
-		if (bpf_get_link_xdp_id(ifindex, &curr_prog_id, xdp_flags)) {
-			printf("bpf_get_link_xdp_id failed\n");
+		if (bpf_xdp_query_id(ifindex, xdp_flags, &curr_prog_id)) {
+			printf("bpf_xdp_query_id failed\n");
 			exit(1);
 		}
 		if (prog_id == curr_prog_id)
-			bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
+			bpf_xdp_detach(ifindex, xdp_flags, NULL);
 		else if (!curr_prog_id)
 			printf("couldn't find a prog id on a given iface\n");
 		else
@@ -288,7 +288,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags) < 0) {
+	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
 		printf("link set xdp fd failed\n");
 		return 1;
 	}
@@ -302,7 +302,7 @@ int main(int argc, char **argv)
 
 	poll_stats(kill_after_s);
 
-	bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
+	bpf_xdp_detach(ifindex, xdp_flags, NULL);
 
 	return 0;
 }
diff --git a/samples/bpf/xdpsock_ctrl_proc.c b/samples/bpf/xdpsock_ctrl_proc.c
index cc4408797ab7..28b5f2a9fa08 100644
--- a/samples/bpf/xdpsock_ctrl_proc.c
+++ b/samples/bpf/xdpsock_ctrl_proc.c
@@ -173,7 +173,7 @@ main(int argc, char **argv)
 	unlink(SOCKET_NAME);
 
 	/* Unset fd for given ifindex */
-	err = bpf_set_link_xdp_fd(ifindex, -1, 0);
+	err = bpf_xdp_detach(ifindex, 0, NULL);
 	if (err) {
 		fprintf(stderr, "Error when unsetting bpf prog_fd for ifindex(%d)\n", ifindex);
 		return err;
diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index aa50864e4415..19288a2bbc75 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -571,13 +571,13 @@ static void remove_xdp_program(void)
 {
 	u32 curr_prog_id = 0;
 
-	if (bpf_get_link_xdp_id(opt_ifindex, &curr_prog_id, opt_xdp_flags)) {
-		printf("bpf_get_link_xdp_id failed\n");
+	if (bpf_xdp_query_id(opt_ifindex, opt_xdp_flags, &curr_prog_id)) {
+		printf("bpf_xdp_query_id failed\n");
 		exit(EXIT_FAILURE);
 	}
 
 	if (prog_id == curr_prog_id)
-		bpf_set_link_xdp_fd(opt_ifindex, -1, opt_xdp_flags);
+		bpf_xdp_detach(opt_ifindex, opt_xdp_flags, NULL);
 	else if (!curr_prog_id)
 		printf("couldn't find a prog id on a given interface\n");
 	else
@@ -1027,7 +1027,7 @@ static struct xsk_socket_info *xsk_configure_socket(struct xsk_umem_info *umem,
 	if (ret)
 		exit_with_error(-ret);
 
-	ret = bpf_get_link_xdp_id(opt_ifindex, &prog_id, opt_xdp_flags);
+	ret = bpf_xdp_query_id(opt_ifindex, opt_xdp_flags, &prog_id);
 	if (ret)
 		exit_with_error(-ret);
 
@@ -1760,7 +1760,7 @@ static void load_xdp_program(char **argv, struct bpf_object **obj)
 		exit(EXIT_FAILURE);
 	}
 
-	if (bpf_set_link_xdp_fd(opt_ifindex, prog_fd, opt_xdp_flags) < 0) {
+	if (bpf_xdp_attach(opt_ifindex, prog_fd, opt_xdp_flags, NULL) < 0) {
 		fprintf(stderr, "ERROR: link set xdp fd failed\n");
 		exit(EXIT_FAILURE);
 	}
diff --git a/samples/bpf/xsk_fwd.c b/samples/bpf/xsk_fwd.c
index 52e7c4ffd228..2220509588a0 100644
--- a/samples/bpf/xsk_fwd.c
+++ b/samples/bpf/xsk_fwd.c
@@ -974,8 +974,8 @@ static void remove_xdp_program(void)
 	int i;
 
 	for (i = 0 ; i < n_ports; i++)
-		bpf_set_link_xdp_fd(if_nametoindex(port_params[i].iface), -1,
-				    port_params[i].xsk_cfg.xdp_flags);
+		bpf_xdp_detach(if_nametoindex(port_params[i].iface),
+			       port_params[i].xsk_cfg.xdp_flags, NULL);
 }
 
 int main(int argc, char **argv)
-- 
2.30.2

