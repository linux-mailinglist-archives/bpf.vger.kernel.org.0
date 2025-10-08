Return-Path: <bpf+bounces-70605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13FBC627C
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F6604E7035
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7B2BF00D;
	Wed,  8 Oct 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fY8rlcDW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A7E2BEFF8
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944958; cv=none; b=TQsSh5RvUNV8kKYvQ2eHTLWK6fGvNMKXcbGDuWDOQlU7l0oMEmzeH2RUkQUtE0AP5Xn8jb86I9UsZiUuYsumJg7lmVPE2zcaISOLSFrfN5zNEvSc/UBwbYLMMwEzUWuQfketjT0JkU22hpDuwDzJWl8ExcKNtql6rRyPEhsG/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944958; c=relaxed/simple;
	bh=1n3ebqrEIijErNmboET1Ait7fQMVgzaHLmyeYHR1efw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7MKkf9yXocSp7EggSEgnyTwYtb8qi6L5qxN06PDjjPg9qgyqOPhq5ZZOZKGOF5hf7xtna/FS5BxgEUASXKq9SjvJtb2zjwXq1PyeNoMY9ClP0Eysm/FNjG5bGc+/H46+XhqyhmaMSspMWXG1D80C+Iz2FYiDg4fhcN1Fh5D7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fY8rlcDW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HETFA029244;
	Wed, 8 Oct 2025 17:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=NyeZO
	SQww4JwUDKAkl05RQXP0TQmQhdeeniGPQAVHNQ=; b=fY8rlcDWjnq8Urx8gSYgH
	WCElr0tTSY1N7cd+f+tU+mTKzNnnVzHbV3/YGaZ6ydmROZfyK8v0jEuvdVWedcEN
	+kRCwqmkidYvZ9b4FERixLN1RFvYjPiaw8nNoET+hsUPR58h/nqHdIyHk05x/VQP
	wsy161ZGwFPZpuHchXTOQ8NleTAD6bpMuNSCcScq4cmis4Qehc6YNgYEAVswkwSy
	u5Z2ldWB36yZqwOlGBxbFVPgerovZbBFCB2gfRjWQik0Xo4gnoEeJqpa2EVLwpjX
	/7Q95piayQIWFgCeZFHLnX3tOaC+FSTzftcHqDT+3Fm/+VGp3pkqzktr0mhplZIA
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6b81b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDxV6037196;
	Wed, 8 Oct 2025 17:35:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rpxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:34 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUu031138;
	Wed, 8 Oct 2025 17:35:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-8;
	Wed, 08 Oct 2025 17:35:34 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 07/15] selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
Date: Wed,  8 Oct 2025 18:35:03 +0100
Message-ID: <20251008173512.731801-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Proofpoint-GUID: koNHCYv65vDW8eQh2kNlc9UHCrO5GFVw
X-Authority-Analysis: v=2.4 cv=Nb7rFmD4 c=1 sm=1 tr=0 ts=68e6a0e8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=O_h5xKu9hMPxhoEXHG0A:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: koNHCYv65vDW8eQh2kNlc9UHCrO5GFVw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX7jQ6jymAEDYb
 JYguxWck8X0EG0E9xPivXcouhEs9RiMGdFQ4bC8C/F5kkWMUVTHAyUDv0JvY0WtHdr/eHTJxJwX
 2qe33+g0n8+Lwcl198Jz7c5USXvUROWjALVTyn3tXHPo50I6tBr8py/FcpHL2GbFjmqONK473NS
 zspfQIJc/mVeNNkMfFpqKhIu9W5SG1+ECLzczrgIx1bDgNU0fPe6RXmvP7t+pqx+Sd+crM5BNPM
 h1pvbxeGJOUoAIu88Rm/5C63laGVhTqpTw/3VsZVc2B0RVkVeqTMMjILmXLNJGho66N1YanSQQ/
 m4BbFL/+F2c0F4wNW1/vb1HZhxaPp0TFrZ/rDQB8K3NO+XDxCVhb7wzuogat7rtAjTLBA9wjQlf
 rhc10RsOpcg+dddxIvzLsVoECjonfxBQfxlob/R/f3E27J4D0NE=

Add support to dump, encode and validate new location-related kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/btf_helpers.c | 43 ++++++++++++++++++++++-
 tools/testing/selftests/bpf/test_btf.h    | 15 ++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 1c1c2c26690a..90455ef8ab0f 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -27,11 +27,14 @@ static const char * const btf_kind_str_mapping[] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 static const char *btf_kind_str(__u16 kind)
 {
-	if (kind > BTF_KIND_ENUM64)
+	if (kind > BTF_KIND_LOCSEC)
 		return "UNKNOWN";
 	return btf_kind_str_mapping[kind];
 }
@@ -203,6 +206,44 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
 		fprintf(out, " type_id=%u component_idx=%d",
 			t->type, btf_decl_tag(t)->component_idx);
 		break;
+	case BTF_KIND_LOC_PARAM: {
+		struct btf_loc_param *p = btf_loc_param(t);
+		__s32 sz = (__s32)t->size;
+
+		if (btf_kflag(t)) {
+			__u64 uval = btf_loc_param_value(t);
+
+			if (sz >= 0) {
+				fprintf(out, " size=%d value=%llu", sz, uval);
+			} else {
+				__s64 sval = (__s64)uval;
+
+				fprintf(out, " size=%d value=%lld", sz, sval);
+			}
+		} else {
+			fprintf(out, " size=%d reg=%u flags=0x%x offset=%d",
+				sz, p->reg, p->flags, p->offset);
+		}
+		break;
+	}
+	case BTF_KIND_LOC_PROTO: {
+		const __u32 *p = btf_loc_proto_params(t);
+
+		fprintf(out, " vlen=%u", vlen);
+		for (i = 0; i < vlen; i++, p++)
+			fprintf(out, "\n\ttype_id=%u", *p);
+		break;
+	}
+	case BTF_KIND_LOCSEC: {
+		const struct btf_loc *l = btf_locsec_locs(t);
+
+		fprintf(out, " vlen=%u", vlen);
+		for (i = 0; i < vlen; i++, l++) {
+			fprintf(out, "\n\t'%s' func_proto_type_id=%u loc_proto_type_id=%u offset=%d",
+				btf_str(btf, l->name_off), l->func_proto, l->loc_proto, l->offset);
+		}
+		break;
+	}
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
index e65889ab4adf..6e9bc6fe6702 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -84,4 +84,19 @@
 #define BTF_TYPE_TAG_ENC(value, type)	\
 	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
 
+#define BTF_LOC_PARAM_ENC(sz, kflag, value) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_LOC, kflag, 0), (__u32)sz), \
+	(value >> 32), (value & 0xffffffff)
+
+#define BTF_LOC_PROTO_ENC(nargs) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_LOC_PROTO, 0, nargs), 0)
+
+#define BTF_LOC_PROTO_PARAM_ENCODE(param) (param)
+
+#define BTF_LOCSEC_ENC(name, nlocs) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_LOCSEC, 0, nlocs), 0)
+
+#define BTF_LOCSEC_LOC_ENCODE(name, func_proto, loc_proto, offset) \
+	(name), (func_proto), (loc_proto), (offset)
+
 #endif /* _TEST_BTF_H */
-- 
2.39.3


