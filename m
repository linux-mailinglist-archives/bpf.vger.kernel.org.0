Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78C564E80C
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 09:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLPISJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 03:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPISI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 03:18:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE742E9E3;
        Fri, 16 Dec 2022 00:18:06 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG6AQlE018257;
        Fri, 16 Dec 2022 08:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=IZNwRIt/4SGUpP71pqbhjPeFA1br7ufyMrbBT8yD22Q=;
 b=H3Mq5TuCgv0WOSWYIMBArpphcYjYZCAmoSsEVhstpj1Y6xY084lJaRcarPugQ+il1rAv
 L311aeRh78KJm3Orb+9JtDHpYhI5duii76Q60EMlZ7juYErtxWd2pi3AzQNrlm4PolEM
 qBgrECbUBh/bYTg+F1GKt4KWCNN2zuHstRlIgI/JnAzyWf+t41bmC+zRJyhoKDdWq/XJ
 wm4Ig+3Aev8ejgENWFCRi46K0/x6TivSSq/02Z/5SWDnmly9vV1ry3rfEpWcRfhl2s32
 v2UeZZMCx+DUdfbXxBI5q/IIuQ6yGfa6Yv6MIA06dfs7u49vsCmEWa+23cFr4zbDXtLy Og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg2893hv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 08:18:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BG8I1h8015288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 08:18:01 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 00:17:59 -0800
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v3 1/2] trace: add new file under include/trace/stages/ for perf/bpf
Date:   Fri, 16 Dec 2022 16:17:54 +0800
Message-ID: <1671178675-28720-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hhryi-tKxUuZeZqj9jZcC6Jh0C6bkNiF
X-Proofpoint-ORIG-GUID: Hhryi-tKxUuZeZqj9jZcC6Jh0C6bkNiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_03,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=971
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

when experiment change for trace operation, the files under
include/trace/stages/ will be changed, perf/bpf trace may compile fail.

add new file stage8_perf_call.h and stage9_bpf_call.h under
include/trace/stages/, it will make sure no missing change when expriment.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
v3: consider perf as stage 8, bpf as stage 9, file name purpose only.
v2: not exist

 include/trace/bpf_probe.h               | 51 +------------------------------
 include/trace/perf.h                    | 52 +-------------------------------
 include/trace/stages/stage8_perf_call.h | 53 +++++++++++++++++++++++++++++++++
 include/trace/stages/stage9_bpf_call.h  | 52 ++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 101 deletions(-)
 create mode 100644 include/trace/stages/stage8_perf_call.h
 create mode 100644 include/trace/stages/stage9_bpf_call.h

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 155c495..a6eeb9e 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -4,56 +4,7 @@
 
 #ifdef CONFIG_BPF_EVENTS
 
