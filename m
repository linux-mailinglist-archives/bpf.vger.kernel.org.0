Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA13197A9
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 02:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBLBA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 20:00:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34238 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229475AbhBLBA0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Feb 2021 20:00:26 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11C0nNvN023571
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 16:59:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=6wmJq01BHbp8Akem50feQ4pCu54BWe3qPm1oXXfAhgY=;
 b=OesEhf34xeRTVVdQ8ivhgd90v4aM9YugK7atK0HJhYWkbNLaktHRcYqTXa+zj58BVTkW
 4wN1LOFxX8IQOkwLDC7dmwuUviEu+sCT4BbcVtjYKInRNhpdJ86tHREZiTrp9LmRgpXb
 +szt+ILIgI8ASXqu+ihCdp0Y1EOy4uQwnTo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36n9nmjavy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 16:59:44 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 11 Feb 2021 16:59:37 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2D6093704F44; Thu, 11 Feb 2021 16:59:26 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <syzbot+580f4f2a272e452d55cb@syzkaller.appspotmail.com>
Subject: [PATCH bpf] bpf: fix an unitialized value in bpf_iter
Date:   Thu, 11 Feb 2021 16:59:26 -0800
Message-ID: <20210212005926.2875002-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 mlxlogscore=625 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
cached btf_id in struct bpf_iter_target_info so later on
if it can be checked cheaply compared to checking registered names.

syzbot found a bug that uninitialized value may occur to
bpf_iter_target_info->btf_id. This is because we allocated
bpf_iter_target_info structure with kmalloc and never initialized
field btf_id afterwards. This uninitialized btf_id is typically
compared to a u32 bpf program func proto btf_id, and the chance
of being equal is extremely slim.

This patch fixed the issue by using kzalloc which will also
prevent future likely instances due to adding new fields.

Reported-by: syzbot+580f4f2a272e452d55cb@syzkaller.appspotmail.com
Fixes: 15d83c4d7cef ("bpf: Allow loading of a bpf_iter program")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/bpf_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 5454161407f1..a0d9eade9c80 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -287,7 +287,7 @@ int bpf_iter_reg_target(const struct bpf_iter_reg *re=
g_info)
 {
 	struct bpf_iter_target_info *tinfo;
=20
-	tinfo =3D kmalloc(sizeof(*tinfo), GFP_KERNEL);
+	tinfo =3D kzalloc(sizeof(*tinfo), GFP_KERNEL);
 	if (!tinfo)
 		return -ENOMEM;
=20
--=20
2.24.1

