Return-Path: <bpf+bounces-8363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C56785B41
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F528131B
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC285CA7B;
	Wed, 23 Aug 2023 14:54:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E40CA71
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 14:54:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AA5E6D
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692802441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDENp8VXFoqHJVi0bGQY+fOABlqD5zspWMYbIK27jJc=;
	b=VxxwezvcvwebHcQ5pcHfgx+w6jCaq8KgxKk34+1Pqy2Xzc69bw18OkN8xQr58vDLpwJa4o
	GIJfV+9YE/8ZOmQLYCeGUZqbLMaWnNarBRPz5k3OPPkk8trdInRaV8LVwEeY8cGYtpACa4
	M0uPIWNunN+s9hTsM7qm7LbKGljo608=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Xj2_9bnJOe6Daqja3YJZLA-1; Wed, 23 Aug 2023 10:53:59 -0400
X-MC-Unique: Xj2_9bnJOe6Daqja3YJZLA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bfe6a531bso398570266b.1
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802438; x=1693407238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDENp8VXFoqHJVi0bGQY+fOABlqD5zspWMYbIK27jJc=;
        b=c3mPBPQ+lrp5oS2o06lOc+RqkjLJeFRNSIWb3ZVKYIhZ/JWqrD/U5aUsP1uwEgGMUx
         95inL2REXzIJVarWYapy9H+pHAYGrmG2Nrcxe37i7ev9aQWZ3xj+PrWpLshCisGwWoQn
         HSo8qEonjiIUGbCkjr2WV/7IaMX5dVmjltZDOQwZqKe/D6ugAmATDS9ZqqYeoLtCQPDK
         5W18W+4rE3ietg0/Xw0QA3fNaTsrqWTc3gv6VlyUHaSyt9FR1RhUVAZUq7Q/CfaitUVt
         2cjQagbZvjlAQVHoi9RRD6fxo9bjw828Yri0mHQQKMt8QrR8lJrzsAlnDkit9K+rROgj
         gYiA==
X-Gm-Message-State: AOJu0YyNGrhyAiMAsXz3Fgj0b8lRR1Ewwbjyhztp0u+qu03AUkVsWgDc
	uqoB2tLd9lk9eC5gLTTQCA0h+N4XXzogG1baU8YfziKSoBHhn2v3i2Psv3XhBb180wHGvQD/Iys
	uXr/PVc03XK/p
X-Received: by 2002:a17:906:1da1:b0:99b:c86b:1d25 with SMTP id u1-20020a1709061da100b0099bc86b1d25mr10103624ejh.26.1692802437218;
        Wed, 23 Aug 2023 07:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfMhryHL0dsaLDBK0L5M5B7TvY6cBdyNQcMK2Kp1kZC4w63grq2LpJA69G5/mFp9K9iAPQEA==
X-Received: by 2002:a17:906:1da1:b0:99b:c86b:1d25 with SMTP id u1-20020a1709061da100b0099bc86b1d25mr10103600ejh.26.1692802436592;
        Wed, 23 Aug 2023 07:53:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jp19-20020a170906f75300b0099cd1c0cb21sm9848083ejb.129.2023.08.23.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:53:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 29DA3D3CECA; Wed, 23 Aug 2023 16:53:55 +0200 (CEST)
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
Subject: [PATCH bpf-next v2 2/6] samples/bpf: Remove the xdp_redirect* utilities
Date: Wed, 23 Aug 2023 16:53:38 +0200
Message-ID: <20230823145346.1462819-3-toke@redhat.com>
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
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These utilities have all been ported to xdp-tools as functions of the
xdp-bench utility. The four different utilities in samples are incorporated
as separate subcommands to xdp-bench, with most of the command line
parameters left intact, except that mandatory arguments are always
positional in xdp-bench. For full usage details see the --help output of
each command, or the xdp-bench man page.

Some examples of how to convert usage to xdp-bench are:

xdp_redirect eth0 eth1
  --> xdp-bench redirect eth0 eth1

xdp_redirect_map eth0 eth1
  --> xdp-bench redirect-map eth0 eth1

xdp_redirect_map_multi eth0 eth1 eth2 eth3
  --> xdp-bench redirect-multi eth0 eth1 eth2 eth3

xdp_redirect_cpu -d eth0 -c 0 -c 1
  --> xdp-bench redirect-cpu -c 0 -c 1 eth0

xdp_redirect_cpu -d eth0 -c 0 -c 1 -r eth1
  --> xdp-bench redirect-cpu -c 0 -c 1 eth0 -r redirect -D eth1

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile                      |  29 +-
 samples/bpf/xdp_redirect.bpf.c            |  49 --
 samples/bpf/xdp_redirect_cpu.bpf.c        | 539 ---------------------
 samples/bpf/xdp_redirect_cpu_user.c       | 559 ----------------------
 samples/bpf/xdp_redirect_map.bpf.c        |  97 ----
 samples/bpf/xdp_redirect_map_multi.bpf.c  |  77 ---
 samples/bpf/xdp_redirect_map_multi_user.c | 232 ---------
 samples/bpf/xdp_redirect_map_user.c       | 228 ---------
 samples/bpf/xdp_redirect_user.c           | 172 -------
 9 files changed, 1 insertion(+), 1981 deletions(-)
 delete mode 100644 samples/bpf/xdp_redirect.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_cpu.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_cpu_user.c
 delete mode 100644 samples/bpf/xdp_redirect_map.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_map_multi.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_map_multi_user.c
 delete mode 100644 samples/bpf/xdp_redirect_map_user.c
 delete mode 100644 samples/bpf/xdp_redirect_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 29b07c4ec066..d2f5c043e4f3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -51,11 +51,6 @@ tprogs-y += xdp_sample_pkts
 tprogs-y += ibumad
 tprogs-y += hbm
 
-tprogs-y += xdp_redirect_cpu
-tprogs-y += xdp_redirect_map_multi
-tprogs-y += xdp_redirect_map
-tprogs-y += xdp_redirect
-
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
 LIBBPF_OUTPUT = $(abspath $(BPF_SAMPLES_PATH))/libbpf
@@ -111,10 +106,6 @@ xdp_sample_pkts-objs := xdp_sample_pkts_user.o
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
-xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o $(XDP_SAMPLE)
-xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o $(XDP_SAMPLE)
-xdp_redirect_map-objs := xdp_redirect_map_user.o $(XDP_SAMPLE)
-xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
 
 # Tell kbuild to always build the programs
@@ -205,10 +196,6 @@ TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
 endif
 
 TPROGS_LDLIBS			+= $(LIBBPF) -lelf -lz
-TPROGLDLIBS_xdp_redirect	+= -lm
-TPROGLDLIBS_xdp_redirect_cpu	+= -lm
-TPROGLDLIBS_xdp_redirect_map	+= -lm
-TPROGLDLIBS_xdp_redirect_map_multi += -lm
 TPROGLDLIBS_xdp_router_ipv4	+= -lm -pthread
 TPROGLDLIBS_tracex4		+= -lrt
 TPROGLDLIBS_trace_output	+= -lrt
@@ -323,10 +310,6 @@ $(obj)/$(TRACE_HELPERS) $(obj)/$(CGROUP_HELPERS) $(obj)/$(XDP_SAMPLE): | libbpf_
 
 .PHONY: libbpf_hdrs
 
