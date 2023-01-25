Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C243A67BEB4
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjAYVjQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjAYVjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4892FCC6
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:11 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLpa5027269;
        Wed, 25 Jan 2023 21:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Iv9uNCR+VH/L8q9QpN4Tc/bQVBdQl81aSph/m+pbw9M=;
 b=Vz8rhDssieE70EpiI5rfz2rcwv0IEXQ4IQxD9pxDk7m8gnpedqFIKj6l6YjUn3WR3Axv
 iXLzvLeWzoxbR00kkPJYP0yCYTdqJXGd16YC2d/10E2BRoLg3kFs2bY6raiKIlSBEz+P
 E4og1Loa5xyp5i9s091EyGh5kHaiO67QcZIGWIIegZIyjcOHd5VJ+v49KwasAYPzR0fs
 HNSJswN1wDUhUgv+YvzBCJ72VqsBbnhSW0GrqFhPk/30vkopRlkJHq7TSylAOIK8IIu1
 QcogfWzrGcdxBe6Cgy7y8XvhbaXfbY6lR35m48omInWhde3V2ozH6kYPr3Mek7KED7si BA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb6na2v5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:38:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PGU8ZW010790;
        Wed, 25 Jan 2023 21:38:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6nm05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:38:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLcpmB50463172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:38:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0455320043;
        Wed, 25 Jan 2023 21:38:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C357520040;
        Wed, 25 Jan 2023 21:38:50 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:38:50 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 00/24] Support bpf trampoline for s390x
Date:   Wed, 25 Jan 2023 22:37:53 +0100
Message-Id: <20230125213817.1424447-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tkbATgyj1Xg1UFtgg1YwmGbHMrV1jbok
X-Proofpoint-ORIG-GUID: tkbATgyj1Xg1UFtgg1YwmGbHMrV1jbok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This series implements poke, trampoline, kfunc, mixing subprogs and
tailcalls, and fixes a number of tests on s390x.

The following failures still remain:

#52      core_read_macros:FAIL
Uses BPF_PROBE_READ(), shouldn't there be BPF_PROBE_READ_KERNEL()?

#82      get_stack_raw_tp:FAIL
get_stack_print_output:FAIL:user_stack corrupted user stack
Known issue:
We cannot reliably unwind userspace on s390x without DWARF.

#101     ksyms_module:FAIL
address of kernel function bpf_testmod_test_mod_kfunc is out of range
Known issue:
Kernel and modules are too far away from each other on s390x.

#167     sk_assign:FAIL
Uses legacy map definitions in 'maps' section.

#190     stacktrace_build_id:FAIL
Known issue:
We cannot reliably unwind userspace on s390x without DWARF.

#211     test_bpffs:FAIL
iterators.bpf.c is broken on s390x, it uses BPF_CORE_READ(), shouldn't
there be BPF_CORE_READ_KERNEL()?

#218     test_profiler:FAIL
A lot of BPF_PROBE_READ() usages.

#281     xdp_metadata:FAIL
See patch 24.

#284     xdp_synproxy:FAIL
Verifier error:
; value = bpf_tcp_raw_gen_syncookie_ipv4(hdr->ipv4, hdr->tcp,
281: (79) r1 = *(u64 *)(r10 -80)      ; R1_w=pkt(off=14,r=74,imm=0) R10=fp0
282: (bf) r2 = r8                     ; R2_w=pkt(id=5,off=14,r=74,umax=60,var_off=(0x0; 0x3c)) R8=pkt(id=5,off=14,r=74,umax=60,var_off=(0x0; 0x3c))
283: (79) r3 = *(u64 *)(r10 -104)     ; R3_w=scalar(umax=60,var_off=(0x0; 0x3c)) R10=fp0
284: (85) call bpf_tcp_raw_gen_syncookie_ipv4#204
invalid access to packet, off=14 size=0, R2(id=5,off=14,r=74)
R2 offset is outside of the packet

None of these seem to be due to the new changes.

Best regards,
Ilya

Ilya Leoshkevich (24):
  selftests/bpf: Fix liburandom_read.so linker error
  selftests/bpf: Fix symlink creation error
  selftests/bpf: Fix fexit_stress on s390x
  selftests/bpf: Fix trampoline_count on s390x
  selftests/bpf: Fix kfree_skb on s390x
  selftests/bpf: Set errno when urand_spawn() fails
  selftests/bpf: Fix decap_sanity_ns cleanup
  selftests/bpf: Fix verify_pkcs7_sig on s390x
  selftests/bpf: Fix xdp_do_redirect on s390x
  selftests/bpf: Fix cgrp_local_storage on s390x
  selftests/bpf: Check stack_mprotect() return value
  selftests/bpf: Increase SIZEOF_BPF_LOCAL_STORAGE_ELEM on s390x
  selftests/bpf: Add a sign-extension test for kfuncs
  selftests/bpf: Fix test_lsm on s390x
  selftests/bpf: Fix test_xdp_adjust_tail_grow2 on s390x
  selftests/bpf: Fix vmlinux test on s390x
  libbpf: Read usdt arg spec with bpf_probe_read_kernel()
  s390/bpf: Fix a typo in a comment
  s390/bpf: Add expoline to tail calls
  s390/bpf: Implement bpf_arch_text_poke()
  bpf: btf: Add BTF_FMODEL_SIGNED_ARG flag
  s390/bpf: Implement arch_prepare_bpf_trampoline()
  s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
  s390/bpf: Implement bpf_jit_supports_kfunc_call()

 arch/s390/net/bpf_jit_comp.c                  | 708 +++++++++++++++++-
 include/linux/bpf.h                           |   8 +
 include/linux/btf.h                           |  15 +-
 kernel/bpf/btf.c                              |  16 +-
 net/bpf/test_run.c                            |   9 +
 tools/lib/bpf/usdt.bpf.h                      |  33 +-
 tools/testing/selftests/bpf/Makefile          |   7 +-
 tools/testing/selftests/bpf/netcnt_common.h   |   6 +-
 .../selftests/bpf/prog_tests/bpf_cookie.c     |   6 +-
 .../bpf/prog_tests/cgrp_local_storage.c       |   2 +-
 .../selftests/bpf/prog_tests/decap_sanity.c   |   2 +-
 .../selftests/bpf/prog_tests/fexit_stress.c   |   6 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |   2 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |   1 +
 .../selftests/bpf/prog_tests/test_lsm.c       |   3 +-
 .../bpf/prog_tests/trampoline_count.c         |   4 +
 tools/testing/selftests/bpf/prog_tests/usdt.c |   1 +
 .../bpf/prog_tests/verify_pkcs7_sig.c         |   9 +
 .../bpf/prog_tests/xdp_adjust_tail.c          |   7 +-
 .../bpf/prog_tests/xdp_do_redirect.c          |   4 +
 .../selftests/bpf/progs/kfunc_call_test.c     |  18 +
 tools/testing/selftests/bpf/progs/lsm.c       |   7 +-
 .../bpf/progs/test_verify_pkcs7_sig.c         |  12 +-
 .../selftests/bpf/progs/test_vmlinux.c        |   4 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |   8 +-
 25 files changed, 816 insertions(+), 82 deletions(-)

-- 
2.39.1

