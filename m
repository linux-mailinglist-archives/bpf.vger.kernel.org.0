Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D756E3D1916
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 23:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhGUUs2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhGUUsY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 16:48:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E27C061575;
        Wed, 21 Jul 2021 14:28:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so1235265pjb.0;
        Wed, 21 Jul 2021 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ga1wzbkQAHVBAo9qcp53OvXs8Z8kN38u7DL/9uNS0U=;
        b=jGQv0WBMpAXAcSSDuQ15g65xEqErLckqVJIK0hdKLB5qbWuF5DvbrxLVk8n7SpGzmn
         leyrq7h20CA72d9ZwW2842tyBRXGrOBBskq+E5nDC9PtACpd2EtTeTiN+pkFPLSLDI1r
         eBWSedmZi85m1Y479101jFxeiQz4Y2TYcU0RAJEJuGG7I3kzg2cb61G5JRjr7ALRxzbt
         YqWwcbooCgQ48VmekaMN2S94s+hBuvpUcptEv20S5b5hgmk3Y7ddQ5PqOx/cV2msOQ8l
         zofuylrVAnUL7KS/q02Ux4Spk45YTavHUVwDAUUjNqLvfeT7A/dPY2r510C9RPThjC9B
         L7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ga1wzbkQAHVBAo9qcp53OvXs8Z8kN38u7DL/9uNS0U=;
        b=sUALVRsTMd/mhKMS4lHMeTjLtA98ta6wbb3rgIY/suu3zd/NxEUe5GdJ8RYf7LadTW
         GKFqyw14xF2x1NVIt2AhrLEloON44xSVdhiQXSXuUTVDqiKNC51GbH146AENTti9+t3Y
         i+dRvtOFpcqMxHqrp7BjbfpvmcEo6ZVaXTGC+16ru4pi9j6j4ovRYc05wcpU6XZIb56Q
         8NknH5uQCpsp1X2CEXCmJZmzm/BU1IEcb/OaApncb2z3qZPgswT6ZqqCyTAcO9u3LlZx
         MiMxRHHofS4esdavGdFEb+TH5g1cxzxthkvZFD6fsEBXq1sfmgdifWgU7/zQMGbMZaO0
         QoJw==
X-Gm-Message-State: AOAM532iuVX1j1adzjJhocNyrw/6Zldz2lbtn9J0P7o82w9vPHp8VHb/
        5WCxpUt9+u5o3Q++YwFRT3SCfbAE1BAcSA==
X-Google-Smtp-Source: ABdhPJyRwSCnrpNTFv6T6E1GZlrGH5ibTRVFW7TF62bg9z1lIAuDOH02NeQobaX4L6ykArzELGMFUg==
X-Received: by 2002:aa7:8d10:0:b029:303:8d17:7b8d with SMTP id j16-20020aa78d100000b02903038d177b8dmr37952764pfe.26.1626902938471;
        Wed, 21 Jul 2021 14:28:58 -0700 (PDT)
Received: from localhost ([2405:201:6014:d0bb:dc30:f309:2f53:5818])
        by smtp.gmail.com with ESMTPSA id 37sm13741645pgt.28.2021.07.21.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:28:58 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 6/8] samples: bpf: Convert xdp_redirect_map to use XDP samples helpers
Date:   Thu, 22 Jul 2021 02:58:31 +0530
Message-Id: <20210721212833.701342-7-memxor@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210721212833.701342-1-memxor@gmail.com>
References: <20210721212833.701342-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change converts XDP redirect_map tool to use the XDP samples
support introduced in previous changes.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 samples/bpf/Makefile                          |  10 +-
 ...rect_map_kern.c => xdp_redirect_map.bpf.c} |  75 +---
 samples/bpf/xdp_redirect_map_user.c           | 385 +++++++-----------
 3 files changed, 181 insertions(+), 289 deletions(-)
 rename samples/bpf/{xdp_redirect_map_kern.c => xdp_redirect_map.bpf.c} (62%)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index b94b6dac09ff..2cccb2aa8f2b 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -39,7 +39,6 @@ tprogs-y += lwt_len_hist
 tprogs-y += xdp_tx_iptunnel
 tprogs-y += test_map_in_map
 tprogs-y += per_socket_stats_example
-tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_redirect_cpu
 tprogs-y += xdp_rxq_info
@@ -55,6 +54,7 @@ tprogs-y += xdp_sample_pkts
 tprogs-y += ibumad
 tprogs-y += hbm
 
+tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect
 tprogs-y += xdp_monitor
 
@@ -100,7 +100,6 @@ lwt_len_hist-objs := lwt_len_hist_user.o
 xdp_tx_iptunnel-objs := xdp_tx_iptunnel_user.o
 test_map_in_map-objs := test_map_in_map_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
-xdp_redirect_map-objs := xdp_redirect_map_user.o
 xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o
 xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o
 xdp_rxq_info-objs := xdp_rxq_info_user.o
