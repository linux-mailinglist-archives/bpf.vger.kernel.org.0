Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8B42498E
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbhJFWXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 18:23:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55978 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239223AbhJFWX3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 18:23:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196Ksxiu023994
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 15:21:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=tE1gh+cDMstjNrOoX7wS2SwzPIWV0vjMmBRZHLFeCLk=;
 b=VvQpxn8EXlhhjZ/MQT7qsgKhKA3rksXupHJqjzQh19ogdkcaDAYg5In8tf7zr+P2wBGt
 QmQ2BBDMED8APSWyh0qisLnCocR6/wanJJXMJDi9g5WDrzn8R1BGqgHYs+Qo6e0NdO8T
 6n1cQrpIYTpKLVJJ7PXg9xPIiM2vsVTuygk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhk8eghgv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 15:21:37 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 15:21:36 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id EC1A23451896; Wed,  6 Oct 2021 15:21:29 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next v4 5/5] bpf/benchs: Add benchmarks for comparing hashmap lookups w/ vs. w/out bloom filter
Date:   Wed, 6 Oct 2021 15:21:03 -0700
Message-ID: <20211006222103.3631981-6-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006222103.3631981-1-joannekoong@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: Vk4Ce5_62UDBt9dG-cfaOdC1eNzLz30S
X-Proofpoint-ORIG-GUID: Vk4Ce5_62UDBt9dG-cfaOdC1eNzLz30S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds benchmark tests for comparing the performance of hashmap
lookups without the bloom filter vs. hashmap lookups with the bloom filte=
r.

Checking the bloom filter first for whether the element exists should
overall enable a higher throughput for hashmap lookups, since if the
element does not exist in the bloom filter, we can avoid a costly lookup =
in
the hashmap.

On average, using 5 hash functions in the bloom filter tended to perform
the best across the widest range of different entry sizes. The benchmark
results using 5 hash functions (running on 8 threads on a machine with on=
e
numa node, and taking the average of 3 runs) were roughly as follows:

value_size =3D 4 bytes -
	10k entries: 30% faster
	50k entries: 50% faster
	100k entries: 55% faster
	500k entres: 80% faster
	1 million entries: 120% faster
	5 million entries: 135% faster

value_size =3D 8 bytes -
	10k entries: 35% faster
	50k entries: 55% faster
	100k entries: 70% faster
	500k entres: 110% faster
	1 million entries: 215% faster
	5 million entries: 215% faster

value_size =3D 16 bytes -
	10k entries: 5% slower
	50k entries: 25% faster
	100k entries: 35% faster
	500k entres: 105% faster
	1 million entries: 130% faster
	5 million entries: 105% faster

value_size =3D 40 bytes -
	10k entries: 5% slower
	50k entries: 10% faster
	100k entries: 20% faster
	500k entres: 45% faster
	1 million entries: 60% faster
	5 million entries: 75% faster

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 tools/testing/selftests/bpf/bench.c           | 22 ++++++++---
 .../bpf/benchs/bench_bloom_filter_map.c       | 37 +++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  | 17 +++++++++
 .../selftests/bpf/benchs/run_common.sh        | 12 ++++++
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
index e836bacd6f9d..d9661f343556 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -92,20 +92,21 @@ void hits_drops_report_progress(int iter, struct benc=
h_res *res, long delta_ns)
 	printf("Iter %3d (%7.3lfus): ",
 	       iter, (delta_ns - 1000000000) / 1000.0);
=20
-	printf("hits %8.3lfM/s (%7.3lfM/prod), drops %8.3lfM/s\n",
-	       hits_per_sec, hits_per_prod, drops_per_sec);
+	printf("hits %8.3lfM/s (%7.3lfM/prod), drops %8.3lfM/s, total operation=
s %8.3lfM/s\n",
+	       hits_per_sec, hits_per_prod, drops_per_sec, hits_per_sec + drops=
_per_sec);
 }
