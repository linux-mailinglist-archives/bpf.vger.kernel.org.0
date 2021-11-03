Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6958644472E
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 18:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKCRfY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 13:35:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6900 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhKCRfW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 13:35:22 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3H615k010062
        for <bpf@vger.kernel.org>; Wed, 3 Nov 2021 10:32:45 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3dch6umy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 10:32:45 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 10:32:43 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A0FC77D160C0; Wed,  3 Nov 2021 10:32:42 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 bpf-next 2/5] libbpf: improve sanity checking during BTF fix up
Date:   Wed, 3 Nov 2021 10:32:10 -0700
Message-ID: <20211103173213.1376990-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103173213.1376990-1-andrii@kernel.org>
References: <20211103173213.1376990-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: nVRf7xMkYB-kaGyWGWRz358LjICxzDdF
X-Proofpoint-ORIG-GUID: nVRf7xMkYB-kaGyWGWRz358LjICxzDdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 clxscore=1034 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=953 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If BTF is corrupted DATASEC's variable type ID might be incorrect.
Prevent this easy to detect situation with extra NULL check.
Reported by oss-fuzz project.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 71f5a009010a..f836a1936597 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2752,13 +2752,12 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 
 	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
 		t_var = btf__type_by_id(btf, vsi->type);
-		var = btf_var(t_var);
-
-		if (!btf_is_var(t_var)) {
+		if (!t_var || !btf_is_var(t_var)) {
 			pr_debug("Non-VAR type seen in section %s\n", name);
 			return -EINVAL;
 		}
 
+		var = btf_var(t_var);
 		if (var->linkage == BTF_VAR_STATIC)
 			continue;
 
-- 
2.30.2

