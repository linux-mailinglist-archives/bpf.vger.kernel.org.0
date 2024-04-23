Return-Path: <bpf+bounces-27579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0668AF6B6
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 20:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0561C24E3B
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D164F1420C6;
	Tue, 23 Apr 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgAHmKE1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AC1411E0;
	Tue, 23 Apr 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897352; cv=none; b=K66LqgLjh3ctiEZgH4nbbtWbi1ifQ12+fDqfDPqc3kDGsnvDhBFSWCplq3vyljktzuN1+8MqwdnbKh6tkY8HaXOntTjVY2ERVDb4gMflzB77Rdh0Lqxn0TiCQpq4x84KXFBraa3XsEvhY/JSthd1R3oxG5MTxz22BPK9bbteULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897352; c=relaxed/simple;
	bh=copQPF2i7DgNKGMAb3Id9J80Y1s6jektENP0rFg6zG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWYVcD32hlA3mEGU8FBXy1rXBsWzyr2FPeoFLTzoQFvdm571yAEENUdco/r4ollfDa1VEymnnhgpMdQja9dFcBMv1pnemQtBT0h7VnsS/Dnk6/ofO8ieE0ga4qVsUrTg6GYyQ2tH2acin56RZqTE/HvfanKrHlNAM0/ND9aRJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgAHmKE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB48C3277B;
	Tue, 23 Apr 2024 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713897351;
	bh=copQPF2i7DgNKGMAb3Id9J80Y1s6jektENP0rFg6zG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgAHmKE19xJGJyKQ3S5GBR6yM4NsE5YMdWtxHMxghDEx+miRavXguDBHPp55uEsk1
	 t51aEjEDH7epYqj7ynSB9rW1CF2jGLM5wp5PK7tZArR5MOtZ8/IOA7plrpLaa7zKWs
	 /aDh/dHbctxcFaJ/6qS2jCSaHfq9cyUJ9m52t9sCQt6iLxMbeX6yniqf+HUF/zBjI8
	 AiNnOOpOOhde3ZMwDGoTgSAi2I2ZeH0CTwmGjcn6LU6huVhZ9/meauT2fd+XJYm1/T
	 VzlQUtIyghE6qF+Na4K5Chz2h2NTPNj8U9wyMy7Ngx+K3LxeB0qJCJN/vwPpr3iswe
	 swI95of8OQiOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: net: name bpf objects consistently and simplify Makefile
Date: Tue, 23 Apr 2024 11:35:41 -0700
Message-ID: <20240423183542.3807234-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423183542.3807234-1-kuba@kernel.org>
References: <20240423183542.3807234-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF sources moved with bpf_offload.py have a suffix of .bpf.c
which seems to be useful convention. Rename the 2 other BPF sources
we had. Use wildcard in the Makefile, since we can match all those
files easily now.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/Makefile                     | 9 +++------
 tools/testing/selftests/net/{nat6to4.c => nat6to4.bpf.c} | 0
 tools/testing/selftests/net/udpgro.sh                    | 2 +-
 tools/testing/selftests/net/udpgro_bench.sh              | 2 +-
 tools/testing/selftests/net/udpgro_frglist.sh            | 8 ++++----
 tools/testing/selftests/net/udpgro_fwd.sh                | 2 +-
 tools/testing/selftests/net/veth.sh                      | 2 +-
 .../selftests/net/{xdp_dummy.c => xdp_dummy.bpf.c}       | 0
 8 files changed, 11 insertions(+), 14 deletions(-)
 rename tools/testing/selftests/net/{nat6to4.c => nat6to4.bpf.c} (100%)
 rename tools/testing/selftests/net/{xdp_dummy.c => xdp_dummy.bpf.c} (100%)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 7e7f243d0ab2..c388308ff517 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -82,10 +82,6 @@ TEST_GEN_PROGS += so_incoming_cpu
 TEST_PROGS += sctp_vrf.sh
 TEST_GEN_FILES += sctp_hello
 TEST_GEN_FILES += csum
-TEST_GEN_FILES += nat6to4.o
-TEST_GEN_FILES += xdp_dummy.o
-TEST_GEN_FILES += sample_ret0.bpf.o
-TEST_GEN_FILES += sample_map_ret0.bpf.o
 TEST_GEN_FILES += ip_local_port_range
 TEST_GEN_FILES += bind_wildcard
 TEST_PROGS += test_vxlan_mdb.sh
@@ -100,6 +96,8 @@ TEST_PROGS += bpf_offload.py
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
+TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
+
 TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
@@ -146,8 +144,7 @@ endif
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 
-BPF_PROG_OBJS := $(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o \
-	$(OUTPUT)/sample_map_ret0.bpf.o $(OUTPUT)/sample_ret0.bpf.o
+BPF_PROG_OBJS := $(patsubst %.c,$(OUTPUT)/%.o,$(wildcard *.bpf.c))
 
 $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
 	$(call msg,BPF_PROG,,$@)
diff --git a/tools/testing/selftests/net/nat6to4.c b/tools/testing/selftests/net/nat6to4.bpf.c
similarity index 100%
rename from tools/testing/selftests/net/nat6to4.c
rename to tools/testing/selftests/net/nat6to4.bpf.c
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 8802604148dd..11a1ebda564f 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.o"
+BPF_FILE="xdp_dummy.bpf.o"
 
 # set global exit status, but never reset nonzero one.
 check_err()
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 7080eae5312b..c51ea90a1395 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.o"
+BPF_FILE="xdp_dummy.bpf.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index e1ff645bd3d1..17404f49cdb6 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.o"
+BPF_FILE="xdp_dummy.bpf.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
@@ -42,8 +42,8 @@ run_one() {
 
 	ip -n "${PEER_NS}" link set veth1 xdp object ${BPF_FILE} section xdp
 	tc -n "${PEER_NS}" qdisc add dev veth1 clsact
-	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol ipv6 bpf object-file nat6to4.o section schedcls/ingress6/nat_6  direct-action
-	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol ip bpf object-file nat6to4.o section schedcls/egress4/snat4 direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol ipv6 bpf object-file nat6to4.bpf.o section schedcls/ingress6/nat_6  direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol ip bpf object-file nat6to4.bpf.o section schedcls/egress4/snat4 direct-action
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
@@ -89,7 +89,7 @@ if [ ! -f ${BPF_FILE} ]; then
 	exit -1
 fi
 
-if [ ! -f nat6to4.o ]; then
+if [ ! -f nat6to4.bpf.o ]; then
 	echo "Missing nat6to4 helper. Run 'make' first"
 	exit -1
 fi
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 83ed987cff34..550d8eb3e224 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -3,7 +3,7 @@
 
 source net_helper.sh
 
-BPF_FILE="xdp_dummy.o"
+BPF_FILE="xdp_dummy.bpf.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
 readonly SRC=2
 readonly DST=1
diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 3a394b43e274..4f1edbafb946 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-BPF_FILE="xdp_dummy.o"
+BPF_FILE="xdp_dummy.bpf.o"
 readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
 readonly BASE=`basename $STATS`
 readonly SRC=2
diff --git a/tools/testing/selftests/net/xdp_dummy.c b/tools/testing/selftests/net/xdp_dummy.bpf.c
similarity index 100%
rename from tools/testing/selftests/net/xdp_dummy.c
rename to tools/testing/selftests/net/xdp_dummy.bpf.c
-- 
2.44.0


