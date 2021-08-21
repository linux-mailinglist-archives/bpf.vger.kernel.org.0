Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3CE3F37B0
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 02:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbhHUAWT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 20:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbhHUAWA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 20:22:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560E6C06129D;
        Fri, 20 Aug 2021 17:21:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so10022150pfh.9;
        Fri, 20 Aug 2021 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrMt3U8f97frBzPiUn9aFNzTRpBQvJz92VPHL9hUUkk=;
        b=Frw1iSqv/C2VQQ0pK4yqic8qSNacya2dI7Id4a2ffOsdG++O4XKeJdKPkIwARwMnYv
         BOe6BWnZm/syvhKH4JoyB1SXgcA3mZmiQgG8KRS+yRJ+4sWeGnqm753I8SPJpFvgppCu
         WaPEBIc1AdtTacFyYglWWXfJMKwmvg8MTFjYgzeP45VNJwuxqslCLylsG9v/XRQ6TFy7
         IIi4IFIIDJRMaz5LID/iQ2Hhu5F9HJTuWd2k5iv4g5ad8nQ8Eap8LBt9DQ4bFjFTgDvA
         0jJyaFSuW6q2JC7pijwiqBNa8OCVztIBuRQgXKNpfK6AhCzjnFnHdqbOeOUv4Pw9js3Y
         2h7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrMt3U8f97frBzPiUn9aFNzTRpBQvJz92VPHL9hUUkk=;
        b=UMguoGwv2FyOXO0vn3JDB6n/9EbfrdLCjKl8gt8Cvm6PV0vJ03yX1FyvDi91TLgpjE
         401ozC6eE75BUlXEghFz1k1MdZ4qKjKMKrIGttupqldP6Lr3PjwaHk4Eg7TIJlL25/oy
         gCVDyulCR8aapYQ6WttXoANguF5tFhY0anJgWpIQFmjL3I0nilOshQGtLQQr7mVJiJMD
         rKtnwLTqczZ0Ruel5IA6U+YVUatXa4XKV27SV/gzBXvPjHGuUEkqRDFtfAztolZXZWIJ
         WdGzaJIozE9S3RUnaeM7xwj94wtnPYlMjeQIPYUdSNVwHxTXZHlcnopLzOk89sLD8NkF
         PDWg==
X-Gm-Message-State: AOAM532Aq2aKovav7bptPGwWiusvlBnr9G88Da2a1TjBrL900k2rZ3g1
        fDV4KDLk1Zj9XhfiUcA6P9ysyeIVgLE=
X-Google-Smtp-Source: ABdhPJz/r52nL8/hPOIDGgxY4mgnwzBFxM54HO74SfU6sJ5Tocu9ne/l0CQOK/pvbd+OXxE6HvUVFg==
X-Received: by 2002:a05:6a00:2295:b0:3e2:2cf5:47b9 with SMTP id f21-20020a056a00229500b003e22cf547b9mr22277460pfe.1.1629505281603;
        Fri, 20 Aug 2021 17:21:21 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id a20sm12324861pjh.46.2021.08.20.17.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 17:21:21 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 22/22] samples: bpf: Convert xdp_redirect_map_multi to XDP samples helper
Date:   Sat, 21 Aug 2021 05:50:10 +0530
Message-Id: <20210821002010.845777-23-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210821002010.845777-1-memxor@gmail.com>
References: <20210821002010.845777-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the libbpf skeleton facility and other utilities provided by XDP
samples helper. Also adapt to change of type of mac address map, so that
no resizing is required.

Add a new flag for sample mask that skips priting the
from_device->to_device heading for each line, as xdp_redirect_map_multi
may have two devices but the flow of data may be bidirectional, so the
output would be confusing.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/Makefile                      |   5 +-
 samples/bpf/xdp_redirect_map_multi_user.c | 345 +++++++++-------------
 samples/bpf/xdp_sample_user.c             |   2 +-
 samples/bpf/xdp_sample_user.h             |  21 +-
 4 files changed, 153 insertions(+), 220 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 2b3d9e39c4f3..4dc20be5fb96 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -39,7 +39,6 @@ tprogs-y += lwt_len_hist
 tprogs-y += xdp_tx_iptunnel
 tprogs-y += test_map_in_map
 tprogs-y += per_socket_stats_example
-tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_rxq_info
 tprogs-y += syscall_tp
 tprogs-y += cpustat
@@ -54,6 +53,7 @@ tprogs-y += ibumad
 tprogs-y += hbm
 
 tprogs-y += xdp_redirect_cpu
+tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect
 tprogs-y += xdp_monitor
@@ -100,7 +100,6 @@ lwt_len_hist-objs := lwt_len_hist_user.o
 xdp_tx_iptunnel-objs := xdp_tx_iptunnel_user.o
 test_map_in_map-objs := test_map_in_map_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
-xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o
 xdp_rxq_info-objs := xdp_rxq_info_user.o
 syscall_tp-objs := syscall_tp_user.o
 cpustat-objs := cpustat_user.o
@@ -114,6 +113,7 @@ xdp_sample_pkts-objs := xdp_sample_pkts_user.o
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
+xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o $(XDP_SAMPLE)
 xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o $(XDP_SAMPLE)
 xdp_redirect_map-objs := xdp_redirect_map_user.o $(XDP_SAMPLE)
 xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
@@ -310,6 +310,7 @@ $(BPF_SAMPLES_PATH)/*.c: verify_target_bpf $(LIBBPF)
 $(src)/*.c: verify_target_bpf $(LIBBPF)
 
 $(obj)/xdp_redirect_cpu_user.o: $(obj)/xdp_redirect_cpu.skel.h
+$(obj)/xdp_redirect_map_multi_user.o: $(obj)/xdp_redirect_map_multi.skel.h
 $(obj)/xdp_redirect_map_user.o: $(obj)/xdp_redirect_map.skel.h
 $(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
 $(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
diff --git a/samples/bpf/xdp_redirect_map_multi_user.c b/samples/bpf/xdp_redirect_map_multi_user.c
index 84cdbbed20b7..315314716121 100644
--- a/samples/bpf/xdp_redirect_map_multi_user.c
+++ b/samples/bpf/xdp_redirect_map_multi_user.c
@@ -1,7 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+static const char *__doc__ =
+"XDP multi redirect tool, using BPF_MAP_TYPE_DEVMAP and BPF_F_BROADCAST flag for bpf_redirect_map\n"
+"Usage: xdp_redirect_map_multi <IFINDEX|IFNAME> <IFINDEX|IFNAME> ... <IFINDEX|IFNAME>\n";
+
 #include <linux/bpf.h>
 #include <linux/if_link.h>
 #include <assert.h>
+#include <getopt.h>
 #include <errno.h>
 #include <signal.h>
 #include <stdio.h>
@@ -15,106 +20,54 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
-
-#include "bpf_util.h"
+#include <linux/if_ether.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include "bpf_util.h"
+#include "xdp_sample_user.h"
+#include "xdp_redirect_map_multi.skel.h"
 
 #define MAX_IFACE_NUM 32
-
-static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
 static int ifaces[MAX_IFACE_NUM] = {};
-static int rxcnt_map_fd;
-
-static void int_exit(int sig)
-{
-	__u32 prog_id = 0;
-	int i;
-
-	for (i = 0; ifaces[i] > 0; i++) {
-		if (bpf_get_link_xdp_id(ifaces[i], &prog_id, xdp_flags)) {
-			printf("bpf_get_link_xdp_id failed\n");
-			exit(1);
-		}
-		if (prog_id)
-			bpf_set_link_xdp_fd(ifaces[i], -1, xdp_flags);
-	}
-
-	exit(0);
-}
-
-static void poll_stats(int interval)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	__u64 values[nr_cpus], prev[nr_cpus];
-
-	memset(prev, 0, sizeof(prev));
-
-	while (1) {
-		__u64 sum = 0;
-		__u32 key = 0;
-		int i;
 
-		sleep(interval);
-		assert(bpf_map_lookup_elem(rxcnt_map_fd, &key, values) == 0);
-		for (i = 0; i < nr_cpus; i++)
-			sum += (values[i] - prev[i]);
-		if (sum)
-			printf("Forwarding %10llu pkt/s\n", sum / interval);
-		memcpy(prev, values, sizeof(values));
-	}
-}
-
-static int get_mac_addr(unsigned int ifindex, void *mac_addr)
-{
-	char ifname[IF_NAMESIZE];
-	struct ifreq ifr;
-	int fd, ret = -1;
-
-	fd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (fd < 0)
-		return ret;
-
-	if (!if_indextoname(ifindex, ifname))
-		goto err_out;
-
-	strcpy(ifr.ifr_name, ifname);
+static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
+		  SAMPLE_EXCEPTION_CNT | SAMPLE_DEVMAP_XMIT_CNT |
+		  SAMPLE_DEVMAP_XMIT_CNT_MULTI | SAMPLE_SKIP_HEADING;
 
-	if (ioctl(fd, SIOCGIFHWADDR, &ifr) != 0)
-		goto err_out;
+DEFINE_SAMPLE_INIT(xdp_redirect_map_multi);
 
-	memcpy(mac_addr, ifr.ifr_hwaddr.sa_data, 6 * sizeof(char));
-	ret = 0;
+static const struct option long_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+	{ "skb-mode", no_argument, NULL, 'S' },
+	{ "force", no_argument, NULL, 'F' },
+	{ "load-egress", no_argument, NULL, 'X' },
+	{ "stats", no_argument, NULL, 's' },
+	{ "interval", required_argument, NULL, 'i' },
+	{ "verbose", no_argument, NULL, 'v' },
+	{}
+};
 
-err_out:
-	close(fd);
-	return ret;
-}
-
-static int update_mac_map(struct bpf_object *obj)
+static int update_mac_map(struct bpf_map *map)
 {
-	int i, ret = -1, mac_map_fd;
+	int mac_map_fd = bpf_map__fd(map);
 	unsigned char mac_addr[6];
 	unsigned int ifindex;
-
-	mac_map_fd = bpf_object__find_map_fd_by_name(obj, "mac_map");
-	if (mac_map_fd < 0) {
-		printf("find mac map fd failed\n");
-		return ret;
-	}
+	int i, ret = -1;
 
 	for (i = 0; ifaces[i] > 0; i++) {
 		ifindex = ifaces[i];
 
 		ret = get_mac_addr(ifindex, mac_addr);
 		if (ret < 0) {
-			printf("get interface %d mac failed\n", ifindex);
+			fprintf(stderr, "get interface %d mac failed\n",
+				ifindex);
 			return ret;
 		}
 
 		ret = bpf_map_update_elem(mac_map_fd, &ifindex, mac_addr, 0);
-		if (ret) {
-			perror("bpf_update_elem mac_map_fd");
+		if (ret < 0) {
+			fprintf(stderr, "Failed to update mac address for ifindex %d\n",
+				ifindex);
 			return ret;
 		}
 	}
@@ -122,181 +75,159 @@ static int update_mac_map(struct bpf_object *obj)
 	return 0;
 }
 
-static void usage(const char *prog)
-{
-	fprintf(stderr,
-		"usage: %s [OPTS] <IFNAME|IFINDEX> <IFNAME|IFINDEX> ...\n"
-		"OPTS:\n"
-		"    -S    use skb-mode\n"
-		"    -N    enforce native mode\n"
-		"    -F    force loading prog\n"
-		"    -X    load xdp program on egress\n",
-		prog);
-}
-
 int main(int argc, char **argv)
 {
-	int i, ret, opt, forward_map_fd, max_ifindex = 0;
-	struct bpf_program *ingress_prog, *egress_prog;
-	int ingress_prog_fd, egress_prog_fd = 0;
-	struct bpf_devmap_val devmap_val;
-	bool attach_egress_prog = false;
+	struct bpf_devmap_val devmap_val = {};
+	struct xdp_redirect_map_multi *skel;
+	struct bpf_program *ingress_prog;
+	bool xdp_devmap_attached = false;
+	struct bpf_map *forward_map;
+	int ret = EXIT_FAIL_OPTION;
+	unsigned long interval = 2;
 	char ifname[IF_NAMESIZE];
-	struct bpf_map *mac_map;
-	struct bpf_object *obj;
 	unsigned int ifindex;
-	char filename[256];
-
-	while ((opt = getopt(argc, argv, "SNFX")) != -1) {
+	bool generic = false;
+	bool force = false;
+	bool tried = false;
+	bool error = true;
+	int i, opt;
+
+	while ((opt = getopt_long(argc, argv, "hSFXi:vs",
+				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'S':
-			xdp_flags |= XDP_FLAGS_SKB_MODE;
-			break;
-		case 'N':
-			/* default, set below */
+			generic = true;
+			/* devmap_xmit tracepoint not available */
+			mask &= ~(SAMPLE_DEVMAP_XMIT_CNT |
+				  SAMPLE_DEVMAP_XMIT_CNT_MULTI);
 			break;
 		case 'F':
