Return-Path: <bpf+bounces-10381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFF7A5F4A
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776E7280EF4
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3643399B;
	Tue, 19 Sep 2023 10:14:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22703398D
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:14:34 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD3ECC8
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:14:11 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J9bUA5021492;
	Tue, 19 Sep 2023 10:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9D80heYt+6Hwb2r+ha3iOt4ukZyF84gMHUYt1WHxl1A=;
 b=CLmTM94Js3ezzd+1qkGGnnu0d6iuAmUm2Akq6tdtVBQiJGuAGeT8E2yqXf8Vr/U0f9Cz
 0/d3F5oEfsN8J5Xx1Go1XcpBKS9sceKvms6/1doYi+W4PS+8l+ymWwXThF0S/BKVu7+V
 RU8j2W1vvVSDB+JG3wIhr7GlSz0+xMLPfqO6IzlnI87aMU+4lXhQjIcJHJ8G1XFkgory
 mXyErILdpL5b8MchlMMZc6AUy0hZp/8yZE5hBUX+NX/5cu7LgIcJ5KCn9KQJq/XIjDvL
 z2FlKVfSSYaVftjO5RNUtrR/lFRQFPpuC1+xlLtc8TMbp/BX4AFG+U++lsPPftn2oYZZ SA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6tywtw1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J8PXZ1011671;
	Tue, 19 Sep 2023 10:13:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5qpnb7rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JADtWR20710028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 10:13:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112462006E;
	Tue, 19 Sep 2023 10:13:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DDFD2004F;
	Tue, 19 Sep 2023 10:13:54 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.67.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 10:13:54 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 10/10] selftests/bpf: Trim DENYLIST.s390x
Date: Tue, 19 Sep 2023 12:09:12 +0200
Message-ID: <20230919101336.2223655-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919101336.2223655-1-iii@linux.ibm.com>
References: <20230919101336.2223655-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2bch-_ylHoOdeXeU4ZkM4js1pWTEZsqE
X-Proofpoint-ORIG-GUID: 2bch-_ylHoOdeXeU4ZkM4js1pWTEZsqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable all selftests, except the 2 that have to do with the userspace
unwinding, and the new exceptions test, in the s390x CI.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 25 ----------------------
 1 file changed, 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index ce6f291665cf..1a63996c0304 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,30 +1,5 @@
 # TEMPORARY
 # Alphabetical order
-bloom_filter_map                         # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
-bpf_cookie                               # failed to open_and_load program: -524 (trampoline)
-bpf_loop                                 # attaches to __x64_sys_nanosleep
-cgrp_local_storage                       # prog_attach unexpected error: -524                                          (trampoline)
-dynptr/test_dynptr_skb_data
-dynptr/test_skb_readonly
 exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
-fexit_sleep                              # fexit_skel_load fexit skeleton failed                                       (trampoline)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
-iters/testmod_seq*                       # s390x doesn't support kfuncs in modules yet
-kprobe_multi_bench_attach                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-kprobe_multi_test                        # relies on fentry
-ksyms_btf/weak_ksyms*                    # test_ksyms_weak__open_and_load unexpected error: -22                        (kfunc)
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
-test_task_under_cgroup                   # JIT does not support calling kernel function                                (kfunc)
-- 
2.41.0


