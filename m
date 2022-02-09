Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D534AEB06
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 08:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiBIHa3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 9 Feb 2022 02:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiBIHa3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 02:30:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C25EC05CB80
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 23:30:33 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218LvOBA027881
        for <bpf@vger.kernel.org>; Tue, 8 Feb 2022 22:39:26 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3n0c7g6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 22:39:25 -0800
Received: from twshared1259.42.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 22:39:25 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0552310884D89; Tue,  8 Feb 2022 22:39:10 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: fix compilation warning due to mismatched printf format
Date:   Tue, 8 Feb 2022 22:39:09 -0800
Message-ID: <20220209063909.1268319-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3TsX_nek3aiilxa4W35y78FBFNe3GBTd
X-Proofpoint-GUID: 3TsX_nek3aiilxa4W35y78FBFNe3GBTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_03,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=576
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090046
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On ppc64le architecture __s64 is long int and requires %ld. Cast to
ssize_t and use %zd to avoid architecture-specific specifiers.

Fixes: 4172843ed4a3 ("libbpf: Fix signedness bug in btf_dump_array_data()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 55aed9e398c3..07ebe70d3a30 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1869,7 +1869,8 @@ static int btf_dump_array_data(struct btf_dump *d,
 	elem_type = skip_mods_and_typedefs(d->btf, elem_type_id, NULL);
 	elem_size = btf__resolve_size(d->btf, elem_type_id);
 	if (elem_size <= 0) {
-		pr_warn("unexpected elem size %lld for array type [%u]\n", elem_size, id);
+		pr_warn("unexpected elem size %zd for array type [%u]\n",
+			(ssize_t)elem_size, id);
 		return -EINVAL;
 	}
 
-- 
2.30.2

