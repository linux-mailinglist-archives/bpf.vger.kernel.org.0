Return-Path: <bpf+bounces-46135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEDC9E5012
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 09:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E90E169B2D
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD41D3564;
	Thu,  5 Dec 2024 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TaXwGqfI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A791E519;
	Thu,  5 Dec 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388344; cv=none; b=UcPfrOYS+n7VLWwEuOSGzMF/aqtnQFGl8g/kRNtKvIKZvT8B6C/0HoVSr9IoIbwr5mrnMbgcVZZUtdO8JCluUqOUWjkaycqoaMRhZbrfiRP7LBVKVfmoG9XC5jrhQiy4BCCkUdZfHoBul5UWws7ysx7zR76CjqfOKMz8n3kRunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388344; c=relaxed/simple;
	bh=6DzzmVLSVEbrNn+cS2dF7UIYs/nTs2YjkOEz5fsdjfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ezShYcEqkrzejhiST4BONnTazz5KNRT5MDa/sBWR0HLvLyELksSN8EdYdbZm9YwyrCt5NMhMDMtN7r1+6EMZTQQLbpxHnovSGsxvNwtzhkDH3iKYD+n6r6YUn6Lz19B/pq/zO0P3Nn9bAl8IiidB6zmZTsTJtOUWR744peO3ivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TaXwGqfI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4LvHi9031654;
	Thu, 5 Dec 2024 08:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fJ+VpSuf1HeJwH57K33Ne1
	tteQfmAnvCOm9aTnueF3I=; b=TaXwGqfI/pCavX+bPtlKBnJvn/cTtXJ8FdIzAL
	3LuvHfSUVP/fUys+0xRMiRgtjEeiiRnibjGM/nMlguU8xBpIp33XmvW4McT3L2XU
	kpWBtgiVedO/CT1bmUe7YizwfqyuIfftDQ2UNjeQTMGLxgrURAPtEdSxpTaZhVOK
	eqQ4k1zBw6b3vA+hBVkmpPmm7dNE+lolVfVnRHvPtcszS+nZYU89DPurv0kYalvA
	ypQdloy+FjpDSxW93biS2UG1s6JukE7lo05wEzosd06xoN9uq+4J8yB3o1PHSUId
	Hz51o6+qPwsueUON9pYGZUVH2e2DOesZP2l2+RJJQS1GUUhA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ayem9aqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 08:45:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B58jJTC026251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 08:45:19 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 00:45:15 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <song@kernel.org>,
        <james.clark@linaro.org>, <yangyicong@hisilicon.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 0/3] perf tool: Fix multiple memory leakages
Date: Thu, 5 Dec 2024 16:44:57 +0800
Message-ID: <20241205084500.823660-1-quic_zhonhan@quicinc.com>
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
X-Proofpoint-GUID: fr_8Lo8tWPo6KFgSei4N8lmay6lzWp6B
X-Proofpoint-ORIG-GUID: fr_8Lo8tWPo6KFgSei4N8lmay6lzWp6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=969 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050062

Fix memory leakages when btf_node or bpf_prog_info_node is duplicated
during insertion into perf_env.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
---
v1 -> v2:
- Following Namhyung's review suggestions, optimize patch 3 by removing
  initialization of the return value to true. Instead, use the internal
  function's return value directly and add a blank line between the
  declaration and other statements.
- Add a blank line before the return statement.
- Following Namhyung's review suggestions, fix the incorrect Fixes tags
  for all three patches.
- Link to v1: https://lore.kernel.org/all/20241128125432.2748981-1-quic_zhonhan@quicinc.com/

Zhongqiu Han (3):
  perf header: Fix one memory leakage in process_bpf_btf()
  perf header: Fix one memory leakage in process_bpf_prog_info()
  perf bpf: Fix two memory leakages when calling
    perf_env__insert_bpf_prog_info()

 tools/perf/util/bpf-event.c | 10 ++++++++--
 tools/perf/util/env.c       | 13 +++++++++----
 tools/perf/util/env.h       |  4 ++--
 tools/perf/util/header.c    |  8 ++++++--
 4 files changed, 25 insertions(+), 10 deletions(-)


base-commit: bcf2acd8f64b0a5783deeeb5fd70c6163ec5acd7
-- 
2.25.1


