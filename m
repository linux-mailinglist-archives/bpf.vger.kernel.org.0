Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA443A6CE
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhJYWsK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Oct 2021 18:48:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234285AbhJYWsJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:48:09 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMiW8i002245
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:47 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4fp8g6c-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:47 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:45:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2ABC074E6641; Mon, 25 Oct 2021 15:45:35 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/4] libbpf: fix off-by-one bug in bpf_core_apply_relo()
Date:   Mon, 25 Oct 2021 15:45:28 -0700
Message-ID: <20211025224531.1088894-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025224531.1088894-1-andrii@kernel.org>
References: <20211025224531.1088894-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 5fBzNyeWuiqtB0I-ZRifzcO9RZqjW8y6
X-Proofpoint-GUID: 5fBzNyeWuiqtB0I-ZRifzcO9RZqjW8y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=850
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110250128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix instruction index validity check which has off-by-one error.

Fixes: 3ee4f5335511 ("libbpf: Split bpf_core_apply_relo() into bpf_program independent helper.")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 604abe00785f..e27a249d46fb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5405,7 +5405,7 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
 	 * relocated, so it's enough to just subtract in-section offset
 	 */
 	insn_idx = insn_idx - prog->sec_insn_off;
-	if (insn_idx > prog->insns_cnt)
+	if (insn_idx >= prog->insns_cnt)
 		return -EINVAL;
 	insn = &prog->insns[insn_idx];
 
-- 
2.30.2

