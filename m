Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BBA31DEFF
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 19:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhBQSS7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 13:18:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18992 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234783AbhBQSS6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Feb 2021 13:18:58 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11HIAa0G030133
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=W3wcLjS92pw8nNiawlCo3vudShJj3SFlPkjWA0uBe58=;
 b=m1iaEsXpPMi1Ouz4UjxBWf0FJwXsgvZSm7pIsDvIsPmmKY0MPy0cGVUGlahIHJ6Pas0W
 FqAv/6Sp/aL6D4YH6e+dYYkfLSrcL4v3/CQ+13PPBbTKhtSJ+pQX8q4ZkhgokI4+Omrk
 wxmlW0es4D5btuErVFdFS1PNXKQ+zO/HX+Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36s10tasdv-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:17 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 10:18:12 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id C77813704F7A; Wed, 17 Feb 2021 10:18:08 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 05/11] bpf: add hashtab support for bpf_for_each_map_elem() helper
Date:   Wed, 17 Feb 2021 10:18:08 -0800
Message-ID: <20210217181808.3190262-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210217181803.3189437-1-yhs@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=300 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch added support for hashmap, percpu hashmap,
lru hashmap and percpu lru hashmap.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h   |  4 +++
 kernel/bpf/hashtab.c  | 63 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 27 +++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 40f41a9b40f9..34277ab1eda5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1392,6 +1392,10 @@ void bpf_iter_map_show_fdinfo(const struct bpf_ite=
r_aux_info *aux,
 int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
 				struct bpf_link_info *info);
=20
+int map_set_for_each_callback_args(struct bpf_verifier_env *env,
+				   struct bpf_func_state *caller,
+				   struct bpf_func_state *callee);
+
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d63912e73ad9..f652b92ca79f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1869,6 +1869,61 @@ static const struct bpf_iter_seq_info iter_seq_inf=
o =3D {
 	.seq_priv_size		=3D sizeof(struct bpf_iter_seq_hash_map_info),
 };
=20
+static int bpf_for_each_hash_elem(struct bpf_map *map, void *callback_fn=
,
+				  void *callback_ctx, u64 flags)
+{
+	struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map);
+	struct hlist_nulls_head *head;
+	long ret =3D 0, num_calls =3D 0;
+	struct hlist_nulls_node *n;
+	struct htab_elem *elem;
+	u32 roundup_key_size;
+	void __percpu *pptr;
+	struct bucket *b;
+	void *key, *val;
+	bool is_percpu;
+	int i;
+
+	if (flags !=3D 0)
+		return -EINVAL;
+
+	is_percpu =3D htab_is_percpu(htab);
+
+	roundup_key_size =3D round_up(map->key_size, 8);
+	/* disable migration so percpu value prepared here will be the
+	 * same as the one seen by the bpf program with bpf_map_lookup_elem().
+	 */
+	migrate_disable();
+	for (i =3D 0; i < htab->n_buckets; i++) {
+		b =3D &htab->buckets[i];
+		rcu_read_lock();
+		head =3D &b->head;
+		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+			key =3D elem->key;
+			if (!is_percpu) {
+				val =3D elem->key + roundup_key_size;
+			} else {
+				/* current cpu value for percpu map */
+				pptr =3D htab_elem_get_ptr(elem, map->key_size);
+				val =3D this_cpu_ptr(pptr);
+			}
+			num_calls++;
+			ret =3D BPF_CAST_CALL(callback_fn)((u64)(long)map,
+					(u64)(long)key, (u64)(long)val,
+					(u64)(long)callback_ctx, 0);
+			if (ret) {
+				rcu_read_unlock();
+				ret =3D (ret =3D=3D 1) ? 0 : -EINVAL;
+				goto out;
+			}
+		}
+		rcu_read_unlock();
+	}
+out:
+	migrate_enable();
+	return ret ?: num_calls;
+}
+
 static int htab_map_btf_id;
 const struct bpf_map_ops htab_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
@@ -1881,6 +1936,8 @@ const struct bpf_map_ops htab_map_ops =3D {
 	.map_delete_elem =3D htab_map_delete_elem,
 	.map_gen_lookup =3D htab_map_gen_lookup,
 	.map_seq_show_elem =3D htab_map_seq_show_elem,
+	.map_set_for_each_callback_args =3D map_set_for_each_callback_args,
+	.map_for_each_callback =3D bpf_for_each_hash_elem,
 	BATCH_OPS(htab),
 	.map_btf_name =3D "bpf_htab",
 	.map_btf_id =3D &htab_map_btf_id,
@@ -1900,6 +1957,8 @@ const struct bpf_map_ops htab_lru_map_ops =3D {
 	.map_delete_elem =3D htab_lru_map_delete_elem,
 	.map_gen_lookup =3D htab_lru_map_gen_lookup,
 	.map_seq_show_elem =3D htab_map_seq_show_elem,
+	.map_set_for_each_callback_args =3D map_set_for_each_callback_args,
+	.map_for_each_callback =3D bpf_for_each_hash_elem,
 	BATCH_OPS(htab_lru),
 	.map_btf_name =3D "bpf_htab",
 	.map_btf_id =3D &htab_lru_map_btf_id,
@@ -2019,6 +2078,8 @@ const struct bpf_map_ops htab_percpu_map_ops =3D {
 	.map_update_elem =3D htab_percpu_map_update_elem,
 	.map_delete_elem =3D htab_map_delete_elem,
 	.map_seq_show_elem =3D htab_percpu_map_seq_show_elem,
+	.map_set_for_each_callback_args =3D map_set_for_each_callback_args,
+	.map_for_each_callback =3D bpf_for_each_hash_elem,
 	BATCH_OPS(htab_percpu),
 	.map_btf_name =3D "bpf_htab",
 	.map_btf_id =3D &htab_percpu_map_btf_id,
@@ -2036,6 +2097,8 @@ const struct bpf_map_ops htab_lru_percpu_map_ops =3D=
 {
 	.map_update_elem =3D htab_lru_percpu_map_update_elem,
 	.map_delete_elem =3D htab_lru_map_delete_elem,
 	.map_seq_show_elem =3D htab_percpu_map_seq_show_elem,
+	.map_set_for_each_callback_args =3D map_set_for_each_callback_args,
+	.map_for_each_callback =3D bpf_for_each_hash_elem,
 	BATCH_OPS(htab_lru_percpu),
 	.map_btf_name =3D "bpf_htab",
 	.map_btf_id =3D &htab_lru_percpu_map_btf_id,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f80386d094b7..2ce8ed8aca70 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5415,6 +5415,33 @@ static int __check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 	return 0;
 }
=20
+int map_set_for_each_callback_args(struct bpf_verifier_env *env,
+				   struct bpf_func_state *caller,
+				   struct bpf_func_state *callee)
+{
+	/* bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn,
+	 *      void *callback_ctx, u64 flags);
+	 * callback_fn(struct bpf_map *map, void *key, void *value,
+	 *      void *callback_ctx);
+	 */
+	callee->regs[BPF_REG_1] =3D caller->regs[BPF_REG_1];
+
+	callee->regs[BPF_REG_2].type =3D PTR_TO_MAP_KEY;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
+	callee->regs[BPF_REG_2].map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
+
+	callee->regs[BPF_REG_3].type =3D PTR_TO_MAP_VALUE;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
+	callee->regs[BPF_REG_3].map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
+
+	/* pointer to stack or null */
+	callee->regs[BPF_REG_4] =3D caller->regs[BPF_REG_3];
+
+	/* unused */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	return 0;
+}
+
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx)
--=20
2.24.1

