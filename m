Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3FE327F73
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhCAN1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 08:27:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235308AbhCAN1M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 08:27:12 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121D33ff071106;
        Mon, 1 Mar 2021 08:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3JeMhbo/jWXNNJQ9ehh5UaJkwTQtn8vA6PxTBdc1hfE=;
 b=XCyrxtJzLlKmbLC3bhiuBt+C7QaHCoYZPepE/TUdhjEnjjNnvfIc0S3s4gCHtcIOmNj3
 lR4w1/5nq+z2dyKtuhRHBJimQp4YNoyrVY1BpIXw0li06euWzeodbH3tfubHFHC9C7b+
 XywHjGz/4wgyZ0ylsm7gTN/tOqpwD8A/cQaS3rWSF8WlThSOtdHRjS1P9evF0iHYzlZ4
 norCMZayopoI2WVJp3naPRNMRnSeUC5uZmCnR/PuHOm2FdNz8nrGuD20JgzUud6MHTLk
 ZmXbUCBG6+UuNLErXwiR5J9fCguQccHoafpZWNDXpUI04HMYeDN4yKaTXc8gMJ/cHGlf 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3710ffhpcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 08:26:19 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 121D3oZi077683;
        Mon, 1 Mar 2021 08:26:19 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3710ffhpbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 08:26:18 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121DMgBY005093;
        Mon, 1 Mar 2021 13:26:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 36ydq8hxam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 13:26:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121DQErY20447660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 13:26:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C878A4060;
        Mon,  1 Mar 2021 13:26:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0B99A405B;
        Mon,  1 Mar 2021 13:26:13 +0000 (GMT)
Received: from sig-9-145-31-74.uk.ibm.com (unknown [9.145.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Mar 2021 13:26:13 +0000 (GMT)
Message-ID: <aabc55351862d0c1ea2ade0bedb3412ff0c6633e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 bpf] bpf: Account for BPF_FETCH in insn_has_def32()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Mon, 01 Mar 2021 14:26:13 +0100
In-Reply-To: <CA+i-1C1DxO+dvmCRWTLhD-XUiCFji=r7LwSgb7yHC5iLneLk9w@mail.gmail.com>
References: <20210226213131.118173-1-iii@linux.ibm.com>
         <CA+i-1C1DxO+dvmCRWTLhD-XUiCFji=r7LwSgb7yHC5iLneLk9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_06:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010108
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-03-01 at 12:02 +0100, Brendan Jackman wrote:
> On Fri, 26 Feb 2021 at 22:31, Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:

[...]

> > @@ -11006,9 +11026,10 @@ static int
> > opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
> >         for (i = 0; i < len; i++) {
> >                 int adj_idx = i + delta;
> >                 struct bpf_insn insn;
> > -               u8 load_reg;
> > +               int load_reg;
> > 
> >                 insn = insns[adj_idx];
> > +               load_reg = insn_def_regno(&insn);
> 
> Nit: Might as well save a line by squashing this into the
> declaration.

Will do.

[...]

> > @@ -11049,22 +11070,9 @@ static int
> > opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
> >                 if (!bpf_jit_needs_zext())
> >                         continue;
> > 
> > -               /* zext_dst means that we want to zero-extend
> > whatever register
> > -                * the insn defines, which is dst_reg most of the
> > time, with
> > -                * the notable exception of BPF_STX + BPF_ATOMIC +
> > BPF_FETCH.
> > -                */
> > -               if (BPF_CLASS(insn.code) == BPF_STX &&
> > -                   BPF_MODE(insn.code) == BPF_ATOMIC) {
> > -                       /* BPF_STX + BPF_ATOMIC insns without
> > BPF_FETCH do not
> > -                        * define any registers, therefore zext_dst
> > cannot be
> > -                        * set.
> > -                        */
> > -                       if (WARN_ON(!(insn.imm & BPF_FETCH)))
> > -                               return -EINVAL;
> > -                       load_reg = insn.imm == BPF_CMPXCHG ?
> > BPF_REG_0
> > -                                                          :
> > insn.src_reg;
> > -               } else {
> > -                       load_reg = insn.dst_reg;
> > +               if (WARN_ON_ONCE(load_reg == -1)) {
> > +                       verbose(env, "zext_dst is set, but no reg
> > is defined\n");
> 
> Let's add the string "verifier bug." to the beginning of this message
> (this is done elsewhere too). Hopefully the only person that ever
> sees
> this message would be someone who's hacking on the verifier, but even
> for them it could be a significant time-saver.

OK.

[...]

> Overall LGTM, thanks. It seems like without this patch, the cmpxchg
> test I added in [1] should fail on the s390 JIT, and this patch
> should
> fix it. Is that correct? If so could you add the test to this patch?
> (I guess you ought to paste in my Signed-off-by)
> 
> [1]  
> https://lore.kernel.org/bpf/44d680a0c40fc9dddf1b2bf4e78bd75b76dc4061.camel@linux.ibm.com/T/#mf6546406db03c6ca473a29cdf3bde7ddeeedf1a1

For this to work, my implementation of atomics needs to be merged
(and I haven't posted it yet). I propose to keep your tests in your
patch, merge this commit first, then your zext patch with tests, then
my atomics patch.

