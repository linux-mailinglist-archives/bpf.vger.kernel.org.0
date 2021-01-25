Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AA1303525
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 06:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbhAZFga (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbhAYMsL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 07:48:11 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DFC06121E;
        Mon, 25 Jan 2021 04:46:49 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q20so8313524pfu.8;
        Mon, 25 Jan 2021 04:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sZtuCuJ/vMEYRYVWnP0fmPm0j/t6522hUUFI1XTufY=;
        b=bvxJPB0nVbgzPmW9YSw/Q7auOYXcwEj9vx/u5VjGWJvXouXuJsrLKg+Em4QGIUhPhK
         6+qAWCxGLheoQQZlQ1QcnbvwuZkBSzRFhOO4Tw473nkMTMYs6WYICvnFXwufMbXnrBk5
         MU5XIh9Et02oNr/I4cEycn84gao/0CQc/WtVwdPb9F8Gvv5DjV2IV6i81uTaHBy1c5dq
         VHdQHXSVLnBrgATCYnZPDeUTdwCdZJAVXia0ydnmBX8eqKXBd8GEEZ047gFPt3KtqUBz
         DWE9eyu/Ue1xshLwn/Z9OMZ1dfJ/Oqhb2oR2h0yu77HigqauIB3cPFQCdq6SLD/WopOw
         DzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sZtuCuJ/vMEYRYVWnP0fmPm0j/t6522hUUFI1XTufY=;
        b=B8Io18JHBSIHRVWJocOJsGNSzTNPB8h0rcVX/tkrWZ6tYe0zWNbDVjrv5XJuPbYv8Q
         s98RoGH7LiiIEECO2klCxu61NYpnaw2ct2BfPZBL8m0JznTTwdw7ICvND19g3FhxQz/v
         1u9xjE2NdkyMk/tFTc/egGXbyy49kyWi/FmbzRQ6dhURUfipAOUThbs4GxgmjwTouPH0
         e+1NtQIwUPqtWEONrTDiOkvxpvHjYdLiUFLJxNgUSW5vZQObHrIgzQHUxoldXJF/jUew
         o9ZCpXnrJ+48dHRg3BuUeqR7b4Y5bMGgT2zzXsGvcDSh8bAz//4/K4qGLvHB6rSmatKl
         HBKA==
X-Gm-Message-State: AOAM530T73hJ3PayyeWMm7aowZrvEdGlrrPJ/xjozfcQUSITGjEuXnDx
        TImhz5BJ5pyDDf0wSrDpJx7fJ1kN1k8Qg/IL
X-Google-Smtp-Source: ABdhPJyVVmnx6P5BqMP1ABCgB71YVmxVBYtVKyPEQkzkOkOLWZGqQkrdevnnEuzwuAEDfqS+qkC/TQ==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr438555pgr.221.1611578808774;
        Mon, 25 Jan 2021 04:46:48 -0800 (PST)
Received: from Leo-laptop-t470s.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j123sm17815466pfg.36.2021.01.25.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 04:46:47 -0800 (PST)
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv17 bpf-next 4/6] sample/bpf: add xdp_redirect_map_multicast test
Date:   Mon, 25 Jan 2021 20:45:14 +0800
Message-Id: <20210125124516.3098129-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125124516.3098129-1-liuhangbin@gmail.com>
References: <20210122074652.2981711-1-liuhangbin@gmail.com>
 <20210125124516.3098129-1-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a sample for xdp multicast. In the sample we could forward all
packets between given interfaces. There is also an option -X that could
enable 2nd xdp_prog on egress interface.

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

---
v16-v17: no update
v15: use bpf_object__find_program_by_name() instead of
     bpf_object__find_program_by_title()
v13-v14: no update, only rebase the code
v12: add devmap xdp_prog on egress support
v10-v11: no update
v9: use NULL directly for arg2 and redefine the maps with btf format
v5: add a null_map as we have strict the arg2 to ARG_CONST_MAP_PTR.
    Move the testing part to bpf selftest in next patch.
