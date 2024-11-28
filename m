Return-Path: <bpf+bounces-45824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F789DB7FB
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 13:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9998163CFF
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD18119EED3;
	Thu, 28 Nov 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cUsObHI6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE092196C7C;
	Thu, 28 Nov 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798518; cv=none; b=b75AtPihBclYhoVEqvhfkOhPchqK48z1WaoAOOyBSF3HPnc9JNExdb3mQDkWkMH8F2XFVhFgD655MiJd8zzdpIK86Z3oa6ru7m9wcCcU7CQCyNhOwkIJpCC4F5w6N0auqJMiI22P03CqD6BW7iWgEW6Y3i/qSyasoz/I6CX1OxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798518; c=relaxed/simple;
	bh=sEtPShFiLdJcTxDqs3y2IAOYSKdGY4QhhxTPO+e7zUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uf42xwf2Hh1CK9JrOAtGxO3oN6wG0pD+fH5AAZQ/5mgC9f91hr38NUgXqYeJUJS1pM8DIKuwkjSCYGTADGk3EYCQmfa0jJtxfkyB8bAzfsvOedhl0T9zWIuSPVVuzN9iJOWdPqLE/Z6SPsrv7AeXORb6FxqkAAVgfWCncojJxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cUsObHI6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS7TXka005298;
	Thu, 28 Nov 2024 12:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h7sn6J2udbGejY+AXZz0wtHy+wTWQqAnvHhmeaZjXlc=; b=cUsObHI6fNpjXJG+
	Ms+/lvwoPbUKbJtH6mHPkQXZn3wx5nnwMbMGHbQvaKcHppRLJ0gymuRVkqiOS3tH
	LMLZIGJsSzvHX78vZAUrWSadGVftLkn65W6wNbUnmJMi+HcdFAnp70K9UGXwsOka
	P4SZWhL/ZYxTrKhvkYhn9Yf44kZAsJzAONz5sI5A/dDwkYge0iazsv1sACk0O9bJ
	JfSUjRhN69CaFWa9SpwrOB59+2iAmoH+RHY11f6rRNHdYbF8y07ZwSgA8hiXGmXV
	Oe72iv3yCAu+NlMwQpNh2ll/+jtPgR124V/c8xO9hyIp+VNmF0dBzyz/pAxlujv4
	8fit5w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xvtrfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:55:00 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASCsxQr027959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 12:54:59 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 04:54:55 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@linaro.org>,
        <yangyicong@hisilicon.com>, <song@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH 2/3] perf header: Fix one memory leakage in process_bpf_prog_info()
Date: Thu, 28 Nov 2024 20:54:31 +0800
Message-ID: <20241128125432.2748981-3-quic_zhonhan@quicinc.com>
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
X-Proofpoint-GUID: M_NjtbMCXdP50DfORTtbND3RCwQ-MgZx
X-Proofpoint-ORIG-GUID: M_NjtbMCXdP50DfORTtbND3RCwQ-MgZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411280101

Function __perf_env__insert_bpf_prog_info() will return without inserting
bpf prog info node into perf env again due to a duplicate bpf prog info
node insertion, causing the temporary info_linear and info_node memory to
leak. Modify the return type of this function to bool and add a check to
ensure the memory is freed if the function returns false.

Fixes: 9c51f8788b5d ("perf env: Avoid recursively taking env->bpf_progs.lock")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 tools/perf/util/env.c    | 5 +++--
 tools/perf/util/env.h    | 2 +-
 tools/perf/util/header.c | 5 ++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index e2843ca2edd9..d7865ae5f8f5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -32,7 +32,7 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 	up_write(&env->bpf_progs.lock);
 }
 
-void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
+bool __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info_node *info_node)
 {
 	__u32 prog_id = info_node->info_linear->info.id;
 	struct bpf_prog_info_node *node;
@@ -50,13 +50,14 @@ void __perf_env__insert_bpf_prog_info(struct perf_env *env, struct bpf_prog_info
 			p = &(*p)->rb_right;
 		} else {
 			pr_debug("duplicated bpf prog info %u\n", prog_id);
-			return;
+			return false;
 		}
 	}
 
 	rb_link_node(&info_node->rb_node, parent, p);
 	rb_insert_color(&info_node->rb_node, &env->bpf_progs.infos);
 	env->bpf_progs.infos_cnt++;
+	return true;
 }
 
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index ae604c4edbb7..9db2e5a625ed 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -176,7 +176,7 @@ const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-void __perf_env__insert_bpf_prog_info(struct perf_env *env,
+bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
 				      struct bpf_prog_info_node *info_node);
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fbba6ffafec4..d06aa86352d3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3158,7 +3158,10 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
-		__perf_env__insert_bpf_prog_info(env, info_node);
+		if (!__perf_env__insert_bpf_prog_info(env, info_node)) {
+			free(info_linear);
+			free(info_node);
+		}
 	}
 
 	up_write(&env->bpf_progs.lock);
-- 
2.25.1


