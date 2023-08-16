Return-Path: <bpf+bounces-7916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C4877E718
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15E21C20E36
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C9168AA;
	Wed, 16 Aug 2023 16:58:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA210949
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 16:58:30 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009FA26B7
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:58:28 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GGTsPb023533
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=vELR2OMSfve3Jo8nFVbzs5MJR0m9vVa4XutJssOgHC8=;
 b=GYz/g+cEgmnireOHNKI1WKsmmGxfazFV8az8l/oZIFV+3VXApnvS1R49ShyxjOFV5WCC
 t4sIhp0rVteuiztqW0K3G5CNLep206c8O4N8+d9gMfZJnheYQ0oZK0iR4X4yG4G6ktYa
 90UheUs0GjaO1HRH4VYwFTNKdnLrv0e8ISw= 
Received: from mail.thefacebook.com ([163.114.132.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sgrkpm650-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:58:28 -0700
Received: from twshared6713.09.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 16 Aug 2023 09:58:25 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 1741322C006DA; Wed, 16 Aug 2023 09:58:14 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 1/2] libbpf: Support triple-underscore flavors for kfunc relocation
Date: Wed, 16 Aug 2023 09:58:12 -0700
Message-ID: <20230816165813.3718580-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mj7v6DOHK3DWwT0Z9XHZ35wCaQ_Am9jG
X-Proofpoint-GUID: mj7v6DOHK3DWwT0Z9XHZ35wCaQ_Am9jG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_17,2023-08-15_02,2023-05-22_02
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

Changelog:

v1 -> v2: https://lore.kernel.org/bpf/20230811201346.3240403-1-davemarchevs=
ky@fb.com/
  * No need to check obj->externs[i].essent_name before zfree (Jiri)
  * Use strndup instead of replicating same functionality (Jiri)
  * Properly handle memory allocation falure (Stanislav)

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/libbpf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b14a4376a86e..8899abc04b8c 100644
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
@@ -3770,6 +3771,7 @@ static int bpf_object__collect_externs(struct bpf_obj=
ect *obj)
 	struct extern_desc *ext;
 	int i, n, off, dummy_var_btf_id;
 	const char *ext_name, *sec_name;
+	size_t ext_essent_len;
 	Elf_Scn *scn;
 	Elf64_Shdr *sh;
=20
@@ -3819,6 +3821,14 @@ static int bpf_object__collect_externs(struct bpf_ob=
ject *obj)
 		ext->sym_idx =3D i;
 		ext->is_weak =3D ELF64_ST_BIND(sym->st_info) =3D=3D STB_WEAK;
=20
+		ext_essent_len =3D bpf_core_essential_name_len(ext->name);
+		ext->essent_name =3D NULL;
+		if (ext_essent_len !=3D strlen(ext->name)) {
+			ext->essent_name =3D strndup(ext->name, ext_essent_len);
+			if (!ext->essent_name)
+				return -ENOMEM;
+		}
+
 		ext->sec_btf_id =3D find_extern_sec_btf_id(obj->btf, ext->btf_id);
 		if (ext->sec_btf_id <=3D 0) {
 			pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
@@ -7624,7 +7634,8 @@ static int bpf_object__resolve_ksym_func_btf_id(struc=
t bpf_object *obj,
=20
 	local_func_proto_id =3D ext->ksym.type_id;
=20
-	kfunc_id =3D find_ksym_btf_id(obj, ext->name, BTF_KIND_FUNC, &kern_btf, &=
mod_btf);
+	kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIN=
D_FUNC, &kern_btf,
+				    &mod_btf);
 	if (kfunc_id < 0) {
 		if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
 			return 0;
@@ -7642,6 +7653,9 @@ static int bpf_object__resolve_ksym_func_btf_id(struc=
t bpf_object *obj,
 		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [=
%d]\n",
 			ext->name, local_func_proto_id,
 			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
+
+		if (ext->is_weak)
+			return 0;
 		return -EINVAL;
 	}
=20
@@ -8370,6 +8384,10 @@ void bpf_object__close(struct bpf_object *obj)
=20
 	zfree(&obj->btf_custom_path);
 	zfree(&obj->kconfig);
+
+	for (i =3D 0; i < obj->nr_extern; i++)
+		zfree(&obj->externs[i].essent_name);
+
 	zfree(&obj->externs);
 	obj->nr_extern =3D 0;
=20
--=20
2.34.1


