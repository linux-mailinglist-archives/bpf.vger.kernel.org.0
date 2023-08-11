Return-Path: <bpf+bounces-7606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2027C779850
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 22:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503A51C2167F
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE42AB5C;
	Fri, 11 Aug 2023 20:14:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D08468
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 20:14:12 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487F30E8
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:14:11 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGN7xA004463
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:14:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hZyH/LvR/wQp6Tg0ZCMFFaJxjz1kxuDjxmCbnADVC0Y=;
 b=lM+QJoXk/nSoJsYrIV+a/R42m9Us1MetHs7c0aTB+0q+bY9lrVgGozOYy5YCy+Gf6x4b
 i7Ilk5MiDG/d8XrkQM4GV/avcUg9JvsrTEYfcbwX7yhuzLwLKp8OeSnBhJNOTHDJbYII
 oPpTaRbmzlg9N8VqrKoQEiXtnUrWBe7waVc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sd8yd9vrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:14:11 -0700
Received: from twshared7236.08.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 13:14:09 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 138922282EDE6; Fri, 11 Aug 2023 13:13:54 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo
	<tj@kernel.org>,
        <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 1/2] libbpf: Support triple-underscore flavors for kfunc relocation
Date: Fri, 11 Aug 2023 13:13:45 -0700
Message-ID: <20230811201346.3240403-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DcGcniHZ0F8L-h5TvurmO2TV4T7D1qd3
X-Proofpoint-GUID: DcGcniHZ0F8L-h5TvurmO2TV4T7D1qd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_12,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The function signature of kfuncs can change at any time due to their
intentional lack of stability guarantees. As kfuncs become more widely
used, BPF program writers will need facilities to support calling
different versions of a kfunc from a single BPF object. Consider this
simplified example based on a real scenario we ran into at Meta:

  /* initial kfunc signature */
  int some_kfunc(void *ptr)

  /* Oops, we need to add some flag to modify behavior. No problem,
    change the kfunc. flags =3D 0 retains original behavior */
  int some_kfunc(void *ptr, long flags)

If the initial version of the kfunc is deployed on some portion of the
fleet and the new version on the rest, a fleetwide service that uses
some_kfunc will currently need to load different BPF programs depending
on which some_kfunc is available.

Luckily CO-RE provides a facility to solve a very similar problem,
struct definition changes, by allowing program writers to declare
my_struct___old and my_struct___new, with ___suffix being considered a
'flavor' of the non-suffixed name and being ignored by
bpf_core_type_exists and similar calls.

This patch extends the 'flavor' facility to the kfunc extern
relocation process. BPF program writers can now declare

  extern int some_kfunc___old(void *ptr)
  extern int some_kfunc___new(void *ptr, int flags)

then test which version of the kfunc exists with bpf_ksym_exists.
Relocation and verifier's dead code elimination will work in concert as
expected, allowing this pattern:

  if (bpf_ksym_exists(some_kfunc___old))
    some_kfunc___old(ptr);
  else
    some_kfunc___new(ptr, 0);

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 17883f5a44b9..8949d489a35f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -550,6 +550,7 @@ struct extern_desc {
 	int btf_id;
 	int sec_btf_id;
 	const char *name;
+	char *essent_name;
 	bool is_set;
 	bool is_weak;
 	union {
@@ -3770,6 +3771,7 @@ static int bpf_object__collect_externs(struct bpf_o=
bject *obj)
 	struct extern_desc *ext;
 	int i, n, off, dummy_var_btf_id;
 	const char *ext_name, *sec_name;
+	size_t ext_essent_len;
 	Elf_Scn *scn;
 	Elf64_Shdr *sh;
=20
@@ -3819,6 +3821,14 @@ static int bpf_object__collect_externs(struct bpf_=
object *obj)
 		ext->sym_idx =3D i;
 		ext->is_weak =3D ELF64_ST_BIND(sym->st_info) =3D=3D STB_WEAK;
=20
+		ext_essent_len =3D bpf_core_essential_name_len(ext->name);
+		ext->essent_name =3D NULL;
+		if (ext_essent_len !=3D strlen(ext->name)) {
+			ext->essent_name =3D malloc(ext_essent_len + 1);
+			memcpy(ext->essent_name, ext->name, ext_essent_len);
+			ext->essent_name[ext_essent_len] =3D '\0';
+		}
+
 		ext->sec_btf_id =3D find_extern_sec_btf_id(obj->btf, ext->btf_id);
 		if (ext->sec_btf_id <=3D 0) {
 			pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
@@ -7624,7 +7634,8 @@ static int bpf_object__resolve_ksym_func_btf_id(str=
uct bpf_object *obj,
=20
 	local_func_proto_id =3D ext->ksym.type_id;
=20
-	kfunc_id =3D find_ksym_btf_id(obj, ext->name, BTF_KIND_FUNC, &kern_btf,=
 &mod_btf);
+	kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_K=
IND_FUNC, &kern_btf,
+				    &mod_btf);
 	if (kfunc_id < 0) {
 		if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
 			return 0;
@@ -7642,6 +7653,9 @@ static int bpf_object__resolve_ksym_func_btf_id(str=
uct bpf_object *obj,
 		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s=
 [%d]\n",
 			ext->name, local_func_proto_id,
 			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
+
+		if (ext->is_weak)
+			return 0;
 		return -EINVAL;
 	}
=20
@@ -8370,6 +8384,11 @@ void bpf_object__close(struct bpf_object *obj)
=20
 	zfree(&obj->btf_custom_path);
 	zfree(&obj->kconfig);
+
+	for (i =3D 0; i < obj->nr_extern; i++)
+		if (obj->externs[i].essent_name)
+			zfree(&obj->externs[i].essent_name);
+
 	zfree(&obj->externs);
 	obj->nr_extern =3D 0;
=20
--=20
2.34.1


