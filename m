Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5F60192A
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiJQUQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 16:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiJQUPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 16:15:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199902098E
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 13:15:09 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJPXug009988;
        Mon, 17 Oct 2022 13:14:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7uGiKkCDrTbP6bWosaFYom3oze5g0Ipg4mvDFB90RBY=;
 b=LoxkWH0xtNuWucK1KOP3hwNlHgLjp42gIPzMu68NCqF4F26unvNAsykicSzMwdTIk/Hx
 1AMSJ8G7bK/WR7j0LV5ujVTf8zuwWx0YcQH/FutAd238QHZ6oOdTu+R7sq28RcO1cWW3
 ZkmRE5AfS+buq8ypa4EY7CEm17sOifCD3aX8t8Qf91Ix5pBMnYPCc9VH4RnyiJa5BdFJ
 47sN9YoAXicLKX9E2D+du+HQGm58/lMQJ24MsV3UUmdQ22+Ipe8EfM+9HPEni8YW+Cun
 U1hEkdoKiGvfaPjJyr/Uio7r6Z844INGtkwf7wmLxid+g8ifVjTvAdJMjQ7vNyOPhIZm Bw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k96mcvmsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfgRji7hPLiLd12EHe9S25fxiVIOKzpQVSTrDCh0GfMNPbTBzP5YFWo5Qi9QmHt0hw1ox/WaU+BPMDDfbEVsbXgeE2GNUehKGhepVZVvpofqL1jgTWy/uib4xGLqbiabt0ojF4Ucy7X8dRgNgR4rmm7Di5pIR6R/9JmusB5fja/zopmU4vgwgc3q7uTsj5p80vFYkg0lNvqy4FmbAt0b67RYd4+Rc4HkMvl3GmAJJ2TGZdj90o5eeXJmgg/vVj35xWrHOFEw1HmpUl9T3lJ+YzsTy/s8fRPg475Afc1vqh9Ma1u9SGiaH47gFC7VJnX0yeAewWKFBlB2wK9njJT0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uGiKkCDrTbP6bWosaFYom3oze5g0Ipg4mvDFB90RBY=;
 b=E8UNsIo9dGYxm7J+EZwMF00Vvu3XACVB/GNjRvUybYt1sgioZ7UmF0lnIA0HjWH4vw13kxzlZ427F9wjn2yJ1Ov6B1X1H9gJLWgMQYIrxKM25lc4ogdWm3xsvsq671eSFjXCP8lZnWY8Ot/BRJYz7zbZLXci1axumPwLqMGF+Tkku0lFji5usKJtASpFVHjKTqu3fI4GUV0UFWMO/TwuAVvxfp/B8GHB54bAhnm/yr0837RftbibodW+L9TnkBD321uTf21HlvxzKLU3fpHgbW4KmP8kiWTccgkxdr+3gaPajEh+G0L4J5RATCdNNp2kNCYyLZYMrNJ/LHGbZwIr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4974.namprd15.prod.outlook.com (2603:10b6:510:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:13:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 20:13:59 +0000
Message-ID: <beae278b-811c-6eee-7361-93e1c019119f@meta.com>
Date:   Mon, 17 Oct 2022 13:13:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com> <Y02Yk8gUgVDuZR4Q@google.com>
 <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 16875630-1755-4ea6-7163-08dab07c204a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sx7mk7ZncrKCUYXhvXSU7rhQYb7VRh4++BnQjn+J1Qn8Xlbz4UOEA6WguZ2ZXMhvX6Y0L1E3DcPoy11+3ynXnU1YfryyilTzHfLhldKkCDyzxjOSFVUzdzc2QPXzNtflOmibHX97lrS7+BA9w+pEUaLVcCCch98tUK2TUUL3CtIhr5UVJGuAHjNh5hgpzrcm1OijPS6b5cfHU5TYyEBRoo0ABzdew5Z+no2CFPeud5ntHOWjAD7MJaBRLaWQbmygag1u7NVenDoJQ8a40N9dZb2xgoV/tGFYYAeo09JaJbWtkuIfzKwJzOM8a8iSV7paOdZnE6ECUyAXoXsUKJJf7uX8TV0k040B8K9l/+X+pAg2h4bacR7WRyfEd/1xD1fSykZwNlADEckj+jjOz6xmov/b4LeQsWTKdq52BfKxQGnRrY3NuWSMwEAwEq5jL+zcqmFg+d4GNeRypQcSlE9TOUNOM1sTm9UvJ8mZFN9xP5mYMJmfjmIGSw3peaZWzD0vOwRsnyEM+5BbdZeN1qnRgrc24+g9oX4fxvYm3UNUhsZ4lrDn4Zh5+EJsfjadVYOn6vftZbEJ16C1V9Y6JEkvVMV2mDdEFZeVtEPMio+JlvpLNdRLuN1ifayfi8DtmIvDggb2bDFjKkb45bA/l5bBEW/7ljP+yRn3L43EeDAkycuawqk0BgiwFyOmP+OeLECRka3Q3+2JfyQieNkea3kRL3x22vfmvdkMDPsEtwHTcWlnvxj0WIlNXjusRSiC4As859xLMftflIMQJZQEBIG8HcbSFl/Q6DbN48Za4/EqTN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(31686004)(6486002)(478600001)(38100700002)(316002)(2616005)(186003)(66556008)(66476007)(8676002)(66946007)(110136005)(54906003)(6666004)(4326008)(6506007)(5660300002)(36756003)(53546011)(41300700001)(6512007)(8936002)(86362001)(2906002)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpybEs5aDN2dEt4em0wcmduY3ZoV2xyK1FsbldzSE54bXF1NS9lMzFWY0hw?=
 =?utf-8?B?TTNPYUxpTzVGWkQ4Qm54STFZTjV0MElwODV4RHVYT0dxSWdqbXBXRUFtZjJx?=
 =?utf-8?B?aHhXa0pKQWNxRDNra3dyTXdDdmxtZkpLUUxVT2JWa1JoWW52SzdlWEJ1cnZ5?=
 =?utf-8?B?WCsvMlFsZit6NVFLd3BzSWFSVGZKTi83aEJPYzQ5VHA0RHAxU3FobEVpZU1F?=
 =?utf-8?B?dEQyYU51YmU1TVhQdXlWZzRZRjYxeFkvRDMvWnRpYTg5eFN2bTZnaUEyVTFO?=
 =?utf-8?B?WEYyU2hvTTBwdHgyNW53WHQxbFptZkNlTld3WWpsaW1EeStQMEhoWHFxTExD?=
 =?utf-8?B?OHI4azFmN3I3WUVRV1d4ZXk0WWtoVVc0dXYzR0FBb3pXTHk5M1VES2p1amhn?=
 =?utf-8?B?WTVVZnQwZDRpMDhOYlJBSXBGdE0rb0ZpbnhRNTMyVXpaaEEwczR5UG1xSVhU?=
 =?utf-8?B?YUZsZDZaRE5lYm9MaUVYNXpFckF4a2FaZS9KUlV6RnJBcEJLRWV4TVJab2hT?=
 =?utf-8?B?OXdIUTlWOXZMa0paeVlMSjZ6MHVUejg0L3FzVjdCYjlTZG9teUpSQk11ZWMv?=
 =?utf-8?B?L242VTVETytUOCtLcnIveEJZVGVaUWdQU2tlYS9XWVFhKy9vK0g4VGdNV0Zx?=
 =?utf-8?B?a0dLV3VDL2h6blgxNzBOWmlSL1E0V1lTZmFSbHlwWkdBc1dWQnNIV2FKdHVz?=
 =?utf-8?B?YXBlMU1UVEp5WEUvekhTejI0ZHVITkNOSy9lZUpXN2NLaEFIUlNjS3AxcEp0?=
 =?utf-8?B?M0EwRFZ6Rjkvanl0Yzk0MmF5T3p3bHlKNHFtdlhoMDh0OXNLL1Q4cUlEMXJh?=
 =?utf-8?B?RFh1SnJ3TnpKRTd6RjMxQStMMmg1RjBHK1oxUHQ0eHZpZXBmTlcwOFc2ZmFH?=
 =?utf-8?B?eHpSbVoyTXJIUklxazd6ZnE5T01pZjRMbWk2K3QxZUx2cldlZ1BCQUN3NC9Z?=
 =?utf-8?B?U0NTUDVWOEJNL0NaVHBmb05rbUMvSE9wYnBsUUJ3UklVN1hsZWVkdS9nYjNE?=
 =?utf-8?B?VnZzR3lKNUVZeXhTVFM5cFZUMUZjc0RkMlR3ZW9EbVR6VGEvV1BNbjJsNlB6?=
 =?utf-8?B?SWdiZmNpNStxWEJiV05vME9tWklHcmhUQWttTkNKSmhxM2NWOVIrNDJlTlFP?=
 =?utf-8?B?SWMzTkR2b0VCMjFCS1ZSd0x4cVQrVnl2clVPYnFmemFGYlF0WVdDMmEzN0I2?=
 =?utf-8?B?bzdtTC9qaU4vMWtVUHhGalNDUmgvSFJqQjd3NWVpeEFMaTdqdWxzQ2xaOFJW?=
 =?utf-8?B?b09ZOEc0TnkyRCtUY0JyRDZseEQ2cGc5dnBjY2l6TFFSY3JKVDRHVmJWRDRj?=
 =?utf-8?B?M0ppSlVvcThLMDFmY3BXUzM4aGVIcm1jNHg1T0tJblp2ai9vYzFQcnJSeEsz?=
 =?utf-8?B?V3RUbEhLdlVzRFlOTlNSZkxMa2FEbVlmaitSRFlsa2VtUHZQV2U1NEdIYnBH?=
 =?utf-8?B?U0QxdGFDQ3NDZU5yVVlyNGdUcE1XZkx6ckJWYjZQeDFsY25ZeGgzM3ZOdFY3?=
 =?utf-8?B?ME5GRE5sU3IzQWFWazBzNENGTHpDeUFmMlo0b2VNQWk0aERpNytkZHQwMndr?=
 =?utf-8?B?MUZ3WGthSlEyWVpTdWpqbVM0dlVSTG53bnYrSFpWbVhncVdUTTFDK1lzSEJm?=
 =?utf-8?B?RTVhZFB1bjdXOEtOSXRqb3NvNDF6WU1VVFdxWFZqVEkvVzhtNjNVM2MzaEpq?=
 =?utf-8?B?YXUzbXQ5TXovY1NLZVhUZUdCY3FocXRuTDFxRGFvR1p4d0hISGVodlB5NEtj?=
 =?utf-8?B?TVoxY0UyOE91cEVnVjUrSWxzUkt6clRYcEtWNWdma0cvUCtNQWxzeTdvUlU2?=
 =?utf-8?B?OE5ieGpnSGJKdWhabE44MmRaV2NCWUZDbDF3K3o4aWFsaWhueS9jS3Z4cVhV?=
 =?utf-8?B?RXBlQXJtU2VtdVhHTXptalVJVXpZRk5aSmNGd0M1VzArQUFlOHYrVWt3MU40?=
 =?utf-8?B?K3RjMjlFa01oclNwTTkrWWlKTk9iRTIzUXpOVWNuNld3WTJIYzk4Z3JodlpJ?=
 =?utf-8?B?RmNOcU9QTGkyNmxpblkwK3pZdjExenNFamk4QWk5U2pNc044UTdtTDR5Q0xs?=
 =?utf-8?B?MFpuYitUakpTc1dqTVpWdkhLcG44OXMralVEWTRtRFZBVUFKM3hiQXdWSW1r?=
 =?utf-8?B?UGMyYmg2bjBBZ2ZUWHk4bVpOYjhKZjJmYk53ZXh2ZjdXb01SWWZid3IxdEJM?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16875630-1755-4ea6-7163-08dab07c204a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:13:59.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0Zl3/6UAM3fAJPwgXyGVfhOhQBC4c4CSi74O5jw650ZDGqQ8YVjEBtQQfRSXbkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4974
X-Proofpoint-ORIG-GUID: SW15HebDPobuLX1V58fxYDbx8jJuLqCT
X-Proofpoint-GUID: SW15HebDPobuLX1V58fxYDbx8jJuLqCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/17/22 11:43 AM, Stanislav Fomichev wrote:
> On Mon, Oct 17, 2022 at 11:26 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
>>>
>>> On 10/13, Yonghong Song wrote:
>>>> Similar to sk/inode/task storage, implement similar cgroup local storage.
>>>
>>>> There already exists a local storage implementation for cgroup-attached
>>>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
>>>> bpf_get_local_storage(). But there are use cases such that non-cgroup
>>>> attached bpf progs wants to access cgroup local storage data. For example,
>>>> tc egress prog has access to sk and cgroup. It is possible to use
>>>> sk local storage to emulate cgroup local storage by storing data in
>>>> socket.
>>>> But this is a waste as it could be lots of sockets belonging to a
>>>> particular
>>>> cgroup. Alternatively, a separate map can be created with cgroup id as
>>>> the key.
>>>> But this will introduce additional overhead to manipulate the new map.
>>>> A cgroup local storage, similar to existing sk/inode/task storage,
>>>> should help for this use case.
>>>
>>>> The life-cycle of storage is managed with the life-cycle of the
>>>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
>>>> with a callback to the bpf_cgroup_storage_free when cgroup itself
>>>> is deleted.
>>>
>>>> The userspace map operations can be done by using a cgroup fd as a key
>>>> passed to the lookup, update and delete operations.
>>>
>>>
>>> [..]
>>>
>>>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup
>>>> local
>>>> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
>>>> used
>>>> for cgroup storage available to non-cgroup-attached bpf programs. The two
>>>> helpers are named as bpf_cgroup_local_storage_get() and
>>>> bpf_cgroup_local_storage_delete().
>>>
>>> Have you considered doing something similar to 7d9c3427894f ("bpf: Make
>>> cgroup storages shared between programs on the same cgroup") where
>>> the map changes its behavior depending on the key size (see key_size checks
>>> in cgroup_storage_map_alloc)? Looks like sizeof(int) for fd still
>>> can be used so we can, in theory, reuse the name..
>>>
>>> Pros:
>>> - no need for a new map name
>>>
>>> Cons:
>>> - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; might be not a
>>>     good idea to add more stuff to it?
>>>
>>> But, for the very least, should we also extend
>>> Documentation/bpf/map_cgroup_storage.rst to cover the new map? We've
>>> tried to keep some of the important details in there..
>>
>> This might be a long shot, but is it possible to switch completely to
>> this new generic cgroup storage, and for programs that attach to
>> cgroups we can still do lookups/allocations during attachment like we
>> do today? IOW, maintain the current API for cgroup progs but switch it
>> to use this new map type instead.
>>
>> It feels like this map type is more generic and can be a superset of
>> the existing cgroup storage, but I feel like I am missing something.
> 
> I feel like the biggest issue is that the existing
> bpf_get_local_storage helper is guaranteed to always return non-null
> and the verifier doesn't require the programs to do null checks on it;
> the new helper might return NULL making all existing programs fail the
> verifier.

Ya, this is indeed the case. Another difference is the new helper
is able to access data from different cgroups. and the old helper
can only access data from *current* cgroup.

> 
> There might be something else I don't remember at this point (besides
> that weird per-prog_type that we'd have to emulate as well)..
> 
>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    include/linux/bpf.h             |   3 +
>>>>    include/linux/bpf_types.h       |   1 +
>>>>    include/linux/cgroup-defs.h     |   4 +
>>>>    include/uapi/linux/bpf.h        |  39 +++++
>>>>    kernel/bpf/Makefile             |   2 +-
>>>>    kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
>>>>    kernel/bpf/helpers.c            |   6 +
>>>>    kernel/bpf/syscall.c            |   3 +-
>>>>    kernel/bpf/verifier.c           |  14 +-
>>>>    kernel/cgroup/cgroup.c          |   4 +
>>>>    kernel/trace/bpf_trace.c        |   4 +
>>>>    scripts/bpf_doc.py              |   2 +
>>>>    tools/include/uapi/linux/bpf.h  |  39 +++++
>>>>    13 files changed, 398 insertions(+), 3 deletions(-)
>>>>    create mode 100644 kernel/bpf/bpf_cgroup_storage.c
[...]
