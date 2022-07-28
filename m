Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F8584550
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 20:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiG1SBV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 14:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiG1SBT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 14:01:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C2E72EFA
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 11:01:18 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SHtgGq003547;
        Thu, 28 Jul 2022 18:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EV7JpHsPlVTgm/YXNeMkhc0Pqz7QCEMvWVUMbWDMAhk=;
 b=tG3vc4vxQxEF8kehuqPckF+j8N3lvqWyvOaIcrquxsai5wIKXtYz2kd0tpdk+MHDzvVV
 hB97qxtjbpZQr6/qna0J2OjrZFSClPNooHsErrAQk7dL0c7ScLTRkS3IN8x8p2g4wInJ
 FoCGtLEC1sgpgjnqJ9fQox7usz9pYymWcHHAPlsy+FB5FmCw167lLkrC44IFidLaYHUW
 /tO+as9Sg5Dw6sqnAyH1ZNYXMYDybMbRlY3Td7T5FLyq0HemEyU5GM6YHslViaY8LL44
 I5ftKdyBXx8dKF5Wn6ya53mR2YE8thGpk8k1lOQ+Boy9FKh6+ciJlyinwpouhBu/LIC7 jA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hky9dr7dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 18:01:05 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26SHnrl9012800;
        Thu, 28 Jul 2022 18:01:04 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 3hg97914by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 18:01:04 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26SI12497143974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 18:01:02 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71A8711206F;
        Thu, 28 Jul 2022 18:01:02 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4556B11206D;
        Thu, 28 Jul 2022 18:01:02 +0000 (GMT)
Received: from [9.31.97.147] (unknown [9.31.97.147])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jul 2022 18:01:02 +0000 (GMT)
Message-ID: <c7763b47-19ff-b369-1006-3bca38f4f083@linux.ibm.com>
Date:   Thu, 28 Jul 2022 14:01:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] BPF: Fix potential bad pointer dereference in bpf_sys_bpf
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        mvle@us.ibm.com, jamjoom@us.ibm.com, sahmed@ibm.com,
        Daniel.Williams2@ibm.com
References: <20220727132905.45166-1-jinghao@linux.ibm.com>
 <44fff416-49d5-458e-c464-e15483e2c90a@fb.com>
Content-Language: en-US
From:   Jinghao Jia <jinghao@linux.ibm.com>
In-Reply-To: <44fff416-49d5-458e-c464-e15483e2c90a@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gNxOcwCJvwWBeSjbZp2Jt8bvxPapK4Ca
X-Proofpoint-GUID: gNxOcwCJvwWBeSjbZp2Jt8bvxPapK4Ca
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=893 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 7/28/22 10:52 AM, Yonghong Song wrote:
>
>
> On 7/27/22 6:29 AM, Jinghao Jia wrote:
>> The bpf_sys_bpf() helper function allows an eBPF program to load another
>> eBPF program from within the kernel. In this case the argument union
>> bpf_attr pointer (as well as the insns and license pointers inside) is a
>> kernel address instead of a userspace address (which is the case of a
>> usual bpf() syscall). To make the memory copying process in the syscall
>> work in both cases, bpfptr_t [1] was introduced to wrap around the
>> pointer and distinguish its origin. Specifically, when copying memory
>> contents from a bpfptr_t, a copy_from_user() is performed in case of a
>> userspace address and a memcpy() is performed for a kernel address [2].
>>
>> This can lead to problems because the in-kernel pointer is never checked
>> for validity. If an eBPF syscall program tries to call bpf_sys_bpf()
>> with a bad insns pointer, say 0xdeadbeef (which is supposed to point to
>> the start of the instruction array) in the bpf_attr union, memcpy() is
>> always happy to dereference the bad pointer to cause a un-handle-able
>> page fault and in turn an oops. However, this is not supposed to happen
>> because at that point the eBPF program is already verified and should
>> not cause a memory error. The same issue in userspace is handled
>> gracefully by copy_from_user(), which would return -EFAULT in such a
>> case.
>>
>> Replace memcpy() with the safer copy_from_kernel_nofault() and
>> strncpy_from_kernel_nofault().
>>
>> [1]: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/bpfptr.h
>> [2]: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/sockptr.h#n44
>>
>> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
>> ---
>>   include/linux/sockptr.h | 11 +++--------
>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
>> index d45902fb4cad..3b8a41c82516 100644
>> --- a/include/linux/sockptr.h
>> +++ b/include/linux/sockptr.h
>> @@ -46,8 +46,7 @@ static inline int copy_from_sockptr_offset(void 
>> *dst, sockptr_t src,
>>   {
>>       if (!sockptr_is_kernel(src))
>>           return copy_from_user(dst, src.user + offset, size);
>> -    memcpy(dst, src.kernel + offset, size);
>> -    return 0;
>> +    return copy_from_kernel_nofault(dst, src.kernel + offset, size);
>>   }
>
> The subject and commit message mentioned it is bpf_sys_bpf() helper
> might have issues. But the patch itself tries to modify 
> copy_from_sockptr_offset() and strncpy_from_sockptr(), why?
>

Hi Yonghong,

Sorry for the confusion. The problem happens when bpf_sys_bpf() helper 
is called with a bad kernel address but the dereference takes place in 
the copy_from_sockptr_offset() and strncpy_from_sockptr() functions.

Let's assume we are doing a BPF_PROG_LOAD operation using bpf_sys_bpf() 
and our insns pointer inside the union bpf_attr argument is set to NULL 
(could be any other bad address). The helper calls __sys_bpf() which 
would then call bpf_prog_load() to load the program. bpf_prog_load() is 
responsible for copying the eBPF instructions to the newly allocated 
memory for the program, which uses the bpfptr_t API [1]. Internally, all 
bpfptr_t operations are backed by the corresponding sockptr_t 
operations. In other words, the code that performs the copy (and 
therefore the deref of the pointer) is inside copy_from_sockptr_offset() 
and strncpy_from_sockptr().

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/syscall.c#n2566

Best,
Jinghao
>>     static inline int copy_from_sockptr(void *dst, sockptr_t src, 
>> size_t size)
>> @@ -93,12 +92,8 @@ static inline void *memdup_sockptr_nul(sockptr_t 
>> src, size_t len)
>>     static inline long strncpy_from_sockptr(char *dst, sockptr_t src, 
>> size_t count)
>>   {
>> -    if (sockptr_is_kernel(src)) {
>> -        size_t len = min(strnlen(src.kernel, count - 1) + 1, count);
>> -
>> -        memcpy(dst, src.kernel, len);
>> -        return len;
>> -    }
>> +    if (sockptr_is_kernel(src))
>> +        return strncpy_from_kernel_nofault(dst, src.kernel, count);
>>       return strncpy_from_user(dst, src.user, count);
>>   }
>>
>> base-commit: d295daf505758f9a0e4d05f4ee3bfdfb4192c18f
