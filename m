Return-Path: <bpf+bounces-1542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889D5718B05
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1387D1C20F16
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A3D3D384;
	Wed, 31 May 2023 20:21:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823C34CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:21:45 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111510F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VERTaa023246;
	Wed, 31 May 2023 20:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=ft+QiSZvAuBxPiNnIUGCCTaNMByaHNoEjKUEDAw6ofo=;
 b=yENQwx+LVc+M6LIkxOll0jPnnYOzleFFpELonlyp7yS8+zsf7vzAiPbxqyk0PBYoxkJ5
 hQfR/T+4siRRL3F0Jlybt37hjpzrYWA5S+vaQzjPkhw57hdv+a5XJNG7U/9BAg+w904b
 IGscxjHzdXubQEXE0qQLZSbavXE//maqXGwbWDo1/1rBbXmW5yCA0l0/FkHw+6gePYYB
 qf50ZJb2JzPU0th+VjyM6k3KQ3LOhhE2Bn4TAUANUTOvaGAtMhYDnV6TupBv3yJ1+8Kz
 jDBlM0sCKyEN7D7bzF99+aq1cZGUl3uY+2H07F1cW55mSXhtdZf/cJFdY8SLChm4xVuT 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9y2dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJqsmu019729;
	Wed, 31 May 2023 20:20:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6djuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:58 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaEV000653;
	Wed, 31 May 2023 20:20:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-6;
	Wed, 31 May 2023 20:20:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 5/8] libbpf: add metadata encoding support
Date: Wed, 31 May 2023 21:19:32 +0100
Message-Id: <20230531201936.1992188-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531201936.1992188-1-alan.maguire@oracle.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310172
X-Proofpoint-GUID: -UXU5sjrBRxhtlonOxbofZRJriJYZslX
X-Proofpoint-ORIG-GUID: -UXU5sjrBRxhtlonOxbofZRJriJYZslX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support encoding of BTF metadata via btf__new_empty_opts().
Current supported opts are base_btf, add_meta and description
for metadata.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 108 +++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      |  11 ++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 77a072716d58..4b85325336b4 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -122,6 +122,7 @@ struct btf {
 	bool strs_deduped;
 
 	void *meta_data;
+	size_t meta_sz;
 
 	/* BTF object FD, if loaded into kernel */
 	int fd;
@@ -896,8 +897,84 @@ void btf__free(struct btf *btf)
 	free(btf);
 }
 
-static struct btf *btf_new_empty(struct btf *base_btf)
+static void __btf_add_kind_meta(struct btf *btf, __u8 kind, const char *name,
+				__u16 flags, __u8 info_sz, __u8 elem_sz)
 {
+	struct btf_metadata *meta = btf->meta_data;
+	struct btf_kind_meta *kind_meta = &meta->kind_meta[kind];
+
+	kind_meta->name_off = btf__add_str(btf, name);
+	kind_meta->flags = flags;
+	kind_meta->info_sz = info_sz;
+	kind_meta->elem_sz = elem_sz;
+}
+
+#define btf_add_kind_meta(btf, kind, flags, info_sz, elem_sz)	\
+	__btf_add_kind_meta(btf, kind, #kind, flags, info_sz, elem_sz)
+
+static int btf_ensure_modifiable(struct btf *btf);
+
+static int btf_add_meta(struct btf *btf, struct btf_new_opts *opts)
+{
+	const char *description = OPTS_GET(opts, description, NULL);
+	struct btf_metadata *meta;
+
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	btf->meta_sz = sizeof(struct btf_metadata) +
+		       (NR_BTF_KINDS * sizeof(struct btf_kind_meta));
+	btf->meta_data = calloc(1, btf->meta_sz);
+
+	if (!btf->meta_data) {
+		btf->meta_sz = 0;
+		return -ENOMEM;
+	}
+
+	meta = btf->meta_data;
+
+	if (btf->base_btf) {
+		struct btf_metadata *base_meta = btf->base_btf->meta_data;
+
+		if (base_meta && (base_meta->flags & BTF_META_CRC_SET)) {
+			meta->base_crc =  base_meta->crc;
+			meta->flags |= BTF_META_BASE_CRC_SET;
+		}
+	}
+
+	if (description)
+		meta->description_off = btf__add_str(btf, description);
+
+	meta->kind_meta_cnt = NR_BTF_KINDS;
+
+	/* all supported kinds should describe their format here. */
+	btf_add_kind_meta(btf, BTF_KIND_UNKN, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_INT, 0, sizeof(__u32), 0);
+	btf_add_kind_meta(btf, BTF_KIND_PTR, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_ARRAY, 0, sizeof(struct btf_array), 0);
+	btf_add_kind_meta(btf, BTF_KIND_STRUCT, 0, 0, sizeof(struct btf_member));
+	btf_add_kind_meta(btf, BTF_KIND_UNION, 0, 0, sizeof(struct btf_member));
+	btf_add_kind_meta(btf, BTF_KIND_ENUM, 0, 0, sizeof(struct btf_enum));
+	btf_add_kind_meta(btf, BTF_KIND_FWD, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_TYPEDEF, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_VOLATILE, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_CONST, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_RESTRICT, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_FUNC, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_FUNC_PROTO, 0, 0, sizeof(struct btf_param));
+	btf_add_kind_meta(btf, BTF_KIND_VAR, 0, sizeof(struct btf_var), 0);
+	btf_add_kind_meta(btf, BTF_KIND_DATASEC, 0, 0, sizeof(struct btf_var_secinfo));
+	btf_add_kind_meta(btf, BTF_KIND_FLOAT, 0, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_DECL_TAG, BTF_KIND_META_OPTIONAL,
+							sizeof(struct btf_decl_tag), 0);
+	btf_add_kind_meta(btf, BTF_KIND_TYPE_TAG, BTF_KIND_META_OPTIONAL, 0, 0);
+	btf_add_kind_meta(btf, BTF_KIND_ENUM64, 0, 0, sizeof(struct btf_enum64));
+	return 0;
+}
+
+static struct btf *btf_new_empty(struct btf_new_opts *opts)
+{
+	struct btf *base_btf = OPTS_GET(opts, base_btf, NULL);
 	struct btf *btf;
 
 	btf = calloc(1, sizeof(*btf));
@@ -934,17 +1011,42 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	btf->strs_data = btf->raw_data + btf->hdr->hdr_len;
 	btf->hdr->str_len = base_btf ? 0 : 1; /* empty string at offset 0 */
 
+	if (opts->add_meta) {
+		int err = btf_add_meta(btf, opts);
+
+		if (err) {
+			free(btf->raw_data);
+			free(btf);
+			return ERR_PTR(err);
+		}
+		btf->hdr->meta_header.meta_len = btf->meta_sz;
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
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..6de445225f02 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -107,6 +107,17 @@ LIBBPF_API struct btf *btf__new_empty(void);
  */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
+struct btf_new_opts {
+	size_t sz;
+	struct btf *base_btf;	/* optional base BTF */
+	bool add_meta;		/* add BTF metadata about encoding */
+	const char *description;/* add description to metadata */
+	size_t :0;
+};
+#define btf_new_opts__last_field description
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
2.31.1


