Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816C5245DE0
	for <lists+bpf@lfdr.de>; Mon, 17 Aug 2020 09:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgHQH22 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 03:28:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgHQH21 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Aug 2020 03:28:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07H73WBP179913;
        Mon, 17 Aug 2020 03:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=/IJfE28c6hvV9LgZAD8oKUcRYXw02GBwMWgCfX728lA=;
 b=oAf5f48St07DBqNSUIl7bBjbKNoeZ7/+77I3m4Uy3x0MNZuPovFhRmIH7OOXXqeuIvDd
 psTDogsQnSXmjFMug+huWuUmLrJ2AWUEGwg2M776evQfPqWI6r6aUef3Ciw3FmBkqbI/
 cKVxN1rQ3pG+yrs+WJshtjyl4pAUwl7AJZ7TjTj0DAu3zCKqpq0EyXxVxHTHNZ8Lksnh
 pbrVjyx6/eRLc8IM2QmdmykWgh/XsNfdlPczdhxGTbEB24HwpafxuxNssKhP6gkLq249
 5m0MzQveevhhv7MnElCmefQXeAg+cs5nrNavGvHIlPQYIG3XsW5J8f+n3WdrA2/N486x 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y80h7qyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 03:28:26 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07H73XeC179948;
        Mon, 17 Aug 2020 03:28:25 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y80h7qy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 03:28:25 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07H7KtIt021296;
        Mon, 17 Aug 2020 07:28:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 32x7b816e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 07:28:23 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07H7SKpM21234158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 07:28:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DA02A4051;
        Mon, 17 Aug 2020 07:28:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B0CA404D;
        Mon, 17 Aug 2020 07:28:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 07:28:19 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     acme@kernel.org
Cc:     tmricht@linux.ibm.com, hca@linux.ibm.com, svens@linux.ibm.com,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH] perf test: Fix basic bpf filtering test
Date:   Mon, 17 Aug 2020 09:27:54 +0200
Message-Id: <20200817072754.58344-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_02:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=1 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170055
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF basic filtering test fails on s390x (when vmlinux debuginfo is
utilized instead of /proc/kallsyms)

Info:
- bpf_probe_load installs the bpf code at do_epoll_wait.
- For s390x, do_epoll_wait resolves to 3 functions including inlines.
  found inline addr: 0x43769e
  Probe point found: __s390_sys_epoll_wait+6
  found inline addr: 0x437290
  Probe point found: do_epoll_wait+0
  found inline addr: 0x4375d6
  Probe point found: __se_sys_epoll_wait+6
- add_bpf_event  creates evsel for every probe in a BPF object. This
  results in 3 evsels.

Solution:
- Expected result = 50% of the samples to be collected from epoll_wait *
  number of entries present in the evlist.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 5d20bf8397f0..cd77e334e577 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -197,7 +197,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		perf_mmap__read_done(&md->core);
 	}
 
-	if (count != expect) {
+	if (count != expect * evlist->core.nr_entries) {
 		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect, count);
 		goto out_delete_evlist;
 	}
-- 
2.17.1

