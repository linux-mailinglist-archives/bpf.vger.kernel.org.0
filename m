Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473A06A8D4C
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCBXuw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCBXuv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:51 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F4367C5
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:50 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KUvsq032521
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:49 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2y1mkc91-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:49 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:45 -0800
Received: from twshared18553.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0507F291B7F0B; Thu,  2 Mar 2023 15:50:40 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 11/17] bpf: generalize dynptr_get_spi to be usable for iters
Date:   Thu, 2 Mar 2023 15:50:09 -0800
Message-ID: <20230302235015.2044271-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HGpv602lNWjIUx_CXv5xKyaI9bi3CB39
X-Proofpoint-ORIG-GUID: HGpv602lNWjIUx_CXv5xKyaI9bi3CB39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Generalize the logic of fetching special stack slot object state using
spi (stack slot index). This will be used by STACK_ITER logic next.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ed53280ce95..641a36204493 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -710,32 +710,38 @@ static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_sl
        return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
 }
 
-static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			          const char *obj_kind, int nr_slots)
 {
 	int off, spi;
 
 	if (!tnum_is_const(reg->var_off)) {
-		verbose(env, "dynptr has to be at a constant offset\n");
+		verbose(env, "%s has to be at a constant offset\n", obj_kind);
 		return -EINVAL;
 	}
 
 	off = reg->off + reg->var_off.value;
 	if (off % BPF_REG_SIZE) {
-		verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
+		verbose(env, "cannot pass in %s at an offset=%d\n", obj_kind, off);
 		return -EINVAL;
 	}
 
 	spi = __get_spi(off);
-	if (spi < 1) {
-		verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
+	if (spi + 1 < nr_slots) {
+		verbose(env, "cannot pass in %s at an offset=%d\n", obj_kind, off);
 		return -EINVAL;
 	}
 
-	if (!is_spi_bounds_valid(func(env, reg), spi, BPF_DYNPTR_NR_SLOTS))
+	if (!is_spi_bounds_valid(func(env, reg), spi, nr_slots))
 		return -ERANGE;
 	return spi;
 }
 
+static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	return stack_slot_obj_get_spi(env, reg, "dynptr", BPF_DYNPTR_NR_SLOTS);
+}
+
 static const char *kernel_type_name(const struct btf* btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
-- 
2.30.2

