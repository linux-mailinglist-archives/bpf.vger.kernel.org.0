Return-Path: <bpf+bounces-41616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA2999265
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE85C1F22D1E
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381A1CDFC2;
	Thu, 10 Oct 2024 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="s6TfXYZY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23B19884C
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588878; cv=none; b=ivRDOYjUv3oXofHFJCmIbtlTrQP3LNbHhekruV2ckh/8QPxnqkX+j+EjKZTFcbfcskbRc4CBQs1BdLrgAnA/tZ5W1SQFoU2YkW3raR9pq2YfYKv7EDdCsDU190GF59S4UAHX0sPb0v0z9wx+qO6UYsXJSGvoWl0n094VJvQZ86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588878; c=relaxed/simple;
	bh=byVggxhtN22khWiyyHlABiQ0Cu5RRkqHhD8yOo+gJc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iDVhz7a3otGrLb+83fvKQULsQiCaZV+uTETfDInZsvC/yCDd2KIxTm4t0rg+V+5bf64pzcoZ0bGMeaRkZFAZGzDNET+kFp1h5w2dfJ7pWrYxLRNZD8PHjv0tpY/vxn5K+ExVrGy0+wXlUd1qB3tpJuHhDAs01W4dPfMQfzhZjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=s6TfXYZY; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AI2SRn001423;
	Thu, 10 Oct 2024 19:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=wK0dMIP5N6pgu
	bhjQZnFlMr83Xs/Zf5+YD35kuop3eI=; b=s6TfXYZY/go8+V/YU9KFrdpGRVA3Q
	B1cCnHRc8Z1gtDEtbmcQ6IlYoSmXelCgytIRTjF7zTJ3PuKX2TkpFbYlFKwoWSw2
	YHfXjltz8vOEYV+Jy3Ottw0Z//OCsHWcVvUYjUeyeYKhgwLdP/UXOV7vUBfc6PXD
	fmQips+Zi2WgLWFzvoUceWYALx0Lh/8TIQzgsOId7AYFjZLTnEa1KPB5T/7gOKn3
	KdjhYHbcrUudPlEIIIPEsC4Ku9r/NPDHjV9ppZ9tB9S/AYJBlJspNV7FrXqBD5Nk
	BJOUL1MJBTgC6f80wu4b/ZwBA1bDKhij+26eiYbKTClixMDoHkbWSDaHQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 426agesuqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 19:34:01 +0000 (GMT)
Received: from LL-J21Z134.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Oct 2024 19:33:59 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
Subject: [PATCH bpf-next v2] bpf: update docs on CONFIG_FUNCTION_ERROR_INJECTION
Date: Thu, 10 Oct 2024 12:33:01 -0700
Message-ID: <20241010193301.995909-1-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04wpexch13.crowdstrike.sys (10.100.11.103) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=ObjKDQTY c=1 sm=1 tr=0 ts=67082c29 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=EjBHVkixTFsA:10 a=DAUX931o1VcA:10 a=pl6vuDidAAAA:8 a=J7MqmPBVAoDNrPO7RfIA:9
X-Proofpoint-ORIG-GUID: UvuOeWI2hSTThHxmVDJfrRGAtuMSBnFG
X-Proofpoint-GUID: UvuOeWI2hSTThHxmVDJfrRGAtuMSBnFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=711
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100128

The documentation says CONFIG_FUNCTION_ERROR_INJECTION is supported only
on x86. This was presumably true at the time of writing, but it's now
supported on many other architectures too. Drop this statement, since
it's not correct anymore and it fits better in other documentation
anyway.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 include/uapi/linux/bpf.h       | 4 ----
 tools/include/uapi/linux/bpf.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8ab4d8184b9d..df664aaeb3f4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3103,10 +3103,6 @@ union bpf_attr {
  * 		with the **CONFIG_BPF_KPROBE_OVERRIDE** configuration
  * 		option, and in this case it only works on functions tagged with
  * 		**ALLOW_ERROR_INJECTION** in the kernel code.
- *
- * 		Also, the helper is only available for the architectures having
- * 		the CONFIG_FUNCTION_ERROR_INJECTION option. As of this writing,
- * 		x86 architecture is the only one to support this feature.
  * 	Return
  * 		0
  *
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7610883c8191..de9c18bfcb00 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3103,10 +3103,6 @@ union bpf_attr {
  * 		with the **CONFIG_BPF_KPROBE_OVERRIDE** configuration
  * 		option, and in this case it only works on functions tagged with
  * 		**ALLOW_ERROR_INJECTION** in the kernel code.
- *
- * 		Also, the helper is only available for the architectures having
- * 		the CONFIG_FUNCTION_ERROR_INJECTION option. As of this writing,
- * 		x86 architecture is the only one to support this feature.
  * 	Return
  * 		0
  *
-- 
2.34.1


