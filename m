Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0714690D8
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 08:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhLFHhd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 02:37:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhLFHhc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 6 Dec 2021 02:37:32 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B67HUr0025383;
        Mon, 6 Dec 2021 07:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=HkMSZMMkGG7qs/M6ldHGjZwCT5FBRbh/Mu0JItmT4HU=;
 b=fuY7zAZS3YT9yFCz/+QlCqrR1JL3u1EAw0y1XAEG4kBfJew0D8VGyLXYLplIZT7e7/90
 3kbwcSaRvsjtOertzdaDPg4qlG7zsfC1iggg1ZkkKR6K+WC3ckDgvu1d0sunbtKC6Nsf
 j0iQ2Dy6NelyxkdgKYBOxiHmlSAIiCDuKrD/R+2Z6UEqrJGNfnrsguhDePT0nszWzWDr
 Yn0eA/yrIPu8IEN9D6FOsf5pvd4AP5av5Qw40iCvAHSXczLPi8+2SimoKrVNjqr3Qki7
 4fXk/x6hKsXru3Gz3AIZ2KBfujp413qm4oZpZiTxmD5qrWvsn/5V8o4YSR6Zw946MvDq eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cse0j07wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 07:33:43 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B67M9SL008384;
        Mon, 6 Dec 2021 07:33:42 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cse0j07vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 07:33:42 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B67WbHH018385;
        Mon, 6 Dec 2021 07:33:40 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3cqykhsc2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 07:33:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B67XaOP29360562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 07:33:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02E784C04E;
        Mon,  6 Dec 2021 07:33:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D24F14C058;
        Mon,  6 Dec 2021 07:33:29 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.39.249])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 07:33:29 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, songliubraving@fb.com,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        andrii.nakryiko@gmail.com
Subject: [PATCH v4] bpf: Remove config check to enable bpf support for branch records
Date:   Mon,  6 Dec 2021 13:03:15 +0530
Message-Id: <20211206073315.77432-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ddqZnyNPzA3d_H6YK0T9qAXKQhnrCgL5
X-Proofpoint-ORIG-GUID: 5VHbnfruROeutJ8Bs9NzMU1-zunweXEV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_02,2021-12-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060045
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Branch data available to bpf programs can be very useful to get
stack traces out of userspace application.

Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
added bpf support to capture branch records in x86. Enable this feature
for other architectures as well by removing check specific to x86.

Incase any architecture doesn't support branch records,
bpf_read_branch_records still have appropriate checks and it
will return error number -EINVAL in that scenario. But based on
documentation there in include/uapi/linux/bpf.h file, incase of
unsupported archs, this function should return -ENOENT. Hence update
the appropriate checks to return -ENOENT instead.

Selftest 'perf_branches' result on power9 machine which has branch stacks
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
have branch stack report.

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
v3 -> v4
- Make return type again as -EINVAL for invalid/unsupported
  flags case as suggested by Daniel Borkmann.

- Link to the v3 patch: https://lkml.org/lkml/2021/11/23/248

v2 -> v3
- Change the return error number for bpf_read_branch_records
  function from -EINVAL to -ENOENT for appropriate checks
  as suggested by Daniel Borkmann.

- Link to the v2 patch: https://lkml.org/lkml/2021/11/18/510

v1 -> v2
- Inorder to add bpf support to capture branch record in
  powerpc, rather then adding config for powerpc, entirely
  remove config check from bpf_read_branch_records function
  as suggested by Peter Zijlstra

- Link to the v1 patch: https://lkml.org/lkml/2021/11/14/434

 kernel/trace/bpf_trace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ae9755037b7e..e36d184615fb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1400,9 +1400,6 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
 BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
-#ifndef CONFIG_X86
-	return -ENOENT;
-#else
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
 	struct perf_branch_stack *br_stack = ctx->data->br_stack;
 	u32 to_copy;
@@ -1411,7 +1408,7 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 		return -EINVAL;
 
 	if (unlikely(!br_stack))
-		return -EINVAL;
+		return -ENOENT;
 
 	if (flags & BPF_F_GET_BRANCH_RECORDS_SIZE)
 		return br_stack->nr * br_entry_size;
@@ -1423,7 +1420,6 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	memcpy(buf, br_stack->entries, to_copy);
 
 	return to_copy;
-#endif
 }
 
 static const struct bpf_func_proto bpf_read_branch_records_proto = {
-- 
2.27.0

