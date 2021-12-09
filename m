Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768A546DF79
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 01:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhLIAel convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Dec 2021 19:34:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241496AbhLIAeh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 19:34:37 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1B8HpSPk031969
        for <bpf@vger.kernel.org>; Wed, 8 Dec 2021 16:31:04 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3ctqvb6968-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 16:31:04 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 16:31:03 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D5287C51D6D2; Wed,  8 Dec 2021 16:30:51 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 08/12] libbpf: deprecate bpf_object__load_xattr()
Date:   Wed, 8 Dec 2021 16:30:29 -0800
Message-ID: <20211209003033.3962657-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209003033.3962657-1-andrii@kernel.org>
References: <20211209003033.3962657-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: F46SNZ-YTtvWJ5ReD0oN03k_RKEy_GA1
X-Proofpoint-GUID: F46SNZ-YTtvWJ5ReD0oN03k_RKEy_GA1
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate non-extensible bpf_object__load_xattr() in v0.8 ([0]).

With log_level control through bpf_object_open_opts or
bpf_program__set_log_level(), we are finally at the point where
bpf_object__load_xattr() doesn't provide any functionality that can't be
accessed through other (better) ways. The other feature,
target_btf_path, is also controllable through bpf_object_open_opts.

  [0] Closes: https://github.com/libbpf/libbpf/issues/289

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 23 ++++++++++-------------
 tools/lib/bpf/libbpf.h |  1 +
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e3e56bebd014..18d95c6a89fe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7462,14 +7462,10 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 	return 0;
 }
 
-int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
+static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const char *target_btf_path)
 {
-	struct bpf_object *obj;
 	int err, i;
 
-	if (!attr)
-		return libbpf_err(-EINVAL);
-	obj = attr->obj;
 	if (!obj)
 		return libbpf_err(-EINVAL);
 
@@ -7479,7 +7475,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	}
 
 	if (obj->gen_loader)
-		bpf_gen__init(obj->gen_loader, attr->log_level);
+		bpf_gen__init(obj->gen_loader, extra_log_level);
 
 	err = bpf_object__probe_loading(obj);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
@@ -7488,8 +7484,8 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	err = err ? : bpf_object__sanitize_maps(obj);
 	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
 	err = err ? : bpf_object__create_maps(obj);
-	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : attr->target_btf_path);
-	err = err ? : bpf_object__load_progs(obj, attr->log_level);
+	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
+	err = err ? : bpf_object__load_progs(obj, extra_log_level);
 	err = err ? : bpf_object_init_prog_arrays(obj);
 
 	if (obj->gen_loader) {
@@ -7534,13 +7530,14 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	return libbpf_err(err);
 }
 
-int bpf_object__load(struct bpf_object *obj)
+int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 {
-	struct bpf_object_load_attr attr = {
-		.obj = obj,
-	};
+	return bpf_object_load(attr->obj, attr->log_level, attr->target_btf_path);
+}
 
-	return bpf_object__load_xattr(&attr);
+int bpf_object__load(struct bpf_object *obj)
+{
+	return bpf_object_load(obj, 0, NULL);
 }
 
 static int make_parent_dir(const char *path)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index dacde55bebff..a8b894dae633 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -214,6 +214,7 @@ struct bpf_object_load_attr {
 
 /* Load/unload object into/from kernel */
 LIBBPF_API int bpf_object__load(struct bpf_object *obj);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__load() instead")
 LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
 LIBBPF_DEPRECATED_SINCE(0, 6, "bpf_object__unload() is deprecated, use bpf_object__close() instead")
 LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
-- 
2.30.2

