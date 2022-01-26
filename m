Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0949C27B
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 05:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiAZEHE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 23:07:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237499AbiAZEHE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 23:07:04 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20PMO4Gp025748
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:07:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ibCKQH0cx7z0cP/kqbpB8YU59O69ng0IzcDg0hIKdGQ=;
 b=lwSqgQAFoLJGE6OMSaPZZnw4tmsNqqq9fxI6MoS9JQvYpJCFNs8TxSd+xUWMiywG+Gx6
 rum1YX9VHT2mfHz0KRsXk18HKeTBQdZUbx8+X2b+oXDuzu+NB5XWXvAYbpKm0XJ7MXJx
 MJsIfAsAXwGI3fMJarZ1mI059SnZpoKuWo8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dth265c0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:07:03 -0800
Received: from twshared19733.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 20:07:03 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id D38D52C1E2B0; Tue, 25 Jan 2022 20:06:58 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <dwarves@vger.kernel.org>, <arnaldo.melo@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves v3 2/4] dwarf_loader: Prepare and pass per-thread data to worker threads.
Date:   Tue, 25 Jan 2022 20:05:07 -0800
Message-ID: <20220126040509.1862767-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126040509.1862767-1-kuifeng@fb.com>
References: <20220126040509.1862767-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: q6ADWZItUoYXV2CI6HCJPYr-M0WSpyVw
X-Proofpoint-ORIG-GUID: q6ADWZItUoYXV2CI6HCJPYr-M0WSpyVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_01,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=958 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add interfaces to allow users of dwarf_loader to prepare and pass
per-thread data to steal-functions running on worker threads.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 dwarf_loader.c | 58 +++++++++++++++++++++++++++++++++++++++-----------
 dwarves.h      |  4 ++++
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index bf9ea3765419..ed415d2db11f 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2682,18 +2682,18 @@ static int class_member__cache_byte_size(struct t=
ag *tag, struct cu *cu,
 	return 0;
 }
=20
-static int cu__finalize(struct cu *cu, struct conf_load *conf)
+static int cu__finalize(struct cu *cu, struct conf_load *conf, void *thr=
_data)
 {
 	cu__for_all_tags(cu, class_member__cache_byte_size, conf);
 	if (conf && conf->steal) {
-		return conf->steal(cu, conf, NULL);
+		return conf->steal(cu, conf, thr_data);
 	}
 	return LSK__KEEPIT;
 }
