Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362E84A93D8
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 07:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiBDGIi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 01:08:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53910 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232902AbiBDGIh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 01:08:37 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2144XxXb019263;
        Fri, 4 Feb 2022 06:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=EyV7MzVXbTnpbxkgIJpM77+NePo7XNIQRBgQAWyBHA0=;
 b=caWbBZNOnENeVcgTxAaGmFSphwpKQrnYO45gujumyE/ettSeWY0vc+6Lnc9lySxL97Ex
 S8UBKch3L3HU2WldlQfLfLHXi9sGMBdfe2h1kNPkaXC0kphsq7mGHxyxVIEjkpLPI52W
 mekiZt9QsDqBzkPnly+yYk4BNdcCjXzhh46/2433aJOjdOKjYUqHkhHR2B4T+DFm5PVJ
 FYdPcJqLJpZm5olf4wnUees3hTniu3S3OQaLXCNZg4w82aTykXYFlUBibNLZxgvGkuQu
 hr8o0qxXCuNYKTzjuiR5qpgtY+wOfxiEuAT1BQCjFoS+dGStFMhX6eckiPAnNhO0wJev 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0rj5dkmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 06:07:56 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2145k8O5016562;
        Fri, 4 Feb 2022 06:07:55 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0rj5dkkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 06:07:55 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21460lUG002216;
        Fri, 4 Feb 2022 06:07:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3e0r0n1jwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 06:07:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2145vr7E13828488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 05:57:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 816A9A4065;
        Fri,  4 Feb 2022 06:07:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1418CA4054;
        Fri,  4 Feb 2022 06:07:48 +0000 (GMT)
Received: from localhost (unknown [9.43.69.119])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 06:07:48 +0000 (GMT)
Date:   Fri, 04 Feb 2022 06:07:46 +0000
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
To:     Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        =?iso-8859-1?b?Qmr2cm4gVPZwZWw=?= <bjorn@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        bpf@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
        <20220201234200.1836443-2-iii@linux.ibm.com> <YfrmO+pcSqrrbC3E@osiris>
In-Reply-To: <YfrmO+pcSqrrbC3E@osiris>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1643952491.peuih6eln6.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dp3BBkmfGzzqzpy-WnsVmLxkEzrmhTr0
X-Proofpoint-GUID: _xPzUWjCdwjEWMPnRCCWYnof5PD8Tbkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_01,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=927 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040028
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Heiko,

Heiko Carstens wrote:
> On Wed, Feb 02, 2022 at 12:41:58AM +0100, Ilya Leoshkevich wrote:
>> user_pt_regs is used by eBPF in order to access userspace registers -
>> see commit 466698e654e8 ("s390/bpf: correct broken uapi for
>> BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
>> syscall argument from eBPF programs, we need to export orig_gpr2.
>>=20
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/ptrace.h      | 2 +-
>>  arch/s390/include/uapi/asm/ptrace.h | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptra=
ce.h
>> index 4ffa8e7f0ed3..c8698e643904 100644
>> --- a/arch/s390/include/asm/ptrace.h
>> +++ b/arch/s390/include/asm/ptrace.h
>> @@ -83,9 +83,9 @@ struct pt_regs {
>>  			unsigned long args[1];
>>  			psw_t psw;
>>  			unsigned long gprs[NUM_GPRS];
>> +			unsigned long orig_gpr2;
>>  		};
>>  	};
>> -	unsigned long orig_gpr2;
>>  	union {
>>  		struct {
>>  			unsigned int int_code;
>> diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uap=
i/asm/ptrace.h
>> index ad64d673b5e6..b3dec603f507 100644
>> --- a/arch/s390/include/uapi/asm/ptrace.h
>> +++ b/arch/s390/include/uapi/asm/ptrace.h
>> @@ -295,6 +295,7 @@ typedef struct {
>>  	unsigned long args[1];
>>  	psw_t psw;
>>  	unsigned long gprs[NUM_GPRS];
>> +	unsigned long orig_gpr2;
>>  } user_pt_regs;
>=20
> Isn't this broken on nearly all architectures? I just checked powerpc,
> arm64, and riscv. While powerpc seems to mirror pt_regs as user_pt_regs,
> and therefore exports orig_gpr3, the bpf macros still seem to access the
> wrong location to access the first syscall parameter(?).

On powerpc, gpr[3] continues to be valid on syscall entry (so this test=20
passes on powerpc), though orig_gpr3 will remain valid throughout.

I will submit a patch to use orig_gpr3 on powerpc.


Thanks!
- Naveen

