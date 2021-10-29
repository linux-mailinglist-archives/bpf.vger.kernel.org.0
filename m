Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DE4401E1
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 20:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhJ2Sbs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 29 Oct 2021 14:31:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64538 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230022AbhJ2Sbo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 14:31:44 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19THwSY6022047
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 11:29:15 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c0b755n5e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 11:29:15 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 11:29:10 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2759377E515F; Fri, 29 Oct 2021 11:29:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix strobemeta selftest regression
Date:   Fri, 29 Oct 2021 11:29:07 -0700
Message-ID: <20211029182907.166910-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Gvk5_Gd3AvNX4hiEdxEHo1_cKyC2XrG0
X-Proofpoint-ORIG-GUID: Gvk5_Gd3AvNX4hiEdxEHo1_cKyC2XrG0
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_04,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=824 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After most recent nightly Clang update strobemeta selftests started
failing with the following error (relevant portion of assembly included):

  1624: (85) call bpf_probe_read_user_str#114
  1625: (bf) r1 = r0
  1626: (18) r2 = 0xfffffffe
  1628: (5f) r1 &= r2
  1629: (55) if r1 != 0x0 goto pc+7
  1630: (07) r9 += 104
  1631: (6b) *(u16 *)(r9 +0) = r0
  1632: (67) r0 <<= 32
  1633: (77) r0 >>= 32
  1634: (79) r1 = *(u64 *)(r10 -456)
  1635: (0f) r1 += r0
  1636: (7b) *(u64 *)(r10 -456) = r1
  1637: (79) r1 = *(u64 *)(r10 -368)
  1638: (c5) if r1 s< 0x1 goto pc+778
  1639: (bf) r6 = r8
  1640: (0f) r6 += r7
  1641: (b4) w1 = 0
  1642: (6b) *(u16 *)(r6 +108) = r1
  1643: (79) r3 = *(u64 *)(r10 -352)
  1644: (79) r9 = *(u64 *)(r10 -456)
  1645: (bf) r1 = r9
  1646: (b4) w2 = 1
  1647: (85) call bpf_probe_read_user_str#114

  R1 unbounded memory access, make sure to bounds check any such access

In the above code r0 and r1 are implicitly related. Clang knows that,
but verifier isn't able to infer this relationship.

Yonghong Song narrowed down this "regression" in code generation to
a recent Clang optimization change ([0]), which for BPF target generates
code pattern that BPF verifier can't handle and loses track of register
boundaries.

This patch works around the issue by adding an BPF assembly-based helper
that helps to prove to the verifier that upper bound of the register is
a given constant by controlling the exact share of generated BPF
instruction sequence. This fixes the immediate issue for strobemeta
selftest.

  [0] https://github.com/llvm/llvm-project/commit/acabad9ff6bf13e00305d9d8621ee8eafc1f8b08

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/strobemeta.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 7de534f38c3f..3687ea755ab5 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -10,6 +10,14 @@
 #include <linux/types.h>
 #include <bpf/bpf_helpers.h>
 
+#define bpf_clamp_umax(VAR, UMAX)					\
+	asm volatile (							\
+		"if %0 <= %[max] goto +1\n"				\
+		"%0 = %[max]\n"						\
+		: "+r"(VAR)						\
+		: [max]"i"(UMAX)					\
+	)
+
 typedef uint32_t pid_t;
 struct task_struct {};
 
@@ -413,6 +421,7 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 
 	len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, map.tag);
 	if (len <= STROBE_MAX_STR_LEN) {
+		bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
 		descr->tag_len = len;
 		payload += len;
 	}
@@ -430,6 +439,7 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
 					      map.entries[i].key);
 		if (len <= STROBE_MAX_STR_LEN) {
+			bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
 			descr->key_lens[i] = len;
 			payload += len;
 		}
@@ -437,6 +447,7 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
 					      map.entries[i].val);
 		if (len <= STROBE_MAX_STR_LEN) {
+			bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
 			descr->val_lens[i] = len;
 			payload += len;
 		}
-- 
2.30.2

