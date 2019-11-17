Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8BFFBCC
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2019 22:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfKQVkn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Nov 2019 16:40:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29652 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbfKQVkn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Nov 2019 16:40:43 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAHLXYIw021318
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2019 13:40:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=HkZaXgIXoPhZIEMWaqtkBfh/2ljj+4jP7u2qJ4cV+8o=;
 b=DEQCAaA3lQScMaWwMmLeNtz/mBJ+mIZsVIGzvoLP3k3ymBxIC4SYxoG2GI0EYzqTYI03
 +xbF2kB9Hy6D7ZRPphlutYgTh4WB7aAdX2HpWtZjcTBGEvf/kZCm7YXhNpb6y5uSQJcs
 TSgCT+pQ0fOSz+xmNk4MD985DVC1A0MhLug= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2waftk045t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 17 Nov 2019 13:40:40 -0800
Received: from 2401:db00:2120:81dc:face:0:23:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sun, 17 Nov 2019 13:40:38 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7B0583702037; Sun, 17 Nov 2019 13:40:36 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] [tools/bpf] workaround an alu32 sub-register spilling issue
Date:   Sun, 17 Nov 2019 13:40:36 -0800
Message-ID: <20191117214036.1309510-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_05:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=450 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0
 suspectscore=13 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911170205
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, with latest llvm trunk, selftest test_progs failed
obj file test_seg6_loop.o with the following error
in verifier:
  infinite loop detected at insn 76
The byte code sequence looks like below, and noted
that alu32 has been turned off by default for better
generated codes in general:
      48:       w3 = 100
      49:       *(u32 *)(r10 - 68) = r3
      ...
  ;             if (tlv.type == SR6_TLV_PADDING) {
      76:       if w3 == 5 goto -18 <LBB0_19>
      ...
      85:       r1 = *(u32 *)(r10 - 68)
  ;     for (int i = 0; i < 100; i++) {
      86:       w1 += -1
      87:       if w1 == 0 goto +5 <LBB0_20>
      88:       *(u32 *)(r10 - 68) = r1

The main reason for verification failure is due to
partial spills at r10 - 68 for induction variable "i".

Current verifier only handles spills with 8-byte values.
The above 4-byte value spill to stack is treated to
STACK_MISC and its content is not saved. For the above example,
    w3 = 100
      R3_w=inv100 fp-64_w=inv1086626730498
    *(u32 *)(r10 - 68) = r3
      R3_w=inv100 fp-64_w=inv1086626730498
    ...
    r1 = *(u32 *)(r10 - 68)
      R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
      fp-64=inv1086626730498

To resolve this issue, verifier needs to be extended to
track sub-registers in spilling, or llvm needs to enhanced
to prevent sub-register spilling in register allocation
phase. The former will increase verifier complexity and
the latter will need some llvm "hacking".

Let us workaround this issue by declaring the induction
variable as "long" type so spilling will happen at non
sub-register level. We can revisit this later if sub-register
spilling causes similar or other verification issues.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/test_seg6_loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_seg6_loop.c b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
index c4d104428643..69880c1e7700 100644
--- a/tools/testing/selftests/bpf/progs/test_seg6_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_seg6_loop.c
@@ -132,8 +132,10 @@ static __always_inline int is_valid_tlv_boundary(struct __sk_buff *skb,
 	*pad_off = 0;
 
 	// we can only go as far as ~10 TLVs due to the BPF max stack size
+	// workaround: define induction variable "i" as "long" instead
+	// of "int" to prevent alu32 sub-register spilling.
 	#pragma clang loop unroll(disable)
-	for (int i = 0; i < 100; i++) {
+	for (long i = 0; i < 100; i++) {
 		struct sr6_tlv_t tlv;
 
 		if (cur_off == *tlv_off)
-- 
2.17.1

