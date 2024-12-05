Return-Path: <bpf+bounces-46138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7C29E5024
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 09:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AD718822D9
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B91D61B7;
	Thu,  5 Dec 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OwPLMNcM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9561D5CE7;
	Thu,  5 Dec 2024 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388357; cv=none; b=O3z4GVW23Dx1FysYk06wWEpaq2fDyvu3sUSnDH2QPl0IzY0v7fMb3s3ympkbhjf2odq+zKaoxok21CPQiee4dqflWmFDR72HOAlPdVfZoNrLKyB/L7wx4xywdk52osTYokk2HsyksWAVGdHXOWszaxvImpXULbex8z3GOaL7Umc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388357; c=relaxed/simple;
	bh=TGub+nnAnx+mngP881hWmOhOaQbFve+Of/d7IUxl9rI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0eE3lynLT9BRdTt9b/t023qoAai7EaTmCC0dAyXVN7uvcHdFjYbqakh22d3o4fCv5o/j2U0lYSjxAPN1UIH6aVsRE62U+mBMVK55dNNzok53Hyh9u6WYdC8ux8S1iIpxwETBwTR3EkS6ljwB/oq3XwcrSNogwEkulh2FS3EPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OwPLMNcM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B56npgH011461;
	Thu, 5 Dec 2024 08:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dAnrLVoF02cKvKJnUNPdsTtlf1wMvv8SdyQ2JCZLSG8=; b=OwPLMNcMhtm2zrnb
	kavwhJ1OcQhU1tB1xOQrjhWGEacod9Di9b4YiOKdo//DgVCCF5pb7X0i91/GNAFX
	xZQUbqehmWX60D4SuP2cwDzOGqrGwzy2ztrI7pcV6hGXcaGSDaag7a2dGYcvRfgN
	CvMMMUcAD/M5xPVskoH0ELMqv5/X1Z7aCBOcU1YBbijcFt/wdEBpmCHLzxJAkGJ8
	ea2L3GSlFPolNByj9ikGfVnDpiHOz2JKsD9FJ+eafBcZWsDt0qgGjRW2V8hbEiM9
	DnXMjlK6BSXVmCkMsMnj9muqd56aL3pVyHPVT7G5ZS2Fy5G82oAWmZDToAAPTVQ+
	kNuZGg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a4by5kh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 08:45:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B58jNJB003644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 08:45:23 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 00:45:19 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <song@kernel.org>,
        <james.clark@linaro.org>, <yangyicong@hisilicon.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH v2 1/3] perf header: Fix one memory leakage in process_bpf_btf()
Date: Thu, 5 Dec 2024 16:44:58 +0800
Message-ID: <20241205084500.823660-2-quic_zhonhan@quicinc.com>
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
X-Proofpoint-GUID: IhXAhm7f-ZBUPvRi_adCuRpNsB9LjIvN
X-Proofpoint-ORIG-GUID: IhXAhm7f-ZBUPvRi_adCuRpNsB9LjIvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050062

If __perf_env__insert_btf() returns false due to a duplicate btf node
insertion, the temporary node will leak. Add a check to ensure the memory
is freed if the function returns false.

Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to perf.data")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/header.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3451e542b69a..fbba6ffafec4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3205,7 +3205,8 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
 		if (__do_read(ff, node->data, data_size))
 			goto out;
 
-		__perf_env__insert_btf(env, node);
+		if (!__perf_env__insert_btf(env, node))
+			free(node);
 		node = NULL;
 	}
 
-- 
2.25.1


