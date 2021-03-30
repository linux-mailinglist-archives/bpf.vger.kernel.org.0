Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936E334F43D
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 00:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhC3W3W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 18:29:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232292AbhC3W2x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 18:28:53 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UMLKqK002441;
        Tue, 30 Mar 2021 15:28:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=g/iIqOaaZ2OKpP7WODu3Qo9dNFCdYWtc4Jr4wBkWim8=;
 b=NYfhOgnZpy0Qkw3sPIrYB0t+UIgnv+UZvJVxctKCIYk3OYReVUonjje4Hvf1dJgHDBiR
 sgQVhYAYspTIMBD0MW21pGYHnZ0v/fJZX8uby3sm8OxPJR6BV5elpoiQV1ZuELnNPiPD
 zLrDgQ1pSIA6C9ttqbqE8w7yZQHG7O8ELIM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37maa2rt3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 15:28:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 15:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akXXJ4+XJJfoKCI48cbR2gDTeScumOO99zC+cwioEpWOh3oZTmjOOBze/iYYRvbrW8NOipaclxr3/d6ckcNCAjoB9fa2mDf0UK3bfQuu9fg8/C/okjEoo9y46Ne0AjqLohQewrAvLsAgWdycq/WZhUpSDLK02xob2rpn9n8iNDDq/wxV5IOLmCuotzFxZ6B2GsziA55R/5Jpba4PAWBOUud8lfWMDpx4n8jR+Eb+61ovJIKHPyyL7bR+FdUFuPInbaPq5xTJsJYtIAkxhbVYaDNIa/emL/0a7KgJ1qNK4siwAQKUdyEL82/MsEyEu28kU/73pf7NAEyBOjHROj8ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/iIqOaaZ2OKpP7WODu3Qo9dNFCdYWtc4Jr4wBkWim8=;
 b=ihPiECtzYrxQHvaust2cXHZx0AvEyfh1SbQi5dkAxKh77Y6ZnklxQLsIXxBURhSAPR6r0udv83gmQLQC1W+AbMjMiS1soXQ2NsrCM4FFUXCsiGQM/ez+nUUADnPisDOQ78PApKHCWd9CHCt4ZCFkc3hwYP54jMpum5tsJXoKQr0yTEAr9EDS0QDFLPxSbRq7Or36fYC2d4ZhU3SdvgBWzxKJYPMmxIrOl7O7fwApiTzA/LWqfmbuB7KQL22TIB2AGF3whJnViTCXAizizvX3uZSWmjv8D5MCB+Gz6FrtA1si6AN4BOe81vdEIg1R+5ZXpMvtVraB30VkZdKV/wM6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3903.namprd15.prod.outlook.com (2603:10b6:806:8a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 22:28:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 22:28:45 +0000
Subject: Re: [PATCH dwarves v3 3/3] dwarf_loader: permit merging all dwarf
 cu's for clang lto built binary
To:     Bill Wendling <morbo@google.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210328201400.1426437-1-yhs@fb.com>
 <20210328201415.1428856-1-yhs@fb.com>
 <CAGG=3QUxQ+xfY9n8n+5QrTPAR4TDp=_TNfXtnKY32YZXH9WBaA@mail.gmail.com>
 <26c68f0c-6be9-7af5-0182-44e5a59f243f@fb.com>
 <CAGG=3QVHfkPanWc20HcjJJO57ynUfE3ZV4SV_SKEOHyEujw5qQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a71634a6-4b91-1af0-a5aa-11623d391464@fb.com>
Date:   Tue, 30 Mar 2021 15:28:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAGG=3QVHfkPanWc20HcjJJO57ynUfE3ZV4SV_SKEOHyEujw5qQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ac88]
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1777] (2620:10d:c090:400::5:ac88) by MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend Transport; Tue, 30 Mar 2021 22:28:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3dc3eb1-0070-4749-1cb6-08d8f3cb2e82
X-MS-TrafficTypeDiagnostic: SA0PR15MB3903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3903FA56E48E12D96CB266E0D37D9@SA0PR15MB3903.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZmmo7VPr5+V0D8agKZwTMXjS86MVmg/9i4xlrrT4RKscOfdZJxrfmIYlV6oO0UkrTNdC9kgqljhGWnnDKHWYozb6qTmQfhhDFe2u2iUZqdaZaa0IwwtSJXfG874Kj9vWhgIQW2AJeJ3+BtGOptR1lBjt9nQ5IHP1HxAfqA8USx+EZJRV9s+ho4dL5BYoKh+cmFUca7u96xgiOC+5mTp1JMGSTHR0f/HiTvmXR05qVqnv1M7yV5jMEk5vgOBipdCvwlMiFbaat+bW5EkV8b7k1H9eqL/vMdtW2EGni5XpOueRuOYtvsFCJrbpUglzw0pULEhoUpKW51CrDt9nSY3oaAPiYdaJfo+JJwa3VsFoaLPtPdOJLARCmkFkJmn+VpiKdLAfUfBxb0i3vc6IZaKyMAu9Gym9mmxGT99ZsGdR2nTwbdjl73Rou/0E/0x7b0WlH0zGXjxlRMXvVLxFCutR6nmaas6s4gtutamZ/NqCAprBFI6BunzlxkpKQTbPW/zRcmRHeXP2PyYIwOza61NJcvsX+36Qdh3IBcLmB0WXgIcBrZlHPEoIOKfJZ1oGyyQdbjztft+aJ7ooq8Xg6EuDqJOduTQ1KJqjQ7I2Llb9g08jEdcO6P1L6L7Sqe7wvw1g3Jpl8T9wwU1x8FfKZWkTQRQhbATxPIZYNa9mOyGHSpHKnbLFXPQaUmCk2szh3J7FiHdpmej22WmOhcVF7BZlVkiDZ1lpWUWjvkvbWhLtXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(136003)(396003)(6916009)(54906003)(316002)(38100700001)(186003)(86362001)(2906002)(4326008)(5660300002)(83380400001)(8676002)(8936002)(36756003)(53546011)(31696002)(2616005)(66476007)(66946007)(52116002)(31686004)(16526019)(6486002)(478600001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NXI0OGZRODU4SmlrZGoxdnJvaVZUZVNyWWJqTTFvNUFnQ1hZUEJEc3B0UUtN?=
 =?utf-8?B?WFhzT3c3SklVcEszTm1DMXV2WXhTWlpRU0FhZzNyRG1qMzljbjNuRTVCRHJW?=
 =?utf-8?B?cFBGTmEzUStsSjc1bGtOdUpFYkkvSUdBKzdTR1VYN3I1eDJ2UUZXYXVuR1U2?=
 =?utf-8?B?SkxJaEZpU1FiMEVLL25UUno4R0FlL0llTmhMaWJPUUxPUE5MRlZmM1VzVTNB?=
 =?utf-8?B?MzN3S2tFLy9DdTlISkJnLzJldTNkMWdiMU96Y2tKdGNKc0tWam90Nkp2MGJS?=
 =?utf-8?B?TDhSOHR2ejQ4dWJEemprb0JTTjM2dXRLdVg1ZGxpYy9WZy9ZU2ZzYWNGdUwx?=
 =?utf-8?B?dVNpVVRPdW05N3JDdWJvVG5NaXNNT1NVeU5qUkhudnpHMmR0T2tHSlAxRFdp?=
 =?utf-8?B?MldsWWU5ZUhLQXpzRWpRWEgwNjZ5bWlOSHNHTkdrcnBmS3ZHNk5sdWVPUUF1?=
 =?utf-8?B?RmZVcjdROTZkYnZuWXV3M0FjYzFSd211WmR3T0lmcjRUTnlrV1hjS3dlQjlQ?=
 =?utf-8?B?YUxoMTZyMkxtalFnTndoL2R1Z3FIQk1xUVFXMmkxcHJqOEczeXBTSUZPQXFh?=
 =?utf-8?B?YmxwQkgwekpJYUxGOTdaQ2Jnc0lHR3ZDa0R0ZVhydUt3UmFhNmJhUUJ6YSt6?=
 =?utf-8?B?Z3NuT0huSjdWVThqSFkxWTRHMVZadUtyMktYQ3pBSHZRSHIrOUZzdFFIcnRL?=
 =?utf-8?B?VThIYSt5NWN3VmhkdkU4Z1hYSk1hd1RyMS9wMmdQb2E0MlkyeVBuUUgrajgw?=
 =?utf-8?B?QUE1TFZ3MHF3YWl2TDdLWFhlSlVQYXdPZzdoMGQvanNyanE2aFFCY2xQVHp6?=
 =?utf-8?B?Q3RjV3BqRVZ3a0hlclZENGNnNStQd1FieE16RTZNSVlvTXpaMmg2REVPWlox?=
 =?utf-8?B?cDNraHE1UHZlb21CTDl0R2pzd0J6OGFpWGhQRUxEWjUxTElVeDYvZHRzZDYw?=
 =?utf-8?B?MlZmNWhDOG5UR2RQUlhnam4zclgvWW9VdDQ2eU1HTTgxaHdUUEtkU0RIU1Fa?=
 =?utf-8?B?Z3hKUzViYndpY0JCYWJwMEViL2hIb2QwMmttNnc0WFh4MFpsL0EwNnRGMWlM?=
 =?utf-8?B?WlBOZ2tMb1V3cjNOZ1M3S1g2SzJ5ejhpdTBuK0NMbVpoeVpuc28vOStxM0tS?=
 =?utf-8?B?aGp2TVRyS0h3MmdlSVpqWVZYTllUYitTK3ZFU1JpZ21sLytFT1JHS0dEaEVN?=
 =?utf-8?B?dnExWklsV2lxVFRmMWRGYkdJa01FYWZSRzhXNGlTc2dRTW5SY0N3VklQU2FN?=
 =?utf-8?B?bE83SiswK2NLeDArcFZFc0hmNENtbUpVdmw5cUJGOTg0emc5OVVDTTlEelpm?=
 =?utf-8?B?V2hSZVh0NUExSFh6SGM4OEZYQnZETytyR3JzWGZ4MGRDSnkrL2hDZGxzcnVM?=
 =?utf-8?B?OGpBSkIyb1NvVm1WY3B6SVhXVVk4MktCdy83Z0lFZzJWZlZoeXN4eUlVVUVw?=
 =?utf-8?B?Z244NG45TUJhNWlmZmd0MzAvcXBNWmZibWNDanVtejhrRGZQd2FxSmFDL092?=
 =?utf-8?B?NFNwbDJZajFnc29BOTQyTng3MDZPTVFndTh5bHlMQ2Fwb3doV2t0UlJ5emxG?=
 =?utf-8?B?ZDBkNlpJME1nRCtlc2hnTDgwZ2NMRHJqODRaZnJMVWZ5clpsRmh4MTZhSFpo?=
 =?utf-8?B?KzlCdHYyRzlJRWpsMFMrdHFNS29NKzhXU0lrRmRHNkhMcUovZ1BNSWhUcDVy?=
 =?utf-8?B?bGdBL1JpTjQ3Sm1zVTVDV3Q3a1hLdy9IL2RwMU9TY2p6WWtLcm9ic1hlMnpj?=
 =?utf-8?B?ZUlpc2p2TE1aZmNFbkUvbk13elpLTWtIUHZYalI0NjdOeWdKVVFkRVBiSnVi?=
 =?utf-8?Q?iMPD8+m8zyyw1KnW6ypxKlVwTxbtvo9vuN3g8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dc3eb1-0070-4749-1cb6-08d8f3cb2e82
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 22:28:45.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpsMOXdFCwrKcfGJTqVYUzsHFSMEBb2XLnGsfmM5L7ukgvMFGSc/WVrm5jUZvcVi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3903
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: rtzKKbtZG_v0Yk-3WJ5INaZ_CujBEBOZ
X-Proofpoint-GUID: rtzKKbtZG_v0Yk-3WJ5INaZ_CujBEBOZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_13:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300163
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/21 2:44 PM, Bill Wendling wrote:
> On Tue, Mar 30, 2021 at 1:15 PM Yonghong Song <yhs@fb.com> wrote:
>> On 3/30/21 1:08 PM, Bill Wendling wrote:
>>> On Sun, Mar 28, 2021 at 1:14 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> For vmlinux built with clang thin-lto or lto, there exist
>>>> cross cu type references. For example, the below can happen:
>>>>     compile unit 1:
>>>>        tag 10:  type A
>>>>     compile unit 2:
>>>>        ...
>>>>          refer to type A (tag 10 in compile unit 1)
>>>> I only checked a few but have seen type A may be a simple type
>>>> like "unsigned char" or a complex type like an array of base types.
>>>>
>>>> To resolve this issue, the tag DW_AT_producer of the first
>>>> DW_TAG_compile_unit is checked. If the binary is built
>>>> with clang lto, all debuginfo dwarf cu's will be merged
>>>> into one pahole cu which will resolve the above
>>>> cross-cu tag reference issue. To test whether a binary
>>>> is built with clang lto or not, The "clang version"
>>>> and "-flto" will be checked against DW_AT_producer string
>>>> for the first 5 debuginfo cu's. The reason is that
>>>> a few linux files disabled lto for various reasons.
>>>>
>>>> Merging cu's will create a single cu with lots of types, tags
>>>> and functions. For example with clang thin-lto built vmlinux,
>>>> I saw 9M entries in types table, 5.2M in tags table. The
>>>> below are pahole wallclock time for different hashbits:
>>>> command line: time pahole -J vmlinux
>>>>         # of hashbits            wallclock time in seconds
>>>>             15                       460
>>>>             16                       255
>>>>             17                       131
>>>>             18                       97
>>>>             19                       75
>>>>             20                       69
>>>>             21                       64
>>>>             22                       62
>>>>             23                       58
>>>>             24                       64
>>>>
>>>> The problem is with hashtags__find(), esp. the loop
>>>>       uint32_t bucket = hashtags__fn(id);
>>>>       const struct hlist_head *head = hashtable + bucket;
>>>>       hlist_for_each_entry(tpos, pos, head, hash_node) {
>>>>               if (tpos->id == id)
>>>>                       return tpos;
>>>>       }
>>>>
>>>> Say we have 9M types and (1 << 15) buckets, that means each bucket
>>>> will have roughly 64 elements. So each lookup will traverse
>>>> the loop 32 iterations on average.
>>>>
>>>> If we have 1 << 21 buckets, then each buckets will have 4 elements,
>>>> and the average number of loop iterations for hashtags__find()
>>>> will be 2.
>>>>
>>>> Note that the number of hashbits 24 makes performance worse
>>>> than 23. The reason could be that 23 hashbits can cover 8M
>>>> buckets (close to 9M for the number of entries in types table).
>>>> Higher number of hash bits allocates more memory and becomes
>>>> less cache efficient compared to 23 hashbits.
>>>>
>>>> This patch picks # of hashbits 21 as the starting value
>>>> and will try to allocate memory based on that, if memory
>>>> allocation fails, we will go with less hashbits until
>>>> we reach hashbits 15 which is the default for
>>>> non merge-cu case.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    dwarf_loader.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 120 insertions(+)
>>>>
>>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>>> index aa6372a..a51391e 100644
>>>> --- a/dwarf_loader.c
>>>> +++ b/dwarf_loader.c
>>>> @@ -51,6 +51,7 @@ struct strings *strings;
>>>>    #endif
>>>>
>>>>    static uint32_t hashtags__bits = 15;
>>>> +static uint32_t max_hashtags__bits = 21;
>>>>
>>>>    static uint32_t hashtags__fn(Dwarf_Off key)
>>>>    {
>>>> @@ -2484,6 +2485,115 @@ static int cus__load_debug_types(struct cus *cus, struct conf_load *conf,
>>>>           return 0;
>>>>    }
>>>>
>>>> +static bool cus__merging_cu(Dwarf *dw)
>>>> +{
>>>> +       uint8_t pointer_size, offset_size;
>>>> +       Dwarf_Off off = 0, noff;
>>>> +       size_t cuhl;
>>>> +       int cnt = 0;
>>>> +
>>>> +       /*
>>>> +        * Just checking the first cu is not enough.
>>>> +        * In linux, some C files may have LTO is disabled, e.g.,
>>>> +        *   e242db40be27  x86, vdso: disable LTO only for vDSO
>>>> +        *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
>>>> +        * Fortunately, disabling LTO for a particular file in a LTO build
>>>> +        * is rather an exception. Iterating 5 cu's to check whether
>>>> +        * LTO is used or not should be enough.
>>>> +        */
>>>> +       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
>>>> +                           &offset_size) == 0) {
>>>> +               Dwarf_Die die_mem;
>>>> +               Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
>>>> +
>>>> +               if (cu_die == NULL)
>>>> +                       break;
>>>> +
>>>> +               if (++cnt > 5)
>>>> +                       break;
>>>> +
>>>> +               const char *producer = attr_string(cu_die, DW_AT_producer);
>>>> +               if (strstr(producer, "clang version") != NULL &&
>>>> +                   strstr(producer, "-flto") != NULL)
>>>
>>> Instead of checking for flags, which can be a bit brittle, would it
>>> make more sense to scan the abbreviations to see if there are any
>>> "sec_offset" encodings used for type attributes to indicate that LTO
>>> was used?
>>
>> Do you have additional info related to "sec_offset"? I scanned through
>> my llvm-dwarfdump result and didn't find it.
>>
> Sorry about that. It was the wrong thing to check. I consulted our
> DWARF expert here and he said this.
> 
> "DW_FORM_ref_addr is the important thing used for cross-CU references,
> like in the DW_AT_abstract_origin of the DW_TAG_inlined_subroutine. In
> intra-CU references, DW_FORM_ref4 is used instead."

Thanks. I checked with lto dwarf, it should work. The only drawback is 
that it needs to traverse all DW_TAG_inlined_subroutine
and DW_TAG_type's in the cu. If nothing found, going to the next.
This is exactly what I tried to avoid in the beginning, going deep
in the dwarf cu. I could remember the maximum and minimum of the ref. 
type tags for each cu, if it is beyond the current cu
range, it means cross-cu access. But I didn't use this approach
as it is something every pahole user will pay the price regardless
of whether their binary is lto or not (mostly probably not.)

I checked my current vmlinux-lto. I will be able
to find a DW_FORM_ref_addr in the 5th cu. May not be too bad.
We could have a heuristic to only check the first 10 cu's.
If no cross cu reference, that means not lto. Not perfect.
But for sure we don't want to go through all cu's just to
find it is not lto build.

Still feel we should get whether it is a lto built binary
as soon as possible. With an explicit option, compiler flags
seem second choice...

> 
> -bw
> 
>>>
>>> Thank you for improving on my hacky patch! :-)
>>>
>>> -bw
>>>
>>>> +                       return true;
>>>> +
>>>> +               off = noff;
>>>> +       }
>>>> +
>>>> +       return false;
>>>> +}
>>>> +
>> [...]
