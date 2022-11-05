Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC6B61A6D8
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 03:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKECP0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 22:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKECPZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 22:15:25 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB440935
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 19:15:24 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Mue6b006043;
        Fri, 4 Nov 2022 19:15:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=w00a2OrtU4XEOWh8ia4T1ZTpOA1LbWBVbt/i8NOVQzo=;
 b=jttpQFd01wT9Sh4jCNujSkZEYmUAemtGZMVskjdCHVkPSX7ctbSB4n6iEGn9INdrvSkb
 sV+SpM+ePqO1k6EuZU839T3ORJU55GfAY314DRippAEOVDKIG5zXAoSs/uVJHfYg1x40
 BTclpEekkG6OR5KrxVhSLPp4BxQ3yzi50Hs/bx5sDhsimgjT2o3e0Pne4PEJ5iAbQHxk
 ovCB28ABCTmrYJ77y/1oPlG4CP6a+YeSm7BE6slipUr2tuVpNk0Ecti0oFurcugwOlwI
 Ja49Z2H47sQdS+tKKB+IrdB74x8DfUZM+9of//DuOsxQ4uhrHRZUU2+YcK3J1qIoNOf/ AQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmpgm3hjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=focT/u5aXjBgnVlw7vKp5dv/JXvTUH88rV7rCW2UEV75mrslQhkw6MJUYwNhf0maOlxtOSdpxi7GcPMdvbujxDqwEsN/yW/XZIRnynR8dkYSt9pofZKt8FSEK0pbkr0dAcJRMcrt+nLa7lOPBUxG6ryUWn35tqnfnnkEfFGRiHA6pdORLFOAt19rer0XlnM1J2/O31FaUNuNO/0aR5fx7FsngGJD9aQD09e37sz1g3wcxCaqcOOwrRTmQMYlJWG67IiwQ/XA0jybM+vtF1RmB+TyeIeCt7YgbtPpwELpHHVhFki3wxlYnNeP9TodyvuCTgAPpTdYtbewJJGO33Xr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w00a2OrtU4XEOWh8ia4T1ZTpOA1LbWBVbt/i8NOVQzo=;
 b=dcMrJunqtAYWwyKo2P80ygLuG2N07gr70HKiVPWB7aldJTj/8qJj3qJVpTJi2WfYeTx/XTOCI+tmvl82EkCDGty7gzBDz100TIXneH7wFro/JIrYg0ktvMnAr0uIkGBHExtIObaV537Xwoqscs5Bm69/+k4nNxeuUvZZNpzhbsp0efKsMBx+WRAh9nkcRPa9wPcjYZzjqoIquo2kWzoSgn+4bBgBm6U04ZlwCRklj6jTBOntkFr+lnukFhIZ6zJJ2S5BHViB+f5Qo+scMD0WMLBpv2lr1GLrhJIbquhCvwt3D/bhl/FmVD0iH7/17OFua6RPr+KE/O+JzdJpTAK7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MWHPR15MB1470.namprd15.prod.outlook.com (2603:10b6:300:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Sat, 5 Nov
 2022 02:15:06 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be%6]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 02:15:06 +0000
Message-ID: <65edb881-f877-2d90-2d5c-46fad3a41251@meta.com>
Date:   Fri, 4 Nov 2022 22:15:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v4 22/24] bpf: Introduce single ownership BPF
 linked list API
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-23-memxor@gmail.com>
 <d3765c8e-3b1b-3ea4-8612-34b8580bc892@meta.com>
 <20221104074248.olfotqiujxz75hzd@apollo>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221104074248.olfotqiujxz75hzd@apollo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|MWHPR15MB1470:EE_
