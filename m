Return-Path: <bpf+bounces-8459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A19786CBA
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207A81C20DE2
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845BE1119B;
	Thu, 24 Aug 2023 10:23:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47B10978
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 10:23:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F319A0
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692872586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRpVAIJLJf1MrgLmXYu+Ow7eTOUvzpBkljB5pD0iIkQ=;
	b=C7MjgWlzU0VNij9xpgtagFrdFz1w7X2FyJElqgOUoGp6ghY8rDol61xRfoWDpE/MHXZbwB
	Li9Z5CgbgiEez1Oif2RwVnHKvDL/SGLpdeiUq+Z9TLRAEKlkdz2Th/IElzp6Zb1AJjk+85
	T2thxnDsVydYmz3Qft0l/CQLoV5y494=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Zdhmng79N-CF3EQEdJyk5Q-1; Thu, 24 Aug 2023 06:23:04 -0400
X-MC-Unique: Zdhmng79N-CF3EQEdJyk5Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bca0b9234so455117666b.2
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692872584; x=1693477384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRpVAIJLJf1MrgLmXYu+Ow7eTOUvzpBkljB5pD0iIkQ=;
        b=XlrDTA0bq/6qaTuSXtDmHM3B/dXGzCXbPh+XaNGGD+AaT3Toz5Wk3ir0Q5WGEpxUfg
         Jar2SPei8aiGxMpTvRbMsiOyry5WXphodzmJmmRo2Bt0NsoWYmYkBNijtO4dpGJrU0We
         5ik9qx3K8yhmn1tk38cGC9G1X2NY+73arD097fSwV1dDACv3Lxb+PT4EPHzMnMbZnCzN
         Sgc7F6Q6Al5iQwBGoZZT/Vt7bIQJk2lZWtMwlzxdaJ+Q/HK1djozrgDPMkLqJgggA8wG
         MX8TRKqOMfTclYQ6fH+LfQSN+bk1+tRYV6OQ1ARyI0V+SUUG2NysoX7HpxISnfhTBoP9
         nxwg==
X-Gm-Message-State: AOJu0YxFlOaYdFEnnY5+O/Szv8UFWQPBuIcsOATmVmWxNLydqhKFNnJH
	4H+Sc0HAgDqulTWR/mU3pn24QPSW/yBrTq49mOXA6LpQyTcBNWVLfvYGjE5+FObJ4Dlh9OzWa4/
	hiOVMMHgxSva4
X-Received: by 2002:a17:907:2722:b0:982:45ca:ac06 with SMTP id d2-20020a170907272200b0098245caac06mr11629743ejl.60.1692872583657;
        Thu, 24 Aug 2023 03:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoMnfLDC+N/2S45M2hOdfplOGTJrIYKNao5Ff2jtxHR1SPS0UkCDJGpZ1D5TAzB0PAfN9Zig==
X-Received: by 2002:a17:907:2722:b0:982:45ca:ac06 with SMTP id d2-20020a170907272200b0098245caac06mr11629727ejl.60.1692872583365;
        Thu, 24 Aug 2023 03:23:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p23-20020a170906141700b009931a3adf64sm10903365ejc.17.2023.08.24.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:23:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 396E7D3D0A3; Thu, 24 Aug 2023 12:23:01 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 5/7] samples/bpf: Remove the xdp_sample_pkts utility
Date: Thu, 24 Aug 2023 12:22:48 +0200
Message-ID: <20230824102255.1561885-6-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824102255.1561885-1-toke@redhat.com>
References: <20230824102255.1561885-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The functionality of this utility is covered by the xdpdump utility in
xdp-tools.

There's a slight difference in usage as the xdpdump utility's main focus is
to dump packets before or after they are processed by an existing XDP
program. However, xdpdump also has the --load-xdp-program switch, which
will make it attach its own program if no existing program is loaded. With
this, xdp_sample_pkts usage can be converted as:

xdp_sample_pkts eth0
  --> xdpdump --load-xdp-program eth0

