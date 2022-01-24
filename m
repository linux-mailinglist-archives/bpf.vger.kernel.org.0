Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175B24989A6
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbiAXS5g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 13:57:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32404 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344558AbiAXSys (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 13:54:48 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OHViTx019368
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 10:54:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TDgsCBwNGZUO87e8EAoWyKnNI15J9DuFZCAQMRJPj1M=;
 b=WkG8/UALNMbjocKNYx6RvW3AO3nO1DNUhrrY966NjQzSLNgdf2bi/zPSPxSCROdUsHQW
 2n2anf6a1YCFNzJrWRAuhA+W5KDkb2wNTxT0sjZPqfJdtGv0cY3hHtbtC8edc+UgYx1q
 xszT7pxNgmW/9iOJtTgMCR0EpZoZz6I9fRk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dswd8j5cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 10:54:47 -0800
Received: from twshared14140.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:54:47 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id B0F879816156; Mon, 24 Jan 2022 10:54:40 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>,
        <alexei.starovoitov@gmail.com>, <andrii.nakryiko@gmail.com>,
        <phoenix1987@gmail.com>
Subject: [PATCH v7 bpf-next 1/4] bpf: Add support for bpf iterator programs to use sleepable helpers
Date:   Mon, 24 Jan 2022 10:54:00 -0800
Message-ID: <20220124185403.468466-2-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124185403.468466-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220124185403.468466-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: m2BvRcZp_W5NUsUb_iI2JkCUWGPtf8Z5
X-Proofpoint-ORIG-GUID: m2BvRcZp_W5NUsUb_iI2JkCUWGPtf8Z5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=896 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201240124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch allows bpf iterator programs to use sleepable helpers by
changing `bpf_iter_run_prog` to use the appropriate synchronization.
With sleepable bpf iterator programs, we can no longer use
`rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
to protect the bpf program.

Signed-off-by: Kenny Yu <kennyyu@fb.com>
---
 kernel/bpf/bpf_iter.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b7aef5b3416d..110029ede71e 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -5,6 +5,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/rcupdate_trace.h>
=20
 struct bpf_iter_target_info {
 	struct list_head list;
@@ -684,11 +685,20 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *=
ctx)
 {
 	int ret;
=20
-	rcu_read_lock();
-	migrate_disable();
-	ret =3D bpf_prog_run(prog, ctx);
-	migrate_enable();
-	rcu_read_unlock();
+	if (prog->aux->sleepable) {
+		rcu_read_lock_trace();
+		migrate_disable();
+		might_fault();
+		ret =3D bpf_prog_run(prog, ctx);
+		migrate_enable();
+		rcu_read_unlock_trace();
+	} else {
+		rcu_read_lock();
+		migrate_disable();
+		ret =3D bpf_prog_run(prog, ctx);
+		migrate_enable();
+		rcu_read_unlock();
+	}
=20
 	/* bpf program can only return 0 or 1:
 	 *  0 : okay
--=20
2.30.2

