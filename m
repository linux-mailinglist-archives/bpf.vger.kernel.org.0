Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1892C4863D3
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiAFLqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:46:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231423AbiAFLqR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:46:17 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206B6j4e018579;
        Thu, 6 Jan 2022 11:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gXEOnt0R7cxWmB5c4YYgJeN80GsgaMP07Hw9XAvcSSE=;
 b=OTLefi+j+hIBaUsPqsQA+L8LMrlJmVIse9P/DwtufHScKxVKoCqnsiiXRWM5VUY4RmA5
 jIVKBev9F8CBaX5o2kLZPW6ZNalLj7TZCQM8bi3rgLb1aPijkMMpR9waoz7sKCG/C5o7
 vj46uIt0M0EF0pfbGry5CSd8GJlsmA+SXuSNjAZ1v/gGrTb8Ou3F43Vhg6rfdaa5XUW6
 lrGKgFVIJeSxMPANQ517i9hq1aNhdCz/cRqEZnq4fVEAqMrDr+f08DVDzrDUkWSDh1Jc
 Y8Gtcnx6DhLcpPbA/2TgfxFTNWP0GijBTQU+WZDbnPnPyoM6smvItHoKnYEWYiwcRHlm rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ddud7vxat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:45:56 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206BjKX9020572;
        Thu, 6 Jan 2022 11:45:55 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ddud7vxa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:45:55 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206BgXaI005819;
        Thu, 6 Jan 2022 11:45:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3ddngr48gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:45:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206BjoCs38732166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:45:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50E2CA4062;
        Thu,  6 Jan 2022 11:45:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BEDCA405F;
        Thu,  6 Jan 2022 11:45:47 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:45:47 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 00/13] powerpc/bpf: Some fixes and updates
Date:   Thu,  6 Jan 2022 17:15:04 +0530
Message-Id: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XmTVu6tIFD5duA1LqcS4wFbHFo9rrVPj
X-Proofpoint-ORIG-GUID: UGmjv-ZL9br0SE2KHNHbyooqtSkHXyFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=612 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A set of fixes and updates to powerpc BPF JIT:
- Patches 1-3 fix issues with the existing powerpc JIT and are tagged 
  for -stable.
- Patch 4 fixes a build issue with bpf selftests on powerpc.
- Patches 5-9 handle some corner cases and make some small improvements.
- Patches 10-13 optimize how function calls are handled in ppc64. 

Patches 7 and 8 were previously posted, and while patch 7 has no 
changes, patch 8 has been reworked to handle BPF_EXIT differently.


- Naveen


Naveen N. Rao (13):
  bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()
  powerpc32/bpf: Fix codegen for bpf-to-bpf calls
  powerpc/bpf: Update ldimm64 instructions during extra pass
  tools/bpf: Rename 'struct event' to avoid naming conflict
  powerpc/bpf: Skip branch range validation during first pass
  powerpc/bpf: Emit a single branch instruction for known short branch
    ranges
  powerpc/bpf: Handle large branch ranges with BPF_EXIT
  powerpc64/bpf: Limit 'ldbrx' to processors compliant with ISA v2.06
  powerpc64/bpf: Do not save/restore LR on each call to
    bpf_stf_barrier()
  powerpc64/bpf: Use r12 for constant blinding
  powerpc64/bpf elfv2: Setup kernel TOC in r2 on entry
  powerpc64/bpf elfv1: Do not load TOC before calling functions
  powerpc64/bpf: Optimize instruction sequence used for function calls

 arch/powerpc/include/asm/ppc-opcode.h |   1 +
 arch/powerpc/net/bpf_jit.h            |   8 +-
 arch/powerpc/net/bpf_jit64.h          |   2 +-
 arch/powerpc/net/bpf_jit_comp.c       |  55 ++++++++++--
 arch/powerpc/net/bpf_jit_comp32.c     |  32 +++++--
 arch/powerpc/net/bpf_jit_comp64.c     | 124 ++++++++++++++------------
 kernel/bpf/stackmap.c                 |   5 +-
 tools/bpf/runqslower/runqslower.bpf.c |   2 +-
 tools/bpf/runqslower/runqslower.c     |   2 +-
 tools/bpf/runqslower/runqslower.h     |   2 +-
 10 files changed, 153 insertions(+), 80 deletions(-)


base-commit: bdcf18e133f656b2c97390a594fc95e37849e682
-- 
2.34.1