X-MS-Office365-Filtering-Correlation-Id: be3cda33-d60a-4f7c-dd3c-08dabed38e41
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfDjAwge1mV4Pm8uH0WHr73J34cNutRlJWati0DOry8dzzdXsMBYrhHleXy3cL7ZDhI/R4PckafBv9rq4kFZQCnVJsRUom1iNhu5yGYw0Rkp3Ill9auUg1ldoKJe4YIyH4/2+RBEvpsN/t+U1p5pzBI0rBLqBU1hxdBswct14RJ0PO/FCY7ZA7lXxNb4IuJb9jD1ocCYPWOMocnVpSjBgJIuVXCMC9BX15YWOZvCbZNA76tTzUztYHoQAIbY5DWLE8cU477qVgfdzF4T3yunqEcxX+3RsNHcmCrhKGjNlVPzTMwJ9xR4+GRF0nvrStjrxmxI4XmDdx/W2yiBbKe1ALbcyy6Jaxr84c42ZVQI97O72c0z5Oj/dXl8sHzqpicztyU863IBuY7t7qErhCH5ZbHBWKgd5MuhYZ80KuRa5yisNRupIzoT0KLBQfSvcT3k1CpFt5Q7m6vCqY7VPvYFfAIsiu9giHGmxmGC2Raieu5aSos4Y9FQu9eeYtW8Q+g8PKKSa7jxTBSp5bZaLSyYHFJbj/PmLAfgerNloxGZcMk8bMCJ7ChjhMyhsuV2u6XA1+UQcD+5WBVAx3edL3/4fbfoVHEwxVpSV3fImyTVl+lCnINnezfA6Q/3Zz6KtAXBs3hTWqaQWvRCiH5JzxYdlqMy+XmqweKIBeYDbo8Yps5409IXfHt4yLxpu4oGDLBH7UkVJmhM2dq3CPcm7mlqz04xcPvZ4/LxCwQa6TmhWv9IqPoaHtn7y7vOW4TnNmjtNlpcE3CF758Zn/++4CmLFrax/t6uMsAU+acfcP3wmhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(6486002)(478600001)(31686004)(53546011)(8676002)(107886003)(6506007)(316002)(6666004)(54906003)(66556008)(4326008)(6916009)(66946007)(66476007)(5660300002)(186003)(38100700002)(2906002)(41300700001)(8936002)(36756003)(31696002)(6512007)(83380400001)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1k1NFVqUGIxRjE2djMzeXlmWnlzY04vMkV5eUl2bW12RXpGaHhURlY0d0Ri?=
 =?utf-8?B?bGRWaVNtK2ZaQytZSThoN29KMDlKT2pPQmpCUmg3NXNIWlZNUFo2anI0NC9L?=
 =?utf-8?B?ZjRrRGRwTlMzVnkyeFM3L3dLeUFrMDl5dTZwaW52azEvWFRTcU9qb3ZjWW94?=
 =?utf-8?B?VzQvNm5YWnRhVm5RclNET3VpcTlaRU9sczFvWjlXQXFRbnVnc0srbkNVVkdZ?=
 =?utf-8?B?SUdQNm9XWlZBOTVJYXppUkMvNUowRFkrcXBiU04vT1o2T1BDVkFKd1p4Vmd0?=
 =?utf-8?B?TkVtbVVKNEJyNjR0b0pHNXlrb0xXL3NvZ0F6K25kbXJNNE9yQThUMnNpc1I2?=
 =?utf-8?B?Z0VUUS9iZlM4YUh1WWFYcm1aMEFNd0lUWnpobnV3NEEvdm1hNFNHbG93OVVK?=
 =?utf-8?B?cDVTYWpVMEFSSHArUTZtK3lMd1pYV2piNXh1VmQ4cHowdFlXZmFHd0tZZzlY?=
 =?utf-8?B?NnUvMmhxemR1OTd4YmhqM0s2L0FZQW1oYXg4RTZWRWpsUkI1VWlEOXgvUlp5?=
 =?utf-8?B?cjRVaG4yY1lvRTBxZmRQeFV3bkhoUUxqazJHS1hVTEVySEZyNDVaOUtMV0tP?=
 =?utf-8?B?d05JU0w0dC9ZUjhrQ2NhYmVVbEp4Ryt0aWxDZ3RUdlZkQWFBQWVwL3k0N09J?=
 =?utf-8?B?NDlFeExzMnJkRlJnbTFJeTk3SkNXTmtFVG1NZjcyZ1lZVTZhQTlOK2Y0cUh1?=
 =?utf-8?B?WjhNTkxDKzJKS2Z4S0EzM3lpTDNHUm4xL0J3RWpQYWJ4SjByWUtHdmZpNDJT?=
 =?utf-8?B?VUQzSkkxMkl5WDNqTGg3eFJIaytjRHpWbUROcU0xY2NHMWlTK3ZFQ2kzZkFj?=
 =?utf-8?B?QU5NRDJwclFqOUlBVDllYzI4RjZGbFZLS3hLWjcraDNKeHhlUjVSTDMwU1ll?=
 =?utf-8?B?M1BXaldpWllud05tZk4xREZrSlRhV1U1b3I1YUREWHQreWZVZnpnOGczenA3?=
 =?utf-8?B?SlpHM2oxaFJXTjlNZXRHanlhMSt5a3JPMkcxeTV4bm9pRy9BUzEyUVhyV0JN?=
 =?utf-8?B?OXQyMWlRS0N3L3RFcEZOZHhweXNqNldJRUFZckgxdWFCeUlsL1ZMdzVYVGFa?=
 =?utf-8?B?eitrRTJKVnFWS3VjK0dSYjBtbVpaM24wUkFIY3BWbWhwOUExNVgrc1FMTWRy?=
 =?utf-8?B?eGc3QzIyQlhCcUFCcUtGbktFV0tlVUZtVW1mUW9zVU5nd0ViUkI1ZWgvK1RC?=
 =?utf-8?B?ZGc3bnBtajl5ZEFva0JUdTdpL1c4aUpoWitabDhvMWViK2hQWTNDU2ZCdnFM?=
 =?utf-8?B?RS9GdnlwcTJRKzVLQ28zWkVpSURCNEdwY1B0SlgwdVFkU0xqWVo1UzBvWXp6?=
 =?utf-8?B?NDZhRWpyTGoyNTJST3drRmZlV2gwR3NjK1hWZzRiNHNKeDNncnNLcWtiUjR1?=
 =?utf-8?B?amwyaFNiUzJoVXQ2eWw0TzkwK2lSbDZqZjZsa0E4QzBJWFI2a29MdHoyM1ZD?=
 =?utf-8?B?TWNmNWRiZU9aTVA2WVl5UEtwWThmQ1BBQVFXWDBlZkdRZHdNUU1pZDZpam9E?=
 =?utf-8?B?bzFXOE11MXVpYlVTbTlTU1N1Nzd4UHRaMGdNUHFVbkJGakdqaFRFUjl6bkNV?=
 =?utf-8?B?V2I4anFDTFhtNjFhYTlacW9BMy93eHRwbVgvV1Qvd0hONGxHSXo5Kzl0NHds?=
 =?utf-8?B?bXMxKzBhOEYxN3hZelAyUk9ZNFdQbFhhWXdMbmNVZm5sWE9tY2lSQW5PNE0r?=
 =?utf-8?B?TlExOXZHbXNPUzByODJkSmpMblBTak1qVDBSeTJraVFCdzVGVU1qSmxuRDRu?=
 =?utf-8?B?RWQ5Y1JVeHFlU2xQYmRLY1ZST1BsWklPYks5ZnEzWjNWcTZxM29NZzI4YXlE?=
 =?utf-8?B?T0F2RDJEcnhXUm5kZ1o0R3NyTWNHclZ5RUdNZTJMTTlydlQzdVVjaWdUdG5S?=
 =?utf-8?B?eklsOVVuclY0WCs5TGk1UE8yNjdibGJsUnFndjhpeEhKZG1NMUJNSnZuVHdR?=
 =?utf-8?B?QWhoK2plSGlBRExia0tlU2lVcnM0TzNkbkZpYTNTQnFLZ3I2RExxWk9zYzJx?=
 =?utf-8?B?RE5tOHgrd09Lb25OeGVQSVYzNHZxc0NtclhVZWVFZFlHbEY2TlJ5L3JvTUlp?=
 =?utf-8?B?dnlLWlJSL3VKTHdXcENvQ2JkdWl2cmtna1l3b2pJVnZpSUYzZy9yMGp6d0RS?=
 =?utf-8?B?UUFzRjRCVjBBQm5EZk5DRlNVUFRYSkhRMlpnZUtrOUxBUEpmZlA4MjdVWk1J?=
 =?utf-8?Q?HRT/fHvldRqcjdUYGj6AGTg=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3cda33-d60a-4f7c-dd3c-08dabed38e41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2022 02:15:06.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcK+Mn5k/PafDcEig8Va1Nf/IL3qdwI26zrzlFrJF3meFXngGzPnqzyf/AjsbkXzjzeggqGv7OGcn+sxkPcoDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1470
