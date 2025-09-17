Return-Path: <bpf+bounces-68650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D545EB7E4C6
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65ED2623C80
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCA230AACA;
	Wed, 17 Sep 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CD3Y2Bcs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A812F5A3F;
	Wed, 17 Sep 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113062; cv=none; b=SgecKMJBXPuUWfiAa9vxmHOdCI5KdF85OEg76bdVmhA/ibTDFkrAHOiLzOgW9YwKE3cM1z1wjE1UYe+wo+dbzA82Th5t9aEssOKTCv3LsdQfhlsCjCbd+3vYGMLqIWkQ/UjTdqZK+AqTyXtuzcT/QYe+mMWZpTCwA4J5t/PSzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113062; c=relaxed/simple;
	bh=bJcg/pBe0wAmBajRsoCOyCPLNBQSDkSLEFp6n0FscF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=srPjTM4RdiA8S/NGX7VkF74qVCEE5mN+Ir2DUwKNl49hozjHv/xTGBTfaBEScHmlmT3DMBW4bI02yFKQdATjC3KbJSkvIxqz0xdh65R/tBJbqCt4tC67ktqu6tk5ObHBFqRQExCTS9qTHliqzgEZZPUe0IZdJL2LXGVsVo6yFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CD3Y2Bcs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XX4G026799;
	Wed, 17 Sep 2025 12:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Z3q28GCMmqb0mtzx4dGMhS
	kQrUgtXvj7//96GGRaoE0=; b=CD3Y2BcsSUPBnBzXcpfucRsruatzQhZqNcAt7I
	wLmAsl2fbKhj6b659oDae8NrJd+RVexX1O3ZMWtuRGZyNgr7SVUZQ6HYTh4nFkht
	hgqgUamICnmQHvBrcScGdHsz3niEA1Zt9hE9OVnOn7bgMySNcsHzAs15ol0AzxpY
	DESDvzFA7y42515E40m/8JqjVXedC+plVw20Fq7MVKZUFKJpdKmxiVTYTwvOtz2k
	o4aig5bPcF6btB/ezXx/x+yAKEnYz3c2912inC4UD5NzzsQVo9a7aH0OpWd/vN0o
	LRToy6sAPKprTDaUIJG5sY8Nmit+OShwXBFqnS1vUHcbEJQw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt2cph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 12:43:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58HChlSg007441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 12:43:47 GMT
Received: from hu-ckantibh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 17 Sep 2025 05:43:42 -0700
From: Sanjay Chitroda <quic_ckantibh@quicinc.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Sanjay Chitroda
	<sanjayembeddese@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii
 Nakryiko <andrii@kernel.org>
CC: Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] libbpf: increase probe_name buffer size to avoid format-truncation
Date: Wed, 17 Sep 2025 18:13:34 +0530
Message-ID: <20250917124334.1783090-1-quic_ckantibh@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5-Ls7IbWoXQlmCMNlM2q0vOFd1zAYaES
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68caad04 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=ZtdpfGWLlbT3tiSeqQcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+Ll5Lkr+GQNE
 MeZvJkmmCmT1AEwLGBTofG/gy7yZmu27q57CwHP48I6GFAw5e04eWLhRtU4nglk45nROdbsjDaE
 CnTZSxYLdcNuchDDigHQuR1devFOxltS2enFVKVJsD2r1PO1QtbUenXFZweqaAKMZ+j9L/cBY27
 YG4MQTZhFGlk2qgH5KDKHAHzG08LAGZlwFAS25vdsWwMgxjv7rw2gXKeBG5PJoNq8vGx5Q1CZFs
 Dz0ZfKLEG4VsnSlTDW5TW5lmfA5/pY8E2655v0UdkN16DUtwLIVEQaQgzWTxVBlPX5BEdZiQwRU
 X5kqR9ov4SuCawcWIs2YOUUstWc18gdm/WOhqGEqu8/ZU/l8jRzOjzTNe4ncEa+n/uo9z4RmONK
 5krSiOL/
X-Proofpoint-ORIG-GUID: 5-Ls7IbWoXQlmCMNlM2q0vOFd1zAYaES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

This patch increases the size of the `probe_name` buffer in
`probe_kern_syscall_wrapper()` from `MAX_EVENT_NAME_LEN` to
`MAX_EVENT_NAME_LEN * 2`.

The change addresses a build failure in perf builds caused by GCC's
-Werror=format-truncation warning:

  libbpf.c:11052:45: error: '%s' directive output may be truncated writing up to 63 bytes into a region of size between 34 and 53 [-Werror=format-truncation]

The warning is triggered by a `snprintf()` call that formats a string
using syscall names and other identifiers. In some cases, the buffer
size is insufficient, leading to potential truncation.

Debug builds pass because they do not treat warnings as errors, but
perf builds fail due to `-Werror`.

Increasing the buffer size ensures that the formatted string fits
safely, resolving the issue without affecting functionality.

Signed-off-by: Sanjay Chitroda <quic_ckantibh@quicinc.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8f5a81b672e1..9413e86476da 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11290,7 +11290,7 @@ int probe_kern_syscall_wrapper(int token_fd)
 
 		return pfd >= 0 ? 1 : 0;
 	} else { /* legacy mode */
-		char probe_name[MAX_EVENT_NAME_LEN];
+		char probe_name[MAX_EVENT_NAME_LEN * 2];
 
 		gen_probe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
 		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
-- 
2.34.1


