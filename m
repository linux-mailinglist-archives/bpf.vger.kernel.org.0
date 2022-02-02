Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990864A7B5E
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiBBW7j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Feb 2022 17:59:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35122 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347968AbiBBW7j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 17:59:39 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212LxYSP028171
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 14:59:38 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dyrahvqf5-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 14:59:38 -0800
Received: from twshared1259.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:59:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 45497103F6E69; Wed,  2 Feb 2022 14:59:28 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/6] selftests/bpf: remove usage of deprecated feature probing APIs
Date:   Wed, 2 Feb 2022 14:59:14 -0800
Message-ID: <20220202225916.3313522-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202225916.3313522-1-andrii@kernel.org>
References: <20220202225916.3313522-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: B1ycxOSFXm6qLUFswygn-RsBwzm81kmB
X-Proofpoint-ORIG-GUID: B1ycxOSFXm6qLUFswygn-RsBwzm81kmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=959 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to libbpf_probe_*() APIs instead of the deprecated ones.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_maps.c     | 2 +-
 tools/testing/selftests/bpf/test_verifier.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 50f7e74ca0b9..cbebfaa7c1e8 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -738,7 +738,7 @@ static void test_sockmap(unsigned int tasks, void *data)
 			    sizeof(key), sizeof(value),
 			    6, NULL);
 	if (fd < 0) {
-		if (!bpf_probe_map_type(BPF_MAP_TYPE_SOCKMAP, 0)) {
+		if (!libbpf_probe_bpf_map_type(BPF_MAP_TYPE_SOCKMAP, NULL)) {
 			printf("%s SKIP (unsupported map type BPF_MAP_TYPE_SOCKMAP)\n",
 			       __func__);
 			skips++;
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 29bbaa58233c..c73fbada5e67 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -456,7 +456,7 @@ static int probe_filter_length(const struct bpf_insn *fp)
 
 static bool skip_unsupported_map(enum bpf_map_type map_type)
 {
-	if (!bpf_probe_map_type(map_type, 0)) {
+	if (!libbpf_probe_bpf_map_type(map_type, NULL)) {
 		printf("SKIP (unsupported map type %d)\n", map_type);
 		skips++;
 		return true;
@@ -1176,7 +1176,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	 * bpf_probe_prog_type won't give correct answer
 	 */
 	if (fd_prog < 0 && prog_type != BPF_PROG_TYPE_TRACING &&
-	    !bpf_probe_prog_type(prog_type, 0)) {
+	    !libbpf_probe_bpf_prog_type(prog_type, NULL)) {
 		printf("SKIP (unsupported program type %d)\n", prog_type);
 		skips++;
 		goto close_fds;
-- 
2.30.2

