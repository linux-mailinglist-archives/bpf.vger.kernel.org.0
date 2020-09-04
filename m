Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49F225DD07
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgIDPSI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 11:18:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17142 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729942AbgIDPSI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Sep 2020 11:18:08 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084F2CT9133804;
        Fri, 4 Sep 2020 11:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DkIx5un8dmmC2AixxyorDisomuNuJIxtGAZLMTmL6Z0=;
 b=X8Kk3HD533WGAcAUcyoLLtaI8YggYr9NKulFRsRCK/iQCZb46CXskPm4L6gjGsnsK8+8
 9lJ8klRZ9PF5v5+M60hUP+RZuD7MFxBOLugejv+ICDNABXnIrGdZt1ygZ5ItQwEt/cKi
 GxHCbGvCBaN0oawAFgbpkE805ayHZ4ggglg7Is7vUIcAEuEqdofXEgto7KUJERjlV/Iq
 E/yPLY23sdvj0Zp+dnTXE2bLLI/jHM1FFWRuVcxQMAchtef+M0uE15JAFQacDuydsTfa
 KYa07yyzsJhof78HTWkmrXGyGc88EOGrvTaIs8Jd9ArQbF46A2MKvIAqtfYQ7zmxCyCP XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bqebh750-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 11:17:55 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 084F2cm4135382;
        Fri, 4 Sep 2020 11:17:54 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bqebh74a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 11:17:54 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 084F1hSt032612;
        Fri, 4 Sep 2020 15:17:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33bpfy02sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 15:17:52 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 084FHo8237552512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Sep 2020 15:17:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 865E311C04A;
        Fri,  4 Sep 2020 15:17:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A0E111C052;
        Fri,  4 Sep 2020 15:17:50 +0000 (GMT)
Received: from sig-9-145-16-19.uk.ibm.com (unknown [9.145.16.19])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Sep 2020 15:17:50 +0000 (GMT)
Message-ID: <a38c5d977acb6c036bfeddfc6784a0fe58c29b80.camel@linux.ibm.com>
Subject: Re: [PATCH RFC] bpf: update current instruction on patching
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        bpf@vger.kernel.org
Cc:     jolsa@redhat.com, Jakub Kicinski <kuba@kernel.org>
Date:   Fri, 04 Sep 2020 17:17:49 +0200
In-Reply-To: <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net>
References: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
         <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_07:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040130
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-09-03 at 17:10 +0200, Daniel Borkmann wrote:
> On 9/3/20 4:05 PM, Yauheni Kaliuta wrote:
> > On code patching it may require to update branch destinations if
> > the
> > code size changed. bpf_adj_delta_to_imm/off increments offset only
> > if the patched area is after the branch instruction. But it's
> > possible, that the patched area itself is a branch instruction and
> > requires destination update.
> 
> Could you provide a concrete example and walk us through? I'm
> probably
> missing something but if the patchlet contains a branch instruction,
> then
> it should be 'self-contained'. In the sense that the patchlet is a
> 'black
> box' that replaces 1 insns with n insns but there is no awareness
> what's
> inside these insns and hence no fixup for that inside
> bpf_patch_insn_data().
> So, if we take an existing branch insns from the code, move it into
> the
> patchlet and extend beginning or end, then it feels more like a bug
> to the
> one that called bpf_patch_insn_data(), aka zext code here. Bit
> puzzled why
> this is only seen now, my impression was that Ilya was running s390x
> the
> BPF selftests quite recently?
> 
> > The problem was triggered by bpf selftest
> > 
> > test_progs -t global_funcs
> > 
> > on s390, where the very first "call" instruction is patched from
> > verifier.c:opt_subreg_zext_lo32_rnd_hi32() with zext_patch.
> > 
> > The patch includes current instruction to the condition check.
> > 
> > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > ---
> >   kernel/bpf/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ed0b3578867c..b0a9a22491a5 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -340,7 +340,7 @@ static int bpf_adj_delta_to_imm(struct bpf_insn
> > *insn, u32 pos, s32 end_old,
> >   	s32 delta = end_new - end_old;
> >   	s64 imm = insn->imm;
> >   
> > -	if (curr < pos && curr + imm + 1 >= end_old)
> > +	if (curr <= pos && curr + imm + 1 >= end_old)
> >   		imm += delta;
> >   	else if (curr >= end_new && curr + imm + 1 < end_new)
> >   		imm -= delta;
> > @@ -358,7 +358,7 @@ static int bpf_adj_delta_to_off(struct bpf_insn
> > *insn, u32 pos, s32 end_old,
> >   	s32 delta = end_new - end_old;
> >   	s32 off = insn->off;
> >   
> > -	if (curr < pos && curr + off + 1 >= end_old)
> > +	if (curr <= pos && curr + off + 1 >= end_old)
> >   		off += delta;
> >   	else if (curr >= end_new && curr + off + 1 < end_new)
> >   		off -= delta;
> > 

Hi!

Last time I ran selftests against bpf-next ~1 month ago, and I don't
remember seeing any test_progs failures. Now I tried it again, and I
see the same problem as Yauheni. So this must be relatively new - I'll
try to bisect the commit that caused this.

Best regards,
Ilya

