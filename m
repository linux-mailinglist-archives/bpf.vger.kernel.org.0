Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD260BC23
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiJXV1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 17:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiJXV1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 17:27:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7373FD5C
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 12:33:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OD4Hrr005853;
        Mon, 24 Oct 2022 14:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=9cpMH1m71ldzuy2BaEQjqqU6L77oI7b+JOdZo24w2Dc=;
 b=IYWi67phW+cF/qyHCo1DSj+RazrFJvoJuthR899STDv1WDRK1U+QJ01vmJzOgUDQ3THW
 Q3RuaY+qw1sD699X7wkHdcmImC+7khVc2WbSJ+UZnhCIIeuXWr9qRsspSlYPa/h8Z4fr
 fDJt+zlBznaGMIvwR78i22bUlBEGY7zJJIVxOsm5V2mo6ocWDOS+ZscAGW65xS0qjqLU
 IXs7z8M/JMe+idfh66Q/QN+yh3euTTsYpgZggwJDoAqzBAMxSfh8U0fNgOL8DbQKDvRR
 qlHRAoYc6qYyNCXvbavrWhVFHX2NUGndlXIPUUEoXu4fLaOSCJlkp9fI6jkTP3HwnkRY oQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xdurt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 14:38:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OE6EBn017396;
        Mon, 24 Oct 2022 14:38:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3wp9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 14:38:34 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29OEcXb1025436;
        Mon, 24 Oct 2022 14:38:33 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-174-236.vpn.oracle.com [10.175.174.236])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kc6y3wp8n-1;
        Mon, 24 Oct 2022 14:38:33 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, jolsa@kernel.org
Cc:     acme@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf] libbpf: btf dedup identical struct test needs check for nested structs/arrays
Date:   Mon, 24 Oct 2022 15:38:29 +0100
Message-Id: <1666622309-22289-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210240089
X-Proofpoint-GUID: 8KfYJZiY3NtOnvpv54_tQUXP16-jspRO
X-Proofpoint-ORIG-GUID: 8KfYJZiY3NtOnvpv54_tQUXP16-jspRO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When examining module BTF, it is common to see core kernel structures
such as sk_buff, net_device duplicated in the module.  After adding
debug messaging to BTF it turned out that much of the problem
was down to the identical struct test failing during deduplication;
sometimes the compiler adds identical structs.  However
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
ids for the above array member.   A similar problem (though not
observed) could occur for struct-in-struct.

The solution is to make the "identical struct" test check members
not just for matching ids, but to also check if they in turn are
identical structs or arrays.

The results of doing this are quite dramatic (for some modules
at least); I see the number of type ids drop from around 10000
to just over 1000 in one module for example.

For testing use latest pahole or apply [1], otherwise dedups
can fail for the reasons described there.

Also fix return type of btf_dedup_identical_arrays() as
suggested by Andrii to match boolean return type used
elsewhere.

Fixes: efdd3eb8015e ("libbpf: Accommodate DWARF/compiler bug with duplicated structs")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

[1] https://lore.kernel.org/bpf/1666364523-9648-1-git-send-email-alan.maguire
---
 tools/lib/bpf/btf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d88647d..675a0df 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3887,14 +3887,14 @@ static inline __u16 btf_fwd_kind(struct btf_type *t)
 }
 
 /* Check if given two types are identical ARRAY definitions */
-static int btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
+static bool btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
 {
 	struct btf_type *t1, *t2;
 
 	t1 = btf_type_by_id(d->btf, id1);
 	t2 = btf_type_by_id(d->btf, id2);
 	if (!btf_is_array(t1) || !btf_is_array(t2))
-		return 0;
+		return false;
 
 	return btf_equal_array(t1, t2);
 }
@@ -3918,7 +3918,9 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
 	m1 = btf_members(t1);
 	m2 = btf_members(t2);
 	for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
-		if (m1->type != m2->type)
+		if (m1->type != m2->type &&
+		    !btf_dedup_identical_arrays(d, m1->type, m2->type) &&
+		    !btf_dedup_identical_structs(d, m1->type, m2->type))
 			return false;
 	}
 	return true;
-- 
1.8.3.1

