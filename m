Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6A6249CA
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 19:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKJSoJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 13:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiKJSnv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 13:43:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09BE4B982
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 10:43:50 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAIflD3025941;
        Thu, 10 Nov 2022 18:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=XxpamRVRCdt9qvuSBAP0HIPKDfuNwKHeN4iEf3SmIOg=;
 b=J3th4QqjdzmQniy2NbEw40tsy4dWZ0MIt/9t/9/X3E3Pfd7HiKYIqv+2XADjueD7WgOs
 cpyI/xzhhLrEYuXutH1X8DSykv8ybMCvPCnjQGHpIXfYoGv7tz6wV53XsmG6v3ZhXmi8
 eHLZcilGMkWieMKUOsWZtfz78FSJ4dWj9nCgEuAAZCYNcT0OToCXp9bAx89sqyPTynSp
 fJBe06TvV1gamqRfD+9UMERr51vz59gnZz4J9TmI6qDw3/mM96tLG0gHSzUJ9PnvqE3j
 t+7dHJgbsKnnp/EGPE9MKYmQ0azUKsQP6X3Ggltt4l9emZzJP79TfmJDESm2n7t//GbP OQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks6t8r16q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:43:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AAIaXja000794;
        Thu, 10 Nov 2022 18:43:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3kngqgfp8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 18:43:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AAIbVbx49152334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 18:37:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 587E7A4051;
        Thu, 10 Nov 2022 18:43:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58549A404D;
        Thu, 10 Nov 2022 18:43:15 +0000 (GMT)
Received: from hbathini-workstation.ibm.com.com (unknown [9.163.72.10])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Nov 2022 18:43:14 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC PATCH 0/3] enable bpf_prog_pack allocator for powerpc
Date:   Fri, 11 Nov 2022 00:13:00 +0530
Message-Id: <20221110184303.393179-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AtrBRS8GN6rS4KnIU9RtSzs3_d1ZLh6v
X-Proofpoint-ORIG-GUID: AtrBRS8GN6rS4KnIU9RtSzs3_d1ZLh6v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=828
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100129
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

Patches 1 & 2 add the arch specific functions needed to support this
feature. Patch 3 enables the support for powerpc. The last patch
ensures cleanup is handled racefully.

Tested the changes successfully on a PowerVM. patch_instruction(),
needed for bpf_arch_text_copy(), is failing for ppc32. Debugging it.
Posting the patches in the meanwhile for feedback on these changes.

[1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/

Hari Bathini (3):
  powerpc/bpf: implement bpf_arch_text_copy
  powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
  powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]

 arch/powerpc/net/bpf_jit.h        |  18 +--
 arch/powerpc/net/bpf_jit_comp.c   | 194 ++++++++++++++++++++++++------
 arch/powerpc/net/bpf_jit_comp32.c |  26 ++--
 arch/powerpc/net/bpf_jit_comp64.c |  32 ++---
 4 files changed, 198 insertions(+), 72 deletions(-)

-- 
2.37.3