v4: no update.
v3: add rxcnt map to show the packet transmit speed.
v2: no update.
---
 samples/bpf/Makefile                      |   3 +
 samples/bpf/xdp_redirect_map_multi_kern.c |  87 +++++++
 samples/bpf/xdp_redirect_map_multi_user.c | 302 ++++++++++++++++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 samples/bpf/xdp_redirect_map_multi_kern.c
 create mode 100644 samples/bpf/xdp_redirect_map_multi_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index d06144613ca2..539af70b5a98 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -41,6 +41,7 @@ tprogs-y += test_map_in_map
 tprogs-y += per_socket_stats_example
 tprogs-y += xdp_redirect
 tprogs-y += xdp_redirect_map
+tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_redirect_cpu
 tprogs-y += xdp_monitor
 tprogs-y += xdp_rxq_info
@@ -99,6 +100,7 @@ test_map_in_map-objs := test_map_in_map_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
 xdp_redirect-objs := xdp_redirect_user.o
 xdp_redirect_map-objs := xdp_redirect_map_user.o
+xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o
 xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o
 xdp_monitor-objs := xdp_monitor_user.o
 xdp_rxq_info-objs := xdp_rxq_info_user.o
@@ -160,6 +162,7 @@ always-y += tcp_tos_reflect_kern.o
 always-y += tcp_dumpstats_kern.o
 always-y += xdp_redirect_kern.o
 always-y += xdp_redirect_map_kern.o
+always-y += xdp_redirect_map_multi_kern.o
 always-y += xdp_redirect_cpu_kern.o
 always-y += xdp_monitor_kern.o
 always-y += xdp_rxq_info_kern.o
