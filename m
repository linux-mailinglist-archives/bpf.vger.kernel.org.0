Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1607913D013
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 23:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgAOWXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 17:23:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22922 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730710AbgAOWXm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jan 2020 17:23:42 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FMMBij021514
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 14:23:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=VGswns7iuZEl51MOvzGuiL6n5XoXwg9qfgPFgvIJ7K4=;
 b=DHrrQQwkEw8sZNsJSsas7L36Z5itznlBjvCYNU3OX5jM/ZZ9i3HDa/AoVNqEtnb8QBOg
 5PKNIyq4qWCTMfWDHmdFefmMV0WhBVjXshZB82F2fsyN/FgOvoWOZ7T+VCZLg9w0uPhB
 rQr5vipPblOUHbd6hI5RtLZIcv2esR/p8Lo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhp0fnena-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 14:23:42 -0800
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 Jan 2020 14:23:25 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id A9FB9294163F; Wed, 15 Jan 2020 14:23:12 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 5/5] bpftool: Support dumping a map with btf_vmlinux_value_type_id
Date:   Wed, 15 Jan 2020 14:23:12 -0800
Message-ID: <20200115222312.948025-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115222241.945672-1-kafai@fb.com>
References: <20200115222241.945672-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_03:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=38
 mlxlogscore=679 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001150167
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch makes bpftool support dumping a map's value properly
when the map's value type is a type of the running kernel's btf.
(i.e. map_info.btf_vmlinux_value_type_id is set instead of
map_info.btf_value_type_id).  The first usecase is for the
BPF_MAP_TYPE_STRUCT_OPS.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/map.c | 62 +++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 4c5b15d736b6..33636f86bcbb 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -20,6 +20,7 @@
 #include "btf.h"
 #include "json_writer.h"
 #include "main.h"
+#include "libbpf_internal.h"
 
 const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_UNSPEC]			= "unspec",
@@ -252,6 +253,7 @@ static int do_dump_btf(const struct btf_dumper *d,
 		       struct bpf_map_info *map_info, void *key,
 		       void *value)
 {
+	__u32 value_id;
 	int ret;
 
 	/* start of key-value pair */
@@ -265,9 +267,12 @@ static int do_dump_btf(const struct btf_dumper *d,
 			goto err_end_obj;
 	}
 
+	value_id = map_info->btf_vmlinux_value_type_id ?
+		: map_info->btf_value_type_id;
+
 	if (!map_is_per_cpu(map_info->type)) {
 		jsonw_name(d->jw, "value");
-		ret = btf_dumper_type(d, map_info->btf_value_type_id, value);
+		ret = btf_dumper_type(d, value_id, value);
 	} else {
 		unsigned int i, n, step;
 
@@ -279,8 +284,7 @@ static int do_dump_btf(const struct btf_dumper *d,
 			jsonw_start_object(d->jw);
 			jsonw_int_field(d->jw, "cpu", i);
 			jsonw_name(d->jw, "value");
-			ret = btf_dumper_type(d, map_info->btf_value_type_id,
-					      value + i * step);
+			ret = btf_dumper_type(d, value_id, value + i * step);
 			jsonw_end_object(d->jw);
 			if (ret)
 				break;
@@ -932,6 +936,44 @@ static int maps_have_btf(int *fds, int nb_fds)
 	return 1;
 }
 
+static struct btf *btf_vmlinux;
+
+static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
+{
+	struct btf *btf = NULL;
+
+	if (info->btf_vmlinux_value_type_id) {
+		if (!btf_vmlinux) {
+			btf_vmlinux = libbpf_find_kernel_btf();
+			if (IS_ERR(btf_vmlinux))
+				p_err("failed to get kernel btf");
+		}
+		return btf_vmlinux;
+	} else if (info->btf_value_type_id) {
+		int err;
+
+		err = btf__get_from_id(info->btf_id, &btf);
+		if (err || !btf) {
+			p_err("failed to get btf");
+			btf = err ? ERR_PTR(err) : ERR_PTR(-ESRCH);
+		}
+	}
+
+	return btf;
+}
+
+static void free_map_kv_btf(struct btf *btf)
+{
+	if (!IS_ERR(btf) && btf != btf_vmlinux)
+		btf__free(btf);
+}
+
+static void free_btf_vmlinux(void)
+{
+	if (!IS_ERR(btf_vmlinux))
+		btf__free(btf_vmlinux);
+}
+
 static int
 map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	 bool show_header)
@@ -952,13 +994,10 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	prev_key = NULL;
 
 	if (wtr) {
-		if (info->btf_id) {
-			err = btf__get_from_id(info->btf_id, &btf);
-			if (err || !btf) {
-				err = err ? : -ESRCH;
-				p_err("failed to get btf");
-				goto exit_free;
-			}
+		btf = get_map_kv_btf(info);
+		if (IS_ERR(btf)) {
+			err = PTR_ERR(btf);
+			goto exit_free;
 		}
 
 		if (show_header) {
@@ -999,7 +1038,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	free(key);
 	free(value);
 	close(fd);
-	btf__free(btf);
+	free_map_kv_btf(btf);
 
 	return err;
 }
@@ -1067,6 +1106,7 @@ static int do_dump(int argc, char **argv)
 		close(fds[i]);
 exit_free:
 	free(fds);
+	free_btf_vmlinux();
 	return err;
 }
 
-- 
2.17.1

