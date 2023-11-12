Return-Path: <bpf+bounces-14923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008697E8FC2
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 13:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC391F20FC4
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E67E3;
	Sun, 12 Nov 2023 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gR32dZNK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C28BEA
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 12:49:23 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD472D62
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 04:49:22 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCj8BG032220;
	Sun, 12 Nov 2023 12:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Nvd913U0oKOPWtcS2wmOvMxR+DFRt5XP4ZTY0Qmag/o=;
 b=gR32dZNK1UWIV5Gkc6ou7uRlk3wDo0sKFSA2YaQEGMTPx/I/us9qB7WZq/Gb64LyE37Y
 ajbSbbMqoYDQZLE+42adRaldmkeyCYGWWT8+p7Ki4gMiSk66IA/YPhQeUXyF0k6R50PT
 NRm5KQpKC8c+eDjGBi4Co+kWGVZeVyc+uJNqcaMwfrc8sei7+LmT31zog8exbbHpRAag
 4Ru65k4QA/RmVlOzDElMaIpCfW8VyBDWk0aHCKiMf0CK+OsZ3Xa3GAPkZiZQAxLEQ1J8
 TE/FQ3PYx+aJoEBhr+WMohoy0Jpt/kQM3O2DsoCftBryPiQEWu1NzF8ZzWiquBzNnaPN 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2sthe4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:48:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCEkkC009001;
	Sun, 12 Nov 2023 12:48:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxhngfj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Nov 2023 12:48:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ACCmceA029718;
	Sun, 12 Nov 2023 12:48:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-14.vpn.oracle.com [10.175.173.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxhngfep-5;
	Sun, 12 Nov 2023 12:48:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 04/17] libbpf: add kind layout encoding, crc support
Date: Sun, 12 Nov 2023 12:48:21 +0000
Message-Id: <20231112124834.388735-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
References: <20231112124834.388735-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120113
X-Proofpoint-GUID: -usB780JpVelgIrTFGBRdLCr3YPV8r_z
X-Proofpoint-ORIG-GUID: -usB780JpVelgIrTFGBRdLCr3YPV8r_z

Support encoding of BTF kind layout data and crcs via
btf__new_empty_opts().

Current supported opts are base_btf, add_kind_layout and
add_crc.

Kind layout information is maintained in btf.c in the
kind_layouts[] array; when BTF is created with the
add_kind_layout option it represents the current view
of supported BTF kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 80 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      | 11 ++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 973da2b21df2..fa6104860ebc 100644
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
@@ -28,6 +29,35 @@
 
 static struct btf_type btf_void;
 
+/* Describe how kinds are laid out; some have a singular element following the "struct btf_type",
+ * some have BTF_INFO_VLEN(t->info) elements.  Specify sizes for both.  Flags are currently unused.
+ * Kind layout can be optionally added to the BTF representation in a dedicated section to
+ * facilitate parsing.  New kinds must be added here.
+ */
+struct btf_kind_layout kind_layouts[NR_BTF_KINDS] = {
+/*	flags	singular element size		vlen element(s) size */
+{	0,	0,				0				}, /* _UNKN */
+{	0,	sizeof(__u32),			0				}, /* _INT */
+{	0,	0,				0				}, /* _PTR */
+{	0,	sizeof(struct btf_array),	0				}, /* _ARRAY */
+{	0,	0,				sizeof(struct btf_member)	}, /* _STRUCT */
+{	0,	0,				sizeof(struct btf_member)	}, /* _UNION */
+{	0,	0,				sizeof(struct btf_enum)		}, /* _ENUM */
+{	0,	0,				0				}, /* _FWD */
+{	0,	0,				0				}, /* _TYPEDEF */
+{	0,	0,				0				}, /* _VOLATILE */
+{	0,	0,				0				}, /* _CONST */
+{	0,	0,				0				}, /* _RESTRICT */
+{	0,	0,				0				}, /* _FUNC */
+{	0,	0,				sizeof(struct btf_param)	}, /* _FUNC_PROTO */
+{	0,	sizeof(struct btf_var),		0				}, /* _VAR */
+{	0,	0,				sizeof(struct btf_var_secinfo)	}, /* _DATASEC */
+{	0,	0,				0				}, /* _FLOAT */
+{	0,	sizeof(struct btf_decl_tag),	0				}, /* _DECL_TAG */
+{	0,	0,				0				}, /* _TYPE_TAG */
+{	0,	0,				sizeof(struct btf_enum64)	}, /* _ENUM64 */
+};
+
 struct btf {
 	/* raw BTF data in native endianness */
 	void *raw_data;
@@ -1063,8 +1093,9 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
 {
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf_header *hdr;
 	struct btf *btf;
 
@@ -1106,6 +1137,29 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 		free(btf);
 		return ERR_PTR(-ENOMEM);
 	}
+
+	if (opts->add_kind_layout) {
+		hdr->kind_layout_len = sizeof(kind_layouts);
+		btf->kind_layout = malloc(hdr->kind_layout_len);
+		if (!btf->kind_layout) {
+			free(btf->hdr);
+			free(btf);
+			return ERR_PTR(-ENOMEM);
+		}
+		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
+	}
+	if (opts->add_crc) {
+		if (btf->base_btf) {
+			struct btf_header *base_hdr = btf->base_btf->hdr;
+
+			if (base_hdr->hdr_len >= sizeof(struct btf_header) &&
+			    base_hdr->flags & BTF_FLAG_CRC_SET) {
+				hdr->base_crc = base_hdr->crc;
+				hdr->flags |= BTF_FLAG_BASE_CRC_SET;
+			}
+		}
+		hdr->flags |= BTF_FLAG_CRC_SET;
+	}
 	memcpy(btf->hdr, hdr, sizeof(*hdr));
 
 	return btf;
@@ -1113,12 +1167,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
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
@@ -1564,6 +1632,12 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 			btf_bswap_kind_layout_sec(p, hdr->kind_layout_len);
 	}
 
+	if (hdr->flags & BTF_FLAG_CRC_SET) {
+		struct btf_header *h = data;
+
+		h->crc = crc32(0L, (const Bytef *)data, data_sz);
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
index b52dc28dc8af..b8c0716133d1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -401,6 +401,7 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netkit;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		btf__new_empty_opts;
 		ring__avail_data_size;
 		ring__consume;
 		ring__consumer_pos;
-- 
2.31.1


