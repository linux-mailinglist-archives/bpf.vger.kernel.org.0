Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF7538838
	for <lists+bpf@lfdr.de>; Mon, 30 May 2022 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiE3U13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 May 2022 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiE3U11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 16:27:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E984F7220E
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 13:27:26 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U3g7cj014378
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 13:27:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TtfcFY+wB6BQ8DhT4o6s6H/nFwEdYFlT9jMIDM/QDkQ=;
 b=kY1XP51+ZuIs47qtmguJQU68ipClQrDU5PUCgYcfGIBHWfsnAYUn8bRXiMgNQsLJU6Iz
 Ap4vcGDT/B6hi+mwTcQcKuCPPhZWJ6+nr3yBKNF+QH8bQpRQgXjBu3RxGB5rB23SycmS
 /u/wrrnlrNt8Fc8FiJetMXoRFWs8uQ0QpoY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gbf2jjab9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 May 2022 13:27:26 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 30 May 2022 13:27:23 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 556608600711; Mon, 30 May 2022 13:27:12 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: refactor bench reporting functions
Date:   Mon, 30 May 2022 13:27:11 -0700
Message-ID: <20220530202711.2594486-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530202711.2594486-1-davemarchevsky@fb.com>
References: <20220530202711.2594486-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PR0xdhuz5tK4_pLJkC1bCYAevEMB3Rf6
X-Proofpoint-GUID: PR0xdhuz5tK4_pLJkC1bCYAevEMB3Rf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-30_09,2022-05-30_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The report_progress and report_final functions in bench.c do similar
calculation of mean and stddev, but each of these rewrites the entire
calculation. Add helpers which calculate mean and stddev for simple
fields of struct bench_res, or in the case of total_ops, sum of two
fields, and move all extant calculations of mean and stddev to use
the helpers.

Also add some macros for unit conversion constants to improve
readability.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/testing/selftests/bpf/bench.c | 156 +++++++++++++++++-----------
 1 file changed, 95 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
index 32399554f89b..0383bcd0e009 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -28,6 +28,62 @@ static int libbpf_print_fn(enum libbpf_print_level lev=
el,
 	return vfprintf(stderr, format, args);
 }
=20
+#define benchres_getter(field) bench_res__ ## field
+#define DEFINE_BENCHRES_GETTER(field) \
+static long benchres_getter(field)(struct bench_res *res) { return res->=
field; }
+
+DEFINE_BENCHRES_GETTER(hits);
+DEFINE_BENCHRES_GETTER(drops);
+DEFINE_BENCHRES_GETTER(important_hits);
+static long benchres_getter(total_ops)(struct bench_res *res)
+{
+	return res->hits + res->drops;
+}
+
+static double calc_mean_long(struct bench_res res[], int res_cnt,
+			     long (*fn)(struct bench_res *res))
+{
+	double sum;
+	int i;
+
+	for (i =3D 0, sum =3D 0; i < res_cnt; i++)
+		sum +=3D fn(&res[i]);
+	return sum / res_cnt;
+}
+
+#define calc_mean_hits(res, res_cnt) calc_mean_long(res, res_cnt, benchr=
es_getter(hits))
+#define calc_mean_drops(res, res_cnt) calc_mean_long(res, res_cnt, bench=
res_getter(drops))
+#define calc_mean_important_hits(res, res_cnt) \
+	calc_mean_long(res, res_cnt, benchres_getter(important_hits))
+#define calc_mean_total_ops(res, res_cnt) calc_mean_long(res, res_cnt, b=
enchres_getter(total_ops))
+
+static double calc_stddev_long(struct bench_res res[], int res_cnt,
+			       double mean, long (*fn)(struct bench_res *res))
+{
+	double sum;
+	long val;
+	int i;
+
+	for (i =3D 0, sum =3D 0; i < res_cnt; i++) {
+		val =3D fn(&res[i]);
+		sum +=3D (mean - val) * (mean - val) / (res_cnt - 1.0);
+	}
+	return sqrt(sum);
+}
+
+#define calc_stddev_hits(res, res_cnt, mean) \
+	calc_stddev_long(res, res_cnt, mean, benchres_getter(hits))
+#define calc_stddev_drops(res, res_cnt, mean) \
+	calc_stddev_long(res, res_cnt, mean, benchres_getter(drops))
+#define calc_stddev_important_hits(res, res_cnt, mean) \
+	calc_stddev_long(res, res_cnt, mean, benchres_getter(important_hits))
+#define calc_stddev_total_ops(res, res_cnt, mean) \
+	calc_stddev_long(res, res_cnt, mean, benchres_getter(total_ops))
+
+#define NS_IN_SEC   1000000000
+#define NS_IN_SEC_F 1000000000.0
+#define MILLION_F   1000000.0
+
 void setup_libbpf(void)
 {
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
@@ -39,7 +95,7 @@ void false_hits_report_progress(int iter, struct bench_=
res *res, long delta_ns)
 	long total =3D res->false_hits  + res->hits + res->drops;
=20
 	printf("Iter %3d (%7.3lfus): ",
-	       iter, (delta_ns - 1000000000) / 1000.0);
+	       iter, (delta_ns - NS_IN_SEC) / 1000.0);
=20
 	printf("%ld false hits of %ld total operations. Percentage =3D %2.2f %%=
\n",
 	       res->false_hits, total, ((float)res->false_hits / total) * 100);
