Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C845850E0
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 15:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiG2N1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiG2N1C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 09:27:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D2B68DE5
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 06:27:00 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TDC1pd021799;
        Fri, 29 Jul 2022 13:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=x0wz5RwO3ZZU30IPYYNiZY4Wi4PbThPr0agnauCHQ7Y=;
 b=mCj9y6wtEEJMW270f9HNtK9Uz6OvPIEYSUxd2Af1wLDUOSiR/bLpasqL1Hn2QSCIeCRy
 enOp0pAA43Q9yeEA9gxOt2VRaJpWLeLTWINx/OM4WFRa8oKvkBNHaBjZSPcDHe7vJYNV
 UZJM8NkYQ0sBBGXdqOPDawEuGGlGoqOHF3kBn3UyIMjbSDCS2NbnNiauVJzlWq8lWBhL
 GWE6Ilk5Gnwvju0Qr/uPxo3LfYGfWHnB2r/ZkKZNZKycZlcVXLby/6SZymRygpb7gcdG
 NbGUOya0sKo9JvcHyATDugm6KneiTjt/UKuMdugV52WEgcP5Ajmfk17o9mw0/kYVvoBL zA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmg7hrgfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 13:26:53 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26TDLqcU020114;
        Fri, 29 Jul 2022 13:26:52 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3hg97974ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 13:26:52 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26TDQowG37880254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 13:26:50 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 670A0C6055;
        Fri, 29 Jul 2022 13:26:50 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC956C6059;
        Fri, 29 Jul 2022 13:26:49 +0000 (GMT)
Received: from [9.31.97.147] (unknown [9.31.97.147])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 13:26:49 +0000 (GMT)
Message-ID: <e94aed3c-1601-13b6-779f-917d0783b70e@linux.ibm.com>
Date:   Fri, 29 Jul 2022 09:26:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH] BPF: Fix potential bad pointer dereference in bpf_sys_bpf
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        mvle@us.ibm.com, jamjoom@us.ibm.com, sahmed@ibm.com,
        Daniel.Williams2@ibm.com
References: <20220727132905.45166-1-jinghao@linux.ibm.com>
 <44fff416-49d5-458e-c464-e15483e2c90a@fb.com>
 <c7763b47-19ff-b369-1006-3bca38f4f083@linux.ibm.com>
 <7e5c0f32-7041-35d0-a18d-8d61f3cb3930@fb.com>
