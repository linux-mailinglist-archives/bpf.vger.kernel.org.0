Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4FD64D5E2
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 05:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiLOEdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 23:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOEdk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 23:33:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A980531DC1;
        Wed, 14 Dec 2022 20:33:38 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF4KiDg009520;
        Thu, 15 Dec 2022 04:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=oL6JKXXrslbXUvwLoHaym9HJ6v4B9FKe1acxHJChhjQ=;
 b=oYOkBcbRKIcWQ/rwgmvEkmAUs93BHQmBY3gBpUwXD8rrioFXSIFVDnEh63c1U5PI24Ca
 snCYNm98of336HYnUZfv6L7UrkRxPZCFXHfOCDnTfhE010vMIzjQeZ0K6s+FJ3vlNFo0
 Wa+vR0ZjnFAna6E1X2q07hfqXVCdVOZF9z7GfSR9DwwBxLGTMC1SwvP0xclzjrxiS35r
 xRApx5VJKpce8SxkA7GZNyNKe0N3lViQxc6yeC8yXpobC+8M3Q8P6ovFZzpkSCkX3jbU
 pmycERGOaaRIAyckvWAjRCILcXXgpUhM2SEF95Jbk1HuXJl3e2aVu7T8tCXrHTz4AgQw ag== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rtk6jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 04:33:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BF4XXJF032178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 04:33:33 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 20:33:31 -0800
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v1 1/2] trace: add new file under include/trace/stages/ for perf/bpf
Date:   Thu, 15 Dec 2022 12:33:26 +0800
Message-ID: <1671078807-20748-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dNNYiuEssxi75mYZKQPX0Zy_go8pq-xb
X-Proofpoint-ORIG-GUID: dNNYiuEssxi75mYZKQPX0Zy_go8pq-xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_02,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 mlxlogscore=984 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150031
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

add new file stage_perf_call.h and stage_bpf_call.h under
include/trace/stages, it will make sure no missing change when expriment.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 include/trace/bpf_probe.h              | 51 +-------------------------------
 include/trace/perf.h                   | 52 +-------------------------------
 include/trace/stages/stage_bpf_call.h  | 53 +++++++++++++++++++++++++++++++++
 include/trace/stages/stage_perf_call.h | 54 ++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 101 deletions(-)
 create mode 100644 include/trace/stages/stage_bpf_call.h
 create mode 100644 include/trace/stages/stage_perf_call.h

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
diff --git a/include/trace/stages/stage_bpf_call.h b/include/trace/stages/stage_bpf_call.h
new file mode 100644
index 0000000..0e6c4e9
--- /dev/null
+++ b/include/trace/stages/stage_bpf_call.h
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
+
diff --git a/include/trace/stages/stage_perf_call.h b/include/trace/stages/stage_perf_call.h
new file mode 100644
index 0000000..718db55
--- /dev/null
+++ b/include/trace/stages/stage_perf_call.h
@@ -0,0 +1,54 @@
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
+
-- 
2.7.4

