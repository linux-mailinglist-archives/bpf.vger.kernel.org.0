Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63894A76C3
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 18:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346233AbiBBRYG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 12:24:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242514AbiBBRYF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 12:24:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212G9RV5005556;
        Wed, 2 Feb 2022 17:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YQRd1n7D19Pla7pR9sgiFwk8F3n9N/G7Kf+lPy9Z4mc=;
 b=QK5K89NSItnP34g5b4Ed5JHHYBcgi1C4Fg6ZC/5KjlNZK4MjcxadNnMCU6lm9vCbebIR
 U0hRiwAikvxUL1EqbpjfTIm+7zI8p9qW8qgGNmwclF/FoqXtPDVEvWWRq7rWVhXPHbDi
 l8glq8DQBX87IdubGTi2ZTSRbosB2NOHblMwC2JdRvLTbzQyvQLbRNIjay8RWN0eWoJI
 n21QuEcYz+brdEH9dQmj/b3jQTDuhK9uVtHVzrMR7EuymQ0U+evy47LllMXAp/GWDq2u
 NsRzkvUgNdA/YiiZyjWWKzKszTh2dRYFC7tYL+eA93imM9I3bMe3MUW258Hkad31E7B2 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyu4uvppj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 17:23:52 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212HEgKk019230;
        Wed, 2 Feb 2022 17:23:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyu4uvpnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 17:23:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212HIO0E011601;
        Wed, 2 Feb 2022 17:23:50 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3dvvujqd1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 17:23:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212HNleg32113056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 17:23:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DFCAAE057;
        Wed,  2 Feb 2022 17:23:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B91E4AE04D;
        Wed,  2 Feb 2022 17:23:46 +0000 (GMT)
Received: from [9.171.36.117] (unknown [9.171.36.117])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 17:23:46 +0000 (GMT)
Message-ID: <011a6988-39a6-66ca-fccd-6fa0852ed599@linux.ibm.com>
Date:   Wed, 2 Feb 2022 18:23:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next 1/3] s390/bpf: Add orig_gpr2 to user_pt_regs
Content-Language: en-US
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
 <20220201234200.1836443-2-iii@linux.ibm.com>
 <your-ad-here.call-01643811544-ext-7630@work.hours>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <your-ad-here.call-01643811544-ext-7630@work.hours>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ayS1xDRu9CA1DtEOHx5Rd7rkQ7EXQ8m2
X-Proofpoint-GUID: KHNTDujK1N7fPH9tWJO78HgWy4LIMUMf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_08,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020095
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Am 02.02.22 um 15:19 schrieb Vasily Gorbik:
> On Wed, Feb 02, 2022 at 12:41:58AM +0100, Ilya Leoshkevich wrote:
>> user_pt_regs is used by eBPF in order to access userspace registers -
>> see commit 466698e654e8 ("s390/bpf: correct broken uapi for
>> BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
>> syscall argument from eBPF programs, we need to export orig_gpr2.
> 
>> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
>> index 4ffa8e7f0ed3..c8698e643904 100644
>> --- a/arch/s390/include/asm/ptrace.h
>> +++ b/arch/s390/include/asm/ptrace.h
>> @@ -83,9 +83,9 @@ struct pt_regs {
>>   			unsigned long args[1];
>>   			psw_t psw;
>>   			unsigned long gprs[NUM_GPRS];
>> +			unsigned long orig_gpr2;
>>   		};
>>   	};
>> -	unsigned long orig_gpr2;
>>   	union {
>>   		struct {
>>   			unsigned int int_code;
>> diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
>> index ad64d673b5e6..b3dec603f507 100644
>> --- a/arch/s390/include/uapi/asm/ptrace.h
>> +++ b/arch/s390/include/uapi/asm/ptrace.h
>> @@ -295,6 +295,7 @@ typedef struct {
>>   	unsigned long args[1];
>>   	psw_t psw;
>>   	unsigned long gprs[NUM_GPRS];
>> +	unsigned long orig_gpr2;
>>   } user_pt_regs;
> 
> It could be a good opportunity to get rid of that "args[1]" which is not
> used for syscall parameters handling since commit baa071588c3f ("[S390]
> cleanup system call parameter setup") [v2.6.37], as well as completely
> unused now, and shouldn't really be exported to eBPF. And luckily eBPF
> never used it.
> 
> So, how about reusing "args[1]" slot for orig_gpr2 instead?

Since this is uapi we certainly have to careful. Reusing this could be ok, though.
