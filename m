Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A39827D77F
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 22:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgI2UD0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 16:03:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23864 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727700AbgI2UD0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 16:03:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TK1Xb2166016;
        Tue, 29 Sep 2020 16:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jUqhaEOTusjiDIkP5J/K/PXNNsYfgXfIfdwf0UJ/6Gw=;
 b=k+lo75/eWS7yi0i4xLXI9x3+PWp0+s/pZ1OGxIK33XzI4dX8HfFsVEeRJZ35NbMwX8tr
 rYPU2gDj6jmR+3m+DsIzFaZq5V6FvFssW/KpT4AX65MEmrgNoxYVszExga0lm1Sjwq/H
 BkBFE/unL75xbPXbGJiVhYGPYYosZdgFvwiUfgK1lwPKhcsP/9gvx1O5QTpmULJWjeB1
 aKJEXf4VuRTZwp1X0Kn8897RRVRz/ihbbnAiv1XbrWIsfXghbUhep1ELgitJKWU2VkfQ
 y3bqsulCg2VCKY7ZrpaajZqYVAZp40eDlEzbNnrzq2tSOcigMAkDPcfCHE4zlkJDtqpA 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vbjhg326-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 16:03:12 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08TK1h0w166648;
        Tue, 29 Sep 2020 16:03:11 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vbjhg317-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 16:03:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TJvPmX001871;
        Tue, 29 Sep 2020 20:03:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 33sw983pea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 20:03:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TK37tM32243998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 20:03:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6616252052;
        Tue, 29 Sep 2020 20:03:07 +0000 (GMT)
Received: from sig-9-145-92-232.uk.ibm.com (unknown [9.145.92.232])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 074B15204E;
        Tue, 29 Sep 2020 20:03:06 +0000 (GMT)
Message-ID: <2f343b2d318ac7b6da5857f005ee28e9c1e6e34a.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 5/5] bpf: Do not include the original insn
 in zext patchlet
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Tue, 29 Sep 2020 22:03:06 +0200
In-Reply-To: <2b84f5c397ca43c5883f6e10c6e3a232b511d893.camel@linux.ibm.com>
References: <20200909233439.3100292-1-iii@linux.ibm.com>
         <20200909233439.3100292-6-iii@linux.ibm.com>
         <CAADnVQ+2RPKcftZw8d+B1UwB35cpBhpF5u3OocNh90D9pETPwg@mail.gmail.com>
         <2b84f5c397ca43c5883f6e10c6e3a232b511d893.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_13:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=910 malwarescore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290163
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-09-11 at 14:58 +0200, Ilya Leoshkevich wrote:
> On Thu, 2020-09-10 at 17:25 -0700, Alexei Starovoitov wrote:
> > On Wed, Sep 9, 2020 at 4:37 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > > If the original insn is a jump, then it is not subjected to
> > > branch
> > > adjustment, which is incorrect. As discovered by Yauheni in
> > 
> > I think the problem is elsewhere.
> > Something is wrong with zext logic.
> > the branch insn should not have been marked as zext_dst.
> > and in the line:
> > zext_patch[0] = insn;
> > this 'insn' should never be a branch.
> > See insn_no_def().
> 
> Would it make sense to add a WARN_ON(insn_no_def(&insn)) there?
> 
> 
> I believe the root cause is triggered by clear_caller_saved_regs().
> 
> This is our prog:
> 
> [     0]: BPF_JMP | BPF_CALL | BPF_K, BPF_REG_0, BPF_REG_1, 0x0, 0x1
> [     1]: BPF_JMP | BPF_EXIT | BPF_K, BPF_REG_0, BPF_REG_0, 0x0, 0x0
> [     2]: BPF_JMP | BPF_CALL | BPF_K, BPF_REG_0, BPF_REG_1, 0x0, 0x1
> [     3]: BPF_JMP | BPF_EXIT | BPF_K, BPF_REG_0, BPF_REG_0, 0x0, 0x0
> ...
> 
> and env->insn_idx is 2. clear_caller_saved_regs() calls
> 
> 	check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> 
> for register 0, and then inside check_reg_arg() we come to
> 
> 	reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx + 1;
> 
> where rw64 is false, because insn 2 is a BPF_PSEUDO_CALL. Having
> non-zero subreg_def causes mark_insn_zext() to set zext_dst later on.
> 
> Maybe mark_reg_unknown() can do something to prevent this? My knee-
> jerk
> reaction would be to set subreg_def to 0 there, but I'm not sure
> whether this would be correct.

Another possible fix (inspired by helper function call handling) is:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4751,6 +4751,7 @@ static int check_func_call(struct
bpf_verifier_env *env, struct bpf_insn *insn,
 
                        /* All global functions return SCALAR_VALUE */
                        mark_reg_unknown(env, caller->regs, BPF_REG_0);
+                       caller->regs[BPF_REG_0].subreg_def =
DEF_NOT_SUBREG;
 
                        /* continue with next insn after call */
                        return 0;

This relies on global functions always returning 64-bit values, which
I believe should always be the case.

If this sounds reasonable, I can send a proper patch.

