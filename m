Return-Path: <bpf+bounces-46136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497559E5016
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 09:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156241699F2
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136A1D515B;
	Thu,  5 Dec 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BBWvJf2c"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3A1CEEBA;
	Thu,  5 Dec 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388346; cv=none; b=QF+bWHg5+7NLxu/cO9sf+q6l7SNWpMKEX3dI5RXSEAYJRSj3caWD0aiiWS+CWAch9q9VODJDXBEN8y0uEoxR6iDbGv7/Uuxll1CxDSOiUdHPKwe18yDcOpSWjzNrl6K1vEnalxwPP+AGaZu96KTsu1JFYiu3wsw8uacnpJeycNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388346; c=relaxed/simple;
	bh=iFZ3o1xxnzcVaBDT4+57NLsT9SRj9h7MlvKaAIpVpfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaPe9OdJeO4gx5EReCgtFN0VX1sfwED5Lg5dbixJUNba4yBNuy8eitjm14dse0OqNCnOxa3IxRXn8QJmYux8eLo9RfsOCSD7NaLJ3WWPleuHjHvn/fsyr69KDxlZ2wxNaPE0WlSscRE2eal1eRkLQkWx7yL6GyObzM4zSOisuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BBWvJf2c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4LvCuk031569;
	Thu, 5 Dec 2024 08:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H29Tij9CROql8/xjcaPE5wTAS8wEjhzGuX8aaYvWiUo=; b=BBWvJf2cWImKLoKE
	icJqewwbSOzdRZORANbSF88vhzikZaJfquyx65ZM/eNf7Jo9PQql//+TjY/FQkYq
	tREvayKejNc6n8mrHJfsaS8aUC127KHTuL7bm88Og1FHNWI46g/mNKCb5lFjtPzC
	dBnr+BKUphJLuWJr2XMcwhIuREi5TRv3RQSCbQXF97eBD/XUJdEsHsc79rUUcScp
	/fI31tlknaaSNSGE6e4J0CerLjxEbb9xFaJr3WFwapIYIO6TKYDs016j8cYLSayZ
	i73KYp9mW7sp15JAqDuQ750EgmUlmzrF4vemmkpk25qIAB4lQ/X31wWTZxOCgREe
	/M6nIw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ayem9ar2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 08:45:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B58jRCl012520
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 08:45:28 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 00:45:23 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <song@kernel.org>,
        <james.clark@linaro.org>, <yangyicong@hisilicon.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 2/3] perf header: Fix one memory leakage in process_bpf_prog_info()
Date: Thu, 5 Dec 2024 16:44:59 +0800
Message-ID: <20241205084500.823660-3-quic_zhonhan@quicinc.com>
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
X-Proofpoint-GUID: noWfPXCPqgnXOigHQC22Wif7S-BViOg6
X-Proofpoint-ORIG-GUID: noWfPXCPqgnXOigHQC22Wif7S-BViOg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050062

Function __perf_env__insert_bpf_prog_info() will return without inserting
bpf prog info node into perf env again due to a duplicate bpf prog info
node insertion, causing the temporary info_linear and info_node memory to
leak. Modify the return type of this function to bool and add a check to
ensure the memory is freed if the function returns false.

Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
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


