Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE0E1F35F1
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFIIKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 04:10:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728034AbgFIIKd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Jun 2020 04:10:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059829Pv018473;
        Tue, 9 Jun 2020 04:10:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31huupsdss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 04:10:32 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05982DtH018934;
        Tue, 9 Jun 2020 04:10:31 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31huupsdrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 04:10:31 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05981RIe002294;
        Tue, 9 Jun 2020 08:10:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7wh1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 08:10:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0598AQTB1442262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 08:10:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8E8BA4054;
        Tue,  9 Jun 2020 08:10:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 662EBA405B;
        Tue,  9 Jun 2020 08:10:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 08:10:26 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     bpf@vger.kernel.org, jolsa@redhat.com, tmricht@linux.ibm.com,
        heiko.carstens@de.ibm.com, mhiramat@kernel.org, iii@linux.ibm.com,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v2 2/2] perf: Fix bpf prologue generation
Date:   Tue,  9 Jun 2020 10:10:19 +0200
Message-Id: <20200609081019.60234-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609081019.60234-1-sumanthk@linux.ibm.com>
References: <20200609081019.60234-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_02:2020-06-08,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 cotscore=-2147483648 suspectscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090056
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Issue:
bpf_probe_read is no longer available for architecture which has
overlapping address space. Hence bpf prologue generation fails

Fix:
Use bpf_probe_read_kernel for kernel member access. For user
attribute access in kprobes, use bpf_probe_read_user.

Other:
@user attribute was introduced in commit 1e032f7cfa14 ("perf-probe:
 Add user memory access attribute support")

Test:
1. ulimit -l 128 ; ./perf record -e tests/bpf_sched_setscheduler.c
2. cat tests/bpf_sched_setscheduler.c

static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
        (void *) 6;
static int (*bpf_probe_read_user)(void *dst, __u32 size,
                                  const void *unsafe_ptr) = (void *) 112;
static int (*bpf_probe_read_kernel)(void *dst, __u32 size,
        const void *unsafe_ptr) = (void *) 113;

SEC("func=do_sched_setscheduler  pid policy param->sched_priority@user")
int bpf_func__setscheduler(void *ctx, int err, pid_t pid, int policy,
                           int param)
{
        char fmt[] = "prio: %ld";
        bpf_trace_printk(fmt, sizeof(fmt), param);
        return 1;
}

char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;

3. ./perf script
   sched 305669 [000] 1614458.838675: perf_bpf_probe:func: (2904e508)
   pid=261614 policy=2 sched_priority=1

4. cat /sys/kernel/debug/tracing/trace
   <...>-309956 [006] .... 1616098.093957: 0: prio: 1

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/bpf-prologue.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index b020a8678eb9..9887ae09242d 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -142,7 +142,8 @@ static int
 gen_read_mem(struct bpf_insn_pos *pos,
 	     int src_base_addr_reg,
 	     int dst_addr_reg,
-	     long offset)
+	     long offset,
+	     int probeid)
 {
 	/* mov arg3, src_base_addr_reg */
 	if (src_base_addr_reg != BPF_REG_ARG3)
@@ -159,7 +160,7 @@ gen_read_mem(struct bpf_insn_pos *pos,
 		ins(BPF_MOV64_REG(BPF_REG_ARG1, dst_addr_reg), pos);
 
 	/* Call probe_read  */
-	ins(BPF_EMIT_CALL(BPF_FUNC_probe_read), pos);
+	ins(BPF_EMIT_CALL(probeid), pos);
 	/*
 	 * Error processing: if read fail, goto error code,
 	 * will be relocated. Target should be the start of
@@ -241,7 +242,7 @@ static int
 gen_prologue_slowpath(struct bpf_insn_pos *pos,
 		      struct probe_trace_arg *args, int nargs)
 {
-	int err, i;
+	int err, i, probeid;
 
 	for (i = 0; i < nargs; i++) {
 		struct probe_trace_arg *arg = &args[i];
@@ -276,11 +277,16 @@ gen_prologue_slowpath(struct bpf_insn_pos *pos,
 				stack_offset), pos);
 
 		ref = arg->ref;
+		probeid = BPF_FUNC_probe_read_kernel;
 		while (ref) {
 			pr_debug("prologue: arg %d: offset %ld\n",
 				 i, ref->offset);
+
+			if (ref->user_access)
+				probeid = BPF_FUNC_probe_read_user;
+
 			err = gen_read_mem(pos, BPF_REG_3, BPF_REG_7,
-					   ref->offset);
+					   ref->offset, probeid);
 			if (err) {
 				pr_err("prologue: failed to generate probe_read function call\n");
 				goto errout;
-- 
2.17.1

