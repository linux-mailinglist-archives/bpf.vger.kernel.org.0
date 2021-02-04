Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5ECC310100
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 00:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhBDXtS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 18:49:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52210 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231205AbhBDXtR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 18:49:17 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114NkYdj013058
        for <bpf@vger.kernel.org>; Thu, 4 Feb 2021 15:48:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DVePNI0uN54E32T9K+HYP/sKFBYuHSg6Xxdu0YDVMN8=;
 b=TvF2MsLJO2zOa309hKbilDZxOAbTTf1rQYNzOGf9lsdPcDX2zcR4gjGZcMcxhMtg/O8i
 pmNXMxfaKXt9Tpd91gFl4kP9yJXpvOWtzpxBK9XOLHPf1qoHeCUFnwtzNdCP14w2PGz0
 vV6tLAtHASTh6zg9PQOfbzkwIEAY5jMomLk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36fvyd1njv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 15:48:36 -0800
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 15:48:35 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id AA8AF3704E75; Thu,  4 Feb 2021 15:48:31 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/8] bpf: add arraymap support for bpf_for_each_map_elem() helper
Date:   Thu, 4 Feb 2021 15:48:31 -0800
Message-ID: <20210204234831.1629285-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210204234827.1628857-1-yhs@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=716
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch added support for arraymap and percpu arraymap.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/arraymap.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1f8453343bf2..af0496b9981a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -625,6 +625,38 @@ static const struct bpf_iter_seq_info iter_seq_info =
=3D {
 	.seq_priv_size		=3D sizeof(struct bpf_iter_seq_array_map_info),
 };
=20
+static int bpf_for_each_array_elem(struct bpf_map *map, void *callback_f=
n,
+				   void *callback_ctx, u64 flags)
+{
+	struct bpf_array *array;
+	bool is_percpu;
+	u32 i, index;
+	long ret =3D 0;
+	void *val;
+
+	if (flags !=3D 0)
+		return -EINVAL;
+
+	is_percpu =3D map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY;
+	array =3D container_of(map, struct bpf_array, map);
+	for (i =3D 0; i < map->max_entries; i++) {
+		index =3D i & array->index_mask;
+		if (is_percpu)
+			val =3D this_cpu_ptr(array->pptrs[i]);
+		else
+			val =3D array->value + array->elem_size * i;
+		ret =3D BPF_CAST_CALL(callback_fn)((u64)(long)map,
+					(u64)(long)&index, (u64)(long)val,
+					(u64)(long)callback_ctx, 0);
+		if (ret) {
+			ret =3D (ret =3D=3D 1) ? 0 : -EINVAL;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int array_map_btf_id;
 const struct bpf_map_ops array_map_ops =3D {
 	.map_meta_equal =3D array_map_meta_equal,
@@ -643,6 +675,8 @@ const struct bpf_map_ops array_map_ops =3D {
 	.map_check_btf =3D array_map_check_btf,
 	.map_lookup_batch =3D generic_map_lookup_batch,
 	.map_update_batch =3D generic_map_update_batch,
+	.map_set_for_each_callback_args =3D map_set_for_each_callback_args,
+	.map_for_each_callback =3D bpf_for_each_array_elem,
 	.map_btf_name =3D "bpf_array",
 	.map_btf_id =3D &array_map_btf_id,
 	.iter_seq_info =3D &iter_seq_info,
@@ -660,6 +694,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
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

