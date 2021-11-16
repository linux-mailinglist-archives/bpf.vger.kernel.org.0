Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1211E4535B1
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 16:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbhKPPZg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 10:25:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238272AbhKPPZ1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Nov 2021 10:25:27 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGF8VNf004354;
        Tue, 16 Nov 2021 15:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZlwSjdOa2ZugEmtyH2Nsm1uDnyQ7Qoyz+enJxDnJ/Hc=;
 b=oDJ7Jz9y5GatlBVs5y6GkrV0OcW7aCcoFx5OHVkDAENGF6djj3so6v4+4y9fprGwpn+O
 +np+CjGedEegh5QFrti04IuPun5yKlu6NgHS2On3V702cKOxSr8cPha0Y/o8ntWn8Qk9
 sE01ZOsexMR1UJVSpiqezw3m8nUt1GWc8L2ACADckEWBmRPaV4MDHzeXNHk8E99mlGrS
 HcjiMb58De+vcl9BH3iQJCxEPMvbFWbh2lvcM3vyqAF+kBPWlK9H9j099X70a0AREe7I
 NjC/AEJtxZ4xOKCA5vIOltdQV44/9J9wktRWlOT4afulJDRBjxDWzlvdNkS5c+3l0X0E 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ccdsdawx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 15:21:46 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AGFBcJN020599;
        Tue, 16 Nov 2021 15:21:45 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ccdsdawwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 15:21:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AGFF0ST025244;
        Tue, 16 Nov 2021 15:21:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3ca4mk0757-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 15:21:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AGFLeVi5440088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 15:21:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D4C9A404D;
        Tue, 16 Nov 2021 15:21:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A435A4053;
        Tue, 16 Nov 2021 15:21:36 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.25.142])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Nov 2021 15:21:35 +0000 (GMT)
Subject: Re: [PATCH] bpf: Enable bpf support for reading branch records in
 powerpc
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        songliubraving@fb.com, andrii@kernel.org, kafai@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, davem@davemloft.net, kpsingh@kernel.org,
        hawk@kernel.org, kuba@kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        rnsastry@linux.ibm.com
References: <20211115044437.12047-1-kjain@linux.ibm.com>
 <5a185d6b-7090-23f0-1ec9-140a31ee5fb4@iogearbox.net>
 <20211116083454.GY174703@worktop.programming.kicks-ass.net>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <36487948-9180-7180-9b04-d4cd18767c47@linux.ibm.com>
Date:   Tue, 16 Nov 2021 20:51:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211116083454.GY174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eDx13e6caN-uUeCHq9WjtPPDQ6YbCng0
X-Proofpoint-ORIG-GUID: XBi-TBt3mrbchl0m4wGOEronlSoT6dLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_03,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160072
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/16/21 2:04 PM, Peter Zijlstra wrote:
> On Tue, Nov 16, 2021 at 12:30:07AM +0100, Daniel Borkmann wrote:
> 
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index fdd14072fc3b..2b7343b64bb7 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -1245,7 +1245,7 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
>>>   BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>>>   	   void *, buf, u32, size, u64, flags)
>>>   {
>>> -#ifndef CONFIG_X86
>>> +#if !(defined(CONFIG_X86) || defined(CONFIG_PPC64))
>>
>> Can this really be enabled generically? Looking at 3925f46bb590 ("powerpc/perf: Enable
>> branch stack sampling framework") it says POWER8 [and beyond]. Should there be a generic
>> Kconfig symbol like ARCH_HAS_BRANCH_RECORDS that can be selected by archs instead?
> 

Hi Peterz/Daniel,
    Thanks for reviewing the patch

> I conplained about it before as well. I'd just take it out entirely.

I agree, it make more sense to entirely remove this arch check from
here. Because anyway, incase any arch doesn't support this
functionality, bpf_read_branch_records will return -EINVAL.

> 
> If perf_snapshot_branch_stack isn't implemnted it'll return 0 and then
> we'll -Esomething anyway.

In this patch, we are basically adding powerpc support to capture
branch records via bpf_read_branch_records function. We are still
looking into adding support for perf_snapshot_branch_stack for powerpc.

 I will send a follow up to remove arch check in bpf_read_branch_records
function.

Thanks,
Kajol Jain
> 
> 