@@ -117,6 +116,7 @@ ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
 xdp_sample_user-objs := xdp_sample_user.o $(LIBBPFDIR)/hashmap.o
+xdp_redirect_map-objs := xdp_redirect_map_user.o $(XDP_SAMPLE)
 xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
 xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
 
@@ -164,7 +164,6 @@ always-y += tcp_clamp_kern.o
 always-y += tcp_basertt_kern.o
 always-y += tcp_tos_reflect_kern.o
 always-y += tcp_dumpstats_kern.o
-always-y += xdp_redirect_map_kern.o
 always-y += xdp_redirect_map_multi_kern.o
 always-y += xdp_redirect_cpu_kern.o
 always-y += xdp_rxq_info_kern.o
@@ -314,6 +313,7 @@ verify_target_bpf: verify_cmds
 $(BPF_SAMPLES_PATH)/*.c: verify_target_bpf $(LIBBPF)
 $(src)/*.c: verify_target_bpf $(LIBBPF)
 
+$(obj)/xdp_redirect_map_user.o: $(obj)/xdp_redirect_map.skel.h
 $(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
 $(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
 
@@ -358,6 +358,7 @@ endef
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
 
+$(obj)/xdp_redirect_map.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_redirect.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_monitor.bpf.o: $(obj)/xdp_sample.bpf.o
 
@@ -369,9 +370,10 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(srctree)/tools/lib $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_redirect.skel.h xdp_monitor.skel.h
+LINKED_SKELS := xdp_redirect_map.skel.h xdp_redirect.skel.h xdp_monitor.skel.h
 clean-files += $(LINKED_SKELS)
 
+xdp_redirect_map.skel.h-deps := xdp_redirect_map.bpf.o xdp_sample.bpf.o
 xdp_redirect.skel.h-deps := xdp_redirect.bpf.o xdp_sample.bpf.o
 xdp_monitor.skel.h-deps := xdp_monitor.bpf.o xdp_sample.bpf.o
 
diff --git a/samples/bpf/xdp_redirect_map_kern.c b/samples/bpf/xdp_redirect_map.bpf.c
similarity index 62%
rename from samples/bpf/xdp_redirect_map_kern.c
rename to samples/bpf/xdp_redirect_map.bpf.c
index a92b8e567bdd..2e8d807ccd57 100644
--- a/samples/bpf/xdp_redirect_map_kern.c
+++ b/samples/bpf/xdp_redirect_map.bpf.c
@@ -10,14 +10,10 @@
  * General Public License for more details.
  */
 #define KBUILD_MODNAME "foo"
-#include <uapi/linux/bpf.h>
-#include <linux/in.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/if_vlan.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <bpf/bpf_helpers.h>
+
+#include "vmlinux.h"
+#include "xdp_sample.bpf.h"
+#include "xdp_sample_shared.h"
 
 /* The 2nd xdp prog on egress does not support skb mode, so we define two
  * maps, tx_port_general and tx_port_native.
@@ -36,67 +32,38 @@ struct {
 	__uint(max_entries, 100);
 } tx_port_native SEC(".maps");
 
-/* Count RX packets, as XDP bpf_prog doesn't get direct TX-success
- * feedback.  Redirect TX errors can be caught via a tracepoint.
- */
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__type(key, u32);
-	__type(value, long);
-	__uint(max_entries, 1);
-} rxcnt SEC(".maps");
-
-/* map to store egress interface mac address */
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, u32);
-	__type(value, __be64);
-	__uint(max_entries, 1);
-} tx_mac SEC(".maps");
-
-static void swap_src_dst_mac(void *data)
-{
-	unsigned short *p = data;
-	unsigned short dst[3];
-
-	dst[0] = p[0];
-	dst[1] = p[1];
-	dst[2] = p[2];
-	p[0] = p[3];
-	p[1] = p[4];
-	p[2] = p[5];
-	p[3] = dst[0];
-	p[4] = dst[1];
-	p[5] = dst[2];
-}
+/* store egress interface mac address */
+const volatile char tx_mac_addr[ETH_ALEN];
 
 static __always_inline int xdp_redirect_map(struct xdp_md *ctx, void *redirect_map)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
 	struct ethhdr *eth = data;
-	int rc = XDP_DROP;
-	long *value;
+	struct datarec *rec;
 	u32 key = 0;
 	u64 nh_off;
 	int vport;
 
 	nh_off = sizeof(*eth);
 	if (data + nh_off > data_end)
-		return rc;
+		return XDP_DROP;
 
 	/* constant virtual port */
 	vport = 0;
 
-	/* count packet in global counter */
-	value = bpf_map_lookup_elem(&rxcnt, &key);
-	if (value)
-		*value += 1;
+	if (key < MAX_CPUS) {
+		/* count packet in global counter */
+		rec = &sample_data.rx_cnt[key];
+		ATOMIC_INC_NORMW(rec->processed);
 
-	swap_src_dst_mac(data);
+		swap_src_dst_mac(data);
 
-	/* send packet out physical port */
-	return bpf_redirect_map(redirect_map, vport, 0);
+		/* send packet out physical port */
+		return bpf_redirect_map(redirect_map, vport, 0);
+	}
+
+	return XDP_PASS;
 }
 
 SEC("xdp_redirect_general")
