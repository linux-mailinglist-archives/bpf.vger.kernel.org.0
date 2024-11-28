Return-Path: <bpf+bounces-45826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6A9DB801
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 13:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7387B21488
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F41A286D;
	Thu, 28 Nov 2024 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dy6cRDyk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3719ADB0;
	Thu, 28 Nov 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798519; cv=none; b=CLz9IGe9JaE2UlDEOW0u+XYMzGzV+EacYqR9d8o9rL/bCnvYKBgh1C+coQK0H1vjAW4icsCNIpFxHqVR1B6iyVkCaep6SGnh562qWvKx6LRLpdOe+FI8PaT4hUaAa8jsiZ2KMNkJ1wp7duBbf5H4XB5D8euign+o9HlRNyPbR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798519; c=relaxed/simple;
	bh=yphBO8Yk9Oyg1aQgtCKogunVKU3IV7zxFKIng0h2dh0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fsEmh/SY8jbauFheIO1MbkiaswqusqB+RIQAGvV7MnQVn3mRf5Rye8rSMI6w7dUaxuE00Xk2AHQ7nMbkx7OaAOOBgIoP1ibGahyx7HZcifqB+qP89sdtic05Jfa5ug4xtEkD6/qWgeKJKlCdaN2l30Z+Tpa3D2+ldoHVQ2NhmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dy6cRDyk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS8Taol006168;
	Thu, 28 Nov 2024 12:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U8QH/Q0QCQ8tGuQIzzc/kO
	445+yrjcSOtdYyjqlB5EU=; b=Dy6cRDykA0lQBlYAd1unH7au0MvsIzsMQAeqyq
	MQ8Zvwakx/1HLxX3CwDapNI3yCQ8+n8S3adHdDiJ9UfryDeQxcK8fWDjNKfEKUMx
	JXy+ds+V1dmA5bLvvebXaQpeaoWOUibrgrWrrSwzIV5sGM5tXE9ZhMRqnSoECkbJ
	hCXYAraegDa+8SPlCG0DpUQ9nvjNZoFPUG6h3q/EWJz5W7s/i+hqXCMYuXEncUM+
	3GydaqPPaEfTEQjzLta/73SONaeJOIjMEymKrR/AYkF0wFe5TSET37wtTORjPNdv
	4450PxI538WtoKuJ4Aq02ugc5rIJfUcRGcCoHGrdl6AiRyjw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xvtrfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:54:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASCsoLW027893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:54:50 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 04:54:46 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@linaro.org>,
        <yangyicong@hisilicon.com>, <song@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH 0/3] perf tool: Fix multiple memory leakages
Date: Thu, 28 Nov 2024 20:54:29 +0800
Message-ID: <20241128125432.2748981-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VFlgfqK0U-BVluYp3YmJs-r3hGYtgPnR
X-Proofpoint-ORIG-GUID: VFlgfqK0U-BVluYp3YmJs-r3hGYtgPnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411280101

Fix memory leakages when btf_node or bpf_prog_info_node is duplicated
during insertion into perf_env.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
Zhongqiu Han (3):
  perf header: Fix one memory leakage in process_bpf_btf()
  perf header: Fix one memory leakage in process_bpf_prog_info()
  perf bpf: Fix two memory leakages when calling
    perf_env__insert_bpf_prog_info()

 tools/perf/util/bpf-event.c | 10 ++++++++--
 tools/perf/util/env.c       | 12 ++++++++----
 tools/perf/util/env.h       |  4 ++--
 tools/perf/util/header.c    |  8 ++++++--
 4 files changed, 24 insertions(+), 10 deletions(-)


base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
-- 
2.25.1


