Return-Path: <bpf+bounces-8455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79598786CAF
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328792814DB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 10:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B8FC07;
	Thu, 24 Aug 2023 10:23:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E8DF61
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 10:23:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED7F199F
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692872581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+RTdjoHen0sRg9l9Zs5EahybWnXZpJ3Wu4Gp71+524=;
	b=IF5Gd8r2Sjbw+6J/8j7WrvNSSybW9fexqmBJZ0Mk3lz9e84q/7hInAMz0aR9E2LwSmLKGA
	RP3N18R56yDWClsl3XgvSZOKjrDJeU2hyBGO+6Cz9ftp5ZHxTIQqse9G7JG5YzdKD7uGTa
	lYWtw0AdKN5ELWJPzVFcdliWfAg0iRw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-zLbYIMYkPmOd7CWBZctfLA-1; Thu, 24 Aug 2023 06:23:00 -0400
X-MC-Unique: zLbYIMYkPmOd7CWBZctfLA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso496146066b.3
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692872579; x=1693477379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+RTdjoHen0sRg9l9Zs5EahybWnXZpJ3Wu4Gp71+524=;
        b=L1fJDhjanowVr40bxuLFH+OAQFlJsAC7XshekICaQHgt7Dxx3wGyRdps0QivgfbF0K
         8LBaHlumvW1rsD0EVmdUQ43CbhrmbodT6qsAWMwzld1iLT3UEH067XU0OGbuJQkNt3Uk
         gBFy4BLczeGYayNsSqBd6kKTX82wMRyUexZ8u8gDx+hx/D4fpQxKbmLamxSo5werNdFE
         vYMZW6BZDyzHgJg/05I9/+Ygz6mDOSL1XSYXSNW7z0tsQxR3Dr/WdbIpWexbs7kreyY6
         IiP9dGuDSb5ienfMmnqdOVnDoeVuwL39MmO+c87dYDQcp5WdFbfyQxxVLBiu5Z4ELSPK
         R61w==
X-Gm-Message-State: AOJu0Yyv3gnN294od2pN1YgP0MbNX7XtpXBjEDNXkEeJzRoACH2sA1qJ
	cimZPsZTFzBzhUckfkUTqzqmf3aeBm52lw+Bqj7C9p03cYRM50eLnMC7t/ChFuUxzzHPhvJ1a4b
	IeeGdUR7c07NP
X-Received: by 2002:a17:906:4c9:b0:99c:afd6:4208 with SMTP id g9-20020a17090604c900b0099cafd64208mr11209184eja.38.1692872578694;
        Thu, 24 Aug 2023 03:22:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIsC9Bo7+3RxEnmbKaYxS9Tu6Is/X76PtUHHxsGQJuwyIhnkK1FMK3NX4M6OuMc596YVAoWg==
X-Received: by 2002:a17:906:4c9:b0:99c:afd6:4208 with SMTP id g9-20020a17090604c900b0099cafd64208mr11209170eja.38.1692872578366;
        Thu, 24 Aug 2023 03:22:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906d10700b00992d122af63sm10785714ejz.89.2023.08.24.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:22:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7BC3DD3D09B; Thu, 24 Aug 2023 12:22:57 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 1/7] samples/bpf: Remove the xdp_monitor utility
Date: Thu, 24 Aug 2023 12:22:44 +0200
Message-ID: <20230824102255.1561885-2-toke@redhat.com>
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This utility has been ported as-is to xdp-tools as 'xdp-monitor'. The only
difference in usage between the samples and xdp-tools versions is that the
'-v' command line parameter has been changed to '-e' in the xdp-tools
version for consistency with the other utilities.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/Makefile           |   8 +--
 samples/bpf/xdp_monitor.bpf.c  |   8 ---
 samples/bpf/xdp_monitor_user.c | 118 ---------------------------------
 3 files changed, 1 insertion(+), 133 deletions(-)
 delete mode 100644 samples/bpf/xdp_monitor.bpf.c
 delete mode 100644 samples/bpf/xdp_monitor_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index f90bcd3696bd..29b07c4ec066 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -55,7 +55,6 @@ tprogs-y += xdp_redirect_cpu
 tprogs-y += xdp_redirect_map_multi
 tprogs-y += xdp_redirect_map
 tprogs-y += xdp_redirect
