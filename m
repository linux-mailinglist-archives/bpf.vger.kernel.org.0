Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C284659D8
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353778AbhLAXcX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:32:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37724 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344113AbhLAXcU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:32:20 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LdEhk005768
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:28:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cp6tm5njv-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:28:59 -0800
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:28:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 178F0B7A0AC1; Wed,  1 Dec 2021 15:28:31 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/9] bpftool: migrate off of deprecated bpf_create_map_xattr() API
Date:   Wed, 1 Dec 2021 15:28:18 -0800
Message-ID: <20211201232824.3166325-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: L1OA86GHFuSDz26TIIDBQijaQV4btj6r
X-Proofpoint-GUID: L1OA86GHFuSDz26TIIDBQijaQV4btj6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=736 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to bpf_map_create() API instead.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/map.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 25b258804f11..cc530a229812 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1261,7 +1261,10 @@ static int do_pin(int argc, char **argv)
 
 static int do_create(int argc, char **argv)
 {
-	struct bpf_create_map_attr attr = { NULL, };
+	LIBBPF_OPTS(bpf_map_create_opts, attr);
+	enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
+	__u32 key_size = 0, value_size = 0, max_entries = 0;
+	const char *map_name = NULL;
 	const char *pinfile;
 	int err = -1, fd;
 
@@ -1276,30 +1279,30 @@ static int do_create(int argc, char **argv)
 		if (is_prefix(*argv, "type")) {
 			NEXT_ARG();
 
-			if (attr.map_type) {
+			if (map_type) {
 				p_err("map type already specified");
 				goto exit;
 			}
 
-			attr.map_type = map_type_from_str(*argv);
-			if ((int)attr.map_type < 0) {
+			map_type = map_type_from_str(*argv);
+			if ((int)map_type < 0) {
 				p_err("unrecognized map type: %s", *argv);
 				goto exit;
 			}
 			NEXT_ARG();
 		} else if (is_prefix(*argv, "name")) {
 			NEXT_ARG();
-			attr.name = GET_ARG();
+			map_name = GET_ARG();
 		} else if (is_prefix(*argv, "key")) {
-			if (parse_u32_arg(&argc, &argv, &attr.key_size,
+			if (parse_u32_arg(&argc, &argv, &key_size,
 					  "key size"))
 				goto exit;
 		} else if (is_prefix(*argv, "value")) {
-			if (parse_u32_arg(&argc, &argv, &attr.value_size,
+			if (parse_u32_arg(&argc, &argv, &value_size,
 					  "value size"))
 				goto exit;
 		} else if (is_prefix(*argv, "entries")) {
-			if (parse_u32_arg(&argc, &argv, &attr.max_entries,
+			if (parse_u32_arg(&argc, &argv, &max_entries,
 					  "max entries"))
 				goto exit;
 		} else if (is_prefix(*argv, "flags")) {
@@ -1340,14 +1343,14 @@ static int do_create(int argc, char **argv)
 		}
 	}
 
-	if (!attr.name) {
+	if (!map_name) {
 		p_err("map name not specified");
 		goto exit;
 	}
 
 	set_max_rlimit();
 
-	fd = bpf_create_map_xattr(&attr);
+	fd = bpf_map_create(map_type, map_name, key_size, value_size, max_entries, &attr);
 	if (fd < 0) {
 		p_err("map create failed: %s", strerror(errno));
 		goto exit;
-- 
2.30.2

