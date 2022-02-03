Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777244A90E0
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 23:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiBCWug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 3 Feb 2022 17:50:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64150 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231437AbiBCWuf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 17:50:35 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213I6Vgh011060
        for <bpf@vger.kernel.org>; Thu, 3 Feb 2022 14:50:35 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e05snep78-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 14:50:35 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 14:50:33 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D0CF5104831CD; Thu,  3 Feb 2022 14:50:24 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next] libbpf: deprecate forgotten btf__get_map_kv_tids()
Date:   Thu, 3 Feb 2022 14:50:17 -0800
Message-ID: <20220203225017.1795946-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tukCjDlGf75wZQkOFqZ2bEHAWsRz4k5e
X-Proofpoint-GUID: tukCjDlGf75wZQkOFqZ2bEHAWsRz4k5e
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf__get_map_kv_tids() is in the same group of APIs as
btf_ext__reloc_func_info()/btf_ext__reloc_line_info() which were only
used by BCC. It was missed to be marked as deprecated in [0]. Fixing
that to complete [1].

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20220201014610.3522985-1-davemarchevsky@fb.com/
  [1] Closes: https://github.com/libbpf/libbpf/issues/277

Cc: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.h    | 1 +
 tools/lib/bpf/libbpf.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b10729fd830c..951ac7475794 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -150,6 +150,7 @@ LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
 LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
 LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
+LIBBPF_DEPRECATED_SINCE(0, 7, "this API is not necessary when BTF-defined maps are used")
 LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 				    __u32 expected_key_size,
 				    __u32 expected_value_size,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 81605de8654e..904cdf83002b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4202,9 +4202,12 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
 
 	if (!bpf_map__is_internal(map)) {
 		pr_warn("Use of BPF_ANNOTATE_KV_PAIR is deprecated, use BTF-defined maps in .maps section instead\n");
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 		ret = btf__get_map_kv_tids(obj->btf, map->name, def->key_size,
 					   def->value_size, &key_type_id,
 					   &value_type_id);
+#pragma GCC diagnostic pop
 	} else {
 		/*
 		 * LLVM annotates global data differently in BTF, that is,
-- 
2.30.2

