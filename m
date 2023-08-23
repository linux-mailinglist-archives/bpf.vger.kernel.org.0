Return-Path: <bpf+bounces-8361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F71785B30
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC4B1C20CD8
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16586C8F1;
	Wed, 23 Aug 2023 14:54:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE219C8D4
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 14:54:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD9E6F
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692802441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxsloiasmUxt/XWsjt2rlBkIIwWpFDrt+ciSY0YZA4I=;
	b=Vkv25lK34LEDrAun+0kGtx3e6nu+TIoWyvwEGLJ81fFDmagHmcUgquvgGS4CDeEnQbNGD9
	UJx8fb3uKUKEXZa1Itu6jVG3tmU0rHnPVTFkIcu5KaDmTngd7Sksx270Q4eRBco9xnbEZt
	TWttXBOW9MEAlByyj0mKHG2X++XFMls=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Te7alFkWP-mqakUpOheFPg-1; Wed, 23 Aug 2023 10:54:00 -0400
X-MC-Unique: Te7alFkWP-mqakUpOheFPg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bbbaa6001dso54229731fa.3
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802438; x=1693407238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxsloiasmUxt/XWsjt2rlBkIIwWpFDrt+ciSY0YZA4I=;
        b=X5Ebgoyb3iBP2B6qjJKRkujX3zjI2kNt/8nMPUjVFmF0sv1+1EZPwYQvHRr60ILsMG
         ntFFT/u99n97YX98V6TEJsKtf21bw7LH/OO505Pk/Si117Ewe+6TZR/sqq9m9jIlSAp1
         e9yy69HT6QyDnN19TM3oFxXMjW3rAgQYVg6nZb4w9FfD1d0ixVochVAOtwylya9DWkb7
         09J+9UjFjWKFE1vbkQkKI8SaFW0z6z1aoJc0pZ0uycy6BX/wrZs7339QpIjIrNJclxGy
         I/6L0m4almNW+7DocEKrjslGvXxYN/dd2s4VrTOU6V2xNoYJZuZy3xmI1Hoofx4rxCy5
         z5Aw==
X-Gm-Message-State: AOJu0YzzrH0N1RUZJOs9vMqGtLxZQI1NFs7L5h947ejBncvMXp+palBS
	3sF/neSsDPsdOQaWlHuXVMWKsRC4AH2L/3MdrP/L2hNaBx5xanhpxfTMoA5SPMLcJGZklB+uz7c
	IX7wS8bnkzAyV
X-Received: by 2002:a2e:9842:0:b0:2bc:c750:d9be with SMTP id e2-20020a2e9842000000b002bcc750d9bemr4455703ljj.29.1692802438266;
        Wed, 23 Aug 2023 07:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZiuLTz0gr1Y5sXUlIm8NLiTk+l0yeGN50ZItPwaQyYJox9cjOMhT8cRT3lTEt7sHa7bUczQ==
X-Received: by 2002:a2e:9842:0:b0:2bc:c750:d9be with SMTP id e2-20020a2e9842000000b002bcc750d9bemr4455687ljj.29.1692802437763;
        Wed, 23 Aug 2023 07:53:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id fy3-20020a170906b7c300b009894b476310sm9711573ejb.163.2023.08.23.07.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:53:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 91493D3CECE; Wed, 23 Aug 2023 16:53:56 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 4/6] samples/bpf: Remove the xdp1 and xdp2 utilities
Date: Wed, 23 Aug 2023 16:53:40 +0200
Message-ID: <20230823145346.1462819-5-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145346.1462819-1-toke@redhat.com>
References: <20230823145346.1462819-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The functionality of these utilities have been incorporated into the
xdp-bench utility in xdp-tools.

Equivalent functionality is:

xdp1 eth0
  --> xdp-bench drop -p parse-ip -l load-bytes eth0

xdp2 eth0
  --> xdp-bench drop -p swap-macs eth0

