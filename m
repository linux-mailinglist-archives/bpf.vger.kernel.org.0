Return-Path: <bpf+bounces-2738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B5E73374F
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C932816F6
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D801D2A5;
	Fri, 16 Jun 2023 17:18:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF4182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:18:11 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ECD2101
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:18:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCiGRU021258;
	Fri, 16 Jun 2023 17:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=0B1WLVueqMmL5VnGFWPjVKWMIrhp7XBKLFvLvwTpnV0=;
 b=uFdZNDNjc47kajHbR9okAxWhhgSQ4XdEFN5tU3FPKl9zt8LzfCHTyQme3ZtHJX6o9Ygf
 fVVwVCX8ZvXgbY4iX7YMRLLq4tFqqedED5fICvFq72ajinhaXb8vbB3iRDF4+n2ttbZj
 e6dLPwFWctJ3InuG2G9aK0sDUNtHJhZmCnB8rGFCALKSWOrvE47YS8ukmL9JltvsR/WQ
 48qR5lE5LjYx0XGz9WP6md8bYO9TmG+w90JqHYIaDfqhGnskEQRtwFpL2KHfX1EynuNS
 JTW0ex6aRH9Gw2YZrEoLbd2YhbElQdjqvICsVU08SoZb22S7hOMpk1b1L7DffDNkVUqW nA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdvh2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GG5E78012376;
	Fri, 16 Jun 2023 17:17:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmertke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPg007608;
	Fri, 16 Jun 2023 17:17:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-6;
	Fri, 16 Jun 2023 17:17:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 5/9] libbpf: add kind layout encoding, crc support
Date: Fri, 16 Jun 2023 18:17:23 +0100
Message-Id: <20230616171728.530116-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230616171728.530116-1-alan.maguire@oracle.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160155
X-Proofpoint-ORIG-GUID: 9rxdssEDAvSuZQlx-rfkM8A_OerkTltt
X-Proofpoint-GUID: 9rxdssEDAvSuZQlx-rfkM8A_OerkTltt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support encoding of BTF kind layout data and crcs via
btf__new_empty_opts().

Current supported opts are base_btf, add_kind_layout and
add_crc.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 99 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      | 11 +++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 457997c2a43c..060a93809f64 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/btf.h>
 #include <gelf.h>
+#include <zlib.h>
 #include "btf.h"
 #include "bpf.h"
 #include "libbpf.h"
