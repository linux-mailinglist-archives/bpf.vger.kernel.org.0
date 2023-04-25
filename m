Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38476EE715
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjDYRsC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDYRsB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 13:48:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A650AD0F
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 10:48:00 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PGDP1O002245
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 10:48:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=G2aTf0mrxc4MBcUVcjGxQOvKF6xdhVDbMmvJ7gxVRBQ=;
 b=UlYQKp/SCHQgaMVrg/3047pWyR2AU94gn9U3B+yGH37j+8TV3UeMgLKPVXVAbl6jVAlg
 DHNzie7vsrCWee1Bg1Vvd8s3MM65KX4uA/8ItpCKrCFfFoBCR+l1yLeyGeZfU9KjLa8P
 hX7Xze+VIw7xvONU3ZZYxxkXwUkIf6Hc1Dk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q687r4ek8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 10:47:59 -0700
Received: from twshared4902.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 10:47:58 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B7D901E2535E7; Tue, 25 Apr 2023 10:47:44 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix selftest test_global_funcs/global_func1 failure with latest clang
Date:   Tue, 25 Apr 2023 10:47:44 -0700
Message-ID: <20230425174744.1758515-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OWisvOZtxdo9wDJAW19mmdvVh7a3G3iA
X-Proofpoint-GUID: OWisvOZtxdo9wDJAW19mmdvVh7a3G3iA
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The selftest test_global_funcs/global_func1 failed with the latest clang17.
The reason is due to upstream ArgumentPromotionPass ([1]),
which may manipulate static function parameters and cause inlining
although the funciton is marked as noinline.

The original code:
  static __attribute__ ((noinline))
  int f0(int var, struct __sk_buff *skb)
  {
        return skb->len;
  }

  __attribute__ ((noinline))
  int f1(struct __sk_buff *skb)
  {
	...
        return f0(0, skb) + skb->len;
  }

  ...

  SEC("tc")
  __failure __msg("combined stack size of 4 calls is 544")
  int global_func1(struct __sk_buff *skb)
  {
        return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
  }

After ArgumentPromotionPass, the code is translated to
  static __attribute__ ((noinline))
  int f0(int var, int skb_len)
  {
        return skb_len;
  }

  __attribute__ ((noinline))
  int f1(struct __sk_buff *skb)
  {
	...
        return f0(0, skb->len) + skb->len;
  }

  ...

  SEC("tc")
  __failure __msg("combined stack size of 4 calls is 544")
  int global_func1(struct __sk_buff *skb)
  {
        return f0(1, skb->len) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
  }

And later llvm InstCombine phase recognized that f0()
simplify returns the value of the second argument and removed f0()
completely and the final code looks like:
  __attribute__ ((noinline))
  int f1(struct __sk_buff *skb)
  {
	...
        return skb->len + skb->len;
  }

  ...

  SEC("tc")
  __failure __msg("combined stack size of 4 calls is 544")
  int global_func1(struct __sk_buff *skb)
  {
        return skb->len + f1(skb) + f2(2, skb) + f3(3, skb, 4);
  }

If f0() is not inlined, the verification will fail with stack size
544 for a particular callchain. With f0() inlined, the maximum
stack size is 512 which is in the limit.

Let us add a `asm volatile ("")` in f0() to prevent ArgumentPromotionPass
from hoisting the code to its caller, and this fixed the test failure.

  [1] https://reviews.llvm.org/D148269

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/test_global_func1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/=
testing/selftests/bpf/progs/test_global_func1.c
index b85fc8c423ba..17a9f59bf5f3 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -10,6 +10,8 @@
 static __attribute__ ((noinline))
 int f0(int var, struct __sk_buff *skb)
 {
+	asm volatile ("");
+
 	return skb->len;
 }
=20
--=20
2.34.1

