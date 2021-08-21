Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA2C3F37AC
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 02:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhHUAWD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbhHUAVy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 20:21:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C1C0617AD;
        Fri, 20 Aug 2021 17:21:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w68so10009200pfd.0;
        Fri, 20 Aug 2021 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voJJUx7flxv7eXMp16i84FB/TWlHdBDeCI1LWbgdWmE=;
        b=UFhbz0o9cU7X6IRLOTdpcvOafbj853d/nlJmIRB71zqnUkUPi0wssgElM0L04M9grN
         phRWUpSdxcY3CscahwZqm3hcKw9BZcjsJp4vFtYyHKJIqTdtRvOUwX2Tn1UnpSqlC0Qm
         Nsuaet6PYhHztgQhEpSveHSnZay6clZIbnEdLrjjjheBrU2tKPLbTe49fY2LhpfUmDMy
         yAVHzhoTKGSb3pFVY8cjF5x2i/5IOs6THIkN1INq/ln3fwffRy2wcUTDQNemzXeQl5Fg
         PMZaQHz3LoR9xefFQ0UDcRsUHl5fQGfyV5u4AteA3FO1zJYcFVnON4LirXSOYyj/8VxS
         87FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voJJUx7flxv7eXMp16i84FB/TWlHdBDeCI1LWbgdWmE=;
        b=kxfklqbipjfkNig8Ozm0E3SHTmgLV2idtClVcY4zWqiS6WOq4quzhEzrYw/jjuHeDV
         TkZEj/V6gnHUoUwQuan+0P+0nNScdflGSB0N/pwlBjAvQCNkKkoo1OHB8FwW1ibAHaeO
         gHLvhf4OTuc8aZjn3ETNakpnZB6QPB7CXiF7GI9cQezy3aAhpbzN/FTSbzrL8QDuIm2O
         eZMX3hasTXGM5jtDe2PI0WYCGpsw0lBs8zn1FXnZudtbZUtedCQMS5ChlZs3ZrPYYpZv
         LPbBlr4AnMvv3dYflkvIUu47mzgioCu4BL5h33OitlTPZf8xAJyAMsYsGA6aE4nCA4Wy
         K+Dg==
X-Gm-Message-State: AOAM531kBAdvPwaPKMBlfrfsC5q2hSJ7CBxaTUmYPnepMzvg7+wq7ZtZ
        iVFfQD/7fUKmnbmKERNFBv0ZHNED8Ec=
X-Google-Smtp-Source: ABdhPJxi6KnDhY3oi7SUn/8bSE13uXEBF0LMDk2QHvY34DYfpIbE6RPw4U699mhgpjUQbeS4/P1ybw==
X-Received: by 2002:a63:5445:: with SMTP id e5mr21082696pgm.100.1629505275362;
        Fri, 20 Aug 2021 17:21:15 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id hd21sm12579609pjb.7.2021.08.20.17.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 17:21:15 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 20/22] samples: bpf: Convert xdp_redirect_map to XDP samples helper
Date:   Sat, 21 Aug 2021 05:50:08 +0530
Message-Id: <20210821002010.845777-21-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210821002010.845777-1-memxor@gmail.com>
References: <20210821002010.845777-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the libbpf skeleton facility and other utilities provided by XDP
samples helper.

Since get_mac_addr is already provided by XDP samples helper, we drop
it. Also convert to XDP samples helper similar to prior samples to
minimize duplication of code.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/Makefile                |   5 +-
 samples/bpf/xdp_redirect_map_user.c | 385 ++++++++++++----------------
 2 files changed, 161 insertions(+), 229 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 8faef4bcead4..6decc8f9bcc2 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -39,7 +39,6 @@ tprogs-y += lwt_len_hist
 tprogs-y += xdp_tx_iptunnel
 tprogs-y += test_map_in_map
 tprogs-y += per_socket_stats_example
-tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_rxq_info
 tprogs-y += syscall_tp