-#undef __entry
-#define __entry entry
-
-#undef __get_dynamic_array
-#define __get_dynamic_array(field)	\
-		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
-
-#undef __get_dynamic_array_len
-#define __get_dynamic_array_len(field)	\
-		((__entry->__data_loc_##field >> 16) & 0xffff)
-
-#undef __get_str
-#define __get_str(field) ((char *)__get_dynamic_array(field))
-
-#undef __get_bitmask
-#define __get_bitmask(field) (char *)__get_dynamic_array(field)
-
-#undef __get_cpumask
-#define __get_cpumask(field) (char *)__get_dynamic_array(field)
-
-#undef __get_sockaddr
-#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
-
-#undef __get_rel_dynamic_array
-#define __get_rel_dynamic_array(field)	\
-		((void *)(&__entry->__rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +		\
-		 (__entry->__rel_loc_##field & 0xffff))
-
-#undef __get_rel_dynamic_array_len
-#define __get_rel_dynamic_array_len(field)	\
-		((__entry->__rel_loc_##field >> 16) & 0xffff)
-
-#undef __get_rel_str
-#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
-
-#undef __get_rel_bitmask
-#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __get_rel_cpumask
-#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __get_rel_sockaddr
-#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
-
-#undef __perf_count
-#define __perf_count(c)	(c)
-
-#undef __perf_task
-#define __perf_task(t)	(t)
+#include "stages/stage_bpf_call.h"
 
 /* cast any integer, pointer, or small struct to u64 */
 #define UINTTYPE(size) \
diff --git a/include/trace/perf.h b/include/trace/perf.h
index 8f3bf1e..e899bf7 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -4,57 +4,7 @@
 
 #ifdef CONFIG_PERF_EVENTS
 
-#undef __entry
-#define __entry entry
-
-#undef __get_dynamic_array
-#define __get_dynamic_array(field)	\
-		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
-
-#undef __get_dynamic_array_len
-#define __get_dynamic_array_len(field)	\
-		((__entry->__data_loc_##field >> 16) & 0xffff)
-
-#undef __get_str
-#define __get_str(field) ((char *)__get_dynamic_array(field))
-
-#undef __get_bitmask
-#define __get_bitmask(field) (char *)__get_dynamic_array(field)
-
-#undef __get_cpumask
-#define __get_cpumask(field) (char *)__get_dynamic_array(field)
-
-#undef __get_sockaddr
-#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
-
-#undef __get_rel_dynamic_array
-#define __get_rel_dynamic_array(field)	\
-		((void *)__entry +					\
-		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +			\
-		 (__entry->__rel_loc_##field & 0xffff))
-
-#undef __get_rel_dynamic_array_len
-#define __get_rel_dynamic_array_len(field)	\
-		((__entry->__rel_loc_##field >> 16) & 0xffff)
-
-#undef __get_rel_str
-#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
-
-#undef __get_rel_bitmask
-#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __get_rel_cpumask
-#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __get_rel_sockaddr
-#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
-
-#undef __perf_count
-#define __perf_count(c)	(__count = (c))
-
-#undef __perf_task
-#define __perf_task(t)	(__task = (t))
+#include "stages/stage_perf_call.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
diff --git a/include/trace/stages/stage8_perf_call.h b/include/trace/stages/stage8_perf_call.h
new file mode 100644
index 0000000..54c8045
--- /dev/null
+++ b/include/trace/stages/stage8_perf_call.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef __entry
+#define __entry entry
+
+#undef __get_dynamic_array
+#define __get_dynamic_array(field)	\
+		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
+
+#undef __get_dynamic_array_len
+#define __get_dynamic_array_len(field)	\
+		((__entry->__data_loc_##field >> 16) & 0xffff)
+
+#undef __get_str
+#define __get_str(field) ((char *)__get_dynamic_array(field))
+
+#undef __get_bitmask
+#define __get_bitmask(field) ((char *)__get_dynamic_array(field))
+
+#undef __get_cpumask
+#define __get_cpumask(field) ((char *)__get_dynamic_array(field))
+
+#undef __get_sockaddr
+#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
+
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)	\
+		((void *)__entry +					\
+		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +			\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_rel_bitmask
+#define __get_rel_bitmask(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
+
+#undef __perf_count
+#define __perf_count(c)	(__count = (c))
+
+#undef __perf_task
+#define __perf_task(t)	(__task = (t))
diff --git a/include/trace/stages/stage9_bpf_call.h b/include/trace/stages/stage9_bpf_call.h
new file mode 100644
index 0000000..6dbcbdf
--- /dev/null
+++ b/include/trace/stages/stage9_bpf_call.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef __entry
+#define __entry entry
+
+#undef __get_dynamic_array
+#define __get_dynamic_array(field)	\
+		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
+
+#undef __get_dynamic_array_len
+#define __get_dynamic_array_len(field)	\
+		((__entry->__data_loc_##field >> 16) & 0xffff)
+
+#undef __get_str
+#define __get_str(field) ((char *)__get_dynamic_array(field))
+
+#undef __get_bitmask
+#define __get_bitmask(field) ((char *)__get_dynamic_array(field))
+
+#undef __get_cpumask
+#define __get_cpumask(field) ((char *)__get_dynamic_array(field))
+
+#undef __get_sockaddr
+#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
+
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)	\
+		((void *)(&__entry->__rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +		\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_rel_bitmask
+#define __get_rel_bitmask(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
+
+#undef __perf_count
+#define __perf_count(c)	(c)
+
+#undef __perf_task
+#define __perf_task(t)	(t)
-- 
2.7.4

