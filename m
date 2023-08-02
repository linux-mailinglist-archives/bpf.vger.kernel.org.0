Return-Path: <bpf+bounces-6687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467776C726
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 09:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F46328130D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688744C8F;
	Wed,  2 Aug 2023 07:40:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6C1859
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 07:40:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF754682
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 00:39:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371KxjfD026106;
	Wed, 2 Aug 2023 07:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=J8Ao0y3j5TNBhCEP/tdsSpJi1XQycCUVNr+X7nMR31E=;
 b=Cbv3f3GuLdJHdTBYa1h2EJHGmzNfU196hP8B08EvTDvmsy0oQgfLFmIsMrcKFLCiubYM
 Hmcz6+uCNeNp1NhKF7tVL22UmJnNxycP1e2+qY9F7f3zJmjAd/iZfU6r4m/SYhCzW9WH
 LgwLxt+J9nNxHZN1Q3fVOhEVyU7FCgqsuXJ4hkSv9whdkDMGjZKOxYI/tUhQaP4jmmJ0
 FHvoYTmgYfDO9gCqzoRzP16wzCeV7uEDoOgMiRW8coVGUH17hrpGClPVl037jEEPH6oK
 xECpf5WiJwvrvy3N02uu2TD7wUazuhSVAwKxGp+AqmvZQUQKUOQO254d+acGnxpX9i7d pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc6nkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 07:39:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3726vnQf000737;
	Wed, 2 Aug 2023 07:39:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7dkbd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 07:39:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3727dAeM015242;
	Wed, 2 Aug 2023 07:39:10 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-85.vpn.oracle.com [10.175.173.85])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s4s7dkbah-1;
	Wed, 02 Aug 2023 07:39:10 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yhs@fb.com, ast@kernel.org, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Colm Harrington <colm.harrington@oracle.com>
Subject: [PATCH v2 bpf] selftests/bpf: fix static assert compilation issue for test_cls_*.c
Date: Wed,  2 Aug 2023 08:39:06 +0100
Message-Id: <20230802073906.3197480-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020067
X-Proofpoint-ORIG-GUID: yBIofNBFqYShNSKu0-0MMBEBdjheNCwL
X-Proofpoint-GUID: yBIofNBFqYShNSKu0-0MMBEBdjheNCwL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")

...was backported to stable trees such as 5.15. The problem is that with older
LLVM/clang (14/15) - which is often used for older kernels - we see compilation
failures in BPF selftests now:

In file included from progs/test_cls_redirect_subprogs.c:2:
progs/test_cls_redirect.c:90:2: error: static assertion expression is not an integral constant expression
        sizeof(flow_ports_t) !=
        ^~~~~~~~~~~~~~~~~~~~~~~
progs/test_cls_redirect.c:91:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
                offsetofend(struct bpf_sock_tuple, ipv4.dport) -
                ^
progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
        (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
         ^
tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
                                 ^
In file included from progs/test_cls_redirect_subprogs.c:2:
progs/test_cls_redirect.c:95:2: error: static assertion expression is not an integral constant expression
        sizeof(flow_ports_t) !=
        ^~~~~~~~~~~~~~~~~~~~~~~
progs/test_cls_redirect.c:96:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
                offsetofend(struct bpf_sock_tuple, ipv6.dport) -
                ^
progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
        (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
         ^
tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
                                 ^
2 errors generated.
make: *** [Makefile:594: tools/testing/selftests/bpf/test_cls_redirect_subprogs.bpf.o] Error 1

The problem is the new offsetof() does not play nice with static asserts.
Given that the context is a static assert (and CO-RE relocation is not
needed at compile time), offsetof() usage can be replaced by restoring
the original offsetof() definition as __builtin_offsetof().

Fixes: bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")
Reported-by: Colm Harrington <colm.harrington@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

---
Changes since v1:

- simplified to restore offsetof() definition in test_cls_redirect.h,
  and added explanatory comment (Yonghong)
---
 tools/testing/selftests/bpf/progs/test_cls_redirect.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
index 76eab0aacba0..233b089d1fba 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
@@ -12,6 +12,15 @@
 #include <linux/ipv6.h>
 #include <linux/udp.h>
 
+/* offsetof() is used in static asserts, and the libbpf-redefined CO-RE
+ * friendly version breaks compilation for older clang versions <= 15
+ * when invoked in a static assert.  Restore original here.
+ */
+#ifdef offsetof
+#undef offsetof
+#define offsetof(type, member) __builtin_offsetof(type, member)
+#endif
+
 struct gre_base_hdr {
 	uint16_t flags;
 	uint16_t protocol;
-- 
2.39.3


