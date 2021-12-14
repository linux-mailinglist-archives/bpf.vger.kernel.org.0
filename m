Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7474739FE
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 02:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbhLNBBA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 13 Dec 2021 20:01:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29096 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhLNBAk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 20:00:40 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BDMdLsj007582
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 17:00:39 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cx9rpuhys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 17:00:39 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 17:00:38 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5AF9FD024071; Mon, 13 Dec 2021 17:00:36 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: fix potential uninit memory read
Date:   Mon, 13 Dec 2021 17:00:32 -0800
Message-ID: <20211214010032.3843804-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: K-8HWyjGv9gJJL8d9wCQ0N9zOmIhMiW7
X-Proofpoint-GUID: K-8HWyjGv9gJJL8d9wCQ0N9zOmIhMiW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_14,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxlogscore=995 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112140001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In case of BPF_CORE_TYPE_ID_LOCAL we fill out target result explicitly.
But targ_res itself isn't initialized in such a case, and subsequent
call to bpf_core_patch_insn() might read uninitialized field (like
fail_memsz_adjust in this case). So ensure that targ_res is
zero-initialized for BPF_CORE_TYPE_ID_LOCAL case.

This was reported by Coverity static analyzer.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/relo_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index c770483b4c36..910865e29edc 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1223,6 +1223,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 	/* TYPE_ID_LOCAL relo is special and doesn't need candidate search */
 	if (relo->kind == BPF_CORE_TYPE_ID_LOCAL) {
 		/* bpf_insn's imm value could get out of sync during linking */
+		memset(&targ_res, 0, sizeof(targ_res));
 		targ_res.validate = false;
 		targ_res.poison = false;
 		targ_res.orig_val = local_spec->root_type_id;
-- 
2.30.2

