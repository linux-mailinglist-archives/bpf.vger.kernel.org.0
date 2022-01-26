Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8576349C275
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 05:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiAZEG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 23:06:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237464AbiAZEGY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 23:06:24 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20PMO2Zc026899
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:06:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DCMSFmJbLQ91HXUrcnvneW49VuxbN1I/B/x+Vf9XN4I=;
 b=eSPaQFJuHkU8JLLgpUHQQXTaY+Msl5YDPvq1AdWqIyhWNrTOc6CfRpS5Um37qQqe1vI7
 cwUZ0h7+RYiGqcVNaY86Lj9xSaI/Y5Bvk2snt1cKJQk+ObWjpi3Zyo0F2Y1chVx6jszO
 EDoGwRa5GkMxMNA5nobWMPSA/GXwCGU6t7o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dts3e9sem-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:06:22 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 20:06:21 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id DDF4E2C1E0E2; Tue, 25 Jan 2022 20:06:17 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <dwarves@vger.kernel.org>, <arnaldo.melo@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves v3 1/4] dwarf_loader: Receive per-thread data on worker threads.
Date:   Tue, 25 Jan 2022 20:05:06 -0800
Message-ID: <20220126040509.1862767-2-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126040509.1862767-1-kuifeng@fb.com>
References: <20220126040509.1862767-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1o9-eJuiwQmgWiH1ShNJ4e__8iDPH0Sz
X-Proofpoint-GUID: 1o9-eJuiwQmgWiH1ShNJ4e__8iDPH0Sz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_01,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add arguments to steal and thread_exit callbacks of conf_load to
receive per-thread data.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 btf_loader.c   | 2 +-
 ctf_loader.c   | 2 +-
 dwarf_loader.c | 4 ++--
 dwarves.h      | 5 +++--
 pahole.c       | 3 ++-
 pdwtags.c      | 3 ++-
 pfunct.c       | 4 +++-
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 7a5b16ff393e..b61cadd55127 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -624,7 +624,7 @@ static int cus__load_btf(struct cus *cus, struct conf=
_load *conf, const char *fi
 	 * The app stole this cu, possibly deleting it,
 	 * so forget about it
 	 */
-	if (conf && conf->steal && conf->steal(cu, conf))
+	if (conf && conf->steal && conf->steal(cu, conf, NULL))
 		return 0;
=20
 	cus__add(cus, cu);
diff --git a/ctf_loader.c b/ctf_loader.c
index 7c34739afdce..de6d4dbfce97 100644
--- a/ctf_loader.c
+++ b/ctf_loader.c
@@ -722,7 +722,7 @@ int ctf__load_file(struct cus *cus, struct conf_load =
*conf,
 	 * The app stole this cu, possibly deleting it,
 	 * so forget about it
 	 */
-	if (conf && conf->steal && conf->steal(cu, conf))
+	if (conf && conf->steal && conf->steal(cu, conf, NULL))
 		return 0;
=20
 	cus__add(cus, cu);
diff --git a/dwarf_loader.c b/dwarf_loader.c
index e30b03c1c541..bf9ea3765419 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2686,7 +2686,7 @@ static int cu__finalize(struct cu *cu, struct conf_=
load *conf)
 {
 	cu__for_all_tags(cu, class_member__cache_byte_size, conf);
 	if (conf && conf->steal) {
-		return conf->steal(cu, conf);
+		return conf->steal(cu, conf, NULL);
 	}
 	return LSK__KEEPIT;
 }
@@ -2930,7 +2930,7 @@ static void *dwarf_cus__process_cu_thread(void *arg=
)
 			goto out_abort;
 	}
=20
-	if (dcus->conf->thread_exit && dcus->conf->thread_exit() !=3D 0)
+	if (dcus->conf->thread_exit && dcus->conf->thread_exit(dcus->conf, NULL=
) !=3D 0)
 		goto out_abort;
=20
 	return (void *)DWARF_CB_OK;
diff --git a/dwarves.h b/dwarves.h
index 52d162d67456..9a8e4de8843a 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -48,8 +48,9 @@ struct conf_fprintf;
  */
 struct conf_load {
 	enum load_steal_kind	(*steal)(struct cu *cu,
-					 struct conf_load *conf);
-	int			(*thread_exit)(void);
+					 struct conf_load *conf,
+					 void *thr_data);
+	int			(*thread_exit)(struct conf_load *conf, void *thr_data);
 	void			*cookie;
 	char			*format_path;
 	int			nr_jobs;
diff --git a/pahole.c b/pahole.c
index f3a51cb2fe74..f3eeaaca4cdf 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2799,7 +2799,8 @@ out:
 static struct type_instance *header;
=20
 static enum load_steal_kind pahole_stealer(struct cu *cu,
-					   struct conf_load *conf_load)
+					   struct conf_load *conf_load,
+					   void *thr_data)
 {
 	int ret =3D LSK__DELETE;
=20
diff --git a/pdwtags.c b/pdwtags.c
index 2b5ba1bf6745..8b1d6f1c96cb 100644
--- a/pdwtags.c
+++ b/pdwtags.c
@@ -72,7 +72,8 @@ static int cu__emit_tags(struct cu *cu)
 }
=20
 static enum load_steal_kind pdwtags_stealer(struct cu *cu,
-					    struct conf_load *conf_load __maybe_unused)
+					    struct conf_load *conf_load __maybe_unused,
+					    void *thr_data __maybe_unused)
 {
 	cu__emit_tags(cu);
 	return LSK__DELETE;
diff --git a/pfunct.c b/pfunct.c
index 5485622e639b..314915b774f4 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -489,7 +489,9 @@ int elf_symtabs__show(char *filenames[])
 	return EXIT_SUCCESS;
 }
=20
-static enum load_steal_kind pfunct_stealer(struct cu *cu, struct conf_lo=
ad *conf_load __maybe_unused)
+static enum load_steal_kind pfunct_stealer(struct cu *cu,
+					   struct conf_load *conf_load __maybe_unused,
+					   void *thr_data __maybe_unused)
 {
=20
 	if (function_name) {
--=20
2.30.2