@@ -55,6 +54,7 @@ tprogs-y += ibumad
 tprogs-y += hbm
 
 tprogs-y += xdp_redirect_cpu
+tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect
 tprogs-y += xdp_monitor
 
@@ -100,7 +100,6 @@ lwt_len_hist-objs := lwt_len_hist_user.o
 xdp_tx_iptunnel-objs := xdp_tx_iptunnel_user.o
 test_map_in_map-objs := test_map_in_map_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
-xdp_redirect_map-objs := xdp_redirect_map_user.o
 xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o
 xdp_rxq_info-objs := xdp_rxq_info_user.o
 syscall_tp-objs := syscall_tp_user.o
@@ -116,6 +115,7 @@ ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
 xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o $(XDP_SAMPLE)
+xdp_redirect_map-objs := xdp_redirect_map_user.o $(XDP_SAMPLE)
 xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
 xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
 
@@ -311,6 +311,7 @@ $(BPF_SAMPLES_PATH)/*.c: verify_target_bpf $(LIBBPF)
 $(src)/*.c: verify_target_bpf $(LIBBPF)
 
 $(obj)/xdp_redirect_cpu_user.o: $(obj)/xdp_redirect_cpu.skel.h
+$(obj)/xdp_redirect_map_user.o: $(obj)/xdp_redirect_map.skel.h
 $(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
 $(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
 
diff --git a/samples/bpf/xdp_redirect_map_user.c b/samples/bpf/xdp_redirect_map_user.c
index 0e8192688dfc..b6e4fc849577 100644
--- a/samples/bpf/xdp_redirect_map_user.c
+++ b/samples/bpf/xdp_redirect_map_user.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2017 Covalent IO, Inc. http://covalent.io
  */
+static const char *__doc__ =
+"XDP redirect tool, using BPF_MAP_TYPE_DEVMAP\n"
+"Usage: xdp_redirect_map <IFINDEX|IFNAME>_IN <IFINDEX|IFNAME>_OUT\n";
+
 #include <linux/bpf.h>
 #include <linux/if_link.h>
 #include <assert.h>
@@ -13,165 +17,83 @@
 #include <net/if.h>
 #include <unistd.h>
 #include <libgen.h>
-#include <sys/resource.h>
-#include <sys/ioctl.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-
-#include "bpf_util.h"
+#include <getopt.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include "bpf_util.h"
+#include "xdp_sample_user.h"
+#include "xdp_redirect_map.skel.h"
 
