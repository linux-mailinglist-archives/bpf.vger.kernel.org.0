Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4102F495778
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 01:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378444AbiAUAln convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 19:41:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378441AbiAUAlm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 19:41:42 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L06XPu016325
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 16:41:42 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqj0gg4tw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 16:41:42 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 16:41:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 12AFAFCAD2B6; Thu, 20 Jan 2022 16:41:30 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 6/7] samples/bpf: use preferred getters/setters instead of deprecated ones
Date:   Thu, 20 Jan 2022 16:41:14 -0800
Message-ID: <20220121004115.3845888-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121004115.3845888-1-andrii@kernel.org>
References: <20220121004115.3845888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -ykUQCr6X8ILp_Gy72L6KE5FfKSAneFF
X-Proofpoint-ORIG-GUID: -ykUQCr6X8ILp_Gy72L6KE5FfKSAneFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_10,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=836
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201210002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use preferred setter and getter APIs instead of deprecated ones.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 samples/bpf/map_perf_test_user.c    | 2 +-
 samples/bpf/xdp_redirect_cpu_user.c | 2 +-
 samples/bpf/xdp_sample_user.c       | 2 +-
 samples/bpf/xdp_sample_user.h       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index 319fd31522f3..e69651a6902f 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -413,7 +413,7 @@ static void fixup_map(struct bpf_object *obj)
 		for (i = 0; i < NR_TESTS; i++) {
 			if (!strcmp(test_map_names[i], name) &&
 			    (check_test_flags(i))) {
-				bpf_map__resize(map, num_map_entries);
+				bpf_map__set_max_entries(map, num_map_entries);
 				continue;
 			}
 		}
diff --git a/samples/bpf/xdp_redirect_cpu_user.c b/samples/bpf/xdp_redirect_cpu_user.c
index a81704d3317b..5f74a70a9021 100644
--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ b/samples/bpf/xdp_redirect_cpu_user.c
@@ -70,7 +70,7 @@ static void print_avail_progs(struct bpf_object *obj)
 
 	printf(" Programs to be used for -p/--progname:\n");
 	bpf_object__for_each_program(pos, obj) {
-		if (bpf_program__is_xdp(pos)) {
+		if (bpf_program__type(pos) == BPF_PROG_TYPE_XDP) {
 			if (!strncmp(bpf_program__name(pos), "xdp_prognum",
 				     sizeof("xdp_prognum") - 1))
 				printf(" %s\n", bpf_program__name(pos));
diff --git a/samples/bpf/xdp_sample_user.c b/samples/bpf/xdp_sample_user.c
index 8740838e7767..44598df4c84b 100644
--- a/samples/bpf/xdp_sample_user.c
+++ b/samples/bpf/xdp_sample_user.c
@@ -1218,7 +1218,7 @@ int sample_setup_maps(struct bpf_map **maps)
 		default:
 			return -EINVAL;
 		}
-		if (bpf_map__resize(sample_map[i], sample_map_count[i]) < 0)
+		if (bpf_map__set_max_entries(sample_map[i], sample_map_count[i]) < 0)
 			return -errno;
 	}
 	sample_map[MAP_DEVMAP_XMIT_MULTI] = maps[MAP_DEVMAP_XMIT_MULTI];
diff --git a/samples/bpf/xdp_sample_user.h b/samples/bpf/xdp_sample_user.h
index 5f44b877ecf5..f45051679977 100644
--- a/samples/bpf/xdp_sample_user.h
+++ b/samples/bpf/xdp_sample_user.h
@@ -61,7 +61,7 @@ static inline char *safe_strncpy(char *dst, const char *src, size_t size)
 
 #define __attach_tp(name)                                                      \
 	({                                                                     \
-		if (!bpf_program__is_tracing(skel->progs.name))                \
+		if (bpf_program__type(skel->progs.name) != BPF_PROG_TYPE_TRACING)\
 			return -EINVAL;                                        \
 		skel->links.name = bpf_program__attach(skel->progs.name);      \
 		if (!skel->links.name)                                         \
-- 
2.30.2

