Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D27324117
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBXPkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 10:40:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233093AbhBXORn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 09:17:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OE2Ubg196516;
        Wed, 24 Feb 2021 09:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7Y8ISWcfeZPY4DuFv/0yz4G/bLzoETD13B1Fdn+Tfgc=;
 b=jvC/HsWX9FCnPTee/WnHIwYSkz6XgEmrxES5Dv3JkKxhTKiiPPK5Z283iicgshBqwXE8
 XUeN1C+3+UJG//Qog0sYtag194ahcsUD7fg+n1P2Fkq6lgtFvh+OD+Hitd9uCY6FyKYz
 CvoY8POQZa4b5TjnqI67SJ6GbN6rdQaudVPhcAW1p+rT8Z0wNiDNKH95m4wp+/Z9B45w
 hQYnHdXPZwNGt3sCkddaLPvpwT9RBDAnx8jyCeZKBYZzMi+C5F36S8sFGxPjJ/U8tDQs
 C4smxrCYtFiLiJ+DlHlbb1m8Bcn1vbMEVj8wPuECts7J53W2LJEwy8uzF5uF7Nl8mPmz Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36wmabsk5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 09:16:24 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OE2qC9002046;
        Wed, 24 Feb 2021 09:16:23 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36wmabsk4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 09:16:23 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OE8QuM000396;
        Wed, 24 Feb 2021 14:16:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 36tsph9wej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 14:16:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OEGJDM51315096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 14:16:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7AE7A4051;
        Wed, 24 Feb 2021 14:16:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EF9CA4055;
        Wed, 24 Feb 2021 14:16:19 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 14:16:19 +0000 (GMT)
Message-ID: <3652fb931ee58813f083c9722223b89b56a2a1c0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Date:   Wed, 24 Feb 2021 15:16:18 +0100
In-Reply-To: <20210223150845.1857620-1-jackmanb@google.com>
References: <20210223150845.1857620-1-jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_04:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240109
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

I think I managed to figure out what is wrong with
adjust_insn_aux_data(): insn_has_def32() does not know about BPF_FETCH.
I'll post a fix shortly; in the meantime, based on my debugging
experience and on looking at the code for a while, I have a few
comments regarding the patch.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d34ba492d46..ec1cbd565140 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11061,8 +11061,16 @@ static int
> opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>                          */
>                         if (WARN_ON(!(insn.imm & BPF_FETCH)))
>                                 return -EINVAL;
> -                       load_reg = insn.imm == BPF_CMPXCHG ?
> BPF_REG_0
> -                                                          :
> insn.src_reg;
> +                       /* There should already be a zero-extension
> inserted after BPF_CMPXCHG. */
> +                       if (insn.imm == BPF_CMPXCHG) {
> +                               struct bpf_insn *next =
> &insns[adj_idx + 1];

Would it make sense to check bounds here? Not sure whether the
verification process might come that far with the last instruction
being cmpxchg and not ret, but still..

> +
> +                               if (WARN_ON(!insn_is_zext(next) ||
> next->dst_reg != insn.src_reg))

We generate BPF_ZEXT_REG(BPF_REG_0), so we should probably use
BPF_REG_0 instead of insn.src_reg here.

> +                                       return -EINVAL;
> +                               continue;

I think we need i++ before continue, otherwise we would stumble upon
BPF_ZEXT_REG itself on the next iteration, and it is also marked with
zext_dst.

> +                       }
> +
> +                       load_reg = insn.src_reg;
>                 } else {
>                         load_reg = insn.dst_reg;
>                 }
> @@ -11666,6 +11674,27 @@ static int fixup_bpf_calls(struct
> bpf_verifier_env *env)
>                         continue;
>                 }
> 
> +               /* BPF_CMPXCHG always loads a value into R0,
> therefore always
> +                * zero-extends. However some archs' equivalent
> instruction only
> +                * does this load when the comparison is successful.
> So here we
> +                * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so
> that such
> +                * archs' JITs don't need to deal with the issue.
> Archs that
> +                * don't face this issue may use insn_is_zext to
> detect and skip
> +                * the added instruction.
> +                */
> +               if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) &&
> insn->imm == BPF_CMPXCHG) {

Since we want this only for JITs and not the interpreter, would it make
sense to check prog->jit_requested, like some other fragments of this
function do?

[...]

