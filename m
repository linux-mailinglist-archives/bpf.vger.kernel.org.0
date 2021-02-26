Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE8325CEA
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 06:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhBZFN7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 00:13:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhBZFN5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 00:13:57 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q560dh026595
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IYG0y1Ajr5xYU38DBRneRvFH499OhJnmJcM7SW60Ors=;
 b=ArrzltH1roiZrYyia9df+dIacj2bwHt+CsfWRh6lxhsNxLCopHPf3c+6QSGWpdF8sOOv
 BKn6NHHFcPK0CVPkTooZXKSs4kJf5X8Kxn5Jj8aRC6OAm+mzW2FVVOXtRMSofdL4JJB2
 O2GiHAfV5QKNRyxay+IQ8C8LLiY+3bIz/Rk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xjxqj63w-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 21:13:17 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 21:13:14 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id A7E8F3705B54; Thu, 25 Feb 2021 21:13:13 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v4 07/12] bpf: add arraymap support for bpf_for_each_map_elem() helper
Date:   Thu, 25 Feb 2021 21:13:13 -0800
Message-ID: <20210226051313.3429218-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226051305.3428235-1-yhs@fb.com>
References: <20210226051305.3428235-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_01:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 mlxlogscore=486 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch added support for arraymap and percpu arraymap.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/arraymap.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1f8453343bf2..463d25e1e67e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -625,6 +625,42 @@ static const struct bpf_iter_seq_info iter_seq_info =
=3D {
 	.seq_priv_size		=3D sizeof(struct bpf_iter_seq_array_map_info),
 };
=20
+static int bpf_for_each_array_elem(struct bpf_map *map, void *callback_f=
n,
+				   void *callback_ctx, u64 flags)
+{
+	u32 i, key, num_elems =3D 0;
+	struct bpf_array *array;
+	bool is_percpu;
+	u64 ret =3D 0;
+	void *val;
+
+	if (flags !=3D 0)
+		return -EINVAL;
+
+	is_percpu =3D map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY;
+	array =3D container_of(map, struct bpf_array, map);
+	if (is_percpu)
+		migrate_disable();
+	for (i =3D 0; i < map->max_entries; i++) {
+		if (is_percpu)
+			val =3D this_cpu_ptr(array->pptrs[i]);
+		else
+			val =3D array->value + array->elem_size * i;
+		num_elems++;
+		key =3D i;
+		ret =3D BPF_CAST_CALL(callback_fn)((u64)(long)map,
+					(u64)(long)&key, (u64)(long)val,
+					(u64)(long)callback_ctx, 0);
+		/* return value: 0 - continue, 1 - stop and return */
+		if (ret)
+			break;
+	}
+
+	if (is_percpu)
+		migrate_enable();
+	return num_elems;
+}
+
 static int array_map_btf_id;
 const struct bpf_map_ops array_map_ops =3D {
 	.map_meta_equal =3D array_map_meta_equal,
@@ -643,6 +679,8 @@ const struct bpf_map_ops array_map_ops =3D {
 	.map_check_btf =3D array_map_check_btf,
 	.map_lookup_batch =3D generic_map_lookup_batch,
 	.map_update_batch =3D generic_map_update_batch,
+	.map_set_for_each_callback_args =3D map_set_for_each_callback_args,
+	.map_for_each_callback =3D bpf_for_each_array_elem,
 	.map_btf_name =3D "bpf_array",
 	.map_btf_id =3D &array_map_btf_id,
 	.iter_seq_info =3D &iter_seq_info,
@@ -660,6 +698,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
 	.map_delete_elem =3D array_map_delete_elem,
 	.map_seq_show_elem =3D percpu_array_map_seq_show_elem,
 	.map_check_btf =3D array_map_check_btf,
+	.map_set_for_each_callback_args =3D map_set_for_each_callback_args,
+	.map_for_each_callback =3D bpf_for_each_array_elem,
 	.map_btf_name =3D "bpf_array",
 	.map_btf_id =3D &percpu_array_map_btf_id,
 	.iter_seq_info =3D &iter_seq_info,
--=20
2.24.1

