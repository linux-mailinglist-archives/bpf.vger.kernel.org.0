Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36618680119
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjA2TFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 14:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA2TFd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 14:05:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1576B2
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 11:05:32 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TGKPK3012140;
        Sun, 29 Jan 2023 19:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=7M9aGv/KGf57Mevli43jPbju7c+nd6elG+pVtnvM/ko=;
 b=K0WcIlwCrKVt2bwScwdR8aWscBOjpcJBJRmedSF/InU7N+AE210KEwMtCX8BGzkGRUuk
 +Zesno/RRGMj33cmpvhP+zgDxlzKF8DDIWQ0oy8T1WFutbT1Lu8MCEj8FSSb13JQ6Y6P
 a5duzrZZGYVyA3oqmPVfg4glG4z31YYxjaiXEJFRziUnI5WKnrjMQgFxdYFBOCiOfbsW
 EHZwwbpXWkB1cGSI4UHK9zSRDONEjwH5IrD4QoeDaLMfsQ+RLjOExXhMtG9cJdNoC/jy
 WXDfzFMULig7RG8XyzZ+mj0EIFR+MN6j3z2/n5WPWa6SmN8yHGuI/9noZeTjzRUby9Ly xA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddv1594m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30T5EKLa014953;
        Sun, 29 Jan 2023 19:05:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ncvttsd7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TJ5CuW30605712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 19:05:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D2D120043;
        Sun, 29 Jan 2023 19:05:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 129CE20040;
        Sun, 29 Jan 2023 19:05:12 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 19:05:11 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: Trim DENYLIST.s390x
Date:   Sun, 29 Jan 2023 20:05:01 +0100
Message-Id: <20230129190501.1624747-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129190501.1624747-1-iii@linux.ibm.com>
References: <20230129190501.1624747-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hSJIl8Nf4vpjaEnl5odQLFtemxpvM8Vk
X-Proofpoint-GUID: hSJIl8Nf4vpjaEnl5odQLFtemxpvM8Vk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that trampoline is implemented, enable a number of tests on s390x.
18 of the remaining failures have to do with either lack of rethook
(fixed by [1]) or syscall symbols missing from BTF (fixed by [2]).

Do not re-classify the remaining failures for now; wait until the
s390/for-next fixes are merged and re-classify only the remaining few.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=for-next&id=1a280f48c0e403903cf0b4231c95b948e664f25a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=for-next&id=2213d44e140f979f4b60c3c0f8dd56d151cc8692

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 69 ----------------------
 1 file changed, 69 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 50924611e5bb..b89eb87034e4 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,93 +1,24 @@
 # TEMPORARY
 # Alphabetical order
-atomics                                  # attach(add): actual -524 <= expected 0                                      (trampoline)
 bloom_filter_map                         # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
 bpf_cookie                               # failed to open_and_load program: -524 (trampoline)
-bpf_iter_setsockopt                      # JIT does not support calling kernel function                                (kfunc)
 bpf_loop                                 # attaches to __x64_sys_nanosleep
-bpf_mod_race                             # BPF trampoline
-bpf_nf                                   # JIT does not support calling kernel function
-bpf_tcp_ca                               # JIT does not support calling kernel function                                (kfunc)
-cb_refs                                  # expected error message unexpected error: -524                               (trampoline)
-cgroup_hierarchical_stats                # JIT does not support calling kernel function                                (kfunc)
-cgrp_kfunc                               # JIT does not support calling kernel function
 cgrp_local_storage                       # prog_attach unexpected error: -524                                          (trampoline)
-core_read_macros                         # unknown func bpf_probe_read#4                                               (overlapping)
-cpumask                                  # JIT does not support calling kernel function
-d_path                                   # failed to auto-attach program 'prog_stat': -524                             (trampoline)
-decap_sanity                             # JIT does not support calling kernel function                                (kfunc)
-deny_namespace                           # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
-dummy_st_ops                             # test_run unexpected error: -524 (errno 524)                                 (trampoline)
-fentry_fexit                             # fentry attach failed: -524                                                  (trampoline)
-fentry_test                              # fentry_first_attach unexpected error: -524                                  (trampoline)
-fexit_bpf2bpf                            # freplace_attach_trace unexpected error: -524                                (trampoline)
 fexit_sleep                              # fexit_skel_load fexit skeleton failed                                       (trampoline)
