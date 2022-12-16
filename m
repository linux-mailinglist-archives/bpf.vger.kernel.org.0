Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1550064E86C
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 10:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLPJDW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 04:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiLPJDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 04:03:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E501EEC4;
        Fri, 16 Dec 2022 01:03:18 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG6DsIV003485;
        Fri, 16 Dec 2022 09:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=MCHxJJgIqWX4kNoe0ebDzRZHM0zd874VF1CmfxJQ6Fk=;
 b=C29sc6CHD7yl22yPrvryU3oDgEeTaStmY2H+RbvbRhLARgE0DJWFc8gt7H5YJQMvX6xt
 6gpde1ZHrZIsNP6k535DLMN6PW2l8rcy9QV9L5Q1MrRLKz88XD8tJSAROmcCk0WThc0J
 DQ5YDHOl0B5S1QnNmm3ELlOo7pg0Jjjmg++y8EWacoTEh0QgbdD/4HQejos59WL9uFZr
 arEBykEGjoAa64fhEfhH94DeC/ot4B5TLUP8THPTlHQib20a8qkGgZSpg/KpiSgqlmoB
 iEl6d/ZBEXQzA/P9KI4q9hja0pQPO0r3ryqqZlIXVfCdqL2UqpJ2NPkMWKqq7HXmqrgT sg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg6tetk7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:03:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BG93DrB001768
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 09:03:13 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 01:03:11 -0800
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v4 2/2] trace: acquire buffer from temparary trace sequence
Date:   Fri, 16 Dec 2022 17:03:05 +0800
Message-ID: <1671181385-5719-2-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NndQ8hU9bNZO7siWX7Sv_L4x6sWtR09b
X-Proofpoint-GUID: NndQ8hU9bNZO7siWX7Sv_L4x6sWtR09b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_04,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

there is one dwc3 trace event declare as below,
DECLARE_EVENT_CLASS(dwc3_log_event,
	TP_PROTO(u32 event, struct dwc3 *dwc),
	TP_ARGS(event, dwc),
	TP_STRUCT__entry(
		__field(u32, event)
		__field(u32, ep0state)
		__dynamic_array(char, str, DWC3_MSG_MAX)
	),
	TP_fast_assign(
		__entry->event = event;
		__entry->ep0state = dwc->ep0state;
	),
	TP_printk("event (%08x): %s", __entry->event,
			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
				__entry->event, __entry->ep0state))
);
the problem is when trace function called, it will allocate up to
DWC3_MSG_MAX bytes from trace event buffer, but never fill the buffer
during fast assignment, it only fill the buffer when output function are
called, so this means if output function are not called, the buffer will
never used.

add __get_buf(len) which acquiree buffer from iter->tmp_seq when trace
output function called, it allow user write string to acquired buffer.

the mentioned dwc3 trace event will changed as below,
DECLARE_EVENT_CLASS(dwc3_log_event,
	TP_PROTO(u32 event, struct dwc3 *dwc),
	TP_ARGS(event, dwc),
	TP_STRUCT__entry(
		__field(u32, event)
		__field(u32, ep0state)
	),
	TP_fast_assign(
		__entry->event = event;
		__entry->ep0state = dwc->ep0state;
	),
	TP_printk("event (%08x): %s", __entry->event,
		dwc3_decode_event(__get_buf(DWC3_MSG_MAX), DWC3_MSG_MAX,
				__entry->event, __entry->ep0state))
);.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
v4: no change
v3: fix comment from maintainer in v2

 include/linux/trace_seq.h                  |  6 ++++++
 include/trace/stages/stage3_trace_output.h |  8 ++++++++
 include/trace/stages/stage7_class_define.h |  1 +
 kernel/trace/trace_seq.c                   | 22 ++++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 5a2c650..4a3bbab 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -95,6 +95,7 @@ extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
 extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 			      int prefix_type, int rowsize, int groupsize,
 			      const void *buf, size_t len, bool ascii);
+char *trace_seq_acquire(struct trace_seq *s, size_t len);
 
 #else /* CONFIG_TRACING */
 static inline void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
@@ -138,6 +139,11 @@ static inline int trace_seq_path(struct trace_seq *s, const struct path *path)
 {
 	return 0;
 }
+
+static inline char *trace_seq_acquire(struct trace_seq *s, size_t len)
+{
+	return NULL;
+}
 #endif /* CONFIG_TRACING */
 
 #endif /* _LINUX_TRACE_SEQ_H */
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 66374df..f60c453 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -139,3 +139,11 @@
 		u64 ____val = (u64)(value);		\
 		(u32) do_div(____val, NSEC_PER_SEC);	\
 	})
+
+/* Macros with flow control statements should be avoided */
+#undef __get_buf
+#define __get_buf(len)							\
+	({								\
+		WARN_ON_ONCE(seq_buf_buffer_left(&p->seq) < (len));	\
+		trace_seq_acquire(p, (len));				\
+	})
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 8795429..bcb960d 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -23,6 +23,7 @@
 #undef __get_rel_sockaddr
 #undef __print_array
 #undef __print_hex_dump
+#undef __get_buf
 
 /*
  * The below is not executed in the kernel. It is only what is
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 9c90b3a..c900b7c 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -403,3 +403,25 @@ int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 	return 1;
 }
 EXPORT_SYMBOL(trace_seq_hex_dump);
+
+/**
+ * trace_seq_acquire - acquire seq buffer with size len
+ * @s: trace sequence descriptor
+ * @len: size of buffer to be acquired
+ *
+ * acquire buffer with size of @len from trace_seq for output usage,
+ * user can fill string into that buffer.
+ *
+ * Returns start address of acquired buffer.
+ *
+ * it allow multiple usage in one trace output function call.
+ */
+char *trace_seq_acquire(struct trace_seq *s, size_t len)
+{
+	char *ret = trace_seq_buffer_ptr(s);
+
+	seq_buf_commit(&s->seq, len);
+
+	return ret;
+}
+EXPORT_SYMBOL(trace_seq_acquire);
-- 
2.7.4