X-Proofpoint-ORIG-GUID: 0vJYNXKeXoRIKnFot8_EXbb4gytpIebN
X-Proofpoint-GUID: 0vJYNXKeXoRIKnFot8_EXbb4gytpIebN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/4/22 3:42 AM, Kumar Kartikeya Dwivedi wrote:
> On Fri, Nov 04, 2022 at 11:26:39AM IST, Dave Marchevsky wrote:
>> On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
>>> Add a linked list API for use in BPF programs, where it expects
>>> protection from the bpf_spin_lock in the same allocation as the
>>> bpf_list_head. Future patches will extend the same infrastructure to
>>> have different flavors with varying protection domains and visibility
>>> (e.g. percpu variant with local_t protection, usable in NMI progs).
>>>
>>> The following functions are added to kick things off:
>>>
>>> bpf_list_push_front
>>> bpf_list_push_back
>>> bpf_list_pop_front
>>> bpf_list_pop_back
>>>
>>> The lock protecting the bpf_list_head needs to be taken for all
>>> operations.
>>>
>>> Once a node has been added to the list, it's pointer changes to
>>> PTR_UNTRUSTED. However, it is only released once the lock protecting the
>>> list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
>>> active ref_obj_id, it is still permitted to read and write to them as
>>> long as the lock is held.
>>
>> I think "still permitted to ... write to them" is not accurate
>> for this version of the series. In v2 you mentioned [0]:
>>
>> """
>> I have switched things a bit to disallow stores, which is a bug right now in
>> this set, because one can do this:
>>
>> push_front(head, &p->node);
>> p2 = container_of(pop_front(head));
>> // p2 == p
>> bpf_obj_drop(p2);
>> p->data = ...;
>>
>> One can always fully initialize the object _before_ inserting it into the list,
>> in some cases that will be the requirement (like adding to RCU protected lists)
>> for correctness.
>> """
>>
>> I confirmed this is currently the case by moving data write after
>> list_push in the selftest and running it:
>>
>> @@ -87,8 +87,8 @@ static __always_inline int list_push_pop(struct bpf_spin_lock *lock,
>>         }
>>
>>         bpf_spin_lock(lock);
>> -       f->data = 13;
>>         bpf_list_push_front(head, &f->node);
>> +       f->data = 13;
>>         bpf_spin_unlock(lock);
>>
>> Got "only read is supported" from verifier.
>> I think it's fine to punt on supporting writes for now and do it in followups.
>>
> 
> Thanks for catching it, I'll fix up the commit message.
> 
> Also, just to manage the expectations I think enabling writes after pushing the
> object won't be possible to make safe, unless the definition of "safe" is
> twisted.
> 
> As shown in that example, we can reach a point where it has been freed but we
> hold an untrusted pointer to it. Once it has been freed the object can be
> reallocated and be in use again concurrently, possibly as a different type.
I think this patchset prevents that example from passing verifier, provided
that bpf_spin_{lock,unlock} are added in the right places:

  p = bpf_obj_new(typeof(*p));
  if (!p)
    return;

  bpf_spin_lock(lock);
  push_front(head, &p->node);
  p2 = container_of(pop_front(head));
  // p2 == p
  if (!p2)
    return;
  bpf_spin_unlock(lock);

  bpf_obj_drop(p2);
  p->data = ...;

