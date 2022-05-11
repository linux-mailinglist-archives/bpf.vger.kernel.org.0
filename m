Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317EA522852
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 02:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiEKASV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 20:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiEKASU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 20:18:20 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E40D1FD84C
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 17:18:18 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ANKwjs009697;
        Tue, 10 May 2022 17:18:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=roNy6tzNa9s4T+TyhxhmYU7Uv362jzYuDQPwhGi7j/0=;
 b=HOGqnRnwzkLRCBLjip6IR04ruMBNKW79wylQ/5APJcA0GifA8cc182xjGsHVp5/k/v5j
 lIb3v3kZIk84xfZYTu+6zMj7f5ozW4ig5ANNSe0Xl2PFGGvgL3Ez3usYkYJmTFtUCyWC
 iEN9KfSoDo7nvwVlqb5XbiQ9hc9diQu1t5E= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyn47wtrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 17:18:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBfZBfOi5SchAGQIC4TcPDD3T8Uy49pXUg7YtqVH71t3NMeTD0aSC+tJt4sr8Ga2xd3gKSNFmYzIKxtVSfmRkOACNLkbAcsMbRAHjfMzKe+nB8EHkbLP8JYJp4K6pFF3Up16zXAOb1Yc7y7sIBhKXZKLTP37WT7R8gyeKFD5OsbCzQgIPA1NT6lm86WIaTbsh4XF1IDPLl2rXYChJiLg0hH+Yign2pQL+iK+yrDYXVCfAgtEbOTwmN5Ha2Sm+4eALhvTBcGX9QN5B4XyDShm3L9wNMf6blyykhcokY1KOb+aKp2THcxyE4iDt7zsqJ9M6T1tnAzhGQY85TM56chDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDuxMA5c1Px/GsUkp1oV3fmdrkUw4ULI3ATd1r8tM78=;
 b=MbCAL2CgzB/UWYTI1IFNdWophUsLoAqDRVQclaMsuCWNquhOWHInzDSE+E6JEqaAynJpOvJWI8Lcz11Fh1frm7NWFWV/WxjiCSjDE6HpADtzaTypetoeHk8+yT2T1HkgOsLbtImkl1n4e/aHhVwBm1KcgfsOdNjem4Es2AS6id2glfeHHfe0Oc/CVvp2KTXtTR/39k10po+QT751IiHmQQ9n9NgBG8K5mJFnBtGNgl/CAw0gHle9tograWi84PKLdvhGaf2yiW5tS4GQF9pkEHpSXSrxdPDpITaBbConOV38lezmW0fMOeZivDJLlrlciRQ9BNoboesv3vXnvpUlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB5107.namprd15.prod.outlook.com (2603:10b6:a03:3ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 00:18:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Wed, 11 May 2022
 00:18:00 +0000
Message-ID: <7e70bb95-9de9-cf79-bf5f-00e9bcef99b1@fb.com>
Date:   Tue, 10 May 2022 17:17:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 01/12] bpf: Add btf enum64 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190007.2576808-1-yhs@fb.com>
 <CAEf4BzbqQDVsiaY1u5G6QAu_3Zq8Vn19qBkzuzVYX0T_e3OLSw@mail.gmail.com>
 <be27f832-c803-1ab0-2180-74bf7177ca41@fb.com>
 <CAEf4BzZN-o+MnPsQ+3_MB+kxyUhmwGa2q9SqN_b6vE6dxsJv1Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZN-o+MnPsQ+3_MB+kxyUhmwGa2q9SqN_b6vE6dxsJv1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b141d873-bac6-452f-a69b-08da32e3b52c
