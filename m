Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2938F69FF56
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjBVXSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBVXR7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:17:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27232129
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:17:58 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MMX4i4032192;
        Wed, 22 Feb 2023 22:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=6QK0mIS0Iei/OHgZOee/1DHvJY2Bw+K/SpYRDuZ+kaw=;
 b=COxyVVDNKYlDuA0tQon3N8SV6wGgC2ASQ4I/Ye7MDh1l/Po3yBpj+C+D1cZGw9rzn7//
 LJuM6gXSDOcDDRtQ9xWkCxAjlbWo2aumNPR0H4h21SG2QkqH7HDphg3Mv8GLkciFjDm6
 B8atwoOKMS7jNv61jy5T+xQGohl9NAHtugBSs0iw+tGdvLnXeKJWAo9uuR+C3qPg3Li/
 u8bthif8o6st/G4ZHBB5UIQkh72BJLh3WYlC92z/EINyALofQ+a+tv4IdZg9JP0Cwhm6
 AkhJKqI/J0Bf8OFDauKsRUORZ4G2UfmmdfjdKWGfy0YIbRdyp9Qp32h2t4BCZJq6wjuB Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuxpg2uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:23 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMXBml032358;
        Wed, 22 Feb 2023 22:37:23 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwuxpg2uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MF7ZER019881;
        Wed, 22 Feb 2023 22:37:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ntnxf5wfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbHWF47579642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6EDB20040;
        Wed, 22 Feb 2023 22:37:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2267E2004B;
        Wed, 22 Feb 2023 22:37:17 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:17 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 00/12] bpf: Support 64-bit pointers to kfuncs
Date:   Wed, 22 Feb 2023 23:37:02 +0100
Message-Id: <20230222223714.80671-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V9twMz46tlOWN0TQaiVxYdmoaptJAxUJ
X-Proofpoint-GUID: 7Hhy7xM7yNeoCpKBCOKV7lcGJmQpZJmb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2: https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/
v2 -> v3: Drop BPF_HELPER_CALL (Alexei).
          Drop the merged check_subprogs() cleanup.
          Adjust arm, sparc and i386 JITs.
          Fix a few portability issues in test_verifier.
          Fix a few sparc64 issues.
          Trim s390x denylist.

v1: https://lore.kernel.org/bpf/20230214212809.242632-1-iii@linux.ibm.com/T/#t
v1 -> v2: Add BPF_HELPER_CALL (Stanislav).
          Add check_subprogs() cleanup - noticed while reviewing the
          code for BPF_HELPER_CALL.
          Drop WARN_ON_ONCE (Stanislav, Alexei).
          Add bpf_jit_get_func_addr() to x86_64 JIT.

Hi,

This series solves the problems outlined in [1, 2, 3]. The main problem
is that kfuncs in modules do not fit into bpf_insn.imm on s390x; the
secondary problem is that there is a conflict between "abstract" XDP
metadata function BTF ids and their "concrete" addresses.

The solution is to keep fkunc BTF ids in bpf_insn.imm, and put the
addresses into bpf_kfunc_desc, which does not have size restrictions.

Regtested with test_verifier and test_progs on x86_64 and s390x.
Regtested with test_verifier only on arm, sparc64 and i386.

[1] https://lore.kernel.org/bpf/Y9%2FyrKZkBK6yzXp+@krava/
[2] https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/
[3] https://lore.kernel.org/bpf/20230128000650.1516334-32-iii@linux.ibm.com/

Best regards,
Ilya

Ilya Leoshkevich (12):
  selftests/bpf: Finish folding after BPF_FUNC_csum_diff
  selftests/bpf: Fix test_verifier on 32-bit systems
  sparc: Update maximum errno
  bpf: sparc64: Emit fixed-length instructions for BPF_PSEUDO_FUNC
  bpf: sparc64: Fix jumping to the first insn
  bpf: sparc64: Use 32-bit tail call index
  bpf, arm: Use bpf_jit_get_func_addr()
  bpf: sparc64: Use bpf_jit_get_func_addr()
  bpf: x86: Use bpf_jit_get_func_addr()
  bpf, x86_32: Use bpf_jit_get_func_addr()
  bpf: Support 64-bit pointers to kfuncs
  selftests/bpf: Trim DENYLIST.s390x

 arch/arm/net/bpf_jit_32.c                     | 27 +++++--
 arch/sparc/include/asm/errno.h                | 10 +++
 arch/sparc/kernel/entry.S                     |  2 +-
 arch/sparc/kernel/process.c                   |  6 +-
 arch/sparc/kernel/syscalls.S                  |  2 +-
 arch/sparc/net/bpf_jit_comp_64.c              | 50 +++++++-----
 arch/x86/net/bpf_jit_comp.c                   | 15 +++-
 arch/x86/net/bpf_jit_comp32.c                 | 27 +++++--
 include/linux/bpf.h                           |  2 +
 kernel/bpf/core.c                             | 21 ++++-
 kernel/bpf/verifier.c                         | 79 ++++++-------------
 tools/testing/selftests/bpf/DENYLIST.s390x    | 20 -----
 tools/testing/selftests/bpf/test_verifier.c   |  5 ++
 .../selftests/bpf/verifier/array_access.c     | 10 ++-
 .../selftests/bpf/verifier/atomic_fetch_add.c |  2 +-
 .../selftests/bpf/verifier/bpf_get_stack.c    |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  4 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
 .../testing/selftests/bpf/verifier/map_ptr.c  |  2 +-
 19 files changed, 164 insertions(+), 124 deletions(-)
 create mode 100644 arch/sparc/include/asm/errno.h

-- 
2.39.1

