Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806F568011A
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjA2TFe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 14:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjA2TFb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 14:05:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9055EFF32
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 11:05:30 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TDckol015323;
        Sun, 29 Jan 2023 19:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=LJM0364MlxZYtQVeh+Rddv/vSRJemfnnBpVgNX6QeZU=;
 b=CdGc2LJXZzH0055A+CRNUn8/Db/CK/v7SBedpg3HltTbfYTJHg6CR07qFHr9twedQSgN
 pllr0mrg4Q80XlV6x02fo2CDqk6E+M5oquoTZslkcpnxbWyZAnQ2VzhorsyL5DLZhvTV
 3VVM531YJBwxP0/sPjBAttLL8/VhsIXW2dUHo4lvcD/zDx/C5qePk2to5e0vnYeT7kTS
 y8Z7LdVbT2cYbz+L67NiwGd3tRSqubPvSthudBgoBHvvtzIIjsTN6lOPvhiS9psjfU/c
 9nliAjZXNolEffhekMoOCb0q+BaHosyQopCaj4GrYpLl7uGwAb7ebLSL82xkftXs9Umq VA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddhpdfm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30T5EKLY014953;
        Sun, 29 Jan 2023 19:05:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ncvttsd7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TJ546m21758554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 19:05:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C0102004B;
        Sun, 29 Jan 2023 19:05:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F1D820040;
        Sun, 29 Jan 2023 19:05:03 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 19:05:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 0/8] Support bpf trampoline for s390x
Date:   Sun, 29 Jan 2023 20:04:53 +0100
Message-Id: <20230129190501.1624747-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OLSl801ZkUq5jcmc8MTmmrPdH6ZlkIL1
X-Proofpoint-GUID: OLSl801ZkUq5jcmc8MTmmrPdH6ZlkIL1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=946 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2: https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/#t
v2 -> v3:
- Make __arch_prepare_bpf_trampoline static.
  (Reported-by: kernel test robot <lkp@intel.com>)
- Support both old- and new- style map definitions in sk_assign. (Alexei)
- Trim DENYLIST.s390x. (Alexei)
- Adjust s390x vmlinux path in vmtest.sh.
- Drop merged fixes.

v1: https://lore.kernel.org/bpf/20230125213817.1424447-1-iii@linux.ibm.com/#t
v1 -> v2:
- Fix core_read_macros, sk_assign, test_profiler, test_bpffs (24/31;
  I'm not quite happy with the fix, but don't have better ideas),
  and xdp_synproxy. (Andrii)
- Prettify liburandom_read and verify_pkcs7_sig fixes. (Andrii)
- Fix bpf_usdt_arg using barrier_var(); prettify barrier_var(). (Andrii)
- Change BPF_MAX_TRAMP_LINKS to enum and query it using BTF. (Andrii)
- Improve bpf_jit_supports_kfunc_call() description. (Alexei)
- Always check sign_extend() return value.
- Cc: Alexander Gordeev.

Hi,

This series implements poke, trampoline, kfunc, and mixing subprogs
and tailcalls on s390x.

The following failures still remain:

#82      get_stack_raw_tp:FAIL
get_stack_print_output:FAIL:user_stack corrupted user stack
Known issue:
We cannot reliably unwind userspace on s390x without DWARF.

#101     ksyms_module:FAIL
address of kernel function bpf_testmod_test_mod_kfunc is out of range
Known issue:
Kernel and modules are too far away from each other on s390x.

#190     stacktrace_build_id:FAIL
Known issue:
We cannot reliably unwind userspace on s390x without DWARF.

#281     xdp_metadata:FAIL
See patch 6.

None of these seem to be due to the new changes.

Best regards,
Ilya

Ilya Leoshkevich (8):
  selftests/bpf: Fix sk_assign on s390x
  s390/bpf: Add expoline to tail calls
  s390/bpf: Implement bpf_arch_text_poke()
  s390/bpf: Implement arch_prepare_bpf_trampoline()
  s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
  s390/bpf: Implement bpf_jit_supports_kfunc_call()
  selftests/bpf: Fix s390x vmlinux path
  selftests/bpf: Trim DENYLIST.s390x

 arch/s390/net/bpf_jit_comp.c                  | 713 +++++++++++++++++-
 include/linux/bpf.h                           |   4 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |  69 --
 .../selftests/bpf/prog_tests/sk_assign.c      |  25 +-
 .../selftests/bpf/progs/test_sk_assign.c      |  11 +
 .../bpf/progs/test_sk_assign_libbpf.c         |   3 +
 tools/testing/selftests/bpf/vmtest.sh         |   2 +-
 7 files changed, 715 insertions(+), 112 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c

-- 
2.39.1

