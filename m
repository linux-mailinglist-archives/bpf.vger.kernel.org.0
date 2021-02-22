Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A9321BE2
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 16:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBVPxS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 10:53:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230491AbhBVPxR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 10:53:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MFmdXx139929;
        Mon, 22 Feb 2021 10:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xPUHws47f1V4+Ga64TDyL24nyol1RiqCpVJXf6jsOhY=;
 b=n/Zuqj9qsgg2zm16JUrrbJBjfv7H+FJ8uihGk4zwmweEDVVG/BpiTE2fOlTiYnn5+Wkc
 KuPTgPpm9kWO2Y4Vbs/eGE7iwubfBALOtN6HrOaxWICUCrI6KZtLem1Dp4uj+mLbyD2c
 jGODEK/K8cpsZjhcuWiHU1a52sMPnBzpfoXOa06XOAfJBjXPWuNnv1Jhi+MYzJ2Hz7aT
 CrRCQ3zDuDyGq6Ah+WU5kbVPu7NyU5CrDjVTMy9Thz4YlB4J6NejetE6MVqMCosZwfK5
 yhety+afaA0pB4amEbwCWZal1aH5gg7kZWFK1YLlUyxUMP3hFUGt2M4OhI334RbDlGvG /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vfk0r7nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 10:52:15 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MFmgbX140302;
        Mon, 22 Feb 2021 10:51:59 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vfk0r76q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 10:51:59 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MFmIvm018761;
        Mon, 22 Feb 2021 15:51:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 36tsph1sxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 15:51:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MFpj3Q25821486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 15:51:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56C7211C04C;
        Mon, 22 Feb 2021 15:51:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E17D411C054;
        Mon, 22 Feb 2021 15:51:44 +0000 (GMT)
