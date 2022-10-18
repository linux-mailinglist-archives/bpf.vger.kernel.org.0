Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F2603269
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJRS0w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJRS0u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:26:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA6857256
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:26:48 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IEObBA028893;
        Tue, 18 Oct 2022 11:26:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZbZp4UQ8GH7ujp54JydfS0Wou6ZgC9AX1ghowFGQR+o=;
 b=fIkUaSiRFuh3T1CO52xIj9Yx/8J3SJvJJDrnQOFO5+F6ry95XP8otf7QSxHhy6bwM9uo
 VNKUX7K9Pl1dgxpZgYsGsaBVqeCVU9dJg7IxP821ZuBd3hwecpMe4iLBKThbPGvgBQJp
 11l0ee4aiUiom3DdI4pg4hpueJCZBJyJqlGsOT0ohJr3EGp8e9nUuHeStvJ8gzUMeiL7
 oZYe1hFWC10DbMMZoynk2AZLYaxepJ9g+gaM4yAIb1MAk1R3yHHmWoQZr467Yvf41sq+
 sV5/k/Etll2q0KwvWqLqSCWEumU7m/9Anan1znVQt6xfUPbL9xteKooI73zp+1HtUPCY hg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9j40h9qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 11:26:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8PZQMpUHOu7xt6IoWFU3WWZ2G2cXODKqShhgvlX9iCJAJ595zT+ELGdV8nWrzRrRuV3tK8SNC/MfkWclUEg1gyBhYdRsbGq1Ik6NqkzLOHqTZX59a5IXocazVtaQFrWgVPNRdpWG3HhBuUb3nEGGrrBIh40v6LWPc3LMLZnZ6a25BdxJSvttBU1dXEggE9GjpK/ce9dsMPNKMhKGdw/WK45vUfwK5cn4ZnHND1n2N3jc21JTTnzO9q8aPxn9hYIXp/j4kc0vZYYg5lGD+APsOxqykRCVfM7rjxs4K9WzL0aRkkTVxK/lS2qzbVFBEGb2Gll72w7tXv0zAuXboy/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbZp4UQ8GH7ujp54JydfS0Wou6ZgC9AX1ghowFGQR+o=;
 b=b7Hz0CM1E2xvsEzL4YfaVMZtUfozjDZY3RODyA2pEyl+teTAueQ9UP1Yzo4wDLnFTgjpQr8PFJu42AE9Z1bn95ANOKJMeHseYZqE38M2Wiy9B/K4ES5y2Di9AGs+5bcnK8mpeEeS4mfrQbrjjpoKrbfZjDDXM+g7+/uKoNrFPAx3iqIWrJz/oa6zZQKCvrn94OyvqqBQCqSI4AafEXbO1vaZEcReOK/oufapHnSUg4wX+cBgj6JKi/5k22tOV7hSOBMl/TPS432lvhMnWd4vFGy7ngSpX5vK9Cz2VMaEQRNyjWw4CUEh5Det4q4m0czvV8Us3p6NwCGUxolVex6JFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5739.namprd15.prod.outlook.com (2603:10b6:510:279::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 18:26:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 18:26:25 +0000
Message-ID: <da3d44e2-4d3e-89f7-35f0-849f6f603f05@meta.com>
Date:   Tue, 18 Oct 2022 11:26:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, Stanislav Fomichev <sdf@google.com>
References: <Y02Yk8gUgVDuZR4Q@google.com>
 <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
 <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev>
 <Y03USAeiBL5Ol22E@google.com>
 <06e37b29-b384-7432-d966-ad89901de55d@linux.dev>
 <fdc0484e-c2da-a118-b845-f937f0ef5688@meta.com> <Y07dlsqt9u3BYF2U@google.com>
 <CAADnVQKPMaU5av0soDh+ddnqpLbjDHEVyFpK9hX4g+99cBiJdQ@mail.gmail.com>
 <67048049-dee4-3ff0-035c-65af34555725@linux.dev>
 <CAJD7tkY5DZK9uO=rnNWTFoHU3qnbsj74engcC8VYyzQaJm1PFA@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAJD7tkY5DZK9uO=rnNWTFoHU3qnbsj74engcC8VYyzQaJm1PFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:208:2be::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 62aaa00f-1dc3-46b0-d447-08dab13643d7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFxr+CaYNStbtlHBYrXlPfGWlU0gEdwD5l9vNUhmBSpeHevtig9UEgc5ORVUe38emYgK4SxD2JG3XjCtfFZ5J/WfZOWeRXbMJOE6etL6HD3gYZbLrdH10GxGw0I9K+Etz6yAj9FlRcgSA8ap/v0duAYaooK/CgYju8+YCOyQWV2LQ7e/gB63xL6UnDALc8yFQgC3Zxe9OPrkQ184E3AnilMdItpy3q8abAueRwICg2yaa4S5HZmeqsLBT3X4ltIyBGsdIoyQ1z9WXSDhlDcYPanPTvi1w2445edzpci5JhsS46Lq/VbJLopg2bMHc6CRlvCgnDzF6/P7B1X4blp5JYVA1nBFjjNCnddWTAIh3I+qVv/HlqJwL9np5B8cZyMB0HkRDlNK9YhwFM5f9gJvexui0PlRJDqPqHjXq+qfJREPkL5VTEaUItBrTCMIYz9Wn4x9Khcw0hxNDdqfEL3Ih/0DjTIM4P1axST+39rt7B8goeSfyy+LhEhKbxufaKEdLBlj2q4gdiqJpem4ByNFoVU5Dh89X4yzqOSLbbqsZadf0ZmzXKGm+ruI5x9jrdK75DbzcJdfEzqyyQM038noDKEa5p0GoosMUuCgS0PGrPMWVuQ9ZKJEcnlahyLGIzIallw6nwi/+n2Vj1RDGHFW4ocHTJzddPLwlchZkTuTnTKLCXHMosKfyquuopSW9iceQfemc1O8x6I9P2agoqrW42pNJyfR40NFlAYHE5se5XpskgVtOmDs3EgMD9DODk70BFRBiPt90noHC6MamgOkVCofrmNtuReoyTQbUsQaRoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(186003)(31686004)(2906002)(6506007)(5660300002)(54906003)(316002)(53546011)(38100700002)(2616005)(86362001)(6512007)(41300700001)(6666004)(8676002)(66476007)(66556008)(66946007)(7416002)(83380400001)(31696002)(4326008)(8936002)(110136005)(6486002)(478600001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWNtc2ZHam5ISDFqMEN5aWVXL3FIMGMwOEtkblJRZHpNWTRiU0x3UWRKa0d5?=
 =?utf-8?B?eTRFd2hNZDRseHpLSlBmbEdLT1M0Z0M4UVY4eXlaZDJlelNXTkxWSkdMblNn?=
 =?utf-8?B?bmNJc20wSnFkNWtoSEpwVWN3bUxKNEZ5b1lZWHBreThKaFdlQUFWSzdWV3Bs?=
 =?utf-8?B?MUhGNnFId0ZabG4vY3ZNZGh1RW95SUJzNzF4c3pUeUpJK2RKb2s3dkNhNkta?=
 =?utf-8?B?WHZVWjl0RzBNMFRHRVo1aTZ5eGhMMlNrakZvZVY2VnRNTS9neEpoWlMyZWxG?=
 =?utf-8?B?U0pFOVNYc000N0ZiN3g4MkxtYU0xQmVVMzJwVHRGYVhydzBjZXBxU003UXR2?=
 =?utf-8?B?dGF1Z1VkM25tOHg0RVdOcDR3bnJBMXEwVnFzVVBPaWM2Tmg4ejRXM3l3TElK?=
 =?utf-8?B?ZnU2WVFCN1VmV3U4WmVwTnBhSXEvM1pGeXRSdnpKNTh0QjdJZWJEanAvQkZl?=
 =?utf-8?B?d2hUYmEwTlFaVzd1TDY0ZzAxM0lUVzNocnJtYVFCa0l3bHRadTR2dXYwS3pa?=
 =?utf-8?B?ZFhVTFQ5WFFYbnRodmlKMnRDZnYrcmFETFZCUGI1ZGJmQ0M3bjR6Vy9BcFRs?=
 =?utf-8?B?TWJBL0FWdE9NaVhKSlRkZ3ZzOTJzVHg3THdiSU5zMTRUWmRPT1hLUEs5WFh3?=
 =?utf-8?B?T3pGZEIrNHNHSnlTS2FYelIzblVIY0RkdEs0c1JBeHJyZk9vUjV0ZWk5QWtv?=
 =?utf-8?B?Uzk1SGswbEl6MVRwUlVPL0NpYWhVMzhNSFc1ODg3eHZ2Z2RwSzhqV0VTWFBB?=
 =?utf-8?B?djV4MkF3LzNFTGIyc3VSQVAra3RoUGl6VngrMkJHWWhVY0FicnUrWk9tcmh6?=
 =?utf-8?B?Qis1b1FVL0dsZEJOZFk4YXB2V0J0TmI3MS9UMGZHNEp0SzZoUW1sWTlCTHB1?=
 =?utf-8?B?Q3Q4QnEzUVpxYUpRY2dzZmhJOFJ4WFJEL0xJS1pCeDRiSWpBVW5GRHJob2JW?=
 =?utf-8?B?NDZ4cFVBbGcvVmttWUNzTjBhMjJHZ1Roa0c1ZDdZeHpzL1FJWVI3U0hSajZ1?=
 =?utf-8?B?Zy9GdXBUL0VHZ0pwQVkwL3psVGRCWDBlSE9mSkNsdUFvUjNUZ2lJUXc4blJ6?=
 =?utf-8?B?YXEyRFVKWElzaEhoOVIrQU4zSW5FWEFnTHNycmJGOE1ZRUs4N2gvK1RqdmdL?=
 =?utf-8?B?SFpTalRLaVB6S2NlN1BVN2ZhNXBLTzlDamZ6aE1KeFRlQ0ZRSWpEUmhpTWtp?=
 =?utf-8?B?UzBrU3JkY290SklBU2RlMU5naVBwZkpxTkhRdzVBcm5mQ2RwYzk1VHNyd0d2?=
 =?utf-8?B?a05zNVNxVGJ0WkUrY1dWVGVRQVNSaGk5bFRpQnp4eXp4RWlUaEhFYkxvbEFN?=
 =?utf-8?B?N0EyQ09paWNnUlN6WnhPRDh5VWtRd1V3VlMzWllBYkxHZDFaMStLZHU3M05u?=
 =?utf-8?B?T0N2QmgycjllZHBoTXlPS0lVVFF1RkVQMEszMUN2WEIxZFFpMVQ4VzFLMVRj?=
 =?utf-8?B?NWRlZTlySUIxaXBwQ3FEMWdaQ3NSVWdGbno4L1UxTlR3TlcxU2RQOTRJSEF1?=
 =?utf-8?B?bVVLaFJxS001dVlBMHB2V3VXRTE0Mi9IbTZzRVZ1YzByN2lWekFMelVIV0ZW?=
 =?utf-8?B?dUJLTG14Z0pFbklkS3pTNVZ1ZWYzZUhnNWZwMTFjRmJObzdiaWd2QURDcE9Z?=
 =?utf-8?B?bzZsVENjd3g4TDgzMGtyb3MzSDd5NnVZcUlsUFhEeUIvUy9jRWtyd0tVb1Nq?=
 =?utf-8?B?V2ZZSzdzYXB5NGt1bkptcGgvMFY5MjE5VXQ2UHgxRGNlVUV5N01jV3kyL3VU?=
 =?utf-8?B?T05KWnBtcnN5WGlsT0lnbmVsWG5WUVE1dXBFaG04Mndnci90Y0VWd25Yb3Rh?=
 =?utf-8?B?RkdHb0xhMmd1WUJROFJvSDRuU3pPamF0RTV5NytZTTA3eUlCMHZzMG9XalZ5?=
 =?utf-8?B?VTU3MHJxaVBudi8vbm1yYTZXbEZYa29MTG16U1owQmJuM3Z6NDBIM0JsNTBN?=
 =?utf-8?B?R3RnNHhiMWdFa2ZENnEwaU1oOG5vMEVwWjRjczV6SjByL1Q5WHg0aUN3Ujkx?=
 =?utf-8?B?dVFQRUFvNVdySzBNL0UvQ3lkZDhBWEs2Y01YMXo5ZjUwTzJaRUFUZDI3TXha?=
 =?utf-8?B?bFlHZWcydXBjSnBGRjczQTczNnlYTkZheHZwZndDTzJWTnNJSWdwMnJPbEtU?=
 =?utf-8?Q?prOPbJlhiMF3nK0nqCGaOCSpQ?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62aaa00f-1dc3-46b0-d447-08dab13643d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 18:26:25.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URur6u3drc0/vK/50nLpNiuFEIBDIoHqzA3FMFaWJ/sLOGT9xJtud42YudzfV7di
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5739
X-Proofpoint-ORIG-GUID: 1VE45f8JUPtoN9mxtKOfyFAwzFUyqMqX
X-Proofpoint-GUID: 1VE45f8JUPtoN9mxtKOfyFAwzFUyqMqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/18/22 11:11 AM, Yosry Ahmed wrote:
> On Tue, Oct 18, 2022 at 11:08 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/18/22 10:17 AM, Alexei Starovoitov wrote:
>>> On Tue, Oct 18, 2022 at 10:08 AM <sdf@google.com> wrote:
>>>>>>
>>>>>> '#define BPF_MAP_TYPE_CGROUP_STORAGE BPF_MAP_TYPE_CGRP_LOCAL_STORAGE /*
>>>>>> depreciated by BPF_MAP_TYPE_CGRP_STORAGE */' in the uapi.
>>>>>>
>>>>>> The new cgroup storage uses a shorter name "cgrp", like
>>>>>> BPF_MAP_TYPE_CGRP_STORAGE and bpf_cgrp_storage_get()?
>>>>
>>>>> This might work and the naming convention will be similar to
>>>>> existing sk/inode/task storage.
>>>>
>>>> +1, CGRP_STORAGE sounds good!
>>>
>>> +1 from me as well.
>>>
>>> Something like this ?
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 17f61338f8f8..13dcb2418847 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -922,7 +922,8 @@ enum bpf_map_type {
>>>           BPF_MAP_TYPE_CPUMAP,
>>>           BPF_MAP_TYPE_XSKMAP,
>>>           BPF_MAP_TYPE_SOCKHASH,
>>> -       BPF_MAP_TYPE_CGROUP_STORAGE,
>>> +       BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>>> +       BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>>
>> +1
>>
>>>           BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>>>           BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>>>           BPF_MAP_TYPE_QUEUE,
>>> @@ -935,6 +936,7 @@ enum bpf_map_type {
>>>           BPF_MAP_TYPE_TASK_STORAGE,
>>>           BPF_MAP_TYPE_BLOOM_FILTER,
>>>           BPF_MAP_TYPE_USER_RINGBUF,
>>> +       BPF_MAP_TYPE_CGRP_STORAGE,
>>>    };

Sounds good to me. Will do this in the next revision.

>>>
>>> What are we going to do with BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE ?
>>> Probably should come up with a replacement as well?
>>
>> Yeah, need to come up with a percpu answer for it.  The percpu usage has never
>> come up on the sk storage and also the later task/inode storage.  or the user is
>> just getting by with an array like map's value.
>>
>> May be the bpf prog can call bpf_mem_alloc() to alloc the percpu memory in the
>> future and then store it as the kptr in the BPF_MAP_TYPE_CGRP_STORAGE?
> 
> A percpu cgroup storage would be very beneficial for cgroup statistics
> collection, things like the selftest in
> tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> currently uses a percpu hashmap indexed by cgroup id, so using a
> percpu cgroup storage instead would be a nice upgrade.

Indeed, agree. For cgroup storage, we could have a per-cpu version
for the new mechanism so it can replace the old one as well.
Will look into this after non per-cpu version is done.