From:   Jinghao Jia <jinghao@linux.ibm.com>
In-Reply-To: <7e5c0f32-7041-35d0-a18d-8d61f3cb3930@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kvbwM-T0gN-QqAV4xqjIs-ztiCmD2q6_
X-Proofpoint-ORIG-GUID: kvbwM-T0gN-QqAV4xqjIs-ztiCmD2q6_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 7/28/22 7:16 PM, Yonghong Song wrote:
>
>
> On 7/28/22 11:01 AM, Jinghao Jia wrote:
>>
>> On 7/28/22 10:52 AM, Yonghong Song wrote:
>>>
>>>
>>> On 7/27/22 6:29 AM, Jinghao Jia wrote:
>>>> The bpf_sys_bpf() helper function allows an eBPF program to load 
>>>> another
>>>> eBPF program from within the kernel. In this case the argument union
>>>> bpf_attr pointer (as well as the insns and license pointers inside) 
>>>> is a
>>>> kernel address instead of a userspace address (which is the case of a
>>>> usual bpf() syscall). To make the memory copying process in the 
>>>> syscall
>>>> work in both cases, bpfptr_t [1] was introduced to wrap around the
>>>> pointer and distinguish its origin. Specifically, when copying memory
>>>> contents from a bpfptr_t, a copy_from_user() is performed in case of a
>>>> userspace address and a memcpy() is performed for a kernel address 
>>>> [2].
>>>>
>>>> This can lead to problems because the in-kernel pointer is never 
>>>> checked
>>>> for validity. If an eBPF syscall program tries to call bpf_sys_bpf()
>>>> with a bad insns pointer, say 0xdeadbeef (which is supposed to 
>>>> point to
>>>> the start of the instruction array) in the bpf_attr union, memcpy() is
>>>> always happy to dereference the bad pointer to cause a un-handle-able
>>>> page fault and in turn an oops. However, this is not supposed to 
>>>> happen
>>>> because at that point the eBPF program is already verified and should
>>>> not cause a memory error. The same issue in userspace is handled
>>>> gracefully by copy_from_user(), which would return -EFAULT in such a
>>>> case.
>>>>
>>>> Replace memcpy() with the safer copy_from_kernel_nofault() and
>>>> strncpy_from_kernel_nofault().
>>>>
>>>> [1]: 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/bpfptr.h 
>>>>
>>>> [2]: 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/sockptr.h#n44 
>>>>
>>>>
>>>> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
>>>> ---
>>>>   include/linux/sockptr.h | 11 +++--------
>>>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
>>>> index d45902fb4cad..3b8a41c82516 100644
>>>> --- a/include/linux/sockptr.h
>>>> +++ b/include/linux/sockptr.h
>>>> @@ -46,8 +46,7 @@ static inline int copy_from_sockptr_offset(void 
>>>> *dst, sockptr_t src,
>>>>   {
>>>>       if (!sockptr_is_kernel(src))
>>>>           return copy_from_user(dst, src.user + offset, size);
>>>> -    memcpy(dst, src.kernel + offset, size);
>>>> -    return 0;
>>>> +    return copy_from_kernel_nofault(dst, src.kernel + offset, size);
>>>>   }
>>>
>>> The subject and commit message mentioned it is bpf_sys_bpf() helper
>>> might have issues. But the patch itself tries to modify 
>>> copy_from_sockptr_offset() and strncpy_from_sockptr(), why?
>>>
>>
>> Hi Yonghong,
>>
>> Sorry for the confusion. The problem happens when bpf_sys_bpf() 
>> helper is called with a bad kernel address but the dereference takes 
>> place in the copy_from_sockptr_offset() and strncpy_from_sockptr() 
>> functions.
>>
>> Let's assume we are doing a BPF_PROG_LOAD operation using 
>> bpf_sys_bpf() and our insns pointer inside the union bpf_attr 
>> argument is set to NULL (could be any other bad address). The helper 
>> calls __sys_bpf() which would then call bpf_prog_load() to load the 
>> program. bpf_prog_load() is responsible for copying the eBPF 
>> instructions to the newly allocated memory for the program, which 
>> uses the bpfptr_t API [1]. Internally, all bpfptr_t operations are 
>> backed by the corresponding sockptr_t operations. In other words, the 
>> code that performs the copy (and therefore the deref of the pointer) 
>> is inside copy_from_sockptr_offset() and strncpy_from_sockptr().
>
> Thanks for explanation. It would be great if you can put the above
> details in the commit message (esp. call stack) which leads to
> the kernel panic(?).
>
>>
>> [1]: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/syscall.c#n2566 
>>
>>
>> Best,
>> Jinghao
>>>>     static inline int copy_from_sockptr(void *dst, sockptr_t src, 
>>>> size_t size)
>>>> @@ -93,12 +92,8 @@ static inline void *memdup_sockptr_nul(sockptr_t 
>>>> src, size_t len)
>>>>     static inline long strncpy_from_sockptr(char *dst, sockptr_t 
>>>> src, size_t count)
>>>>   {
>>>> -    if (sockptr_is_kernel(src)) {
>>>> -        size_t len = min(strnlen(src.kernel, count - 1) + 1, count);
>>>> -
>>>> -        memcpy(dst, src.kernel, len);
>>>> -        return len;
>>>> -    }
>>>> +    if (sockptr_is_kernel(src))
>>>> +        return strncpy_from_kernel_nofault(dst, src.kernel, count);
>>>>       return strncpy_from_user(dst, src.user, count);
>>>>   }
>
> I think we should not modify copy_from_sockptr() and 
> strncpy_from_sockptr(). These two functions are used by networking
> as well and nofault version should not be called for calls in
> networking stack.
>
> So I suggest you directly modify copy_from_bpfptr() and 
> strncpy_from_bpfptr() since these two functions indeed might
> have invalid kernel address and may cause fault.
>

Thanks a lot for the feedback! I do agree that the changes on sockptr 
functions might be problematic. I will roll out a V2 based on your comments.

--Jinghao
>>>>
>>>> base-commit: d295daf505758f9a0e4d05f4ee3bfdfb4192c18f
