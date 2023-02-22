Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3569FF41
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBVXLJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBVXLH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:11:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76A433441
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:11:04 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMGiYI029485;
        Wed, 22 Feb 2023 22:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PId1MBFavWzoTRttZTIpImTRa/Hpqhm+EJ23QnCjzfo=;
 b=WswPwmhyYSNsLUcneFK8qxUJX0RBkvi0rBSIKqMcUqXuuEO/pt9J6x1h5m6Koc3vec8o
 wuK/Ak6w8MNwemerQ4ID6sDhlrz/D1ycTV3gp5W56JNnD442tzXsxyiV6LsC555779Of
 a/8knnlNMgEi2yJJkXOwx1SIcS2yT9sz7/utCdi8f1x8c4LEEk23p4vxZpgGNZNCdEC5
 y13/MuKy9ftDJDZGs95RrZjzjodpTC//oCLwxtFBNgEBtG6Ss/7Zk59fsCAnqSxhgwF/
 Qyr062Yl1K7qnVE6Iraw6mKiKT9oemWHFOzctK81o7d38SY0hY9p6oFEfgMD3JW0cfFM Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuq2gf1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:40 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMbaM3005171;
        Wed, 22 Feb 2023 22:37:40 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuq2gf17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MEpVZF016606;
        Wed, 22 Feb 2023 22:37:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6dwrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbXvu34013604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8C502004E;
        Wed, 22 Feb 2023 22:37:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DF8220040;
        Wed, 22 Feb 2023 22:37:33 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:32 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 12/12] selftests/bpf: Trim DENYLIST.s390x
Date:   Wed, 22 Feb 2023 23:37:14 +0100
Message-Id: <20230222223714.80671-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5WgN1_tLrwbK840FbopR9fIBET9_pS3d
X-Proofpoint-ORIG-GUID: RjGJ_2tm9SyXcmybhj9H0stPQi-sK5mP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With commit 1a280f48c0e4 ("s390/kprobes: replace kretprobe with
rethook") and commit 2213d44e140f ("s390/syscalls: get rid of system
call alias functions") merged, and kfunc range issues fixed, only two
known test_progs failures remain on s390x.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index b89eb87034e4..a17baf8c6fd7 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,24 +1,4 @@
 # TEMPORARY
 # Alphabetical order
-bloom_filter_map                         # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
-bpf_cookie                               # failed to open_and_load program: -524 (trampoline)
-bpf_loop                                 # attaches to __x64_sys_nanosleep
-cgrp_local_storage                       # prog_attach unexpected error: -524                                          (trampoline)
-fexit_sleep                              # fexit_skel_load fexit skeleton failed                                       (trampoline)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
-kprobe_multi_bench_attach                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-kprobe_multi_test                        # relies on fentry
-ksyms_module                             # test_ksyms_module__open_and_load unexpected error: -9                       (?)
-ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
-ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
-module_attach                            # skel_attach skeleton attach failed: -524                                    (trampoline)
-ringbuf                                  # skel_load skeleton load failed                                              (?)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
-test_lsm                                 # attach unexpected error: -524                                               (trampoline)
-trace_printk                             # trace_printk__load unexpected error: -2 (errno 2)                           (?)
-trace_vprintk                            # trace_vprintk__open_and_load unexpected error: -9                           (?)
-unpriv_bpf_disabled                      # fentry
-user_ringbuf                             # failed to find kernel BTF type ID of '__s390x_sys_prctl': -3                (?)
-verif_stats                              # trace_vprintk__open_and_load unexpected error: -9                           (?)
-xdp_bonding                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
-xdp_metadata                             # JIT does not support calling kernel function                                (kfunc)
-- 
2.39.1