Received: from sig-9-145-151-190.de.ibm.com (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 15:51:44 +0000 (GMT)
Message-ID: <1b80764894c342a2bc8bf2e61103b6d7be3be6eb.camel@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>
Date:   Mon, 22 Feb 2021 16:51:44 +0100
In-Reply-To: <CA+i-1C0JFW4qyN4XNhG-sX-rspmbTaV2g_eYNjtnjg8WB=XUEQ@mail.gmail.com>
References: <20210217092831.2366396-1-jackmanb@google.com>
         <c20a494cfeb112093dcefe45838c63f62d781621.camel@linux.ibm.com>
         <CACYkzJ4DAzE1QZ9aioi6rAu9zZdNBa6rJ+FapZMXzwqDb5pehA@mail.gmail.com>
         <CA+i-1C0JFW4qyN4XNhG-sX-rspmbTaV2g_eYNjtnjg8WB=XUEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_03:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220142
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-02-22 at 16:06 +0100, Brendan Jackman wrote:
> On Thu, 18 Feb 2021 at 00:12, KP Singh <kpsingh@kernel.org> wrote:
> > 
> > On Wed, Feb 17, 2021 at 7:30 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > > 
> > > On Wed, 2021-02-17 at 09:28 +0000, Brendan Jackman wrote:
> > > > As pointed out by Ilya and explained in the new comment, there's
> > > > a
> > > > discrepancy between x86 and BPF CMPXCHG semantics: BPF always
> > > > loads
> > > > the value from memory into r0, while x86 only does so when r0 and
> > > > the
> > > > value in memory are different. The same issue affects s390.
> > > > 
> > > > At first this might sound like pure semantics, but it makes a
> > > > real
> > > > difference when the comparison is 32-bit, since the load will
> > > > zero-extend r0/rax.
> > > > 
> > > > The fix is to explicitly zero-extend rax after doing such a
> > > > CMPXCHG. Since this problem affects multiple archs, this is done
> > > > in
> > > > the verifier by patching in a BPF_ZEXT_REG instruction after
> > > > every
> > > > 32-bit cmpxchg. Any archs that don't need such manual zero-
> > > > extension
> > > > can do a look-ahead with insn_is_zext to skip the unnecessary
> > > > mov.
> > > > 
> > > > Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > Fixes: 5ffa25502b5a ("bpf: Add instructions for
> > > > atomic_[cmp]xchg")
> > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > ---
> > > > 
> > > > Differences v2->v3[1]:
> > > >  - Moved patching into fixup_bpf_calls (patch incoming to rename
> > > > this
> > > > function)
> > > >  - Added extra commentary on bpf_jit_needs_zext
> > > >  - Added check to avoid adding a pointless zext(r0) if there's
> > > > already one there.
> > > > 
> > > > Difference v1->v2[1]: Now solved centrally in the verifier
> > > > instead of
> > > >   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> > > > suggestions!
> > > > 
> > > > [1] v2:
> > > > https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> > > >     v1:
> > > > https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> > > > 
> > > >  kernel/bpf/core.c                             |  4 +++
> > > >  kernel/bpf/verifier.c                         | 26
> > > > +++++++++++++++++++
> > > >  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25
> > > > ++++++++++++++++++
> > > >  .../selftests/bpf/verifier/atomic_or.c        | 26
> > > > +++++++++++++++++++
> > > >  4 files changed, 81 insertions(+)
> > > 
> > > [...]
> > > 
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 16ba43352a5f..a0d19be13558 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -11662,6 +11662,32 @@ static int fixup_bpf_calls(struct
> > > > bpf_verifier_env *env)
> > > >                         continue;
> > > >                 }
> > > > 
> > > > +               /* BPF_CMPXCHG always loads a value into R0,
> > > > therefore always
> > > > +                * zero-extends. However some archs' equivalent
> > > > instruction only
> > > > +                * does this load when the comparison is
> > > > successful.
> > > > So here we
> > > > +                * add a BPF_ZEXT_REG after every 32-bit CMPXCHG,
> > > > so
> > > > that such
> > > > +                * archs' JITs don't need to deal with the issue.
> > > > Archs that
> > > > +                * don't face this issue may use insn_is_zext to
> > > > detect and skip
> > > > +                * the added instruction.
> > > > +                */
> > > > +               if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC)
> > > > &&
> > > > insn->imm == BPF_CMPXCHG) {
> > > > +                       struct bpf_insn zext_patch[2] = { [1] =
> > > > BPF_ZEXT_REG(BPF_REG_0) };
> > > > +
> > > > +                       if (!memcmp(&insn[1], &zext_patch[1],
> > > > sizeof(struct bpf_insn)))
> > > > +                               /* Probably done by
> > > > opt_subreg_zext_lo32_rnd_hi32. */
> > > > +                               continue;
> > > > +
> > > 
> > > Isn't opt_subreg_zext_lo32_rnd_hi32() called after
> > > fixup_bpf_calls()?
> > 
> > Indeed, this check should not be needed.
> 
> Ah yep, right. Do you folks think I should keep the optimisation (i.e.
> move this memcmp into opt_subreg_zext_lo32_rnd_hi32)? It feels like a
> bit of a toss-up to me.

It would be good to have this on s390. In "BPF_W cmpxchg should zero
top 32 bits", for example, I get:

   7: (c3) r0 = atomic_cmpxchg((u32 *)(r10 -8), r0, r1)
   8: (bc) w0 = w0
   9: (bc) w0 = w0

With the following adjustment (only briefly tested: survives 
test_verifier on s390):

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11677,8 +11677,9 @@ static int fixup_bpf_calls(struct
bpf_verifier_env *env)
                if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) &&
insn->imm == BPF_CMPXCHG) {
                        struct bpf_insn zext_patch[2] = { [1] =
BPF_ZEXT_REG(BPF_REG_0) };
 
-                       if (!memcmp(&insn[1], &zext_patch[1],
sizeof(struct bpf_insn)))
-                               /* Probably done by
opt_subreg_zext_lo32_rnd_hi32. */
+                       aux = &env->insn_aux_data[i + delta];
+                       if (aux->zext_dst && bpf_jit_needs_zext())
+                               /* Will be done by
opt_subreg_zext_lo32_rnd_hi32(). */
                                continue;
 
                        zext_patch[0] = *insn;

it becomes:

   7: (c3) r0 = atomic_cmpxchg((u32 *)(r10 -8), r0, r1)
   8: (bc) w0 = w0

Moving the check to opt_subreg_zext_lo32_rnd_hi32() is also an option;
I don't know which of the two is a better choice.

