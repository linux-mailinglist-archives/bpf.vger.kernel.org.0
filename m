Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827B21F1DCD
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgFHQvi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 12:51:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21086 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387466AbgFHQvh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591635095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XF3Wy7iZfFTJJshRavRsaR0+EGzv3e2uxQj+6HLGC0w=;
        b=Dz6aW+8MSKqfToT5C/+X5CnYL3RyPvbvkyJ04OG4Et0zLhXXRkFdlks5P4+SRP+BlrMr4F
        k6pg93c2Zd4MGBTdpQVGt40VZsauiliZoNLAxySTrEEXllkilhR+hmxRcMlwFvy0DRWmcy
        /8norpf9Se4ZuHD0T6rnId6MjDTZ/X4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-_RQr77-jP1-VH61q87erNA-1; Mon, 08 Jun 2020 12:51:33 -0400
X-MC-Unique: _RQr77-jP1-VH61q87erNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D655D8018A2;
        Mon,  8 Jun 2020 16:51:31 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC62979598;
        Mon,  8 Jun 2020 16:51:28 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id BA22E300003EB;
        Mon,  8 Jun 2020 18:51:27 +0200 (CEST)
Subject: [PATCH bpf 3/3] bpf: selftests and tools use struct bpf_devmap_val
 from uapi
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     David Ahern <dsahern@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Mon, 08 Jun 2020 18:51:27 +0200
Message-ID: <159163508769.1967373.9026895070748918567.stgit@firesoul>
In-Reply-To: <159163498340.1967373.5048584263152085317.stgit@firesoul>
References: <159163498340.1967373.5048584263152085317.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync tools uapi bpf.h header file and update selftests that use
struct bpf_devmap_val.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 tools/include/uapi/linux/bpf.h                     |   18 ++++++++++++++++++
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   |    8 --------
 .../selftests/bpf/progs/test_xdp_devmap_helpers.c  |    2 +-
 .../bpf/progs/test_xdp_with_devmap_helpers.c       |    3 +--
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 868e9efe9c09..19684813faae 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3761,6 +3761,24 @@ struct xdp_md {
 	__u32 egress_ifindex;  /* txq->dev->ifindex */
 };
 
+/* DEVMAP map-value layout
+ *
+ * The struct data-layout of map-value is a configuration interface.
+ * New members can only be added to the end of this structure.
+ */
+struct bpf_devmap_val {
+	__u32 ifindex;   /* device index */
+	union {
+		int   fd;  /* prog fd on map write */
+		__u32 id;  /* prog id on map read */
+	} bpf_prog;
+};
+
+enum sk_action {
+	SK_DROP = 0,
+	SK_PASS,
+};
+
 /* user accessible metadata for SK_MSG packet hook, new fields must
  * be added to the end of this structure
  */
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
index d19dbd668f6a..88ef3ec8ac4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
@@ -8,14 +8,6 @@
 
 #define IFINDEX_LO 1
 
-struct bpf_devmap_val {
-	u32 ifindex;   /* device index */
-	union {
-		int fd;  /* prog fd on map write */
-		u32 id;  /* prog id on map read */
-	} bpf_prog;
-};
-
 void test_xdp_with_devmap_helpers(void)
 {
 	struct test_xdp_with_devmap_helpers *skel;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
index e5c0f131c8a7..b360ba2bd441 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
@@ -2,7 +2,7 @@
 /* fails to load without expected_attach_type = BPF_XDP_DEVMAP
  * because of access to egress_ifindex
  */
-#include "vmlinux.h"
+#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
 SEC("xdp_dm_log")
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
index deef0e050863..330811260123 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#include "vmlinux.h"
+#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
 struct {


