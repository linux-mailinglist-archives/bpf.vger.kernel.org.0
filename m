Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C3E201CEC
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392729AbgFSVMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 17:12:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392236AbgFSVMO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 17:12:14 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JL04BP002595
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fpXgEwCakCuARIQE7ovQmXDU3xKPnG0sUwDVa9zG2k8=;
 b=cUmnTmD0rtINlApvRp0a89umlmn1AYD/wkNDVQuYebc+i4HPoNEJE9wxgn6V5L4eZj3J
 9yMwTo4g80z8wc6q3gV5CbFK20DxE+JX2aSq7kmfxVrCesfbrQvqqd8wNBWsRwNcCqL2
 A7ZRktSz8yo5Q7FmlVGuK1lpdJqMbHXBtmQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31s2rcrr1f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:12:13 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 14:12:12 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id AF9613700BAE; Fri, 19 Jun 2020 14:12:08 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 1/5] bpf: Switch btf_parse_vmlinux to btf_find_by_name_kind
Date:   Fri, 19 Jun 2020 14:11:41 -0700
Message-ID: <6e12d5c3e8a3d552925913ef73a695dd1bb27800.1592600985.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 priorityscore=1501 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=827 impostorscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_parse_vmlinux() implements manual search for struct bpf_ctx_convert
since at the time of implementing btf_find_by_name_kind() was not
available.

Later btf_find_by_name_kind() was introduced in 27ae7997a661 ("bpf:
Introduce BPF_PROG_TYPE_STRUCT_OPS"). It provides similar search
functionality and can be leveraged in btf_parse_vmlinux(). Do it.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/btf.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 58c9af1d4808..3eb804618a53 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3591,7 +3591,7 @@ struct btf *btf_parse_vmlinux(void)
 	struct btf_verifier_env *env =3D NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf =3D NULL;
-	int err, i;
+	int err, btf_id;
=20
 	env =3D kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
 	if (!env)
@@ -3625,24 +3625,13 @@ struct btf *btf_parse_vmlinux(void)
 		goto errout;
=20
 	/* find struct bpf_ctx_convert for type checking later */
-	for (i =3D 1; i <=3D btf->nr_types; i++) {
-		const struct btf_type *t;
-		const char *tname;
-
-		t =3D btf_type_by_id(btf, i);
-		if (!__btf_type_is_struct(t))
-			continue;
-		tname =3D __btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, "bpf_ctx_convert")) {
-			/* btf_parse_vmlinux() runs under bpf_verifier_lock */
-			bpf_ctx_convert.t =3D t;
-			break;
-		}
-	}
-	if (i > btf->nr_types) {
-		err =3D -ENOENT;
+	btf_id =3D btf_find_by_name_kind(btf, "bpf_ctx_convert", BTF_KIND_STRUC=
T);
+	if (btf_id < 0) {
+		err =3D btf_id;
 		goto errout;
 	}
+	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
+	bpf_ctx_convert.t =3D btf_type_by_id(btf, btf_id);
=20
 	bpf_struct_ops_init(btf, log);
=20
--=20
2.24.1

