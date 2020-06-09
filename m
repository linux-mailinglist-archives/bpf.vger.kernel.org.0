Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F241F35F0
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 10:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgFIIKk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 04:10:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbgFIIKd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Jun 2020 04:10:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05985FRe059028;
        Tue, 9 Jun 2020 04:10:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31g77qunru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 04:10:32 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05988XKK072689;
        Tue, 9 Jun 2020 04:10:31 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31g77qunqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 04:10:31 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0598ATSl031062;
        Tue, 9 Jun 2020 08:10:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 31g2s827r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 08:10:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0598AQin4063666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 08:10:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59CE5A4064;
        Tue,  9 Jun 2020 08:10:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C96AA4067;
        Tue,  9 Jun 2020 08:10:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 08:10:25 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     bpf@vger.kernel.org, jolsa@redhat.com, tmricht@linux.ibm.com,
        heiko.carstens@de.ibm.com, mhiramat@kernel.org, iii@linux.ibm.com,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v2 1/2] perf: Fix user attribute access in kprobes
Date:   Tue,  9 Jun 2020 10:10:18 +0200
Message-Id: <20200609081019.60234-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609081019.60234-1-sumanthk@linux.ibm.com>
References: <20200609081019.60234-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_03:2020-06-08,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015
 cotscore=-2147483648 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090061
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Issue:
perf probe -a 'do_sched_setscheduler  pid policy
param->sched_priority@user' did not work before.

Fix:
Make (perf probe -a 'do_sched_setscheduler  pid policy
param->sched_priority@user') output equivalent to ftrace
('p:probe/do_sched_setscheduler _text+517384 pid=%r2:s32 policy=%r3:s32
sched_priority=+u0(%r4):s32' > kprobe_events)

Other:
1. Right now, __match_glob() does not handle [u]<offset>. For now, use
  *u]<offset>.
2. @user attribute was introduced in commit 1e032f7cfa14 ("perf-probe:
   Add user memory access attribute support")

Test:
1. perf probe -a 'do_sched_setscheduler  pid policy
   param->sched_priority@user'

2 ./perf script
   sched 305669 [000] 1614458.838675: perf_bpf_probe:func: (2904e508)
   pid=261614 policy=2 sched_priority=1

3. cat /sys/kernel/debug/tracing/trace
   <...>-309956 [006] .... 1616098.093957: 0: prio: 1

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c | 7 +++++--
 tools/perf/util/probe-file.c  | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a08f373d3305..df713a5d1e26 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1575,7 +1575,7 @@ static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
 	}
 
 	tmp = strchr(str, '@');
-	if (tmp && tmp != str && strcmp(tmp + 1, "user")) { /* user attr */
+	if (tmp && tmp != str && !strcmp(tmp + 1, "user")) { /* user attr */
 		if (!user_access_is_supported()) {
 			semantic_error("ftrace does not support user access\n");
 			return -EINVAL;
@@ -1995,7 +1995,10 @@ static int __synthesize_probe_trace_arg_ref(struct probe_trace_arg_ref *ref,
 		if (depth < 0)
 			return depth;
 	}
-	err = strbuf_addf(buf, "%+ld(", ref->offset);
+	if (ref->user_access)
+		err = strbuf_addf(buf, "%s%ld(", "+u", ref->offset);
+	else
+		err = strbuf_addf(buf, "%+ld(", ref->offset);
 	return (err < 0) ? err : depth;
 }
 
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 8c852948513e..064b63a6a3f3 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -1044,7 +1044,7 @@ static struct {
 	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
 	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
 	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
-	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
+	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*u]<offset>*"),
 	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
 	DEFINE_TYPE(FTRACE_README_IMMEDIATE_VALUE, "*\\imm-value,*"),
 };
-- 
2.17.1

