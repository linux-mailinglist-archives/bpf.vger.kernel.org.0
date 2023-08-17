Return-Path: <bpf+bounces-8028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858FB78014F
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 00:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BF21C214EE
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE351B7F8;
	Thu, 17 Aug 2023 22:54:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF13F9D5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 22:54:38 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D52D65
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:54:37 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HHmXRa028710
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:54:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=RPyxSei1bagjIjDcYGKF2XBRHizQ4u+4q8zKmKNfEwc=;
 b=h5aw5Vcx+GQJUZpGlOl6IRLBhrZnIhBSbw7ykX8rgI4jSnWOVn4xTxEcEY3ktZfuL25m
 atOyGaHQZwQqCFii/S+La4dJB1bMUwjCvm0MJeSckIhtUYTbw66e2sRtdLE8GRYRZC83
 QWSWXtksvuR2vk8UTXU/qROrLfhDjnqI+3Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3shgk2q9yb-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:54:37 -0700
Received: from twshared13387.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 17 Aug 2023 15:54:07 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 1233122D020D7; Thu, 17 Aug 2023 15:53:54 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 1/2] libbpf: Support triple-underscore flavors for kfunc relocation
Date: Thu, 17 Aug 2023 15:53:52 -0700
Message-ID: <20230817225353.2570845-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: L7qtksgZJra4AVfSHF9kEN1UgfYLIgyr
X-Proofpoint-ORIG-GUID: L7qtksgZJra4AVfSHF9kEN1UgfYLIgyr
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
 definitions=2023-08-17_18,2023-08-17_02,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

v2 -> v3: https://lore.kernel.org/bpf/20230816165813.3718580-1-davemarchevs=
ky@fb.com/
  * Move if (ext->is_weak) test above pr_warn to match existing similar beh=
avior
    (David Vernet)

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/libbpf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b14a4376a86e..2178b28878e2 100644
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
@@ -7639,6 +7650,9 @@ static int bpf_object__resolve_ksym_func_btf_id(struc=
t bpf_object *obj,
 	ret =3D bpf_core_types_are_compat(obj->btf, local_func_proto_id,
 					kern_btf, kfunc_proto_id);
 	if (ret <=3D 0) {
+		if (ext->is_weak)
+			return 0;
+
 		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [=
%d]\n",
 			ext->name, local_func_proto_id,
 			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
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