-fexit_stress                             # fexit attach failed prog 0 failed: -524                                     (trampoline)
-fexit_test                               # fexit_first_attach unexpected error: -524                                   (trampoline)
-get_func_args_test	                 # trampoline
-get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
-htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
-jit_probe_mem                            # jit_probe_mem__open_and_load unexpected error: -524                         (kfunc)
-kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
-kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
-kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
 kprobe_multi_bench_attach                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test                        # relies on fentry
 ksyms_module                             # test_ksyms_module__open_and_load unexpected error: -9                       (?)
 ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
 ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
-libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
-linked_list				 # JIT does not support calling kernel function                                (kfunc)
-lookup_key                               # JIT does not support calling kernel function                                (kfunc)
-lru_bug                                  # prog 'printk': failed to auto-attach: -524
-map_kptr                                 # failed to open_and_load program: -524 (trampoline)
-modify_return                            # modify_return attach failed: -524                                           (trampoline)
 module_attach                            # skel_attach skeleton attach failed: -524                                    (trampoline)
-mptcp
-nested_trust                             # JIT does not support calling kernel function
-netcnt                                   # failed to load BPF skeleton 'netcnt_prog': -7                               (?)
-probe_user                               # check_kprobe_res wrong kprobe res from probe read                           (?)
-rcu_read_lock                            # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
-recursion                                # skel_attach unexpected error: -524                                          (trampoline)
 ringbuf                                  # skel_load skeleton load failed                                              (?)
-select_reuseport                         # intermittently fails on new s390x setup
-send_signal                              # intermittently fails to receive signal
-setget_sockopt                           # attach unexpected error: -524                                               (trampoline)
-sk_assign                                # Can't read on server: Invalid argument                                      (?)
-sk_lookup                                # endianness problem
-sk_storage_tracing                       # test_sk_storage_tracing__attach unexpected error: -524                      (trampoline)
-skc_to_unix_sock                         # could not attach BPF object unexpected error: -524                          (trampoline)
-socket_cookie                            # prog_attach unexpected error: -524                                          (trampoline)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
-tailcalls                                # tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls      (?)
-task_kfunc                               # JIT does not support calling kernel function
-task_local_storage                       # failed to auto-attach program 'trace_exit_creds': -524                      (trampoline)
-test_bpffs                               # bpffs test  failed 255                                                      (iterator)
-test_bprm_opts                           # failed to auto-attach program 'secure_exec': -524                           (trampoline)
-test_ima                                 # failed to auto-attach program 'ima': -524                                   (trampoline)
-test_local_storage                       # failed to auto-attach program 'unlink_hook': -524                           (trampoline)
 test_lsm                                 # attach unexpected error: -524                                               (trampoline)
-test_overhead                            # attach_fentry unexpected error: -524                                        (trampoline)
-test_profiler                            # unknown func bpf_probe_read_str#45                                          (overlapping)
-timer                                    # failed to auto-attach program 'test1': -524                                 (trampoline)
-timer_crash                              # trampoline
-timer_mim                                # failed to auto-attach program 'test1': -524                                 (trampoline)
-trace_ext                                # failed to auto-attach program 'test_pkt_md_access_new': -524                (trampoline)
 trace_printk                             # trace_printk__load unexpected error: -2 (errno 2)                           (?)
 trace_vprintk                            # trace_vprintk__open_and_load unexpected error: -9                           (?)
-tracing_struct                           # failed to auto-attach: -524                                                 (trampoline)
-trampoline_count                         # prog 'prog1': failed to attach: ERROR: strerror_r(-524)=22                  (trampoline)
-type_cast                                # JIT does not support calling kernel function
 unpriv_bpf_disabled                      # fentry
 user_ringbuf                             # failed to find kernel BTF type ID of '__s390x_sys_prctl': -3                (?)
 verif_stats                              # trace_vprintk__open_and_load unexpected error: -9                           (?)
-verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
-vmlinux                                  # failed to auto-attach program 'handle__fentry': -524                        (trampoline)
-xdp_adjust_tail                          # case-128 err 0 errno 28 retval 1 size 128 expect-size 3520                  (?)
 xdp_bonding                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
-xdp_bpf2bpf                              # failed to auto-attach program 'trace_on_entry': -524                        (trampoline)
-xdp_do_redirect                          # prog_run_max_size unexpected error: -22 (errno 22)
 xdp_metadata                             # JIT does not support calling kernel function                                (kfunc)
-xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
-xfrm_info                                # JIT does not support calling kernel function                                (kfunc)
-- 
2.39.1

