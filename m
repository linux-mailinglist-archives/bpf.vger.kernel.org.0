Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49B64CBDB
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 15:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiLNOMH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 09:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbiLNOL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 09:11:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9439022535;
        Wed, 14 Dec 2022 06:11:54 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEDux0j026964;
        Wed, 14 Dec 2022 14:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=rgqFgMAkXTSjXWTUQJsx9snCAvVEafA20v2NTLpN08Y=;
 b=FMbw/LrgcwRieAs3ubUQIyBDJuCUO7g+bpAJdVWgb6cf8AYcKQDOk1Fiad84EP90dIWa
 U29f5IMc0omDTrFdast5GsNdhIjSerspzczhqIXMfiAIoZTMDlxvJBDRWzrn6z953ofo
 rVWbs6QkjRgnYeT6Zdrqfi1nL+smweJrNLCoNSn2r/tgziS4CyCjtnerOMPxpsYss/1i
 8ciDayF/6oRL7hacuLzIO7oafby3AiT5bEOIAOTFQLEdWUmmvx7qDqtw1CzLEXLUHGND
 crFth2BikrqRcjWUMmfZdjP5s9TMYm0QgejSUvV6HwfHN17TxAGQDho7hAw0RHkaNT0X Ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6re9bvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 14:11:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEEBodK023340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 14:11:50 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 06:11:49 -0800
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [RFC PATCH 2/2] trace: allocate temparary buffer for trace output usage
Date:   Wed, 14 Dec 2022 22:11:42 +0800
Message-ID: <1671027102-21403-2-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671027102-21403-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1671027102-21403-1-git-send-email-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5PV4P6qmnsJ_FTIjFA9X53Ggrjyh8Iav
X-Proofpoint-ORIG-GUID: 5PV4P6qmnsJ_FTIjFA9X53Ggrjyh8Iav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140112
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

add __alloc_buf() and __get_buf() which will not allocate event buffer
when trace function called, but when trace output function called, it will
kmalloc buffer with size DWC3_MSG_MAX for temprary usage and free it
before trace output function return.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 include/trace/stages/stage1_struct_define.h |  5 +++
 include/trace/stages/stage3_trace_output.h  | 60 +++++++++++++++++++++++++++++
 include/trace/stages/stage4_event_fields.h  |  6 +++
 include/trace/stages/stage7_class_define.h  |  1 +
 include/trace/trace_events.h                | 29 +++++++++++++-
 5 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/include/trace/stages/stage1_struct_define.h b/include/trace/stages/stage1_struct_define.h
index 69e0dae..7eba055 100644
--- a/include/trace/stages/stage1_struct_define.h
+++ b/include/trace/stages/stage1_struct_define.h
@@ -56,5 +56,10 @@
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
 
+#undef __alloc_buf
+#define __alloc_buf(len)
+
+/* __get_buf is not allow present inside TP_STRUCT__entry */
+
 #undef TP_STRUCT__entry
 #define TP_STRUCT__entry(args...) args
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 66374df..824061f 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -139,3 +139,63 @@
 		u64 ____val = (u64)(value);		\
 		(u32) do_div(____val, NSEC_PER_SEC);	\
 	})
+
+#undef __field
+#define __field(type, item)
+
+#undef __field_ext
+#define __field_ext(type, item, filter_type)
+
+#undef __field_struct
+#define __field_struct(type, item)
+
+#undef __field_struct_ext
+#define __field_struct_ext(type, item, filter_type)
+
+#undef __array
+#define __array(type, item, len)
+
+#undef __dynamic_array
+#define __dynamic_array(type, item, len)
+
+#undef __string
+#define __string(item, src)
+
+#undef __string_len
+#define __string_len(item, src, len)
+
+#undef __vstring
+#define __vstring(item, fmt, ap)
+
+#undef __bitmask
+#define __bitmask(item, nr_bits)
+
+#undef __cpumask
+#define __cpumask(item)
+
+#undef __sockaddr
+#define __sockaddr(field, len)
+
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)
+
+#undef __rel_string
+#define __rel_string(item, src)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits)
+
+#undef __rel_cpumask
+#define __rel_cpumask(item)
+
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len)
+
+#undef __alloc_buf
+#define __alloc_buf(len)	__buf_len = (len);
+
+#undef __get_buf
+#define __get_buf(offset)	(__buf + (offset))
diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index f2990d2..e78399d74 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -72,3 +72,9 @@
 
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
+#undef __alloc_buf
+#define __alloc_buf(len)
+
+#undef __get_buf
+#define __get_buf(offset)
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
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index c2f9cab..cca6b38 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -192,6 +192,8 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 	struct trace_seq *s = &iter->seq;				\
 	struct trace_seq __maybe_unused *p = &iter->tmp_seq;		\
 	struct trace_event_raw_##call *field;				\
+	void *__buf = NULL;						\
+	size_t __buf_len = 0;						\
 	int ret;							\
 									\
 	field = (typeof(field))iter->ent;				\
@@ -200,8 +202,18 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 	if (ret != TRACE_TYPE_HANDLED)					\
 		return ret;						\
 									\
+	tstruct;							\
+									\
+	if (__buf_len) {						\
+		__buf = kmalloc(__buf_len, GFP_KERNEL);			\
+		if (!__buf)						\
+			return -ENOMEM;					\
+	}								\
+									\
 	trace_event_printf(iter, print);				\
 									\
+	kfree(__buf);							\
+									\
 	return trace_handle_return(s);					\
 }									\
 static struct trace_event_functions trace_event_type_funcs_##call = {	\
@@ -217,6 +229,9 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 	struct trace_event_raw_##template *field;			\
 	struct trace_entry *entry;					\
 	struct trace_seq *p = &iter->tmp_seq;				\
+	void *__buf = NULL;						\
+	size_t __buf_len = 0;						\
+	int ret;							\
 									\
 	entry = iter->ent;						\
 									\
@@ -227,8 +242,20 @@ trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
 									\
 	field = (typeof(field))entry;					\
 									\
+	tstruct;							\
+									\
+	if (__buf_len) {						\
+		__buf = kmalloc(__buf_len, GFP_KERNEL);			\
+		if (!__buf)						\
+			return -ENOMEM;					\
+	}								\
+									\
 	trace_seq_init(p);						\
-	return trace_output_call(iter, #call, print);			\
+	ret = trace_output_call(iter, #call, print);			\
+									\
+	kfree(__buf);							\
+									\
+	return ret;							\
 }									\
 static struct trace_event_functions trace_event_type_funcs_##call = {	\
 	.trace			= trace_raw_output_##call,		\
-- 
2.7.4

