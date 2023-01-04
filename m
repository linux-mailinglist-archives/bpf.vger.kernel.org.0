Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C29E65CD85
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 08:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjADHPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 02:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjADHPc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 02:15:32 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E4F178AA;
        Tue,  3 Jan 2023 23:15:30 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3046kAom000779;
        Tue, 3 Jan 2023 23:14:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NgpGvOzvtKpU3Sg4oHHz2IXQqhAYY94cxc9Gs7QJE7I=;
 b=doZ6aCIBpVYJZizP6r0j+quKTRq5zr/TS51fT4axz/2PLpBD8EG25pUMs96GcT3Z0A1u
 UVPvJrpGTqeMGHcD2Sv7FgsocedAkJnmp2zBskum188RoVasfQC2MKPqvoGeso4SjXm5
 navzXiTiELupxRd8YVhCp/LIvC3iCrRF+DkuGokHn6sVdVIW6dBm1kEHf2rXTQJEuJhT
 2NV/tCgv6jilszQl7E3dvHPm3+zP7zokT2Zw+wF2bTI+eWkyLWr4RrmS05wjzUrWhtQv
 a5WbeuHiuFX1DYja7OrUb82x2FsdWA2wH3k7q4UFoqkc0vevEysqEAABtidat7NVDy3x qg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mvkt8f5m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 23:14:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HD71ZjDQrebYgonx5QPk+6iZrB2Us/O3RXcJrHjAQX/sJGrzMD8nDUCxVH/gdWgT2/W49TmlE6YfKJRAy+FftdXNj7Z4Rf8JmWGik3Sr48eAo2jAlEyU1RVKmoiwIjGUs6aILVjfBONypiYL7UdkLyItlNsQ3YhWdxQYk7xGld3L3kxQRdD4hZTkKqeJthdCtyIAAmY61l8qx0Ajv5RV2L/UyQLpj5YNXjdjRuobWdrkxiovokUMrnybs24r4GlD4CwW3OXLb06SL4i/GadNcmbv1KuuMg9pmN0gl6Qg4Dv7ErpAM/2whCuY1384N+va+Re3jV30k1sghxezBduflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgpGvOzvtKpU3Sg4oHHz2IXQqhAYY94cxc9Gs7QJE7I=;
 b=AkgkoSbauFsFt76IjOqpKnjYrhG1IYu9faXU4MpWknz9zoT6tPPfUJhMBgLtylJavrhbwOGLfKIHCpVzgpR9V83NnKZnn+K57kOwxU2wELO8n+GMwO9YQgxbsBp4fZNR7UOPS5uQIUEX8fdG9bbcl2NTjot5H45TLkBcJy7/cvBOtnJIYLfJTuPAU/d10fHHTuRDAzjD0jrWw6wyFjtCGGhs+ReScDUB7Q7N4TkF3l6Wpy6kVWR+IyPlzJXAyUJi7ZpgbGTVUFQr19XcwRKc+cHXepHP5KswkX1CaR5WjQ/KmILH5eZ/8Ag0ZfMBuk1AhBR663e23tMnWBDeI+UYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4627.namprd15.prod.outlook.com (2603:10b6:806:19e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 07:14:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 07:14:44 +0000
Message-ID: <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
Date:   Tue, 3 Jan 2023 23:14:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
 <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: a309247f-2c27-4692-c780-08daee235ad0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4PmxQgxZVZVyX/bNxlETh2woS7QlGeByMxr1V8b/X4t/DUbqG6+PaiXzY56vW95GOU6XH3gUw8SEYOHUrUQPfiErNwEBwVt8xWtxlZbNtKOepMRDoknyLfBR0X5W9IMI+qF4xWJQ8OJAvrqF6dGUNGWycYd7yoHwZXuRsoFPjtCWaaGdn0do0vz3w0lYbZBZTd7alsziNu16s8E0fd3FkEITGU22LNVRO1MXlLx1vlA+Kgkq0rcQclPua+qkGyXX0LcekKd8KiSXE+RdavRVl7QX6WyBYMU6fOT0SNCySeApVReqo41rwceA9Y+80rGtJ/HnvB8/6ZLpKE731BTPFqlITeTxKfYLlFkLOZpaXvc7J6llSaBKr4w845FFixw2m8YoXjTuDNuNwhqQf5Odc5yYJ8SGoT/PZ0+wcq/C3EKbBNLxn8d9IUX2rXZXPamhuIuRkunCE8qNGWkjhals4IJmXp/QEMxPuGf4OAVt7ovRImSiOvIkX0aPqwR+DWX4K/Ih+RlhUj1cytTJ2FAph3e+qwCmB+6ALW2R09FDbeb52jP5ABW3hmgAglD8ynJ22+5KX7DcOfVKmTQ4VHFPp2v9EfHpy4XhuW8tBZIaicmBgGsgvu37lI5D4K3wbVTcOMTJjaDIGdiRGHSjwsgXrv9T5x2VCdU2MoLvPNfzXYS8WdnZRomVMF3fYYjGbvhc5BGmFkA2ZszEYztz6qIeCvc126oEUYRkYGQsLvLGBEGBzpNWMPwnzOmOjJmyBP9zpIu/3LvRYx/RIcs+/H0FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(7416002)(5660300002)(2906002)(8936002)(41300700001)(4326008)(478600001)(8676002)(966005)(316002)(66476007)(54906003)(66946007)(110136005)(66556008)(6486002)(31686004)(6666004)(6512007)(6506007)(83380400001)(186003)(38100700002)(53546011)(2616005)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0FjSDZualZGakhpR3ZEQmI1VjhjMEZiTnVZck10d0JGcW55L2NvUk9Pbk4r?=
 =?utf-8?B?a3BPak1OeDJORjVtdVpDdkRZNlJkcjZGb3c1aTQxeGxlK1h2UCtEUUtiR2Nt?=
 =?utf-8?B?TVpWRTdoWjczS1ZZa1dTUTIwSCtaU2xhaVhOUmZDVmhVU016ditmZXB5RGFF?=
 =?utf-8?B?dEtHN0NCc25kQjBNYlpvSmMrYWp1KzBBSTIwaUZTVTVzM0pjSFloTnAwWnlq?=
 =?utf-8?B?WmpURGVvVHlYRDRnZHpvWDYrelRLNzhqUFBpRHplVWJ5S0N6TnJjTWhHOW1Q?=
 =?utf-8?B?R0lTVUVkR0JuN0RlQWlPRTd1KzM1anVUQTN6UElZbzBJYVpnYUNpNnQ0ZXdh?=
 =?utf-8?B?M21USncxOXhvRy94a04xd3J2QjZqanl0azdqMjhBenJYOStlbWtYdHBNZHI3?=
 =?utf-8?B?Tm01T3ZkdmIvR3NsMXN0RG5aYkdHd1dUU1RqaXBnaEtWQklzbDQ1bWN2SXJl?=
 =?utf-8?B?bEgyKzhuMFBaUXhXbTNKQWI1M3dDd0NBeHdKT3ZGTHVJNFU0SzR6eVFFc0hB?=
 =?utf-8?B?ZTZ1Q0FzTWxyOGFmK2NoWkRJVnVmNDZvb0FBUzZTdTZrTEd1RC8vQWNRN3A5?=
 =?utf-8?B?RDJCL09nZVlOamt4SjlsMDZiODhrZUpXN0dsUlZ1NzBVZjBFemRGdWRad3ph?=
 =?utf-8?B?eVk2NFFoaHRtNktQZHVWVFJXbUZLclBFc0lxOHkrYkZtOGNWT2tGZHdKM3Bt?=
 =?utf-8?B?KzlvS1dkVzFoWlBjc2ZWWEtnY2NqSW00TEM5VG1keGhmaTBsU2NYN0EzWHZC?=
 =?utf-8?B?RnB0V0xjOWxpSk1lTmhValU3OFFRVHZFcExnc29RdHJ2U0IrcnBuS2dneEE5?=
 =?utf-8?B?ekJsNlRydWx3MXRreHFNWm4yY1YxazdpdlZGalluRkZRREFsZUl1Ulk2azJo?=
 =?utf-8?B?RXBURTk0NXVGVVhiRklOR2hET2s2cVdNbTkwcUFUWHJEZGROZmFTaGhHWXht?=
 =?utf-8?B?dnYrUFlaSlc3TEIvVWtPNlMzRk14N1NVeHR6RlNNS3JObmpsaldDRExXczZR?=
 =?utf-8?B?eUJsZk9CdXhLc2NpUGsySUJhQXRNNm9YbFJZRWpMVXZNWXlDYzNSQnZEOXhm?=
 =?utf-8?B?MVNXcllhdzBBbHhvWHo1UWZDOC9xQjdmSGpKZG83akxQMXlySDkwaERYcHUw?=
 =?utf-8?B?Y3VQbzBENzJUZkQrQ1hQZC94ZDFLTVg4UFlGSE9tOVNOZFpYQ2tRVnRJUzM3?=
 =?utf-8?B?am5ZVE5RbUJSYUQ4OXZnMzdJTzFHcjdlK1RPUXRRaVFCT3pTejBzZlJ0dlRv?=
 =?utf-8?B?TlFhWjROTzZXV1hCbFlHVDhOTzl2VWRlUXl6UDhRLy9aNFQzSFJ6V3BxR2Qz?=
 =?utf-8?B?ZFp3aUtET0w0Q0xaRXdYVHRVdnRDa3kwZHBxQndSNnU1YU9lWW1FZ1lXUFdO?=
 =?utf-8?B?Y1BNMlJHWTN3RDdUNVlpMjNLbGtaL04zSWdON0JwdUx5eE5wdi80eTJ6UWxZ?=
 =?utf-8?B?b3cxYVVWb09BZDg2MmhWdFRUR1YvUi9XQU9JQkNCeGY4ODNGSzFXdFd1NFpQ?=
 =?utf-8?B?QWFnbTNIeHpOMVFkcjZUd1FVU0M1Z3JNQkdKYU94cGVLZ08vaThZS1JNQmlX?=
 =?utf-8?B?TnJyYytJWnBXV0JZQm5CZXlXbEtrTFNmV2d6OEhPT2pCQ2E3Z0M4alVBS0lO?=
 =?utf-8?B?UEpUZERaV1Rwa3hYV1VlZWZ0cU00ZkFGczYzQnNmSlBaUm9rWXlPQVhzeTNQ?=
 =?utf-8?B?ckVsU0hNWjAxeTVHV0p0bENiVjZid2JZNkJWVDNaZmd0M1FuU1JNOEZocW1y?=
 =?utf-8?B?aUVIbFR2ZU9KZWpHdzdpV0JBTnVMWGwvNUduM0VteUgyZEJsLy9BNEcyOTFW?=
 =?utf-8?B?MmpXVjM2ck1KbjlCSTZPRDljcHEyVEhvV2I5VmEwYVFOc1NEd2FUUU1JSmVp?=
 =?utf-8?B?bFFiYWtZNVhCWnZKT2M3RlFpT2xBOVhWM0VaOU9zQnpxNHlkR1VlMXBuVm1D?=
 =?utf-8?B?N2xNQmdVaWVIWHI3b3JoL1VSbFBUWTd3bHNSMTJ1YWVZcm04aGdXLytyTjVB?=
 =?utf-8?B?ZWhIOEtNOEpKeE9BRVVZMzl2WUFuZzJVREpEUjNvNmZXZ3FveEVnK2dLWFY3?=
 =?utf-8?B?SU5FSlRPWmRHcWlSVEVoRWZVamhGSjBmc09BMk1kSkV5QjlFTXRZMWtGWWM2?=
 =?utf-8?B?N2tXSVE0Z3Jad29DVWQ3S2VYNW1JNmZ3ZkYyeHdYYnJlR1hEdEc3ZjVGV1Nj?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a309247f-2c27-4692-c780-08daee235ad0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 07:14:44.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fclj2w42L0puKDoAV3z6abpPSCTilzfnV/8KwGTmD+gMQt+Bf2vdfuD1P49o0cKc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4627
X-Proofpoint-ORIG-GUID: 7IWbmr6f3_aHCdWLSoXGZbuLbQ4i82Ld
X-Proofpoint-GUID: 7IWbmr6f3_aHCdWLSoXGZbuLbQ4i82Ld
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/3/23 10:30 PM, Hou Tao wrote:
> Hi,
> 
> On 1/4/2023 2:10 PM, Yonghong Song wrote:
>>
>>
>> On 1/3/23 5:47 AM, Hou Tao wrote:
>>> Hi,
>>>
>>> On 1/2/2023 2:48 AM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
>>>>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> The patchset tries to fix the problems found when checking how htab map
>>>>>> handles element reuse in bpf memory allocator. The immediate reuse of
>>>>>> freed elements may lead to two problems in htab map:
>>>>>>
>>>>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>>>>>>        htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>>>>>>        flag which acquires bpf-spin-lock during value copying. The
>>>>>>        corruption of bpf-spin-lock may result in hard lock-up.
>>>>>> (2) lookup procedure may get incorrect map value if the found element is
>>>>>>        freed and then reused.
>>>>>>
>>>>>> Because the type of htab map elements are the same, so problem #1 can be
>>>>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
>>>>>> these special fields in map element only when the map element is newly
>>>>>> allocated. If it is just a reused element, there will be no
>>>>>> reinitialization.
>>>>>
>>>>> Instead of adding the overhead of ctor callback let's just
>>>>> add __GFP_ZERO to flags in __alloc().
>>>>> That will address the issue 1 and will make bpf_mem_alloc behave just
>>>>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
>>>>> will behave the same way.
>>>>
>>>> Patch https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/
>>>> tried to address a similar issue for lru hash table.
>>>> Maybe we need to do similar things after bpf_mem_cache_alloc() for
>>>> hash table?
>>> IMO ctor or __GFP_ZERO will fix the issue. Did I miss something here ?
>>
>> The following is my understanding:
>> in function alloc_htab_elem() (hashtab.c), we have
>>
>>                  if (is_map_full(htab))
>>                          if (!old_elem)
>>                                  /* when map is full and update() is replacing
>>                                   * old element, it's ok to allocate, since
>>                                   * old element will be freed immediately.
>>                                   * Otherwise return an error
>>                                   */
>>                                  return ERR_PTR(-E2BIG);
>>                  inc_elem_count(htab);
>>                  l_new = bpf_mem_cache_alloc(&htab->ma);
>>                  if (!l_new) {
>>                          l_new = ERR_PTR(-ENOMEM);
>>                          goto dec_count;
>>                  }
>>                  check_and_init_map_value(&htab->map,
>>                                           l_new->key + round_up(key_size, 8));
>>
>> In the above check_and_init_map_value() intends to do initializing
>> for an element from bpf_mem_cache_alloc (could be reused from the free list).
>>
>> The check_and_init_map_value() looks like below (in include/linux/bpf.h)
>>
>> static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
>> {
>>          int i;
>>
>>          if (!foffs)
>>                  return;
>>          for (i = 0; i < foffs->cnt; i++)
>>                  memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
>> }
>>
>> static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
>> {
>>          bpf_obj_init(map->field_offs, dst);
>> }
>>
>> IIUC, bpf_obj_init() will bzero those fields like spin_lock, timer,
>> list_head, list_node, etc.
>>
>> This is the problem for above problem #1.
>> Maybe I missed something?
> Yes. It is the problem patch #1 tries to fix exactly. Patch #1 tries to fix the
> problem by only calling check_and_init_map_value() once for the newly-allocated
> element, so if a freed element is reused, its special fields will not be zeroed
> again. Is there any other cases which are not covered by the solution or any
> other similar problems in hash-tab ?

No, I checked all cases of check_and_init_map_value() and didn't find
any other instances.

>>
>>>>
>>>>
>>>>>
>>>>>> Problem #2 exists for both non-preallocated and preallocated htab map.
>>>>>> By adding seq in htab element, doing reuse check and retrying the
>>>>>> lookup procedure may be a feasible solution, but it will make the
>>>>>> lookup API being hard to use, because the user needs to check whether
>>>>>> the found element is reused or not and repeat the lookup procedure if it
>>>>>> is reused. A simpler solution would be just disabling freed elements
>>>>>> reuse and freeing these elements after lookup procedure ends.
>>>>>
>>>>> You've proposed this 'solution' twice already in qptrie thread and both
>>>>> times the answer was 'no, we cannot do this' with reasons explained.
>>>>> The 3rd time the answer is still the same.
>>>>> This 'issue 2' existed in hashmap since very beginning for many years.
>>>>> It's a known quirk. There is nothing to fix really.
>>>>>
>>>>> The graph apis (aka new gen data structs) with link list and rbtree are
>>>>> in active development. Soon bpf progs will be able to implement their own
>>>>> hash maps with explicit bpf_rcu_read_lock. At that time the progs will
>>>>> be making the trade off between performance and lookup/delete race.
>>>>> So please respin with just __GFP_ZERO and update the patch 6
>>>>> to check for lockup only.
>>>
> 