@@ -68,12 +124,12 @@ void hits_drops_report_progress(int iter, struct ben=
ch_res *res, long delta_ns)
 	double hits_per_sec, drops_per_sec;
 	double hits_per_prod;
=20
-	hits_per_sec =3D res->hits / 1000000.0 / (delta_ns / 1000000000.0);
+	hits_per_sec =3D res->hits / MILLION_F / (delta_ns / NS_IN_SEC_F);
 	hits_per_prod =3D hits_per_sec / env.producer_cnt;
-	drops_per_sec =3D res->drops / 1000000.0 / (delta_ns / 1000000000.0);
+	drops_per_sec =3D res->drops / MILLION_F / (delta_ns / NS_IN_SEC_F);
=20
 	printf("Iter %3d (%7.3lfus): ",
-	       iter, (delta_ns - 1000000000) / 1000.0);
+	       iter, (delta_ns - NS_IN_SEC) / 1000.0);
=20
 	printf("hits %8.3lfM/s (%7.3lfM/prod), drops %8.3lfM/s, total operation=
s %8.3lfM/s\n",
 	       hits_per_sec, hits_per_prod, drops_per_sec, hits_per_sec + drops=
_per_sec);
@@ -81,34 +137,26 @@ void hits_drops_report_progress(int iter, struct ben=
ch_res *res, long delta_ns)
=20
 void hits_drops_report_final(struct bench_res res[], int res_cnt)
 {
-	int i;
 	double hits_mean =3D 0.0, drops_mean =3D 0.0, total_ops_mean =3D 0.0;
 	double hits_stddev =3D 0.0, drops_stddev =3D 0.0, total_ops_stddev =3D =
0.0;
-	double total_ops;
=20
-	for (i =3D 0; i < res_cnt; i++) {
-		hits_mean +=3D res[i].hits / 1000000.0 / (0.0 + res_cnt);
-		drops_mean +=3D res[i].drops / 1000000.0 / (0.0 + res_cnt);
-	}
-	total_ops_mean =3D hits_mean + drops_mean;
+	hits_mean =3D calc_mean_hits(res, res_cnt);
+	drops_mean =3D calc_mean_drops(res, res_cnt);
+	total_ops_mean =3D calc_mean_total_ops(res, res_cnt);
=20
 	if (res_cnt > 1)  {
-		for (i =3D 0; i < res_cnt; i++) {
-			hits_stddev +=3D (hits_mean - res[i].hits / 1000000.0) *
-				       (hits_mean - res[i].hits / 1000000.0) /
-				       (res_cnt - 1.0);
-			drops_stddev +=3D (drops_mean - res[i].drops / 1000000.0) *
-					(drops_mean - res[i].drops / 1000000.0) /
-					(res_cnt - 1.0);
-			total_ops =3D res[i].hits + res[i].drops;
-			total_ops_stddev +=3D (total_ops_mean - total_ops / 1000000.0) *
-					(total_ops_mean - total_ops / 1000000.0) /
-					(res_cnt - 1.0);
-		}
-		hits_stddev =3D sqrt(hits_stddev);
-		drops_stddev =3D sqrt(drops_stddev);
-		total_ops_stddev =3D sqrt(total_ops_stddev);
+		hits_stddev =3D calc_stddev_hits(res, res_cnt, hits_mean);
+		drops_stddev =3D calc_stddev_drops(res, res_cnt, drops_mean);
+		total_ops_stddev =3D calc_stddev_total_ops(res, res_cnt, total_ops_mea=
n);
 	}
+
+	hits_mean /=3D MILLION_F;
+	drops_mean /=3D MILLION_F;
+	total_ops_mean /=3D MILLION_F;
+	hits_stddev /=3D MILLION_F;
+	drops_stddev /=3D MILLION_F;
+	total_ops_stddev /=3D MILLION_F;
+
 	printf("Summary: hits %8.3lf \u00B1 %5.3lfM/s (%7.3lfM/prod), ",
 	       hits_mean, hits_stddev, hits_mean / env.producer_cnt);
 	printf("drops %8.3lf \u00B1 %5.3lfM/s, ",
@@ -121,10 +169,10 @@ void ops_report_progress(int iter, struct bench_res=
 *res, long delta_ns)
 {
 	double hits_per_sec, hits_per_prod;
=20
-	hits_per_sec =3D res->hits / 1000000.0 / (delta_ns / 1000000000.0);
+	hits_per_sec =3D res->hits / MILLION_F / (delta_ns / NS_IN_SEC_F);
 	hits_per_prod =3D hits_per_sec / env.producer_cnt;
=20
-	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0)=
;
+	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - NS_IN_SEC) / 1000.0);
=20
 	printf("hits %8.3lfM/s (%7.3lfM/prod)\n", hits_per_sec, hits_per_prod);
 }
