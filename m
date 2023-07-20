Return-Path: <bpf+bounces-5405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00475A35B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AE4281BC6
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826F8361;
	Thu, 20 Jul 2023 00:21:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583917F
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:21:20 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD72126
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:20:46 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C2CF1C151980
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689812393; bh=XVurAwJEk442Acuwy8LEcPJ6lok1pBa/28OPIVwTzVI=;
	h=To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LYQy24NilpxsjYMVnFLDkcpeH1wYzyAOA5OOXxrx/0IGEEkwv8I0SPLA/acLrxHJg
	 a83gpOkEgDJ77lLoNjJZiTCbxuyBpBSrLtQqOIFa1OrYqCzXYc4hiYEh4KNZNc2yBY
	 4j7rOSNWV6ElqUN9QLqw2SrPSVC8jNoIuZBgo5Jo=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id A077CC1516EA;
 Wed, 19 Jul 2023 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1689812393; bh=XVurAwJEk442Acuwy8LEcPJ6lok1pBa/28OPIVwTzVI=;
 h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=p+KzsQikiDWkeZn+Pru4n8jC4CxozP+eVZwkZ/Dy+jF9GudTDL9AYJ0cLYz8npqyH
 KuiiexI3r0QqKRhfmSFgl+4Z+ZpXHxcHnp5hu/r01jXolJiM19xBFo+wWjx6uVYTLp
 ajnwTXbsAr6Zm5dUDPpZyAh/+Lt1ieVDAFnuTgbQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id F145EC15155C
 for <bpf@ietfa.amsl.com>; Wed, 19 Jul 2023 17:18:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.445
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=fb.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fdz2f0gQirxO for <bpf@ietfa.amsl.com>;
 Wed, 19 Jul 2023 17:17:57 -0700 (PDT)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4D91BC151064
 for <bpf@ietf.org>; Wed, 19 Jul 2023 17:17:57 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JMM8Yr002332 for <bpf@ietf.org>; Wed, 19 Jul 2023 17:02:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=txDEwgegHeiAN04McoM/wyxhAYcvhGp9QbbyR7Ij3mw=;
 b=qN9Pojw3ZWVfsjjAJklHLzyDfvhR9CR4wS++/klyJCX60JTUwRYIbDIfnTCZhEe0qr8m
 hEHLA11fcH5logv4z0js1pYQUDVFe83AfL9rqpLwPY5aQh7vX6boJ1Z09jNOb1rHPKvQ
 WQhjoO2hOZnrva8C8lwk+V0PVhh0ZsaTctw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxjpcku4y-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <bpf@ietf.org>; Wed, 19 Jul 2023 17:02:32 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:02:31 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
 id 0A3CC2354EA88; Wed, 19 Jul 2023 17:02:23 -0700 (PDT)
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, <kernel-team@fb.com>
Date: Wed, 19 Jul 2023 17:02:23 -0700
Message-ID: <20230720000223.112169-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
X-Proofpoint-GUID: QdxB21Gzqi138Za6GULypCMsVd_lzmRC
X-Proofpoint-ORIG-GUID: QdxB21Gzqi138Za6GULypCMsVd_lzmRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/bZDSkSa_91hiJF6JrQXbrJz52-0>
Subject: [Bpf] [PATCH bpf-next v3 15/17] selftests/bpf: Add unit tests for
 new gotol insn
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Yonghong Song <yhs@fb.com>
From: Yonghong Song <yhs=40fb.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add unit tests for gotol insn.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_gotol.c      | 30 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a591d7b673f1..e3e68c97b40c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -25,6 +25,7 @@
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
 #include "verifier_div_overflow.skel.h"
+#include "verifier_gotol.skel.h"
 #include "verifier_helper_access_var_len.skel.h"
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
@@ -131,6 +132,7 @@ void test_verifier_direct_packet_access(void) { RUN(verifier_direct_packet_acces
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
+void test_verifier_gotol(void)                { RUN(verifier_gotol); }
 void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_len); }
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
new file mode 100644
index 000000000000..78870ea4d468
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("gotol, small_imm")
+__success __success_unpriv __retval(1)
+__naked void gotol_small_imm(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 == 0 goto l0_%=;				\
+	gotol l1_%=;					\
+l2_%=:							\
+	gotol l3_%=;					\
+l1_%=:							\
+	r0 = 1;						\
+	gotol l2_%=;					\
+l0_%=:							\
+	r0 = 2;						\
+l3_%=:							\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

