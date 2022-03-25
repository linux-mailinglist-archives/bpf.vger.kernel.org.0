Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30E4E7CE2
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 01:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiCYUHl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiCYUHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 16:07:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A65675B
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 13:03:08 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PIK36s000998
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 13:03:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=VpS7Bxj3FYl4GYhW1xbaRfom0CaW9Zw3HU4HdCcL0MY=;
 b=rMy1GC2kkC8bhDxHmAoCSiqWeFmdobXMXdYXZDiDFUgHYFSxTJgID7zbrPvCqEcW+s+e
 xIA01Kt3w6SmZhky39p+aan+cqZjbN8NAqNIMbrTbsovBjV7/TMoZxaybnlGy3QOS6F+
 VN7ip4Di5/PmyMzzcASbc5KFm3fB0IvIu8E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f1jwsgpmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 13:03:08 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 13:03:07 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 11AA181C2F6D; Fri, 25 Mar 2022 13:03:04 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix clang compilation errors
Date:   Fri, 25 Mar 2022 13:03:04 -0700
Message-ID: <20220325200304.2915588-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YIg4NvCm1kmyO-GKEfrzsKilAAnPnLpF
X-Proofpoint-ORIG-GUID: YIg4NvCm1kmyO-GKEfrzsKilAAnPnLpF
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_06,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

llvm upstream patch ([1]) added to issue warning for code like
  void test() {
    int j =3D 0;
    for (int i =3D 0; i < 1000; i++)
            j++;
    return;
  }

This triggered several errors in selftests/bpf build since
compilation flag -Werror is used.
  ...
  test_lpm_map.c:212:15: error: variable 'n_matches' set but not used [-Wer=
ror,-Wunused-but-set-variable]
        size_t i, j, n_matches, n_matches_after_delete, n_nodes, n_lookups;
                     ^
  test_lpm_map.c:212:26: error: variable 'n_matches_after_delete' set but n=
ot used [-Werror,-Wunused-but-set-variable]
        size_t i, j, n_matches, n_matches_after_delete, n_nodes, n_lookups;
                                ^
  ...
  prog_tests/get_stack_raw_tp.c:32:15: error: variable 'cnt' set but not us=
ed [-Werror,-Wunused-but-set-variable]
        static __u64 cnt;
                     ^
  ...

  For test_lpm_map.c, 'n_matches'/'n_matches_after_delete' are changed to b=
e volatile
  in order to silent the warning. I didn't remove these two declarations si=
nce
  they are referenced in a commented code which might be used by people in =
certain
  cases. For get_stack_raw_tp.c, the variable 'cnt' is removed.

  [1] https://reviews.llvm.org/D122271

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c | 3 ---
 tools/testing/selftests/bpf/test_lpm_map.c                | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/to=
ols/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index e834a01de16a..16048978a1ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -29,11 +29,8 @@ static void get_stack_print_output(void *ctx, int cpu, v=
oid *data, __u32 size)
 	 */
 	struct get_stack_trace_t e;
 	int i, num_stack;
-	static __u64 cnt;
 	struct ksym *ks;
=20
-	cnt++;
-
 	memset(&e, 0, sizeof(e));
 	memcpy(&e, data, size <=3D sizeof(e) ? size : sizeof(e));
=20
diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/sel=
ftests/bpf/test_lpm_map.c
index baa3e3ecae82..aa294612e0a7 100644
--- a/tools/testing/selftests/bpf/test_lpm_map.c
+++ b/tools/testing/selftests/bpf/test_lpm_map.c
@@ -209,7 +209,8 @@ static void test_lpm_order(void)
 static void test_lpm_map(int keysize)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_NO_PREALLOC);
-	size_t i, j, n_matches, n_matches_after_delete, n_nodes, n_lookups;
+	volatile size_t n_matches, n_matches_after_delete;
+	size_t i, j, n_nodes, n_lookups;
 	struct tlpm_node *t, *list =3D NULL;
 	struct bpf_lpm_trie_key *key;
 	uint8_t *data, *value;
--=20
2.30.2

