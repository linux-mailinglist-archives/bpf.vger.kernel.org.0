Return-Path: <bpf+bounces-7911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B977E631
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5DE28199A
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C11642F;
	Wed, 16 Aug 2023 16:18:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C002156E8
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 16:18:26 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54FA2704;
	Wed, 16 Aug 2023 09:18:24 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFoXWS021488;
	Wed, 16 Aug 2023 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m05c/qLPzxh89HW5MXXsDJFf1NWFW8gLAgWmwTK3mQc=;
 b=etqhHAoVHFN9gCVk6sZFWx46Q2gfWu6MTchrQZKypONnQLZfBv2bOZ8DklOrtAYmwVPo
 ScIHjz3w9kwpVdCvx5Bz3I58Cbn4U/wMuLAdC161jpMDGqrgXnI1O2nMCwdqxa2pPzGK
 FZZYTLQDowXzgbb6GpayoqtkF2C1WQ8PeAW6+HEcMv0C4Y0XytmBmPlhVNc/eMsO49l3
 255cgeDPFpDvjbNYndnQyhoKzouSg4Cchhl+P5C70l10f4mw1TRLeqmBmbvKy2qk1X9U
 YGWqa1JIGeGJki5xfrjDvuEQHgwxoEWk6ie1k1dM87BxZf3e4u+5Gszt0kDhw28YXvLQ Fg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh1eurt7r-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 16:18:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFeOe4003459;
	Wed, 16 Aug 2023 15:49:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdsphh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 15:49:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GFnkpT26936036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 15:49:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46FCB2004F;
	Wed, 16 Aug 2023 15:49:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3394C2004E;
	Wed, 16 Aug 2023 15:49:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Aug 2023 15:49:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id D63C0E012C; Wed, 16 Aug 2023 17:49:45 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH RESEND v3 2/3] tracing/synthetic: skip first entry for stack traces
Date: Wed, 16 Aug 2023 17:49:27 +0200
Message-Id: <20230816154928.4171614-3-svens@linux.ibm.com>
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
X-Proofpoint-GUID: EuPMFYJ89KLizs5WJYxpGi2ZxcmHwTbA
X-Proofpoint-ORIG-GUID: EuPMFYJ89KLizs5WJYxpGi2ZxcmHwTbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_16,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While debugging another issue i noticed that the stack trace output
contains the number of entries on top:

         <idle>-0       [000] d..4.   203.322502: wake_lat: pid=0 delta=2268270616 stack=STACK:
=> 0x10
=> __schedule+0xac6/0x1a98
=> schedule+0x126/0x2c0
=> schedule_timeout+0x242/0x2c0
=> __wait_for_common+0x434/0x680
=> __wait_rcu_gp+0x198/0x3e0
=> synchronize_rcu+0x112/0x138
=> ring_buffer_reset_online_cpus+0x140/0x2e0
=> tracing_reset_online_cpus+0x15c/0x1d0
=> tracing_set_clock+0x180/0x1d8
=> hist_register_trigger+0x486/0x670
=> event_hist_trigger_parse+0x494/0x1318
=> trigger_process_regex+0x1d4/0x258
=> event_trigger_write+0xb4/0x170
=> vfs_write+0x210/0xad0
=> ksys_write+0x122/0x208

Fix this by skipping the first element. Also replace the pointer
logic with an index variable which is easier to read.

Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/trace_events_synth.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 7fff8235075f..80a2a832f857 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -350,7 +350,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	struct synth_trace_event *entry;
 	struct synth_event *se;
-	unsigned int i, n_u64;
+	unsigned int i, j, n_u64;
 	char print_fmt[32];
 	const char *fmt;
 
@@ -389,18 +389,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
 		} else if (se->fields[i]->is_stack) {
-			unsigned long *p, *end;
 			union trace_synth_field *data = &entry->fields[n_u64];
-
-			p = (void *)entry + data->as_dynamic.offset;
-			end = (void *)p + data->as_dynamic.len - (sizeof(long) - 1);
+			unsigned long *p = (void *)entry + data->as_dynamic.offset;
 
 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
-
-			for (; *p && p < end; p++)
-				trace_seq_printf(s, "=> %pS\n", (void *)*p);
+			for (j = 1; j < data->as_dynamic.len / sizeof(long); j++)
+				trace_seq_printf(s, "=> %pS\n", (void *)p[j]);
 			n_u64++;
-
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -490,10 +485,6 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 			break;
 	}
 
-	/* Include the zero'd element if it fits */
-	if (len < HIST_STACKTRACE_DEPTH)
-		len++;
-
 	len *= sizeof(long);
 
 	/* Find the dynamic section to copy the stack into. */
-- 
2.39.2