=20
 void hits_drops_report_final(struct bench_res res[], int res_cnt)
 {
 	int i;
-	double hits_mean =3D 0.0, drops_mean =3D 0.0;
-	double hits_stddev =3D 0.0, drops_stddev =3D 0.0;
+	double hits_mean =3D 0.0, drops_mean =3D 0.0, total_ops_mean =3D 0.0;
+	double hits_stddev =3D 0.0, drops_stddev =3D 0.0, total_ops_stddev =3D =
0.0;
=20
 	for (i =3D 0; i < res_cnt; i++) {
 		hits_mean +=3D res[i].hits / 1000000.0 / (0.0 + res_cnt);
 		drops_mean +=3D res[i].drops / 1000000.0 / (0.0 + res_cnt);
 	}
+	total_ops_mean =3D hits_mean + drops_mean;
=20
 	if (res_cnt > 1)  {
 		for (i =3D 0; i < res_cnt; i++) {
@@ -115,14 +116,21 @@ void hits_drops_report_final(struct bench_res res[]=
, int res_cnt)
 			drops_stddev +=3D (drops_mean - res[i].drops / 1000000.0) *
 					(drops_mean - res[i].drops / 1000000.0) /
 					(res_cnt - 1.0);
+			total_ops_stddev +=3D (total_ops_mean -
+					(res[i].hits + res[i].drops) / 1000000.0) *
+					(total_ops_mean - (res[i].hits + res[i].drops) / 1000000.0)
+					/ (res_cnt - 1.0);
 		}
 		hits_stddev =3D sqrt(hits_stddev);
 		drops_stddev =3D sqrt(drops_stddev);
+		total_ops_stddev =3D sqrt(total_ops_stddev);
 	}
 	printf("Summary: hits %8.3lf \u00B1 %5.3lfM/s (%7.3lfM/prod), ",
 	       hits_mean, hits_stddev, hits_mean / env.producer_cnt);
-	printf("drops %8.3lf \u00B1 %5.3lfM/s\n",
+	printf("drops %8.3lf \u00B1 %5.3lfM/s, ",
 	       drops_mean, drops_stddev);
+	printf("total operations %8.3lf \u00B1 %5.3lfM/s\n",
+	       total_ops_mean, total_ops_stddev);
 }
=20
 const char *argp_program_version =3D "benchmark";
@@ -357,6 +365,8 @@ extern const struct bench bench_pb_custom;
 extern const struct bench bench_bloom_filter_lookup;
 extern const struct bench bench_bloom_filter_update;
 extern const struct bench bench_bloom_filter_false_positive;
+extern const struct bench bench_hashmap_without_bloom_filter;
+extern const struct bench bench_hashmap_with_bloom_filter;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -381,6 +391,8 @@ static const struct bench *benchs[] =3D {
 	&bench_bloom_filter_lookup,
 	&bench_bloom_filter_update,
 	&bench_bloom_filter_false_positive,
+	&bench_hashmap_without_bloom_filter,
+	&bench_hashmap_with_bloom_filter,
 };
=20
 static void setup_benchmark()
diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c =
b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 25d6b8179c8e..7af8fd455dc0 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -337,6 +337,21 @@ static void hashmap_lookup_setup(void)
 	}
 }
=20
+static void hashmap_no_bloom_filter_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.skel =3D setup_skeleton(false);
+
+	populate_maps();
+
+	link =3D bpf_program__attach(ctx.skel->progs.prog_bloom_filter_hashmap_=
lookup);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
 static void measure(struct bench_res *res)
 {
 	long total_hits =3D 0, total_drops =3D 0, total_false_hits =3D 0;
@@ -409,3 +424,25 @@ const struct bench bench_bloom_filter_false_positive=
 =3D {
 	.report_progress =3D false_hits_report_progress,
 	.report_final =3D false_hits_report_final,
 };
+
+const struct bench bench_hashmap_without_bloom_filter =3D {
+	.name =3D "hashmap-without-bloom-filter",
+	.validate =3D validate,
+	.setup =3D hashmap_no_bloom_filter_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
+
+const struct bench bench_hashmap_with_bloom_filter =3D {
+	.name =3D "hashmap-with-bloom-filter",
+	.validate =3D validate,
+	.setup =3D hashmap_lookup_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_ma=
p.sh b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
index 5d4f84ad9973..a8cff64d0492 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
@@ -26,3 +26,20 @@ subtitle "value_size: $v bytes, # threads: $t, # hashe=
s: $h"
 done
 done
 done
+
+header "Hashmap without bitset vs. hashmap with bitset (throughput, 8 th=
reads)"
+for v in 2, 4, 8, 16, 40; do
+for h in {1..10}; do
+subtitle "# hashes: $h"
+	for e in 10000 50000 75000 100000 250000 500000 750000 1000000 2500000 =
5000000; do
+		printf "%'d entries -\n" $e
+		printf "\t"
+		summarize_total "Hashmap without bitset: " \
+			"$($RUN_BENCH --nr_hash_funcs $h --nr_entries $e --value_size $v -p 8=
 hashmap-without-bloom-filter)"
+		printf "\t"
+		summarize_total "Hashmap with bitset: " \
+			"$($RUN_BENCH --nr_hash_funcs $h --nr_entries $e --value_size $v -p 8=
 hashmap-with-bloom-filter)"
+	done
+	printf "\n"
+done
+done
diff --git a/tools/testing/selftests/bpf/benchs/run_common.sh b/tools/tes=
ting/selftests/bpf/benchs/run_common.sh
index 670f23b037c4..9a16be78b180 100644
--- a/tools/testing/selftests/bpf/benchs/run_common.sh
+++ b/tools/testing/selftests/bpf/benchs/run_common.sh
@@ -33,6 +33,11 @@ function percentage()
 	echo "$*" | sed -E "s/.*Percentage\s=3D\s+([0-9]+\.[0-9]+).*/\1/"
 }
=20
+function total()
+{
+	echo "$*" | sed -E "s/.*total operations\s+([0-9]+\.[0-9]+ =C2=B1 [0-9]=
+\.[0-9]+M\/s).*/\1/"
+}
+
 function summarize()
 {
 	bench=3D"$1"
@@ -46,3 +51,10 @@ function summarize_percentage()
 	summary=3D$(echo $2 | tail -n1)
 	printf "%-20s %s%%\n" "$bench" "$(percentage $summary)"
 }
+
+function summarize_total()
+{
+	bench=3D"$1"
+	summary=3D$(echo $2 | tail -n1)
+	printf "%-20s %s\n" "$bench" "$(total $summary)"
+}
--=20
2.30.2

