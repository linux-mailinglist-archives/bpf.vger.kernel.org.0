Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93E15E8447
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 22:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIWUoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiIWUnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 16:43:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F02E21E2
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 13:37:43 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NIGBkY012572
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 13:37:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=uMW05ntqhTxnqydbjTlEBEZMb68OIqoNaDlQ3mavUhM=;
 b=PjvXvgInDOcO0zsYqAlpPNRgpxm75fc4q3PSV8XFhZR7cEr0BJWsL1nthv/Tgi9QLzJW
 jTwJ4dZo4J406ivdTkl012y0CFyogyKVNCLsgizDB6LM9wRn9wbA5zMUKhALn4n2PgBY
 46G/U30j5sJW7+y9+DReAYOBGi+DXuewj7Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsb1nm5sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 13:37:16 -0700
Received: from twshared22593.02.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 13:37:14 -0700
Received: by devvm8797.prn0.facebook.com (Postfix, from userid 2982)
        id 94901B2B7691; Fri, 23 Sep 2022 13:37:02 -0700 (PDT)
From:   Tomislav Novak <tnovak@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tomislav Novak <tnovak@fb.com>,
        Samuel Gosselin <sgosselin@fb.com>
Subject: [PATCH] hw_breakpoint: fix single-stepping when using bpf_overflow_handler
Date:   Fri, 23 Sep 2022 13:36:45 -0700
Message-ID: <20220923203644.2731604-1-tnovak@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X8tLilDYzaUoOlwZsZyoBmOur0N3mdL_
X-Proofpoint-GUID: X8tLilDYzaUoOlwZsZyoBmOur0N3mdL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_09,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On ARM platforms is_default_overflow_handler() is used to determine if
hw_breakpoint code should single-step over the watchpoint trigger or
let the custom handler deal with it.

Attaching a BPF program to a watchpoint replaces the handler with
bpf_overflow_handler, which isn't recognized as a default handler so we
never step over the instruction triggering the data abort exception (the
watchpoint keeps firing):

  # bpftrace -e 'watchpoint:0x10000000:4:w { printf("hit\n"); }' ./wp_tes=
t
  Attaching 1 probe...
  hit
  hit
  hit
  [...]

(wp_test performs a single 4-byte store to address 0x10000000)

This patch replaces the check with uses_default_overflow_handler(), which
accounts for the bpf_overflow_handler() case by also testing if the handl=
er
invokes one of the perf_event_output functions via orig_default_handler.

Signed-off-by: Tomislav Novak <tnovak@fb.com>
Tested-by: Samuel Gosselin <sgosselin@fb.com> # arm64
---
 arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
 arch/arm64/kernel/hw_breakpoint.c |  4 ++--
 include/linux/perf_event.h        | 22 +++++++++++++++++++---
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpo=
int.c
index 054e9199f30d..dc0fb7a81371 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &=3D ~alignment_mask;
 	hw->ctrl.len <<=3D offset;
=20
-	if (is_default_overflow_handler(bp)) {
+	if (uses_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, un=
signed int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!is_default_overflow_handler(wp))
+		if (!uses_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, un=
signed int fsr,
 		info->trigger =3D addr;
 		pr_debug("watchpoint fired: address =3D 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (is_default_overflow_handler(wp))
+		if (uses_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
=20
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown,=
 struct pt_regs *regs)
 			info->trigger =3D addr;
 			pr_debug("breakpoint fired: address =3D 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (is_default_overflow_handler(bp))
+			if (uses_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_bre=
akpoint.c
index b29a311bb055..9659a9555c63 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, u=
nsigned long esr,
 		perf_bp_event(bp, regs);
=20
 		/* Do we need to handle the stepping? */
-		if (is_default_overflow_handler(bp))
+		if (uses_default_overflow_handler(bp))
 			step =3D 1;
 unlock:
 		rcu_read_unlock();
@@ -733,7 +733,7 @@ static u64 get_distance_from_watchpoint(unsigned long=
 addr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step =3D is_default_overflow_handler(wp);
+	int step =3D uses_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info =3D counter_arch_bp(wp);
=20
 	info->trigger =3D addr;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..f174b77437f5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1105,15 +1105,31 @@ extern int perf_event_output(struct perf_event *e=
vent,
 			     struct pt_regs *regs);
=20
 static inline bool
-is_default_overflow_handler(struct perf_event *event)
+__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 {
-	if (likely(event->overflow_handler =3D=3D perf_event_output_forward))
+	if (likely(overflow_handler =3D=3D perf_event_output_forward))
 		return true;
-	if (unlikely(event->overflow_handler =3D=3D perf_event_output_backward)=
)
+	if (unlikely(overflow_handler =3D=3D perf_event_output_backward))
 		return true;
 	return false;
 }
=20
+#define is_default_overflow_handler(event) \
+	__is_default_overflow_handler((event)->overflow_handler)
+
+#ifdef CONFIG_BPF_SYSCALL
+static inline bool uses_default_overflow_handler(struct perf_event *even=
t)
+{
+	if (likely(is_default_overflow_handler(event)))
+		return true;
+
+	return __is_default_overflow_handler(event->orig_overflow_handler);
+}
+#else
+#define uses_default_overflow_handler(event) \
+	is_default_overflow_handler(event)
+#endif
+
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,
--=20
2.30.2

