Return-Path: <bpf+bounces-9916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25E179EB0D
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD96281E5A
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBF61F198;
	Wed, 13 Sep 2023 14:27:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF81A713
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 14:27:25 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905A91
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 07:27:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DDkKQg029022;
	Wed, 13 Sep 2023 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=J5vD8ufc89HXLxAwnezExdB3cO6/gL7le2a1PZjDo1o=;
 b=FhClDZnkWNrkwW6ZUSQbf/k9OMaTZpYxuPz22X8Xt51cE/uVffLFODgY58uhdaYRQyU7
 9gEVuUnasbI2KNToQ+hgE4n0DXvL6UZ3tbHo4Z3E1nbSonItKoBqM0AfBOaDXRZaqeVq
 oR1+3t5VLbRvNa6tqre5GPzO+q2sGPNe4C3Q/e+0sOhyBlzHImNeSbLEhYowCL67CVk3
 h1zC1xced4xSTa7KAm5wPTZ9A7oLeRFOgGMT3IqiSZ7VtIlUv9gjctG7o5yuA3SI4C+a
 VSUFAQG5NrLTdYsZi8Ca42+EQ1u5ZPk/xVy5LPOJQywGIf8OLVBNFpFNioywvGqBKsny Vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7ka8kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 14:27:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DDlZoX014676;
	Wed, 13 Sep 2023 14:27:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5dkhsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 14:27:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DENxAO005305;
	Wed, 13 Sep 2023 14:27:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-188-149.vpn.oracle.com [10.175.188.149])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t0f5dkhdj-4;
	Wed, 13 Sep 2023 14:27:04 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 3/3] btf_encoder: learn BTF_KIND_MAX value from base BTF when generating split BTF
Date: Wed, 13 Sep 2023 15:26:46 +0100
Message-Id: <20230913142646.190047-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230913142646.190047-1-alan.maguire@oracle.com>
References: <20230913142646.190047-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130118
X-Proofpoint-GUID: 6y8efBAXTje9WIYGuzMzwp43CiWg82UK
X-Proofpoint-ORIG-GUID: 6y8efBAXTje9WIYGuzMzwp43CiWg82UK

When creating module BTF, the module likely will not have a DWARF
specificiation of BTF_KIND_MAX, so look for it in the base BTF.  For
vmlinux base BTF, the enumeration value is present, so the base BTF
can be checked to limit BTF kind representation.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 24 ++++++++++++++++++++++++
 btf_encoder.h |  2 ++
 pahole.c      |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index ad0158f..6cb3df6 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1902,3 +1902,27 @@ void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max)
 	if (btf_kind_max < BTF_KIND_ENUM64)
 		conf_load->skip_encoding_btf_enum64 = true;
 }
+
+void btf__set_btf_kind_max(struct conf_load *conf_load, struct btf *btf)
+{
+	__u32 id, type_cnt = btf__type_cnt(btf);
+
+	for (id = 1; id < type_cnt; id++) {
+		const struct btf_type *t = btf__type_by_id(btf, id);
+		const struct btf_enum *e;
+		__u16 vlen, i;
+
+		if (!t || !btf_is_enum(t))
+			continue;
+		vlen = btf_vlen(t);
+		e = btf_enum(t);
+		for (i = 0; i < vlen; e++, i++) {
+			const char *name = btf__name_by_offset(btf, e->name_off);
+
+			if (!name || strcmp(name, "BTF_KIND_MAX"))
+				continue;
+			dwarves__set_btf_kind_max(conf_load, e->val);
+			return;
+		}
+	}
+}
diff --git a/btf_encoder.h b/btf_encoder.h
index 34516bb..e5e12ef 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -27,4 +27,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder);
 
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other);
 
+void btf__set_btf_kind_max(struct conf_load *conf_load, struct btf *btf);
+
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index aca2704..4d6d059 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3470,6 +3470,7 @@ int main(int argc, char *argv[])
 				base_btf_file, libbpf_get_error(conf_load.base_btf));
 			goto out;
 		}
+		btf__set_btf_kind_max(&conf_load, conf_load.base_btf);
 		if (!btf_encode && !ctf_encode) {
 			// Force "btf" since a btf_base is being informed
 			conf_load.format_path = "btf";
@@ -3513,6 +3514,7 @@ try_sole_arg_as_class_names:
 					base_btf_file, libbpf_get_error(conf_load.base_btf));
 				goto out;
 			}
+			btf__set_btf_kind_max(&conf_load, conf_load.base_btf);
 		}
 	}
 
-- 
2.39.3


