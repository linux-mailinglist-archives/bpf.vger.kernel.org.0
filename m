Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85CA48E1BE
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 01:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiANAtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 19:49:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12518 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238527AbiANAtv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 19:49:51 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DN5pfq007500
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 16:49:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=a4A6Fjah4UWUQmOD1w+z90Q7Laf7C8+8lbIEIcha6YI=;
 b=C8Sla4IP1NSzQvlc0J7xGI6xgDpTTMmNaIGYIbLcKNdo1rh0q6Ljj/PIu1p3qzLLZsMG
 tp6cqunTZhaMLdEireOJzVPSkwZqH55+zMuXTy1ir2Xx5HuqdbUpjaWaNOd4/QoCH9Q1
 aDVaAnds16Qu02Qe01pRRSXP5U1hYdywJOE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3djgfkwa39-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 16:49:51 -0800
Received: from twshared4941.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 16:49:27 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 185A98FA3229; Thu, 13 Jan 2022 16:49:16 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     Kenny Yu <kennyyu@fb.com>
Subject: [PATCH v2 bpf-next 2/4] bpf: Add support for sleepable programs in bpf_iter_run_prog
Date:   Thu, 13 Jan 2022 16:48:58 -0800
Message-ID: <20220114004900.3756025-3-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114004900.3756025-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
 <20220114004900.3756025-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OFcRyJsY_gucoTsmxsgRWmyMVuK7wvL2
X-Proofpoint-GUID: OFcRyJsY_gucoTsmxsgRWmyMVuK7wvL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=936
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The next patch adds the ability to create sleepable bpf iterator programs=
.
This changes `bpf_iter_run_prog` to use the appropriate synchronization f=
or
sleepable bpf programs. With sleepable bpf iterator programs, we can no
longer use `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
to protect the bpf program.

Signed-off-by: Kenny Yu <kennyyu@fb.com>
---
 kernel/bpf/bpf_iter.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b7aef5b3416d..d814ca6454af 100644
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
+	if (prog->aux->sleepable) {
+		rcu_read_lock_trace();
+		migrate_disable();
+		might_fault();
+	} else {
+		rcu_read_lock();
+		migrate_disable();
+	}
 	ret =3D bpf_prog_run(prog, ctx);
 	migrate_enable();
-	rcu_read_unlock();
+	if (prog->aux->sleepable)
+		rcu_read_unlock_trace();
+	else
+		rcu_read_unlock();
=20
 	/* bpf program can only return 0 or 1:
 	 *  0 : okay
--=20
2.30.2

