Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79CE1174BFF
	for <lists+bpf@lfdr.de>; Sun,  1 Mar 2020 07:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgCAGYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Mar 2020 01:24:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23844 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgCAGYO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 1 Mar 2020 01:24:14 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02164iIc030148
        for <bpf@vger.kernel.org>; Sat, 29 Feb 2020 22:04:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=A015FQVNHFI0fB9p/6VL5WadcEbih2TacIlvEoZ3t6g=;
 b=F7rtUl6eFxdwfBcUQS3IUYyDRLITIuh4RckhUWAZoSAdMHvNgMu6Zr4cxQhuEfwWUGOK
 UeEfrilTPSShUOhOLdQTdHcHgkDq/PFEfykYTKm9zflzLBubgCkDToEP5WgaobTfF9l0
 NPXrdsN9zIgdEjVmvKy3JpifjTlXoZ57oWA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yfpbu2tem-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 29 Feb 2020 22:04:44 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 29 Feb 2020 22:04:37 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id DC9AE2EC2CFD; Sat, 29 Feb 2020 22:04:24 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/3] libbpf: assume unsigned values for BTF_KIND_ENUM
Date:   Sat, 29 Feb 2020 22:02:36 -0800
Message-ID: <20200301060237.2774675-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200301060237.2774675-1-andriin@fb.com>
References: <20200301060237.2774675-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-01_01:2020-02-28,2020-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=8 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003010049
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, BTF_KIND_ENUM type doesn't record whether enum values should be
interpreted as signed or unsigned. In Linux, most enums are unsigned, though,
so interpreting them as unsigned matches real world better.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf_dump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bd09ed1710f1..0d43d9bb821b 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -916,13 +916,13 @@ static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
 			/* enumerators share namespace with typedef idents */
 			dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
 			if (dup_cnt > 1) {
-				btf_dump_printf(d, "\n%s%s___%zu = %d,",
+				btf_dump_printf(d, "\n%s%s___%zu = %u,",
 						pfx(lvl + 1), name, dup_cnt,
-						(__s32)v->val);
+						(__u32)v->val);
 			} else {
-				btf_dump_printf(d, "\n%s%s = %d,",
+				btf_dump_printf(d, "\n%s%s = %u,",
 						pfx(lvl + 1), name,
-						(__s32)v->val);
+						(__u32)v->val);
 			}
 		}
 		btf_dump_printf(d, "\n%s}", pfx(lvl));
-- 
2.17.1

