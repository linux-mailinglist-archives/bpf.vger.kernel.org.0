Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A73231575
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 00:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgG1WSF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 18:18:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42186 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729567AbgG1WSF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Jul 2020 18:18:05 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SMACnc005085
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 15:18:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=khEKn/HofYFeWRLfeujerfad+E4YU6oJE9H+cDFsv5I=;
 b=b0mTCvb4UG1QN9fkenwAvOgs55ra0boerm3XWNvRfxMj5uwQfnR6W2ot6ixCAE/hTC5f
 G6pTyDFzzuO+rHZNnduAEpW6Q3xIVsOomN4DE6RTPfdXvB9XHz7b9ilmXC1ghRkFRLDH
 yuLuwa9gvZ+q9fQvTJV1CQAbleiLe1hVOU8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32j13yq5w9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 15:18:03 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 15:18:02 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 74F2C3704BE1; Tue, 28 Jul 2020 15:18:01 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/2] bpf: add missing newline characters in verifier error messages
Date:   Tue, 28 Jul 2020 15:18:01 -0700
Message-ID: <20200728221801.1090349-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_17:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=13 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007280157
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Newline characters are added in two verifier error messages,
refactored in Commit afbf21dce668 ("bpf: Support readonly/readwrite
buffers in verifier"). This way, they do not mix with
messages afterwards.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 88bb25d08bf8..b6ccfce3bf4c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3069,7 +3069,7 @@ static int __check_buffer_access(struct bpf_verifie=
r_env *env,
 {
 	if (off < 0) {
 		verbose(env,
-			"R%d invalid %s buffer access: off=3D%d, size=3D%d",
+			"R%d invalid %s buffer access: off=3D%d, size=3D%d\n",
 			regno, buf_info, off, size);
 		return -EACCES;
 	}
@@ -3078,7 +3078,7 @@ static int __check_buffer_access(struct bpf_verifie=
r_env *env,
=20
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 		verbose(env,
-			"R%d invalid variable buffer offset: off=3D%d, var_off=3D%s",
+			"R%d invalid variable buffer offset: off=3D%d, var_off=3D%s\n",
 			regno, off, tn_buf);
 		return -EACCES;
 	}
--=20
2.24.1

