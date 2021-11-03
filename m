Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BE2444AA8
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 23:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhKCWLi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 18:11:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47944 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230221AbhKCWLi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 18:11:38 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3KAlXZ022019
        for <bpf@vger.kernel.org>; Wed, 3 Nov 2021 15:09:01 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddpgpfh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 15:09:01 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 15:09:00 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DAC597D65E53; Wed,  3 Nov 2021 15:08:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 05/12] libbpf: stop using to-be-deprecated APIs
Date:   Wed, 3 Nov 2021 15:08:38 -0700
Message-ID: <20211103220845.2676888-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103220845.2676888-1-andrii@kernel.org>
References: <20211103220845.2676888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: EE2gz9h_YQLJxhgQyB12EiHu2idiFHwG
X-Proofpoint-GUID: EE2gz9h_YQLJxhgQyB12EiHu2idiFHwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111030115
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
index 5751cade0f66..dfd15cc60ea7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7709,7 +7709,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 	return 0;
 
 err_unpin_maps:
-	while ((map = bpf_map__prev(map, obj))) {
+	while ((map = bpf_object__prev_map(obj, map))) {
 		if (!map->pin_path)
 			continue;
 
@@ -7789,7 +7789,7 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
 	return 0;
 
 err_unpin_programs:
-	while ((prog = bpf_program__prev(prog, obj))) {
+	while ((prog = bpf_object__prev_program(obj, prog))) {
 		char buf[PATH_MAX];
 		int len;
 
@@ -8130,9 +8130,11 @@ int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
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
@@ -8178,7 +8180,10 @@ int bpf_program__set_prep(struct bpf_program *prog, int nr_instances,
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

