Return-Path: <bpf+bounces-12827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD17D114B
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C295A1C20F70
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA81D527;
	Fri, 20 Oct 2023 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="stqh7lJN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F81CFA6
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:14:32 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1461A8
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:14:30 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KEA4BW010079;
	Fri, 20 Oct 2023 14:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=vYihVZhhEqkil7q6mTllNMq9mfh32x1mF1x7BTOUpAg=;
 b=stqh7lJNzzwXuMKLoRpogoUfGBha30pWpWttDZ0zn7Zd7Qt1fTAB1p80wdpeZqbZp+xB
 M3uQSk260m2CBWcKuILBLOJ6XfpVcrD5u6TWQWSJplh1/GyhYX88tAA8YkmTxUEtMbqd
 l/RO9r7nFR1YT6WYsQdV8Aot+vuI55Qn41NRYk0h6niJVS3EQdGNV5kLKWnFLniMxNrh
 a/m3gYRjnf2b2nZf5Z+AkeMaQrapsrPdBQda17rC+3LK+38+KfyqSFMicDkOn1NzA8IC
 DtxoZ80Qt25NxgKnQVCIdIJMFyabJrP10LJKhoK+bhO/dRrW4HshhmnVckWxwyCkyDgk Mg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuu2w84gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 14:14:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39KBxLm3024162;
	Fri, 20 Oct 2023 14:14:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc2951hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 14:14:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39KEE2lj21299930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 14:14:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3077520043;
	Fri, 20 Oct 2023 14:14:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2FCC20040;
	Fri, 20 Oct 2023 14:13:59 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.18.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Oct 2023 14:13:59 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v7 0/5] powerpc/bpf: use BPF prog pack allocator
Date: Fri, 20 Oct 2023 19:43:53 +0530
Message-ID: <20231020141358.643575-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R921qn1U7N0_S4OYz292ecGosRJSdehs
X-Proofpoint-ORIG-GUID: R921qn1U7N0_S4OYz292ecGosRJSdehs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=688 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200116

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

Changes in v7:
* Fixed crash observed with !STRICT_RWX.

Changes in v6:
* No changes in patches 2-5/5 except addition of Acked-by tags from Song.
* Skipped merging code path of patch_instruction() & patch_instructions()
  to avoid performance overhead observed on ppc32 with that.

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

Changes in v2:
* Introduced patch_instructions() to help with patching bpf programs.


Hari Bathini (5):
  powerpc/code-patching: introduce patch_instructions()
  powerpc/bpf: implement bpf_arch_text_copy
  powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
  powerpc/bpf: rename powerpc64_jit_data to powerpc_jit_data
  powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]

 arch/powerpc/include/asm/code-patching.h |   1 +
 arch/powerpc/lib/code-patching.c         | 141 +++++++++++++++++++++-
 arch/powerpc/net/bpf_jit.h               |  18 +--
 arch/powerpc/net/bpf_jit_comp.c          | 145 ++++++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c        |  13 +-
 arch/powerpc/net/bpf_jit_comp64.c        |  10 +-
 6 files changed, 271 insertions(+), 57 deletions(-)

-- 
2.41.0


