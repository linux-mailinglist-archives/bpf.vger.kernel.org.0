Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731E862F170
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiKRJkB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 04:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241983AbiKRJj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 04:39:59 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4818B1E
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 01:39:58 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI8q6Ic010416;
        Fri, 18 Nov 2022 09:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ApGhgdgxwbo//4e8BI/r7ZLAAUWOn9Ws0+lfryVpQTI=;
 b=LIlrG51nw5xO8T2SRisyjV5LmPoUwo7QwP4af9F5jrSOe0rWFqvDItbXnbIyR4T/yxAy
 V/ZITCaAVuyu35wtA7k2Wr6yDMf3xJvOPKo2+LHZly+SB3+EWhIuBNDVCQnUICfqjckI
 ov9fpII9WPEgiQ04kuog0x0WV/qciA723UorCA4g+mocmK+oWTlIdiR0/icOpBfHtLTH
 HlCwvETB5Ap4GurYacmkWqcg0HQw2FvixVIFnZ+vIvdB1mrQO3OOjeltWwPNFbVuActa
 5tDDREmrBuYOeH8W35Ng9ytYsNjogDi4BBJmqnBaPUN2T04dtsgGxmlEyAB6CycgWzKf VA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx6wqh0r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 09:39:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AI9avF7014616;
        Fri, 18 Nov 2022 09:39:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kwthe0s6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 09:39:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AI9eCEY51904950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 09:40:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3773742042;
        Fri, 18 Nov 2022 09:39:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBC1642041;
        Fri, 18 Nov 2022 09:39:28 +0000 (GMT)
Received: from [9.211.152.48] (unknown [9.211.152.48])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Nov 2022 09:39:28 +0000 (GMT)
Message-ID: <548de735-52d7-f5bb-5c85-370a1c233a08@linux.ibm.com>
Date:   Fri, 18 Nov 2022 15:09:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH 0/3] enable bpf_prog_pack allocator for powerpc
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20221110184303.393179-1-hbathini@linux.ibm.com>
 <00efe9b1-d9fd-441c-9eb4-cbf25d82baf2@csgroup.eu>
 <5b59b7df-d2ec-1664-f0fb-764c9b93417c@linux.ibm.com>
 <bf0af91e-861c-1608-7150-d31578be9b02@csgroup.eu>
 <e0266414-843f-db48-a56d-1d8a8944726a@csgroup.eu>
 <6151f5c6-2e64-5f2d-01b1-6f517f4301c0@linux.ibm.com>
 <02496f7a-51d8-4fc0-161d-b29d5e657089@csgroup.eu>
 <9d5c390a-31db-4f93-203d-281b0831d37f@linux.ibm.com>
 <c651bd44-d0ca-e3cf-0639-6b42b33f4666@csgroup.eu>
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <c651bd44-d0ca-e3cf-0639-6b42b33f4666@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1rc3Sq6bJrCr4aKtC77Pj-POMcvAj6AL
X-Proofpoint-GUID: 1rc3Sq6bJrCr4aKtC77Pj-POMcvAj6AL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 18/11/22 2:21 pm, Christophe Leroy wrote:
> 
> 
> Le 18/11/2022 à 09:39, Hari Bathini a écrit :
>>
>>
>> On 17/11/22 12:29 pm, Christophe Leroy wrote:
>>>
>>>
>>> Le 16/11/2022 à 18:01, Hari Bathini a écrit :
>>>>
>>>>
>>>> On 16/11/22 12:14 am, Christophe Leroy wrote:
>>>>>
>>>>>
>>>>> Le 14/11/2022 à 18:27, Christophe Leroy a écrit :
>>>>>>
>>>>>>
>>>>>> Le 14/11/2022 à 15:47, Hari Bathini a écrit :
>>>>>>> Hi Christophe,
>>>>>>>
>>>>>>> On 11/11/22 4:55 pm, Christophe Leroy wrote:
>>>>>>>> Le 10/11/2022 à 19:43, Hari Bathini a écrit :
>>>>>>>>> Most BPF programs are small, but they consume a page each. For
>>>>>>>>> systems
>>>>>>>>> with busy traffic and many BPF programs, this may also add
>>>>>>>>> significant
>>>>>>>>> pressure on instruction TLB. High iTLB pressure usually slows down
>>>>>>>>> the
>>>>>>>>> whole system causing visible performance degradation for production
>>>>>>>>> workloads.
>>>>>>>>>
>>>>>>>>> bpf_prog_pack, a customized allocator that packs multiple bpf
>>>>>>>>> programs
>>>>>>>>> into preallocated memory chunks, was proposed [1] to address it.
>>>>>>>>> This
>>>>>>>>> series extends this support on powerpc.
>>>>>>>>>
>>>>>>>>> Patches 1 & 2 add the arch specific functions needed to support
>>>>>>>>> this
>>>>>>>>> feature. Patch 3 enables the support for powerpc. The last patch
>>>>>>>>> ensures cleanup is handled racefully.
>>>>>>>>>
>>>>>>>
>>>>>>>>> Tested the changes successfully on a PowerVM. patch_instruction(),
>>>>>>>>> needed for bpf_arch_text_copy(), is failing for ppc32. Debugging
>>>>>>>>> it.
>>>>>>>>> Posting the patches in the meanwhile for feedback on these changes.
>>>>>>>>
>>>>>>>> I did a quick test on ppc32, I don't get such a problem, only
>>>>>>>> something
>>>>>>>> wrong in the dump print as traps intructions only are dumped, but
>>>>>>>> tcpdump works as expected:
>>>>>>>
>>>>>>> Thanks for the quick test. Could you please share the config you
>>>>>>> used.
>>>>>>> I am probably missing a few knobs in my conifg...
>>>>>>>
>>>>>>
>>>>>
>>>>> I also managed to test it on QEMU. The config is based on
>>>>> pmac32_defconfig.
>>>>
>>>> I had the same config but hit this problem:
>>>>
>>>>        # echo 1 > /proc/sys/net/core/bpf_jit_enable; modprobe test_bpf
>>>>        test_bpf: #0 TAX
>>>>        ------------[ cut here ]------------
>>>>        WARNING: CPU: 0 PID: 96 at arch/powerpc/net/bpf_jit_comp.c:367
>>>> bpf_int_jit_compile+0x8a0/0x9f8
>>>
>>> I get no such problem, on QEMU, and I checked the .config has:
>>
>>> CONFIG_STRICT_KERNEL_RWX=y
>>> CONFIG_STRICT_MODULE_RWX=y
>>
>> Yeah. That did the trick.
> 
> Interesting. I guess we have to find out why it fails when those config
> are missing.
> 
> Maybe module code plays with RO and NX flags even if
> CONFIG_STRICT_MODULE_RWX is not selected ?

Need to look at the code closely but fwiw, observing same failure on
64-bit as well with !STRICT_RWX...

Thanks
Hari
