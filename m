Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC0455C5B
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 14:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhKRNN4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 08:13:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229714AbhKRNNz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 08:13:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AICMfqW022013;
        Thu, 18 Nov 2021 13:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=tMCS1XwUVl1BKDDgYe0FkgqBtanlugS0urknWgn/Wow=;
 b=OklhY3S5nFBWEzK3M5QcCz17xAf3ceha2KKGKgBRN8MrNoyBozLg8azg08OVs8LbftZH
 N9wba5HifEGR2GGQz9xvzjiaIQJT8WG912FRwj81qTlakL602R12txYZXDQW44SXq47U
 qwniCJZxRThrZZ1SYH0ZDw95nUVj4epRq2/u8WktdbWDQh1ftTppu1v60QUc+PdvyTl9
 PAbiJLuHP6C8XgNYmZegU505Nn8H4SXa3KcpJOjbp3wokpYZ0i51rjK3SDhxYD2pANO4
 d+Z0aDW6GcdtHYrGl/8/7PxKPuMvra9nXDV5jjnlu5/yptDen9UPha/E+bLeBeaIcDhO GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdpsks570-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 13:10:31 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AICNF01026779;
        Thu, 18 Nov 2021 13:10:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdpsks561-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 13:10:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AID3QCK007459;
        Thu, 18 Nov 2021 13:05:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mkdw6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 13:05:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AID5QT56423228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 13:05:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E253A42049;
        Thu, 18 Nov 2021 13:05:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70A554205C;
        Thu, 18 Nov 2021 13:05:19 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.63.210])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 13:05:19 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, songliubraving@fb.com,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com
Subject: [PATCH v2] bpf: Remove config check to enable bpf support for branch records
Date:   Thu, 18 Nov 2021 18:35:07 +0530
Message-Id: <20211118130507.170154-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MCevU-shEbSRuNzovsdhbppeKZB9e8_n
X-Proofpoint-ORIG-GUID: vpgw9Kmdqd1TLSRMqtw29oaGpD0hXakL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180075
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Branch data available to bpf programs can be very useful to get
stack traces out of userspace application.

Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
added bpf support to capture branch records in x86. Enable this feature
for other architectures as well by removing check specific to x86.
Incase any platform didn't support branch stack, it will return with
-EINVAL.

Selftest 'perf_branches' result on power9 machine with branch stacks
support.

Before this patch changes:
[command]# ./test_progs -t perf_branches
 #88/1 perf_branches/perf_branches_hw:FAIL
 #88/2 perf_branches/perf_branches_no_hw:OK
 #88 perf_branches:FAIL
Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED

After this patch changes:
[command]# ./test_progs -t perf_branches
 #88/1 perf_branches/perf_branches_hw:OK
 #88/2 perf_branches/perf_branches_no_hw:OK
 #88 perf_branches:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Selftest 'perf_branches' result on power9 machine which doesn't
support branch stack

After this patch changes:
[command]# ./test_progs -t perf_branches
 #88/1 perf_branches/perf_branches_hw:SKIP
 #88/2 perf_branches/perf_branches_no_hw:OK
 #88 perf_branches:OK
Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED

Fixes: fff7b64355eac ("bpf: Add bpf_read_branch_records() helper")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---

Tested this patch changes on power9 machine using selftest
'perf branches' which is added in commit 67306f84ca78 ("selftests/bpf:
Add bpf_read_branch_records()")

Changelog:
v1 -> v2
- Inorder to add bpf support to capture branch record in
  powerpc, rather then adding config for powerpc, entirely
  remove config check from bpf_read_branch_records function
  as suggested by Peter Zijlstra

- Link to the v1 patch: https://lkml.org/lkml/2021/11/14/434

 kernel/trace/bpf_trace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7396488793ff..5e445985c6b4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1402,9 +1402,6 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
 BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
-#ifndef CONFIG_X86
-	return -ENOENT;
-#else
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
 	struct perf_branch_stack *br_stack = ctx->data->br_stack;
 	u32 to_copy;
@@ -1425,7 +1422,6 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	memcpy(buf, br_stack->entries, to_copy);
 
 	return to_copy;
-#endif
 }
 
 static const struct bpf_func_proto bpf_read_branch_records_proto = {
-- 
2.27.0

