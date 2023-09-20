Return-Path: <bpf+bounces-10432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2184D7A7216
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 07:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCFB1C2090E
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984E3D8C;
	Wed, 20 Sep 2023 05:32:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF503D65
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 05:32:22 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E3F9
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:20 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K1vGni022239
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:19 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t73uyjawm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 22:32:19 -0700
Received: from twshared22837.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 22:32:18 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 3D22224A600D5; Tue, 19 Sep 2023 22:32:11 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@kernel.org>, <kernel-team@meta.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 2/8] bpf: Let bpf_prog_pack_free handle any pointer
Date: Tue, 19 Sep 2023 22:31:52 -0700
Message-ID: <20230920053158.3175043-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920053158.3175043-1-song@kernel.org>
References: <20230920053158.3175043-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Gx8XM1lNRUkXKny6ABaecKk36misQFwq
X-Proofpoint-GUID: Gx8XM1lNRUkXKny6ABaecKk36misQFwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, bpf_prog_pack_free only can only free pointer to struct
bpf_binary_header, which is not flexible. Add a size argument to
bpf_prog_pack_free so that it can handle any pointer.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/filter.h  |  2 +-
 kernel/bpf/core.c       | 21 ++++++++++-----------
 kernel/bpf/dispatcher.c |  5 +----
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 27406aee2d40..eda9efe20026 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1073,7 +1073,7 @@ struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
=20
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_ins=
ns);
-void bpf_prog_pack_free(struct bpf_binary_header *hdr);
+void bpf_prog_pack_free(void *ptr, u32 size);
=20
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *f=
p)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 08626b519ce2..fcdf710e6a32 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -928,20 +928,20 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_ho=
le_t bpf_fill_ill_insns)
 	return ptr;
 }
=20
-void bpf_prog_pack_free(struct bpf_binary_header *hdr)
+void bpf_prog_pack_free(void *ptr, u32 size)
 {
 	struct bpf_prog_pack *pack =3D NULL, *tmp;
 	unsigned int nbits;
 	unsigned long pos;
=20
 	mutex_lock(&pack_mutex);
-	if (hdr->size > BPF_PROG_PACK_SIZE) {
-		bpf_jit_free_exec(hdr);
+	if (size > BPF_PROG_PACK_SIZE) {
+		bpf_jit_free_exec(ptr);
 		goto out;
 	}
=20
 	list_for_each_entry(tmp, &pack_list, list) {
-		if ((void *)hdr >=3D tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > (vo=
id *)hdr) {
+		if (ptr >=3D tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > ptr) {
 			pack =3D tmp;
 			break;
 		}
@@ -950,10 +950,10 @@ void bpf_prog_pack_free(struct bpf_binary_header *h=
dr)
 	if (WARN_ONCE(!pack, "bpf_prog_pack bug\n"))
 		goto out;
=20
-	nbits =3D BPF_PROG_SIZE_TO_NBITS(hdr->size);
-	pos =3D ((unsigned long)hdr - (unsigned long)pack->ptr) >> BPF_PROG_CHU=
NK_SHIFT;
+	nbits =3D BPF_PROG_SIZE_TO_NBITS(size);
+	pos =3D ((unsigned long)ptr - (unsigned long)pack->ptr) >> BPF_PROG_CHU=
NK_SHIFT;
=20
-	WARN_ONCE(bpf_arch_text_invalidate(hdr, hdr->size),
+	WARN_ONCE(bpf_arch_text_invalidate(ptr, size),
 		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
=20
 	bitmap_clear(pack->bitmap, pos, nbits);
@@ -1100,8 +1100,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 =
**image_ptr,
=20
 	*rw_header =3D kvmalloc(size, GFP_KERNEL);
 	if (!*rw_header) {
-		bpf_arch_text_copy(&ro_header->size, &size, sizeof(size));
-		bpf_prog_pack_free(ro_header);
+		bpf_prog_pack_free(ro_header, size);
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
 	}
@@ -1132,7 +1131,7 @@ int bpf_jit_binary_pack_finalize(struct bpf_prog *p=
rog,
 	kvfree(rw_header);
=20
 	if (IS_ERR(ptr)) {
-		bpf_prog_pack_free(ro_header);
+		bpf_prog_pack_free(ro_header, ro_header->size);
 		return PTR_ERR(ptr);
 	}
 	return 0;
@@ -1153,7 +1152,7 @@ void bpf_jit_binary_pack_free(struct bpf_binary_hea=
der *ro_header,
 {
 	u32 size =3D ro_header->size;
=20
-	bpf_prog_pack_free(ro_header);
+	bpf_prog_pack_free(ro_header, size);
 	kvfree(rw_header);
 	bpf_jit_uncharge_modmem(size);
 }
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index fa3e9225aedc..56760fc10e78 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -150,10 +150,7 @@ void bpf_dispatcher_change_prog(struct bpf_dispatche=
r *d, struct bpf_prog *from,
 			goto out;
 		d->rw_image =3D bpf_jit_alloc_exec(PAGE_SIZE);
 		if (!d->rw_image) {
-			u32 size =3D PAGE_SIZE;
-
-			bpf_arch_text_copy(d->image, &size, sizeof(size));
-			bpf_prog_pack_free((struct bpf_binary_header *)d->image);
+			bpf_prog_pack_free(d->image, PAGE_SIZE);
 			d->image =3D NULL;
 			goto out;
 		}
--=20
2.34.1