@@ -117,17 +84,13 @@ int xdp_redirect_map_egress(struct xdp_md *ctx)
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
 	struct ethhdr *eth = data;
-	__be64 *mac;
-	u32 key = 0;
 	u64 nh_off;
 
 	nh_off = sizeof(*eth);
 	if (data + nh_off > data_end)
 		return XDP_DROP;
 
-	mac = bpf_map_lookup_elem(&tx_mac, &key);
-	if (mac)
-		__builtin_memcpy(eth->h_source, mac, ETH_ALEN);
+	__builtin_memcpy(eth->h_source, (const char *)tx_mac_addr, ETH_ALEN);
 
 	return XDP_PASS;
 }
diff --git a/samples/bpf/xdp_redirect_map_user.c b/samples/bpf/xdp_redirect_map_user.c
index ad3cdc4c07d3..d305beba902e 100644
--- a/samples/bpf/xdp_redirect_map_user.c
+++ b/samples/bpf/xdp_redirect_map_user.c
@@ -13,165 +13,102 @@
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
-
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
+#include "bpf_util.h"
+#include "xdp_sample_user.h"
+#include "xdp_redirect_map.skel.h"
+
+static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
+		  SAMPLE_EXCEPTION_CNT | SAMPLE_DEVMAP_XMIT_CNT;
+
+DEFINE_SAMPLE_INIT(xdp_redirect_map);
+
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
+
+static void usage(char *argv[])
 {
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
+	int i;
+
+	sample_print_help(mask);
+
+	printf("\n");
+	printf(" Usage: %s (options-see-below)\n",
+	       argv[0]);
+	printf(" Listing options:\n");
+	for (i = 0; long_options[i].name != 0; i++) {
+		printf(" --%-15s", long_options[i].name);
+		if (long_options[i].flag != NULL)
+			printf(" flag (internal value:%d)",
+			       *long_options[i].flag);
 		else
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
+			printf("short-option: -%c",
+			       long_options[i].val);
+		printf("\n");
 	}
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
-
-err_out:
-	close(fd);
-	return ret;
-}
-
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
+	printf("\n");
 }
 
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
+	int opt, key = 0;
+
+	while ((opt = getopt_long(argc, argv, "SFXi:vs",
+				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'S':
-			xdp_flags |= XDP_FLAGS_SKB_MODE;
-			break;
-		case 'N':
-			/* default, set below */
+			generic = true;
+			/* devmap_xmit tracepoint not available */
+			mask &= ~SAMPLE_DEVMAP_XMIT_CNT;
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
 		default:
-			usage(basename(argv[0]));
-			return 1;
+			usage(argv);
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
 	if (argc <= optind + 1) {
-		usage(basename(argv[0]));
-		return 1;
+		usage(argv);
+		return ret;
 	}
 
 	ifindex_in = if_nametoindex(argv[optind]);
@@ -182,107 +119,97 @@ int main(int argc, char **argv)
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
-	}
-
-	if (bpf_set_link_xdp_fd(ifindex_in, prog_fd, xdp_flags) < 0) {
-		printf("ERROR: link set xdp fd failed on %d\n", ifindex_in);
-		return 1;
-	}
-
-	ret = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
-	if (ret) {
-		printf("can't get prog info - %s\n", strerror(errno));
-		return ret;
-	}
-	prog_id = info.id;
-
-	/* Loading dummy XDP prog on out-device */
-	if (bpf_set_link_xdp_fd(ifindex_out, dummy_prog_fd,
-			    (xdp_flags | XDP_FLAGS_UPDATE_IF_NOEXIST)) < 0) {
-		printf("WARN: link set xdp fd failed on %d\n", ifindex_out);
-		ifindex_out_xdp_dummy_attached = false;
+	skel = xdp_redirect_map__open();
+	if (!skel) {
+		fprintf(stderr, "Failed to xdp_redirect_map__open: %s\n",
+			strerror(errno));
+		ret = EXIT_FAIL_BPF;
+		goto end;
 	}
 
-	memset(&info, 0, sizeof(info));
-	ret = bpf_obj_get_info_by_fd(dummy_prog_fd, &info, &info_len);
-	if (ret) {
-		printf("can't get prog info - %s\n", strerror(errno));
-		return ret;
-	}
-	dummy_prog_id = info.id;
-
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
+		fprintf(stderr, "Trying fallback to sizeof(int) as value_size for devmap in generic mode\n");
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
+		perror("if_nametoindex");
+		goto end_destroy;
+	}
+
+	if (!if_indextoname(ifindex_out, ifname_out)) {
+		perror("if_nametoindex");
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
2.32.0

