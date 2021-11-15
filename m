Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D616444FDF9
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 05:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhKOEsk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Nov 2021 23:48:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229790AbhKOEsi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 14 Nov 2021 23:48:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AF2i8eG018734;
        Mon, 15 Nov 2021 04:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=lpvOwaRxKrxUcq3pF62L2S7luuODp2ko37HAwXLJdcA=;
 b=MA6xiBdpy3WgszOBuZAdAQDIPoMyVK9KeO4KNfju4GSMgUahD+DHOAvbHNlCwDwxb215
 iwZ7uRKZLzGCqKMHK+PBnFcdy1T7DBS27uoB0rhSccRAPhCuwU0FcoSPDjWiVD0xmHsO
 L6D6Tzy0YxBcYSTtpVg1LiEXkcwVCBIaN+W8jTYR3beAezKZjwBJsNmftsHW5L0vamDl
 WDMZ4hDtLfOQBt6E1N/yI3wmNth49rFWNd4c1xd8M6g7TEMm4KpYX0twUZM6o/mlQ5El
 YAR6hnsZjm03UbSbEXjhokpRyq2IU3UgDwpNtd0BCXyFvFvKakz5w98v+7M8U8OzO3Lh 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cbf181yrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 04:45:13 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AF4TMGa001735;
        Mon, 15 Nov 2021 04:45:12 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cbf181ypx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 04:45:12 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AF4ggIf025481;
        Mon, 15 Nov 2021 04:45:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3ca4mjgs7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 04:45:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AF4j6V146530866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 04:45:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B93F8AE05F;
        Mon, 15 Nov 2021 04:45:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BF7DAE045;
        Mon, 15 Nov 2021 04:45:01 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.4.103])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Nov 2021 04:45:00 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, peterz@infradead.org, songliubraving@fb.com,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com
Subject: [PATCH] bpf: Enable bpf support for reading branch records in powerpc
Date:   Mon, 15 Nov 2021 10:14:37 +0530
Message-Id: <20211115044437.12047-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c0-yq0-S8LeDucJ7wZuPPcwKlv6r9XGm
X-Proofpoint-ORIG-GUID: l-8JHcdGQCpR-O5pBRSI67xYxRjnUNaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_03,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150025
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Branch data available to bpf programs can be very useful to get
stack traces out of userspace applications.

Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
added bpf support to capture branch records in x86. Enable this feature
for powerpc as well.

Commit 67306f84ca78 ("selftests/bpf: Add bpf_read_branch_records()
selftest") adds selftest corresponding to bpf branch read
function bpf_read_branch_records(). Used this selftest to
test bpf support, for reading branch records in powerpc.

Selftest result in power9 box before this patch changes:

[command]# ./test_progs -t perf_branches
Failed to load bpf_testmod.ko into the kernel: -8
WARNING! Selftests relying on bpf_testmod.ko will be skipped.
test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
test_perf_branches_common:PASS:attach_perf_event 0 nsec
test_perf_branches_common:PASS:set_affinity 0 nsec
check_good_sample:PASS:output not valid 0 nsec
check_good_sample:FAIL:read_branches_size err -2
check_good_sample:FAIL:read_branches_stack err -2
check_good_sample:FAIL:read_branches_stack stack bytes written=-2
not multiple of struct size=24
check_good_sample:FAIL:read_branches_global err -2
check_good_sample:FAIL:read_branches_global global bytes written=-2
not multiple of struct size=24
check_good_sample:PASS:read_branches_size 0 nsec
 #75/1 perf_branches_hw:FAIL
 #75/2 perf_branches_no_hw:OK
 #75 perf_branches:FAIL
Summary: 0/1 PASSED, 0 SKIPPED, 2 FAILED

Selftest result in power9 box after this patch changes:

[command]#: ./test_progs -t perf_branches
 #75/1 perf_branches_hw:OK
 #75/2 perf_branches_no_hw:OK
 #75 perf_branches:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Kajol Jain<kjain@linux.ibm.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fdd14072fc3b..2b7343b64bb7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1245,7 +1245,7 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
 BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
 	   void *, buf, u32, size, u64, flags)
 {
-#ifndef CONFIG_X86
+#if !(defined(CONFIG_X86) || defined(CONFIG_PPC64))
 	return -ENOENT;
 #else
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
-- 
2.27.0

