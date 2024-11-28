Return-Path: <bpf+bounces-45827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EDC9DB802
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 13:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F0F281F7B
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 12:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3121AA1E2;
	Thu, 28 Nov 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L9aiU8iH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F81A9B51;
	Thu, 28 Nov 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798523; cv=none; b=PrVckse01oP269LVV8RrfprhhLMX40gxiZreZDY/kLSA4B5He3gNV8RHVoCrsCG4SIlw0smAlgcTNPXb78y0zgVedxWvc4OpjsZwmtdzTQ2NF+6k7JcDnk8DZB53kXfBfxJp3GXbw3XRJBztbNJoJ7+q29lk3v/op2RPsNtcLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798523; c=relaxed/simple;
	bh=kmClH6K+ZKxbtSiVWiRLeiqkhHiTkiq5DgAxlIoY11I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDjGHmI53Oi/kWHzZvFyf78pil05bdAd1kopUlOaHBPK2PeBU30sS7QkWnFgnAjAjQV8kmi/ZEoAyLp3eQrYZur2Cgd+FNd5lKKXhx139s7EF7F1VvjV3HWrVgSXZyR5yVGuvWDf04yPSydr7l4aaWzeBS8K/Fl7TDMRzyXIKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L9aiU8iH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS8bMQB022932;
	Thu, 28 Nov 2024 12:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2L0CerSr3kMsoq1YLCEchm17fKUPWuJk+2P/A5PgZiM=; b=L9aiU8iHm/t3jY7x
	F4n+OWWdNaUOt++Cz23qQcqZIh62roE2DFFtlkMKzbdmwl7Gh3E/BhEZyRJK/jT6
	DdKOdiDcM7O/2Mfzb0uiJNvQEv4DXBth9vaBCjsVlJPIfScP/udC5cU5mHSk58EB
	bdNTumgSeRmyDpC/Ej5rRlMzlVtwRngketTvJMoF/51/+leiIsVhNteNhdflILXm
	FvisVkLQFzpyXpewYHYwZZ3AEb6L++uv3d9SfvKUhycL/BMHK0nmDIRvvnLo2zbq
	7OX7nchCLSe3v7lhpQZGWLcbJoTER+uYxHRWatvMyyGRiVFrjy1VHOA0/5/XzqmQ
	GmwARQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xwjqpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:55:04 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASCt3id028923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:55:03 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 04:54:59 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@linaro.org>,
        <yangyicong@hisilicon.com>, <song@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH 3/3] perf bpf: Fix two memory leakages when calling perf_env__insert_bpf_prog_info()
Date: Thu, 28 Nov 2024 20:54:32 +0800
Message-ID: <20241128125432.2748981-4-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128125432.2748981-1-quic_zhonhan@quicinc.com>
References: <20241128125432.2748981-1-quic_zhonhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: R1vVtqECV7v4n1oGNtvC-IJyQPzlTA0V
X-Proofpoint-GUID: R1vVtqECV7v4n1oGNtvC-IJyQPzlTA0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280101

If perf_env__insert_bpf_prog_info() returns false due to a duplicate bpf
prog info node insertion, the temporary info_node and info_linear memory
will leak. Add a check to ensure the memory is freed if the function
returns false.

Fixes: 9c51f8788b5d ("perf env: Avoid recursively taking env->bpf_progs.lock")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 tools/perf/util/bpf-event.c | 10 ++++++++--
 tools/perf/util/env.c       |  7 +++++--
 tools/perf/util/env.h       |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

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
index d7865ae5f8f5..38401a289c24 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -24,12 +24,15 @@ struct perf_env perf_env;
 #include "bpf-utils.h"
 #include <bpf/libbpf.h>
 
-void perf_env__insert_bpf_prog_info(struct perf_env *env,
+bool perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node)
 {
+	bool ret = true;
 	down_write(&env->bpf_progs.lock);
-	__perf_env__insert_bpf_prog_info(env, info_node);
+	if (!__perf_env__insert_bpf_prog_info(env, info_node))
+		ret = false;
 	up_write(&env->bpf_progs.lock);
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


