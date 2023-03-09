Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780EB6B2C8C
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCISCp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCISCo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:02:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B4FCBC1
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:02:42 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329H52VA019970;
        Thu, 9 Mar 2023 18:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=f2YtmbBo/XIPEk+DAobJEAfO4YCF48VXlkBCn3DMtMQ=;
 b=emPG9Acp51jKiCoik1OeG4C1vfcnE9zMDBp6z/pil7ienvF9tdE+OJY2AwlLzJMdm+vO
 fcrH7G18qmIordajWpe5o96qfh8way9WVit3SncAjRNA6C6hbKqS4phloibqVrYVwNIS
 AiI8aQgEVm63hlQCuj5Iuyf2zStRImJQS+Hw42nAKIc9KkHi4Re57KkGbgDLNeyrewMx
 zPj1ReQTNCgt9AymvPvhEITIsGHHPvMu7cRvJn2Bs3KprBkXui9pJ4SBXcLvXULOOUyY
 0HRUfQ7cbj/cj70QNA/DJfRaN7+BeWSC41t3O8g32pRb0LsZRFgatXZGPx3z5GUKYjd/ Rw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7j154ecn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:02:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329GsqhN022967;
        Thu, 9 Mar 2023 18:02:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p6fystqvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 18:02:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329I2G0f65864158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 18:02:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 420312004E;
        Thu,  9 Mar 2023 18:02:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18CB62004D;
        Thu,  9 Mar 2023 18:02:14 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.13.46])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 18:02:13 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 0/4] enable bpf_prog_pack allocator for powerpc
Date:   Thu,  9 Mar 2023 23:32:09 +0530
Message-Id: <20230309180213.180263-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hL_b8h0taduXkIHftOfrB6nqMHSSmEnS
X-Proofpoint-GUID: hL_b8h0taduXkIHftOfrB6nqMHSSmEnS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_08,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Most BPF programs are small, but they consume a page each. For systems
with busy traffic and many BPF programs, this may also add significant
pressure on instruction TLB. High iTLB pressure usually slows down the
whole system causing visible performance degradation for production
workloads.

bpf_prog_pack, a customized allocator that packs multiple bpf programs
into preallocated memory chunks, was proposed [1] to address it. This
series extends this support on powerpc.

The first patch introduces patch_instructions() function to enable
patching more than one instruction at a time. This change showed
around 5X improvement in the time taken to run test_bpf test cases.
Patches 2 & 3 add the arch specific functions needed to support this
feature. Patch 4 enables the support for powerpc and ensures cleanup
is handled racefully. Tested the changes successfully.

[1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
[2] https://lore.kernel.org/all/20221110184303.393179-1-hbathini@linux.ibm.com/ 

Changes in v2:
* Introduced patch_instructions() to help with patching bpf programs.

Hari Bathini (4):
  powerpc/code-patching: introduce patch_instructions()
  powerpc/bpf: implement bpf_arch_text_copy
  powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
  powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]

 arch/powerpc/include/asm/code-patching.h |   1 +
 arch/powerpc/lib/code-patching.c         | 151 ++++++++++++++++-------
 arch/powerpc/net/bpf_jit.h               |   7 +-
 arch/powerpc/net/bpf_jit_comp.c          | 142 ++++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c        |   4 +-
 arch/powerpc/net/bpf_jit_comp64.c        |   6 +-
 6 files changed, 226 insertions(+), 85 deletions(-)

-- 
2.39.2

