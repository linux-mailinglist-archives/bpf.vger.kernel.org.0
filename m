Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A066F63677A
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiKWRml (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 12:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiKWRmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 12:42:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA62F78
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 09:42:35 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHQDdZ026697;
        Wed, 23 Nov 2022 17:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=ub1tNgwn+SgnwRZt1w1K7dsBYSmgg+ChnDekeIQMf54=;
 b=pWVsdN+3E921RSVZj6Fc3Wjm/OjlDFbCiZTPZrb5ZEFdLsZ/dHaL+dIg18Aos6a2bCwH
 A5zubb73eeVR66E2CsAgDha4z3dumrl87EK2RJQzcc+5rgGCGrvPev87LnzskPALverD
 SgTAwg80moCMnPBqtcxY3waRGoNmvv4O0e32IKV7gSlJUjCbpSYHcUOFAjbRn+GF1Qss
 mw2cU6CC+SoKssR/VPdsK4daNju8To9AtHAUaUZ82WIv4MAqimec5xWl2Hwpab2PIYxb
 /11YdxUecRrkQGuSHb2E1kWcTH9XdctsQQONwSDiebCf4JD2t+scM4XKkCUHGEdYWtXb jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1qwt01h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANHFO89015584;
        Wed, 23 Nov 2022 17:42:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk74af1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANHfvqG028233;
        Wed, 23 Nov 2022 17:42:09 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-201-76.vpn.oracle.com [10.175.201.76])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kxnk74a4g-4;
        Wed, 23 Nov 2022 17:42:09 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 3/5] libbpf: use BTF-encoded kind information to help parse unrecognized kinds
Date:   Wed, 23 Nov 2022 17:41:50 +0000
Message-Id: <1669225312-28949-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
References: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230130
X-Proofpoint-ORIG-GUID: oiQvhlAHF_uEQGI4kUzPFwYHq4n8vTN9
X-Proofpoint-GUID: oiQvhlAHF_uEQGI4kUzPFwYHq4n8vTN9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf__add_kinds() adds typedef/struct representations of the kinds supported
at BTF encoding time.  When decoding/parsing, we can then use information
about unrecognized kinds to skip over them.  This will be useful if the
BTF encoder encoded info using a new kind, but the parser doesn't support
it yet.

Note that only size determinations of unrecognized kinds are supported;
lookup, dedup and other features are not supported; the aim here is to
not break BTF parsing if newer kinds are encountered.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e3cea44..da719de 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -28,6 +28,8 @@
 
 static struct btf_type btf_void;
 
+#define NR_BTF_KINDS_POSSIBLE	0x20
+
 /* info used to encode/decode an unrecognized kind */
 struct btf_kind_desc {
 	int kind;
@@ -131,6 +133,9 @@ struct btf {
 
 	/* Pointer size (in bytes) for a target architecture of this BTF */
 	int ptr_sz;
+
+	/* representations of unrecognized kinds are stored here */
+	struct btf_kind_desc unrecognized_kinds[NR_BTF_KINDS_POSSIBLE - NR_BTF_KINDS];
 };
 
 static inline __u64 ptr_to_u64(const void *ptr)
@@ -420,6 +425,75 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	}
 }
 
+static int btf_unrecognized_kind_type_size(struct btf *btf, const struct btf_type *t)
+{
+	struct btf_kind_desc *unrec_kind = NULL;
+	__u16 kind = btf_kind(t);
+	int size = 0;
+
+	if (kind >= NR_BTF_KINDS && kind < NR_BTF_KINDS_POSSIBLE)
+		unrec_kind = &btf->unrecognized_kinds[kind - NR_BTF_KINDS];
+	if (!unrec_kind) {
+		pr_debug("No information about unrecognized kind:%u\n", kind);
+		return -EINVAL;
+	}
+
+	if (unrec_kind->kind != kind) {
+		const char *kind_struct_name;
+		const struct btf_type *kt;
+		const struct btf_member *m;
+		const struct btf_array *a;
+		char typedef_name[64];
+		__s32 id;
+
+		/* we need to fill in information on this kind; it will be cached in struct btf
+		 * for subsequent references.
+		 */
+		snprintf(typedef_name, sizeof(typedef_name), BTF_KIND_PFX "%u", kind);
+		id = btf__find_by_name_kind(btf, typedef_name, BTF_KIND_TYPEDEF);
+		if (id < 0)
+			return id;
+		kt = btf__type_by_id(btf, id);
+		kt = btf__type_by_id(btf, kt->type);
+		kind_struct_name = btf__str_by_offset(btf, kt->name_off);
+		/* struct should contain type + optional meta fields; otherwise unsupported */
+		switch (btf_vlen(kt)) {
+		case 1:
+			unrec_kind->nr_meta = 0;
+			unrec_kind->meta_size = 0;
+			break;
+		case 2:
+			m = btf_members(kt);
+			kt = btf__type_by_id(btf, (++m)->type);
+			if (btf_kind(kt) != BTF_KIND_ARRAY) {
+				pr_debug("Unexpected kind %u for member in '%s'\n",
+					 btf_kind(kt), kind_struct_name);
+				return -EINVAL;
+			}
+			a = btf_array(kt);
+			unrec_kind->nr_meta = a->nelems;
+			kt = btf__type_by_id(btf, a->type);
+			unrec_kind->meta_size = kt->size;
+			unrec_kind->meta_name = btf__str_by_offset(btf, kt->name_off);
+			break;
+		default:
+			pr_debug("unexpected nr of fields for '%s'(%u)\n", kind_struct_name,
+				 kind);
+			return -EINVAL;
+		}
+		unrec_kind->kind = kind;
+		unrec_kind->struct_name = kind_struct_name;
+	}
+	size = sizeof(struct btf_type);
+	if (unrec_kind->meta_size > 0) {
+		if (unrec_kind->nr_meta == 0)
+			size += btf_vlen(t) * unrec_kind->meta_size;
+		else
+			size += unrec_kind->nr_meta * unrec_kind->meta_size;
+	}
+	return size;
+}
+
 static int btf_parse_type_sec(struct btf *btf)
 {
 	struct btf_header *hdr = btf->hdr;
@@ -433,6 +507,8 @@ static int btf_parse_type_sec(struct btf *btf)
 
 		type_size = btf_type_size(next_type);
 		if (type_size < 0)
+			type_size = btf_unrecognized_kind_type_size(btf, next_type);
+		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
 			pr_warn("BTF type [%d] is malformed\n", btf->start_id + btf->nr_types);
-- 
1.8.3.1