Note that there's a slight difference in behaviour of those examples: the
swap-macs operation of xdp-bench doesn't use the bpf_xdp_load_bytes()
helper to load the packet data, whereas the xdp2 utility did so
unconditionally. For the parse-ip action the use of bpf_xdp_load_bytes()
can be selected by the '-l load-bytes' switch, with the difference that the
xdp-bench utility will perform two separate calls to the helper, one to
load the ethernet header and another to load the IP header; where the xdp1
utility only performed one call always loading 60 bytes of data.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile    |   7 --
 samples/bpf/xdp1_kern.c | 100 ------------------------
 samples/bpf/xdp1_user.c | 166 ----------------------------------------
 samples/bpf/xdp2_kern.c | 125 ------------------------------
 4 files changed, 398 deletions(-)
 delete mode 100644 samples/bpf/xdp1_kern.c
 delete mode 100644 samples/bpf/xdp1_user.c
 delete mode 100644 samples/bpf/xdp2_kern.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index fb1dc9d96b2a..decd31167ee4 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -30,8 +30,6 @@ tprogs-y += test_cgrp2_array_pin
 tprogs-y += test_cgrp2_attach
 tprogs-y += test_cgrp2_sock
 tprogs-y += test_cgrp2_sock2
-tprogs-y += xdp1
-tprogs-y += xdp2
 tprogs-y += xdp_router_ipv4
 tprogs-y += test_current_task_under_cgroup
 tprogs-y += trace_event
@@ -83,9 +81,6 @@ test_cgrp2_array_pin-objs := test_cgrp2_array_pin.o
 test_cgrp2_attach-objs := test_cgrp2_attach.o
 test_cgrp2_sock-objs := test_cgrp2_sock.o
 test_cgrp2_sock2-objs := test_cgrp2_sock2.o
-xdp1-objs := xdp1_user.o
-# reuse xdp1 source intentionally
-xdp2-objs := xdp1_user.o
 test_current_task_under_cgroup-objs := $(CGROUP_HELPERS) \
 				       test_current_task_under_cgroup_user.o
 trace_event-objs := trace_event_user.o $(TRACE_HELPERS)
@@ -132,8 +127,6 @@ always-y += test_overhead_raw_tp.bpf.o
 always-y += test_overhead_kprobe.bpf.o
 always-y += parse_varlen.o parse_simple.o parse_ldabs.o
 always-y += test_cgrp2_tc.bpf.o
-always-y += xdp1_kern.o
-always-y += xdp2_kern.o
 always-y += test_current_task_under_cgroup.bpf.o
 always-y += trace_event_kern.o
 always-y += sampleip_kern.o
