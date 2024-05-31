Return-Path: <bpf+bounces-31045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F818D66D0
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F8428AD23
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539215B96C;
	Fri, 31 May 2024 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LwphYhcW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD487156242;
	Fri, 31 May 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172952; cv=none; b=R3ie9zjsgjevyWHCzPNWVFYuARbCFUQZQDL42aJSE4OraThqDach1yQeUjS9Qlg+M+HK5k138QMB9YyDL/Uh7uuPOPxpg7qXmV5C98RFJsfIxs76PM2gQs0C4hEwYSnZlpzP3L+DsyW3hi2TllFSGG7sqkfqlgDNakh9t0pGMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172952; c=relaxed/simple;
	bh=/dieNpAffYfF3j9dI+41BjDdn/AE2ZDNZQ0kdYwkDMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=a60LPVuV5L8jFNHnPyIoRleCeyXYp4ijWUuDNlh0XaNclmEGModOFfYm2FPiwaoC/TrSsEMPBwDOId6oz+fTsFmBIyOk7dAwtCzT3WZO4/WInmJGkzMsoxmXWOfB3JdZ35gqAVtW/ITt4w0sgsj/8elYqB24Wt/KGws9ITxSpi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LwphYhcW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V8osjB019859;
	Fri, 31 May 2024 16:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Hy60RPDaCxUwgwf6FF4cUM
	FAxBZJ9nOouJL9XB+bIOs=; b=LwphYhcWNWDUGD+VCVPOV4qhRMCC5wSnj1Gtpr
	vfLdITbOFqcgT6ghpWOCOjrG8ZZkn11gzuvKVYchZovzs6zBZToCr8sBI0qPpBWS
	ABZp0b/melukEgJvKznpGOFzfQUJYko1H0hL1D9iKqNfPNhm2e8jYPTAInjDazTp
	2XCldF6eIySEC5h+MQCdy49x6aX8rGMs9I6YU/JC0WdKkWQp7IBn0Sr4RlQPMaL0
	QGUhBuIxS/wBOxFIlPLU4RTJPY7QCR0iycKrnXIZQQCsRtc0lmZvEMKRMkrAp0mb
	0FNZujvhAW5VfsQdCNH9xBrYsV9Iv57dZypEOV95Sm3qPG0Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qqfj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 16:28:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VGSnDI032720
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 16:28:49 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 09:28:49 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 09:28:43 -0700
Subject: [PATCH] test_bpf: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_bpf-v1-1-868e4bd2f9ed@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALr6WWYC/x3M0Q6CMAxA0V8hfbYJbCrqrxBjOlakCUzSTkNC+
 Henj+fh3g2MVdjgVm2g/BGTVypoDhX0I6Uno8RicLU71iff4BxxkoCZLT/CMqBrz/HKvvUXclC
 qRXmQ9X/s7sWBjDEopX78fSZJ7xVnsswK+/4FUKXiuoAAAAA=
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
	<john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eDUSwnBGnFEXi0bqGp1p8h-0FvhzUD9D
X-Proofpoint-ORIG-GUID: eDUSwnBGnFEXi0bqGp1p8h-0FvhzUD9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=960 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310123

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bpf.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 207ff87194db..ce5716c3999a 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -15706,4 +15706,5 @@ static void __exit test_bpf_exit(void)
 module_init(test_bpf_init);
 module_exit(test_bpf_exit);
 
+MODULE_DESCRIPTION("Testsuite for BPF interpreter and BPF JIT compiler");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240531-md-lib-test_bpf-276d9e3738a2


