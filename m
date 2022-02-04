Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC574A92FB
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 05:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356931AbiBDEUc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 23:20:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1356924AbiBDEUa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 23:20:30 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2143Gseg011714;
        Fri, 4 Feb 2022 04:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=1iodfSucoet7jLXTPCGZ6I5avhEGEmXNwGia8viSFDg=;
 b=KPSCiui5arNid43yj6sfVxMNuOP1nDd5t83PzepGDgHhpUoLiEgVUvwxy7yxlsB/XkVP
 KLutATgbUIFjlqicG5AUbFfYKSQRmMMRghBgE0402631iT+gHBQ5cIT/9Y224VXU6Bq1
 gqHOZNgPVK48GZ7trvlyGREh1EfOaiGG+Yeq/kauTZEjmny+i2RiXp92FYLi8ZvfBjNV
 iJ3TI5icEsiZGIye62O/UqR+aI/i9iT1zDtNa4jiufATuXYuIBXG34S//MqbTg7lk04V
 ZVjW83jhai2S9qf/ICARqqwwWVfC8kkohQV3aQX19hzkHQQ8RR4PKk9I3D42Z0vJ/T4N jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0qxfmpf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:03 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2143gH3i019372;
        Fri, 4 Feb 2022 04:20:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0qxfmpes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2144BV5Y011746;
        Fri, 4 Feb 2022 04:20:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3e0r1094yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2144JvQF41877778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 04:19:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6DE8A405B;
        Fri,  4 Feb 2022 04:19:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D6A1A4053;
        Fri,  4 Feb 2022 04:19:57 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 04:19:57 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 00/10] libbpf: Fix accessing syscall arguments
Date:   Fri,  4 Feb 2022 05:19:45 +0100
Message-Id: <20220204041955.1958263-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fuLiN-R-ua2C8K5U0cq2uE4Nkq6ZMOba
X-Proofpoint-ORIG-GUID: Fs2-ts75sPp9cY__2ZftKKp00LqoYUc2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_01,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040019
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf now has macros to access syscall arguments in an
architecture-agnostic manner, but unfortunately they have a number of
issues on non-Intel arches, that this series aims to fix.

v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
v1 -> v2:
* Put orig_gpr2 in place of args[1] on s390 (Vasily).
* Fix arm64, powerpc and riscv (Heiko).

The arm64 fix is similar to the s390 one.

powerpc and riscv are different in that they unpack arguments to
registers before invoking syscall handlers - libbpf needs to know about
this difference, so I've decided to introduce PT_REGS_SYSCALL macro for
this (see bpf_syscall_macro test for usage example).

Tested in QEMU.

@Catalin, @Michael, @Paul: could you please review the arm64, powerpc
and riscv parts?

Ilya Leoshkevich (10):
  arm64/bpf: Add orig_x0 to user_pt_regs
  s390/bpf: Add orig_gpr2 to user_pt_regs
  selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
  libbpf: Add __PT_PARM1_REG_SYSCALL macro
  libbpf: Add PT_REGS_SYSCALL macro
  selftests/bpf: Use PT_REGS_SYSCALL in bpf_syscall_macro
  libbpf: Fix accessing the first syscall argument on arm64
  libbpf: Fix accessing syscall arguments on powerpc
  libbpf: Fix accessing syscall arguments on riscv
  libbpf: Fix accessing the first syscall argument on s390

 arch/arm64/include/asm/ptrace.h               |  2 +-
 arch/arm64/include/uapi/asm/ptrace.h          |  1 +
 arch/s390/include/asm/ptrace.h                |  3 +--
 arch/s390/include/uapi/asm/ptrace.h           |  2 +-
 tools/lib/bpf/bpf_tracing.h                   | 23 ++++++++++++++++++-
 .../selftests/bpf/progs/bpf_syscall_macro.c   |  7 ++++--
 6 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.34.1

