Return-Path: <bpf+bounces-38867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596CC96B234
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 08:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738611C212AB
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 06:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F05145B3E;
	Wed,  4 Sep 2024 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anx+jUJn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CC1DDE9;
	Wed,  4 Sep 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433172; cv=none; b=eI2C6kR2RsOm30GVb/J70T8k3DbCOmOKtIA3g6jbwj85knUIi/Y0IPo4xk7k9HpB+CkNiI1iJhqkvDvZ9iqb/N7mp/DsCWl/j6vd2g6Gw1+aBuKvPMLopQR1cf/czJF/DE2K8UQKRp8RQEeG0L2WKUdedRmstFzV8X7mvoi+h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433172; c=relaxed/simple;
	bh=aQyhcc3F3PANNj74AR0gp1Z4T/rwnutME68N8t9B1WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDQNPvdte++Fgc7PsThb2Okfx5DTkXXU/18vb8WYc8JzLFV56bvI2f6MnigsFWuFkoawbyEDOCFMWAFgCM2504Tc8f7Cw5l2rWYpknrt6piwmmqcR28sQ+Ychk4TPLXBPP4FxMCQO0+DoZg/UYEHbIod7E8Th5ogFJ1+xeY8XQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anx+jUJn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4843l4Ga026977;
	Wed, 4 Sep 2024 06:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=bpnTrhuT9tk24
	mc0lWEQWOy52/vroDUge2MFDgcCyR4=; b=anx+jUJn6idlgKmc8fF4BR02/M52W
	Pwr0wZpcMu8cQMN/FbWw9BYzTjBpUh9atZo5yA0PZ/+4p01HUlParICB3t9P9tZ5
	zMzttQ/mI1EL4Wnk5lxAn4DHGq3gvt+l82M64m38ukYlJSn7zpRIhKuf/xyj3oFy
	Y2KAboJICyb+5Sh2qe/H91Z658KQdww/6JBMK3YTwMfG51xRVjlgt9LsonbN2gwt
	v4YUSvUzr3HBTbSdI7LN2pUH3LPWKZTd1Cozbb8KQddzPaNtuXlQejxPyF/W03Gt
	0/wb/SjQpHVmpHv1DEc3Bd99pldiOBcva6zovSJ0EfkFv6cklIFVk5nbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqt1tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48455ePr011979;
	Wed, 4 Sep 2024 06:59:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegpxf9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846xJVk53346580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:59:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7160E20043;
	Wed,  4 Sep 2024 06:59:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F76D20040;
	Wed,  4 Sep 2024 06:59:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Sep 2024 06:59:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 203CEE0297; Wed,  4 Sep 2024 08:59:19 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 4/7] Add print_function_args()
Date: Wed,  4 Sep 2024 08:58:58 +0200
Message-ID: <20240904065908.1009086-5-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904065908.1009086-1-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g7qxufGOAcbGUCKmLgjBagyF508u6CrB
X-Proofpoint-ORIG-GUID: g7qxufGOAcbGUCKmLgjBagyF508u6CrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040049

Add a function to decode argument types with the help of BTF. Will
be used to display arguments in the function and function graph
tracer.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/trace_output.c | 68 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_output.h |  9 +++++
 2 files changed, 77 insertions(+)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..70405c4cceb6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -12,8 +12,11 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 #include <linux/idr.h>
+#include <linux/btf.h>
+#include <linux/bpf.h>
 
 #include "trace_output.h"
+#include "trace_btf.h"
 
 /* must be a power of 2 */
 #define EVENT_HASHSIZE	128
@@ -669,6 +672,71 @@ int trace_print_lat_context(struct trace_iterator *iter)
 	return !trace_seq_has_overflowed(s);
 }
 
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+void print_function_args(struct trace_seq *s, struct ftrace_regs *fregs,
+			 unsigned long func)
+{
+	const struct btf_param *param;
+	const struct btf_type *t;
+	const char *param_name;
+	char name[KSYM_NAME_LEN];
+	unsigned long arg;
+	struct btf *btf;
+	s32 tid, nr = 0;
+	int i;
+
+	trace_seq_printf(s, "(");
+
+	if (!ftrace_regs_has_args(fregs))
+		goto out;
+	if (lookup_symbol_name(func, name))
+		goto out;
+
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR_OR_NULL(btf))
+		goto out;
+
+	t = btf_find_func_proto(name, &btf);
+	if (IS_ERR_OR_NULL(t))
+		goto out;
+
+	param = btf_get_func_param(t, &nr);
+	if (!param)
+		goto out_put;
+
+	for (i = 0; i < nr; i++) {
+		arg = ftrace_regs_get_argument(fregs, i);
+
+		param_name = btf_name_by_offset(btf, param[i].name_off);
+		if (param_name)
+			trace_seq_printf(s, "%s = ", param_name);
+		t = btf_type_skip_modifiers(btf, param[i].type, &tid);
+		if (!t)
+			continue;
+		switch (BTF_INFO_KIND(t->info)) {
+		case BTF_KIND_PTR:
+			trace_seq_printf(s, "0x%lx", arg);
+			break;
+		case BTF_KIND_INT:
+			trace_seq_printf(s, "%ld", arg);
+			break;
+		case BTF_KIND_ENUM:
+			trace_seq_printf(s, "%ld", arg);
+			break;
+		default:
+			trace_seq_printf(s, "0x%lx (%d)", arg, BTF_INFO_KIND(param[i].type));
+			break;
+		}
+		if (i < nr - 1)
+			trace_seq_printf(s, ", ");
+	}
+out_put:
+	btf_put(btf);
+out:
+	trace_seq_printf(s, ")");
+}
+#endif
+
 /**
  * ftrace_find_event - find a registered event
  * @type: the type of event to look for
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index dca40f1f1da4..a21d8ce606f7 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -41,5 +41,14 @@ extern struct rw_semaphore trace_event_sem;
 #define SEQ_PUT_HEX_FIELD(s, x)				\
 	trace_seq_putmem_hex(s, &(x), sizeof(x))
 
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+void print_function_args(struct trace_seq *s, struct ftrace_regs *fregs,
+			 unsigned long func);
+#else
+static inline void print_function_args(struct trace_seq *s, struct ftrace_regs *fregs,
+				       unsigned long func) {
+	trace_seq_puts(s, "()");
+}
+#endif
 #endif
 
-- 
2.43.0


