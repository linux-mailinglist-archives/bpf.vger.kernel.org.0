Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347793AFDA0
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFVHOW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 03:14:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43530 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhFVHOQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Jun 2021 03:14:16 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M73tJ4026652;
        Tue, 22 Jun 2021 03:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DmFy3Ba0GQktUP84N/Xh5kSVt/I7Z6RAqewGIHWSsOw=;
 b=ZFtoLB7lFXWOH+lMB/4NA1zlcFoElVyxQA0SywE0eGzHTkc6AzneeunZU/mv8bMNDu/S
 bzHVNnLUqojO582zOEYskwIHrAmn/Qlzi3/zDQrny95C6KezT7T/PJRjwUIwz91wUt/Z
 Sqeb+GZL2Wq0LITa0z/2df5RuTNxhZJ/TxsbDn0Drv+vS3AqaGohGqk1q7Zpgefb2Mb1
 tc2c6MPvz8tdDyvVFfPZmPz15GD9HEXlLl4aaB+rC32smNhgulzM174f3tDBP+LUIoAA
 DeTDRFndeml1kpaHOipplXK3sHpdZUPD+ijjW++QMA6jkVN81/5EYuWtC6hku3LLAzHL uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ba85hm9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 03:11:10 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15M73old025895;
        Tue, 22 Jun 2021 03:11:10 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ba85hm8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 03:11:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15M784nb015650;
        Tue, 22 Jun 2021 07:11:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 399878993d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 07:11:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15M79ngk32899492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 07:09:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE11AA405F;
        Tue, 22 Jun 2021 07:11:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DCDDA405C;
        Tue, 22 Jun 2021 07:10:59 +0000 (GMT)
Received: from [9.199.39.114] (unknown [9.199.39.114])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jun 2021 07:10:59 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH bpf-next 0/1] arm64: Add BPF exception tables
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        bpf <bpf@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200728152122.1292756-1-jean-philippe@linaro.org>
 <daba29d3-46bb-8246-74a7-83184c92435c@linux.ibm.com>
 <CAADnVQJsCkSdqCaQt2hretdqamWJmWRQvh+=RvwHmHAOW2kL6g@mail.gmail.com>
 <fedff32f-e511-a191-22b0-bf421bdcce2a@linux.ibm.com>
 <CAADnVQJux+8n-vpuK9FqTLuj4cXrp04pGkpvKaUdAPXLQ4c-PQ@mail.gmail.com>
Message-ID: <3bc13a55-c0c4-e2fe-762c-794138adebf6@linux.ibm.com>
Date:   Tue, 22 Jun 2021 12:40:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQJux+8n-vpuK9FqTLuj4cXrp04pGkpvKaUdAPXLQ4c-PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R2pniiIf8D9jys73ZpSG380JQPRrTxja
X-Proofpoint-GUID: TenCV2jNI72BffM_rrIWYqe56dqr0-H8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_04:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220043
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On 6/18/21 10:04 PM, Alexei Starovoitov wrote:
> On Wed, Jun 16, 2021 at 11:58 PM Ravi Bangoria
> <ravi.bangoria@linux.ibm.com> wrote:
>>
>>     $ dmesg
>>     [  166.864325] BUG: unable to handle page fault for address: 0000000000d12345
>>     [  166.864336] #PF: supervisor read access in kernel mode
>>     [  166.864338] #PF: error_code(0x0000) - not-present page
>>
>> 0xd12345 is unallocated userspace address. Similarly, I also tried with
> 
> that's unfortunately expected, since this is a user address.

Sure. fwiw, it works with bpf_probe_read().

>> p->dte = (void *)0xffffffffc1234567 after confirming it's not allocated
>> to kernel or any module address. I see the same failure with it too.
> 
> This one is surprising though. Sounds like a bug in exception table
> construction. Can you debug it to see what's causing it?
> First check that do_kern_addr_fault() is invoked in this case.
> And then fixup_exception() and why search_bpf_extables()
> cannot find it.

It seems the commit 4c5de127598e1 ("bpf: Emit explicit NULL pointer checks
for PROBE_LDX instructions.") added few instructions before actual load
but does not consider those additional instruction while calculating
extable offset. Let me prepare a fix.

> Separately we probably need to replace the NULL check
> with addr >= TASK_SIZE_MAX to close this issue though it's a bit artificial.

Ravi