=20
-static int cus__finalize(struct cus *cus, struct cu *cu, struct conf_loa=
d *conf)
+static int cus__finalize(struct cus *cus, struct cu *cu, struct conf_loa=
d *conf, void *thr_data)
 {
-	int lsk =3D cu__finalize(cu, conf);
+	int lsk =3D cu__finalize(cu, conf, thr_data);
 	switch (lsk) {
 	case LSK__DELETE:
 		cu__delete(cu);
@@ -2862,7 +2862,13 @@ struct dwarf_cus {
 	struct dwarf_cu	    *type_dcu;
 };
=20
-static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwar=
f_Die *cu_die, uint8_t pointer_size)
+struct dwarf_thread {
+	struct dwarf_cus	*dcus;
+	void			*data;
+};
+
+static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwar=
f_Die *cu_die,
+					    uint8_t pointer_size, void *thr_data)
 {
 	/*
 	 * DW_AT_name in DW_TAG_compile_unit can be NULL, first seen in:
@@ -2884,7 +2890,7 @@ static int dwarf_cus__create_and_process_cu(struct =
dwarf_cus *dcus, Dwarf_Die *c
 	cu->dfops =3D &dwarf__ops;
=20
 	if (die__process_and_recode(cu_die, cu, dcus->conf) !=3D 0 ||
-	    cus__finalize(dcus->cus, cu, dcus->conf) =3D=3D LSK__STOP_LOADING)
+	    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) =3D=3D LSK__STOP=
_LOADING)
 		return DWARF_CB_ABORT;
=20
        return DWARF_CB_OK;
@@ -2918,7 +2924,8 @@ out_unlock:
=20
 static void *dwarf_cus__process_cu_thread(void *arg)
 {
-	struct dwarf_cus *dcus =3D arg;
+	struct dwarf_thread *dthr =3D arg;
+	struct dwarf_cus *dcus =3D dthr->dcus;
 	uint8_t pointer_size, offset_size;
 	Dwarf_Die die_mem, *cu_die;
=20
@@ -2926,11 +2933,13 @@ static void *dwarf_cus__process_cu_thread(void *a=
rg)
 		if (cu_die =3D=3D NULL)
 			break;
=20
-		if (dwarf_cus__create_and_process_cu(dcus, cu_die, pointer_size) =3D=3D=
 DWARF_CB_ABORT)
+		if (dwarf_cus__create_and_process_cu(dcus, cu_die,
+						     pointer_size, dthr->data) =3D=3D DWARF_CB_ABORT)
 			goto out_abort;
 	}
=20
-	if (dcus->conf->thread_exit && dcus->conf->thread_exit(dcus->conf, NULL=
) !=3D 0)
+	if (dcus->conf->thread_exit &&
+	    dcus->conf->thread_exit(dcus->conf, dthr->data) !=3D 0)
 		goto out_abort;
=20
 	return (void *)DWARF_CB_OK;
@@ -2941,10 +2950,25 @@ out_abort:
 static int dwarf_cus__threaded_process_cus(struct dwarf_cus *dcus)
 {
 	pthread_t threads[dcus->conf->nr_jobs];
+	struct dwarf_thread dthr[dcus->conf->nr_jobs];
+	void *thread_data[dcus->conf->nr_jobs];
+	int res;
 	int i;
=20
+	if (dcus->conf->threads_prepare) {
+		res =3D dcus->conf->threads_prepare(dcus->conf, dcus->conf->nr_jobs, t=
hread_data);
+		if (res !=3D 0)
+			return res;
+	} else
+		memset(thread_data, 0, sizeof(void *) * dcus->conf->nr_jobs);
+
 	for (i =3D 0; i < dcus->conf->nr_jobs; ++i) {
-		dcus->error =3D pthread_create(&threads[i], NULL, dwarf_cus__process_c=
u_thread, dcus);
+		dthr[i].dcus =3D dcus;
+		dthr[i].data =3D thread_data[i];
+
+		dcus->error =3D pthread_create(&threads[i], NULL,
+					     dwarf_cus__process_cu_thread,
+					     &dthr[i]);
 		if (dcus->error)
 			goto out_join;
 	}
@@ -2960,6 +2984,13 @@ out_join:
 			dcus->error =3D (long)res;
 	}
=20
+	if (dcus->conf->threads_collect) {
+		res =3D dcus->conf->threads_collect(dcus->conf, dcus->conf->nr_jobs,
+						  thread_data, dcus->error);
+		if (dcus->error =3D=3D 0)
+			dcus->error =3D res;
+	}
+
 	return dcus->error;
 }
=20
@@ -2976,7 +3007,8 @@ static int __dwarf_cus__process_cus(struct dwarf_cu=
s *dcus)
 		if (cu_die =3D=3D NULL)
 			break;
=20
-		if (dwarf_cus__create_and_process_cu(dcus, cu_die, pointer_size) =3D=3D=
 DWARF_CB_ABORT)
+		if (dwarf_cus__create_and_process_cu(dcus, cu_die,
+						     pointer_size, NULL) =3D=3D DWARF_CB_ABORT)
 			return DWARF_CB_ABORT;
=20
 		dcus->off =3D noff;
@@ -3070,7 +3102,7 @@ static int cus__merge_and_process_cu(struct cus *cu=
s, struct conf_load *conf,
 	if (cu__resolve_func_ret_types(cu) !=3D LSK__KEEPIT)
 		goto out_abort;
=20
-	if (cus__finalize(cus, cu, conf) =3D=3D LSK__STOP_LOADING)
+	if (cus__finalize(cus, cu, conf, NULL) =3D=3D LSK__STOP_LOADING)
 		goto out_abort;
=20
 	return 0;
@@ -3102,7 +3134,7 @@ static int cus__load_module(struct cus *cus, struct=
 conf_load *conf,
 	}
=20
 	if (type_cu !=3D NULL) {
-		type_lsk =3D cu__finalize(type_cu, conf);
+		type_lsk =3D cu__finalize(type_cu, conf, NULL);
 		if (type_lsk =3D=3D LSK__KEEPIT) {
 			cus__add(cus, type_cu);
 		}
diff --git a/dwarves.h b/dwarves.h
index 9a8e4de8843a..de152f9b64cf 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -71,6 +71,10 @@ struct conf_load {
 	const char		*kabi_prefix;
 	struct btf		*base_btf;
 	struct conf_fprintf	*conf_fprintf;
+	int			(*threads_prepare)(struct conf_load *conf, int nr_threads,
+						   void **thr_data);
+	int			(*threads_collect)(struct conf_load *conf, int nr_threads,
+						   void **thr_data, int error);
 };
=20
 /** struct conf_fprintf - hints to the __fprintf routines
--=20
2.30.2

