Return-Path: <bpf+bounces-35615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17C93BD6B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 09:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D52B21084
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F964171E74;
	Thu, 25 Jul 2024 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a3x3hc77"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D5339A0;
	Thu, 25 Jul 2024 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894146; cv=none; b=JrA2DD/CGZg3UQHj9WX2IypSYjq46f9WOsEkpNRggAFkX0ovci0j+yCZXv9VrpVNSsVGENH43YIYwquiMt7h+1VpO+0mwOFN4qbS2h3FgT4FbbkQ2rr61ViBFk8sl2vK3ctFGr/t+GVL6SkrcxvgL6J/sXXm4YVtsOd8C0EPxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894146; c=relaxed/simple;
	bh=JteyzvXcp3QXzCReYia+mLqaOc4wpR81HbWjXZdZyAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pns8KYPXULy6jliZVmGxJL46veJmNEeu+lHcOxt7ytDrh+AF4BAiG1fuAP6WQryKI91gv2V+XocAHt4Bif3ULvr4+1Wa6FdvH6v61khQxKk7Hxn/h8HMY8CeCNbDuuDywLlzrFYcjqdBUlWqdzBAQSiMJB2qkXG4vQMJ/o0a05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a3x3hc77; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P7jKF9006021;
	Thu, 25 Jul 2024 07:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=eI5acEpIkrw5z8
	iX7At5oIkGKFfSs6l2NF0WyFIdPh4=; b=a3x3hc77S0cGSmj2WGd0T1oqnsZXDA
	zXjo+vhXCcFkpYcOWA3w0WES7SCMyKuzAZZnuQ42xg0iFxxR6imvaB32YQAu//Zn
	pI/5gqgNcD2pUCKW2E2NjXwZ1c1lnDECMXtTqaAzQBxrOvgWjyG2RcKvDmWCaMnl
	dYfNyWEJRYOj99of8nZAE5o7kXbwDfdHaHukZRtS4/GLKSmEVcUkVAMLjoTaO3XT
	M5Gkia4/AeuOEjzrcvJcPFLyiu9ExZbXWWFtVD3sqBqQxYJ7uQ9HkimKtTYXMNbQ
	3jrtMSQcJGf6XpJI7xepKVcLqLeJ6GrC82SljIZV0CqYe9njQGl6vZCg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40k7yus054-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 07:55:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46P752bG018937;
	Thu, 25 Jul 2024 07:55:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h2824dfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 07:55:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46P7tNBo030581;
	Thu, 25 Jul 2024 07:55:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-218-72.vpn.oracle.com [10.175.218.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40h2824dem-1;
	Thu, 25 Jul 2024 07:55:22 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: cavok@debian.org, jolsa@kernel.org, ben@decadent.org.uk,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_encoder: log libbpf errors when they cause encoding errors
Date: Thu, 25 Jul 2024 08:55:20 +0100
Message-ID: <20240725075520.1281905-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_07,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407250050
X-Proofpoint-GUID: 8-b-1cevoHHNHXTPb0Wvoz4L1qiTshxQ
X-Proofpoint-ORIG-GUID: 8-b-1cevoHHNHXTPb0Wvoz4L1qiTshxQ

libbpf returns a negative error code when adding types fails.
Pass it into btf__log_err() and display the libbpf error when
negative.  Nearly all use cases of btf__log_err() happen as a
result of a libbpf-returned error, pass 0 for the exceptions.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c2df2bc..adc38c3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -237,9 +237,9 @@ static const char * btf__int_encoding_str(uint8_t encoding)
 		return "UNKN";
 }
 
-__attribute ((format (printf, 5, 6)))
+__attribute ((format (printf, 6, 7)))
 static void btf__log_err(const struct btf *btf, int kind, const char *name,
-			 bool output_cr, const char *fmt, ...)
+			 bool output_cr, int libbpf_err, const char *fmt, ...)
 {
 	fprintf(stderr, "[%u] %s %s", btf__type_cnt(btf),
 		btf_kind_str[kind], name ?: "(anon)");
@@ -253,6 +253,9 @@ static void btf__log_err(const struct btf *btf, int kind, const char *name,
 		va_end(ap);
 	}
 
+	if (libbpf_err < 0)
+		fprintf(stderr, " (libbpf error %d)", libbpf_err);
+
 	if (output_cr)
 		fprintf(stderr, "\n");
 }