-static int ifindex_in;
-static int ifindex_out;
-static bool ifindex_out_xdp_dummy_attached = true;
-static bool xdp_devmap_attached;
-static __u32 prog_id;
-static __u32 dummy_prog_id;
-
-static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-static int rxcnt_map_fd;
-
-static void int_exit(int sig)
-{
-	__u32 curr_prog_id = 0;
-
-	if (bpf_get_link_xdp_id(ifindex_in, &curr_prog_id, xdp_flags)) {
-		printf("bpf_get_link_xdp_id failed\n");
-		exit(1);
-	}
-	if (prog_id == curr_prog_id)
-		bpf_set_link_xdp_fd(ifindex_in, -1, xdp_flags);
-	else if (!curr_prog_id)
-		printf("couldn't find a prog id on iface IN\n");
-	else
-		printf("program on iface IN changed, not removing\n");
-
-	if (ifindex_out_xdp_dummy_attached) {
-		curr_prog_id = 0;
-		if (bpf_get_link_xdp_id(ifindex_out, &curr_prog_id,
-					xdp_flags)) {
-			printf("bpf_get_link_xdp_id failed\n");
-			exit(1);
-		}
-		if (dummy_prog_id == curr_prog_id)
-			bpf_set_link_xdp_fd(ifindex_out, -1, xdp_flags);
-		else if (!curr_prog_id)
-			printf("couldn't find a prog id on iface OUT\n");
-		else
-			printf("program on iface OUT changed, not removing\n");
-	}
-	exit(0);
-}
-
-static void poll_stats(int interval, int ifindex)
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
-
-		sleep(interval);
-		assert(bpf_map_lookup_elem(rxcnt_map_fd, &key, values) == 0);
-		for (i = 0; i < nr_cpus; i++)
-			sum += (values[i] - prev[i]);
-		if (sum)
-			printf("ifindex %i: %10llu pkt/s\n",
-			       ifindex, sum / interval);
-		memcpy(prev, values, sizeof(values));
-	}
-}
-
-static int get_mac_addr(unsigned int ifindex_out, void *mac_addr)
-{
-	char ifname[IF_NAMESIZE];
-	struct ifreq ifr;
-	int fd, ret = -1;
-
-	fd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (fd < 0)
-		return ret;
-
-	if (!if_indextoname(ifindex_out, ifname))
-		goto err_out;
-
-	strcpy(ifr.ifr_name, ifname);
-
-	if (ioctl(fd, SIOCGIFHWADDR, &ifr) != 0)
-		goto err_out;
-
-	memcpy(mac_addr, ifr.ifr_hwaddr.sa_data, 6 * sizeof(char));
-	ret = 0;
+static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
+		  SAMPLE_EXCEPTION_CNT | SAMPLE_DEVMAP_XMIT_CNT_MULTI;
 
-err_out:
-	close(fd);
-	return ret;
-}
+DEFINE_SAMPLE_INIT(xdp_redirect_map);
 
