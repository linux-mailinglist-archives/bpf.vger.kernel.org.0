Return-Path: <bpf+bounces-1530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF2F718A5D
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280421C20EFE
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD533D389;
	Wed, 31 May 2023 19:38:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82993D381;
	Wed, 31 May 2023 19:38:56 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F3C8E;
	Wed, 31 May 2023 12:38:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f6b9ad956cso37014291cf.1;
        Wed, 31 May 2023 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685561934; x=1688153934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxBxKmVHfzPg3Xk5aUhOmv49SJzzXW/eBIi8w32OnDU=;
        b=YFtIQfydOkYxCHCjQuDHsGOUyDEvvv1N9GwAp0CU/y/YRveHF8IaDSi8+QBBO2l8+x
         ZNb5i+6mZfiv/pvYN4e2CU0wdZygK9RlBKTyfKE0D/2b/Vq6fxArziJRaeI3cv2aS9mh
         /pby2DaA68jyHvZJSZUAVDAv2JNullEkC1Iv2EAfJWEXPUSURpNZxOwLDO/NINoOPVMS
         21+zhQFjt8+aDwCMpCWVX/5WH4hCREGH8RWDX1ofm+0qQdSCcrf481dNcXpItVpIv2dS
         jD267YN3L3o9ejJw6a+xu8f8+di+89YmSAmpggm10bzrHM4SlPP7FbIkk4KYIQ/l3zvp
         8Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561934; x=1688153934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxBxKmVHfzPg3Xk5aUhOmv49SJzzXW/eBIi8w32OnDU=;
        b=kR6TD67Sh3rZngrBLIHxCtI0RCegAH1kC/7BLI2+zhQBJj9zFOBwX7KnD0LrvpylLy
         3TfF8vIBQLQwX5SkvTpQZJSO5GhDTQhWtf7KVt1ND3XbqQkSBHBeLWna5PsGjUtYtDIj
         Z67gRu6YbbYkDqEpNF8p0MYZUuz+IQLSwkrz7wkxViC8ltne9V9zKMuQs+i27mKYz9at
         +qluHUbFPa4KjmJBWZRqYhbXcY9j0kssZwVWsnkWpRVE9EiT+OR8/3SnAZWlpV/gpns6
         kADo6WT9Y3uf/7Copjsopa/hfaQ2kyUON/1Uyzjyv+XdXed2qBmKRvpdRXNAf06AEAnm
         pE1w==
X-Gm-Message-State: AC+VfDxS2x1dx6eDbU8XGhbqJBPkFS3aIsILFOM6bbCOC7QuXBuH0D82
	XRf4rd4cOArxy4Dbj5PExuw=
X-Google-Smtp-Source: ACHHUZ5yh0QdoGQ1dV4aE6VVpati8DlntSgQ0icj5I6fNEQl4WAKO9v2E3hh4KGLSGro8/NYOEuyxQ==
X-Received: by 2002:a05:622a:413:b0:3f3:97c9:dff0 with SMTP id n19-20020a05622a041300b003f397c9dff0mr6999779qtx.12.1685561934309;
        Wed, 31 May 2023 12:38:54 -0700 (PDT)
Received: from localhost (ool-944b8b4f.dyn.optonline.net. [148.75.139.79])
        by smtp.gmail.com with ESMTPSA id bb40-20020a05622a1b2800b003e6a1bf26a4sm6241223qtb.64.2023.05.31.12.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:38:53 -0700 (PDT)
From: Louis DeLosSantos <louis.delos.devel@gmail.com>
Date: Wed, 31 May 2023 15:38:49 -0400
Subject: [PATCH v2 2/2] selftests/bpf: test table ID fib lookup BPF helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230505-bpf-add-tbid-fib-lookup-v2-2-0a31c22c748c@gmail.com>
References: <20230505-bpf-add-tbid-fib-lookup-v2-0-0a31c22c748c@gmail.com>
In-Reply-To: <20230505-bpf-add-tbid-fib-lookup-v2-0-0a31c22c748c@gmail.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Stanislav Fomichev <sdf@google.com>, razor@blackwall.org, 
 John Fastabend <john.fastabend@gmail.com>, Yonghong Song <yhs@meta.com>, 
 Louis DeLosSantos <louis.delos.devel@gmail.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add additional test cases to `fib_lookup.c` prog_test.

