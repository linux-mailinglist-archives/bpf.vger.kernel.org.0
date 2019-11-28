Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B49A10C33E
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2019 05:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfK1EfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 27 Nov 2019 23:35:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbfK1EfX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Nov 2019 23:35:23 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAS4ZKFb007244
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2019 20:35:22 -0800
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2whcy2rdwf-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2019 20:35:22 -0800
Received: from 2401:db00:12:909f:face:0:3:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 27 Nov 2019 20:35:08 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 285EF760F05; Wed, 27 Nov 2019 20:35:08 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <rdunlap@infradead.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf] bpf: Fix build in minimal configurations
Date:   Wed, 27 Nov 2019 20:35:08 -0800
Message-ID: <20191128043508.2346723-1-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_07:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=526
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=1 impostorscore=0
 mlxscore=0 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280038
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some kconfigs can have BPF enabled without a single valid program type.
In such configurations the build will fail with:
./kernel/bpf/btf.c:3466:1: error: empty enum is invalid

Fix it by adding unused value to the enum.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd5e11881ba3..7d40da240891 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3463,6 +3463,7 @@ enum {
 	__ctx_convert##_id,
 #include <linux/bpf_types.h>
 #undef BPF_PROG_TYPE
+	__ctx_convert_unused, /* to avoid empty enum in extreme .config */
 };
 static u8 bpf_ctx_convert_map[] = {
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
-- 
2.23.0