-			xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
+			force = true;
 			break;
 		case 'X':
-			attach_egress_prog = true;
+			xdp_devmap_attached = true;
+			break;
+		case 'i':
+			interval = strtoul(optarg, NULL, 0);
+			break;
+		case 'v':
+			sample_switch_mode();
 			break;
+		case 's':
+			mask |= SAMPLE_REDIRECT_MAP_CNT;
+			break;
+		case 'h':
+			error = false;
 		default:
-			usage(basename(argv[0]));
-			return 1;
+			sample_usage(argv, long_options, __doc__, mask, error);
+			return ret;
 		}
 	}
 
-	if (!(xdp_flags & XDP_FLAGS_SKB_MODE)) {
-		xdp_flags |= XDP_FLAGS_DRV_MODE;
-	} else if (attach_egress_prog) {
-		printf("Load xdp program on egress with SKB mode not supported yet\n");
-		return 1;
+	if (argc <= optind + 1) {
+		sample_usage(argv, long_options, __doc__, mask, error);
+		return ret;
 	}
 
-	if (optind == argc) {
-		printf("usage: %s <IFNAME|IFINDEX> <IFNAME|IFINDEX> ...\n", argv[0]);
-		return 1;
+	skel = xdp_redirect_map_multi__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to xdp_redirect_map_multi__open: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end;
 	}
 
-	printf("Get interfaces");
+	ret = sample_init_pre_load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
+	}
+
+	ret = EXIT_FAIL_OPTION;
 	for (i = 0; i < MAX_IFACE_NUM && argv[optind + i]; i++) {
 		ifaces[i] = if_nametoindex(argv[optind + i]);
 		if (!ifaces[i])
 			ifaces[i] = strtoul(argv[optind + i], NULL, 0);
 		if (!if_indextoname(ifaces[i], ifname)) {
-			perror("Invalid interface name or i");
-			return 1;
+			fprintf(stderr, "Bad interface index or name\n");
+			sample_usage(argv, long_options, __doc__, mask, true);
+			goto end_destroy;
 		}
 
-		/* Find the largest index number */
-		if (ifaces[i] > max_ifindex)
-			max_ifindex = ifaces[i];
-
-		printf(" %d", ifaces[i]);
-	}
-	printf("\n");
-
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-
-	obj = bpf_object__open(filename);
-	if (libbpf_get_error(obj)) {
-		printf("ERROR: opening BPF object file failed\n");
-		obj = NULL;
-		goto err_out;
+		skel->rodata->from_match[i] = ifaces[i];
+		skel->rodata->to_match[i] = ifaces[i];
 	}
 