-tprogs-y += xdp_monitor
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -116,7 +115,6 @@ xdp_redirect_map_multi-objs := xdp_redirect_map_multi_user.o $(XDP_SAMPLE)
 xdp_redirect_cpu-objs := xdp_redirect_cpu_user.o $(XDP_SAMPLE)
 xdp_redirect_map-objs := xdp_redirect_map_user.o $(XDP_SAMPLE)
 xdp_redirect-objs := xdp_redirect_user.o $(XDP_SAMPLE)
-xdp_monitor-objs := xdp_monitor_user.o $(XDP_SAMPLE)
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
 
 # Tell kbuild to always build the programs
@@ -207,7 +205,6 @@ TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
 endif
 
 TPROGS_LDLIBS			+= $(LIBBPF) -lelf -lz
-TPROGLDLIBS_xdp_monitor		+= -lm
 TPROGLDLIBS_xdp_redirect	+= -lm
 TPROGLDLIBS_xdp_redirect_cpu	+= -lm
 TPROGLDLIBS_xdp_redirect_map	+= -lm
@@ -330,7 +327,6 @@ $(obj)/xdp_redirect_cpu_user.o: $(obj)/xdp_redirect_cpu.skel.h
 $(obj)/xdp_redirect_map_multi_user.o: $(obj)/xdp_redirect_map_multi.skel.h
 $(obj)/xdp_redirect_map_user.o: $(obj)/xdp_redirect_map.skel.h
 $(obj)/xdp_redirect_user.o: $(obj)/xdp_redirect.skel.h
-$(obj)/xdp_monitor_user.o: $(obj)/xdp_monitor.skel.h
 $(obj)/xdp_router_ipv4_user.o: $(obj)/xdp_router_ipv4.skel.h
 
 $(obj)/tracex5.bpf.o: $(obj)/syscall_nrs.h
@@ -387,7 +383,6 @@ $(obj)/xdp_redirect_cpu.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_redirect_map_multi.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_redirect_map.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_redirect.bpf.o: $(obj)/xdp_sample.bpf.o
-$(obj)/xdp_monitor.bpf.o: $(obj)/xdp_sample.bpf.o
 $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
 
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/xdp_sample_shared.h
@@ -399,7 +394,7 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-c $(filter %.bpf.c,$^) -o $@
 
 LINKED_SKELS := xdp_redirect_cpu.skel.h xdp_redirect_map_multi.skel.h \
-		xdp_redirect_map.skel.h xdp_redirect.skel.h xdp_monitor.skel.h \
+		xdp_redirect_map.skel.h xdp_redirect.skel.h \
 		xdp_router_ipv4.skel.h
 clean-files += $(LINKED_SKELS)
 
@@ -407,7 +402,6 @@ xdp_redirect_cpu.skel.h-deps := xdp_redirect_cpu.bpf.o xdp_sample.bpf.o
 xdp_redirect_map_multi.skel.h-deps := xdp_redirect_map_multi.bpf.o xdp_sample.bpf.o
 xdp_redirect_map.skel.h-deps := xdp_redirect_map.bpf.o xdp_sample.bpf.o
 xdp_redirect.skel.h-deps := xdp_redirect.bpf.o xdp_sample.bpf.o
