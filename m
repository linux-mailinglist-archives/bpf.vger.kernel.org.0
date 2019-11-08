Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4B9F4089
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 07:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfKHGky convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Nov 2019 01:40:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729919AbfKHGkx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Nov 2019 01:40:53 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA86elr5022916
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 22:40:52 -0800
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41ujhnmx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 22:40:52 -0800
Received: from 2401:db00:2050:5102:face:0:3b:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 7 Nov 2019 22:40:48 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 90175760F61; Thu,  7 Nov 2019 22:40:47 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 04/18] libbpf: Introduce btf__find_by_name_kind()
Date:   Thu, 7 Nov 2019 22:40:25 -0800
Message-ID: <20191108064039.2041889-5-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108064039.2041889-1-ast@kernel.org>
References: <20191108064039.2041889-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_01:2019-11-07,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1034
 suspectscore=3 priorityscore=1501 spamscore=0 mlxlogscore=721
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080065
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce btf__find_by_name_kind() helper to search BTF by name and kind, since
name alone can be ambiguous.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/btf.c      | 22 ++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 25 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 86a1847e4a9f..88efa2bb7137 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -316,6 +316,28 @@ __s32 btf__find_by_name(const struct btf *btf, const char *type_name)
 	return -ENOENT;
 }
 
+__s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
+			     __u32 kind)
+{
+	__u32 i;
+
+	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
+		return 0;
+
+	for (i = 1; i <= btf->nr_types; i++) {
+		const struct btf_type *t = btf->types[i];
+		const char *name;
+
+		if (btf_kind(t) != kind)
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		if (name && !strcmp(type_name, name))
+			return i;
+	}
+
+	return -ENOENT;
+}
+
 void btf__free(struct btf *btf)
 {
 	if (!btf)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b18994116a44..d9ac73a02cde 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -72,6 +72,8 @@ LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
 LIBBPF_API int btf__load(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
+LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
+					const char *type_name, __u32 kind);
 LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
 LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
 						  __u32 id);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 86173cbb159d..cddb0e9d0695 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -202,4 +202,5 @@ LIBBPF_0.0.6 {
 		bpf_program__get_type;
 		bpf_program__is_tracing;
 		bpf_program__set_tracing;
+		btf__find_by_name_kind;
 } LIBBPF_0.0.5;
-- 
2.23.0