@@ -355,7 +358,8 @@ static int32_t btf_encoder__add_float(struct btf_encoder *encoder, const struct
 	int32_t id = btf__add_float(encoder->btf, name, BITS_ROUNDUP_BYTES(bt->bit_size));
 
 	if (id < 0) {
-		btf__log_err(encoder->btf, BTF_KIND_FLOAT, name, true, "Error emitting BTF type");
+		btf__log_err(encoder->btf, BTF_KIND_FLOAT, name, true, id,
+			     "Error emitting BTF type");
 	} else {
 		const struct btf_type *t;
 
@@ -429,7 +433,7 @@ static int32_t btf_encoder__add_base_type(struct btf_encoder *encoder, const str
 
 	id = btf__add_int(encoder->btf, name, byte_sz, encoding);
 	if (id < 0) {
-		btf__log_err(encoder->btf, BTF_KIND_INT, name, true, "Error emitting BTF type");
+		btf__log_err(encoder->btf, BTF_KIND_INT, name, true, id, "Error emitting BTF type");
 	} else {
 		t = btf__type_by_id(encoder->btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "size=%u nr_bits=%u encoding=%s%s",
@@ -473,7 +477,7 @@ static int32_t btf_encoder__add_ref_type(struct btf_encoder *encoder, uint16_t k
 		id = btf__add_func(btf, name, BTF_FUNC_STATIC, type);
 		break;
 	default:
-		btf__log_err(btf, kind, name, true, "Unexpected kind for reference");
+		btf__log_err(btf, kind, name, true, 0, "Unexpected kind for reference");
 		return -1;
 	}
 
@@ -484,7 +488,7 @@ static int32_t btf_encoder__add_ref_type(struct btf_encoder *encoder, uint16_t k
 		else
 			btf_encoder__log_type(encoder, t, false, true, "type_id=%u", t->type);
 	} else {
-		btf__log_err(btf, kind, name, true, "Error emitting BTF type");
+		btf__log_err(btf, kind, name, true, id, "Error emitting BTF type");
 	}
 	return id;
 }
@@ -503,7 +507,7 @@ static int32_t btf_encoder__add_array(struct btf_encoder *encoder, uint32_t type
 		btf_encoder__log_type(encoder, t, false, true, "type_id=%u index_type_id=%u nr_elems=%u",
 				      array->type, array->index_type, array->nelems);
 	} else {
-		btf__log_err(btf, BTF_KIND_ARRAY, NULL, true,
+		btf__log_err(btf, BTF_KIND_ARRAY, NULL, true, id,
 			      "type_id=%u index_type_id=%u nr_elems=%u Error emitting BTF type",
 			      type, index_type, nelems);
 	}
@@ -545,12 +549,12 @@ static int32_t btf_encoder__add_struct(struct btf_encoder *encoder, uint8_t kind
 		id = btf__add_union(btf, name, size);
 		break;
 	default:
-		btf__log_err(btf, kind, name, true, "Unexpected kind of struct");
+		btf__log_err(btf, kind, name, true, 0, "Unexpected kind of struct");
 		return -1;
 	}
 
 	if (id < 0) {
-		btf__log_err(btf, kind, name, true, "Error emitting BTF type");
+		btf__log_err(btf, kind, name, true, id, "Error emitting BTF type");
 	} else {
 		t = btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "size=%u", t->size);
@@ -600,7 +604,7 @@ static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const char *na
 		t = btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "size=%u", t->size);
 	} else {
-		btf__log_err(btf, is_enum32 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name, true,
+		btf__log_err(btf, is_enum32 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name, true, id,
 			      "size=%u Error emitting BTF type", size);
 	}
 	return id;
@@ -682,9 +686,9 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 		t = btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, false, "return=%u args=(%s", t->type, !nr_params ? "void)\n" : "");
 	} else {
-		btf__log_err(btf, BTF_KIND_FUNC_PROTO, NULL, true,
-			      "return=%u vlen=%u Error emitting BTF type",
-			      type_id, nr_params);
+		btf__log_err(btf, BTF_KIND_FUNC_PROTO, NULL, true, id,
+			     "return=%u vlen=%u Error emitting BTF type",
+			     type_id, nr_params);
 		return id;
 	}
 
@@ -718,9 +722,9 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
 		t = btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "type=%u linkage=%u", t->type, btf_var(t)->linkage);
 	} else {
-		btf__log_err(btf, BTF_KIND_VAR, name, true,
-			      "type=%u linkage=%u Error emitting BTF type",
-			      type, linkage);
+		btf__log_err(btf, BTF_KIND_VAR, name, true, id,
+			     "type=%u linkage=%u Error emitting BTF type",
+			     type, linkage);
 	}
 	return id;
 }
@@ -781,9 +785,9 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
 
 	id = btf__add_datasec(btf, section_name, datasec_sz);
 	if (id < 0) {
-		btf__log_err(btf, BTF_KIND_DATASEC, section_name, true,
-				 "size=%u vlen=%u Error emitting BTF type",
-				 datasec_sz, nr_var_secinfo);
+		btf__log_err(btf, BTF_KIND_DATASEC, section_name, true, id,
+			     "size=%u vlen=%u Error emitting BTF type",
+			     datasec_sz, nr_var_secinfo);
 	} else {
 		t = btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "size=%u vlen=%u", t->size, nr_var_secinfo);
@@ -819,7 +823,8 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 		btf_encoder__log_type(encoder, t, false, true, "type_id=%u component_idx=%d",
 				      t->type, component_idx);
 	} else {
-		btf__log_err(btf, BTF_KIND_DECL_TAG, value, true, "component_idx=%d Error emitting BTF type",
+		btf__log_err(btf, BTF_KIND_DECL_TAG, value, true, id,
+			     "component_idx=%d Error emitting BTF type",
 			     component_idx);
 	}
 
-- 
2.43.5


