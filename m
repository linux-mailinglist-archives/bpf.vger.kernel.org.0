Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC304375FC2
	for <lists+bpf@lfdr.de>; Fri,  7 May 2021 07:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhEGFm1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 7 May 2021 01:42:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230499AbhEGFm0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 May 2021 01:42:26 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1475Y4IJ024570
        for <bpf@vger.kernel.org>; Thu, 6 May 2021 22:41:27 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38css519w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 May 2021 22:41:27 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 6 May 2021 22:41:26 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 09A202ED7617; Thu,  6 May 2021 22:41:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [RFC PATCH bpf-next 1/7] bpftool: strip const/volatile/restrict modifiers from .bss and .data vars
Date:   Thu, 6 May 2021 22:41:13 -0700
Message-ID: <20210507054119.270888-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210507054119.270888-1-andrii@kernel.org>
References: <20210507054119.270888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: loyHPorawXLh8T6lGIoo0gXj3UgoJqnk
X-Proofpoint-ORIG-GUID: loyHPorawXLh8T6lGIoo0gXj3UgoJqnk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_01:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=746 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105070041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to .rodata, strip any const/volatile/restrict modifiers when
generating BPF skeleton. They are not helpful and actually just get in the way.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 31ade77f5ef8..440a2fcb6441 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -106,8 +106,10 @@ static int codegen_datasec_def(struct bpf_object *obj,
 
 	if (strcmp(sec_name, ".data") == 0) {
 		sec_ident = "data";
+		strip_mods = true;
 	} else if (strcmp(sec_name, ".bss") == 0) {
 		sec_ident = "bss";
+		strip_mods = true;
 	} else if (strcmp(sec_name, ".rodata") == 0) {
 		sec_ident = "rodata";
 		strip_mods = true;
-- 
2.30.2