To get roughly equivalent behaviour.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile               |   3 -
 samples/bpf/xdp_sample_pkts_kern.c |  57 ---------
 samples/bpf/xdp_sample_pkts_user.c | 196 -----------------------------
 3 files changed, 256 deletions(-)
 delete mode 100644 samples/bpf/xdp_sample_pkts_kern.c
 delete mode 100644 samples/bpf/xdp_sample_pkts_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index decd31167ee4..4ccf4236031c 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -44,7 +44,6 @@ tprogs-y += cpustat
 tprogs-y += xdp_adjust_tail
 tprogs-y += xdp_fwd
 tprogs-y += task_fd_query
-tprogs-y += xdp_sample_pkts
 tprogs-y += ibumad
 tprogs-y += hbm
 
@@ -95,7 +94,6 @@ cpustat-objs := cpustat_user.o
 xdp_adjust_tail-objs := xdp_adjust_tail_user.o
 xdp_fwd-objs := xdp_fwd_user.o
 task_fd_query-objs := task_fd_query_user.o $(TRACE_HELPERS)
-xdp_sample_pkts-objs := xdp_sample_pkts_user.o
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
@@ -148,7 +146,6 @@ always-y += cpustat_kern.o
 always-y += xdp_adjust_tail_kern.o
 always-y += xdp_fwd_kern.o
 always-y += task_fd_query_kern.o