These test cases add a new /24 network to the previously unused veth2
device, removes the directly connected route from the main routing table
and moves it to table 100.

The first test case then confirms a fib lookup for a remote address in this
directly connected network, using the main routing table fails.

The second test case ensures the same fib lookup using table 100
succeeds.

An additional pair of tests which function in the same manner are added
for IPv6.

Signed-off-by: Louis DeLosSantos <louis.delos.devel@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  | 61 +++++++++++++++++++---
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index a1e7121058118..2fd05649bad19 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 
+#include <linux/rtnetlink.h>
 #include <sys/types.h>
 #include <net/if.h>
 
@@ -15,14 +16,23 @@
 #define IPV4_IFACE_ADDR		"10.0.0.254"
 #define IPV4_NUD_FAILED_ADDR	"10.0.0.1"
 #define IPV4_NUD_STALE_ADDR	"10.0.0.2"
+#define IPV4_TBID_ADDR		"172.0.0.254"
+#define IPV4_TBID_NET		"172.0.0.0"
+#define IPV4_TBID_DST		"172.0.0.2"
+#define IPV6_TBID_ADDR		"fd00::FFFF"
+#define IPV6_TBID_NET		"fd00::"
+#define IPV6_TBID_DST		"fd00::2"
 #define DMAC			"11:11:11:11:11:11"
 #define DMAC_INIT { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, }
+#define DMAC2			"01:01:01:01:01:01"
+#define DMAC_INIT2 { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, }
 
 struct fib_lookup_test {
 	const char *desc;
 	const char *daddr;
 	int expected_ret;
 	int lookup_flags;
+	__u32 tbid;
 	__u8 dmac[6];
 };
 
@@ -43,6 +53,22 @@ static const struct fib_lookup_test tests[] = {
 	{ .desc = "IPv4 skip neigh",
 	  .daddr = IPV4_NUD_FAILED_ADDR, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
 	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH, },
+	{ .desc = "IPv4 TBID lookup failure",
+	  .daddr = IPV4_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID,
+	  .tbid = RT_TABLE_MAIN, },
+	{ .desc = "IPv4 TBID lookup success",
+	  .daddr = IPV4_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID, .tbid = 100,
+	  .dmac = DMAC_INIT2, },
+	{ .desc = "IPv6 TBID lookup failure",
+	  .daddr = IPV6_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_NOT_FWDED,
+	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID,
+	  .tbid = RT_TABLE_MAIN, },
+	{ .desc = "IPv6 TBID lookup success",
+	  .daddr = IPV6_TBID_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
+	  .lookup_flags = BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_TBID, .tbid = 100,
+	  .dmac = DMAC_INIT2, },
 };
 
 static int ifindex;
@@ -53,6 +79,7 @@ static int setup_netns(void)
 
 	SYS(fail, "ip link add veth1 type veth peer name veth2");
 	SYS(fail, "ip link set dev veth1 up");
+	SYS(fail, "ip link set dev veth2 up");
 
 	err = write_sysctl("/proc/sys/net/ipv4/neigh/veth1/gc_stale_time", "900");
 	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.neigh.veth1.gc_stale_time)"))
