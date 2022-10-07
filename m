Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B570F5F7519
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJGIOP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 04:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGIOO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 04:14:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92832F1935;
        Fri,  7 Oct 2022 01:14:13 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2977fmnQ031215;
        Fri, 7 Oct 2022 08:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dtd3CMHEDsC9DUqgNxiqohaQ+nZUyjGQZk5G1Ce326w=;
 b=JXOduRrtTDhRMlsIbXdiuTMCL104/cDeoEP+o0Bj78qJvtHGsK4KA0Q87vA3jLGTAzXH
 7p7b+ZMboaTi8Bt3bj87RheQhJVWSGMrr9CR2xIOsOqHgooP4r4EVft6faxo5xsJWIjh
 6fjN41Gvhcl5rq96GFfflKxCAKC9RTCABTB7L2z+CbCXeIqizm0tpUw10+MjAQc04ZM6
 nKVhDjuAwT1DGakl45BptIuoTaLW40HhMRHeoNnu4HCYjIro9IWskvXX23we9g0YSu08
 eA6cy3YlsGsHQlaD27p4cmuADH53yzEJ0YOoMG8AtvOpgRTCj9WVXcooQRr4/nFNgrFp yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2fxr106k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 08:13:58 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2977fmEv031218;
        Fri, 7 Oct 2022 08:13:57 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k2fxr1060-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 08:13:57 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29787HwC017647;
        Fri, 7 Oct 2022 08:13:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3jxd68x3nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 08:13:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2978DpNC62456234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Oct 2022 08:13:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCF6AA4054;
        Fri,  7 Oct 2022 08:13:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45ACFA405B;
        Fri,  7 Oct 2022 08:13:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Oct 2022 08:13:51 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     olsajiri@gmail.com
Cc:     bpf@vger.kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        iii@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, namhyung@kernel.org,
        peterz@infradead.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        tip-bot2@linutronix.de, tmricht@linux.ibm.com, x86@kernel.org
Subject: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
Date:   Fri,  7 Oct 2022 10:13:27 +0200
Message-Id: <20221007081327.1047552-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Yz8lbkx3HYQpnvIB@krava>
References: <Yz8lbkx3HYQpnvIB@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vy7-shgvwI2HEsF_dLzPypgUPE8Ao3EA
X-Proofpoint-ORIG-GUID: 3yeAUfUDBSAgaV1q30dqMv7CtkEjuzEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Raw data is also filled by bpf_perf_event_output.
* Add sample_flags to indicate raw data.
* This eliminates the segfaults as shown below:
  Run ./samples/bpf/trace_output
  BUG pid 9 cookie 1001000000004 sized 4
  BUG pid 9 cookie 1001000000004 sized 4
  BUG pid 9 cookie 1001000000004 sized 4
  Segmentation fault (core dumped)

Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 kernel/trace/bpf_trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 49fb9ec8366d..1ed08967fb97 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -687,6 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 
 	perf_sample_data_init(sd, 0, 0);
 	sd->raw = &raw;
+	sd->sample_flags |= PERF_SAMPLE_RAW;
 
 	err = __bpf_perf_event_output(regs, map, flags, sd);
 
@@ -745,6 +746,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
 	sd->raw = &raw;
+	sd->sample_flags |= PERF_SAMPLE_RAW;
 
 	ret = __bpf_perf_event_output(regs, map, flags, sd);
 out:
-- 
2.36.1