-always-y += xdp_sample_pkts_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
diff --git a/samples/bpf/xdp_sample_pkts_kern.c b/samples/bpf/xdp_sample_pkts_kern.c
deleted file mode 100644
index 9cf76b340dd7..000000000000
--- a/samples/bpf/xdp_sample_pkts_kern.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/ptrace.h>
-#include <linux/version.h>
-#include <uapi/linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-#define SAMPLE_SIZE 64ul
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(u32));
-} my_map SEC(".maps");
-
-SEC("xdp_sample")
-int xdp_sample_prog(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-
-	/* Metadata will be in the perf event before the packet data. */
-	struct S {
-		u16 cookie;
-		u16 pkt_len;
-	} __packed metadata;
-
-	if (data < data_end) {
-		/* The XDP perf_event_output handler will use the upper 32 bits
-		 * of the flags argument as a number of bytes to include of the
-		 * packet payload in the event data. If the size is too big, the
-		 * call to bpf_perf_event_output will fail and return -EFAULT.
-		 *
-		 * See bpf_xdp_event_output in net/core/filter.c.
-		 *
-		 * The BPF_F_CURRENT_CPU flag means that the event output fd
-		 * will be indexed by the CPU number in the event map.
-		 */
-		u64 flags = BPF_F_CURRENT_CPU;
-		u16 sample_size;
-		int ret;
-
-		metadata.cookie = 0xdead;
-		metadata.pkt_len = (u16)(data_end - data);
-		sample_size = min(metadata.pkt_len, SAMPLE_SIZE);
-		flags |= (u64)sample_size << 32;
-
-		ret = bpf_perf_event_output(ctx, &my_map, flags,
-					    &metadata, sizeof(metadata));
-		if (ret)
-			bpf_printk("perf_event_output failed: %d\n", ret);
-	}
-
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/xdp_sample_pkts_user.c b/samples/bpf/xdp_sample_pkts_user.c
deleted file mode 100644
index e39d7f654f30..000000000000
--- a/samples/bpf/xdp_sample_pkts_user.c
+++ /dev/null
@@ -1,196 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <linux/perf_event.h>
-#include <linux/bpf.h>
-#include <net/if.h>
-#include <errno.h>
-#include <assert.h>
-#include <sys/sysinfo.h>
-#include <sys/ioctl.h>
-#include <signal.h>
-#include <bpf/libbpf.h>
-#include <bpf/bpf.h>
-#include <libgen.h>
-#include <linux/if_link.h>
-
-#include "perf-sys.h"
-
-static int if_idx;
-static char *if_name;
-static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-static __u32 prog_id;
-static struct perf_buffer *pb = NULL;
-
-static int do_attach(int idx, int fd, const char *name)
-{
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	int err;
-
-	err = bpf_xdp_attach(idx, fd, xdp_flags, NULL);
-	if (err < 0) {
-		printf("ERROR: failed to attach program to %s\n", name);
-		return err;
-	}
-
-	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
-	if (err) {
-		printf("can't get prog info - %s\n", strerror(errno));
-		return err;
-	}
-	prog_id = info.id;
-
-	return err;
-}
-
-static int do_detach(int idx, const char *name)
-{
-	__u32 curr_prog_id = 0;
-	int err = 0;
-
-	err = bpf_xdp_query_id(idx, xdp_flags, &curr_prog_id);
-	if (err) {
-		printf("bpf_xdp_query_id failed\n");
-		return err;
-	}
-	if (prog_id == curr_prog_id) {
-		err = bpf_xdp_detach(idx, xdp_flags, NULL);
-		if (err < 0)
-			printf("ERROR: failed to detach prog from %s\n", name);
-	} else if (!curr_prog_id) {
-		printf("couldn't find a prog id on a %s\n", name);
-	} else {
-		printf("program on interface changed, not removing\n");
-	}
-
-	return err;
-}
-
-#define SAMPLE_SIZE 64
-
-static void print_bpf_output(void *ctx, int cpu, void *data, __u32 size)
-{
-	struct {
-		__u16 cookie;
-		__u16 pkt_len;
-		__u8  pkt_data[SAMPLE_SIZE];
-	} __packed *e = data;
-	int i;
-
-	if (e->cookie != 0xdead) {
-		printf("BUG cookie %x sized %d\n", e->cookie, size);
-		return;
-	}
-
-	printf("Pkt len: %-5d bytes. Ethernet hdr: ", e->pkt_len);
-	for (i = 0; i < 14 && i < e->pkt_len; i++)
-		printf("%02x ", e->pkt_data[i]);
-	printf("\n");
-}
-
-static void sig_handler(int signo)
-{
-	do_detach(if_idx, if_name);
-	perf_buffer__free(pb);
-	exit(0);
-}
-
-static void usage(const char *prog)
-{
-	fprintf(stderr,
-		"%s: %s [OPTS] <ifname|ifindex>\n\n"
-		"OPTS:\n"
-		"    -F    force loading prog\n"
-		"    -S    use skb-mode\n",
-		__func__, prog);
-}
-
-int main(int argc, char **argv)
-{
-	const char *optstr = "FS";
-	int prog_fd, map_fd, opt;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	struct bpf_map *map;
-	char filename[256];
-	int ret, err;
-
-	while ((opt = getopt(argc, argv, optstr)) != -1) {
-		switch (opt) {
-		case 'F':
-			xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
-			break;
-		case 'S':
-			xdp_flags |= XDP_FLAGS_SKB_MODE;
-			break;
-		default:
-			usage(basename(argv[0]));
-			return 1;
-		}
-	}
-
-	if (!(xdp_flags & XDP_FLAGS_SKB_MODE))
-		xdp_flags |= XDP_FLAGS_DRV_MODE;
-
-	if (optind == argc) {
-		usage(basename(argv[0]));
-		return 1;
-	}
-
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
-
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj))
-		return 1;
-
-	prog = bpf_object__next_program(obj, NULL);
-	bpf_program__set_type(prog, BPF_PROG_TYPE_XDP);
-
-	err = bpf_object__load(obj);
-	if (err)
-		return 1;
-
-	prog_fd = bpf_program__fd(prog);
-
-	map = bpf_object__next_map(obj, NULL);
-	if (!map) {
-		printf("finding a map in obj file failed\n");
-		return 1;
-	}
-	map_fd = bpf_map__fd(map);
-
-	if_idx = if_nametoindex(argv[optind]);
-	if (!if_idx)
-		if_idx = strtoul(argv[optind], NULL, 0);
-
-	if (!if_idx) {
-		fprintf(stderr, "Invalid ifname\n");
-		return 1;
-	}
-	if_name = argv[optind];
-	err = do_attach(if_idx, prog_fd, if_name);
-	if (err)
-		return err;
-
-	if (signal(SIGINT, sig_handler) ||
-	    signal(SIGHUP, sig_handler) ||
-	    signal(SIGTERM, sig_handler)) {
-		perror("signal");
-		return 1;
-	}
-
-	pb = perf_buffer__new(map_fd, 8, print_bpf_output, NULL, NULL, NULL);
-	err = libbpf_get_error(pb);
-	if (err) {
-		perror("perf_buffer setup failed");
-		return 1;
-	}
-
-	while ((ret = perf_buffer__poll(pb, 1000)) >= 0) {
-	}
-
-	kill(0, SIGINT);
-	return ret;
-}
-- 
2.41.0


