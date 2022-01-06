Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B79486B77
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiAFUwD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Jan 2022 15:52:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243986AbiAFUwD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 15:52:03 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 206HUwIt021066
        for <bpf@vger.kernel.org>; Thu, 6 Jan 2022 12:52:02 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3de4w2saq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 12:52:02 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 12:52:01 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BC038E89C24B; Thu,  6 Jan 2022 12:51:57 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: don't rely on preserving volatile in PT_REGS macros in loop3
Date:   Thu, 6 Jan 2022 12:51:56 -0800
Message-ID: <20220106205156.955373-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _IaoPfApapmZm3JE2oIf-LRCuFZBQE_4
X-Proofpoint-ORIG-GUID: _IaoPfApapmZm3JE2oIf-LRCuFZBQE_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_09,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=802 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PT_REGS*() macro on some architectures force-cast struct pt_regs to
other types (user_pt_regs, etc) and might drop volatile modifiers, if any.
Volatile isn't really required as pt_regs value isn't supposed to change
during the BPF program run, so this is correct behavior.

But progs/loop3.c relies on that volatile modifier to ensure that loop
is preserved. Fix loop3.c by declaring i and sum variables as volatile
instead. It preserves the loop and makes the test pass on all
architectures (including s390x which is currently broken).

Fixes: 3cc31d794097 ("libbpf: Normalize PT_REGS_xxx() macro definitions")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/loop3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/loop3.c b/tools/testing/selftests/bpf/progs/loop3.c
index 76e93b31c14b..24ff85295830 100644
--- a/tools/testing/selftests/bpf/progs/loop3.c
+++ b/tools/testing/selftests/bpf/progs/loop3.c
@@ -12,9 +12,9 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("raw_tracepoint/consume_skb")
-int while_true(volatile struct pt_regs* ctx)
+int while_true(struct pt_regs* ctx)
 {
-	__u64 i = 0, sum = 0;
+	volatile __u64 i = 0, sum = 0;
 	do {
 		i++;
 		sum += PT_REGS_RC(ctx);
-- 
2.30.2

