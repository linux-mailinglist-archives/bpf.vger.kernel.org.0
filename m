Return-Path: <bpf+bounces-11061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0BF7B261C
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1C28928258D
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034833FB10;
	Thu, 28 Sep 2023 19:48:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C8110B
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 19:48:51 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D60719F
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 12:48:50 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SJg4CP024449;
	Thu, 28 Sep 2023 19:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=MpvdhYnzDwdS5guLmnKgmjz7ZlhhsEsMxRUvtwEaozQ=;
 b=B2HmD2Rxlcvft2/qACemggrEhfm0Iik3Fso3PC76XViHCcjxzXvskOQoe7OPOizpH5Sa
 qwKmg9QPHHzUOjAT6RbTrpR/CNPe+nnWPihwbeBrLdFD+70Le5stahr3FRDtVqFQ1mAk
 TNwAILUdfx+eCxmbr4HnwjPKssqrSYTZtk20Yf3S6r4HfUSfW7absL9JiHsnkMDx517U
 UbvSMEFiPZQyC9376DOqXnw6UoOoZ4bAaRRBrZ2UPGVOit7nRKyF6OLagOe4TMYgNqnI
 4QA07DcDgFbKiGKWya0NOKwk2GAxO5Px2fgOq0/oQvxiD3zBgKIvoRIviefAVl6yTcdd zw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdfvfg5kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 19:48:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SIg9Wo030466;
	Thu, 28 Sep 2023 19:48:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad226x7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 19:48:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SJmM202753090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Sep 2023 19:48:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7574B20040;
	Thu, 28 Sep 2023 19:48:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9503220063;
	Thu, 28 Sep 2023 19:48:20 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.85.6])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Sep 2023 19:48:20 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 0/5] powerpc/bpf: use BPF prog pack allocator
Date: Fri, 29 Sep 2023 01:18:13 +0530
Message-ID: <20230928194818.261163-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SLzhQbLaCiBXgoxTkfrWwqm07vg-cV7S
X-Proofpoint-ORIG-GUID: SLzhQbLaCiBXgoxTkfrWwqm07vg-cV7S
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_19,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=715 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Most BPF programs are small, but they consume a page each. For systems
with busy traffic and many BPF programs, this may also add significant
pressure on instruction TLB. High iTLB pressure usually slows down the
whole system causing visible performance degradation for production
workloads.

bpf_prog_pack, a customized allocator that packs multiple bpf programs
into preallocated memory chunks, was proposed [1] to address it. This
series extends this support on powerpc.

Both bpf_arch_text_copy() & bpf_arch_text_invalidate() functions,
needed for this support depend on instruction patching in text area.
Currently, patch_instruction() supports patching only one instruction
at a time. The first patch introduces patch_instructions() function
to enable patching more than one instruction at a time. This helps in
avoiding performance degradation while JITing bpf programs.

Patches 2 & 3 implement the above mentioned arch specific functions
using patch_instructions(). Patch 4 fixes a misnomer in bpf JITing
code. The last patch enables the use of BPF prog pack allocator on
powerpc and also, ensures cleanup is handled gracefully.

[1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/

Changes in v5:
* Moved introduction of patch_instructions() as 1st patch in series.
* Improved patch_instructions() to use memset & memcpy.
* Fixed the misnomer in JITing code as a separate patch.
* Removed unused bpf_flush_icache() function.

Changes in v4:
* Updated bpf_patch_instructions() definition in patch 1/5 so that
  it doesn't have to be updated again in patch 2/5.
* Addressed Christophe's comment on bpf_arch_text_invalidate() return
  value in patch 2/5.

Changes in v3:
* Fixed segfault issue observed on ppc32 due to inaccurate offset
  calculation for branching.
* Tried to minimize the performance impact for patch_instruction()
  with the introduction of patch_instructions().
* Corrected uses of u32* vs ppc_instr_t.
* Moved the change that introduces patch_instructions() to after
  enabling bpf_prog_pack support.
* Added few comments to improve code readability.


Hari Bathini (5):
  powerpc/code-patching: introduce patch_instructions()
  powerpc/bpf: implement bpf_arch_text_copy
  powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
  powerpc/bpf: rename powerpc64_jit_data to powerpc_jit_data
  powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]

 arch/powerpc/include/asm/code-patching.h |   1 +
 arch/powerpc/lib/code-patching.c         |  93 +++++++++++++--
 arch/powerpc/net/bpf_jit.h               |  18 +--
 arch/powerpc/net/bpf_jit_comp.c          | 145 ++++++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c        |  13 +-
 arch/powerpc/net/bpf_jit_comp64.c        |  10 +-
 6 files changed, 217 insertions(+), 63 deletions(-)

-- 
2.41.0


