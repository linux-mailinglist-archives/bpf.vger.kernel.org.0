Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D76925E117
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgIDRlS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 13:41:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727938AbgIDRlJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Sep 2020 13:41:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084HVuD9192302;
        Fri, 4 Sep 2020 13:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XB3w9mxehQVk5XKAaxbFKucOSd20Lrz7GGvyrKY3C/Q=;
 b=BVz84S5OtfvUmTy00F81ZOVG1teFbAtp2yrvzjv1cg8mGz7tk1wXFiXWuL1DD9y10K21
 4LU3To8shAJJsxCJ5ZKuMDukDr1nRHTZQ7uKoRBhoefI05f44rhN3uwdowc6jh2Fpb0T
 8aIbIMhW2+mhFYTcT4+5AVhTo2F+ti20vMBZa3cINZOPnkEjsjMxogz4w4YbIQ5Ges3q
 MY/jOb7xbLcSI13V8FSRhLIobKbne29Ny5kfcvaq+tMI/lRdVe6vvelqpOWcvDoh+rC9
 b8t2qTeAJQkimhhl+ZvKYPFsv6Ff3+gM0iOJ2YKpmNUJxHQFRYYM58VOqdHD8cC0eofm 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bsb7sc8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 13:40:40 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 084HVvLa192554;
        Fri, 4 Sep 2020 13:40:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bsb7sc7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 13:40:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 084HcAxp012905;
        Fri, 4 Sep 2020 17:40:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 337en874e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 17:40:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 084Hd3n5393936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Sep 2020 17:39:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C01911C058;
        Fri,  4 Sep 2020 17:40:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBBB911C052;
        Fri,  4 Sep 2020 17:40:34 +0000 (GMT)
Received: from sig-9-145-16-19.uk.ibm.com (unknown [9.145.16.19])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Sep 2020 17:40:34 +0000 (GMT)
Message-ID: <17838beb91c983ae586bea035475e787fb095a56.camel@linux.ibm.com>
Subject: Re: [PATCH RFC] bpf: update current instruction on patching
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        bpf@vger.kernel.org
Cc:     jolsa@redhat.com, Jakub Kicinski <kuba@kernel.org>
Date:   Fri, 04 Sep 2020 19:40:34 +0200
In-Reply-To: <a38c5d977acb6c036bfeddfc6784a0fe58c29b80.camel@linux.ibm.com>
References: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
         <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net>
         <a38c5d977acb6c036bfeddfc6784a0fe58c29b80.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_11:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=3 spamscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040147
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-09-04 at 17:17 +0200, Ilya Leoshkevich wrote:
> On Thu, 2020-09-03 at 17:10 +0200, Daniel Borkmann wrote:
> > On 9/3/20 4:05 PM, Yauheni Kaliuta wrote:
> > > On code patching it may require to update branch destinations if
> > > the
> > > code size changed. bpf_adj_delta_to_imm/off increments offset
> > > only
> > > if the patched area is after the branch instruction. But it's
> > > possible, that the patched area itself is a branch instruction
> > > and
> > > requires destination update.
> > 
> > Could you provide a concrete example and walk us through? I'm
> > probably
> > missing something but if the patchlet contains a branch
> > instruction,
> > then
> > it should be 'self-contained'. In the sense that the patchlet is a
> > 'black
> > box' that replaces 1 insns with n insns but there is no awareness
> > what's
> > inside these insns and hence no fixup for that inside
> > bpf_patch_insn_data().
> > So, if we take an existing branch insns from the code, move it into
> > the
> > patchlet and extend beginning or end, then it feels more like a bug
> > to the
> > one that called bpf_patch_insn_data(), aka zext code here. Bit
> > puzzled why
> > this is only seen now, my impression was that Ilya was running
> > s390x
> > the
> > BPF selftests quite recently?
> > 
> > > The problem was triggered by bpf selftest
> > > 
> > > test_progs -t global_funcs
> > > 
> > > on s390, where the very first "call" instruction is patched from
> > > verifier.c:opt_subreg_zext_lo32_rnd_hi32() with zext_patch.
> > > 
> > > The patch includes current instruction to the condition check.
> > > 
> > > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > > ---
> > >   kernel/bpf/core.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index ed0b3578867c..b0a9a22491a5 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -340,7 +340,7 @@ static int bpf_adj_delta_to_imm(struct
> > > bpf_insn
> > > *insn, u32 pos, s32 end_old,
> > >   	s32 delta = end_new - end_old;
> > >   	s64 imm = insn->imm;
> > >   
> > > -	if (curr < pos && curr + imm + 1 >= end_old)
> > > +	if (curr <= pos && curr + imm + 1 >= end_old)
> > >   		imm += delta;
> > >   	else if (curr >= end_new && curr + imm + 1 < end_new)
> > >   		imm -= delta;
> > > @@ -358,7 +358,7 @@ static int bpf_adj_delta_to_off(struct
> > > bpf_insn
> > > *insn, u32 pos, s32 end_old,
> > >   	s32 delta = end_new - end_old;
> > >   	s32 off = insn->off;
> > >   
> > > -	if (curr < pos && curr + off + 1 >= end_old)
> > > +	if (curr <= pos && curr + off + 1 >= end_old)
> > >   		off += delta;
> > >   	else if (curr >= end_new && curr + off + 1 < end_new)
> > >   		off -= delta;
> > > 
> 
> Hi!
> 
> Last time I ran selftests against bpf-next ~1 month ago, and I don't
> remember seeing any test_progs failures. Now I tried it again, and I
> see the same problem as Yauheni. So this must be relatively new -
> I'll
> try to bisect the commit that caused this.

Turns out it has been failing for quite some time. I stopped at

commit 23ad04669f81f958e9a4121b0266228d2eb3c357 (HEAD)
Author: Matteo Croce <mcroce@redhat.com>
Date:   Mon May 11 13:32:34 2020 +0200

    samples: bpf: Fix build error

because I can't build earlier commits on my new Debian 10 VM due to
linker errors. The asm in the failing test is quite simple, so it's
unlikely that LLVM ouput has changed in the meantime. So I must have
simply missed it. Sorry!

I'll double check whether there have been more unnoticed failures.

