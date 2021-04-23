Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE2369A75
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbhDWSyo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Apr 2021 14:54:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13928 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243453AbhDWSyl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Apr 2021 14:54:41 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NIPPGF032277
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 11:54:04 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3839usrt90-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 11:54:03 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:54:02 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 4A33E2ED5CA8; Fri, 23 Apr 2021 11:54:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 1/6] bpftool: strip const/volatile/restrict modifiers from .bss and .data vars
Date:   Fri, 23 Apr 2021 11:53:52 -0700
Message-ID: <20210423185357.1992756-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423185357.1992756-1-andrii@kernel.org>
References: <20210423185357.1992756-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DJe2-9yjOWUQWRGYXZrqR2sPzdhp-w_I
X-Proofpoint-ORIG-GUID: DJe2-9yjOWUQWRGYXZrqR2sPzdhp-w_I
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_07:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxlogscore=784 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104230121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to .rodata, strip any const/volatile/restrict modifiers when
generating BPF skeleton. They are not helpful and actually just get in the way.

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

