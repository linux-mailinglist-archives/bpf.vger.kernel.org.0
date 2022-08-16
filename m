Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E78594F2D
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 05:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiHPDwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 15 Aug 2022 23:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHPDvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 23:51:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1F338F9A
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:20:18 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIbvTa014661
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:19:42 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hyry8uc36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:19:42 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 15 Aug 2022 17:19:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 665891DAC7DB4; Mon, 15 Aug 2022 17:19:38 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: few fixes for selftests/bpf built in release mode
Date:   Mon, 15 Aug 2022 17:19:29 -0700
Message-ID: <20220816001929.369487-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220816001929.369487-1-andrii@kernel.org>
References: <20220816001929.369487-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Qm_FC4wrGC7ss6L7a3ol2cHGItPMJseb
X-Proofpoint-ORIG-GUID: Qm_FC4wrGC7ss6L7a3ol2cHGItPMJseb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few issues found when building and running test_progs in release
mode.

First, potentially uninitialized idx variable in xskxceiver,
force-initialize to zero to satisfy compiler.

Few instances of defining uprobe trigger functions break in release mode
unless marked as noinline, due to being static. Add noinline to make
sure everything works.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c | 6 +++---
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c   | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c | 2 +-
 tools/testing/selftests/bpf/xskxceiver.c              | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 0b899d2d8ea7..9566d9d2f6ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -6,19 +6,19 @@
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
 
 /* uprobe attach point */
-static void trigger_func(void)
+static noinline void trigger_func(void)
 {
 	asm volatile ("");
 }
 
 /* attach point for byname uprobe */
-static void trigger_func2(void)
+static noinline void trigger_func2(void)
 {
 	asm volatile ("");
 }
 
 /* attach point for byname sleepable uprobe */
-static void trigger_func3(void)
+static noinline void trigger_func3(void)
 {
 	asm volatile ("");
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 2974b44f80fa..2be2d61954bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -13,7 +13,7 @@
 #include "kprobe_multi.skel.h"
 
 /* uprobe attach point */
-static void trigger_func(void)
+static noinline void trigger_func(void)
 {
 	asm volatile ("");
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
index 61935e7e056a..f000734a3d1f 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
@@ -4,7 +4,7 @@
 #include "test_task_pt_regs.skel.h"
 
 /* uprobe attach point */
-static void trigger_func(void)
+static noinline void trigger_func(void)
 {
 	asm volatile ("");
 }
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 20b44ab32a06..14b4737b223c 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -922,7 +922,7 @@ static int __send_pkts(struct ifobject *ifobject, u32 *pkt_nb, struct pollfd *fd
 {
 	struct xsk_socket_info *xsk = ifobject->xsk;
 	bool use_poll = ifobject->use_poll;
-	u32 i, idx, ret, valid_pkts = 0;
+	u32 i, idx = 0, ret, valid_pkts = 0;
 
 	while (xsk_ring_prod__reserve(&xsk->tx, BATCH_SIZE, &idx) < BATCH_SIZE) {
 		if (use_poll) {
-- 
2.30.2