diff --git a/samples/bpf/xdp1_kern.c b/samples/bpf/xdp1_kern.c
deleted file mode 100644
index d91f27cbcfa9..000000000000
--- a/samples/bpf/xdp1_kern.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/* Copyright (c) 2016 PLUMgrid
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#define KBUILD_MODNAME "foo"
-#include <uapi/linux/bpf.h>
-#include <linux/in.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/if_vlan.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <bpf/bpf_helpers.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__type(key, u32);
-	__type(value, long);
-	__uint(max_entries, 256);
-} rxcnt SEC(".maps");
-
-static int parse_ipv4(void *data, u64 nh_off, void *data_end)
-{
-	struct iphdr *iph = data + nh_off;
-
-	if (iph + 1 > data_end)
-		return 0;
-	return iph->protocol;
-}
-
-static int parse_ipv6(void *data, u64 nh_off, void *data_end)
-{
-	struct ipv6hdr *ip6h = data + nh_off;
-
-	if (ip6h + 1 > data_end)
-		return 0;
-	return ip6h->nexthdr;
-}
-
-#define XDPBUFSIZE	60
-SEC("xdp.frags")
-int xdp_prog1(struct xdp_md *ctx)
-{
-	__u8 pkt[XDPBUFSIZE] = {};
-	void *data_end = &pkt[XDPBUFSIZE-1];
-	void *data = pkt;
-	struct ethhdr *eth = data;
-	int rc = XDP_DROP;
-	long *value;
-	u16 h_proto;
-	u64 nh_off;
-	u32 ipproto;
-
-	if (bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt)))
-		return rc;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return rc;
-
-	h_proto = eth->h_proto;
-
-	/* Handle VLAN tagged packet */
-	if (h_proto == htons(ETH_P_8021Q) || h_proto == htons(ETH_P_8021AD)) {
-		struct vlan_hdr *vhdr;
-
-		vhdr = data + nh_off;
-		nh_off += sizeof(struct vlan_hdr);
-		if (data + nh_off > data_end)
-			return rc;
-		h_proto = vhdr->h_vlan_encapsulated_proto;
-	}
-	/* Handle double VLAN tagged packet */
-	if (h_proto == htons(ETH_P_8021Q) || h_proto == htons(ETH_P_8021AD)) {
-		struct vlan_hdr *vhdr;
-
-		vhdr = data + nh_off;
-		nh_off += sizeof(struct vlan_hdr);
-		if (data + nh_off > data_end)
-			return rc;
-		h_proto = vhdr->h_vlan_encapsulated_proto;
-	}
-
-	if (h_proto == htons(ETH_P_IP))
-		ipproto = parse_ipv4(data, nh_off, data_end);
-	else if (h_proto == htons(ETH_P_IPV6))
-		ipproto = parse_ipv6(data, nh_off, data_end);
-	else
-		ipproto = 0;
-
-	value = bpf_map_lookup_elem(&rxcnt, &ipproto);
-	if (value)
-		*value += 1;
-
-	return rc;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp1_user.c b/samples/bpf/xdp1_user.c
deleted file mode 100644
index f05e797013e9..000000000000
--- a/samples/bpf/xdp1_user.c
+++ /dev/null
@@ -1,166 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2016 PLUMgrid
- */
-#include <linux/bpf.h>
-#include <linux/if_link.h>
-#include <assert.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <libgen.h>
-#include <net/if.h>
-
-#include "bpf_util.h"
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-static int ifindex;
-static __u32 xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
-static __u32 prog_id;
-
-static void int_exit(int sig)
-{
-	__u32 curr_prog_id = 0;
-
-	if (bpf_xdp_query_id(ifindex, xdp_flags, &curr_prog_id)) {
-		printf("bpf_xdp_query_id failed\n");
-		exit(1);
-	}
-	if (prog_id == curr_prog_id)
-		bpf_xdp_detach(ifindex, xdp_flags, NULL);
-	else if (!curr_prog_id)
-		printf("couldn't find a prog id on a given interface\n");
-	else
-		printf("program on interface changed, not removing\n");
-	exit(0);
-}
-
-/* simple per-protocol drop counter
- */
-static void poll_stats(int map_fd, int interval)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	__u64 values[nr_cpus], prev[UINT8_MAX] = { 0 };
-	int i;
-
-	while (1) {
-		__u32 key = UINT32_MAX;
-
-		sleep(interval);
-
-		while (bpf_map_get_next_key(map_fd, &key, &key) == 0) {
-			__u64 sum = 0;
-
-			assert(bpf_map_lookup_elem(map_fd, &key, values) == 0);
-			for (i = 0; i < nr_cpus; i++)
-				sum += values[i];
-			if (sum > prev[key])
-				printf("proto %u: %10llu pkt/s\n",
-				       key, (sum - prev[key]) / interval);
-			prev[key] = sum;
-		}
-	}
-}
-
-static void usage(const char *prog)
-{
-	fprintf(stderr,
-		"usage: %s [OPTS] IFACE\n\n"
-		"OPTS:\n"
-		"    -S    use skb-mode\n"
-		"    -N    enforce native mode\n"
-		"    -F    force loading prog\n",
-		prog);
-}
-
-int main(int argc, char **argv)
-{
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	const char *optstr = "FSN";
-	int prog_fd, map_fd, opt;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	struct bpf_map *map;
-	char filename[256];
-	int err;
-
-	while ((opt = getopt(argc, argv, optstr)) != -1) {
-		switch (opt) {
-		case 'S':
-			xdp_flags |= XDP_FLAGS_SKB_MODE;
-			break;
-		case 'N':
-			/* default, set below */
-			break;
-		case 'F':
-			xdp_flags &= ~XDP_FLAGS_UPDATE_IF_NOEXIST;
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
-	ifindex = if_nametoindex(argv[optind]);
-	if (!ifindex) {
-		perror("if_nametoindex");
-		return 1;
-	}
-
-	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
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
-	if (!prog_fd) {
-		printf("bpf_prog_load_xattr: %s\n", strerror(errno));
-		return 1;
-	}
-
-	signal(SIGINT, int_exit);
-	signal(SIGTERM, int_exit);
-
-	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
-		printf("link set xdp fd failed\n");
-		return 1;
-	}
-
-	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
-	if (err) {
-		printf("can't get prog info - %s\n", strerror(errno));
-		return err;
-	}
-	prog_id = info.id;
-
-	poll_stats(map_fd, 1);
-
-	return 0;
-}
diff --git a/samples/bpf/xdp2_kern.c b/samples/bpf/xdp2_kern.c
deleted file mode 100644
index 8bca674451ed..000000000000
--- a/samples/bpf/xdp2_kern.c
+++ /dev/null
@@ -1,125 +0,0 @@
-/* Copyright (c) 2016 PLUMgrid
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#define KBUILD_MODNAME "foo"
-#include <uapi/linux/bpf.h>
-#include <linux/in.h>
-#include <linux/if_ether.h>
-#include <linux/if_packet.h>
-#include <linux/if_vlan.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <bpf/bpf_helpers.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__type(key, u32);
-	__type(value, long);
-	__uint(max_entries, 256);
-} rxcnt SEC(".maps");
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
-
-static int parse_ipv4(void *data, u64 nh_off, void *data_end)
-{
-	struct iphdr *iph = data + nh_off;
-
-	if (iph + 1 > data_end)
-		return 0;
-	return iph->protocol;
-}
-
-static int parse_ipv6(void *data, u64 nh_off, void *data_end)
-{
-	struct ipv6hdr *ip6h = data + nh_off;
-
-	if (ip6h + 1 > data_end)
-		return 0;
-	return ip6h->nexthdr;
-}
-
-#define XDPBUFSIZE	60
-SEC("xdp.frags")
-int xdp_prog1(struct xdp_md *ctx)
-{
-	__u8 pkt[XDPBUFSIZE] = {};
-	void *data_end = &pkt[XDPBUFSIZE-1];
-	void *data = pkt;
-	struct ethhdr *eth = data;
-	int rc = XDP_DROP;
-	long *value;
-	u16 h_proto;
-	u64 nh_off;
-	u32 ipproto;
-
-	if (bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt)))
-		return rc;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return rc;
-
-	h_proto = eth->h_proto;
-
-	/* Handle VLAN tagged packet */
-	if (h_proto == htons(ETH_P_8021Q) || h_proto == htons(ETH_P_8021AD)) {
-		struct vlan_hdr *vhdr;
-
-		vhdr = data + nh_off;
-		nh_off += sizeof(struct vlan_hdr);
-		if (data + nh_off > data_end)
-			return rc;
-		h_proto = vhdr->h_vlan_encapsulated_proto;
-	}
-	/* Handle double VLAN tagged packet */
-	if (h_proto == htons(ETH_P_8021Q) || h_proto == htons(ETH_P_8021AD)) {
-		struct vlan_hdr *vhdr;
-
-		vhdr = data + nh_off;
-		nh_off += sizeof(struct vlan_hdr);
-		if (data + nh_off > data_end)
-			return rc;
-		h_proto = vhdr->h_vlan_encapsulated_proto;
-	}
-
-	if (h_proto == htons(ETH_P_IP))
-		ipproto = parse_ipv4(data, nh_off, data_end);
-	else if (h_proto == htons(ETH_P_IPV6))
-		ipproto = parse_ipv6(data, nh_off, data_end);
-	else
-		ipproto = 0;
-
-	value = bpf_map_lookup_elem(&rxcnt, &ipproto);
-	if (value)
-		*value += 1;
-
-	if (ipproto == IPPROTO_UDP) {
-		swap_src_dst_mac(data);
-
-		if (bpf_xdp_store_bytes(ctx, 0, pkt, sizeof(pkt)))
-			return rc;
-
-		rc = XDP_TX;
-	}
-
-	return rc;
-}
-
-char _license[] SEC("license") = "GPL";
-- 
2.41.0