-xdp_monitor.skel.h-deps := xdp_monitor.bpf.o xdp_sample.bpf.o
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
diff --git a/samples/bpf/xdp_monitor.bpf.c b/samples/bpf/xdp_monitor.bpf.c
deleted file mode 100644
index cfb41e2205f4..000000000000
--- a/samples/bpf/xdp_monitor.bpf.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*  Copyright(c) 2017-2018 Jesper Dangaard Brouer, Red Hat Inc.
- *
- * XDP monitor tool, based on tracepoints
- */
-#include "xdp_sample.bpf.h"
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/xdp_monitor_user.c b/samples/bpf/xdp_monitor_user.c
deleted file mode 100644
index 58015eb2ffae..000000000000
--- a/samples/bpf/xdp_monitor_user.c
+++ /dev/null
@@ -1,118 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2017 Jesper Dangaard Brouer, Red Hat, Inc. */
-static const char *__doc__=
-"XDP monitor tool, based on tracepoints\n";
-
-static const char *__doc_err_only__=
-" NOTICE: Only tracking XDP redirect errors\n"
-"         Enable redirect success stats via '-s/--stats'\n"
-"         (which comes with a per packet processing overhead)\n";
-
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <stdint.h>
-#include <string.h>
-#include <ctype.h>
-#include <unistd.h>
-#include <locale.h>
-#include <getopt.h>
-#include <net/if.h>
-#include <time.h>
-#include <signal.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include "bpf_util.h"
-#include "xdp_sample_user.h"
-#include "xdp_monitor.skel.h"
-
-static int mask = SAMPLE_REDIRECT_ERR_CNT | SAMPLE_CPUMAP_ENQUEUE_CNT |
-		  SAMPLE_CPUMAP_KTHREAD_CNT | SAMPLE_EXCEPTION_CNT |
-		  SAMPLE_DEVMAP_XMIT_CNT | SAMPLE_DEVMAP_XMIT_CNT_MULTI;
-
-DEFINE_SAMPLE_INIT(xdp_monitor);
-
-static const struct option long_options[] = {
-	{ "help", no_argument, NULL, 'h' },
-	{ "stats", no_argument, NULL, 's' },
-	{ "interval", required_argument, NULL, 'i' },
-	{ "verbose", no_argument, NULL, 'v' },
-	{}
-};
-
-int main(int argc, char **argv)
-{
-	unsigned long interval = 2;
-	int ret = EXIT_FAIL_OPTION;
-	struct xdp_monitor *skel;
-	bool errors_only = true;
-	int longindex = 0, opt;
-	bool error = true;
-
-	/* Parse commands line args */
-	while ((opt = getopt_long(argc, argv, "si:vh",
-				  long_options, &longindex)) != -1) {
-		switch (opt) {
-		case 's':
-			errors_only = false;
-			mask |= SAMPLE_REDIRECT_CNT;
-			break;
-		case 'i':
-			interval = strtoul(optarg, NULL, 0);
-			break;
-		case 'v':
-			sample_switch_mode();
-			break;
-		case 'h':
-			error = false;
-		default:
-			sample_usage(argv, long_options, __doc__, mask, error);
-			return ret;
-		}
-	}
-
-	skel = xdp_monitor__open();
-	if (!skel) {
-		fprintf(stderr, "Failed to xdp_monitor__open: %s\n",
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
-	ret = xdp_monitor__load(skel);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to xdp_monitor__load: %s\n", strerror(errno));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	ret = sample_init(skel, mask);
-	if (ret < 0) {
-		fprintf(stderr, "Failed to initialize sample: %s\n", strerror(-ret));
-		ret = EXIT_FAIL_BPF;
-		goto end_destroy;
-	}
-
-	if (errors_only)
-		printf("%s", __doc_err_only__);
-
-	ret = sample_run(interval, NULL, NULL);
-	if (ret < 0) {
-		fprintf(stderr, "Failed during sample run: %s\n", strerror(-ret));
-		ret = EXIT_FAIL;
-		goto end_destroy;
-	}
-	ret = EXIT_OK;
-end_destroy:
-	xdp_monitor__destroy(skel);
-end:
-	sample_exit(ret);
-}
-- 
2.41.0