-$(obj)/xdp_redirect_cpu_user.o: $(obj)/xdp_redirect_cpu.skel.h
-$(obj)/xdp_redirect_map_multi_user.o: $(obj)/xdp_redirect_map_multi.skel.h
-$(obj)/xdp_redirect_map_user.o: $(obj)/xdp_redirect_map.skel.h
-$(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
 $(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
 
 $(obj)/tracex5.bpf.o: $(obj)/syscall_nrs.h
@@ -379,10 +362,6 @@ endef
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
 
-$(obj)/xdp_redirect_cpu.bpf.o: $(obj)/xdp_sample.bpf.o
-$(obj)/xdp_redirect_map_multi.bpf.o: $(obj)/xdp_sample.bpf.o
-$(obj)/xdp_redirect_map.bpf.o: $(obj)/xdp_sample.bpf.o
-$(obj)/xdp_redirect.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
@@ -393,15 +372,9 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_redirect_cpu.skel.h xdp_redirect_map_multi.skel.h \
-		xdp_redirect_map.skel.h xdp_redirect.skel.h \
-		xdp_router_ipv4.skel.h
+LINKED_SKELS := xdp_router_ipv4.skel.h
 clean-files += $(LINKED_SKELS)
 
-xdp_redirect_cpu.skel.h-deps := xdp_redirect_cpu.bpf.o xdp_sample.bpf.o
-xdp_redirect_map_multi.skel.h-deps := xdp_redirect_map_multi.bpf.o xdp_sample.bpf.o
-xdp_redirect_map.skel.h-deps := xdp_redirect_map.bpf.o xdp_sample.bpf.o
-xdp_redirect.skel.h-deps := xdp_redirect.bpf.o xdp_sample.bpf.o
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
diff --git a/samples/bpf/xdp_redirect.bpf.c b/samples/bpf/xdp_redirect.bpf.c
deleted file mode 100644
index 7c02bacfe96b..000000000000
--- a/samples/bpf/xdp_redirect.bpf.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2016 John Fastabend <john.r.fastabend@intel.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- */
-#include "vmlinux.h"
-#include "xdp_sample.bpf.h"
-#include "xdp_sample_shared.h"
-
-const volatile int ifindex_out;
-
-SEC("xdp")
-int xdp_redirect_prog(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-	u32 key = bpf_get_smp_processor_id();
-	struct ethhdr *eth = data;
-	struct datarec *rec;
-	u64 nh_off;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return XDP_DROP;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-
-	swap_src_dst_mac(data);
-	return bpf_redirect(ifindex_out, 0);
-}
-
-/* Redirect require an XDP bpf_prog loaded on the TX device */
-SEC("xdp")
-int xdp_redirect_dummy_prog(struct xdp_md *ctx)
-{
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_redirect_cpu.bpf.c b/samples/bpf/xdp_redirect_cpu.bpf.c
deleted file mode 100644
index 87c54bfdbb70..000000000000
--- a/samples/bpf/xdp_redirect_cpu.bpf.c
+++ /dev/null
@@ -1,539 +0,0 @@
-/*  XDP redirect to CPUs via cpumap (BPF_MAP_TYPE_CPUMAP)
- *
- *  GPLv2, Copyright(c) 2017 Jesper Dangaard Brouer, Red Hat, Inc.
- */
-#include "vmlinux.h"
-#include "xdp_sample.bpf.h"
-#include "xdp_sample_shared.h"
-#include "hash_func01.h"
-
-/* Special map type that can XDP_REDIRECT frames to another CPU */
-struct {
-	__uint(type, BPF_MAP_TYPE_CPUMAP);
-	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(struct bpf_cpumap_val));
-} cpu_map SEC(".maps");
-
-/* Set of maps controlling available CPU, and for iterating through
- * selectable redirect CPUs.
- */
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, u32);
-	__type(value, u32);
-} cpus_available SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, u32);
-	__type(value, u32);
-	__uint(max_entries, 1);
-} cpus_count SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__type(key, u32);
-	__type(value, u32);
-	__uint(max_entries, 1);
-} cpus_iterator SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_DEVMAP);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(struct bpf_devmap_val));
-	__uint(max_entries, 1);
-} tx_port SEC(".maps");
-
-char tx_mac_addr[ETH_ALEN];
-
-/* Helper parse functions */
-
-static __always_inline
-bool parse_eth(struct ethhdr *eth, void *data_end,
-	       u16 *eth_proto, u64 *l3_offset)
-{
-	u16 eth_type;
-	u64 offset;
-
-	offset = sizeof(*eth);
-	if ((void *)eth + offset > data_end)
-		return false;
-
-	eth_type = eth->h_proto;
-
-	/* Skip non 802.3 Ethertypes */
-	if (__builtin_expect(bpf_ntohs(eth_type) < ETH_P_802_3_MIN, 0))
-		return false;
-
-	/* Handle VLAN tagged packet */
-	if (eth_type == bpf_htons(ETH_P_8021Q) ||
-	    eth_type == bpf_htons(ETH_P_8021AD)) {
-		struct vlan_hdr *vlan_hdr;
-
-		vlan_hdr = (void *)eth + offset;
-		offset += sizeof(*vlan_hdr);
-		if ((void *)eth + offset > data_end)
-			return false;
-		eth_type = vlan_hdr->h_vlan_encapsulated_proto;
-	}
-	/* Handle double VLAN tagged packet */
-	if (eth_type == bpf_htons(ETH_P_8021Q) ||
-	    eth_type == bpf_htons(ETH_P_8021AD)) {
-		struct vlan_hdr *vlan_hdr;
-
-		vlan_hdr = (void *)eth + offset;
-		offset += sizeof(*vlan_hdr);
-		if ((void *)eth + offset > data_end)
-			return false;
-		eth_type = vlan_hdr->h_vlan_encapsulated_proto;
-	}
-
-	*eth_proto = bpf_ntohs(eth_type);
-	*l3_offset = offset;
-	return true;
-}
-
-static __always_inline
-u16 get_dest_port_ipv4_udp(struct xdp_md *ctx, u64 nh_off)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	struct iphdr *iph = data + nh_off;
-	struct udphdr *udph;
-
-	if (iph + 1 > data_end)
-		return 0;
-	if (!(iph->protocol == IPPROTO_UDP))
-		return 0;
-
-	udph = (void *)(iph + 1);
-	if (udph + 1 > data_end)
-		return 0;
-
-	return bpf_ntohs(udph->dest);
-}
-
-static __always_inline
-int get_proto_ipv4(struct xdp_md *ctx, u64 nh_off)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	struct iphdr *iph = data + nh_off;
-
-	if (iph + 1 > data_end)
-		return 0;
-	return iph->protocol;
-}
-
-static __always_inline
-int get_proto_ipv6(struct xdp_md *ctx, u64 nh_off)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	struct ipv6hdr *ip6h = data + nh_off;
-
-	if (ip6h + 1 > data_end)
-		return 0;
-	return ip6h->nexthdr;
-}
-
-SEC("xdp")
-int  xdp_prognum0_no_touch(struct xdp_md *ctx)
-{
-	u32 key = bpf_get_smp_processor_id();
-	struct datarec *rec;
-	u32 *cpu_selected;
-	u32 cpu_dest = 0;
-	u32 key0 = 0;
-
-	/* Only use first entry in cpus_available */
-	cpu_selected = bpf_map_lookup_elem(&cpus_available, &key0);
-	if (!cpu_selected)
-		return XDP_ABORTED;
-	cpu_dest = *cpu_selected;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-
-	if (cpu_dest >= nr_cpus) {
-		NO_TEAR_INC(rec->issue);
-		return XDP_ABORTED;
-	}
-	return bpf_redirect_map(&cpu_map, cpu_dest, 0);
-}
-
-SEC("xdp")
-int  xdp_prognum1_touch_data(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	u32 key = bpf_get_smp_processor_id();
-	struct ethhdr *eth = data;
-	struct datarec *rec;
-	u32 *cpu_selected;
-	u32 cpu_dest = 0;
-	u32 key0 = 0;
-	u16 eth_type;
-
-	/* Only use first entry in cpus_available */
-	cpu_selected = bpf_map_lookup_elem(&cpus_available, &key0);
-	if (!cpu_selected)
-		return XDP_ABORTED;
-	cpu_dest = *cpu_selected;
-
-	/* Validate packet length is minimum Eth header size */
-	if (eth + 1 > data_end)
-		return XDP_ABORTED;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-
-	/* Read packet data, and use it (drop non 802.3 Ethertypes) */
-	eth_type = eth->h_proto;
-	if (bpf_ntohs(eth_type) < ETH_P_802_3_MIN) {
-		NO_TEAR_INC(rec->dropped);
-		return XDP_DROP;
-	}
-
-	if (cpu_dest >= nr_cpus) {
-		NO_TEAR_INC(rec->issue);
-		return XDP_ABORTED;
-	}
-	return bpf_redirect_map(&cpu_map, cpu_dest, 0);
-}
-
-SEC("xdp")
-int  xdp_prognum2_round_robin(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	u32 key = bpf_get_smp_processor_id();
-	struct datarec *rec;
-	u32 cpu_dest = 0;
-	u32 key0 = 0;
-
-	u32 *cpu_selected;
-	u32 *cpu_iterator;
-	u32 *cpu_max;
-	u32 cpu_idx;
-
-	cpu_max = bpf_map_lookup_elem(&cpus_count, &key0);
-	if (!cpu_max)
-		return XDP_ABORTED;
-
-	cpu_iterator = bpf_map_lookup_elem(&cpus_iterator, &key0);
-	if (!cpu_iterator)
-		return XDP_ABORTED;
-	cpu_idx = *cpu_iterator;
-
-	*cpu_iterator += 1;
-	if (*cpu_iterator == *cpu_max)
-		*cpu_iterator = 0;
-
-	cpu_selected = bpf_map_lookup_elem(&cpus_available, &cpu_idx);
-	if (!cpu_selected)
-		return XDP_ABORTED;
-	cpu_dest = *cpu_selected;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-
-	if (cpu_dest >= nr_cpus) {
-		NO_TEAR_INC(rec->issue);
-		return XDP_ABORTED;
-	}
-	return bpf_redirect_map(&cpu_map, cpu_dest, 0);
-}
-
-SEC("xdp")
-int  xdp_prognum3_proto_separate(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	u32 key = bpf_get_smp_processor_id();
-	struct ethhdr *eth = data;
-	u8 ip_proto = IPPROTO_UDP;
-	struct datarec *rec;
-	u16 eth_proto = 0;
-	u64 l3_offset = 0;
-	u32 cpu_dest = 0;
-	u32 *cpu_lookup;
-	u32 cpu_idx = 0;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-
-	if (!(parse_eth(eth, data_end, &eth_proto, &l3_offset)))
-		return XDP_PASS; /* Just skip */
-
-	/* Extract L4 protocol */
-	switch (eth_proto) {
-	case ETH_P_IP:
-		ip_proto = get_proto_ipv4(ctx, l3_offset);
-		break;
-	case ETH_P_IPV6:
-		ip_proto = get_proto_ipv6(ctx, l3_offset);
-		break;
-	case ETH_P_ARP:
-		cpu_idx = 0; /* ARP packet handled on separate CPU */
-		break;
-	default:
-		cpu_idx = 0;
-	}
-
-	/* Choose CPU based on L4 protocol */
-	switch (ip_proto) {
-	case IPPROTO_ICMP:
-	case IPPROTO_ICMPV6:
-		cpu_idx = 2;
-		break;
-	case IPPROTO_TCP:
-		cpu_idx = 0;
-		break;
-	case IPPROTO_UDP:
-		cpu_idx = 1;
-		break;
-	default:
-		cpu_idx = 0;
-	}
-
-	cpu_lookup = bpf_map_lookup_elem(&cpus_available, &cpu_idx);
-	if (!cpu_lookup)
-		return XDP_ABORTED;
-	cpu_dest = *cpu_lookup;
-
-	if (cpu_dest >= nr_cpus) {
-		NO_TEAR_INC(rec->issue);
-		return XDP_ABORTED;
-	}
-	return bpf_redirect_map(&cpu_map, cpu_dest, 0);
-}
-
-SEC("xdp")
-int  xdp_prognum4_ddos_filter_pktgen(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	u32 key = bpf_get_smp_processor_id();
-	struct ethhdr *eth = data;
-	u8 ip_proto = IPPROTO_UDP;
-	struct datarec *rec;
-	u16 eth_proto = 0;
-	u64 l3_offset = 0;
-	u32 cpu_dest = 0;
-	u32 *cpu_lookup;
-	u32 cpu_idx = 0;
-	u16 dest_port;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-
-	if (!(parse_eth(eth, data_end, &eth_proto, &l3_offset)))
-		return XDP_PASS; /* Just skip */
-
-	/* Extract L4 protocol */
-	switch (eth_proto) {
-	case ETH_P_IP:
-		ip_proto = get_proto_ipv4(ctx, l3_offset);
-		break;
-	case ETH_P_IPV6:
-		ip_proto = get_proto_ipv6(ctx, l3_offset);
-		break;
-	case ETH_P_ARP:
-		cpu_idx = 0; /* ARP packet handled on separate CPU */
-		break;
-	default:
-		cpu_idx = 0;
-	}
-
-	/* Choose CPU based on L4 protocol */
-	switch (ip_proto) {
-	case IPPROTO_ICMP:
-	case IPPROTO_ICMPV6:
-		cpu_idx = 2;
-		break;
-	case IPPROTO_TCP:
-		cpu_idx = 0;
-		break;
-	case IPPROTO_UDP:
-		cpu_idx = 1;
-		/* DDoS filter UDP port 9 (pktgen) */
-		dest_port = get_dest_port_ipv4_udp(ctx, l3_offset);
-		if (dest_port == 9) {
-			NO_TEAR_INC(rec->dropped);
-			return XDP_DROP;
-		}
-		break;
-	default:
-		cpu_idx = 0;
-	}
-
-	cpu_lookup = bpf_map_lookup_elem(&cpus_available, &cpu_idx);
-	if (!cpu_lookup)
-		return XDP_ABORTED;
-	cpu_dest = *cpu_lookup;
-
-	if (cpu_dest >= nr_cpus) {
-		NO_TEAR_INC(rec->issue);
-		return XDP_ABORTED;
-	}
-	return bpf_redirect_map(&cpu_map, cpu_dest, 0);
-}
-
-/* Hashing initval */
-#define INITVAL 15485863
-
-static __always_inline
-u32 get_ipv4_hash_ip_pair(struct xdp_md *ctx, u64 nh_off)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	struct iphdr *iph = data + nh_off;
-	u32 cpu_hash;
-
-	if (iph + 1 > data_end)
-		return 0;
-
-	cpu_hash = iph->saddr + iph->daddr;
-	cpu_hash = SuperFastHash((char *)&cpu_hash, 4, INITVAL + iph->protocol);
-
-	return cpu_hash;
-}
-
-static __always_inline
-u32 get_ipv6_hash_ip_pair(struct xdp_md *ctx, u64 nh_off)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	struct ipv6hdr *ip6h = data + nh_off;
-	u32 cpu_hash;
-
-	if (ip6h + 1 > data_end)
-		return 0;
-
-	cpu_hash  = ip6h->saddr.in6_u.u6_addr32[0] + ip6h->daddr.in6_u.u6_addr32[0];
-	cpu_hash += ip6h->saddr.in6_u.u6_addr32[1] + ip6h->daddr.in6_u.u6_addr32[1];
-	cpu_hash += ip6h->saddr.in6_u.u6_addr32[2] + ip6h->daddr.in6_u.u6_addr32[2];
-	cpu_hash += ip6h->saddr.in6_u.u6_addr32[3] + ip6h->daddr.in6_u.u6_addr32[3];
-	cpu_hash = SuperFastHash((char *)&cpu_hash, 4, INITVAL + ip6h->nexthdr);
-
-	return cpu_hash;
-}
-
-/* Load-Balance traffic based on hashing IP-addrs + L4-proto.  The
- * hashing scheme is symmetric, meaning swapping IP src/dest still hit
- * same CPU.
- */
-SEC("xdp")
-int  xdp_prognum5_lb_hash_ip_pairs(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data     = (void *)(long)ctx->data;
-	u32 key = bpf_get_smp_processor_id();
-	struct ethhdr *eth = data;
-	struct datarec *rec;
-	u16 eth_proto = 0;
-	u64 l3_offset = 0;
-	u32 cpu_dest = 0;
-	u32 cpu_idx = 0;
-	u32 *cpu_lookup;
-	u32 key0 = 0;
-	u32 *cpu_max;
-	u32 cpu_hash;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-
-	cpu_max = bpf_map_lookup_elem(&cpus_count, &key0);
-	if (!cpu_max)
-		return XDP_ABORTED;
-
-	if (!(parse_eth(eth, data_end, &eth_proto, &l3_offset)))
-		return XDP_PASS; /* Just skip */
-
-	/* Hash for IPv4 and IPv6 */
-	switch (eth_proto) {
-	case ETH_P_IP:
-		cpu_hash = get_ipv4_hash_ip_pair(ctx, l3_offset);
-		break;
-	case ETH_P_IPV6:
-		cpu_hash = get_ipv6_hash_ip_pair(ctx, l3_offset);
-		break;
-	case ETH_P_ARP: /* ARP packet handled on CPU idx 0 */
-	default:
-		cpu_hash = 0;
-	}
-
-	/* Choose CPU based on hash */
-	cpu_idx = cpu_hash % *cpu_max;
-
-	cpu_lookup = bpf_map_lookup_elem(&cpus_available, &cpu_idx);
-	if (!cpu_lookup)
-		return XDP_ABORTED;
-	cpu_dest = *cpu_lookup;
-
-	if (cpu_dest >= nr_cpus) {
-		NO_TEAR_INC(rec->issue);
-		return XDP_ABORTED;
-	}
-	return bpf_redirect_map(&cpu_map, cpu_dest, 0);
-}
-
-SEC("xdp/cpumap")
-int xdp_redirect_cpu_devmap(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-	struct ethhdr *eth = data;
-	u64 nh_off;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return XDP_DROP;
-
-	swap_src_dst_mac(data);
-	return bpf_redirect_map(&tx_port, 0, 0);
-}
-
-SEC("xdp/cpumap")
-int xdp_redirect_cpu_pass(struct xdp_md *ctx)
-{
-	return XDP_PASS;
-}
-
-SEC("xdp/cpumap")
-int xdp_redirect_cpu_drop(struct xdp_md *ctx)
-{
-	return XDP_DROP;
-}
-
-SEC("xdp/devmap")
-int xdp_redirect_egress_prog(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-	struct ethhdr *eth = data;
-	u64 nh_off;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return XDP_DROP;
-
-	__builtin_memcpy(eth->h_source, (const char *)tx_mac_addr, ETH_ALEN);
-
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_redirect_cpu_user.c b/samples/bpf/xdp_redirect_cpu_user.c
deleted file mode 100644
index e1458405e2ba..000000000000
--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ /dev/null
@@ -1,559 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2017 Jesper Dangaard Brouer, Red Hat, Inc.
- */
-static const char *__doc__ =
-"XDP CPU redirect tool, using BPF_MAP_TYPE_CPUMAP\n"
-"Usage: xdp_redirect_cpu -d <IFINDEX|IFNAME> -c 0 ... -c N\n"
-"Valid specification for CPUMAP BPF program:\n"
-"  --mprog-name/-e pass (use built-in XDP_PASS program)\n"
-"  --mprog-name/-e drop (use built-in XDP_DROP program)\n"
-"  --redirect-device/-r <ifindex|ifname> (use built-in DEVMAP redirect program)\n"
-"  Custom CPUMAP BPF program:\n"
-"    --mprog-filename/-f <filename> --mprog-name/-e <program>\n"
-"    Optionally, also pass --redirect-map/-m and --redirect-device/-r together\n"
-"    to configure DEVMAP in BPF object <filename>\n";
-
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <string.h>
-#include <unistd.h>
-#include <locale.h>
-#include <sys/sysinfo.h>
-#include <getopt.h>
-#include <net/if.h>
-#include <time.h>
-#include <linux/limits.h>
-#include <arpa/inet.h>
-#include <linux/if_link.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include "bpf_util.h"
-#include "xdp_sample_user.h"
-#include "xdp_redirect_cpu.skel.h"
-
-static int map_fd;
-static int avail_fd;
-static int count_fd;
-
-static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
-		  SAMPLE_CPUMAP_ENQUEUE_CNT | SAMPLE_CPUMAP_KTHREAD_CNT |
-		  SAMPLE_EXCEPTION_CNT;
-
-DEFINE_SAMPLE_INIT(xdp_redirect_cpu);
-
-static const struct option long_options[] = {
-	{ "help", no_argument, NULL, 'h' },
-	{ "dev", required_argument, NULL, 'd' },
-	{ "skb-mode", no_argument, NULL, 'S' },
-	{ "progname", required_argument, NULL, 'p' },
-	{ "qsize", required_argument, NULL, 'q' },
-	{ "cpu", required_argument, NULL, 'c' },
-	{ "stress-mode", no_argument, NULL, 'x' },
-	{ "force", no_argument, NULL, 'F' },
-	{ "interval", required_argument, NULL, 'i' },
-	{ "verbose", no_argument, NULL, 'v' },
-	{ "stats", no_argument, NULL, 's' },
-	{ "mprog-name", required_argument, NULL, 'e' },
-	{ "mprog-filename", required_argument, NULL, 'f' },
-	{ "redirect-device", required_argument, NULL, 'r' },
-	{ "redirect-map", required_argument, NULL, 'm' },
-	{}
-};
-
-static void print_avail_progs(struct bpf_object *obj)
-{
-	struct bpf_program *pos;
-
-	printf(" Programs to be used for -p/--progname:\n");
-	bpf_object__for_each_program(pos, obj) {
-		if (bpf_program__type(pos) == BPF_PROG_TYPE_XDP) {
-			if (!strncmp(bpf_program__name(pos), "xdp_prognum",
-				     sizeof("xdp_prognum") - 1))
-				printf(" %s\n", bpf_program__name(pos));
-		}
-	}
-}
-
-static void usage(char *argv[], const struct option *long_options,
-		  const char *doc, int mask, bool error, struct bpf_object *obj)
-{
-	sample_usage(argv, long_options, doc, mask, error);
-	print_avail_progs(obj);
-}
-
-static int create_cpu_entry(__u32 cpu, struct bpf_cpumap_val *value,
-			    __u32 avail_idx, bool new)
-{
-	__u32 curr_cpus_count = 0;
-	__u32 key = 0;
-	int ret;
-
-	/* Add a CPU entry to cpumap, as this allocate a cpu entry in
-	 * the kernel for the cpu.
-	 */
-	ret = bpf_map_update_elem(map_fd, &cpu, value, 0);
-	if (ret < 0) {
-		fprintf(stderr, "Create CPU entry failed: %s\n", strerror(errno));
-		return ret;
-	}
-
-	/* Inform bpf_prog's that a new CPU is available to select
-	 * from via some control maps.
-	 */
-	ret = bpf_map_update_elem(avail_fd, &avail_idx, &cpu, 0);
-	if (ret < 0) {
-		fprintf(stderr, "Add to avail CPUs failed: %s\n", strerror(errno));
-		return ret;
-	}
-
-	/* When not replacing/updating existing entry, bump the count */
-	ret = bpf_map_lookup_elem(count_fd, &key, &curr_cpus_count);
-	if (ret < 0) {
-		fprintf(stderr, "Failed reading curr cpus_count: %s\n",
-			strerror(errno));
-		return ret;
-	}
-	if (new) {
-		curr_cpus_count++;
-		ret = bpf_map_update_elem(count_fd, &key,
-					  &curr_cpus_count, 0);
-		if (ret < 0) {
-			fprintf(stderr, "Failed write curr cpus_count: %s\n",
-				strerror(errno));
-			return ret;
-		}
-	}
-
-	printf("%s CPU: %u as idx: %u qsize: %d cpumap_prog_fd: %d (cpus_count: %u)\n",
-	       new ? "Add new" : "Replace", cpu, avail_idx,
-	       value->qsize, value->bpf_prog.fd, curr_cpus_count);
-
-	return 0;
-}
-
-/* CPUs are zero-indexed. Thus, add a special sentinel default value
- * in map cpus_available to mark CPU index'es not configured
- */
-static int mark_cpus_unavailable(void)
-{
-	int ret, i, n_cpus = libbpf_num_possible_cpus();
-	__u32 invalid_cpu = n_cpus;
-
-	for (i = 0; i < n_cpus; i++) {
-		ret = bpf_map_update_elem(avail_fd, &i,
-					  &invalid_cpu, 0);
-		if (ret < 0) {
-			fprintf(stderr, "Failed marking CPU unavailable: %s\n",
-				strerror(errno));
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-/* Stress cpumap management code by concurrently changing underlying cpumap */
-static void stress_cpumap(void *ctx)
-{
-	struct bpf_cpumap_val *value = ctx;
-
-	/* Changing qsize will cause kernel to free and alloc a new
-	 * bpf_cpu_map_entry, with an associated/complicated tear-down
-	 * procedure.
-	 */
-	value->qsize = 1024;
-	create_cpu_entry(1, value, 0, false);
-	value->qsize = 8;
-	create_cpu_entry(1, value, 0, false);
-	value->qsize = 16000;
-	create_cpu_entry(1, value, 0, false);
-}
-
-static int set_cpumap_prog(struct xdp_redirect_cpu *skel,
-			   const char *redir_interface, const char *redir_map,
-			   const char *mprog_filename, const char *mprog_name)
-{
-	if (mprog_filename) {
-		struct bpf_program *prog;
-		struct bpf_object *obj;
-		int ret;
-
-		if (!mprog_name) {
-			fprintf(stderr, "BPF program not specified for file %s\n",
-				mprog_filename);
-			goto end;
-		}
-		if ((redir_interface && !redir_map) || (!redir_interface && redir_map)) {
-			fprintf(stderr, "--redirect-%s specified but --redirect-%s not specified\n",
-				redir_interface ? "device" : "map", redir_interface ? "map" : "device");
-			goto end;
-		}
-
-		/* Custom BPF program */
-		obj = bpf_object__open_file(mprog_filename, NULL);
-		if (!obj) {
-			ret = -errno;
-			fprintf(stderr, "Failed to bpf_prog_load_xattr: %s\n",
-				strerror(errno));
-			return ret;
-		}
-
-		ret = bpf_object__load(obj);
-		if (ret < 0) {
-			ret = -errno;
-			fprintf(stderr, "Failed to bpf_object__load: %s\n",
-				strerror(errno));
-			return ret;
-		}
-
-		if (redir_map) {
-			int err, redir_map_fd, ifindex_out, key = 0;
-
-			redir_map_fd = bpf_object__find_map_fd_by_name(obj, redir_map);
-			if (redir_map_fd < 0) {
-				fprintf(stderr, "Failed to bpf_object__find_map_fd_by_name: %s\n",
-					strerror(errno));
-				return redir_map_fd;
-			}
-
-			ifindex_out = if_nametoindex(redir_interface);
-			if (!ifindex_out)
-				ifindex_out = strtoul(redir_interface, NULL, 0);
-			if (!ifindex_out) {
-				fprintf(stderr, "Bad interface name or index\n");
-				return -EINVAL;
-			}
-
-			err = bpf_map_update_elem(redir_map_fd, &key, &ifindex_out, 0);
-			if (err < 0)
-				return err;
-		}
-
-		prog = bpf_object__find_program_by_name(obj, mprog_name);
-		if (!prog) {
-			ret = -errno;
-			fprintf(stderr, "Failed to bpf_object__find_program_by_name: %s\n",
-				strerror(errno));
-			return ret;
-		}
-
-		return bpf_program__fd(prog);
-	} else {
-		if (mprog_name) {
-			if (redir_interface || redir_map) {
-				fprintf(stderr, "Need to specify --mprog-filename/-f\n");
-				goto end;
-			}
-			if (!strcmp(mprog_name, "pass") || !strcmp(mprog_name, "drop")) {
-				/* Use built-in pass/drop programs */
-				return *mprog_name == 'p' ? bpf_program__fd(skel->progs.xdp_redirect_cpu_pass)
-					: bpf_program__fd(skel->progs.xdp_redirect_cpu_drop);
-			} else {
-				fprintf(stderr, "Unknown name \"%s\" for built-in BPF program\n",
-					mprog_name);
-				goto end;
-			}
-		} else {
-			if (redir_map) {
-				fprintf(stderr, "Need to specify --mprog-filename, --mprog-name and"
-					" --redirect-device with --redirect-map\n");
-				goto end;
-			}
-			if (redir_interface) {
-				/* Use built-in devmap redirect */
-				struct bpf_devmap_val val = {};
-				int ifindex_out, err;
-				__u32 key = 0;
-
-				if (!redir_interface)
-					return 0;
-
-				ifindex_out = if_nametoindex(redir_interface);
-				if (!ifindex_out)
-					ifindex_out = strtoul(redir_interface, NULL, 0);
-				if (!ifindex_out) {
-					fprintf(stderr, "Bad interface name or index\n");
-					return -EINVAL;
-				}
-
-				if (get_mac_addr(ifindex_out, skel->bss->tx_mac_addr) < 0) {
-					printf("Get interface %d mac failed\n", ifindex_out);
-					return -EINVAL;
-				}
-
-				val.ifindex = ifindex_out;
-				val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_redirect_egress_prog);
-				err = bpf_map_update_elem(bpf_map__fd(skel->maps.tx_port), &key, &val, 0);
-				if (err < 0)
-					return -errno;
-
-				return bpf_program__fd(skel->progs.xdp_redirect_cpu_devmap);
-			}
-		}
-	}
-
-	/* Disabled */
-	return 0;
-end:
-	fprintf(stderr, "Invalid options for CPUMAP BPF program\n");
-	return -EINVAL;
-}
-
-int main(int argc, char **argv)
-{
-	const char *redir_interface = NULL, *redir_map = NULL;
-	const char *mprog_filename = NULL, *mprog_name = NULL;
-	struct xdp_redirect_cpu *skel;
-	struct bpf_map_info info = {};
-	struct bpf_cpumap_val value;
-	__u32 infosz = sizeof(info);
-	int ret = EXIT_FAIL_OPTION;
-	unsigned long interval = 2;
-	bool stress_mode = false;
-	struct bpf_program *prog;
-	const char *prog_name;
-	bool generic = false;
-	bool force = false;
-	int added_cpus = 0;
-	bool error = true;
-	int longindex = 0;
-	int add_cpu = -1;
-	int ifindex = -1;
-	int *cpu, i, opt;
-	__u32 qsize;
-	int n_cpus;
-
-	n_cpus = libbpf_num_possible_cpus();
-
-	/* Notice: Choosing the queue size is very important when CPU is
-	 * configured with power-saving states.
-	 *
-	 * If deepest state take 133 usec to wakeup from (133/10^6). When link
-	 * speed is 10Gbit/s ((10*10^9/8) in bytes/sec). How many bytes can
-	 * arrive with in 133 usec at this speed: (10*10^9/8)*(133/10^6) =
-	 * 166250 bytes. With MTU size packets this is 110 packets, and with
-	 * minimum Ethernet (MAC-preamble + intergap) 84 bytes is 1979 packets.
-	 *
-	 * Setting default cpumap queue to 2048 as worst-case (small packet)
-	 * should be +64 packet due kthread wakeup call (due to xdp_do_flush)
-	 * worst-case is 2043 packets.
-	 *
-	 * Sysadm can configured system to avoid deep-sleep via:
-	 *   tuned-adm profile network-latency
-	 */
-	qsize = 2048;
-
-	skel = xdp_redirect_cpu__open();
-	if (!skel) {
-		fprintf(stderr, "Failed to xdp_redirect_cpu__open: %s\n",
-			strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end;
-	}
-
-	ret = sample_init_pre_load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	if (bpf_map__set_max_entries(skel->maps.cpu_map, n_cpus) < 0) {
-		fprintf(stderr, "Failed to set max entries for cpu_map map: %s",
-			strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	if (bpf_map__set_max_entries(skel->maps.cpus_available, n_cpus) < 0) {
-		fprintf(stderr, "Failed to set max entries for cpus_available map: %s",
-			strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	cpu = calloc(n_cpus, sizeof(int));
-	if (!cpu) {
-		fprintf(stderr, "Failed to allocate cpu array\n");
-		goto end_destroy;
-	}
-
-	prog = skel->progs.xdp_prognum5_lb_hash_ip_pairs;
-	while ((opt = getopt_long(argc, argv, "d:si:Sxp:f:e:r:m:c:q:Fvh",
-				  long_options, &longindex)) != -1) {
-		switch (opt) {
-		case 'd':
-			if (strlen(optarg) >= IF_NAMESIZE) {
-				fprintf(stderr, "-d/--dev name too long\n");
-				usage(argv, long_options, __doc__, mask, true, skel->obj);
-				goto end_cpu;
-			}
-			ifindex = if_nametoindex(optarg);
-			if (!ifindex)
-				ifindex = strtoul(optarg, NULL, 0);
-			if (!ifindex) {
-				fprintf(stderr, "Bad interface index or name (%d): %s\n",
-					errno, strerror(errno));
-				usage(argv, long_options, __doc__, mask, true, skel->obj);
-				goto end_cpu;
-			}
-			break;
-		case 's':
-			mask |= SAMPLE_REDIRECT_MAP_CNT;
-			break;
-		case 'i':
-			interval = strtoul(optarg, NULL, 0);
-			break;
-		case 'S':
-			generic = true;
-			break;
-		case 'x':
-			stress_mode = true;
-			break;
-		case 'p':
-			/* Selecting eBPF prog to load */
-			prog_name = optarg;
-			prog = bpf_object__find_program_by_name(skel->obj,
-								prog_name);
-			if (!prog) {
-				fprintf(stderr,
-					"Failed to find program %s specified by"
-					" option -p/--progname\n",
-					prog_name);
-				print_avail_progs(skel->obj);
-				goto end_cpu;
-			}
-			break;
-		case 'f':
-			mprog_filename = optarg;
-			break;
-		case 'e':
-			mprog_name = optarg;
-			break;
-		case 'r':
-			redir_interface = optarg;
-			mask |= SAMPLE_DEVMAP_XMIT_CNT_MULTI;
-			break;
-		case 'm':
-			redir_map = optarg;
-			break;
-		case 'c':
-			/* Add multiple CPUs */
-			add_cpu = strtoul(optarg, NULL, 0);
-			if (add_cpu >= n_cpus) {
-				fprintf(stderr,
-				"--cpu nr too large for cpumap err (%d):%s\n",
-					errno, strerror(errno));
-				usage(argv, long_options, __doc__, mask, true, skel->obj);
-				goto end_cpu;
-			}
-			cpu[added_cpus++] = add_cpu;
-			break;
-		case 'q':
-			qsize = strtoul(optarg, NULL, 0);
-			break;
-		case 'F':
-			force = true;
-			break;
-		case 'v':
-			sample_switch_mode();
-			break;
-		case 'h':
-			error = false;
-		default:
-			usage(argv, long_options, __doc__, mask, error, skel->obj);
-			goto end_cpu;
-		}
-	}
-
-	ret = EXIT_FAIL_OPTION;
-	if (ifindex == -1) {
-		fprintf(stderr, "Required option --dev missing\n");
-		usage(argv, long_options, __doc__, mask, true, skel->obj);
-		goto end_cpu;
-	}
-
-	if (add_cpu == -1) {
-		fprintf(stderr, "Required option --cpu missing\n"
-				"Specify multiple --cpu option to add more\n");
-		usage(argv, long_options, __doc__, mask, true, skel->obj);
-		goto end_cpu;
-	}
-
-	skel->rodata->from_match[0] = ifindex;
-	if (redir_interface)
-		skel->rodata->to_match[0] = if_nametoindex(redir_interface);
-
-	ret = xdp_redirect_cpu__load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to xdp_redirect_cpu__load: %s\n",
-			strerror(errno));
-		goto end_cpu;
-	}
-
-	ret = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.cpu_map), &info, &infosz);
-	if (ret < 0) {
-		fprintf(stderr, "Failed bpf_map_get_info_by_fd for cpumap: %s\n",
-			strerror(errno));
-		goto end_cpu;
-	}
-
-	skel->bss->cpumap_map_id = info.id;
-
-	map_fd = bpf_map__fd(skel->maps.cpu_map);
-	avail_fd = bpf_map__fd(skel->maps.cpus_available);
-	count_fd = bpf_map__fd(skel->maps.cpus_count);
-
-	ret = mark_cpus_unavailable();
-	if (ret < 0) {
-		fprintf(stderr, "Unable to mark CPUs as unavailable\n");
-		goto end_cpu;
-	}
-
-	ret = sample_init(skel, mask);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_cpu;
-	}
-
-	value.bpf_prog.fd = set_cpumap_prog(skel, redir_interface, redir_map,
-					    mprog_filename, mprog_name);
-	if (value.bpf_prog.fd < 0) {
-		fprintf(stderr, "Failed to set CPUMAP BPF program: %s\n",
-			strerror(-value.bpf_prog.fd));
-		usage(argv, long_options, __doc__, mask, true, skel->obj);
-		ret = EXIT_FAIL_BPF;
-		goto end_cpu;
-	}
-	value.qsize = qsize;
-
-	for (i = 0; i < added_cpus; i++) {
-		if (create_cpu_entry(cpu[i], &value, i, true) < 0) {
-			fprintf(stderr, "Cannot proceed, exiting\n");
-			usage(argv, long_options, __doc__, mask, true, skel->obj);
-			goto end_cpu;
-		}
-	}
-
-	ret = EXIT_FAIL_XDP;
-	if (sample_install_xdp(prog, ifindex, generic, force) < 0)
-		goto end_cpu;
-
-	ret = sample_run(interval, stress_mode ? stress_cpumap : NULL, &value);
-	if (ret < 0) {
-		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_cpu;
-	}
-	ret = EXIT_OK;
-end_cpu:
-	free(cpu);
-end_destroy:
-	xdp_redirect_cpu__destroy(skel);
-end:
-	sample_exit(ret);
-}
diff --git a/samples/bpf/xdp_redirect_map.bpf.c b/samples/bpf/xdp_redirect_map.bpf.c
deleted file mode 100644
index 8557c278df77..000000000000
--- a/samples/bpf/xdp_redirect_map.bpf.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/* Copyright (c) 2017 Covalent IO, Inc. http://covalent.io
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- */
-#define KBUILD_MODNAME "foo"
-
-#include "vmlinux.h"
-#include "xdp_sample.bpf.h"
-#include "xdp_sample_shared.h"
-
-/* The 2nd xdp prog on egress does not support skb mode, so we define two
- * maps, tx_port_general and tx_port_native.
- */
-struct {
-	__uint(type, BPF_MAP_TYPE_DEVMAP);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
-	__uint(max_entries, 1);
-} tx_port_general SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_DEVMAP);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(struct bpf_devmap_val));
-	__uint(max_entries, 1);
-} tx_port_native SEC(".maps");
-
-/* store egress interface mac address */
-const volatile __u8 tx_mac_addr[ETH_ALEN];
-
-static __always_inline int xdp_redirect_map(struct xdp_md *ctx, void *redirect_map)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-	u32 key = bpf_get_smp_processor_id();
-	struct ethhdr *eth = data;
-	struct datarec *rec;
-	u64 nh_off;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return XDP_DROP;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-	swap_src_dst_mac(data);
-	return bpf_redirect_map(redirect_map, 0, 0);
-}
-
-SEC("xdp")
-int xdp_redirect_map_general(struct xdp_md *ctx)
-{
-	return xdp_redirect_map(ctx, &tx_port_general);
-}
-
-SEC("xdp")
-int xdp_redirect_map_native(struct xdp_md *ctx)
-{
-	return xdp_redirect_map(ctx, &tx_port_native);
-}
-
-SEC("xdp/devmap")
-int xdp_redirect_map_egress(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-	u8 *mac_addr = (u8 *) tx_mac_addr;
-	struct ethhdr *eth = data;
-	u64 nh_off;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return XDP_DROP;
-
-	barrier_var(mac_addr); /* prevent optimizing out memcpy */
-	__builtin_memcpy(eth->h_source, mac_addr, ETH_ALEN);
-
-	return XDP_PASS;
-}
-
-/* Redirect require an XDP bpf_prog loaded on the TX device */
-SEC("xdp")
-int xdp_redirect_dummy_prog(struct xdp_md *ctx)
-{
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_redirect_map_multi.bpf.c b/samples/bpf/xdp_redirect_map_multi.bpf.c
deleted file mode 100644
index 8b2fd4ec2c76..000000000000
--- a/samples/bpf/xdp_redirect_map_multi.bpf.c
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define KBUILD_MODNAME "foo"
-
-#include "vmlinux.h"
-#include "xdp_sample.bpf.h"
-#include "xdp_sample_shared.h"
-
-struct {
-	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(int));
-	__uint(max_entries, 32);
-} forward_map_general SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
-	__uint(key_size, sizeof(int));
-	__uint(value_size, sizeof(struct bpf_devmap_val));
-	__uint(max_entries, 32);
-} forward_map_native SEC(".maps");
-
-/* map to store egress interfaces mac addresses */
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, u32);
-	__type(value, __be64);
-	__uint(max_entries, 32);
-} mac_map SEC(".maps");
-
-static int xdp_redirect_map(struct xdp_md *ctx, void *forward_map)
-{
-	u32 key = bpf_get_smp_processor_id();
-	struct datarec *rec;
-
-	rec = bpf_map_lookup_elem(&rx_cnt, &key);
-	if (!rec)
-		return XDP_PASS;
-	NO_TEAR_INC(rec->processed);
-
-	return bpf_redirect_map(forward_map, 0,
-				BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
-}
-
-SEC("xdp")
-int xdp_redirect_map_general(struct xdp_md *ctx)
-{
-	return xdp_redirect_map(ctx, &forward_map_general);
-}
-
-SEC("xdp")
-int xdp_redirect_map_native(struct xdp_md *ctx)
-{
-	return xdp_redirect_map(ctx, &forward_map_native);
-}
-
-SEC("xdp/devmap")
-int xdp_devmap_prog(struct xdp_md *ctx)
-{
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
-	u32 key = ctx->egress_ifindex;
-	struct ethhdr *eth = data;
-	__be64 *mac;
-	u64 nh_off;
-
-	nh_off = sizeof(*eth);
-	if (data + nh_off > data_end)
-		return XDP_DROP;
-
-	mac = bpf_map_lookup_elem(&mac_map, &key);
-	if (mac)
-		__builtin_memcpy(eth->h_source, mac, ETH_ALEN);
-
-	return XDP_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_redirect_map_multi_user.c b/samples/bpf/xdp_redirect_map_multi_user.c
deleted file mode 100644
index 9e24f2705b67..000000000000
--- a/samples/bpf/xdp_redirect_map_multi_user.c
+++ /dev/null
@@ -1,232 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-static const char *__doc__ =
-"XDP multi redirect tool, using BPF_MAP_TYPE_DEVMAP and BPF_F_BROADCAST flag for bpf_redirect_map\n"
-"Usage: xdp_redirect_map_multi <IFINDEX|IFNAME> <IFINDEX|IFNAME> ... <IFINDEX|IFNAME>\n";
-
-#include <linux/bpf.h>
-#include <linux/if_link.h>
-#include <assert.h>
-#include <getopt.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <net/if.h>
-#include <unistd.h>
-#include <libgen.h>
-#include <sys/ioctl.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <linux/if_ether.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include "bpf_util.h"
-#include "xdp_sample_user.h"
-#include "xdp_redirect_map_multi.skel.h"
-
-#define MAX_IFACE_NUM 32
-static int ifaces[MAX_IFACE_NUM] = {};
-
-static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
-		  SAMPLE_EXCEPTION_CNT | SAMPLE_DEVMAP_XMIT_CNT |
-		  SAMPLE_DEVMAP_XMIT_CNT_MULTI | SAMPLE_SKIP_HEADING;
-
-DEFINE_SAMPLE_INIT(xdp_redirect_map_multi);
-
-static const struct option long_options[] = {
-	{ "help", no_argument, NULL, 'h' },
-	{ "skb-mode", no_argument, NULL, 'S' },
-	{ "force", no_argument, NULL, 'F' },
-	{ "load-egress", no_argument, NULL, 'X' },
-	{ "stats", no_argument, NULL, 's' },
-	{ "interval", required_argument, NULL, 'i' },
-	{ "verbose", no_argument, NULL, 'v' },
-	{}
-};
-
-static int update_mac_map(struct bpf_map *map)
-{
-	int mac_map_fd = bpf_map__fd(map);
-	unsigned char mac_addr[6];
-	unsigned int ifindex;
-	int i, ret = -1;
-
-	for (i = 0; ifaces[i] > 0; i++) {
-		ifindex = ifaces[i];
-
-		ret = get_mac_addr(ifindex, mac_addr);
-		if (ret < 0) {
-			fprintf(stderr, "get interface %d mac failed\n",
-				ifindex);
-			return ret;
-		}
-
-		ret = bpf_map_update_elem(mac_map_fd, &ifindex, mac_addr, 0);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to update mac address for ifindex %d\n",
-				ifindex);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	struct bpf_devmap_val devmap_val = {};
-	struct xdp_redirect_map_multi *skel;
-	struct bpf_program *ingress_prog;
-	bool xdp_devmap_attached = false;
-	struct bpf_map *forward_map;
-	int ret = EXIT_FAIL_OPTION;
-	unsigned long interval = 2;
-	char ifname[IF_NAMESIZE];
-	unsigned int ifindex;
-	bool generic = false;
-	bool force = false;
-	bool tried = false;
-	bool error = true;
-	int i, opt;
-
-	while ((opt = getopt_long(argc, argv, "hSFXi:vs",
-				  long_options, NULL)) != -1) {
-		switch (opt) {
-		case 'S':
-			generic = true;
-			/* devmap_xmit tracepoint not available */
-			mask &= ~(SAMPLE_DEVMAP_XMIT_CNT |
-				  SAMPLE_DEVMAP_XMIT_CNT_MULTI);
-			break;
-		case 'F':
-			force = true;
-			break;
-		case 'X':
-			xdp_devmap_attached = true;
-			break;
-		case 'i':
-			interval = strtoul(optarg, NULL, 0);
-			break;
-		case 'v':
-			sample_switch_mode();
-			break;
-		case 's':
-			mask |= SAMPLE_REDIRECT_MAP_CNT;
-			break;
-		case 'h':
-			error = false;
-		default:
-			sample_usage(argv, long_options, __doc__, mask, error);
-			return ret;
-		}
-	}
-
-	if (argc <= optind + 1) {
-		sample_usage(argv, long_options, __doc__, mask, error);
-		return ret;
-	}
-
-	skel = xdp_redirect_map_multi__open();
-	if (!skel) {
-		fprintf(stderr, "Failed to xdp_redirect_map_multi__open: %s\n",
-			strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end;
-	}
-
-	ret = sample_init_pre_load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	ret = EXIT_FAIL_OPTION;
-	for (i = 0; i < MAX_IFACE_NUM && argv[optind + i]; i++) {
-		ifaces[i] = if_nametoindex(argv[optind + i]);
-		if (!ifaces[i])
-			ifaces[i] = strtoul(argv[optind + i], NULL, 0);
-		if (!if_indextoname(ifaces[i], ifname)) {
-			fprintf(stderr, "Bad interface index or name\n");
-			sample_usage(argv, long_options, __doc__, mask, true);
-			goto end_destroy;
-		}
-
-		skel->rodata->from_match[i] = ifaces[i];
-		skel->rodata->to_match[i] = ifaces[i];
-	}
-
-	ret = xdp_redirect_map_multi__load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to xdp_redirect_map_multi__load: %s\n",
-			strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	if (xdp_devmap_attached) {
-		/* Update mac_map with all egress interfaces' mac addr */
-		if (update_mac_map(skel->maps.mac_map) < 0) {
-			fprintf(stderr, "Updating mac address failed\n");
-			ret = EXIT_FAIL;
-			goto end_destroy;
-		}
-	}
-
-	ret = sample_init(skel, mask);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_destroy;
-	}
-
-	ingress_prog = skel->progs.xdp_redirect_map_native;
-	forward_map = skel->maps.forward_map_native;
-
-	for (i = 0; ifaces[i] > 0; i++) {
-		ifindex = ifaces[i];
-
-		ret = EXIT_FAIL_XDP;
-restart:
-		/* bind prog_fd to each interface */
-		if (sample_install_xdp(ingress_prog, ifindex, generic, force) < 0) {
-			if (generic && !tried) {
-				fprintf(stderr,
-					"Trying fallback to sizeof(int) as value_size for devmap in generic mode\n");
-				ingress_prog = skel->progs.xdp_redirect_map_general;
-				forward_map = skel->maps.forward_map_general;
-				tried = true;
-				goto restart;
-			}
-			goto end_destroy;
-		}
-
-		/* Add all the interfaces to forward group and attach
-		 * egress devmap program if exist
-		 */
-		devmap_val.ifindex = ifindex;
-		if (xdp_devmap_attached)
-			devmap_val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_devmap_prog);
-		ret = bpf_map_update_elem(bpf_map__fd(forward_map), &ifindex, &devmap_val, 0);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to update devmap value: %s\n",
-				strerror(errno));
-			ret = EXIT_FAIL_BPF;
-			goto end_destroy;
-		}
-	}
-
-	ret = sample_run(interval, NULL, NULL);
-	if (ret < 0) {
-		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_destroy;
-	}
-	ret = EXIT_OK;
-end_destroy:
-	xdp_redirect_map_multi__destroy(skel);
-end:
-	sample_exit(ret);
-}
diff --git a/samples/bpf/xdp_redirect_map_user.c b/samples/bpf/xdp_redirect_map_user.c
deleted file mode 100644
index c889a1394dc1..000000000000
--- a/samples/bpf/xdp_redirect_map_user.c
+++ /dev/null
@@ -1,228 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2017 Covalent IO, Inc. http://covalent.io
- */
-static const char *__doc__ =
-"XDP redirect tool, using BPF_MAP_TYPE_DEVMAP\n"
-"Usage: xdp_redirect_map <IFINDEX|IFNAME>_IN <IFINDEX|IFNAME>_OUT\n";
-
-#include <linux/bpf.h>
-#include <linux/if_link.h>
-#include <assert.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <string.h>
-#include <net/if.h>
-#include <unistd.h>
-#include <libgen.h>
-#include <getopt.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include "bpf_util.h"
-#include "xdp_sample_user.h"
-#include "xdp_redirect_map.skel.h"
-
-static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_MAP_CNT |
-		  SAMPLE_EXCEPTION_CNT | SAMPLE_DEVMAP_XMIT_CNT_MULTI;
-
-DEFINE_SAMPLE_INIT(xdp_redirect_map);
-
-static const struct option long_options[] = {
-	{ "help", no_argument, NULL, 'h' },
-	{ "skb-mode", no_argument, NULL, 'S' },
-	{ "force", no_argument, NULL, 'F' },
-	{ "load-egress", no_argument, NULL, 'X' },
-	{ "stats", no_argument, NULL, 's' },
-	{ "interval", required_argument, NULL, 'i' },
-	{ "verbose", no_argument, NULL, 'v' },
-	{}
-};
-
-static int verbose = 0;
-
-int main(int argc, char **argv)
-{
-	struct bpf_devmap_val devmap_val = {};
-	bool xdp_devmap_attached = false;
-	struct xdp_redirect_map *skel;
-	char str[2 * IF_NAMESIZE + 1];
-	char ifname_out[IF_NAMESIZE];
-	struct bpf_map *tx_port_map;
-	char ifname_in[IF_NAMESIZE];
-	int ifindex_in, ifindex_out;
-	unsigned long interval = 2;
-	int ret = EXIT_FAIL_OPTION;
-	struct bpf_program *prog;
-	bool generic = false;
-	bool force = false;
-	bool tried = false;
-	bool error = true;
-	int opt, key = 0;
-
-	while ((opt = getopt_long(argc, argv, "hSFXi:vs",
-				  long_options, NULL)) != -1) {
-		switch (opt) {
-		case 'S':
-			generic = true;
-			/* devmap_xmit tracepoint not available */
-			mask &= ~(SAMPLE_DEVMAP_XMIT_CNT |
-				  SAMPLE_DEVMAP_XMIT_CNT_MULTI);
-			break;
-		case 'F':
-			force = true;
-			break;
-		case 'X':
-			xdp_devmap_attached = true;
-			break;
-		case 'i':
-			interval = strtoul(optarg, NULL, 0);
-			break;
-		case 'v':
-			sample_switch_mode();
-			verbose = 1;
-			break;
-		case 's':
-			mask |= SAMPLE_REDIRECT_MAP_CNT;
-			break;
-		case 'h':
-			error = false;
-		default:
-			sample_usage(argv, long_options, __doc__, mask, error);
-			return ret;
-		}
-	}
-
-	if (argc <= optind + 1) {
-		sample_usage(argv, long_options, __doc__, mask, true);
-		goto end;
-	}
-
-	ifindex_in = if_nametoindex(argv[optind]);
-	if (!ifindex_in)
-		ifindex_in = strtoul(argv[optind], NULL, 0);
-
-	ifindex_out = if_nametoindex(argv[optind + 1]);
-	if (!ifindex_out)
-		ifindex_out = strtoul(argv[optind + 1], NULL, 0);
-
-	if (!ifindex_in || !ifindex_out) {
-		fprintf(stderr, "Bad interface index or name\n");
-		sample_usage(argv, long_options, __doc__, mask, true);
-		goto end;
-	}
-
-	skel = xdp_redirect_map__open();
-	if (!skel) {
-		fprintf(stderr, "Failed to xdp_redirect_map__open: %s\n",
-			strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end;
-	}
-
-	ret = sample_init_pre_load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	/* Load 2nd xdp prog on egress. */
-	if (xdp_devmap_attached) {
-		ret = get_mac_addr(ifindex_out, skel->rodata->tx_mac_addr);
-		if (ret < 0) {
-			fprintf(stderr, "Failed to get interface %d mac address: %s\n",
-				ifindex_out, strerror(-ret));
-			ret = EXIT_FAIL;
-			goto end_destroy;
-		}
-		if (verbose)
-			printf("Egress ifindex:%d using src MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
-			       ifindex_out,
-			       skel->rodata->tx_mac_addr[0], skel->rodata->tx_mac_addr[1],
-			       skel->rodata->tx_mac_addr[2], skel->rodata->tx_mac_addr[3],
-			       skel->rodata->tx_mac_addr[4], skel->rodata->tx_mac_addr[5]);
-	}
-
-	skel->rodata->from_match[0] = ifindex_in;
-	skel->rodata->to_match[0] = ifindex_out;
-
-	ret = xdp_redirect_map__load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to xdp_redirect_map__load: %s\n",
-			strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	ret = sample_init(skel, mask);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_destroy;
-	}
-
-	prog = skel->progs.xdp_redirect_map_native;
-	tx_port_map = skel->maps.tx_port_native;
-restart:
-	if (sample_install_xdp(prog, ifindex_in, generic, force) < 0) {
-		/* First try with struct bpf_devmap_val as value for generic
-		 * mode, then fallback to sizeof(int) for older kernels.
-		 */
-		fprintf(stderr,
-			"Trying fallback to sizeof(int) as value_size for devmap in generic mode\n");
-		if (generic && !tried) {
-			prog = skel->progs.xdp_redirect_map_general;
-			tx_port_map = skel->maps.tx_port_general;
-			tried = true;
-			goto restart;
-		}
-		ret = EXIT_FAIL_XDP;
-		goto end_destroy;
-	}
-
-	/* Loading dummy XDP prog on out-device */
-	sample_install_xdp(skel->progs.xdp_redirect_dummy_prog, ifindex_out, generic, force);
-
-	devmap_val.ifindex = ifindex_out;
-	if (xdp_devmap_attached)
-		devmap_val.bpf_prog.fd = bpf_program__fd(skel->progs.xdp_redirect_map_egress);
-	ret = bpf_map_update_elem(bpf_map__fd(tx_port_map), &key, &devmap_val, 0);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to update devmap value: %s\n",
-			strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	ret = EXIT_FAIL;
-	if (!if_indextoname(ifindex_in, ifname_in)) {
-		fprintf(stderr, "Failed to if_indextoname for %d: %s\n", ifindex_in,
-			strerror(errno));
-		goto end_destroy;
-	}
-
-	if (!if_indextoname(ifindex_out, ifname_out)) {
-		fprintf(stderr, "Failed to if_indextoname for %d: %s\n", ifindex_out,
-			strerror(errno));
-		goto end_destroy;
-	}
-
-	safe_strncpy(str, get_driver_name(ifindex_in), sizeof(str));
-	printf("Redirecting from %s (ifindex %d; driver %s) to %s (ifindex %d; driver %s)\n",
-	       ifname_in, ifindex_in, str, ifname_out, ifindex_out, get_driver_name(ifindex_out));
-	snprintf(str, sizeof(str), "%s->%s", ifname_in, ifname_out);
-
-	ret = sample_run(interval, NULL, NULL);
-	if (ret < 0) {
-		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_destroy;
-	}
-	ret = EXIT_OK;
-end_destroy:
-	xdp_redirect_map__destroy(skel);
-end:
-	sample_exit(ret);
-}
diff --git a/samples/bpf/xdp_redirect_user.c b/samples/bpf/xdp_redirect_user.c
deleted file mode 100644
index 8663dd631b6e..000000000000
--- a/samples/bpf/xdp_redirect_user.c
+++ /dev/null
@@ -1,172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2016 John Fastabend <john.r.fastabend@intel.com>
- */
-static const char *__doc__ =
-"XDP redirect tool, using bpf_redirect helper\n"
-"Usage: xdp_redirect <IFINDEX|IFNAME>_IN <IFINDEX|IFNAME>_OUT\n";
-
-#include <linux/bpf.h>
-#include <linux/if_link.h>
-#include <assert.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <string.h>
-#include <net/if.h>
-#include <unistd.h>
-#include <libgen.h>
-#include <getopt.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include "bpf_util.h"
-#include "xdp_sample_user.h"
-#include "xdp_redirect.skel.h"
-
-static int mask = SAMPLE_RX_CNT | SAMPLE_REDIRECT_ERR_CNT |
-		  SAMPLE_EXCEPTION_CNT | SAMPLE_DEVMAP_XMIT_CNT_MULTI;
-
-DEFINE_SAMPLE_INIT(xdp_redirect);
-
-static const struct option long_options[] = {
-	{"help",	no_argument,		NULL, 'h' },
-	{"skb-mode",	no_argument,		NULL, 'S' },
-	{"force",	no_argument,		NULL, 'F' },
-	{"stats",	no_argument,		NULL, 's' },
-	{"interval",	required_argument,	NULL, 'i' },
-	{"verbose",	no_argument,		NULL, 'v' },
-	{}
-};
-
-int main(int argc, char **argv)
-{
-	int ifindex_in, ifindex_out, opt;
-	char str[2 * IF_NAMESIZE + 1];
-	char ifname_out[IF_NAMESIZE];
-	char ifname_in[IF_NAMESIZE];
-	int ret = EXIT_FAIL_OPTION;
-	unsigned long interval = 2;
-	struct xdp_redirect *skel;
-	bool generic = false;
-	bool force = false;
-	bool error = true;
-
-	while ((opt = getopt_long(argc, argv, "hSFi:vs",
-				  long_options, NULL)) != -1) {
-		switch (opt) {
-		case 'S':
-			generic = true;
-			mask &= ~(SAMPLE_DEVMAP_XMIT_CNT |
-				  SAMPLE_DEVMAP_XMIT_CNT_MULTI);
-			break;
-		case 'F':
-			force = true;
-			break;
-		case 'i':
-			interval = strtoul(optarg, NULL, 0);
-			break;
-		case 'v':
-			sample_switch_mode();
-			break;
-		case 's':
-			mask |= SAMPLE_REDIRECT_CNT;
-			break;
-		case 'h':
-			error = false;
-		default:
-			sample_usage(argv, long_options, __doc__, mask, error);
-			return ret;
-		}
-	}
-
-	if (argc <= optind + 1) {
-		sample_usage(argv, long_options, __doc__, mask, true);
-		return ret;
-	}
-
-	ifindex_in = if_nametoindex(argv[optind]);
-	if (!ifindex_in)
-		ifindex_in = strtoul(argv[optind], NULL, 0);
-
-	ifindex_out = if_nametoindex(argv[optind + 1]);
-	if (!ifindex_out)
-		ifindex_out = strtoul(argv[optind + 1], NULL, 0);
-
-	if (!ifindex_in || !ifindex_out) {
-		fprintf(stderr, "Bad interface index or name\n");
-		sample_usage(argv, long_options, __doc__, mask, true);
-		goto end;
-	}
-
-	skel = xdp_redirect__open();
-	if (!skel) {
-		fprintf(stderr, "Failed to xdp_redirect__open: %s\n", strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end;
-	}
-
-	ret = sample_init_pre_load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to sample_init_pre_load: %s\n", strerror(-ret));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	skel->rodata->from_match[0] = ifindex_in;
-	skel->rodata->to_match[0] = ifindex_out;
-	skel->rodata->ifindex_out = ifindex_out;
-
-	ret = xdp_redirect__load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to xdp_redirect__load: %s\n", strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	ret = sample_init(skel, mask);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_destroy;
-	}
-
-	ret = EXIT_FAIL_XDP;
-	if (sample_install_xdp(skel->progs.xdp_redirect_prog, ifindex_in,
-			       generic, force) < 0)
-		goto end_destroy;
-
-	/* Loading dummy XDP prog on out-device */
-	sample_install_xdp(skel->progs.xdp_redirect_dummy_prog, ifindex_out,
-			   generic, force);
-
-	ret = EXIT_FAIL;
-	if (!if_indextoname(ifindex_in, ifname_in)) {
-		fprintf(stderr, "Failed to if_indextoname for %d: %s\n", ifindex_in,
-			strerror(errno));
-		goto end_destroy;
-	}
-
-	if (!if_indextoname(ifindex_out, ifname_out)) {
-		fprintf(stderr, "Failed to if_indextoname for %d: %s\n", ifindex_out,
-			strerror(errno));
-		goto end_destroy;
-	}
-
-	safe_strncpy(str, get_driver_name(ifindex_in), sizeof(str));
-	printf("Redirecting from %s (ifindex %d; driver %s) to %s (ifindex %d; driver %s)\n",
-	       ifname_in, ifindex_in, str, ifname_out, ifindex_out, get_driver_name(ifindex_out));
-	snprintf(str, sizeof(str), "%s->%s", ifname_in, ifname_out);
-
-	ret = sample_run(interval, NULL, NULL);
-	if (ret < 0) {
-		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_destroy;
-	}
-	ret = EXIT_OK;
-end_destroy:
-	xdp_redirect__destroy(skel);
-end:
-	sample_exit(ret);
-}
-- 
2.41.0