diff --git a/samples/bpf/xdp_redirect_map_multi_kern.c b/samples/bpf/xdp_redirect_map_multi_kern.c
new file mode 100644
index 000000000000..e422340d1251
--- /dev/null
+++ b/samples/bpf/xdp_redirect_map_multi_kern.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+#define KBUILD_MODNAME "foo"
+#include <uapi/linux/bpf.h>
+#include <linux/in.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+	__uint(max_entries, 32);
+} forward_map_general SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(struct bpf_devmap_val));
+	__uint(max_entries, 32);
+} forward_map_native SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, u32);
+	__type(value, long);
+	__uint(max_entries, 1);
+} rxcnt SEC(".maps");
+
+/* map to store egress interfaces mac addresses, set the
+ * max_entries to 1 and extend it in user sapce prog.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, __be64);
+	__uint(max_entries, 1);
+} mac_map SEC(".maps");
+
+static int xdp_redirect_map(struct xdp_md *ctx, void *forward_map)
+{
+	long *value;
+	u32 key = 0;
+
+	/* count packet in global counter */
+	value = bpf_map_lookup_elem(&rxcnt, &key);
+	if (value)
+		*value += 1;
+
+	return bpf_redirect_map_multi(forward_map, NULL, BPF_F_EXCLUDE_INGRESS);
+}
+
+SEC("xdp_redirect_general")
+int xdp_redirect_map_general(struct xdp_md *ctx)
+{
+	return xdp_redirect_map(ctx, &forward_map_general);
+}
+
+SEC("xdp_redirect_native")
+int xdp_redirect_map_native(struct xdp_md *ctx)
+{
+	return xdp_redirect_map(ctx, &forward_map_native);
+}
+
+SEC("xdp_devmap/map_prog")
+int xdp_devmap_prog(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	u32 key = ctx->egress_ifindex;
+	struct ethhdr *eth = data;
+	__be64 *mac;
+	u64 nh_off;
+
+	nh_off = sizeof(*eth);
+	if (data + nh_off > data_end)
+		return XDP_DROP;
+
+	mac = bpf_map_lookup_elem(&mac_map, &key);
+	if (mac)
+		__builtin_memcpy(eth->h_source, mac, ETH_ALEN);
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_redirect_map_multi_user.c b/samples/bpf/xdp_redirect_map_multi_user.c
new file mode 100644
index 000000000000..84cdbbed20b7
--- /dev/null
+++ b/samples/bpf/xdp_redirect_map_multi_user.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/if_link.h>
+#include <assert.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <net/if.h>
+#include <unistd.h>
+#include <libgen.h>
+#include <sys/resource.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "bpf_util.h"
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#define MAX_IFACE_NUM 32
+
+static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
+static int ifaces[MAX_IFACE_NUM] = {};
+static int rxcnt_map_fd;
+
+static void int_exit(int sig)
+{
+	__u32 prog_id = 0;
+	int i;
+
+	for (i = 0; ifaces[i] > 0; i++) {
+		if (bpf_get_link_xdp_id(ifaces[i], &prog_id, xdp_flags)) {
+			printf("bpf_get_link_xdp_id failed\n");
+			exit(1);
+		}
+		if (prog_id)
+			bpf_set_link_xdp_fd(ifaces[i], -1, xdp_flags);
+	}
+
+	exit(0);
+}
+
+static void poll_stats(int interval)
+{
+	unsigned int nr_cpus = bpf_num_possible_cpus();
+	__u64 values[nr_cpus], prev[nr_cpus];
+
+	memset(prev, 0, sizeof(prev));
+
+	while (1) {
+		__u64 sum = 0;
+		__u32 key = 0;
+		int i;
+
+		sleep(interval);
+		assert(bpf_map_lookup_elem(rxcnt_map_fd, &key, values) == 0);
+		for (i = 0; i < nr_cpus; i++)
+			sum += (values[i] - prev[i]);
+		if (sum)
+			printf("Forwarding %10llu pkt/s\n", sum / interval);
+		memcpy(prev, values, sizeof(values));
+	}
+}
+
+static int get_mac_addr(unsigned int ifindex, void *mac_addr)
+{
+	char ifname[IF_NAMESIZE];
+	struct ifreq ifr;
+	int fd, ret = -1;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return ret;
+
+	if (!if_indextoname(ifindex, ifname))
+		goto err_out;
+
+	strcpy(ifr.ifr_name, ifname);
+
+	if (ioctl(fd, SIOCGIFHWADDR, &ifr) != 0)
+		goto err_out;
+
+	memcpy(mac_addr, ifr.ifr_hwaddr.sa_data, 6 * sizeof(char));
+	ret = 0;
+
+err_out:
+	close(fd);
+	return ret;
+}
+
+static int update_mac_map(struct bpf_object *obj)
+{
+	int i, ret = -1, mac_map_fd;
+	unsigned char mac_addr[6];
+	unsigned int ifindex;
+
+	mac_map_fd = bpf_object__find_map_fd_by_name(obj, "mac_map");
+	if (mac_map_fd < 0) {
+		printf("find mac map fd failed\n");
+		return ret;
+	}
+
+	for (i = 0; ifaces[i] > 0; i++) {
+		ifindex = ifaces[i];
+
+		ret = get_mac_addr(ifindex, mac_addr);
+		if (ret < 0) {
+			printf("get interface %d mac failed\n", ifindex);
+			return ret;
+		}
+
+		ret = bpf_map_update_elem(mac_map_fd, &ifindex, mac_addr, 0);
+		if (ret) {
+			perror("bpf_update_elem mac_map_fd");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s [OPTS] <IFNAME|IFINDEX> <IFNAME|IFINDEX> ...\n"
+		"OPTS:\n"
+		"    -S    use skb-mode\n"
+		"    -N    enforce native mode\n"
+		"    -F    force loading prog\n"
+		"    -X    load xdp program on egress\n",
+		prog);
+}
+
+int main(int argc, char **argv)
+{
+	int i, ret, opt, forward_map_fd, max_ifindex = 0;
+	struct bpf_program *ingress_prog, *egress_prog;
+	int ingress_prog_fd, egress_prog_fd = 0;
+	struct bpf_devmap_val devmap_val;
+	bool attach_egress_prog = false;
+	char ifname[IF_NAMESIZE];
+	struct bpf_map *mac_map;
+	struct bpf_object *obj;
+	unsigned int ifindex;
+	char filename[256];
+
+	while ((opt = getopt(argc, argv, "SNFX")) != -1) {
+		switch (opt) {
+		case 'S':
+			xdp_flags |= XDP_FLAGS_SKB_MODE;
+			break;
+		case 'N':
+			/* default, set below */
+			break;
+		case 'F':
+			xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
+			break;
+		case 'X':
+			attach_egress_prog = true;
+			break;
+		default:
+			usage(basename(argv[0]));
+			return 1;
+		}
+	}
+
+	if (!(xdp_flags & XDP_FLAGS_SKB_MODE)) {
+		xdp_flags |= XDP_FLAGS_DRV_MODE;
+	} else if (attach_egress_prog) {
+		printf("Load xdp program on egress with SKB mode not supported yet\n");
+		return 1;
+	}
+
+	if (optind == argc) {
+		printf("usage: %s <IFNAME|IFINDEX> <IFNAME|IFINDEX> ...\n", argv[0]);
+		return 1;
+	}
+
+	printf("Get interfaces");
+	for (i = 0; i < MAX_IFACE_NUM && argv[optind + i]; i++) {
+		ifaces[i] = if_nametoindex(argv[optind + i]);
+		if (!ifaces[i])
+			ifaces[i] = strtoul(argv[optind + i], NULL, 0);
+		if (!if_indextoname(ifaces[i], ifname)) {
+			perror("Invalid interface name or i");
+			return 1;
+		}
+
+		/* Find the largest index number */
+		if (ifaces[i] > max_ifindex)
+			max_ifindex = ifaces[i];
+
+		printf(" %d", ifaces[i]);
+	}
+	printf("\n");
+
+	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+
+	obj = bpf_object__open(filename);
+	if (libbpf_get_error(obj)) {
+		printf("ERROR: opening BPF object file failed\n");
+		obj = NULL;
+		goto err_out;
+	}
+
+	/* Reset the map size to max ifindex + 1 */
+	if (attach_egress_prog) {
+		mac_map = bpf_object__find_map_by_name(obj, "mac_map");
+		ret = bpf_map__resize(mac_map, max_ifindex + 1);
+		if (ret < 0) {
+			printf("ERROR: reset mac map size failed\n");
+			goto err_out;
+		}
+	}
+
+	/* load BPF program */
+	if (bpf_object__load(obj)) {
+		printf("ERROR: loading BPF object file failed\n");
+		goto err_out;
+	}
+
+	if (xdp_flags & XDP_FLAGS_SKB_MODE) {
+		ingress_prog = bpf_object__find_program_by_name(obj, "xdp_redirect_map_general");
+		forward_map_fd = bpf_object__find_map_fd_by_name(obj, "forward_map_general");
+	} else {
+		ingress_prog = bpf_object__find_program_by_name(obj, "xdp_redirect_map_native");
+		forward_map_fd = bpf_object__find_map_fd_by_name(obj, "forward_map_native");
+	}
+	if (!ingress_prog || forward_map_fd < 0) {
+		printf("finding ingress_prog/forward_map in obj file failed\n");
+		goto err_out;
+	}
+
+	ingress_prog_fd = bpf_program__fd(ingress_prog);
+	if (ingress_prog_fd < 0) {
+		printf("find ingress_prog fd failed\n");
+		goto err_out;
+	}
+
+	rxcnt_map_fd = bpf_object__find_map_fd_by_name(obj, "rxcnt");
+	if (rxcnt_map_fd < 0) {
+		printf("bpf_object__find_map_fd_by_name failed\n");
+		goto err_out;
+	}
+
+	if (attach_egress_prog) {
+		/* Update mac_map with all egress interfaces' mac addr */
+		if (update_mac_map(obj) < 0) {
+			printf("Error: update mac map failed");
+			goto err_out;
+		}
+
+		/* Find egress prog fd */
+		egress_prog = bpf_object__find_program_by_name(obj, "xdp_devmap_prog");
+		if (!egress_prog) {
+			printf("finding egress_prog in obj file failed\n");
+			goto err_out;
+		}
+		egress_prog_fd = bpf_program__fd(egress_prog);
+		if (egress_prog_fd < 0) {
+			printf("find egress_prog fd failed\n");
+			goto err_out;
+		}
+	}
+
+	/* Remove attached program when program is interrupted or killed */
+	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
+
+	/* Init forward multicast groups */
+	for (i = 0; ifaces[i] > 0; i++) {
+		ifindex = ifaces[i];
+
+		/* bind prog_fd to each interface */
+		ret = bpf_set_link_xdp_fd(ifindex, ingress_prog_fd, xdp_flags);
+		if (ret) {
+			printf("Set xdp fd failed on %d\n", ifindex);
+			goto err_out;
+		}
+
+		/* Add all the interfaces to forward group and attach
+		 * egress devmap programe if exist
+		 */
+		devmap_val.ifindex = ifindex;
+		devmap_val.bpf_prog.fd = egress_prog_fd;
+		ret = bpf_map_update_elem(forward_map_fd, &ifindex, &devmap_val, 0);
+		if (ret) {
+			perror("bpf_map_update_elem forward_map");
+			goto err_out;
+		}
+	}
+
+	poll_stats(2);
+
+	return 0;
+
+err_out:
+	return 1;
+}
-- 
2.26.2

