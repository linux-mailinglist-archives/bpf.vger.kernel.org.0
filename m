Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4365B4A7B67
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 00:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbiBBXCV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Feb 2022 18:02:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47412 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233672AbiBBXCU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 18:02:20 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212LfW1x025982
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 15:02:20 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dyjxu635q-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 15:02:20 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:02:19 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3AF52103F6E5F; Wed,  2 Feb 2022 14:59:26 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/6] bpftool: fix uninit variable compilation warning
Date:   Wed, 2 Feb 2022 14:59:13 -0800
Message-ID: <20220202225916.3313522-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202225916.3313522-1-andrii@kernel.org>
References: <20220202225916.3313522-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KPmg_EQk6S2M9fSrvtJVS4sgYYltH2mj
X-Proofpoint-ORIG-GUID: KPmg_EQk6S2M9fSrvtJVS4sgYYltH2mj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=855 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Newer GCC complains about capturing the address of unitialized variable.
While there is nothing wrong with the code (the variable is filled out
by the kernel), initialize the variable anyway to make compiler happy.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 111dff809c7b..606743c6db41 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -310,7 +310,7 @@ void get_prog_full_name(const struct bpf_prog_info *prog_info, int prog_fd,
 {
 	const char *prog_name = prog_info->name;
 	const struct btf_type *func_type;
-	const struct bpf_func_info finfo;
+	const struct bpf_func_info finfo = {};
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	struct btf *prog_btf = NULL;
-- 
2.30.2

