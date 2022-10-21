Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8B6080FE
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJUV4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJUV4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:56:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B542A935E
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:56:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDnp0004052;
        Fri, 21 Oct 2022 21:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=tZQENge+IkjysD8G1y9LQ2uYiI+i16z5vYDWSrdHE2w=;
 b=Yw92WV4nNwxBFX+Bwk6FDUyaP47TdwlNQ3RCEuGs7uvqWs+0r+N7iSoydaMeNA6u1hkl
 Tpe06C3GRS4aa4TlIvuS8POjbvQ+Qa1nmKq5rlZTxZpn9+xEXQ6bzlNnrbmI8nfXwtbW
 NAsEzVL9pK54bYtKJV8xzxpYaYR/EpgTtBfN4eN3VINdqgcKhfh/wwomoFeukgElNzuY
 KsxGflXG/hQ2UcZwGMnqeNKOc4JtVzfzNEm5Md8QFn2HwsiDY3X6sSb+9UnsREj1x1MN
 3yBwrdHP8XTZBVQi97iLW4icE8/ORyG4ZmfuJ7KBR2MGMV9HHatolMZllBCK35TW1R+A Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu0aetb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 21:56:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LKs6aA007178;
        Fri, 21 Oct 2022 21:56:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hre7m3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 21:56:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29LLu8pZ039284;
        Fri, 21 Oct 2022 21:56:09 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-208-221.vpn.oracle.com [10.175.208.221])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8hre7m2e-1;
        Fri, 21 Oct 2022 21:56:08 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, jolsa@kernel.org
Cc:     acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next] libbpf: btf dedup identical struct test needs check for nested structs/arrays
Date:   Fri, 21 Oct 2022 22:56:04 +0100
Message-Id: <1666389364-27963-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210127
X-Proofpoint-ORIG-GUID: hp8A2-8KLJ3ngCNU7W8e3e2Ggg7gl1He
X-Proofpoint-GUID: hp8A2-8KLJ3ngCNU7W8e3e2Ggg7gl1He
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When examining module BTF, we often see core kernel structures
such as sk_buff, net_device duplicated in the module.  After adding
debug messaging to BTF it turned out that much of the problem
was down to the identical struct test failing during deduplication;
sometimes compilation units contain identical structs.  However
it turns out sometimes that type ids of identical struct members
can also differ, even when the containing structs are still identical.

To take an example, for struct sk_buff, debug messaging revealed
that the identical struct matching was failing for the anon
struct "headers"; specifically for the first field:

	__u8       __pkt_type_offset[0]; /*   128     0 */

Looking at the code in BTF deduplication, we have code that guards
against the possibility of identical struct definitions, down to
type ids, and identical array definitions.  However in this case
we have a struct which is being defined twice but does not have
identical type ids since each duplicate struct has separate type
ids for the above array member.  A similar problem (though not
observed) could potentially occur for a struct-in-a-struct.

The solution is to make the "identical struct" test check members
not just for matching ids, but to also check if they in turn are
identical structs or arrays.

The results of doing this are quite dramatic (for some modules
at least); I see the number of type ids drop from around 10000
to just over 1000 in one module for example, and kernel
module types are no longer duplicated.

For testing with latest pahole, applying [1] is required,
otherwise dedups can fail for the reasons described there.

All BTF-related selftests passed with this change.

RFC for bpf-next rather than patch for bpf tree because while
this resolves dedup issues for me using gcc 9 and 11,
these things seem to be quite compiler-sensitive, so would
be good to ensure it works for others too.  Presuming it
does, should probably specify:

Fixes: efdd3eb8015e ("libbpf: Accommodate DWARF/compiler bug with duplicated structs")

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/1666364523-9648-1-git-send-email-alan.maguire@oracle.com/
---
 tools/lib/bpf/btf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d88647d..b7d7f19 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3918,8 +3918,11 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
 	m1 = btf_members(t1);
 	m2 = btf_members(t2);
 	for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
-		if (m1->type != m2->type)
-			return false;
+		if (m1->type == m2->type ||
+		    btf_dedup_identical_structs(d, m1->type, m2->type) ||
+		    btf_dedup_identical_arrays(d, m1->type, m2->type))
+			continue;
+		return false;
 	}
 	return true;
 }
-- 
1.8.3.1

