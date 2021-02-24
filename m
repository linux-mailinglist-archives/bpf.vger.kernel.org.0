Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B095E32475C
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbhBXXII (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:08:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235612AbhBXXIH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:08:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ON4mpA069256;
        Wed, 24 Feb 2021 18:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ws4W209gPzet5wx+acqjeR2wEY1J4Yto5LxV2giZfTE=;
 b=Q1hdCQdzEUXTm2G+oeBECnFIodyYxxtkqol1z5SYfN6B4zzrxOwvW0iomEyq7eOyYTfJ
 7WWxAKlG5bF0qImPPXjmFcHfKXaHUtzCYpSppGFgd+P3j5Uy0ULU75C2fAXbc5s1mlI0
 LCbfosImoMc/tck/CXshr6XHUUdWnIvTeo6ddE9uZ2sN992mDa/E0WorhKezKEv/0p9v
 PHGrKuKFKPDK1VwFbbHkaKErhu9Oj/lURPlx7fiM45M+Y2LlukdM5Cf+B78U5hGWBMjr
 z/IZvUwk8/fN3zRkrT5DiRvltbKIktCnfKMnGrMMvV4HcSHFBS/Veg+euHD9Mq3ecJRi dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wgu6r3c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:07:13 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ON4rMH069521;
        Wed, 24 Feb 2021 18:07:13 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wgu6r3bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:07:13 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ON77V4018370;
        Wed, 24 Feb 2021 23:07:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 36tt28a2dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:07:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ON78KH37683546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:07:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 035AA11C052;
        Wed, 24 Feb 2021 23:07:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8658111C06F;
        Wed, 24 Feb 2021 23:07:07 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:07:07 +0000 (GMT)
Message-ID: <44d680a0c40fc9dddf1b2bf4e78bd75b76dc4061.camel@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Date:   Thu, 25 Feb 2021 00:07:07 +0100
In-Reply-To: <20210224223449.3vwtjzx7cvlvzpv5@kafai-mbp.dhcp.thefacebook.com>
References: <20210223150845.1857620-1-jackmanb@google.com>
         <3652fb931ee58813f083c9722223b89b56a2a1c0.camel@linux.ibm.com>
         <20210224223449.3vwtjzx7cvlvzpv5@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240179
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-24 at 14:34 -0800, Martin KaFai Lau wrote:
> On Wed, Feb 24, 2021 at 03:16:18PM +0100, Ilya Leoshkevich wrote:
> > On Tue, 2021-02-23 at 15:08 +0000, Brendan Jackman wrote:
> > > As pointed out by Ilya and explained in the new comment, there's a
> > > discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> > > the value from memory into r0, while x86 only does so when r0 and
> > > the
> > > value in memory are different. The same issue affects s390.
> > > 
> > > At first this might sound like pure semantics, but it makes a real
> > > difference when the comparison is 32-bit, since the load will
> > > zero-extend r0/rax.
> > > 
> > > The fix is to explicitly zero-extend rax after doing such a
> > > CMPXCHG. Since this problem affects multiple archs, this is done in
> > > the verifier by patching in a BPF_ZEXT_REG instruction after every
> > > 32-bit cmpxchg. Any archs that don't need such manual zero-
> > > extension
> > > can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> > > 
> > > There was actually already logic to patch in zero-extension insns
> > > after 32-bit cmpxchgs, in opt_subreg_zext_lo32_rnd_hi32. To avoid
> > > bloating the prog with unnecessary movs, we now explicitly check
> > > and
> > > skip that logic for this case.
> > > 
> > > Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > ---
> > > 
> > > Differences v3->v4[1]:
> > >  - Moved the optimization against pointless zext into the correct
> > > place:
> > >    opt_subreg_zext_lo32_rnd_hi32 is called _after_ fixup_bpf_calls.
> > > 
> > > Differences v2->v3[1]:
> > >  - Moved patching into fixup_bpf_calls (patch incoming to rename
> > > this
> > > function)
> > >  - Added extra commentary on bpf_jit_needs_zext
> > >  - Added check to avoid adding a pointless zext(r0) if there's
> > > already one there.
> > > 
> > > Difference v1->v2[1]: Now solved centrally in the verifier instead
> > > of
> > >   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> > > suggestions!
> > > 
> > > [1] v3: 
> > > https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> > >     v2: 
> > > https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> > >     v1: 
> > > https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> > > 
> > >  kernel/bpf/core.c                             |  4 +++
> > >  kernel/bpf/verifier.c                         | 33
> > > +++++++++++++++++--
> > >  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++
> > >  .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++
> > >  4 files changed, 86 insertions(+), 2 deletions(-)
> > 
> > I think I managed to figure out what is wrong with
> > adjust_insn_aux_data(): insn_has_def32() does not know about
> > BPF_FETCH.
> > I'll post a fix shortly; in the meantime, based on my debugging
> > experience and on looking at the code for a while, I have a few
> > comments regarding the patch.
> Ah. good catch.
> 
> If adjust_insn_aux_data()/insn_has_def32() is fixed to set zext_dst
> properly for BPF_FETCH, then that alone should be enough for s390?

Yes, my fix [1] + this patch (with conflicts resolved) seem to work
really nicely on s390 for me: no duplicate zexts and one less check
that the JIT needs to do.

[1]
https://lore.kernel.org/bpf/20210224141837.104654-1-iii@linux.ibm.com/

