Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0803A45B0A6
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhKXA0u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:26:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59702 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231515AbhKXA0q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:26:46 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMeqMA031274
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:37 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch0wp4fky-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:37 -0800
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8D7EFA666A7B; Tue, 23 Nov 2021 16:23:31 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Evgeny Vereshchagin <evvers@ya.ru>
Subject: [PATCH bpf-next 02/13] libbpf: fix potential misaligned memory access in btf_ext__new()
Date:   Tue, 23 Nov 2021 16:23:14 -0800
Message-ID: <20211124002325.1737739-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: h5XQLbGpFGCzsfaYGH70unxOIGutXInZ
X-Proofpoint-GUID: h5XQLbGpFGCzsfaYGH70unxOIGutXInZ
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=774 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Perform a memory copy before we do the sanity checks of btf_ext_hdr.
This prevents misaligned memory access if raw btf_ext data is not 4-byte
aligned ([0]).

While at it, also add missing const qualifier.

  [0] Closes: https://github.com/libbpf/libbpf/issues/391

Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
Fixes: 2993e0515bb4 ("tools/bpf: add support to read .BTF.ext sections")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 10 +++++-----
 tools/lib/bpf/btf.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e97217a77196..8024fe355ca8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2731,15 +2731,11 @@ void btf_ext__free(struct btf_ext *btf_ext)
 	free(btf_ext);
 }
 
-struct btf_ext *btf_ext__new(__u8 *data, __u32 size)
+struct btf_ext *btf_ext__new(const __u8 *data, __u32 size)
 {
 	struct btf_ext *btf_ext;
 	int err;
 
-	err = btf_ext_parse_hdr(data, size);
-	if (err)
-		return libbpf_err_ptr(err);
-
 	btf_ext = calloc(1, sizeof(struct btf_ext));
 	if (!btf_ext)
 		return libbpf_err_ptr(-ENOMEM);
@@ -2752,6 +2748,10 @@ struct btf_ext *btf_ext__new(__u8 *data, __u32 size)
 	}
 	memcpy(btf_ext->data, data, size);
 
+	err = btf_ext_parse_hdr(btf_ext->data, size);
+	if (err)
+		goto done;
+
 	if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header, line_info_len)) {
 		err = -EINVAL;
 		goto done;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 5c73a5b0a044..742a2bf71c5e 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -157,7 +157,7 @@ LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
 				    __u32 expected_value_size,
 				    __u32 *key_type_id, __u32 *value_type_id);
 
-LIBBPF_API struct btf_ext *btf_ext__new(__u8 *data, __u32 size);
+LIBBPF_API struct btf_ext *btf_ext__new(const __u8 *data, __u32 size);
 LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
 LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext,
 					     __u32 *size);
-- 
2.30.2

