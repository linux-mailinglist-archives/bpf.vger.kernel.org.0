Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534FA44078A
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 07:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhJ3FCd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59482 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbhJ3FCc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:32 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19U3LMEx016489
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:03 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0wq90btu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:02 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 22:00:01 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B7059783056B; Fri, 29 Oct 2021 21:59:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 07/14] libbpf: stop using to-be-deprecated APIs
Date:   Fri, 29 Oct 2021 21:59:34 -0700
Message-ID: <20211030045941.3514948-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: xDmZ_Vak07HicZ8Hzt7FFA-bwFiaC8-_
X-Proofpoint-GUID: xDmZ_Vak07HicZ8Hzt7FFA-bwFiaC8-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 mlxlogscore=993 priorityscore=1501 clxscore=1015 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove all the internal uses of libbpf APIs that are slated to be
deprecated in v0.7.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d9f99acc0c1f..16a3effbf330 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7683,7 +7683,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 	return 0;
 
 err_unpin_maps:
-	while ((map = bpf_map__prev(map, obj))) {
+	while ((map = bpf_object__prev_map(obj, map))) {
 		if (!map->pin_path)
 			continue;
 
@@ -7763,7 +7763,7 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
 	return 0;
 
 err_unpin_programs:
-	while ((prog = bpf_program__prev(prog, obj))) {
+	while ((prog = bpf_object__prev_program(obj, prog))) {
 		char buf[PATH_MAX];
 		int len;
 
@@ -8104,9 +8104,11 @@ int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 	return 0;
 }
 
+static int bpf_program_nth_fd(const struct bpf_program *prog, int n);
+
 int bpf_program__fd(const struct bpf_program *prog)
 {
-	return bpf_program__nth_fd(prog, 0);
+	return bpf_program_nth_fd(prog, 0);
 }
 
 size_t bpf_program__size(const struct bpf_program *prog)
@@ -8152,7 +8154,10 @@ int bpf_program__set_prep(struct bpf_program *prog, int nr_instances,
 	return 0;
 }
 
-int bpf_program__nth_fd(const struct bpf_program *prog, int n)
+__attribute__((alias("bpf_program_nth_fd")))
+int bpf_program__nth_fd(const struct bpf_program *prog, int n);
+
+static int bpf_program_nth_fd(const struct bpf_program *prog, int n)
 {
 	int fd;
 
-- 
2.30.2

