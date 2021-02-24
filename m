Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55219323BC2
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 13:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhBXMDf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 07:03:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233365AbhBXMDf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 07:03:35 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OBY4uH148032;
        Wed, 24 Feb 2021 07:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Kz3gGIfpD8P0bGFLWzPyaeG8hJKUUbWajDPitTMkAxI=;
 b=LtrvVv7vnojM/btKLt4sm2AB625waaQsHeHoBYrO5i5i+e1cISjF8vha+Q89Wya4UmbB
 Fu1s6m2IvezfCWcdUnQucuFLVu+sFFlpn3SefoVzU1PTpSQNVCBBquanAPgVX4r8hRAd
 agmUk661A/tDC6SsriiX6bI93M8x6xYCqqdBfgZQQwQ4RHK+/KrydgGy4RgyA83qx8X0
 ln+rKN/ZpQ9Ux9rojddAhqV/HTorDERk07Iqjh/P0lI7yrXuZ/cmtYBoRM94ZppbSiEz
 DIMQwRODm+6a+EEZtaTI1Z2qXBFX52faFplLf1RVajV3B2QR+q1QCA7p3Aiki94D+XCJ YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wktkwvya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 07:02:41 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OBZkMA154161;
        Wed, 24 Feb 2021 07:02:41 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wktkwvwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 07:02:41 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OBw98n015339;
        Wed, 24 Feb 2021 12:02:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 36tt289upj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 12:02:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OC2aPM64225682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 12:02:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 576D742045;
        Wed, 24 Feb 2021 12:02:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E163142042;
        Wed, 24 Feb 2021 12:02:35 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 12:02:35 +0000 (GMT)
Message-ID: <0d724d02826950e5911ff26125df79541eb32ffc.camel@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Date:   Wed, 24 Feb 2021 13:02:35 +0100
In-Reply-To: <20210223150845.1857620-1-jackmanb@google.com>
References: <20210223150845.1857620-1-jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_03:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240091
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-23 at 15:08 +0000, Brendan Jackman wrote:
> As pointed out by Ilya and explained in the new comment, there's a
> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> the value from memory into r0, while x86 only does so when r0 and the
> value in memory are different. The same issue affects s390.
> 
> At first this might sound like pure semantics, but it makes a real
> difference when the comparison is 32-bit, since the load will
> zero-extend r0/rax.
> 
> The fix is to explicitly zero-extend rax after doing such a
> CMPXCHG. Since this problem affects multiple archs, this is done in
> the verifier by patching in a BPF_ZEXT_REG instruction after every
> 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> 
> There was actually already logic to patch in zero-extension insns
> after 32-bit cmpxchgs, in opt_subreg_zext_lo32_rnd_hi32. To avoid
> bloating the prog with unnecessary movs, we now explicitly check and
> skip that logic for this case.
> 
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> 
> Differences v3->v4[1]:
>  - Moved the optimization against pointless zext into the correct
> place:
>    opt_subreg_zext_lo32_rnd_hi32 is called _after_ fixup_bpf_calls.
> 
> Differences v2->v3[1]:
>  - Moved patching into fixup_bpf_calls (patch incoming to rename this
> function)
>  - Added extra commentary on bpf_jit_needs_zext
>  - Added check to avoid adding a pointless zext(r0) if there's
> already one there.
> 
> Difference v1->v2[1]: Now solved centrally in the verifier instead of
>   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> suggestions!
> 
> [1] v3: 
> https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
>     v2: 
> https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
>     v1: 
> https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> 
>  kernel/bpf/core.c                             |  4 +++
>  kernel/bpf/verifier.c                         | 33
> +++++++++++++++++--
>  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++
>  .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++
>  4 files changed, 86 insertions(+), 2 deletions(-)

Unfortunately this still gives me 2 x `w0 = w0` on s390, but the
culprit seems to be not your patch, but rather that
adjust_insn_aux_data() is messing up zext_dst. I'll try to debug
further and come up with a fix.