After bpf_obj_new R0 is of type ptr_or_null_BTF_TYPE with nonzero ref_obj_id,
let's say 1. 
After null check any regs holding p have _or_null removed.

After push_front any regs w/ ref_obj_id==1 become untrusted and have
release_on_unlock set. After pop_front R0 is ptr_or_null_BTF_TYPE with nonzero
ref_obj_id different than bpf_obj_new result, let's say 2.
Null check works same way as before.

After bpf_spin_unlock all release_on_unlock references are clobbered, so
p->data will result in "invalid mem access 'scalar'" verifier error.

Verifier requires list manipulation functions to be in a critical section
and doesn't allow bpf_obj_new or bpf_obj_drop in the critical section.
p2 == p but having different ref_obj_ids is OK because only p2 will escape
bpf_spin_unlock unclobbered to be released by bpf_obj_drop, and no free()s
are allowed until we're out of the critical section. So by the time we can
call bpf_obj_drop we only have one valid reference remaining ("trusted" one).

My OBJ_NON_OWNING_REF stuff in rbtree patchsets had same logic, IIRC
only difference is that my "add to datastructure" function was considered
a RELEASE func that also did an ACQUIRE of a release_on_unlock retval. But this
was before static lock checking discussions, so the RELEASE/ACQUIRE could fail.
I think directly modifying arg reg like you're doing in set_release_on_unlock
is cleaner.

> I was contemplating whether to simply drop this whole set_release_on_unlock
> logic entirely. Not sure it's worth the added complexity, atleast for now. Once
> you push you simply lose ownership of the object and any registers are
> immediately killed.

I think that being able to read / modify the datastructure node after it's been 
added is pretty critical, at least from a UX perspective. 

Totally fine with it being dropped from the series and experimented with
later, though.
