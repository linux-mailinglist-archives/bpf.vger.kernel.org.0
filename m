Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BEC6EB4E
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2019 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbfGSTqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jul 2019 15:46:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2422 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733213AbfGSTqL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jul 2019 15:46:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6JJhu4x006179
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 12:46:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=HIxAqrcQZfXlU3NBG8+yIj8uOxQutH2ujlY6n2PlIsU=;
 b=XqeFCMGgAJOjPl/J4I3w/LiKUUoL9wjossjALqtps/fsAJxVeqR5b/s25orskNT9AWYQ
 I0GIGv4V1Xp46S0gRBwhAJpxh9u3nbq/CCj/Uc4e8319ruXYz4STYENah7BoHV4KvdfZ
 aWJPYn7nIqifoCZNuw4qDOOyBLUfSfwz1H0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tubxdhvwj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 12:46:10 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 19 Jul 2019 12:46:09 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 9641E86161E; Fri, 19 Jul 2019 12:46:07 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <rdna@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf] libbpf: sanitize VAR to conservative 1-byte INT
Date:   Fri, 19 Jul 2019 12:46:03 -0700
Message-ID: <20190719194603.2704713-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=721 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907190212
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If VAR in non-sanitized BTF was size less than 4, converting such VAR
into an INT with size=4 will cause BTF validation failure due to
violationg of STRUCT (into which DATASEC was converted) member size.
Fix by conservatively using size=1.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 87168f21ef43..d8833ff6c4a1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1377,8 +1377,13 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj)
 		if (!has_datasec && kind == BTF_KIND_VAR) {
 			/* replace VAR with INT */
 			t->info = BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
-			t->size = sizeof(int);
-			*(int *)(t+1) = BTF_INT_ENC(0, 0, 32);
+			/*
+			 * using size = 1 is the safest choice, 4 will be too
+			 * big and cause kernel BTF validation failure if
+			 * original variable took less than 4 bytes
+			 */
+			t->size = 1;
+			*(int *)(t+1) = BTF_INT_ENC(0, 0, 8);
 		} else if (!has_datasec && kind == BTF_KIND_DATASEC) {
 			/* replace DATASEC with STRUCT */
 			struct btf_var_secinfo *v = (void *)(t + 1);
-- 
2.17.1

