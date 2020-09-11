Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE1266659
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgIKR0V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 13:26:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbgIKM7I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Sep 2020 08:59:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BCojmN131411;
        Fri, 11 Sep 2020 08:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IYEuItAi3wlJLQEvfcjRR1c2enzmHSxStOlUaJGsTw0=;
 b=Tx18GUKznzruk+f9dpN3OaWaJ+5yFhU3X0j+ChbzGp6R1aWoyIcP4ZvNregYqjIzPPOy
 +MfrmfjG1F79027ExcDYkIllab7cQ3A0ZKKTNMJeui4/leOTnfUfsYwQHMmq0zU0KUki
 VBmMzxcX8rijFcdVj3nPbprh9zcW44RasFGUVQ+uge8LrjrDXgJK+z5cIrnQU9bwEOt/
 1/9gMiJhi1R/vz8ESn8j/co4eyiEg/+PD1qRMIgVQXVbtNTIkEsjlng2DybMfpGkC0ap
 3MCOH6lYgKfi+lof8+fvBhDx843mCv7b950ZO+vw62QDsMi2uZn3v4HNDadPhYtcnj62 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33g9krr763-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 08:58:52 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BCornL131797;
        Fri, 11 Sep 2020 08:58:51 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33g9krr753-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 08:58:51 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BCh4Kd011326;
        Fri, 11 Sep 2020 12:58:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8f8fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 12:58:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BCwkpY25166080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 12:58:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36A6BA4057;
        Fri, 11 Sep 2020 12:58:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C39E3A4065;
        Fri, 11 Sep 2020 12:58:45 +0000 (GMT)
Received: from sig-9-145-5-224.uk.ibm.com (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 12:58:45 +0000 (GMT)
Message-ID: <2b84f5c397ca43c5883f6e10c6e3a232b511d893.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 5/5] bpf: Do not include the original insn
 in zext patchlet
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Fri, 11 Sep 2020 14:58:45 +0200
In-Reply-To: <CAADnVQ+2RPKcftZw8d+B1UwB35cpBhpF5u3OocNh90D9pETPwg@mail.gmail.com>
References: <20200909233439.3100292-1-iii@linux.ibm.com>
         <20200909233439.3100292-6-iii@linux.ibm.com>
         <CAADnVQ+2RPKcftZw8d+B1UwB35cpBhpF5u3OocNh90D9pETPwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_04:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 mlxlogscore=939 suspectscore=3 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110102
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-09-10 at 17:25 -0700, Alexei Starovoitov wrote:
> On Wed, Sep 9, 2020 at 4:37 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > If the original insn is a jump, then it is not subjected to branch
> > adjustment, which is incorrect. As discovered by Yauheni in
> 
> I think the problem is elsewhere.
> Something is wrong with zext logic.
> the branch insn should not have been marked as zext_dst.
> and in the line:
> zext_patch[0] = insn;
> this 'insn' should never be a branch.
> See insn_no_def().

Would it make sense to add a WARN_ON(insn_no_def(&insn)) there?


I believe the root cause is triggered by clear_caller_saved_regs().

This is our prog:

[     0]: BPF_JMP | BPF_CALL | BPF_K, BPF_REG_0, BPF_REG_1, 0x0, 0x1
[     1]: BPF_JMP | BPF_EXIT | BPF_K, BPF_REG_0, BPF_REG_0, 0x0, 0x0
[     2]: BPF_JMP | BPF_CALL | BPF_K, BPF_REG_0, BPF_REG_1, 0x0, 0x1
[     3]: BPF_JMP | BPF_EXIT | BPF_K, BPF_REG_0, BPF_REG_0, 0x0, 0x0
...

and env->insn_idx is 2. clear_caller_saved_regs() calls

	check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);

for register 0, and then inside check_reg_arg() we come to

	reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx + 1;

where rw64 is false, because insn 2 is a BPF_PSEUDO_CALL. Having
non-zero subreg_def causes mark_insn_zext() to set zext_dst later on.

Maybe mark_reg_unknown() can do something to prevent this? My knee-jerk
reaction would be to set subreg_def to 0 there, but I'm not sure
whether this would be correct.

