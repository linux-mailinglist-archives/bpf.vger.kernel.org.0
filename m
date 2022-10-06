Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73E25F6B20
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiJFQCH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJFQCF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 12:02:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44508ABD47;
        Thu,  6 Oct 2022 09:02:04 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296G0DRS004008;
        Thu, 6 Oct 2022 16:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oUnouGWBn3JOewD2KRTkQww+SMzrfrB6EUcHGJQ5qAg=;
 b=U5Gf86NxB5g8IAmIU0QhotvWajTy8+loIeWVLR9giRrZRCOHOdYBsOQWRH+EWJpU+O4t
 GzAnp/0oh3tRxyv6zA1CLHiSaoH+Af3CbFgrMzlfp5lBYiU6I3VoCNg9v7sZ8emYKYC8
 pQREm6SbqIISLMqWE3Z+nzquS4yPlYFT0KyHpaafvStUCWyVnrzqLGtqcw8AAQwoG+bn
 V2qI3WXu+ePejxtgEL7PpjldvKWgJ5TXqveYQZab9fME9WnbnBzdxaWaFhJVOg9n3e39
 7L2ITYfRbZ6rOogThxOdRVv+tznWxH0KhY7T6QPY98JlEX3Db1DaUMi7l9+xR5zoy10J Ww== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2258r1k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 16:01:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296FoHOM005492;
        Thu, 6 Oct 2022 16:01:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3jxd697bs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 16:01:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296G22PW38535534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 16:02:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5897D4C046;
        Thu,  6 Oct 2022 16:01:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F28ED4C052;
        Thu,  6 Oct 2022 16:01:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 16:01:31 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     tip-bot2@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        namhyung@kernel.org, peterz@infradead.org, x86@kernel.org,
        iii@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        svens@linux.ibm.com, tmricht@linux.ibm.com, bpf@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH] Re: [tip: perf/core] perf: Use sample_flags for raw_data
Date:   Thu,  6 Oct 2022 18:00:44 +0200
Message-Id: <20221006160044.3397237-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <166434824149.401.4361243714612738808.tip-bot2@tip-bot2>
References: <166434824149.401.4361243714612738808.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JPAiRTJnkur7214gTcyrKJOdqGqoRSVy
X-Proofpoint-ORIG-GUID: JPAiRTJnkur7214gTcyrKJOdqGqoRSVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This causes segfaults.

Steps to recreate:
*  Run ./samples/bpf/trace_output
BUG pid 9 cookie 1001000000004 sized 4
BUG pid 9 cookie 1001000000004 sized 4
BUG pid 9 cookie 1001000000004 sized 4
Segmentation fault (core dumped)

Problem:
* The following commit sets data->raw to NULL, when the raw data is not filled
by PMU driver. This leads to stale data.
   
* raw data could also be filled by bpf_perf_event_output(), bpf_event_output()
...
 686         perf_sample_data_init(sd, 0, 0);
 687         sd->raw = &raw;
 688
 689         err = __bpf_perf_event_output(regs, map, flags, sd);
...

* The below patch eliminates segfaults. However, contradicts with
the description mentioned in this commit (Filled by only PMU driver).
  
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 49fb9ec8366d..1ed08967fb97 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -687,6 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 
        perf_sample_data_init(sd, 0, 0);
        sd->raw = &raw;
+       sd->sample_flags |= PERF_SAMPLE_RAW;
 
        err = __bpf_perf_event_output(regs, map, flags, sd);
 
@@ -745,6 +746,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
        perf_fetch_caller_regs(regs);
        perf_sample_data_init(sd, 0, 0);
        sd->raw = &raw;
+       sd->sample_flags |= PERF_SAMPLE_RAW;
 
        ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
  
--
Thanks,
Sumanth
