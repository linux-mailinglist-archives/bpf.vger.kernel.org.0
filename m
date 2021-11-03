Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7526F443A45
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhKCAMr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 Nov 2021 20:12:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232299AbhKCAMq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 20:12:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A2LbUmG020890
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 17:10:10 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c3ddbh03j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 17:10:10 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 17:10:09 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1114C7C14DAF; Tue,  2 Nov 2021 17:10:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/5] libbpf: improve sanity checking during BTF fix up
Date:   Tue, 2 Nov 2021 17:10:00 -0700
Message-ID: <20211103001003.398812-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103001003.398812-1-andrii@kernel.org>
References: <20211103001003.398812-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: zc8dsdyoHd23N9GX-n18KP2n6tKMYyrd
X-Proofpoint-ORIG-GUID: zc8dsdyoHd23N9GX-n18KP2n6tKMYyrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxlogscore=858 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If BTF is corrupted DATASEC's variable type ID might be incorrect.
Prevent this easy to detect situation with extra NULL check.
Reported by oss-fuzz project.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 71f5a009010a..4537ce6d54ce 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2754,7 +2754,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 		t_var = btf__type_by_id(btf, vsi->type);
 		var = btf_var(t_var);
 
-		if (!btf_is_var(t_var)) {
+		if (!t_var || !btf_is_var(t_var)) {
 			pr_debug("Non-VAR type seen in section %s\n", name);
 			return -EINVAL;
 		}
-- 
2.30.2

