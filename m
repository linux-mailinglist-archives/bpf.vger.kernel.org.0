Return-Path: <bpf+bounces-70601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30ABC6273
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB71899BDA
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6372BEFFE;
	Wed,  8 Oct 2025 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MF+Fm0Up"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478692165EA
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944951; cv=none; b=qeLN24xfhcPq5UE4ksueSy1I48aU+kxTqxM6uHGCbbbsFKNWpn0Ih4rlRXEQvOkxI3DkteDIM9/V/xYd4vIKabBQha6GtvFNECDbMbggxK6XG6a2C1dAEfFyjmEVaqc/rSC8THgK62lBSrZRSynoPj0U002wN+YmbmZwstStBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944951; c=relaxed/simple;
	bh=W4XqY15b7TcGB1OHSfJNTFD5ZrkuaEwVuXA3axRc1I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqLEBQ3hNr3dJHPaHQQb1duLz9YlMxAbwkj3CzMx5E7uJls4z9ai3mEyNEMSFhrCZ3PTkQ8oa+F/ttQe93dN71aKWbseWN8jDeKsWrRPq5VLU5/gTwcOxraT48pqfFVraUlyoePrYA5HG+t6RZv1HFiJMakiBWOBU9yyUWcwtEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MF+Fm0Up; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HETSB032634;
	Wed, 8 Oct 2025 17:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=TEoWb
	b5BymTjUfq7HoIFzGH/hSHLTifAtXZp0UOzQbw=; b=MF+Fm0UpYRwSFlsZKNC/E
	X9wM9IKCIagBqTRLJqrzuCTP9FBRizk3/JF3q9rLCpMXwJ14C+ysZ5lRN1IOwiOX
	ASS7peZ26t9s+Q+fF/FlKHnFNlR1r2hR+gAtcjXmCSK3VYc9G6OJSJzLDe4z2znc
	AWnmd3MMhhddqp42gKcnuKBARsb7XvsIE+Ur9t8EWLkHA1HCnEDibPihOc5aCruw
	iCHqTyjMz26BCA6z3YfwTse5W07OGcOaMsPxQRbsa/MYL04PxVtmOAUbv3pJ6q02
	Xxk7KWxF9w1XTvj+BmuJrmzmPqESujN1rR5XjyidcHh3WQib4tUG4ygf4q9+b/TU
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6br1bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDnPC036923;
	Wed, 8 Oct 2025 17:35:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rpvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:29 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUq031138;
	Wed, 8 Oct 2025 17:35:28 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-6;
	Wed, 08 Oct 2025 17:35:28 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 05/15] bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
Date: Wed,  8 Oct 2025 18:35:01 +0100
Message-ID: <20251008173512.731801-6-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e6a0e2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=DLatG2-O_xZech7bYxoA:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: hnl2nHkiAZhxN-dwajMVaouGIWGos-1I
X-Proofpoint-GUID: hnl2nHkiAZhxN-dwajMVaouGIWGos-1I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwsRUjIoS7Jpm
 RHJYVcirbeylGomT9hrNzEASS/T0Uwf8nO0krTPWXSahMonVv7AcTp2iCJF2y1yduyCQ5oeVQlU
 XuxhDADo2p8OnKQwr+ZLQkXPTH0oS8PwftRCE2Nmx3epJNq4cL3YX3a2MEngAejwkKoJBPF7b+b
 lKGzYQd637Df7yVfWzL4ajYIjvVNpJQSgQgGY9r3F0PSAOWRSOk/7M/476UvqZeA3FpORgbxvVV
 +s6cz4lCefsrIecko2Mm4OZb58pWPP0MFNHJ/x7ceyy1W8X9fuHh1RmXNXtLozxS2+Y3F410Pxw
 zU3KIu/Uz3NS/yukyfU4ds4LiLvS0SoxIutpGKePKR60+zwYYh71Fpohtdvm3/2W3fw5URE6xJe
 d7Rx3ZgHhQ93APXS7VNNnX+qmtoAVLpBNvd5dtBPzzL+V4ErOY0=

In raw mode ensure we can dump new BTF kinds in normal/json format.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 95 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 946612029dee..23b773659ad8 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -50,6 +50,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 struct sort_datum {
@@ -420,6 +423,98 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 		}
 		break;
 	}
+	case BTF_KIND_LOC_PARAM: {
+		const struct btf_loc_param *p = btf_loc_param(t);
+		__s32 sz = (__s32)t->size;
+
+		if (btf_kflag(t)) {
+			__u64 uval = btf_loc_param_value(t);
+			__s64 sval = (__s64)uval;
+
+			if (json_output) {
+				jsonw_int_field(w, "size", sz);
+				if (sz >= 0)
+					jsonw_uint_field(w, "value", uval);
+				else
+					jsonw_int_field(w, "value", sval);
+			} else {
+				if (sz >= 0)
+					printf(" size=%d value=%llu", sz, uval);
+				else
+					printf(" size=%d value=%lld", sz, sval);
+			}
+		} else {
+			if (json_output) {
+				jsonw_int_field(w, "size", sz);
+				jsonw_uint_field(w, "reg", p->reg);
+				jsonw_uint_field(w, "flags", p->flags);
+				jsonw_int_field(w, "offset", p->offset);
+			} else {
+				printf(" size=%d reg=%u flags=0x%x offset=%d",
+				       sz, p->reg, p->flags, p->offset);
+			}
+		}
+		break;
+	}
+
+	case BTF_KIND_LOC_PROTO: {
+		__u32 *params = btf_loc_proto_params(t);
+		__u16 vlen = BTF_INFO_VLEN(t->info);
+		int i;
+
+		if (json_output) {
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "params");
+			jsonw_start_array(w);
+		} else {
+			printf(" vlen=%u", vlen);
+		}
+
+		for (i = 0; i < vlen; i++, params++) {
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_uint_field(w, "type_id", *params);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\t type_id=%u", *params);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+
+	case BTF_KIND_LOCSEC: {
+		__u16 vlen = BTF_INFO_VLEN(t->info);
+		struct btf_loc *locs = btf_locsec_locs(t);
+		int i;
+
+		if (json_output) {
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "locs");
+			jsonw_start_array(w);
+		} else {
+			printf(" vlen=%u", vlen);
+		}
+
+		for (i = 0; i < vlen; i++, locs++) {
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_string_field(w, "name", btf_str(btf, locs->name_off));
+				jsonw_uint_field(w, "func_proto_type_id", locs->func_proto);
+				jsonw_uint_field(w, "loc_proto_type_id", locs->loc_proto);
+				jsonw_uint_field(w, "offset", locs->offset);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\t '%s' func_proto_type_id=%u loc_proto_type_id=%u offset=%u",
+				       btf_str(btf, locs->name_off),
+				       locs->func_proto, locs->loc_proto, locs->offset);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
 	default:
 		break;
 	}
-- 
2.39.3