-static void usage(const char *prog)
-{
-	fprintf(stderr,
-		"usage: %s [OPTS] <IFNAME|IFINDEX>_IN <IFNAME|IFINDEX>_OUT\n\n"
-		"OPTS:\n"
-		"    -S    use skb-mode\n"
-		"    -N    enforce native mode\n"
-		"    -F    force loading prog\n"
-		"    -X    load xdp program on egress\n",
-		prog);
-}
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
 
 int main(int argc, char **argv)
 {
-	struct bpf_prog_load_attr prog_load_attr = {
-		.prog_type	= BPF_PROG_TYPE_UNSPEC,
-	};
-	struct bpf_program *prog, *dummy_prog, *devmap_prog;
-	int prog_fd, dummy_prog_fd, devmap_prog_fd = 0;
-	int tx_port_map_fd, tx_mac_map_fd;
-	struct bpf_devmap_val devmap_val;
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	const char *optstr = "FSNX";
-	struct bpf_object *obj;
-	int ret, opt, key = 0;
-	char filename[256];
-
-	while ((opt = getopt(argc, argv, optstr)) != -1) {
+	struct bpf_devmap_val devmap_val = {};
+	bool xdp_devmap_attached = false;
+	struct xdp_redirect_map *skel;
+	char str[2 * IF_NAMESIZE + 1];
+	char ifname_out[IF_NAMESIZE];
+	struct bpf_map *tx_port_map;
+	char ifname_in[IF_NAMESIZE];
+	int ifindex_in, ifindex_out;
+	unsigned long interval = 2;
+	int ret = EXIT_FAIL_OPTION;
+	struct bpf_program *prog;
+	bool generic = false;
+	bool force = false;
+	bool tried = false;
+	bool error = true;
+	int opt, key = 0;
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
 			xdp_devmap_attached = true;
 			break;
+		case 'i':
+			interval = strtoul(optarg, NULL, 0);
+			break;
+		case 'v':
+			sample_switch_mode();
+			break;
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
-	} else if (xdp_devmap_attached) {
-		printf("Load xdp program on egress with SKB mode not supported yet\n");
-		return 1;
-	}
-
-	if (optind == argc) {
-		printf("usage: %s <IFNAME|IFINDEX>_IN <IFNAME|IFINDEX>_OUT\n", argv[0]);
-		return 1;
+	if (argc <= optind + 1) {
+		sample_usage(argv, long_options, __doc__, mask, true);
+		goto end;
 	}
 
 	ifindex_in = if_nametoindex(argv[optind]);
@@ -182,107 +104,116 @@ int main(int argc, char **argv)
 	if (!ifindex_out)
 		ifindex_out = strtoul(argv[optind + 1], NULL, 0);
 
-	printf("input: %d output: %d\n", ifindex_in, ifindex_out);
-
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-	prog_load_attr.file = filename;
-
-	if (bpf_prog_load_xattr(&prog_load_attr, &obj, &prog_fd))
-		return 1;
-
-	if (xdp_flags & XDP_FLAGS_SKB_MODE) {
-		prog = bpf_object__find_program_by_name(obj, "xdp_redirect_map_general");
-		tx_port_map_fd = bpf_object__find_map_fd_by_name(obj, "tx_port_general");
-	} else {
-		prog = bpf_object__find_program_by_name(obj, "xdp_redirect_map_native");
-		tx_port_map_fd = bpf_object__find_map_fd_by_name(obj, "tx_port_native");
-	}
-	dummy_prog = bpf_object__find_program_by_name(obj, "xdp_redirect_dummy_prog");
-	if (!prog || dummy_prog < 0 || tx_port_map_fd < 0) {
-		printf("finding prog/dummy_prog/tx_port_map in obj file failed\n");
-		goto out;
-	}
-	prog_fd = bpf_program__fd(prog);
-	dummy_prog_fd = bpf_program__fd(dummy_prog);
-	if (prog_fd < 0 || dummy_prog_fd < 0 || tx_port_map_fd < 0) {
-		printf("bpf_prog_load_xattr: %s\n", strerror(errno));
-		return 1;
-	}
-
-	tx_mac_map_fd = bpf_object__find_map_fd_by_name(obj, "tx_mac");
-	rxcnt_map_fd = bpf_object__find_map_fd_by_name(obj, "rxcnt");
-	if (tx_mac_map_fd < 0 || rxcnt_map_fd < 0) {
-		printf("bpf_object__find_map_fd_by_name failed\n");
-		return 1;
+	if (!ifindex_in || !ifindex_out) {
+		fprintf(stderr, "Bad interface index or name\n");
+		sample_usage(argv, long_options, __doc__, mask, true);
+		goto end;
 	}
 
-	if (bpf_set_link_xdp_fd(ifindex_in, prog_fd, xdp_flags) < 0) {
-		printf("ERROR: link set xdp fd failed on %d\n", ifindex_in);
-		return 1;
+	skel = xdp_redirect_map__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to xdp_redirect_map__open: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end;
 	}
 
-	ret = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
-	if (ret) {
-		printf("can't get prog info - %s\n", strerror(errno));
-		return ret;
+	ret = sample_init_pre_load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
 	}
-	prog_id = info.id;
-
-	/* Loading dummy XDP prog on out-device */
-	if (bpf_set_link_xdp_fd(ifindex_out, dummy_prog_fd,
-			    (xdp_flags | XDP_FLAGS_UPDATE_IF_NOEXIST)) < 0) {
-		printf("WARN: link set xdp fd failed on %d\n", ifindex_out);
-		ifindex_out_xdp_dummy_attached = false;
-	}
-
-	memset(&info, 0, sizeof(info));
-	ret = bpf_obj_get_info_by_fd(dummy_prog_fd, &info, &info_len);
-	if (ret) {
-		printf("can't get prog info - %s\n", strerror(errno));
-		return ret;
-	}
-	dummy_prog_id = info.id;
 
 	/* Load 2nd xdp prog on egress. */
 	if (xdp_devmap_attached) {
-		unsigned char mac_addr[6];
-
-		devmap_prog = bpf_object__find_program_by_name(obj, "xdp_redirect_map_egress");
-		if (!devmap_prog) {
-			printf("finding devmap_prog in obj file failed\n");
-			goto out;
-		}
-		devmap_prog_fd = bpf_program__fd(devmap_prog);
-		if (devmap_prog_fd < 0) {
-			printf("finding devmap_prog fd failed\n");
-			goto out;
-		}
-
-		if (get_mac_addr(ifindex_out, mac_addr) < 0) {
-			printf("get interface %d mac failed\n", ifindex_out);
-			goto out;
+		ret = get_mac_addr(ifindex_out, skel->rodata->tx_mac_addr);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to get interface %d mac address: %s\n",
+				ifindex_out, strerror(-ret));
+			ret = EXIT_FAIL;
+			goto end_destroy;
 		}
+	}
 
-		ret = bpf_map_update_elem(tx_mac_map_fd, &key, mac_addr, 0);
-		if (ret) {
-			perror("bpf_update_elem tx_mac_map_fd");
-			goto out;
+	skel->rodata->from_match[0] = ifindex_in;
+	skel->rodata->to_match[0] = ifindex_out;
+
+	ret = xdp_redirect_map__load(skel);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to xdp_redirect_map__load: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
+	}
+
+	ret = sample_init(skel, mask);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
+	}
+
+	prog = skel->progs.xdp_redirect_map_native;
+	tx_port_map = skel->maps.tx_port_native;
+restart:
+	if (sample_install_xdp(prog, ifindex_in, generic, force) < 0) {
+		/* First try with struct bpf_devmap_val as value for generic
+		 * mode, then fallback to sizeof(int) for older kernels.
+		 */
+		fprintf(stderr,
+			"Trying fallback to sizeof(int) as value_size for devmap in generic mode\n");
+		if (generic && !tried) {
+			prog = skel->progs.xdp_redirect_map_general;
+			tx_port_map = skel->maps.tx_port_general;
+			tried = true;
+			goto restart;
 		}
+		ret = EXIT_FAIL_XDP;
+		goto end_destroy;
 	}
 
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
+	/* Loading dummy XDP prog on out-device */
+	sample_install_xdp(skel->progs.xdp_redirect_dummy_prog, ifindex_out, generic, force);
 
 	devmap_val.ifindex = ifindex_out;
-	devmap_val.bpf_prog.fd = devmap_prog_fd;
-	ret = bpf_map_update_elem(tx_port_map_fd, &key, &devmap_val, 0);
-	if (ret) {
-		perror("bpf_update_elem");
-		goto out;
-	}
-
-	poll_stats(2, ifindex_out);
-
-out:
-	return 0;
+	if (xdp_devmap_attached)
+		devmap_val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_redirect_map_egress);
+	ret = bpf_map_update_elem(bpf_map__fd(tx_port_map), &key, &devmap_val, 0);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to update devmap value: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end_destroy;
+	}
+
+	ret = EXIT_FAIL;
+	if (!if_indextoname(ifindex_in, ifname_in)) {
+		fprintf(stderr, "Failed to if_indextoname for %d: %s\n", ifindex_in,
+			strerror(errno));
+		goto end_destroy;
+	}
+
+	if (!if_indextoname(ifindex_out, ifname_out)) {
+		fprintf(stderr, "Failed to if_indextoname for %d: %s\n", ifindex_out,
+			strerror(errno));
+		goto end_destroy;
+	}
+
+	safe_strncpy(str, get_driver_name(ifindex_in), sizeof(str));
+	printf("Redirecting from %s (ifindex %d; driver %s) to %s (ifindex %d; driver %s)\n",
+	       ifname_in, ifindex_in, str, ifname_out, ifindex_out, get_driver_name(ifindex_out));
+	snprintf(str, sizeof(str), "%s->%s", ifname_in, ifname_out);
+
+	ret = sample_run(interval, NULL, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
+		ret = EXIT_FAIL;
+		goto end_destroy;
+	}
+	ret = EXIT_OK;
+end_destroy:
+	xdp_redirect_map__destroy(skel);
+end:
+	sample_exit(ret);
 }
-- 
2.33.0