@@ -132,19 +180,13 @@ void ops_report_progress(int iter, struct bench_res=
 *res, long delta_ns)
 void ops_report_final(struct bench_res res[], int res_cnt)
 {
 	double hits_mean =3D 0.0, hits_stddev =3D 0.0;
-	int i;
-
-	for (i =3D 0; i < res_cnt; i++)
-		hits_mean +=3D res[i].hits / 1000000.0 / (0.0 + res_cnt);
=20
-	if (res_cnt > 1)  {
-		for (i =3D 0; i < res_cnt; i++)
-			hits_stddev +=3D (hits_mean - res[i].hits / 1000000.0) *
-				       (hits_mean - res[i].hits / 1000000.0) /
-				       (res_cnt - 1.0);
+	hits_mean =3D calc_mean_hits(res, res_cnt);
+	if (res_cnt > 1)
+		hits_stddev =3D calc_stddev_hits(res, res_cnt, hits_mean);
+	hits_mean /=3D MILLION_F;
+	hits_stddev /=3D MILLION_F;
=20
-		hits_stddev =3D sqrt(hits_stddev);
-	}
 	printf("Summary: throughput %8.3lf \u00B1 %5.3lf M ops/s (%7.3lfM ops/p=
rod), ",
 	       hits_mean, hits_stddev, hits_mean / env.producer_cnt);
 	printf("latency %8.3lf ns/op\n", 1000.0 / hits_mean * env.producer_cnt)=
;
@@ -154,12 +196,12 @@ void local_storage_report_progress(int iter, struct=
 bench_res *res,
 				   long delta_ns)
 {
 	double important_hits_per_sec, hits_per_sec;
-	double delta_sec =3D delta_ns / 1000000000.0;
+	double delta_sec =3D delta_ns / NS_IN_SEC_F;
=20
-	hits_per_sec =3D res->hits / 1000000.0 / delta_sec;
-	important_hits_per_sec =3D res->important_hits / 1000000.0 / delta_sec;
+	hits_per_sec =3D res->hits / MILLION_F / delta_sec;
+	important_hits_per_sec =3D res->important_hits / MILLION_F / delta_sec;
=20
-	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0)=
;
+	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - NS_IN_SEC) / 1000.0);
=20
 	printf("hits %8.3lfM/s ", hits_per_sec);
 	printf("important_hits %8.3lfM/s\n", important_hits_per_sec);
@@ -169,27 +211,19 @@ void local_storage_report_final(struct bench_res re=
s[], int res_cnt)
 {
 	double important_hits_mean =3D 0.0, important_hits_stddev =3D 0.0;
 	double hits_mean =3D 0.0, hits_stddev =3D 0.0;
-	int i;
=20
-	for (i =3D 0; i < res_cnt; i++) {
-		hits_mean +=3D res[i].hits / 1000000.0 / (0.0 + res_cnt);
-		important_hits_mean +=3D res[i].important_hits / 1000000.0 / (0.0 + re=
s_cnt);
+	hits_mean =3D calc_mean_hits(res, res_cnt);
+	important_hits_mean =3D calc_mean_important_hits(res, res_cnt);
+	if (res_cnt > 1) {
+		hits_stddev =3D calc_stddev_hits(res, res_cnt, hits_mean);
+		important_hits_stddev =3D
+			calc_stddev_important_hits(res, res_cnt, important_hits_mean);
 	}
+	hits_mean /=3D MILLION_F;
+	important_hits_mean /=3D MILLION_F;
+	hits_stddev /=3D MILLION_F;
+	important_hits_stddev /=3D MILLION_F;
=20
-	if (res_cnt > 1)  {
-		for (i =3D 0; i < res_cnt; i++) {
-			hits_stddev +=3D (hits_mean - res[i].hits / 1000000.0) *
-				       (hits_mean - res[i].hits / 1000000.0) /
-				       (res_cnt - 1.0);
-			important_hits_stddev +=3D
-				       (important_hits_mean - res[i].important_hits / 1000000.0) *
-				       (important_hits_mean - res[i].important_hits / 1000000.0) /
-				       (res_cnt - 1.0);
-		}
-
-		hits_stddev =3D sqrt(hits_stddev);
-		important_hits_stddev =3D sqrt(important_hits_stddev);
-	}
 	printf("Summary: hits throughput %8.3lf \u00B1 %5.3lf M ops/s, ",
 	       hits_mean, hits_stddev);
 	printf("hits latency %8.3lf ns/op, ", 1000.0 / hits_mean);
--=20
2.30.2