X-MS-TrafficTypeDiagnostic: BY3PR15MB5107:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB5107A9567CC9AF45C37D5423D3C89@BY3PR15MB5107.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUmxohxGGmzltomyLDpTqiPbPM+iHzt2K/xK/Md7mRKPyJW4X8jBUgtOVV5lsjr89zQaLp9mflE2kEZBdP6thLMa8s51QAPXrLl8lc8ATXr/wAmOelYm/rSac6Hk0a7ABH0uaW7TMoytzq6bKPy2nxbaacqnTui7j/hm6o47VHOklXcyF59kdfmh+IeglZLHv8XiIyNUw/JY4nFUuBBwlUnIy1O8bhhe6YGIWyTA68xRrojDCIwlur57tQvAlG6ndMDcjXYLynOEdaXxpwOkY4BipiD5mW8YVkuf8RIsgLdXmvcjkm7gj0flTIGjxqGDPZjK9KpiOP0aK5/BHKH8Z21yD5v087tYOyRfR39UR/yvNThD3Pr/lSU30n8CHD9XDkKo3a5VBFywGaCY+qNrFt057QGBTvoxsXU6TKfVQlErUY+OXn0JEMvmjkLY5zUJ+sD945YI33soZ6mR4xyt1KHYoF7KO41WvkJR8tLSwJtRfZdu/lKn04JCAE0wTcgZckkcoyvRK+p21qEbuVOu6rVCtz6DrJYLZdG+Pwf19aXB1kdVEwPQYUxFjjdUh7pLLEAneLhOLeUW9YvXKEw54owKepFLSQL8BnLni0xz/ok65ZakY9xE8C/ajHN0vHzvaMT3vL/zzO6wYz/d6f8WG4YeWlmczHXAUMp5fvnOGtOpYLnSnbj2IpDn7P/VtdlXogYuguOthxoR2XAw46H8oYEw+99fGCJx33yAaIl3Dagt+P7lK6+OLngHifclha16JAceFILKxG4i7FjVRpb4cRfn3SBYqrSvUebrRFxw7qUldVTwB+rFRz5d4pEbBxhx5D5d0WDQ9tlDe3IIkb5VrQ0eIigWQVM2o7gM11E1Gvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(53546011)(6506007)(31686004)(83380400001)(6512007)(36756003)(66556008)(5660300002)(186003)(2616005)(2906002)(38100700002)(966005)(316002)(8936002)(31696002)(508600001)(6486002)(66476007)(66946007)(86362001)(8676002)(4326008)(54906003)(6916009)(87944003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1UxMHIyNUFLQmlnQjI4RjU1clFzVXU1d1hHTUFxZnprSUV5Lzdsc05HRFdL?=
 =?utf-8?B?Q2NiTnhaZDB4YlF3elRYOTJjSTJpbWFESzBBVlJYTVdCSEw1SG45WHd2SHlj?=
 =?utf-8?B?S28xTW1RYXdLR2ZMa1BKUjlHdDEwLzlpVkRFcGgxbnVFSE5vWWdPL0J5VmtI?=
 =?utf-8?B?V2FocW96NURhSHRSY1hhVVM5a2VJU0N1UkhiTFFNS2RjSW1UaWt6Wi9IcHJv?=
 =?utf-8?B?NFJtd1piLzk3U2JXbHBlQmFSUDhBYzA5SnRwWGRzbjBET3F1YU1vRjcrV3V3?=
 =?utf-8?B?L1VSdVVzbW1zL25iL290NnBmdnBodDI3eHB5OHdsUVovQkp3ek9GS0lsc1JC?=
 =?utf-8?B?a2pDZEE3dlZwWnFFTWFNbHd2L2FqK3R4eGpPR05Wa1dadk45dE5XYjN5Y3Ux?=
 =?utf-8?B?SGFHSkJYY2hma29zcmJSNzJkaFFGYjFpUWtlK0QxMmN0M2JoOVBJaTFGN2hj?=
 =?utf-8?B?RjlUM2Z4a3piQmpvSktVNEczdU05S2o4QXh3ejJZcFNRanJ6dU90S2IydGUv?=
 =?utf-8?B?NmpiTGc4c0dOYzQzUklwV0ovakpaSHZyeVlzYW5WMHJkTU8vV212VE91b0xV?=
 =?utf-8?B?b2hENGgrTTlGbzRvcVMzQVREb0ZWUG03bUlwRy9Eb1BhVnZZTmZCL2cwLzZ1?=
 =?utf-8?B?bE5hQnZJTEp2dC9aa01uSVYrSmVsQmpBZWYzM2pOMklkbm0rRDZvQkRhanlm?=
 =?utf-8?B?Wk9PUEcwNGFTZGowV2h2MVkzNDJxY0tZWWJmTElGMDQzeHJGOXpUdUI5bmw0?=
 =?utf-8?B?dDZsVDBnUmplUUpEbkxORS82YUY1MU5TWWxYUndiSmZQaThYQmJxZys0RDVH?=
 =?utf-8?B?ZFJLcStGYnp0TUY4Y2NwMGRDOE1oSml2TFFYYTdEN1hUZENBRFlGeWNqQ1Fu?=
 =?utf-8?B?VjdpTFNicklJY1dwQUU0OE9aQ1lmUTVHVTdnWEo0aERkaWNRNWRQU1hqYVF6?=
 =?utf-8?B?QXJ2d0JBS2lKOEhUTHRpSndxcWphd3BMQ2IyTTlXNWdXRmZDa2VlSS84TWxx?=
 =?utf-8?B?SE02SDFITjk3ZGFPOEJBcFZRUmVqMy9UUmFPVlFPc2dJZ1BuOTFHOXFvdUpq?=
 =?utf-8?B?VEJEdmdnNjI4L0RUVnNXSDJOTkIxdklveE9MOTBoSjNhTHowd0tjNHc0MW1T?=
 =?utf-8?B?ZStSRi9EWEV0T1lndXpqTkpMSFJvZUNQSnJWRUZsQnduQUFuVmdJUUdrcm8z?=
 =?utf-8?B?M0J5ODBsTjMyelhIYVZMVHRXS0VMeHNxRmF3cERacWlEL0VnRUwxaE5UOW80?=
 =?utf-8?B?R3d6N0NoSXRsQU9PSk1PZG9oQm9HbFRKSmVMREtETXVibDF0cmRGMklVTWp5?=
 =?utf-8?B?bWhOODFMaHNyc1d5UDZvS0MxK0U2aTdFV2x5MktlZzhsVEkzTE1RS3lYR1RO?=
 =?utf-8?B?VHphTW1HL25NU1d4VnhoVExhOHJJSHhESDJjWkwxNWtOakg3UW9BaG5pMUgx?=
 =?utf-8?B?SWVkQjVJVWttZWI0c2lXSHV6dWQ0azFGK0Q2WWVqblA5Nmg1NEdUZ0lvcEE4?=
 =?utf-8?B?SDVRWG9MN1JVNk4xZzFYTkhBdWZ2NkJFYUlUK1I0SzhTOTBEQzhNMXlsQVpr?=
 =?utf-8?B?WnY1WmtXRWZwZUxodEVZeDVhZzFONmUrZHQzQlNjK2x4ZmdlOGtNQS8yUEd6?=
 =?utf-8?B?ckVIekoyazRobVhldEtLVWtkUk5hejdLblhsaTN0N052S2h4SEtuZXdKV0VR?=
 =?utf-8?B?b1ZOUVBqOEU5MFdWYUFobmZWVkF1dXp5ZXdiZ0UwQ29mQzVaOXlkcFBHS1JX?=
 =?utf-8?B?MUhZV0MxVkhxeXhMZGRITkg0cUI0aGQ2WWNqdjR3MmlKZm0vbzZUWTFTbHgw?=
 =?utf-8?B?K0tpN0ltaFZVak9aTEhGcnlCQXAwWGZWKzI1aDA3K2dSdmRwRDBENWFiNVh2?=
 =?utf-8?B?TGxpb2g0TWZXdHRWdTA0TGc1MkFrNE54YndOMGZBWmFMbzJseE02VHpqWlNY?=
 =?utf-8?B?dFQzUDJZREFBQ2x1WTZuWkZYRDc3d1VHTE9MRnJkVmhiTFBUNkI5eDJsZUZN?=
 =?utf-8?B?L1c3U2FITlNuTCtpUzIvRGhDZmFyYzNBR2dEc0FKbm9sN2pkVGhhSUZvbC8z?=
 =?utf-8?B?SjZCYitXVU4wanBUSllIQUtBV0luMlpUVGNiSmh4TGpYU2hyWE5od3NuZkdQ?=
 =?utf-8?B?Y3lxTEVFRGhwUjJxemR2TWZjMkhocEs2M1pMQ1lyOUtWYzBQL00wTUhPU2xU?=
 =?utf-8?B?RVNZekpQZE5qMUY5UlRaMmdNMEg0d3J4aFdKN0FhaEJBc0d6dzRadkxSTGVm?=
 =?utf-8?B?TWxBd1VTTGxqNlV0czZIUHFIc2RMTUYzcnFEUWF2UWI5a01VUzFxYms1RFhI?=
 =?utf-8?B?VUwxM05IVVQxNDFZUXh4WS9PenBWOVhETTRJOElDSm04RmtCQkwxekYraitl?=
 =?utf-8?Q?m3PHzjduCHcRjNZA=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b141d873-bac6-452f-a69b-08da32e3b52c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 00:18:00.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxTIb1bdEyAexLHGhR1KJ2mZ5AFTk0fso+oomtNhNN32jDewciF6C0usjlg9r/v5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5107
X-Proofpoint-ORIG-GUID: P-C5TzcIbw47AX3JYmBkTOFc31FKJeUo
X-Proofpoint-GUID: P-C5TzcIbw47AX3JYmBkTOFc31FKJeUo
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/10/22 4:18 PM, Andrii Nakryiko wrote:
> On Tue, May 10, 2022 at 3:06 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 5/9/22 3:29 PM, Andrii Nakryiko wrote:
>>> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> Currently, BTF only supports upto 32bit enum value with BTF_KIND_ENUM.
>>>> But in kernel, some enum indeed has 64bit values, e.g.,
>>>> in uapi bpf.h, we have
>>>>     enum {
>>>>           BPF_F_INDEX_MASK                = 0xffffffffULL,
>>>>           BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
>>>>           BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
>>>>     };
>>>> In this case, BTF_KIND_ENUM will encode the value of BPF_F_CTXLEN_MASK
>>>> as 0, which certainly is incorrect.
>>>>
>>>> This patch added a new btf kind, BTF_KIND_ENUM64, which permits
>>>> 64bit value to cover the above use case. The BTF_KIND_ENUM64 has
>>>> the following three bytes followed by the common type:
>>>
>>> you probably meant three fields, not bytes
>>
>> correct.
>>
>>>
>>>>     struct bpf_enum64 {
>>>>       __u32 nume_off;
>>>>       __u32 hi32;
>>>>       __u32 lo32;
>>>
>>> I'd like to nitpick on name here, as hi/lo of what? Maybe val_hi32 and
>>> val_lo32? Can we also reverse the order here? For x86 you'll be able
>>> to use &lo32 to get value directly if you really want, without a local
>>> copy. It also just logically seems better to have something low first,
>>> then high next.
>>
>> I can go with val_hi32, val_lo32 and put val_lo32 before val_hi32.
>> I don't have any preference for the ordering of these two fields.
>>
>>>
>>>
>>>>     };
>>>> Currently, btf type section has an alignment of 4 as all element types
>>>> are u32. Representing the value with __u64 will introduce a pad
>>>> for bpf_enum64 and may also introduce misalignment for the 64bit value.
>>>> Hence, two members of hi32 and lo32 are chosen to avoid these issues.
>>>>
>>>> The kflag is also introduced for BTF_KIND_ENUM and BTF_KIND_ENUM64
>>>> to indicate whether the value is signed or unsigned. The kflag intends
>>>> to provide consistent output of BTF C fortmat with the original
>>>> source code. For example, the original BTF_KIND_ENUM bit value is 0xffffffff.
>>>> The format C has two choices, print out 0xffffffff or -1 and current libbpf
>>>> prints out as unsigned value. But if the signedness is preserved in btf,
>>>> the value can be printed the same as the original source code.
>>>>
>>>> The new BTF_KIND_ENUM64 is intended to support the enum value represented as
>>>> 64bit value. But it can represent all BTF_KIND_ENUM values as well.
>>>> The value size of BTF_KIND_ENUM64 is encoded to 8 to represent its intent.
>>>> The compiler ([1]) and pahole will generate BTF_KIND_ENUM64 only if the value has
>>>> to be represented with 64 bits.
>>>>
>>>>     [1] https://reviews.llvm.org/D124641
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
[...]
>>>
>>>>           btf_show_end_type(show);
>>>>    }
>>>>
>>>> @@ -3770,6 +3779,109 @@ static struct btf_kind_operations enum_ops = {
>>>>           .show = btf_enum_show,
>>>>    };
>>>>
>>>> +static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
>>>> +                                const struct btf_type *t,
>>>> +                                u32 meta_left)
>>>> +{
>>>> +       const struct btf_enum64 *enums = btf_type_enum64(t);
>>>> +       struct btf *btf = env->btf;
>>>> +       const char *fmt_str;
>>>> +       u16 i, nr_enums;
>>>> +       u32 meta_needed;
>>>> +
>>>> +       nr_enums = btf_type_vlen(t);
>>>> +       meta_needed = nr_enums * sizeof(*enums);
>>>> +
>>>> +       if (meta_left < meta_needed) {
>>>> +               btf_verifier_log_basic(env, t,
>>>> +                                      "meta_left:%u meta_needed:%u",
>>>> +                                      meta_left, meta_needed);
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       if (t->size != 8) {
>>>
>>> technically there is nothing wrong with using enum64 for smaller
>>> sizes, right? Any particular reason to prevent this? We can just
>>> define that 64-bit value is sign-extended if enum is signed and has
>>> size < 8?
>>
>> My original idea is to support 64-bit enum only for ENUM64 kind.
>> But it is certainly possible to encode 32-bit enums as well for
>> ENUM64. So I will remove this restriction.
>>
>> The dwarf only generates sizes 4 (for up-to 32 bit values)
>> and 8 (for 64 bit values). But BTF_KIND_ENUM supports 1/2/4/8
>> sizes, so BTF_KIND_ENUM64 will also support 1/2/4/8 sizes.
> 
> Little known fact, but it's not true:
> 
> $ bpftool btf dump file /sys/kernel/btf/vmlinux| rg 'ENUM.*size=1' -A8
> [83476] ENUM 'hub_led_mode' size=1 vlen=8
>          'INDICATOR_AUTO' val=0
>          'INDICATOR_CYCLE' val=1
>          'INDICATOR_GREEN_BLINK' val=2
>          'INDICATOR_GREEN_BLINK_OFF' val=3
>          'INDICATOR_AMBER_BLINK' val=4
>          'INDICATOR_AMBER_BLINK_OFF' val=5
>          'INDICATOR_ALT_BLINK' val=6
>          'INDICATOR_ALT_BLINK_OFF' val=7
> 
> Defined as packed enum:
> 
> enum hub_led_mode {
>          INDICATOR_AUTO = 0,
>          INDICATOR_CYCLE,
>          /* software blinks for attention:  software, hardware, reserved */
>          INDICATOR_GREEN_BLINK, INDICATOR_GREEN_BLINK_OFF,
>          INDICATOR_AMBER_BLINK, INDICATOR_AMBER_BLINK_OFF,
>          INDICATOR_ALT_BLINK, INDICATOR_ALT_BLINK_OFF
> } __attribute__ ((packed));

I am not aware of this.... Good to know.

> 
> 
>>
>>>
>>>> +               btf_verifier_log_type(env, t, "Unexpected size");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       /* enum type either no name or a valid one */
>>>> +       if (t->name_off &&
>>>> +           !btf_name_valid_identifier(env->btf, t->name_off)) {
>>>> +               btf_verifier_log_type(env, t, "Invalid name");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>
>>> [...]
