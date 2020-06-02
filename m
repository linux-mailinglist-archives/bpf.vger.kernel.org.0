Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9A1EC149
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 19:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgFBRoB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 13:44:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725969AbgFBRoB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Jun 2020 13:44:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052HWYbq082430;
        Tue, 2 Jun 2020 13:43:48 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31dp42aur4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 13:43:48 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052He96R007292;
        Tue, 2 Jun 2020 17:43:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf47xgbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 17:43:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 052Hhhos58655210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 17:43:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC63C5204F;
        Tue,  2 Jun 2020 17:43:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.174.225])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA8355204E;
        Tue,  2 Jun 2020 17:43:42 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] s390/bpf: Maintain 8-byte stack alignment
Date:   Tue,  2 Jun 2020 19:43:39 +0200
Message-Id: <20200602174339.2501066-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_13:2020-06-02,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 cotscore=-2147483648
 adultscore=0 suspectscore=2 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020123
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Certain kernel functions (e.g. get_vtimer/set_vtimer) cause kernel
panic when the stack is not 8-byte aligned. Currently JITed BPF programs
may trigger this by allocating stack frames with non-rounded sizes and
then being interrupted. Fix by using rounded fp->aux->stack_depth.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 8d2134136290..0f37a1b635f8 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -594,7 +594,7 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
  * stack space for the large switch statement.
  */
 static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
-				 int i, bool extra_pass)
+				 int i, bool extra_pass, u32 stack_depth)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
 	u32 dst_reg = insn->dst_reg;
@@ -1207,7 +1207,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 */
 
 		if (jit->seen & SEEN_STACK)
-			off = STK_OFF_TCCNT + STK_OFF + fp->aux->stack_depth;
+			off = STK_OFF_TCCNT + STK_OFF + stack_depth;
 		else
 			off = STK_OFF_TCCNT;
 		/* lhi %w0,1 */
@@ -1249,7 +1249,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/*
 		 * Restore registers before calling function
 		 */
-		save_restore_regs(jit, REGS_RESTORE, fp->aux->stack_depth);
+		save_restore_regs(jit, REGS_RESTORE, stack_depth);
 
 		/*
 		 * goto *(prog->bpf_func + tail_call_start);
@@ -1519,7 +1519,7 @@ static int bpf_set_addr(struct bpf_jit *jit, int i)
  * Compile eBPF program into s390x code
  */
 static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
-			bool extra_pass)
+			bool extra_pass, u32 stack_depth)
 {
 	int i, insn_count, lit32_size, lit64_size;
 
@@ -1527,18 +1527,18 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->lit64 = jit->lit64_start;
 	jit->prg = 0;
 
-	bpf_jit_prologue(jit, fp->aux->stack_depth);
+	bpf_jit_prologue(jit, stack_depth);
 	if (bpf_set_addr(jit, 0) < 0)
 		return -1;
 	for (i = 0; i < fp->len; i += insn_count) {
-		insn_count = bpf_jit_insn(jit, fp, i, extra_pass);
+		insn_count = bpf_jit_insn(jit, fp, i, extra_pass, stack_depth);
 		if (insn_count < 0)
 			return -1;
 		/* Next instruction address */
 		if (bpf_set_addr(jit, i + insn_count) < 0)
 			return -1;
 	}
-	bpf_jit_epilogue(jit, fp->aux->stack_depth);
+	bpf_jit_epilogue(jit, stack_depth);
 
 	lit32_size = jit->lit32 - jit->lit32_start;
 	lit64_size = jit->lit64 - jit->lit64_start;
@@ -1569,6 +1569,7 @@ struct s390_jit_data {
  */
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
+	u32 stack_depth = round_up(fp->aux->stack_depth, 8);
 	struct bpf_prog *tmp, *orig_fp = fp;
 	struct bpf_binary_header *header;
 	struct s390_jit_data *jit_data;
@@ -1621,7 +1622,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 *   - 3:   Calculate program size and addrs arrray
 	 */
 	for (pass = 1; pass <= 3; pass++) {
-		if (bpf_jit_prog(&jit, fp, extra_pass)) {
+		if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
 			fp = orig_fp;
 			goto free_addrs;
 		}
@@ -1635,7 +1636,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		goto free_addrs;
 	}
 skip_init_ctx:
-	if (bpf_jit_prog(&jit, fp, extra_pass)) {
+	if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
 		bpf_jit_binary_free(header);
 		fp = orig_fp;
 		goto free_addrs;
-- 
2.25.4

