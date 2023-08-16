Return-Path: <bpf+bounces-7909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F132D77E598
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA4A1C20FA2
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC811641B;
	Wed, 16 Aug 2023 15:50:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D9125B2
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 15:50:02 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A67A2733;
	Wed, 16 Aug 2023 08:49:53 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFauQm012404;
	Wed, 16 Aug 2023 15:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FJZYLStsj55jSIlYlDgwpbg7S5EBCrJAiAQRw3GAopw=;
 b=CnO52sh4ZH5oiqh3tfLQ0EkwiicbWZKrhznXHo2V7ByO6OalRCxb4tDZi+7D5KQDVE/0
 ls5Cjv0YAADdDV8tPBlncZxF8JE958h1ACetIIDk9xZdsZ0uXoxFxSoHMwFrijaqq9oz
 4piKlo7g1UOh/qlP1CuJBcemk+kaMtiWygB1qAiJSFOI8VOpXT1s3gFTn1S7M3FVV7W/
 BOQKr6HvMm4MICZlvK6ZvPRIEMyxv5RsJFxzg/iZeMiReg90TQsuVr/FheYLXaZPDC94
 gJtVKYb0fPxSa6hAe9oL/hKEXC3U3+d95F3menOaXdaHD4I6PC7KZUXrTYyBM8QxmCeZ ow== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh12u8q53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 15:49:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFBsqM002403;
	Wed, 16 Aug 2023 15:49:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendne2se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 15:49:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GFnk1u26936042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 15:49:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D993D2004B;
	Wed, 16 Aug 2023 15:49:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C74F120040;
	Wed, 16 Aug 2023 15:49:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Aug 2023 15:49:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 7BC89E012C; Wed, 16 Aug 2023 17:49:46 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH RESEND v3 3/3] tracing/synthetic: allocate one additional element for size
Date: Wed, 16 Aug 2023 17:49:28 +0200
Message-Id: <20230816154928.4171614-4-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816154928.4171614-1-svens@linux.ibm.com>
References: <20230816154928.4171614-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rq6ZPzLbUSRNKmXEE-XkXN_ezXXgVytQ
X-Proofpoint-GUID: Rq6ZPzLbUSRNKmXEE-XkXN_ezXXgVytQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While debugging another issue i noticed that the stack trace contains
one invalid entry at the end:

<idle>-0       [008] d..4.    26.484201: wake_lat: pid=0 delta=2629976084 000000009cc24024 stack=STACK:
=> __schedule+0xac6/0x1a98
=> schedule+0x126/0x2c0
=> schedule_timeout+0x150/0x2c0
=> kcompactd+0x9ca/0xc20
=> kthread+0x2f6/0x3d8
=> __ret_from_fork+0x8a/0xe8
=> 0x6b6b6b6b6b6b6b6b

This is because the code failed to add the one element containing the
number of entries to field_size.

Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/trace_events_synth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 80a2a832f857..9897d0bfcab7 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -528,7 +528,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		str_val = (char *)(long)var_ref_vals[val_idx];
 
 		if (event->dynamic_fields[i]->is_stack) {
-			len = *((unsigned long *)str_val);
+			/* reserve one extra element for size */
+			len = *((unsigned long *)str_val) + 1;
 			len *= sizeof(unsigned long);
 		} else {
 			len = fetch_store_strlen((unsigned long)str_val);
-- 
2.39.2


