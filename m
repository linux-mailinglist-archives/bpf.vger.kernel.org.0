Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1C49C27C
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 05:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbiAZEHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 23:07:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237509AbiAZEHI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 23:07:08 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20PMO1uk003790
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:07:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4mFSaPc3keKHilpmEs9b8g+hJ44EVpIzYvyHaxnLpnM=;
 b=NoH96/f4/vwOLPF/yyIrLn+nWw0fDmPnFEp2++WUGoQUSlZQIFTRaqbJirn9PgRkcvww
 pZJhV2bSWEHuGDo5jOkHVvoTONyfqG7ULUL84tsro2qJ2bF2gZUEXEZUuJnxwLoqI+mK
 ihCGx8CNw6cMrmYrKdgxK9pvNhCVX/Q9CtE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dtmrwux8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:07:07 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 20:07:06 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 456E12C1E2B4; Tue, 25 Jan 2022 20:07:00 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <dwarves@vger.kernel.org>, <arnaldo.melo@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves v3 3/4] pahole: Use per-thread btf instances to avoid mutex locking.
Date:   Tue, 25 Jan 2022 20:05:08 -0800
Message-ID: <20220126040509.1862767-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126040509.1862767-1-kuifeng@fb.com>
References: <20220126040509.1862767-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -PwOILxsU-ulcXsJ0aLWelVnPw8wY5Cw
X-Proofpoint-ORIG-GUID: -PwOILxsU-ulcXsJ0aLWelVnPw8wY5Cw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_01,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Create an instance of btf for each worker thread, and add type info to
the local btf instance in the steal-function of pahole without mutex
acquiring.  Once finished with all worker threads, merge all
per-thread btf instances to the primary btf instance.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 btf_encoder.c |   5 +++
 btf_encoder.h |   2 +
 pahole.c      | 121 ++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 120 insertions(+), 8 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9d015f304e92..56a76f5d7275 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1529,3 +1529,8 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu)
 out:
 	return err;
 }
+
+struct btf *btf_encoder__btf(struct btf_encoder *encoder)
+{
+	return encoder->btf;
+}
diff --git a/btf_encoder.h b/btf_encoder.h
index f133b0d7674d..0f0eee84df74 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -29,4 +29,6 @@ struct btf_encoder *btf_encoders__first(struct list_hea=
d *encoders);
=20
 struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder);
=20
+struct btf *btf_encoder__btf(struct btf_encoder *encoder);
+
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index f3eeaaca4cdf..525eb4d90b08 100644
--- a/pahole.c
+++ b/pahole.c
@@ -29,6 +29,7 @@
 #include "btf_encoder.h"
=20
 static struct btf_encoder *btf_encoder;
+static pthread_mutex_t btf_encoder_lock =3D PTHREAD_MUTEX_INITIALIZER;
 static char *detached_btf_filename;
 static bool btf_encode;
 static bool btf_gen_floats;
@@ -2798,6 +2799,65 @@ out:
=20
 static struct type_instance *header;
=20
+struct thread_data {
+	struct btf *btf;
+	struct btf_encoder *encoder;
+};
+
+static int pahole_threads_prepare(struct conf_load *conf, int nr_threads=
, void **thr_data)
+{
+	int i;
+	struct thread_data *threads =3D calloc(sizeof(struct thread_data), nr_t=
hreads);
+
+	for (i =3D 0; i < nr_threads; i++)
+		thr_data[i] =3D threads + i;
+
+	return 0;
+}
+
+static int pahole_thread_exit(struct conf_load *conf, void *thr_data)
+{
+	struct thread_data *thread =3D thr_data;
+
+	if (thread =3D=3D NULL)
+		return 0;
+
+	/*
+	 * Here we will call btf__dedup() here once we extend
+	 * btf__dedup().
+	 */
+
+	if (thread->encoder =3D=3D btf_encoder) {
+		/* Release the lock acuqired when created btf_encoder */
+		pthread_mutex_unlock(&btf_encoder_lock);
+		return 0;
+	}
+
+	pthread_mutex_lock(&btf_encoder_lock);
+	btf__add_btf(btf_encoder__btf(btf_encoder), thread->btf);
+	pthread_mutex_unlock(&btf_encoder_lock);
+
+	btf_encoder__delete(thread->encoder);
+	thread->encoder =3D NULL;
+
+	return 0;
+}
+
+static int pahole_threads_collect(struct conf_load *conf, int nr_threads=
, void **thr_data,
+				  int error)
+{
+	struct thread_data **threads =3D (struct thread_data **)thr_data;
+	int i;
+
+	for (i =3D 0; i < nr_threads; i++) {
+		if (threads[i]->encoder && threads[i]->encoder !=3D btf_encoder)
+			btf_encoder__delete(threads[i]->encoder);
+	}
+	free(threads[0]);
+
+	return 0;
+}
+
 static enum load_steal_kind pahole_stealer(struct cu *cu,
 					   struct conf_load *conf_load,
 					   void *thr_data)
