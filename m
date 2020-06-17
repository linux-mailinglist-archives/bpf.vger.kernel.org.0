Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC01FD644
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFQUol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 16:44:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38506 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbgFQUok (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Jun 2020 16:44:40 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HKZhFW024268
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:44:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vyKWXHfNkpJBknpAg0rWdI9c4pvECRYKMHHXxlwHqSI=;
 b=A9qnOG/XYFr1qk+k2jxhuQGHWq9SwYzy6X6BdVn9AvdHBhLr6SseU64f3vwJaJDfKt/B
 M9qirC84Ck56uaxsmckEbbBJ8TQmn53AEzDeMknKcHSHP9wfhpgpXX73rOkbrTOnFOd7
 WJoHCzvuSwgqRZTFrCQXT8aWiwC5pIGOdUY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q653fun3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:44:39 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 13:44:15 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id AC8F83700B15; Wed, 17 Jun 2020 13:44:11 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/6] bpf: Introduce btf_find_by_name_kind_next()
Date:   Wed, 17 Jun 2020 13:43:43 -0700
Message-ID: <077d491bfa92c2a16f0843c2b0df0773ab8496ee.1592426215.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1592426215.git.rdna@fb.com>
References: <cover.1592426215.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_11:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 suspectscore=13
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=726 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170154
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce btf_find_by_name_kind_next() function to find btf_id by name
and kind starting from specified start_id to reuse the function in
finding duplicates (e.g. structs with same name) in btf.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 include/linux/btf.h | 2 ++
 kernel/bpf/btf.c    | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 5c1ea99b480f..69e017594298 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -56,6 +56,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const=
 struct btf_type *s,
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd);
+s32 btf_find_by_name_kind_next(const struct btf *btf, const char *name, =
u8 kind,
+			       u32 start_id);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
 					       u32 id, u32 *res_id);
 const struct btf_type *btf_type_resolve_ptr(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3eb804618a53..e5c5305e859c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -383,12 +383,18 @@ static bool btf_type_is_datasec(const struct btf_ty=
pe *t)
 }
=20
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
+{
+	return btf_find_by_name_kind_next(btf, name, kind, 1);
+}
+
+s32 btf_find_by_name_kind_next(const struct btf *btf, const char *name, =
u8 kind,
+			       u32 start_id)
 {
 	const struct btf_type *t;
 	const char *tname;
 	u32 i;
=20
-	for (i =3D 1; i <=3D btf->nr_types; i++) {
+	for (i =3D start_id; i <=3D btf->nr_types; i++) {
 		t =3D btf->types[i];
 		if (BTF_INFO_KIND(t->info) !=3D kind)
 			continue;
--=20
2.24.1