-	/* Reset the map size to max ifindex + 1 */
-	if (attach_egress_prog) {
-		mac_map = bpf_object__find_map_by_name(obj, "mac_map");
-		ret = bpf_map__resize(mac_map, max_ifindex + 1);
-		if (ret < 0) {
-			printf("ERROR: reset mac map size failed\n");
-			goto err_out;
-		}
+	ret = xdp_redirect_map_multi__load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to xdp_redirect_map_multi__load: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
 	}
 
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		printf("ERROR: loading BPF object file failed\n");
-		goto err_out;
-	}
-
-	if (xdp_flags & XDP_FLAGS_SKB_MODE) {
-		ingress_prog = bpf_object__find_program_by_name(obj, "xdp_redirect_map_general");
-		forward_map_fd = bpf_object__find_map_fd_by_name(obj, "forward_map_general");
-	} else {
-		ingress_prog = bpf_object__find_program_by_name(obj, "xdp_redirect_map_native");
-		forward_map_fd = bpf_object__find_map_fd_by_name(obj, "forward_map_native");
-	}
-	if (!ingress_prog || forward_map_fd < 0) {
-		printf("finding ingress_prog/forward_map in obj file failed\n");
-		goto err_out;
-	}
-
-	ingress_prog_fd = bpf_program__fd(ingress_prog);
-	if (ingress_prog_fd < 0) {
-		printf("find ingress_prog fd failed\n");
-		goto err_out;
-	}
-
-	rxcnt_map_fd = bpf_object__find_map_fd_by_name(obj, "rxcnt");
-	if (rxcnt_map_fd < 0) {
-		printf("bpf_object__find_map_fd_by_name failed\n");
-		goto err_out;
-	}
-
-	if (attach_egress_prog) {
+	if (xdp_devmap_attached) {
 		/* Update mac_map with all egress interfaces' mac addr */
-		if (update_mac_map(obj) < 0) {
-			printf("Error: update mac map failed");
-			goto err_out;
+		if (update_mac_map(skel->maps.mac_map) < 0) {
+			fprintf(stderr, "Updating mac address failed\n");
+			ret = EXIT_FAIL;
+			goto end_destroy;
 		}
+	}
 
-		/* Find egress prog fd */
-		egress_prog = bpf_object__find_program_by_name(obj, "xdp_devmap_prog");
-		if (!egress_prog) {
-			printf("finding egress_prog in obj file failed\n");
-			goto err_out;
-		}
-		egress_prog_fd = bpf_program__fd(egress_prog);
-		if (egress_prog_fd < 0) {
-			printf("find egress_prog fd failed\n");
-			goto err_out;
-		}
+	ret = sample_init(skel, mask);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
 	}
 
-	/* Remove attached program when program is interrupted or killed */
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
+	ingress_prog = skel->progs.xdp_redirect_map_native;
+	forward_map = skel->maps.forward_map_native;
 
-	/* Init forward multicast groups */
 	for (i = 0; ifaces[i] > 0; i++) {
 		ifindex = ifaces[i];
 
+		ret = EXIT_FAIL_XDP;
+restart:
 		/* bind prog_fd to each interface */
-		ret = bpf_set_link_xdp_fd(ifindex, ingress_prog_fd, xdp_flags);
-		if (ret) {
-			printf("Set xdp fd failed on %d\n", ifindex);
-			goto err_out;
+		if (sample_install_xdp(ingress_prog, ifindex, generic, force) < 0) {
+			if (generic && !tried) {
+				fprintf(stderr,
+					"Trying fallback to sizeof(int) as value_size for devmap in generic mode\n");
+				ingress_prog = skel->progs.xdp_redirect_map_general;
+				forward_map = skel->maps.forward_map_general;
+				tried = true;
+				goto restart;
+			}
+			goto end_destroy;
 		}
 
 		/* Add all the interfaces to forward group and attach
-		 * egress devmap programe if exist
+		 * egress devmap program if exist
 		 */
 		devmap_val.ifindex = ifindex;
-		devmap_val.bpf_prog.fd = egress_prog_fd;
-		ret = bpf_map_update_elem(forward_map_fd, &ifindex, &devmap_val, 0);
-		if (ret) {
-			perror("bpf_map_update_elem forward_map");
-			goto err_out;
+		if (xdp_devmap_attached)
+			devmap_val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_devmap_prog);
+		ret = bpf_map_update_elem(bpf_map__fd(forward_map), &ifindex, &devmap_val, 0);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to update devmap value: %s\n",
+				strerror(errno));
+			ret = EXIT_FAIL_BPF;
+			goto end_destroy;
 		}
 	}
 
