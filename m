Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E30F21DB8E
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgGMQSR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 12:18:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45116 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730234AbgGMQR6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Jul 2020 12:17:58 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DFx6B9004753
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 09:17:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=t8JI+PY1bgZg0wUSyE0ryif/vrdWVstv6UukUas34zE=;
 b=Ch1wvyfynRl1sR8Bz9AspQFIlFhAEtIWN1GlXehfDtsMwy+of9O2DqfkViZkvSOBMZIp
 uLbm+2f7ic2GhJKb1sudIY6rqJrqX82G3hRZTJdjab2l2zy8ZTQmSRGwqO4MU4klhEFZ
 seVHz/OV7PpWwHOQHgRTo4izHYTAGVWsmjY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 327b8hrbkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 09:17:55 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 13 Jul 2020 09:17:55 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3F9C53702065; Mon, 13 Jul 2020 09:17:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 06/13] bpf: implement bpf iterator for array maps
Date:   Mon, 13 Jul 2020 09:17:46 -0700
Message-ID: <20200713161746.3077087-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200713161739.3076283-1-yhs@fb.com>
References: <20200713161739.3076283-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_15:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 mlxlogscore=999 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf iterators for array and percpu array
are implemented. Similar to hash maps, for percpu
array map, bpf program will receive values
from all cpus.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/arraymap.c | 140 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/map_iter.c |   6 +-
 2 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index c66e8273fccd..e855bafb3a59 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -487,6 +487,144 @@ static int array_map_mmap(struct bpf_map *map, stru=
ct vm_area_struct *vma)
 				   vma->vm_pgoff + pgoff);
 }
=20
+struct bpf_iter_seq_array_map_info {
+	struct bpf_map *map;
+	void *percpu_value_buf;
+	u32 index;
+};
+
+static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpf_iter_seq_array_map_info *info =3D seq->private;
+	struct bpf_map *map =3D info->map;
+	struct bpf_array *array;
+	u32 index;
+
+	if (info->index >=3D map->max_entries)
+		return NULL;
+
+	if (*pos =3D=3D 0)
+		++*pos;
+	array =3D container_of(map, struct bpf_array, map);
+	index =3D info->index & array->index_mask;
+	if (info->percpu_value_buf)
+	       return array->pptrs[index];
+	return array->value + array->elem_size * index;
+}
+
+static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_=
t *pos)
+{
+	struct bpf_iter_seq_array_map_info *info =3D seq->private;
+	struct bpf_map *map =3D info->map;
+	struct bpf_array *array;
+	u32 index;
+
+	++*pos;
+	++info->index;
+	if (info->index >=3D map->max_entries)
+		return NULL;
+
+	array =3D container_of(map, struct bpf_array, map);
+	index =3D info->index & array->index_mask;
+	if (info->percpu_value_buf)
+	       return array->pptrs[index];
+	return array->value + array->elem_size * index;
+}
+
+static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter_seq_array_map_info *info =3D seq->private;
+	struct bpf_iter__bpf_map_elem ctx =3D {};
+	struct bpf_map *map =3D info->map;
+	struct bpf_iter_meta meta;
+	struct bpf_array *array;
+	struct bpf_prog *prog;
+	int off =3D 0, cpu =3D 0;
+	void __percpu **pptr;
+	u32 size;
+
+	meta.seq =3D seq;
+	prog =3D bpf_iter_get_info(&meta, v =3D=3D NULL);
+	if (!prog)
+		return 0;
+
+	ctx.meta =3D &meta;
+	ctx.map =3D info->map;
+	if (v) {
+		ctx.key =3D &info->index;
+
+		array =3D container_of(map, struct bpf_array, map);
+		if (!info->percpu_value_buf) {
+			ctx.value =3D v;
+		} else {
+			pptr =3D v;
+			size =3D round_up(map->value_size, 8);
+			for_each_possible_cpu(cpu) {
+				bpf_long_memcpy(info->percpu_value_buf + off,
+						per_cpu_ptr(pptr, cpu),
+						size);
+				off +=3D size;
+			}
+			ctx.value =3D info->percpu_value_buf;
+		}
+	}
+
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int bpf_array_map_seq_show(struct seq_file *seq, void *v)
+{
+	return __bpf_array_map_seq_show(seq, v);
+}
+
+static void bpf_array_map_seq_stop(struct seq_file *seq, void *v)
+{
+	if (!v)
+		(void)__bpf_array_map_seq_show(seq, NULL);
+}
+
+static int bpf_iter_init_array_map(void *priv_data,
+				   struct bpf_iter_aux_info *aux)
+{
+	struct bpf_iter_seq_array_map_info *seq_info =3D priv_data;
+	struct bpf_map *map =3D aux->map;
+	void *value_buf;
+	u32 buf_size;
+
+	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
+		buf_size =3D round_up(map->value_size, 8) * num_possible_cpus();
+		value_buf =3D kmalloc(buf_size, GFP_USER | __GFP_NOWARN);
+		if (!value_buf)
+			return -ENOMEM;
+
+		seq_info->percpu_value_buf =3D value_buf;
+	}
+
+	seq_info->map =3D map;
+	return 0;
+}
+
+static void bpf_iter_fini_array_map(void *priv_data)
+{
+	struct bpf_iter_seq_array_map_info *seq_info =3D priv_data;
+
+	kfree(seq_info->percpu_value_buf);
+}
+
+static const struct seq_operations bpf_array_map_seq_ops =3D {
+	.start	=3D bpf_array_map_seq_start,
+	.next	=3D bpf_array_map_seq_next,
+	.stop	=3D bpf_array_map_seq_stop,
+	.show	=3D bpf_array_map_seq_show,
+};
+
+static const struct bpf_iter_seq_info iter_seq_info =3D {
+	.seq_ops		=3D &bpf_array_map_seq_ops,
+	.init_seq_private	=3D bpf_iter_init_array_map,
+	.fini_seq_private	=3D bpf_iter_fini_array_map,
+	.seq_priv_size		=3D sizeof(struct bpf_iter_seq_array_map_info),
+};
+
 static int array_map_btf_id;
 const struct bpf_map_ops array_map_ops =3D {
 	.map_alloc_check =3D array_map_alloc_check,
@@ -506,6 +644,7 @@ const struct bpf_map_ops array_map_ops =3D {
 	.map_update_batch =3D generic_map_update_batch,
 	.map_btf_name =3D "bpf_array",
 	.map_btf_id =3D &array_map_btf_id,
+	.iter_seq_info =3D &iter_seq_info,
 };
=20
 static int percpu_array_map_btf_id;
@@ -521,6 +660,7 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
 	.map_check_btf =3D array_map_check_btf,
 	.map_btf_name =3D "bpf_array",
 	.map_btf_id =3D &percpu_array_map_btf_id,
+	.iter_seq_info =3D &iter_seq_info,
 };
=20
 static int fd_array_map_alloc_check(union bpf_attr *attr)
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 2988244853d1..5729d78166e3 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -106,10 +106,12 @@ static int bpf_iter_check_map(struct bpf_prog *prog=
,
 	bool is_percpu =3D false;
=20
 	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH)
+	    map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
 		is_percpu =3D true;
 	else if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
-		 map->map_type !=3D BPF_MAP_TYPE_LRU_HASH)
+		 map->map_type !=3D BPF_MAP_TYPE_LRU_HASH &&
+		 map->map_type !=3D BPF_MAP_TYPE_ARRAY)
 		return -EINVAL;
=20
 	key_acc_size =3D prog->aux->max_rdonly_access[0];
--=20
2.24.1

