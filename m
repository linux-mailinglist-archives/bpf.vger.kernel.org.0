Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386D258449C
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiG1RJJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiG1RJH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 13:09:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3CA6173F
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:09:06 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SEnimV023768;
        Thu, 28 Jul 2022 10:08:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LvdCpTiAnW9veRjteFzL36yPuAJU50T97tHIg3GKYfg=;
 b=IRRUVW1ZqNJ6un0HzlZ0Hc/4nzHalm6VQso6sn+DDnfUD2OWpyp7Viy9nrxdM5Z4kDbO
 H06qrTZv69XBx3DONWeDOgVLOBEqYwaECNuvaWf0FM5B21LLCNmR55FTqOkwszgEcS2P
 DiQ24Qv0zEBlP9SkhnTpfy30uuDVSkmahHk= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkst127rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 10:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqe4PF3iDnwYBEgRDOTt6JZfYmdQRqPAM1McRIy0SvjntYvpzOX0FP2p41OR8rDtbECoFwmHFMJq0/CvDfH9Yg0aEhJOeQgjwsKZOQcEI5bXPFNI7cjlOx/EWdx609GclvpQA2t4JLAEN4TwiB+bfSmFqdgAaXOyuvmxiRghfBtz/3s5akj09aMFGoKlIjdd29yMxNZDt17xDKaiidQQqugVIAtDK8Hc08tFpVpOB+8Jg+PGNsSpCJ8l/8BOhfHp4H/xMCGEJA835UhmFMBtm4DWyTC9l7h5s4G2Basf3rudqZf/QJ/gTv7MWq7dqFlgzag8dBmCPYZ9vCoDItbzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvdCpTiAnW9veRjteFzL36yPuAJU50T97tHIg3GKYfg=;
 b=A3n0SRgmULa+ov2PeP+AwlUR64xj/JF3zRoafExJIXF73akt18AZIs1QkB+GaWXM9qPzVmcJEvq1JbPRxTJ3BdcxV3qU7MHzMHEk9n4CgG2OntBLRLcp6/RvCoueOgkKkdadlQCw3mPBLXZoNRRfMGZ8d6NCE5NcPbhyE21fX1Fw0RNxmv+5t2jcdka1Dp38niO+YpJqQEFxW0uGTAiNdb4yjapWrwAg9LmOCrjZ8kvBZAjgxZ2qeyjAWAeucj3Am/0vwQRdyvW5u5aOO+icarA/Sc8YywgMgq9XfHlT/TKTUV90wBlRJaUO6A82YluKtDECB+6cJ+X8HzlW4G3hkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3020.namprd15.prod.outlook.com (2603:10b6:5:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 17:08:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 17:08:49 +0000
Message-ID: <555a171a-9855-e827-878d-e75e533f72ad@fb.com>
Date:   Thu, 28 Jul 2022 10:08:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>,
        "memxor@gmail.com" <memxor@gmail.com>
Cc:     "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
References: <20220726051713.840431-1-kuifeng@fb.com>
 <20220726051713.840431-2-kuifeng@fb.com> <Yt/aXYiVmGKP282Q@krava>
 <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
 <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
 <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
 <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com>
 <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
 <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d909868e-e0f0-4ef4-fc08-08da70bbd69b
X-MS-TrafficTypeDiagnostic: DM6PR15MB3020:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/tW0aqJxOJNpv3PLNnM0FqSPnTWT6fAHa4Pf2x83AorUpAh/hrA7dBuhZVa8cn3gijyG/ii200nH7+vHnDC3pCNAMOqw1cvxEO2cw/tOajtTDhBZHI+AAxEvULJYx+3hCc9QOuzgrzJexXZ9OpRxWC3PTBdj2ej5jLRnd6E/OlHbZ7ZF+TaOgzXqCZoXma/QNQcvrlZNGFNCCt9zEwb8w7lq/GWxnNKQKLqzThLOwlpVJOn7Wsbv2Fxyv2oiVKC2+4NGJvx3TZqylXY9N4faZi/nqa7ZbYks4s4enThmWsasbhs0ewKXor3mSEpe8PDRLxGHWDCt8imYCp/oSgobO7yQDT0XyTmb6ZMGH9HCstYGq8aYyVGNHMYM0iwkBfEghuqIPxOjTRQlxJCVbMP1jI/C6c9Ct9fUGolkaEfXPjK3TlKtqYy98sqFR0ZMIYBi9II82CfbT+Ckf0il+fZniprau0u8o0HSNP31xJKS1iCY+x39rz+RQLjZDbelAzU1SAiZYlR0aFthfVCvf4koipseN9xmeOMHvpyucE4c2a5nWFLELfvLuMjRnPC0zGSY+0tWJNfH+NMB2Q9c9StriuqviyvPDHngF3cNDZSRQ9CEl4bYISlr7nO7PiIm7UECYwqWfv+sag2eBXaRZoK6Z+7/1Zg+Z32oD48I5XdOh7HIizkUE70GMKvmIGOt+/yfzOxoSf46F6GoLaAbuEDmxxz69EwG2/PpFPsh09Q/J7zp09Tp0R04WgBFhc7C/RntKS3wS2+H93a9BSb8KbAIPKz1QMCwcdtGk/3kfexnbeq80l42RnERSs0YNff9UzdwoKgL4FwfkhXg35QLaMZHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(38100700002)(41300700001)(5660300002)(6486002)(8936002)(478600001)(83380400001)(66946007)(2616005)(66476007)(66556008)(8676002)(4326008)(316002)(186003)(53546011)(110136005)(6506007)(54906003)(6666004)(86362001)(6512007)(36756003)(31696002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1huNWFkeXBMQUJmTGpPZk1UMEhIWXBnZE1iVjErMHhDWGFIaWl0bWFmMFcr?=
 =?utf-8?B?eUZ6K1hKVmREUVFFbFlnWm1keTh1TTVHeVAwOExnU09Cczlud3BJend3Vmdm?=
 =?utf-8?B?OFlJUm0yODZJbWFDN2owTTNCNjFKV1pFS3FBc2ZDN3I0YmpLbE9JTnpnNkJE?=
 =?utf-8?B?UEN5MDY0c0VCbnc3QnNzc2VjZENUcUk0K2FNK3RVT3BidlhoZTJ0ZzBkbUVh?=
 =?utf-8?B?dG1lN0hhOTRtQzI2Yndzb3FWdVhiaER6RFN3TkwvZXVUTElSQkJ5ajg0Yy96?=
 =?utf-8?B?TzFDR2t5Um0xRXpWSkxSOVlnZE5yQjcvMkhQRVViMWZBaDMxWTI5bjRHRkd0?=
 =?utf-8?B?QnFrajdiODRmWHZxRlNVN1ZTdmFwSzJIcEdMRzFoZ0xmbTVnMWE1VzRsRE5v?=
 =?utf-8?B?dm40Y0V6OU94WVUwaEdFOUZKcHdySFY5OVp6QmdJcVNaWVRtMXRiV3Z6RFZt?=
 =?utf-8?B?L2N3dlB2cUlSeS9rb1l4Zlo5c01RWDVDV2RRdDNVaTBwcVRhV3VkdEx2Y2xo?=
 =?utf-8?B?WjI2dDhaeUNmRHpPQTVUUWUxUUJjU3dBbmZqeFdqeW9DRm5LV2pKYlFla1Vl?=
 =?utf-8?B?WitaVklGeWtwcjFlZnAraUt4bnkvYkFXUk9sbG1FKzFGWWNZOTRQM3RVc0Ir?=
 =?utf-8?B?NjhnQWc0bUkwUjdJVWVwUVI4VXBTaGpzclVMMWgwb200VXpTWXN5TnRLM1ls?=
 =?utf-8?B?ZXp5OTg3TjFNcGRHSnhnNDNQWlFwbEViNUlRM3l0dSszMmYzRTNvZFhxZC81?=
 =?utf-8?B?MURLeHFhT2l2WllvQTFCQUpDNlBVNURZYTNiTmp3L1dBekpMbUlwT1IxNnU3?=
 =?utf-8?B?WVV2UjNOSjVMd3EzdnRrOWtvbHZlallXeWcyOU5zQ09OZDZpR20yeG9YeFRv?=
 =?utf-8?B?MStjQ3VBc1hnRkNzZ0JDY0haNmI4THFBblppSmM0Q2dmQWE4aEdiUjFPNDJr?=
 =?utf-8?B?ZFFmbHNOb3FhSGV4alZXTXZpWkdmNFZOQTQ4SkcwTzZNN2dOZGtQVjRBZWZy?=
 =?utf-8?B?dDl3WEtuL2JsU3RGTXNFU1RheWsycEt0R2tRZ1R5N0hVc3JiOWg4UEczUmxU?=
 =?utf-8?B?ZURub0hUT1U3WGd5VG5YaWRRanc1bHFadGlnRG8yY3RuYUxWMlFuamZBRjhF?=
 =?utf-8?B?Vmx1RElicFdKMGlFcVhsQlVUbVRqelpiVkY0K2tmbCttbGlIc0oxV0NTRGRP?=
 =?utf-8?B?bTJmMC9udkk2Y0plVWNIL2lPY2ZTUWFhTGY1Y0hUempzR1JPQ3RHb3JLa3pV?=
 =?utf-8?B?YitVc0xhVk8wS1UrSklzMlNvdklMbjhxRFJLSDNVNFUwZGV6aEpjR1pPcTIr?=
 =?utf-8?B?VjlZamYzRzBrdVFZWVMrTGM1ckdYYnJKNndUdTBUNzYvdkdZS01PYjFlZ00v?=
 =?utf-8?B?OUovZXoydk1sd0xCbkdTZUN3STVxTUVtbFJScmpJWXZPdmRKRG8ySFdlSFkr?=
 =?utf-8?B?L0puVlQ2QUZ1U3NZY2FJTmVpL3hWeVltaHE3QnByUkVKTXlZQ0t3T000V0o1?=
 =?utf-8?B?aWd2ZDM1UVBka3l3RlJiYjlsZTczaDVMc0JOVXVBYnA5RHh4NjJrdU1XOXg1?=
 =?utf-8?B?TFlDTXBjcE8zY0I1QytBNDNRdnBlUVY3dm9wcGVZSGxCeStqUnNBMWRHaGxz?=
 =?utf-8?B?bzFqcFRVZjBiNVREbnN3MGJtb2pCSWd0dEE2a25VZ2J3cVlQSThvNmFLam1W?=
 =?utf-8?B?RVg5MWN4SVdGS01XclNOY2EyeWVKK1pGc3BndmpoNVBnZ1FiQnFpbkpwdzhv?=
 =?utf-8?B?RE1DM094SmdUS0RPTm9PYVRoemhpVTB0V2NXWVd1SFJjaERZMXI4aDgzUlMz?=
 =?utf-8?B?U1B2Q2dCVGp0RnhqcWJpbkk5anhldk56RWdCMmNTOHBvTXFxVit4YlFKZzhy?=
 =?utf-8?B?UDZ1d0ZsT0RhWlJGT3BYQmVoWmhmQ0pML3crSGpsWG5pWkxMUmVJeTFta2t0?=
 =?utf-8?B?bE1oNWl5c2dacDR6QmdYWGVsZDJEVXdYckk0ZEpEMG5VY2V3djAwSXVxVVJw?=
 =?utf-8?B?bnFzVk1PeFdqZTJYK3VNd3pMQkZQb0hrMGIwZFlTNmFxU1JlaURtV1hjQ0l5?=
 =?utf-8?B?ZG1iQzJzQy9iZ2x0N2hIdWxzU0ZmV2Y4U2xLRjlTeFk3V05BVDU1WVNlT25X?=
 =?utf-8?B?SWNvQnI4c25uZ2QvSGZOczBodDJCK1g3Q2NTdG1jY3IvVExHVk5iL2dKU2lO?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d909868e-e0f0-4ef4-fc08-08da70bbd69b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:08:48.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgscGQUlbWZcr49CaBVaCHg4T+ACdz06G42PT7ovd1B7NwD+EUk705Uqkwf/wb03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3020
X-Proofpoint-GUID: ARMwDV-jPWtL0cfSjgoEBT22SbzQ3Nvw
X-Proofpoint-ORIG-GUID: ARMwDV-jPWtL0cfSjgoEBT22SbzQ3Nvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/22 9:40 AM, Kui-Feng Lee wrote:
> On Thu, 2022-07-28 at 18:22 +0200, Kumar Kartikeya Dwivedi wrote:
>> On Thu, 28 Jul 2022 at 17:16, Kui-Feng Lee <kuifeng@fb.com> wrote:
>>>
>>> On Thu, 2022-07-28 at 10:47 +0200, Kumar Kartikeya Dwivedi wrote:
>>>> On Thu, 28 Jul 2022 at 07:25, Kui-Feng Lee <kuifeng@fb.com>
>>>> wrote:
>>>>>
>>>>> On Wed, 2022-07-27 at 10:19 +0200, Kumar Kartikeya Dwivedi
>>>>> wrote:
>>>>>> On Wed, 27 Jul 2022 at 09:01, Kui-Feng Lee <kuifeng@fb.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On Tue, 2022-07-26 at 14:13 +0200, Jiri Olsa wrote:
>>>>>>>> On Mon, Jul 25, 2022 at 10:17:11PM -0700, Kui-Feng Lee
>>>>>>>> wrote:
>>>>>>>>> Allow creating an iterator that loops through resources
>>>>>>>>> of
>>>>>>>>> one
>>>>>>>>> task/thread.
>>>>>>>>>
>>>>>>>>> People could only create iterators to loop through all
>>>>>>>>> resources of
>>>>>>>>> files, vma, and tasks in the system, even though they
>>>>>>>>> were
>>>>>>>>> interested
>>>>>>>>> in only the resources of a specific task or process.
>>>>>>>>> Passing
>>>>>>>>> the
>>>>>>>>> additional parameters, people can now create an
>>>>>>>>> iterator to
>>>>>>>>> go
>>>>>>>>> through all resources or only the resources of a task.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
>>>>>>>>> ---
>>>>>>>>>   include/linux/bpf.h            |  4 ++
>>>>>>>>>   include/uapi/linux/bpf.h       | 23 ++++++++++
>>>>>>>>>   kernel/bpf/task_iter.c         | 81
>>>>>>>>> +++++++++++++++++++++++++-
>>>>>>>>> ----
>>>>>>>>> ----
>>>>>>>>>   tools/include/uapi/linux/bpf.h | 23 ++++++++++
>>>>>>>>>   4 files changed, 109 insertions(+), 22 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>>>>>>> index 11950029284f..c8d164404e20 100644
>>>>>>>>> --- a/include/linux/bpf.h
>>>>>>>>> +++ b/include/linux/bpf.h
>>>>>>>>> @@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char
>>>>>>>>> __user
>>>>>>>>> *pathname, int flags);
>>>>>>>>>
>>>>>>>>>   struct bpf_iter_aux_info {
>>>>>>>>>          struct bpf_map *map;
>>>>>>>>> +       struct {
>>>>>>>>> +               __u32   tid;
>>>>>>>>
>>>>>>>> should be just u32 ?
>>>>>>>
>>>>>>> Or, should change the following 'type' to __u8?
>>>>>>
>>>>>> Would it be better to use a pidfd instead of a tid here?
>>>>>> Unset
>>>>>> pidfd
>>>>>> would mean going over all tasks, and any fd > 0 implies
>>>>>> attaching
>>>>>> to
>>>>>> a
>>>>>> specific task (as is the convention in BPF land). Most of the
>>>>>> new
>>>>>> UAPIs working on processes are using pidfds (to work with a
>>>>>> stable
>>>>>> handle instead of a reusable ID).
>>>>>> The iterator taking an fd also gives an opportunity to BPF
>>>>>> LSMs
>>>>>> to
>>>>>> attach permissions/policies to it (once we have a file local
>>>>>> storage
>>>>>> map) e.g. whether creating a task iterator for that specific
>>>>>> pidfd
>>>>>> instance (backed by the struct file) would be allowed or not.
>>>>>> You are using getpid in the selftest and keeping track of
>>>>>> last_tgid
>>>>>> in
>>>>>> the iterator, so I guess you don't even need to extend
>>>>>> pidfd_open
>>>>>> to
>>>>>> work on thread IDs right now for your use case (and fdtable
>>>>>> and
>>>>>> mm
>>>>>> are
>>>>>> shared for POSIX threads anyway, so for those two it won't
>>>>>> make a
>>>>>> difference).

There is one problem here. The current pidfd_open syscall
only supports thread-group leader, i.e., main thread, i.e.,
it won't support any non-main-thread tid's. Yes, thread-group
leader and other threads should share the same vma and files
in most of times, but it still possible different threads
in the same process may have different files which is why
in current task_iter.c we have:
                 *tid = pid_nr_ns(pid, ns);
                 task = get_pid_task(pid, PIDTYPE_PID);
                 if (!task) {
                         ++*tid;
                         goto retry;
                 } else if (skip_if_dup_files && 
!thread_group_leader(task) &&
                            task->files == task->group_leader->files) {
                         put_task_struct(task);
                         task = NULL;
                         ++*tid;
                         goto retry;
                 }


Each thread (tid) will have some fields different from
thread-group leader (tgid), e.g., comm and most (if not all)
scheduling related fields.

So it would be good to support for each tid from the start
as it is not clear when pidfd_open will support non
thread-group leader.

If it worries wrap around, a reference to the task
can be held when tid passed to the kernel at link
create time. This is similar to pid is passed to
the kernel at pidfd_open syscall. But in practice,
I think taking the reference during read() should
also fine. The race always exist anyway.

Kumar, could you give more details about security
concerns? I am not sure about the tight relationship
between bpf_iter and security. bpf_iter just for
iterating kernel data structures.

>>>>>>
>>>>>> What is your opinion?
>>>>>
>>>>> Do you mean removed both tid and type, and replace them with a
>>>>> pidfd?
>>>>> We can do that in uapi, struct bpf_link_info.  But, the interal
>>>>> types,
>>>>> ex. bpf_iter_aux_info, still need to use tid or struct file to
>>>>> avoid
>>>>> getting file from the per-process fdtable.  Is that what you
>>>>> mean?
>>>>>
>>>>
>>>> Yes, just for the UAPI, it is similar to taking map_fd for map
>>>> iter.
>>>> In bpf_link_info we should report just the tid, just like map
>>>> iter
>>>> reports map_id.
>>>
>>> It sounds good to me.
>>>
>>> One thing I need a clarification. You mentioned that a fd > 0
>>> implies
>>> attaching to a specific task, however fd can be 0. So, it should be
>>> fd
>>>> = 0. So, it forces the user to initialize the value of pidfd to -
>>>> 1.
>>> So, for convenience, we still need a field like 'type' to make it
>>> easy
>>> to create iterators without a filter.
>>>
>>
>> Right, but in lots of BPF UAPI fields, fd 0 means fd is unset, so it
>> is fine to rely on that assumption. For e.g. even for map_fd,
>> bpf_map_elem iterator considers fd 0 to be unset. Then you don't need
>> the type field.
> 
> I just realize that pidfd may be meaningless for the bpf_link_info
> returned by bpf_obj_get_info_by_fd() since the origin fd might be
> closed already.  So, I will always set it a value of 0.
> 
