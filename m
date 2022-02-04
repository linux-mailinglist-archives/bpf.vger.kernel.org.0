Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E514A9B67
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 15:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiBDOus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 09:50:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244487AbiBDOur (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 09:50:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214D2PKb021373;
        Fri, 4 Feb 2022 14:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=PoL1Suu1JF/CINMOqS2TXMYutZAzhZyOvyyvk8P3zlc=;
 b=bMTgatkFMGTBLc0wa1Ae+Rrh23DQIf2Vf5WKhvkTsy+jpsADrCSV+Dc2E7hR/FkMVOdb
 /c7FmFyozh0LfQeAvNWkAcd9OSWBcHCcwEUGlG7uH+xsAkI/jfvWH5aBYllx01hZfy7b
 LDK7Sax1ua72D1Duht6dD+Ib23bkAMJYhd3mP7hVQHLCWAjsGFLI3RwvLzr7TC9Em89w
 Iv9PR4eL5KmvZncchTOEbN6WeyKbWh17yTs/+XZ9Fsicp/MHpDSq0DU1i8KdeDr+x1Ge
 U1aOdisWqJC3ACKbudO0/dco/7IjUoyTrTpe7YjehN+MrgXgOuzRLI81vu5HiOH4EKav Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0vrru1cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:27 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214EWcno019751;
        Fri, 4 Feb 2022 14:50:26 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0vrru1bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:26 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214El6bO016206;
        Fri, 4 Feb 2022 14:50:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3e0r0snu5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214EoLU642664346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 14:50:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AD625204E;
        Fri,  4 Feb 2022 14:50:21 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 968755204F;
        Fri,  4 Feb 2022 14:50:20 +0000 (GMT)
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 00/11] libbpf: Fix accessing syscall arguments
Date:   Fri,  4 Feb 2022 15:50:07 +0100
Message-Id: <20220204145018.1983773-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9oasV-A2uSd6QgmjeOc2ahEt36skzCof
X-Proofpoint-ORIG-GUID: MFkO5igDbX6GuEojpPR1CSqTABl7X9UY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_05,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040082
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf now has macros to access syscall arguments in an
architecture-agnostic manner, but unfortunately they have a number of
issues on non-Intel arches, which this series aims to fix.

v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
v1 -> v2:
* Put orig_gpr2 in place of args[1] on s390 (Vasily).
* Fix arm64, powerpc and riscv (Heiko).

v2: https://lore.kernel.org/bpf/20220204041955.1958263-1-iii@linux.ibm.com/
v2 -> v3:
* Undo args[1] change (Andrii).
* Rename PT_REGS_SYSCALL to PT_REGS_SYSCALL_REGS (Andrii).
* Split the riscv patch (Andrii).

+cc Naveen.

Ilya Leoshkevich (11):
  arm64/bpf: Add orig_x0 to user_pt_regs
  s390/bpf: Add orig_gpr2 to user_pt_regs
  selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
  libbpf: Add __PT_PARM1_REG_SYSCALL macro
  libbpf: Add PT_REGS_SYSCALL_REGS macro
  selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
  libbpf: Fix accessing the first syscall argument on arm64
  libbpf: Fix accessing syscall arguments on powerpc
  libbpf: Fix accessing program counter on riscv
  libbpf: Fix accessing syscall arguments on riscv
  libbpf: Fix accessing the first syscall argument on s390

 arch/arm64/include/asm/ptrace.h               |  2 +-
 arch/arm64/include/uapi/asm/ptrace.h          |  1 +
 arch/s390/include/asm/ptrace.h                |  2 +-
 arch/s390/include/uapi/asm/ptrace.h           |  1 +
 tools/lib/bpf/bpf_tracing.h                   | 23 ++++++++++++++++++-
 .../selftests/bpf/progs/bpf_syscall_macro.c   |  7 ++++--
 6 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.34.1

