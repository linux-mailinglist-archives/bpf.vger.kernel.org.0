Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3424B4DC0
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiBNLNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:13:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350109AbiBNLNF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:13:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A273AD11F
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 02:42:32 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9m7QX002701;
        Mon, 14 Feb 2022 10:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=HRgdk3Xd9GVO60ggAAKL+6DkT3RjEAdUX7JmNrJeaJQ=;
 b=PPOpz6S4XLyH/IcIDMPBZYyd5/3UIiTFdzvVXnCtnJiVk3A5367jj5oRY52pbnhFaI/t
 5QQTIXiQpY8OfgMjPQ8eteOlaHdpv42NkUAXGsozpbraDJC67GN3Ze9YmYRe473Gqf04
 4DfFecqUkw8B++ns4PqFDMLlzPBitL4vNPxi1pPqmJ3zpdSjSHldy0cBUcdcAd/L/pUq
 YAg6viewWRGGSXnoV6x717JejxcrC/JfteXxhndhDeHJW9GQf+b03PU4XoBa7mTh2OG+
 8MRkW45xbXV2kNGgUH/MdHdt/sAc2x0GkHW5kslgeH1ZP5cyEIHDhR9DeIiNaxrmhGJc RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e7cjdu5f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:08 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EA09ip027989;
        Mon, 14 Feb 2022 10:42:08 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e7cjdu5er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:08 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAXffG014645;
        Mon, 14 Feb 2022 10:42:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3e645jb9u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:42:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EAg3oO47120712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:42:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 016B8AE053;
        Mon, 14 Feb 2022 10:42:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8AFDAE057;
        Mon, 14 Feb 2022 10:42:00 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.124.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Feb 2022 10:42:00 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <bpf@vger.kernel.org>
Subject: [PATCH powerpc/next 00/17] powerpc/bpf: Some updates and cleanups
Date:   Mon, 14 Feb 2022 16:11:34 +0530
Message-Id: <cover.1644834730.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V6JdpT6bC_oRiM_6gTOKY2yWJu5D3XJr
X-Proofpoint-ORIG-GUID: XE4hxrFGZFT9NYEZfyDGqiUDNPpPYCXT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=463 mlxscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a follow-up series with the pending patches from:
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=279602&state=*

Patches 1-5 and 8 are unchanged. Patch 6 is new and patch 7 has changes 
based on discussion from the last series. Patch 9 has a small change to 
not skip the toc load for elf v2.

Patches 10-17 are new to this series and are largely some cleanups to 
the bpf code on powerpc.

- Naveen


Jordan Niethe (1):
  powerpc64/bpf: Store temp registers' bpf to ppc mapping

Naveen N. Rao (16):
  powerpc/bpf: Skip branch range validation during first pass
  powerpc/bpf: Emit a single branch instruction for known short branch
    ranges
  powerpc/bpf: Handle large branch ranges with BPF_EXIT
  powerpc64/bpf: Do not save/restore LR on each call to
    bpf_stf_barrier()
  powerpc64/bpf: Use r12 for constant blinding
  powerpc64: Set PPC64_ELF_ABI_v[1|2] macros to 1
  powerpc64/bpf elfv2: Setup kernel TOC in r2 on entry
  powerpc64/bpf elfv1: Do not load TOC before calling functions
  powerpc64/bpf: Optimize instruction sequence used for function calls
  powerpc/bpf: Rename PPC_BL_ABS() to PPC_BL()
  powerpc64/bpf: Convert some of the uses of PPC_BPF_[LL|STL] to
    PPC_BPF_[LD|STD]
  powerpc64/bpf: Get rid of PPC_BPF_[LL|STL|STLU] macros
  powerpc/bpf: Cleanup bpf_jit.h
  powerpc/bpf: Move bpf_jit64.h into bpf_jit_comp64.c
  powerpc/bpf: Use _Rn macros for GPRs
  powerpc/bpf: Simplify bpf_to_ppc() and adopt it for powerpc64

 arch/powerpc/include/asm/types.h  |   4 +-
 arch/powerpc/net/bpf_jit.h        |  35 +--
 arch/powerpc/net/bpf_jit64.h      |  91 ------
 arch/powerpc/net/bpf_jit_comp.c   |  34 ++-
 arch/powerpc/net/bpf_jit_comp32.c | 113 ++++----
 arch/powerpc/net/bpf_jit_comp64.c | 440 ++++++++++++++++--------------
 6 files changed, 340 insertions(+), 377 deletions(-)
 delete mode 100644 arch/powerpc/net/bpf_jit64.h


base-commit: 1b43a74f255c5c00db25a5fedfd75ca0dc029022
-- 
2.35.1