@@ -70,6 +97,17 @@ static int setup_netns(void)
 	SYS(fail, "ip neigh add %s dev veth1 nud failed", IPV4_NUD_FAILED_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud stale", IPV4_NUD_STALE_ADDR, DMAC);
 
+	/* Setup for tbid lookup tests */
+	SYS(fail, "ip addr add %s/24 dev veth2", IPV4_TBID_ADDR);
+	SYS(fail, "ip route del %s/24 dev veth2", IPV4_TBID_NET);
+	SYS(fail, "ip route add table 100 %s/24 dev veth2", IPV4_TBID_NET);
+	SYS(fail, "ip neigh add %s dev veth2 lladdr %s nud stale", IPV4_TBID_DST, DMAC2);
+
+	SYS(fail, "ip addr add %s/64 dev veth2", IPV6_TBID_ADDR);
+	SYS(fail, "ip -6 route del %s/64 dev veth2", IPV6_TBID_NET);
+	SYS(fail, "ip -6 route add table 100 %s/64 dev veth2", IPV6_TBID_NET);
+	SYS(fail, "ip neigh add %s dev veth2 lladdr %s nud stale", IPV6_TBID_DST, DMAC2);
+
 	err = write_sysctl("/proc/sys/net/ipv4/conf/veth1/forwarding", "1");
 	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf.veth1.forwarding)"))
 		goto fail;
@@ -83,7 +121,7 @@ static int setup_netns(void)
 	return -1;
 }
 
-static int set_lookup_params(struct bpf_fib_lookup *params, const char *daddr)
+static int set_lookup_params(struct bpf_fib_lookup *params, const struct fib_lookup_test *test)
 {
 	int ret;
 
@@ -91,8 +129,9 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const char *daddr)
 
 	params->l4_protocol = IPPROTO_TCP;
 	params->ifindex = ifindex;
+	params->tbid = test->tbid;
 
-	if (inet_pton(AF_INET6, daddr, params->ipv6_dst) == 1) {
+	if (inet_pton(AF_INET6, test->daddr, params->ipv6_dst) == 1) {
 		params->family = AF_INET6;
 		ret = inet_pton(AF_INET6, IPV6_IFACE_ADDR, params->ipv6_src);
 		if (!ASSERT_EQ(ret, 1, "inet_pton(IPV6_IFACE_ADDR)"))
@@ -100,7 +139,7 @@ static int set_lookup_params(struct bpf_fib_lookup *params, const char *daddr)
 		return 0;
 	}
 
-	ret = inet_pton(AF_INET, daddr, &params->ipv4_dst);
+	ret = inet_pton(AF_INET, test->daddr, &params->ipv4_dst);
 	if (!ASSERT_EQ(ret, 1, "convert IP[46] address"))
 		return -1;
 	params->family = AF_INET;
@@ -154,13 +193,12 @@ void test_fib_lookup(void)
 	fib_params = &skel->bss->fib_params;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		printf("Testing %s\n", tests[i].desc);
+		printf("Testing %s ", tests[i].desc);
 
-		if (set_lookup_params(fib_params, tests[i].daddr))
+		if (set_lookup_params(fib_params, &tests[i]))
 			continue;
 		skel->bss->fib_lookup_ret = -1;
-		skel->bss->lookup_flags = BPF_FIB_LOOKUP_OUTPUT |
-			tests[i].lookup_flags;
+		skel->bss->lookup_flags = tests[i].lookup_flags;
 
 		err = bpf_prog_test_run_opts(prog_fd, &run_opts);
 		if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
@@ -175,7 +213,14 @@ void test_fib_lookup(void)
 
 			mac_str(expected, tests[i].dmac);
 			mac_str(actual, fib_params->dmac);
-			printf("dmac expected %s actual %s\n", expected, actual);
+			printf("dmac expected %s actual %s ", expected, actual);
+		}
+
+		// ensure tbid is zero'd out after fib lookup.
+		if (tests[i].lookup_flags & BPF_FIB_LOOKUP_DIRECT) {
+			if (!ASSERT_EQ(skel->bss->fib_params.tbid, 0,
+					"expected fib_params.tbid to be zero"))
+				goto fail;
 		}
 	}
 

-- 
2.40.1


