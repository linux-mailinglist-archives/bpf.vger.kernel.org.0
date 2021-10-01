Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8826841F6B7
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhJAVRc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:17:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbhJAVRc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Oct 2021 17:17:32 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191KmA0A012105;
        Fri, 1 Oct 2021 17:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Wm9ssMUwToeW98lV81N19hbAcMm50cGOgb7TpVNaSXA=;
 b=E6c0XIftIdOK3eJVmcnV9eccWJHFi//dI61QFGnMYh49wUgSubKb5vgHhbHvLrvkAAFk
 XaaTzNKQmD/BaXH5Z7txgU0+l5yrozkDXvuoQzvakBfFWC0Gng4IPyUM+25PT/e71eFS
 k3SHgq8um7NzzlySf4ahPZOewTW3Em7zmK/NV5XAovzzxIsGvqugiobCwlL2diqW09Yx
 dZF9qKQSGMEPVNIIbfb0ruOXEQz+b0KbXvM2Ry2bjRougkS8h7WVaEz2lszMj9gyZtJg
 S02FOu56mXSobDNX3ABKVbdzo36JzXBsCSP+oT6wdrjPq3lDx1izO+MdksGV9QXQvbGb 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3be9p6rf81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 17:15:23 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 191LFNFo036553;
        Fri, 1 Oct 2021 17:15:23 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3be9p6rf7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 17:15:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 191L6lAD007329;
        Fri, 1 Oct 2021 21:15:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9udb1yww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 21:15:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 191LFHni66322722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Oct 2021 21:15:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 438A04C064;
        Fri,  1 Oct 2021 21:15:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 684A84C04E;
        Fri,  1 Oct 2021 21:15:14 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.54.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Oct 2021 21:15:14 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/9] powerpc/bpf: Various fixes
Date:   Sat,  2 Oct 2021 02:44:46 +0530
Message-Id: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kY4RZhFgsl2koOI7OV93qZMRgIgnKIVF
X-Proofpoint-ORIG-GUID: zKicyWQ1bmtPiUR2wbjNaz8uA4tBUxrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=655 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010147
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Various fixes to the eBPF JIT for powerpc, thanks to some new tests 
added by Johan. This series fixes all failures in test_bpf on powerpc64.  
There are still some failures on powerpc32 to be looked into.

- Naveen


Naveen N. Rao (8):
  powerpc/lib: Add helper to check if offset is within conditional
    branch range
  powerpc/bpf: Validate branch ranges
  powerpc/bpf: Handle large branch ranges with BPF_EXIT
  powerpc/bpf: Fix BPF_MOD when imm == 1
  powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
  powerpc/bpf: Limit 'ldbrx' to processors compliant with ISA v2.06
  powerpc/security: Add a helper to query stf_barrier type
  powerpc/bpf: Emit stf barrier instruction sequences for BPF_NOSPEC

Ravi Bangoria (1):
  powerpc/bpf: Remove unused SEEN_STACK

 arch/powerpc/include/asm/code-patching.h     |   1 +
 arch/powerpc/include/asm/ppc-opcode.h        |   1 +
 arch/powerpc/include/asm/security_features.h |   5 +
 arch/powerpc/kernel/security.c               |   5 +
 arch/powerpc/lib/code-patching.c             |   7 +-
 arch/powerpc/net/bpf_jit.h                   |  39 ++++---
 arch/powerpc/net/bpf_jit64.h                 |   8 +-
 arch/powerpc/net/bpf_jit_comp.c              |  28 ++++-
 arch/powerpc/net/bpf_jit_comp32.c            |  10 +-
 arch/powerpc/net/bpf_jit_comp64.c            | 113 ++++++++++++++-----
 10 files changed, 167 insertions(+), 50 deletions(-)


base-commit: 044c2d99d9f43c6d6fde8bed00672517dd9a5a57
-- 
2.33.0

