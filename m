Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41AF459F8A
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhKWJy4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 04:54:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234440AbhKWJyz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 04:54:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN8pTRQ023413;
        Tue, 23 Nov 2021 09:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Xg4AVH2UW1BhTWspMv/0MMeHkAwUuTXypcJilsaUPzo=;
 b=KUNQzYASiXbc/xLCDOkXcyA9+114ecXx7Ran/C05m+tE65/3LcmkP/xxYFSCDtvhAYK6
 OZFAaTH83iQqkAX7xwhCQKtP9vYOd171dsyWnS5FVAbY/e8iR8jbLlubtZTdZpiEVVET
 LH1s9W/SpZfrE8uoYgtqODT/Yfn65jreAqkGukrPzbH0PioUNyH7vZkXn3mWjQD0eF9q
 +Wi9JynOk6AndzCBtqEVUG1HrZ9xfjNWRS061KrrfNKctEhtGgM1gauy+R+kZZbPabIJ
 GXechztyqs3LOpZ+mD1WZeHGUct+H1oFfOZQ13EJUddqkCrwF4i3dhjRodcP35vgEogE NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cgw5kh35y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 09:51:27 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AN8vYjH011970;
        Tue, 23 Nov 2021 09:51:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cgw5kh35m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 09:51:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AN9h6aI020799;
        Tue, 23 Nov 2021 09:51:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3cernap3t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 09:51:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AN9pKkr20513236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 09:51:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6F0052051;
        Tue, 23 Nov 2021 09:51:20 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.21.81])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0840F52052;
        Tue, 23 Nov 2021 09:51:14 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, songliubraving@fb.com,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        andrii.nakryiko@gmail.com
Subject: [PATCH v3] bpf: Remove config check to enable bpf support for branch records
Date:   Tue, 23 Nov 2021 15:21:04 +0530
Message-Id: <20211123095104.54330-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oubcxEqwLcubm9Bc2-X3RwkoSmgBCRpz
X-Proofpoint-GUID: FRP_h4nXKfQnosPGhGuCWEKz9ru_DNMY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_03,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230051
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

 kernel/trace/bpf_trace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7396488793ff..b94a00f92759 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1402,18 +1402,15 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
 BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
-#ifndef CONFIG_X86
-	return -ENOENT;
-#else
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
 	struct perf_branch_stack *br_stack = ctx->data->br_stack;
 	u32 to_copy;
 
 	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
-		return -EINVAL;
+		return -ENOENT;
 
 	if (unlikely(!br_stack))
-		return -EINVAL;
+		return -ENOENT;
 
 	if (flags & BPF_F_GET_BRANCH_RECORDS_SIZE)
 		return br_stack->nr * br_entry_size;
@@ -1425,7 +1422,6 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	memcpy(buf, br_stack->entries, to_copy);
 
 	return to_copy;
-#endif
 }
 
 static const struct bpf_func_proto bpf_read_branch_records_proto = {
-- 
2.27.0

