Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A645B0B6
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhKXA3M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:29:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46510 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238874AbhKXA3L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:29:11 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf8rV002872
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:26:03 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgx62wgtg-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:26:02 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:25:55 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 81983A666A63; Tue, 23 Nov 2021 16:23:29 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 01/13] tools/resolve_btf_ids: close ELF file on error
Date:   Tue, 23 Nov 2021 16:23:13 -0800
Message-ID: <20211124002325.1737739-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: IWp-LYqaxvA7pbNHS5okbshfyNMlxQ0T
X-Proofpoint-ORIG-GUID: IWp-LYqaxvA7pbNHS5okbshfyNMlxQ0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=832
 suspectscore=0 bulkscore=0 adultscore=2 spamscore=0 clxscore=1034
 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix one case where we don't do explicit clean up.

Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in ELF object")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/resolve_btfids/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index a59cb0ee609c..e9e6166c3f28 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -167,7 +167,7 @@ static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
 	return NULL;
 }
 
-static struct btf_id*
+static struct btf_id *
 btf_id__add(struct rb_root *root, char *name, bool unique)
 {
 	struct rb_node **p = &root->rb_node;
@@ -730,7 +730,8 @@ int main(int argc, const char **argv)
 	if (obj.efile.idlist_shndx == -1 ||
 	    obj.efile.symbols_shndx == -1) {
 		pr_debug("Cannot find .BTF_ids or symbols sections, nothing to do\n");
-		return 0;
+		err = 0;
+		goto out;
 	}
 
 	if (symbols_collect(&obj))
-- 
2.30.2