-	poll_stats(2);
-
-	return 0;
-
-err_out:
-	return 1;
+	ret = sample_run(interval, NULL, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
+	}
+	ret = EXIT_OK;
+end_destroy:
+	xdp_redirect_map_multi__destroy(skel);
+end:
+	sample_exit(ret);
 }
diff --git a/samples/bpf/xdp_sample_user.c b/samples/bpf/xdp_sample_user.c
index eb484c15492d..b32d82178199 100644
--- a/samples/bpf/xdp_sample_user.c
+++ b/samples/bpf/xdp_sample_user.c
@@ -1510,7 +1510,7 @@ static int sample_timer_cb(int timerfd, struct stats_record **rec,
 	if (ret < 0)
 		return ret;
 
-	if (sample_xdp_cnt == 2) {
+	if (sample_xdp_cnt == 2 && !(sample_mask & SAMPLE_SKIP_HEADING)) {
 		char fi[IFNAMSIZ];
 		char to[IFNAMSIZ];
 		const char *f, *t;
diff --git a/samples/bpf/xdp_sample_user.h b/samples/bpf/xdp_sample_user.h
index 3a678986cce2..d97465ff8c62 100644
--- a/samples/bpf/xdp_sample_user.h
+++ b/samples/bpf/xdp_sample_user.h
@@ -8,17 +8,18 @@
 #include "xdp_sample_shared.h"
 
 enum stats_mask {
-	_SAMPLE_REDIRECT_MAP        = 1U << 0,
-	SAMPLE_RX_CNT               = 1U << 1,
-	SAMPLE_REDIRECT_ERR_CNT     = 1U << 2,
-	SAMPLE_CPUMAP_ENQUEUE_CNT   = 1U << 3,
-	SAMPLE_CPUMAP_KTHREAD_CNT   = 1U << 4,
-	SAMPLE_EXCEPTION_CNT        = 1U << 5,
-	SAMPLE_DEVMAP_XMIT_CNT      = 1U << 6,
-	SAMPLE_REDIRECT_CNT         = 1U << 7,
-	SAMPLE_REDIRECT_MAP_CNT     = SAMPLE_REDIRECT_CNT | _SAMPLE_REDIRECT_MAP,
-	SAMPLE_REDIRECT_ERR_MAP_CNT = SAMPLE_REDIRECT_ERR_CNT | _SAMPLE_REDIRECT_MAP,
+	_SAMPLE_REDIRECT_MAP         = 1U << 0,
+	SAMPLE_RX_CNT                = 1U << 1,
+	SAMPLE_REDIRECT_ERR_CNT      = 1U << 2,
+	SAMPLE_CPUMAP_ENQUEUE_CNT    = 1U << 3,
+	SAMPLE_CPUMAP_KTHREAD_CNT    = 1U << 4,
+	SAMPLE_EXCEPTION_CNT         = 1U << 5,
+	SAMPLE_DEVMAP_XMIT_CNT       = 1U << 6,
+	SAMPLE_REDIRECT_CNT          = 1U << 7,
+	SAMPLE_REDIRECT_MAP_CNT      = SAMPLE_REDIRECT_CNT | _SAMPLE_REDIRECT_MAP,
+	SAMPLE_REDIRECT_ERR_MAP_CNT  = SAMPLE_REDIRECT_ERR_CNT | _SAMPLE_REDIRECT_MAP,
 	SAMPLE_DEVMAP_XMIT_CNT_MULTI = 1U << 8,
+	SAMPLE_SKIP_HEADING	     = 1U << 9,
 };
 
 /* Exit return codes */
-- 
2.33.0

