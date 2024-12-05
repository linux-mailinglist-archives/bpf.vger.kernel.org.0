Return-Path: <bpf+bounces-46137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC09E501D
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 09:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D783A1699F0
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44A1D3194;
	Thu,  5 Dec 2024 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LVqBCr2m"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642601C3C1B;
	Thu,  5 Dec 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388351; cv=none; b=qK34THNsZd6AyYFzMsJb4+v3iOx72ROKHA7P1IdLNHvV253vhopjkAVD2/iI5bVKTtvY38vBTlaljTtIuRvDOnf/9h3mStM6oUCVmThwX90UUIptWP3Jz9J8GKFOLtVF1oCqk2Gm9QjqUZCb6K2m1W3xcjtkBaXo++YSd+jIBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388351; c=relaxed/simple;
	bh=yBxMDzLUQ+UUqEGx4gccp27vhPftyCQVLW4rYP1jVdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bufkvKm47C9Ia2dLOYD9V4dyU2w4SliHCA6Fxk19GgZKvVtfqqmGEgMKRIvdeenC7IkGI3rezqlZ6MDl5f7oyqrsGiYOfdV+xQcYa+fsblKnBgCgNvIxPsSkFAfUvbdyJPtjegwXSy62WQspKSYflXiV8TotCMU4M7sQ2Ygliv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LVqBCr2m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B55iRSX032114;
	Thu, 5 Dec 2024 08:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bKfgrYa/QFrkOV0zx4Ss0Pk/DtiPxo2P5UZjLA/HY/g=; b=LVqBCr2m70ZUx1eF
	Pp5pB77RvZPgV15WB5i+7OX7uL6wy90AD8GzKGZei5vGJJdmS7VGzi0dYTlP5Stt
	Ty4tAgVKK8Ep+Nehf/827/eS1+kMCBByezripwrluGhKxW0CnfjZpVI9bl66z+c2
	apIltRM5QRE7x+ILPIyHfYVgJ2oFvhIr8g3iKg7FUsKZO9ssEIU9Q9t5CjvSH9cy
	eWlWY2Rb6VtT0VzQ37pkSd313so9PlhKXJE6jF/0LOOO7x/C1UNuFiU2aTi7+a/q
	9znam1RdGYwg0PxQBH/pjrvIazFFXFjZ+heYg0NlBcjbPL3wPjXeGeA8HnXYmp3v
	dwS29g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a3fawtvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 08:45:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B58jWnd012553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 08:45:32 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 00:45:28 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <song@kernel.org>,
        <james.clark@linaro.org>, <yangyicong@hisilicon.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 3/3] perf bpf: Fix two memory leakages when calling perf_env__insert_bpf_prog_info()
Date: Thu, 5 Dec 2024 16:45:00 +0800
Message-ID: <20241205084500.823660-4-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205084500.823660-1-quic_zhonhan@quicinc.com>
References: <20241205084500.823660-1-quic_zhonhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -GyyUAnOy5XPi3guRMJW6aOqz-G5-Zmv
X-Proofpoint-GUID: -GyyUAnOy5XPi3guRMJW6aOqz-G5-Zmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050062

If perf_env__insert_bpf_prog_info() returns false due to a duplicate bpf
prog info node insertion, the temporary info_node and info_linear memory
will leak. Add a check to ensure the memory is freed if the function
returns false.

Fixes: e4378f0cb90b ("perf bpf: Save bpf_prog_info in a rbtree in perf_env")
Fixes: d56354dc4909 ("perf tools: Save bpf_prog_info and BTF of new BPF programs")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-event.c | 10 ++++++++--
 tools/perf/util/env.c       |  8 ++++++--
 tools/perf/util/env.h       |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 13608237c50e..c81444059ad0 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -289,7 +289,10 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		}
 
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
+			free(info_linear);
+			free(info_node);
+		}
 		info_linear = NULL;
 
 		/*
@@ -480,7 +483,10 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	info_node = malloc(sizeof(struct bpf_prog_info_node));
 	if (info_node) {
 		info_node->info_linear = info_linear;
-		perf_env__insert_bpf_prog_info(env, info_node);
+		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
+			free(info_linear);
+			free(info_node);
+		}
 	} else
 		free(info_linear);
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index d7865ae5f8f5..a6321e7f0633 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -24,12 +24,16 @@ struct perf_env perf_env;
 #include "bpf-utils.h"
 #include <bpf/libbpf.h>
 
-void perf_env__insert_bpf_prog_info(struct perf_env *env,
+bool perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node)
 {
+	bool ret;
+
 	down_write(&env->bpf_progs.lock);
-	__perf_env__insert_bpf_prog_info(env, info_node);
+	ret = __perf_env__insert_bpf_prog_info(env, info_node);
 	up_write(&env->bpf_progs.lock);
+
+	return ret;
 }
 
 bool __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 9db2e5a625ed..da11add761d0 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -178,7 +178,7 @@ int perf_env__nr_cpus_avail(struct perf_env *env);
 void perf_env__init(struct perf_env *env);
 bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
 				      struct bpf_prog_info_node *info_node);
-void perf_env__insert_bpf_prog_info(struct perf_env *env,
+bool perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
-- 
2.25.1


