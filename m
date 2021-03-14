Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D388433A8D6
	for <lists+bpf@lfdr.de>; Mon, 15 Mar 2021 00:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhCNXee (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Mar 2021 19:34:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11890 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhCNXeJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 14 Mar 2021 19:34:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12ENV0KB011165;
        Sun, 14 Mar 2021 16:34:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=B3hgHzeE6jh3tvO9AwbbqPKnrlUAyoAcKJPF7J6CanQ=;
 b=kXUYo/6+D7o38y6mka9wkz3vznyFGwcZf0aWpVqjnW/Ecs+PfzGYK7Rwn2ljeevSte0r
 UVvDYlCOn3GBGBHG094oUCRlYw8cB93luT9CF7qTnoMQLdXsywGE2pDeBVg1PM0hj0HA
 dblbC/hWvWH4gjB4H5TKiecA7I/n2EK58G4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 379e11267g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 14 Mar 2021 16:34:06 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 14 Mar 2021 16:34:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFGmOf8TVQc/wi5Vj3/X0B6zK9dT5FrAmBrFiSlD3kIBRLLZk23scxmx1zt4DL8unSr8CAJT61YRisBZk707RnSbz8RkIX7yq9tF51BN6s1KnJaAif6SVY+PiHv5oPjWkIGwBF/DiZ555aXke/nCEyV+u9Xszr7uN1AQSCfhvW2QtiGZxWGPWDh1RRYv6w3yfI64qc6D5tKIbvPNmLtCZQ0xLaWQ0Y5MUTNgLYTqCIlVbrbs6CorJ8eU6PRIHdn6VSd0FQI2mjkXzppxA6FOGA/lSoQNYdyx+YBQiK1HvEIdCq2TThWPGtbKp01dwIZoId2ObZzpWZbgtjt4IUQwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3hgHzeE6jh3tvO9AwbbqPKnrlUAyoAcKJPF7J6CanQ=;
 b=C1DGT7t7T1ieAPwDSeA96odGliyQ6+XLTNeTQu10poSpsPrJYG9TsnunDPExgdibRsZwcPC0Tft6GHuYK9WlXV3MYg0ofq0TDa0yzmpBSbcnnisxSo6bgfqyZm3m0toU+utqnMp2VIvn552RJ5nBdyX7+6qMmMKBFeVdvF5y4c8nj09jI3TFP5GR6a4r/4+BaMt30Lc6KL0RjrjOn97RAMJajLPq7BNIYkG5NvCegBR8xsrOaAgiA9YaDT1Wu+aWzBBimwyrRs5G+a9BO4jf3aAZ+4rHn33BUPj/mAsw6RLxJr5vU/zfUDAb7KCNW371UpGwL0pKR3vumSGeF//pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sun, 14 Mar
 2021 23:34:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3933.032; Sun, 14 Mar 2021
 23:34:02 +0000
Subject: Re: [RFC 0/1] Combining CUs into a single hash table
To:     Bill Wendling <morbo@google.com>
CC:     <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
References: <20210212211607.2890660-1-morbo@google.com>
 <CAGG=3QWuxzwKGuYhVu+EfXPFZMNsO7-=NtHbdXAyvcVjvKF3hA@mail.gmail.com>
 <86bcb5c4-b3c8-e41f-96ec-800caf57f585@fb.com>
 <CAGG=3QUYzMNBwoOY9q739wKDVzuevZSjC=KPBdrQW9fXRCnvjQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f742fd34-27ee-bb48-907b-1d12cb6ff25c@fb.com>
Date:   Sun, 14 Mar 2021 16:33:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAGG=3QUYzMNBwoOY9q739wKDVzuevZSjC=KPBdrQW9fXRCnvjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:896c]
X-ClientProxiedBy: MWHPR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:300:ee::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::104e] (2620:10d:c090:400::5:896c) by MWHPR04CA0027.namprd04.prod.outlook.com (2603:10b6:300:ee::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Sun, 14 Mar 2021 23:34:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19b5458f-d507-47ba-6bf0-08d8e741a611
X-MS-TrafficTypeDiagnostic: SA1PR15MB4644:
X-Microsoft-Antispam-PRVS: <SA1PR15MB46444E0E788610B3E2F12A04D36D9@SA1PR15MB4644.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDhq3+EolZwRwbE7M1OXSC243ydyiqxVyxH5unMuJW6p/a3kR/JAZplu+bmN5O3/MFdHn9raYY889asvaiEMKpfh3zJpdKBF1bX0KUb5dEEcltchBpjZXahis8kAznaB0U1ByIPCnMg/F6hiZ4UpZoFHHW7sYUnVVStPcjcFqrqYUgNgzmFEKp1vABfYkbQ/me5SYPUSPovM9aryZ9OTf49oD7sJwQr9jsAY8N1m8EAm9bju+LIGKwjYrpqbNj/HwzOWgI3B3Eui3gyg6muamuG/lqnLq0llnvIG/62P3P/JYRt90hIAR7atpOYrHfMkmdLuONPpMBFmK2g3nfyQe773uOqR+8KsfSD3nQhdfovCEhtXcPNS7edhUW80m3jFDTN3W0z9DqgLW9rlPCNJJecK2rYJbFs5JuHt3f31LY9/tNCleCKJw57ZhJtFUVvAeY65xDW+vg62936o3xxSv4gwvOyeQNLn6Bgptv5pVn91a+EJC+kXYvgw1+Ho0E4bfOhSzZYJqTjTTkgUWnz2YbCcuL/+f+4PoyNFBhUxyFtoBneU68CxG6YrLc8p4G1UT1P+02fEJirAQlwEL9pJdAKVT159W6p/5aBvTgwcZQWtVrt+5G84zTivDtO7oogtm0P9mHkWXJSb+dmnizBHWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(39860400002)(396003)(186003)(2616005)(16526019)(6666004)(31686004)(83380400001)(36756003)(2906002)(54906003)(316002)(53546011)(478600001)(5660300002)(6486002)(8936002)(8676002)(66476007)(6916009)(66556008)(86362001)(31696002)(66946007)(4326008)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWp4WVQ2Z2VsNkNreTdnUG52ZGpDaUJCbGlhMnBENFJvOXRkMm1HS3VTZXJZ?=
 =?utf-8?B?UVppNFNNckNhTEI4T05aM3U3bVpkUkhzeUtOWTFwYWljaDErc2pCckU5cXZD?=
 =?utf-8?B?YVNDd3J4QTMzR1d1YUttTmxmcWtJZU1XQWt5c0hjSzB5eTk5SlFVc1BJNGl4?=
 =?utf-8?B?VVg1QjU0NVUxNmthbUVzL2JPOEIzVlRJL1lVZ2VKeTBQcmNPT3k3Z3o4RjJB?=
 =?utf-8?B?MWZSVlQ2VVVaZm5nYTMvV3lhUTNUNDRhNHVEVXBYc2x1dFBpZkozZWFhNmg4?=
 =?utf-8?B?K1gzaUExN3Z3RFUrUmVXNTV4TXhrVUNrUzR5MURSM2d2N2xkN0VNb1Q4eEYx?=
 =?utf-8?B?c1pEemN6UzBPZ1REUndJc1VsVnB5NnJmTXFYUnFDc1JQNm91NmRTZkpBN1VI?=
 =?utf-8?B?ZGlYS1dTbWtVeU9wYVk1bE11c054blVjcjFHemUzN3RjTUNQbjdOblRlaTdm?=
 =?utf-8?B?U2NBeHJSRllXenlaQk93R1oxYjMyd21UOXd6ZXU1OUJyTGxXd1Z3Ym1OeFBk?=
 =?utf-8?B?Vi8raUNQQlhKZ0FXbHdDclJUd25RSHZsNVI1VkRrbS9Ccm9HeDZ0enZIM2Nr?=
 =?utf-8?B?U3NPWWdTUmlDczlLM3lSV3kycjRuMHJ2WFNKWUY0MzZwWVVCK2NnS2Foa3p0?=
 =?utf-8?B?dlBQM3RzN0pOUm1nK21hejB3dFZNMUJIODRoK0pMZnozakw1c040b3BFcEdN?=
 =?utf-8?B?ZUhMSE8wUWx0eHErZjUxZE4rVHNyOXJvNDRCTXBkdDFXTFMxRkxKcHdHaGpL?=
 =?utf-8?B?Z3plUHBrdVcvNHpENytjak5JbEJ0OExLeFNiL0hJT29WZTMrYmtudk90OGlV?=
 =?utf-8?B?SWlQWDhtWTRMcnVMaWFiTDlrMkdhV3pLZjNncW1reEJXc0ROSitRWXZlSlg5?=
 =?utf-8?B?bldrWlhhZ0VHekcxbm13L2hiWlRlNnpYck84N09RSCswK1FCT0lLQUVVc2Ns?=
 =?utf-8?B?ZE9FU0t5Z1JmS2V4SHg5KzhXd0FDYVcvR1E3YnlKS0YzU0RUN0NQY2pKMFZY?=
 =?utf-8?B?Z3ZkMkU0UjU2SE5RcDA3NXE2WHdmSmUvSndLSzBoZnBSUmZESDZkakdCMWxJ?=
 =?utf-8?B?dWhNTmo3b3V5TU5ReDF6NlBtZXY3U3RRb3hpUXB2bEV6OXZSUWQ4SU8vZ3cy?=
 =?utf-8?B?Z1UwSEVhWUkxcUVTeEhmNDhwMnl4WUtvZVp4QzdXMS9uUFdzclhCVDFZSXpQ?=
 =?utf-8?B?bUdOcTlzaGRwNmNRL3lCdWMwcEhhcG44Vjdzemc3Y2VrOXhreXRaUVJ3VEYy?=
 =?utf-8?B?Vkx3VG5PSExLaWRjZ1ltY3RjRmlvQzV4VWFDa3lMOHhiMXJWZzRWOFlwcnpM?=
 =?utf-8?B?emhrbVdjSW1Ddm9IS3JkZ01vc0RZZFlZaDE3MWxuM2ZkT005cCtJMncyNTBU?=
 =?utf-8?B?NXFERzZyYVhvMW9Rbis3L0FjZzF5ekFpdllDaVlXZ0lycTNWWUtSZExubVFQ?=
 =?utf-8?B?N2hyWGV4TFM1L0dWdXNLY1VGY2lxc1ZnZnpqTTlWR1JNa25RNXF2SXplOWlz?=
 =?utf-8?B?aCt3bnAxUitWMEt4S0N3ZFl3MXR4aWtpdXpCWDJnS2ZiMWtiUDVUQ2lLL1l3?=
 =?utf-8?B?aFpudFFvcVo1a2luekMwaE5sdjQzNUcrbWxSVGJHZWFDOWtKUU9wS0FKcDBH?=
 =?utf-8?B?bTloYWp0T3owbVFkU2JabmNhSk8vZWJRUGdUTndUYi8zdUs1UE9UaUR4dE1F?=
 =?utf-8?B?WTdTc3g1Y3pzRHlSdE1UNUc2Q2JSOWNVQkdtWERTWFNpdW1wMEtwYVNlRlRw?=
 =?utf-8?B?SFN0UC9nSTNNUVEzenRPOG5SZ0ljL2N2am9JZ1VxYmQ5ZVNBUzhrWmJlbzhv?=
 =?utf-8?B?UzZodFNtUHJLcHoyT3diQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5458f-d507-47ba-6bf0-08d8e741a611
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2021 23:34:02.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UakUCptyGPHY5lR6wAlr9SjetL4JV7QKa8LveQ/NfG9u75zVY5X8CPjQZ1ckx7Eg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-14_13:2021-03-12,2021-03-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140183
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/14/21 12:28 AM, Bill Wendling wrote:
> On Sat, Mar 13, 2021 at 11:05 PM Yonghong Song <yhs@fb.com> wrote:
>> On 2/23/21 12:44 PM, Bill Wendling wrote:
>>> Bump for exposure.
>>>
>>> On Fri, Feb 12, 2021 at 1:16 PM Bill Wendling <morbo@google.com> wrote:
>>>>
>>>> Hey gang,
>>>>
>>>> I would like your feedback on this patch.
>>>>
>>>> This patch creates one hash table that all CUs share. The impetus for this
>>>> patch is to support clang's LTO (Link-Time Optimizations). Currently, pahole
>>>> can't handle the DWARF data that clang produces, because the CUs may refer to
>>>> tags in other CUs (all of the code having been squozen together).
>>
>> Hi, Bill,
>>
>> LTO build support is now in linus tree 5.12 rc2 and also merged in
>> latest bpf-next. I tried thin-LTO build and it is fine with latest
>> trunk llvm (llvm13) until it hits pahole and it stuck there (pahole
>> 1.20) probably some kind of infinite loop in pahole as pahole is
>> not ready to handle lto dwarf yet.
>>
>> I then applied this patch on top of master pahole (1.20) and pahole
>> seg faulted. I did not debug. Have you hit the same issue?
>> How did you make pahole work with LTO built kernel?
>>
> Hi Yonghong,
> 
> I haven't tried this very much with top-of-tree Linux, but it's quite
> possible that there's a segfaulting issue I haven't come across yet.
> Make sure that you're using pahole v1.20, because it supports clang's
> penchant for assigning some objects "null" names.
> 
> This patch is the first step in my attempt to get pahole working with
> LTO. There's a follow-up patch that I'll attach to this email that
> gets me through the compilation. It's not been heavily tested or
> reviewed (it's in my local tree), so caveat emptor. I would love to
> have people test it to see if it helps or just makes things worse.

I applied you "Combining CUs into a single hash table" patch and
the attach patch, now pahole does not segfault any more, but I still
get the following pahole errors:

...
<ERROR(tag__size:1040): 1622 not found!>
<ERROR(tag__size:1040): 1617 not found!>
<ERROR(tag__size:1040): 1615 not found!>
error: found variable 'loaded_vmcss_on_cpu' in CU 
'/home/yhs/work/bpf-next/arch/x86/kvm/vmx/vmx.c' that has void type
Encountered error while encoding BTF.

FYI, I compiled latest bpf-next with the following command:
    make LLVM=1 LLVM_IAS=1 -j60
the compiler is locally built with latest upstream llvm-project.
I am using thin-lto in kernel config.

I will take a look at your patch and the issue next week,
hopefully we can resolve the issue soon. Thanks!

> 
> Cheers!
> -bw
> 
>> Thanks!
>>
>> Yonghong
>>
>>>>
>>>> One solution I found is to process the CUs in two steps:
>>>>
>>>>     1. add the CUs into a single hash table, and
>>>>     2. perform the recoding and finalization steps in a a separate step.
>>>>
>>>> The issue I'm facing with this patch is that it balloons the runtime from
>>>> ~11.11s to ~14.27s. It looks like the underlying cause is that some (but not
>>>> all) hash buckets have thousands of entries each. I've bumped up the
>>>> HASHTAGS__BITS from 15 to 16, which helped a little. Bumping it up to 17 or
>>>> above causes a failure.
>>>>
>>>> A couple of things I thought of may help. We could increase the number of
>>>> buckets, which would help with distribution. As I mentioned though, that seemed
>>>> to cause a failure. Another option is to store the bucket entries in a
>>>> non-list, e.g. binary search tree.
>>>>
>>>> I wanted to get your opinions before I trod down one of these roads.
>>>>
>>>> Share and enjoy!
>>>> -bw
>>>>
>>>> Bill Wendling (1):
>>>>     dwarf_loader: have all CUs use a single hash table
>>>>
>>>>    dwarf_loader.c | 45 +++++++++++++++++++++++++++++++++------------
>>>>    1 file changed, 33 insertions(+), 12 deletions(-)
>>>>
>>>> --
>>>> 2.30.0.478.g8a0d178c01-goog
>>>>
