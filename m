Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3368F4AE39C
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387270AbiBHWXH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386232AbiBHTq4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 14:46:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98CEC0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 11:46:55 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218IVDiR012124;
        Tue, 8 Feb 2022 19:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DPrYtdyvSHnLSr7PTJRfH3pHlVYWvzxLKZJN1+H6bqw=;
 b=cJqhxE2uakMTlpnhKT25M/rJrTJwl0l/5xRzwYEOFOjk+UTwEj7NuOmHr8CHzAiVW4q8
 Gc464Abovb9kvF7bvgPZryD8eqLb6h7p1/qeDKIvBPIap1P3V3e1kUN67nxtWF3gCeU6
 JeLcN2FbslTk2UBi0NObTA4t4s07zQBQj5jeIwWIZoM2ZbdjS1j0Nu1ToS0drhvSYvdn
 zWOJIMCseHX92Rlyhkl6Bp/26cp7chBQDfkQEgkvG6lvg15moBqmKyT2FZoFNKR6Js9H
 kqqkRV5QTS2wr02eNHlIy8I0i7ct2jov+Zjjr+756kL7TfKnxv71hMN0f80yF29bu6jU ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22kr3mpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 19:46:31 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 218JgQPs017043;
        Tue, 8 Feb 2022 19:46:31 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22kr3mpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 19:46:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 218Jd2ej008386;
        Tue, 8 Feb 2022 19:46:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv98w0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 19:46:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 218JkQOI43516226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 19:46:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 049934C063;
        Tue,  8 Feb 2022 19:46:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C2114C058;
        Tue,  8 Feb 2022 19:46:25 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 19:46:25 +0000 (GMT)
Message-ID: <bb17e7657ada2577664caa6d0b9fbfcabf2f1676.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v4 14/14] arm64: add a comment that warns that
 orig_x0 should not be moved
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org
Date:   Tue, 08 Feb 2022 20:46:25 +0100
In-Reply-To: <20220208192522.risaxa7debgxx5kz@ast-mbp.dhcp.thefacebook.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
         <20220208051635.2160304-15-iii@linux.ibm.com>
         <20220208192522.risaxa7debgxx5kz@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x_cWQCSb6tSTJnGEFKM6D7O6vkbAjBdB
X-Proofpoint-ORIG-GUID: z3SOw7woLEnnQr1isjpFC6daJyS-OAA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=906 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-02-08 at 11:25 -0800, Alexei Starovoitov wrote:
> On Tue, Feb 08, 2022 at 06:16:35AM +0100, Ilya Leoshkevich wrote:
> > orig_x0's location is used by libbpf tracing macros, therefore it
> > should not be moved.
> > 
> > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/ptrace.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/ptrace.h
> > b/arch/arm64/include/asm/ptrace.h
> > index 41b332c054ab..7e34c3737839 100644
> > --- a/arch/arm64/include/asm/ptrace.h
> > +++ b/arch/arm64/include/asm/ptrace.h
> > @@ -185,6 +185,10 @@ struct pt_regs {
> >                         u64 pstate;
> >                 };
> >         };
> > +       /*
> > +        * orig_x0 is not exposed via struct user_pt_regs, but its
> > location is
> > +        * assumed by libbpf's tracing macros, so it should not be
> > moved.
> > +        */
> 
> In other words this comment is saying that the layout is ABI.
> That's not the case. orig_x0 here and equivalent on s390 can be
> moved.
> It will break bpf progs written without CO-RE and that is expected.
> Non CO-RE programs often do all kinds of bpf_probe_read_kernel and
> will be breaking when kernel layout is changing.
> I suggest to drop this patch and patch 12.

Yeah, that was the intention here: to promote orig_x0 to ABI using a
comment, since doing this by extending user_pt_regs turned out to be
infeasible. I'm actually ok with not doing this, since programs
compiled with kernel headers and using CO-RE macros will be fine.

As you say, we don't care about programs that don't use CO-RE too much
here - if they break after an incompatible kernel change, fine.

The question now is - how much do we care about programs that are
compiled with userspace headers? Andrii suggested to use offsetofend to
make syscall macros work there, however, this now requires this ABI
promotion.