@@ -882,8 +883,58 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static void btf_add_kind_layout(struct btf *btf, __u8 kind,
+				__u16 flags, __u8 info_sz, __u8 elem_sz)
 {
+	struct btf_kind_layout *k = &btf->kind_layout[kind];
+
+	k->flags = flags;
+	k->info_sz = info_sz;
+	k->elem_sz = elem_sz;
+	btf->hdr->kind_layout_len += sizeof(*k);
+}
+
+static int btf_ensure_modifiable(struct btf *btf);
+
+static int btf_add_kind_layouts(struct btf *btf, struct btf_new_opts *opts)
+{
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	btf->kind_layout = calloc(NR_BTF_KINDS, sizeof(struct btf_kind_layout));
+
+	if (!btf->kind_layout)
+		return -ENOMEM;
+
+	/* all supported kinds should describe their layout here. */
+	btf_add_kind_layout(btf, BTF_KIND_UNKN, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_INT, 0, sizeof(__u32), 0);
+	btf_add_kind_layout(btf, BTF_KIND_PTR, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_ARRAY, 0, sizeof(struct btf_array), 0);
+	btf_add_kind_layout(btf, BTF_KIND_STRUCT, 0, 0, sizeof(struct btf_member));
+	btf_add_kind_layout(btf, BTF_KIND_UNION, 0, 0, sizeof(struct btf_member));
+	btf_add_kind_layout(btf, BTF_KIND_ENUM, 0, 0, sizeof(struct btf_enum));
+	btf_add_kind_layout(btf, BTF_KIND_FWD, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_TYPEDEF, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_VOLATILE, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_CONST, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_RESTRICT, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_FUNC, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_FUNC_PROTO, 0, 0, sizeof(struct btf_param));
+	btf_add_kind_layout(btf, BTF_KIND_VAR, 0, sizeof(struct btf_var), 0);
+	btf_add_kind_layout(btf, BTF_KIND_DATASEC, 0, 0, sizeof(struct btf_var_secinfo));
+	btf_add_kind_layout(btf, BTF_KIND_FLOAT, 0, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_DECL_TAG, BTF_KIND_LAYOUT_OPTIONAL,
+							sizeof(struct btf_decl_tag), 0);
+	btf_add_kind_layout(btf, BTF_KIND_TYPE_TAG, BTF_KIND_LAYOUT_OPTIONAL, 0, 0);
+	btf_add_kind_layout(btf, BTF_KIND_ENUM64, 0, 0, sizeof(struct btf_enum64));
+
+	return 0;
+}
+
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
+{
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf *btf;
 
 	btf = calloc(1, sizeof(*btf));
@@ -920,17 +971,53 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->strs_data = btf->raw_data + btf->hdr->hdr_len;
 	btf->hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
 
+	if (opts->add_kind_layout) {
+		int err = btf_add_kind_layouts(btf, opts);
+
+		if (err) {
+			free(btf->raw_data);
+			free(btf);
+			return ERR_PTR(err);
+		}
+	}
+	if (opts->add_crc) {
+		if (btf->base_btf) {
+			struct btf_header *base_hdr = btf->base_btf->hdr;
+
+			if (base_hdr->hdr_len >= sizeof(struct btf_header) &&
+			    base_hdr->flags & BTF_FLAG_CRC_SET) {
+				btf->hdr->base_crc = base_hdr->crc;
+				btf->hdr->flags |= BTF_FLAG_BASE_CRC_SET;
+			}
+		}
+		btf->hdr->flags |= BTF_FLAG_CRC_SET;
+	}
+
 	return btf;
 }
 
 struct btf *btf__new_empty(void)
 {
-	return libbpf_ptr(btf_new_empty(NULL));
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	return libbpf_ptr(btf_new_empty(&opts));
 }
 
 struct btf *btf__new_empty_split(struct btf *base_btf)
 {
-	return libbpf_ptr(btf_new_empty(base_btf));
+	LIBBPF_OPTS(btf_new_opts, opts);
+
+	opts.base_btf = base_btf;
+
+	return libbpf_ptr(btf_new_empty(&opts));
+}
+
+struct btf *btf__new_empty_opts(struct btf_new_opts *opts)
+{
+	if (!OPTS_VALID(opts, btf_new_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	return libbpf_ptr(btf_new_empty(opts));
 }
 
 static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
@@ -1377,6 +1464,12 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 			btf_bswap_kind_layout_sec(p, hdr->kind_layout_len);
 		p += hdr->kind_layout_len;
 	}
+	if (hdr->flags & BTF_FLAG_CRC_SET) {
+		struct btf_header *h = data;
+
+		h->crc = crc32(0L, (const Bytef *)&data, sizeof(data));
+	}
+
 	*size = data_sz;
 	return data;
 err_out:
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..d25bd5c19eec 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -107,6 +107,17 @@ LIBBPF_API struct btf *btf__new_empty(void);
  */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
+struct btf_new_opts {
+	size_t sz;
+	struct btf *base_btf;	/* optional base BTF */
+	bool add_kind_layout;	/* add BTF kind layout information */
+	bool add_crc;		/* add CRC information */
+	size_t:0;
+};
+#define btf_new_opts__last_field add_crc
+
+LIBBPF_API struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
+
 LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
 LIBBPF_API struct btf *btf__parse_split(const char *path, struct btf *base_btf);
 LIBBPF_API struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7521a2fb7626..edd8be4b21d0 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
 LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
+		btf__new_empty_opts;
 } LIBBPF_1.2.0;
-- 
2.39.3


