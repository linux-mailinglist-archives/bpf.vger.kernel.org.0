Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE97615C38
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 07:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKBGWp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Nov 2022 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKBGWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 02:22:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A5B2612C
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 23:22:39 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A25BPog029200
        for <bpf@vger.kernel.org>; Tue, 1 Nov 2022 23:22:39 -0700
Received: from maileast.thefacebook.com ([163.114.130.3])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kjk618u06-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 23:22:38 -0700
Received: from twshared24130.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 23:22:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7797020F58A1A; Tue,  1 Nov 2022 23:22:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/6] bpf: propagate precision in ALU/ALU64 operations
Date:   Tue, 1 Nov 2022 23:22:16 -0700
Message-ID: <20221102062221.2019833-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221102062221.2019833-1-andrii@kernel.org>
References: <20221102062221.2019833-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: W1XXjky3kasH9VA70KSNt1pJysQlXQ43
X-Proofpoint-ORIG-GUID: W1XXjky3kasH9VA70KSNt1pJysQlXQ43
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_03,2022-11-01_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When processing ALU/ALU64 operations (apart from BPF_MOV, which is
handled correctly already; and BPF_NEG and BPF_END are special and don't
have source register), if destination register is already marked
precise, this causes problem with potentially missing precision tracking
for the source register. E.g., when we have r1 >>= r5 and r1 is marked
precise, but r5 isn't, this will lead to r5 staying as imprecise. This
is due to the precision backtracking logic stopping early when it sees
r1 is already marked precise. If r1 wasn't precise, we'd keep
backtracking and would add r5 to the set of registers that need to be
marked precise. So there is a discrepancy here which can lead to invalid
and incompatible states matched due to lack of precision marking on r5.
If r1 wasn't precise, precision backtracking would correctly mark both
r1 and r5 as precise.

This is simple to fix, luckily. If destination register is already
precise, we need to propagate precision to source register (if it is
SCALAR). This is similar to `reg += scalar` handling case, so nothing
conceptually new here.

This does have (negative) effect on some selftest programs and few
Cilium programs.  ~/baseline-tmp-results.csv are veristat results with
this patch, while ~/baseline-results.csv is without it. See post
scriptum for instructions on how to make Cilium programs testable with
veristat. Correctness has a price.

$ ./veristat -C -e file,prog,insns,states ~/baseline-results.csv ~/baseline-tmp-results.csv | grep -v '+0'
File                     Program               Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
-----------------------  --------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
bpf_cubic.bpf.linked1.o  bpf_cubic_cong_avoid              997             1700      +703 (+70.51%)                62                90        +28 (+45.16%)
test_l4lb.bpf.linked1.o  balancer_ingress                 4559             5469      +910 (+19.96%)               118               126          +8 (+6.78%)
-----------------------  --------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

$ ./veristat -C -e file,prog,verdict,insns,states ~/baseline-results-cilium.csv ~/baseline-tmp-results-cilium.csv | grep -v '+0'
File           Program                         Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
-------------  ------------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
bpf_host.o     tail_nodeport_nat_ingress_ipv6             4448             5261      +813 (+18.28%)               234               247         +13 (+5.56%)
bpf_host.o     tail_nodeport_nat_ipv6_egress              3396             3446        +50 (+1.47%)               201               203          +2 (+1.00%)
bpf_lxc.o      tail_nodeport_nat_ingress_ipv6             4448             5261      +813 (+18.28%)               234               247         +13 (+5.56%)
bpf_overlay.o  tail_nodeport_nat_ingress_ipv6             4448             5261      +813 (+18.28%)               234               247         +13 (+5.56%)
bpf_xdp.o      tail_lb_ipv4                              71736            73442      +1706 (+2.38%)              4295              4370         +75 (+1.75%)
-------------  ------------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

P.S. To make Cilium ([0]) programs libbpf-compatible and thus
veristat-loadable, apply changes from topmost commit in [1], which does
minimal changes to Cilium source code, mostly around SEC() annotations
and BPF map definitions.

  [0] https://github.com/cilium/cilium/
  [1] https://github.com/anakryiko/cilium/commits/libbpf-friendliness

Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 275c2f1f00ee..3f3c4451674d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9197,6 +9197,11 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				return err;
 			return adjust_ptr_min_max_vals(env, insn,
 						       dst_reg, src_reg);
+		} else if (dst_reg->precise) {
+			/* if dst_reg is precise, src_reg should be precise as well */
+			err = mark_chain_precision(env, insn->src_reg);
+			if (err)
+				return err;
 		}
 	} else {
 		/* Pretend the src is a reg with a known value, since we only
-- 
2.30.2

