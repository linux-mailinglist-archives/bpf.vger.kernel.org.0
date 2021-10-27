Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605A343D7BF
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 01:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJ0Xuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 19:50:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26704 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229447AbhJ0Xup (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 19:50:45 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RLfRGb013677
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:48:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=YYx22NjXFnkiU0gOfmAeuRhd34PmFVkaVEmibAFNfxA=;
 b=MCcxCqptd2WPOnjlcPISLs4JNabF9Ptd3ll4LkOnKGerEnflKKj2i51WVTg160sl4GQx
 8tI/QN9xyzw29lA4eGMOJzZp0TyQbSa2zZ16E4Cqq2ZbOJ/LpsQliw/7xcjyTqjK7TXX
 tov0MT4B1Oe0h3d7gSdttIHgJ2hrJXhP8yo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3by64s72cf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:48:19 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 16:48:17 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id C5456421C73C; Wed, 27 Oct 2021 16:45:18 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v6 bpf-next 5/5] bpf/benchs: Add benchmarks for comparing hashmap lookups w/ vs. w/out bloom filter
Date:   Wed, 27 Oct 2021 16:45:04 -0700
Message-ID: <20211027234504.30744-6-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027234504.30744-1-joannekoong@fb.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: hmDSlHgJ0CRddyhBCbEqkpfracDIlv9e
X-Proofpoint-GUID: hmDSlHgJ0CRddyhBCbEqkpfracDIlv9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_07,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270130
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
	50k entries: 40% faster
	100k entries: 40% faster
	500k entres: 70% faster
	1 million entries: 90% faster
	5 million entries: 140% faster

value_size =3D 8 bytes -
	10k entries: 30% faster
	50k entries: 40% faster
	100k entries: 50% faster
	500k entres: 80% faster
	1 million entries: 100% faster
	5 million entries: 150% faster

value_size =3D 16 bytes -
	10k entries: 20% faster
	50k entries: 30% faster
	100k entries: 35% faster
	500k entres: 65% faster
	1 million entries: 85% faster
	5 million entries: 110% faster

value_size =3D 40 bytes -
	10k entries: 5% faster
	50k entries: 15% faster
	100k entries: 20% faster
	500k entres: 65% faster
	1 million entries: 75% faster
	5 million entries: 120% faster

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 tools/testing/selftests/bpf/bench.c           | 23 ++++++--
 .../bpf/benchs/bench_bloom_filter_map.c       | 57 +++++++++++++++++++
 .../bpf/benchs/run_bench_bloom_filter_map.sh  | 17 ++++++
 .../selftests/bpf/benchs/run_common.sh        | 12 ++++
 4 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
index a1d5dffe5ef6..cc4722f693e9 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -92,20 +92,22 @@ void hits_drops_report_progress(int iter, struct benc=
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
+	double total_ops;
=20
 	for (i =3D 0; i < res_cnt; i++) {
 		hits_mean +=3D res[i].hits / 1000000.0 / (0.0 + res_cnt);
 		drops_mean +=3D res[i].drops / 1000000.0 / (0.0 + res_cnt);
 	}
+	total_ops_mean =3D hits_mean + drops_mean;
=20
 	if (res_cnt > 1)  {
 		for (i =3D 0; i < res_cnt; i++) {
@@ -115,14 +117,21 @@ void hits_drops_report_final(struct bench_res res[]=
, int res_cnt)
 			drops_stddev +=3D (drops_mean - res[i].drops / 1000000.0) *
 					(drops_mean - res[i].drops / 1000000.0) /
 					(res_cnt - 1.0);
+			total_ops =3D res[i].hits + res[i].drops;
+			total_ops_stddev +=3D (total_ops_mean - total_ops / 1000000.0) *
+					(total_ops_mean - total_ops / 1000000.0) /
+					(res_cnt - 1.0);
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
@@ -357,6 +366,8 @@ extern const struct bench bench_pb_custom;
 extern const struct bench bench_bloom_lookup;
 extern const struct bench bench_bloom_update;
 extern const struct bench bench_bloom_false_positive;
+extern const struct bench bench_hashmap_without_bloom;
+extern const struct bench bench_hashmap_with_bloom;
=20
 static const struct bench *benchs[] =3D {
 	&bench_count_global,
@@ -381,6 +392,8 @@ static const struct bench *benchs[] =3D {
 	&bench_bloom_lookup,
 	&bench_bloom_update,
 	&bench_bloom_false_positive,
+	&bench_hashmap_without_bloom,
+	&bench_hashmap_with_bloom,
 };
=20
 static void setup_benchmark()
diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c =
b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 4bafad418a8a..6eeeed2913e6 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -346,6 +346,41 @@ static void false_positive_setup(void)
 	}
 }
=20
+static void hashmap_with_bloom_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.use_hashmap =3D true;
+	ctx.hashmap_use_bloom =3D true;
+
+	ctx.skel =3D setup_skeleton();
+
+	populate_maps();
+
+	link =3D bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+static void hashmap_no_bloom_setup(void)
+{
+	struct bpf_link *link;
+
+	ctx.use_hashmap =3D true;
+
+	ctx.skel =3D setup_skeleton();
+
+	populate_maps();
+
+	link =3D bpf_program__attach(ctx.skel->progs.bloom_hashmap_lookup);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
 static void measure(struct bench_res *res)
 {
 	unsigned long total_hits =3D 0, total_drops =3D 0, total_false_hits =3D=
 0;
@@ -418,3 +453,25 @@ const struct bench bench_bloom_false_positive =3D {
 	.report_progress =3D false_hits_report_progress,
 	.report_final =3D false_hits_report_final,
 };
+
+const struct bench bench_hashmap_without_bloom =3D {
+	.name =3D "hashmap-without-bloom",
+	.validate =3D validate,
+	.setup =3D hashmap_no_bloom_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
+
+const struct bench bench_hashmap_with_bloom =3D {
+	.name =3D "hashmap-with-bloom",
+	.validate =3D validate,
+	.setup =3D hashmap_with_bloom_setup,
+	.producer_thread =3D producer,
+	.consumer_thread =3D consumer,
+	.measure =3D measure,
+	.report_progress =3D hits_drops_report_progress,
+	.report_final =3D hits_drops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_ma=
p.sh b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
index d03d0e5c91cd..8ffd385ab2f4 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
@@ -26,3 +26,20 @@ subtitle "value_size: $v bytes, # threads: $t, # hashe=
s: $h"
 done
 done
 done
+
+header "Hashmap without bloom filter vs. hashmap with bloom filter (thro=
ughput, 8 threads)"
+for v in 2 4 8 16 40; do
+for h in {1..10}; do
+subtitle "value_size: $v, # hashes: $h"
+	for e in 10000 50000 75000 100000 250000 500000 750000 1000000 2500000 =
5000000; do
+		printf "%'d entries -\n" $e
+		printf "\t"
+		summarize_total "Hashmap without bloom filter: " \
+			"$($RUN_BENCH --nr_hash_funcs $h --nr_entries $e --value_size $v -p 8=
 hashmap-without-bloom)"
+		printf "\t"
+		summarize_total "Hashmap with bloom filter: " \
+			"$($RUN_BENCH --nr_hash_funcs $h --nr_entries $e --value_size $v -p 8=
 hashmap-with-bloom)"
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

