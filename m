Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920FD2E350
	for <lists+bpf@lfdr.de>; Wed, 29 May 2019 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfE2Rg2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 13:36:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbfE2Rg1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 May 2019 13:36:27 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4THRaQ6007037
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 10:36:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=6OtO2mfukcbM3YQrPaHn8M0ShFkCEjsVLlqv/pOP718=;
 b=MC7tvPdHBITRcrT7+DXRF5X0EJAeuuyHcQorN8obthjDstHeFzTOhDfbpSI6YIfaNReB
 PuEYZrTxEDgK3SjGV/bF6L1VoPxqhb+3cVLHjtIsnz5ENBzgfnyduYtZ04opt58LfwqK
 SE5ey1n1p0ij0JE/qlx3YvtU83Y42xleeqo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ssx3ar4jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 10:36:27 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 29 May 2019 10:36:26 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id B8B338617AE; Wed, 29 May 2019 10:36:25 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 5/9] libbpf: fix error code returned on corrupted ELF
Date:   Wed, 29 May 2019 10:36:07 -0700
Message-ID: <20190529173611.4012579-6-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529173611.4012579-1-andriin@fb.com>
References: <20190529173611.4012579-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=827 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290114
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All of libbpf errors are negative, except this one. Fix it.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e3c0144e454f..c972fa10271f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1221,7 +1221,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
 
 	if (!obj->efile.strtabidx || obj->efile.strtabidx >= idx) {
 		pr_warning("Corrupted ELF file: index of strtab invalid\n");
-		return LIBBPF_ERRNO__FORMAT;
+		return -LIBBPF_ERRNO__FORMAT;
 	}
 	if (btf_data) {
 		obj->btf = btf__new(btf_data->d_buf, btf_data->d_size);
-- 
2.17.1