@@ -2819,30 +2879,72 @@ static enum load_steal_kind pahole_stealer(struct=
 cu *cu,
=20
 	if (btf_encode) {
 		static pthread_mutex_t btf_lock =3D PTHREAD_MUTEX_INITIALIZER;
+		struct btf_encoder *encoder;
=20
-		pthread_mutex_lock(&btf_lock);
 		/*
 		 * FIXME:
 		 *
 		 * This should be really done at main(), but since in the current code=
base only at this
 		 * point we'll have cu->elf setup...
 		 */
+		pthread_mutex_lock(&btf_lock);
 		if (!btf_encoder) {
-			btf_encoder =3D btf_encoder__new(cu, detached_btf_filename, conf_load=
->base_btf, skip_encoding_btf_vars,
-						       btf_encode_force, btf_gen_floats, global_verbose);
-			if (btf_encoder =3D=3D NULL) {
-				ret =3D LSK__STOP_LOADING;
-				goto out_btf;
+			/*
+			 * btf_encoder is the primary encoder.
+			 * And, it is used by the thread
+			 * create it.
+			 */
+			btf_encoder =3D btf_encoder__new(cu, detached_btf_filename,
+						       conf_load->base_btf,
+						       skip_encoding_btf_vars,
+						       btf_encode_force,
+						       btf_gen_floats, global_verbose);
+			if (btf_encoder && thr_data) {
+				struct thread_data *thread =3D (struct thread_data *)thr_data;
+
+				thread->encoder =3D btf_encoder;
+				thread->btf =3D btf_encoder__btf(btf_encoder);
+				/* Will be relased by pahole_thread_exit() */
+				pthread_mutex_lock(&btf_encoder_lock);
 			}
 		}
+		pthread_mutex_unlock(&btf_lock);
+
+		if (btf_encoder =3D=3D NULL) {
+			ret =3D LSK__STOP_LOADING;
+			goto out_btf;
+		}
=20
-		if (btf_encoder__encode_cu(btf_encoder, cu)) {
+		/*
+		 * thr_data keeps per-thread data for worker threads.  Each worker thr=
ead
+		 * has an encoder.  The main thread will merge the data collected by a=
ll
+		 * these encoders to btf_encoder.  However, the first thread reaching =
this
+		 * function creates btf_encoder and reuses it as its local encoder.  I=
t
+		 * avoids copying the data collected by the first thread.
+		 */
+		if (thr_data) {
+			struct thread_data *thread =3D (struct thread_data *)thr_data;
+
+			if (thread->encoder =3D=3D NULL) {
+				thread->encoder =3D
+					btf_encoder__new(cu, detached_btf_filename,
+							 NULL,
+							 skip_encoding_btf_vars,
+							 btf_encode_force,
+							 btf_gen_floats,
+							 global_verbose);
+				thread->btf =3D btf_encoder__btf(thread->encoder);
+			}
+			encoder =3D thread->encoder;
+		} else
+			encoder =3D btf_encoder;
+
+		if (btf_encoder__encode_cu(encoder, cu)) {
 			fprintf(stderr, "Encountered error while encoding BTF.\n");
 			exit(1);
 		}
 		ret =3D LSK__DELETE;
 out_btf:
-		pthread_mutex_unlock(&btf_lock);
 		return ret;
 	}
 #if 0
@@ -3207,6 +3309,9 @@ int main(int argc, char *argv[])
 	memset(tab, ' ', sizeof(tab) - 1);
=20
 	conf_load.steal =3D pahole_stealer;
+	conf_load.thread_exit =3D pahole_thread_exit;
+	conf_load.threads_prepare =3D pahole_threads_prepare;
+	conf_load.threads_collect =3D pahole_threads_collect;
=20
 	// Make 'pahole --header type < file' a shorter form of 'pahole -C type=
 --count 1 < file'
 	if (conf.header_type && !class_name && prettify_input) {
--=20
2.30.2

