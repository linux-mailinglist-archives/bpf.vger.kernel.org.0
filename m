Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C7F646129
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 19:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiLGSfT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 13:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGSfS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 13:35:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796972AC1
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 10:35:17 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7EoGc1015997;
        Wed, 7 Dec 2022 10:35:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=gnmzFNiJ42zDhEMQ8r+yLqBl/kwHSSfn/nkmcIBbIzU=;
 b=Plw85LjG55W5wpIu8DOBBNhFXRhSVEHipu9SukwOAs2ahb1D7gij75Hs1rnsI1OsH1Ck
 jdPYpVxRBOyTgM7aFP3XFbYZHAd8tQQCHsW1ZhnAi1A9vgW/EaXnszXo8HwN77i3Iz8c
 36bBaMnuXYX4IqqzEHiE4OEILSmspCrDyXcVj278/T9p9V4KvhmiY68odwDu49S9szYF
 Pvzez91uZU3zYcOHm/s1uDrbzsNY9lMqJWlgMhmkJDRq7m6CbJMGMg5xCEFidzNALmHy
 ZtnkNwmH3j4/Susuqe2Kax6oDvCKNetJmf/0rbqo9+n4Qp1c+edhVPnoqoNcOSWUr3Yg WA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9x7fd74y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 10:34:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh61QtOj5EL66JjnK25Zm7yxqc027zA0/sE9UndswsJsOJiRYJbYT3zG5AmrNU0jDkG/XRBANFVG6+B1QML55/9pZnxPdMbC82dqoSbXB7s7yvoD6jnhuMacRZag58Z6/xEun6mAAX0CLNSdhLTiS0Wd7vnr8FyCm/gvYKPdLhhJfs8vPIHKGv9Te1YDhjenvOZrz+LXF3xqhHCKrGm3zqEVw9ZPIdyGRmFyV7knHWJ49A7/AYdn/U8xzCEJJjM2njkruRs7zRLPGyd6hdH7eOOfrTP9WXFFW8jAqOrc1ZnkNn6sdAmbdGvjw4zoYwIdk3R33v32j17zsu0TBG8lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnmzFNiJ42zDhEMQ8r+yLqBl/kwHSSfn/nkmcIBbIzU=;
 b=ftv20HqX7dUcTn9ev3h9M6m5mM9paGW4vXIxaIN3A4UwhFNGDFey1LySGLg7A3lLKjQ/9/EOrOIr44gmjKOAw69Wz03VaTsoQ8zZmcNoVvkMXGNg1qY16+WS9Qkng6demW9ooZt3cQPjo/czcK2khZYHB79k3OozCsABGpMl4f9V71vYsDjvVBaFCQnTzw96XqyY/FCv5NkeAS5ZnuJ0Le7JEXONf7MP9Z1xb467HV6xxfL/RbrlVuhRZgGUvj2SePf2QsrIMAMVbrJwbrQJkkVXWyefTZA/wiL5JabVBUfZl6aNkWjZeY9novOywBXXviovBoGpg00MMOOwxXhnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by BN8PR15MB3089.namprd15.prod.outlook.com (2603:10b6:408:87::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 7 Dec
 2022 18:34:47 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:34:47 +0000
Message-ID: <a8079b93-15d5-147d-226b-13bbebfda75e@meta.com>
Date:   Wed, 7 Dec 2022 13:34:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 01/13] bpf: Loosen alloc obj test in verifier's
 reg_btf_record
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-2-davemarchevsky@fb.com>
 <20221207164121.h6wm5crfhhvekqvd@apollo>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221207164121.h6wm5crfhhvekqvd@apollo>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:208:178::14) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|BN8PR15MB3089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7f729b-eb6c-4448-71a7-08dad881b780
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuumW8YUntpCAjhzipEVupGVTjhaHkJYpU/N9qulP0XAIe/oQswWr+E0Y+HA3SH3h++RWmt3F+nKgZ1CjOsl/spSiVqIw26B+tfZgPQpVPMl8B7Hzo9OGxWkLo4aGJ4RwOKxhP8bPMxM+KXW9J84NOoCBkPehjKBvmJJbU452wgdfViV7mmMJzk93MI9pGefGF7g2djniLLpJ5R5DypghEvGOks9ZABnXOzaP8x5LGR76ANxANi+4wCAianZ4uy4SB4Fhs/cL065D4JNSpNfztgaVukqXINTpghfxnns2b2n0oq62cZYfQ70mMzP770WHcnrqXx8aMmZrX7HWMhLsiWBT49qI06H4H5Itgp3Ut/uwjSumSof0d4tms3ruqUQnxkPCe5t/tm0W2Guc8X4DF0Zwk6lnUScnRiypZ5izqcN3eGjrAic4zU3dr+MkUU4J/v54/k5w1NWPC3r5gODPmChRGEkfqvn4HO6FIq54ylokstxo1anxxp7jpgg6nM0l7sLle/Dza4QLlu2X1ZfZCKbr1W6wqsy3g8aYMCvvdIgDCwaKyr/FFfe+RpTyOUofRFC6Gte25H9NcciSL7/t29VDM7wnTGmSt4vjRuS1x2fQgPS9Nrf5jvFRkRzWBIrZ0sf+0C4wTKWijoLi/4cWYPa2aXPJgIn3qu+4cSWj1YgSukWtb2MIeS1yslFmu5llzecN54gFkvb+qrSwABOnCNmAFGbWk54zKApcvRoP2oYvZ4wc6uvANI4XVWF23x8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(6666004)(6486002)(6506007)(31686004)(66899015)(53546011)(966005)(478600001)(86362001)(31696002)(186003)(54906003)(38100700002)(316002)(8676002)(66556008)(110136005)(66946007)(66476007)(4326008)(41300700001)(2616005)(8936002)(6512007)(5660300002)(2906002)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxJQ2JGazBRNjA4UFovdWNKaTI3Wkt0bWZCb3lpVGFQUXhGMnlHWWZxSnhI?=
 =?utf-8?B?MndUck5kZ1BJQ1hwL1M3dnFUby9WMDU4SGlhazE5aDlJbzZDZEMySGhqdlow?=
 =?utf-8?B?eHZjRHd3eEgwQitZRUFNSmEreFpYaFVmMTRiYW9uMzNCRnhWT3Y5TFcvSHJT?=
 =?utf-8?B?VWE2R3M4NGJ5aFpLejdlblhDdUVxc0hTUThYT3pKeVJvZ1pkZUljNWVmRUF6?=
 =?utf-8?B?S2RtUGpIZ3NUYm9yRmpzQk9xaVFyK3pRU3d4bC9jODdBUjRiMnpjaHl3QnNl?=
 =?utf-8?B?NmpEVys1Zk5USDlrYThzMkNYVU9tODluOTMvL0d5Tk9WWFFNbThoTHJmQ0l6?=
 =?utf-8?B?ZHI5Yk5VQWx3bFprZk4xcjlEaUlBQUNOeUJpUi9XRHNha3VGSkdTVzI0MTBV?=
 =?utf-8?B?dHRXVFV1MXl5OU1lanJGZFBnOWxMV3VNSElONmpUS1Q2K0lwWlkwUVhmV3Ey?=
 =?utf-8?B?cEpnbWJhcGZVcVRuOVNKWkJtWElibFhCM25FZitmbnNJenhyOGRWK0NyZDJv?=
 =?utf-8?B?NEhTNG5iSlBxdFJUdXlObTl5dzBoT2VwanRHVVJrZEFEUUkyb3M4VWo2SUhj?=
 =?utf-8?B?MGpvTEpkYTkrQ3I0eUtNN2RqN0lBc2ZtMW9aSU85SndQT1hyMWU1MldIZ3R0?=
 =?utf-8?B?Yzd1WXJEbEtIMGFHdmhhaklLRWlYLzJwV1V2WlNhaW5Cb3lnc21YM29yR0ZX?=
 =?utf-8?B?cjFtV3hucmN5TVhPQVVia0publh0WUVXeE5COTFETzR3Q1VxdVZEcEVMRFA2?=
 =?utf-8?B?aGhGUWpMK3lkMmNUT3pvSkJud08yRnNzT2t0NTF2dUdLUklrUEhQbkhGcmRI?=
 =?utf-8?B?c2NoWVgzbTNnZ2h3M1VpcjVLUEJCUzM5cGhPcXhTVzgwSWhnWFdveldzNlY5?=
 =?utf-8?B?bnpldVBnRXp6NkIxMVFoOXA0SWpGYmprNDB4Sy90eW9BWFNVVGM3bGROekMz?=
 =?utf-8?B?SDB0aTZXZFlmRzhzN1BvOFE0cGwrS24zdkZ0MGdmekg1ZUUwMU9XWjRBT1Fv?=
 =?utf-8?B?RHgxVFpNeTRPd1lubTkxbkY0TFFaT3ZTZGJLRDl4NWFtekFzbVIydHg5ajVt?=
 =?utf-8?B?c3c3dHpydFBEZUNweG9UYjk3NnlCeUVpd1NDdk1Lb1d1VVN4cFdodHdUaDNR?=
 =?utf-8?B?b2czL2MxZnJDeTVEbGg2UDd2TFN5Y21oR3lHUXhBdVhyQ2VpbVdDcjd2U2RG?=
 =?utf-8?B?SzRpelUzMXVGSWZlQ2VNN3pibGpnQjFna1M3eFRwMkxadStPOTNINzIwNHJB?=
 =?utf-8?B?ZCtWdTkrdS9yeHFIdzhHd1EvanA5M2RxemVXSXZrUUlVamYvOTZKZmFra2Yz?=
 =?utf-8?B?UkJYSzR0N3VFdzNCWXNtSjFtTEk1SjdzVjdmR2pXYVAyeUVkenRrUFV2eERa?=
 =?utf-8?B?VnhtckVoRGx5ZnRqMEw4TjZqOVZZVXlha256dUxReU9yN3ZzOGNFbk5ZUk9s?=
 =?utf-8?B?RlZJSVdxMGZoVElONlF2UElhUmxsR1ZvT1dYV1RqS1FNNk5WOVhvNjR6aDJk?=
 =?utf-8?B?WTV4N0JhNlcxb251RWVTeTd5L0h5cW5yV016ak5FOVduM2M1ZFlqakFLNUNp?=
 =?utf-8?B?NFRCdFNoUzE2bzlPU0dhL2VIZi9zNVo2V3ZNZ3hQc2phUUs5Z0R3MlZjUjFI?=
 =?utf-8?B?WGVkUjVKaElSdUJ4cmtlaW9rT2VJZGIrNHZkckc3ZXVHTGl4Q21nYmdVWGtw?=
 =?utf-8?B?TE1mQWlnb3JoWVhsT0dWbDRjTTN4YWtHU21FamlEUnNUMldEb0lYOFpyTThq?=
 =?utf-8?B?NFM1U09TVG8xc0JVNWtNZ1hIQzNPaWZscllNaGVwaDZuSXFHNGtCbk1leThS?=
 =?utf-8?B?elIzeG5Ha0lNTTRQOVBuUnlFZmpnMC93YkMvM0V3dzNjMFIyQ2svRGRGVHhR?=
 =?utf-8?B?dExJVnBFcWtvY3hjRU5WOHZOeEhZUlVKalRCRGVibmF3LzFyQnpRSTRLMzdk?=
 =?utf-8?B?eGMzei9TcEtsNUk4L3oxMU00cFhwZllSOFk4SjdlUTJONm5rK3BYMThIOWNI?=
 =?utf-8?B?dWdJait5ZWYxNTNuQ0lFa0JTQklBQy9yaXZHTGp1N1hBZ2JDcFdROC9Ra0cy?=
 =?utf-8?B?V2l0RnBTV2VoTllZOURtR3NZcUdPQ2VOOWhaTUlydUdKaExSUS93Sm93Y3Zz?=
 =?utf-8?B?dG9CYTdQN1AyKy9LYXB6blBtUFgzWHZEYjJucFM2R0MzbzF2eWpZY0NPUnoy?=
 =?utf-8?Q?2KC011I8s1AAexFlHnkRHH8=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7f729b-eb6c-4448-71a7-08dad881b780
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 18:34:47.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQ2eM0SYoLX9vN2Li2PoBYP9pxN5c8T4K8o7F0exKjI9UMXLws00QupD7LxArCF/YmSMtkHFbZ8Sh/ex3D72qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3089
X-Proofpoint-ORIG-GUID: DNF5l_dMyTFZioNlKyJyD4TWbJ1HdEzF
X-Proofpoint-GUID: DNF5l_dMyTFZioNlKyJyD4TWbJ1HdEzF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 11:41 AM, Kumar Kartikeya Dwivedi wrote:
> On Wed, Dec 07, 2022 at 04:39:48AM IST, Dave Marchevsky wrote:
>> btf->struct_meta_tab is populated by btf_parse_struct_metas in btf.c.
>> There, a BTF record is created for any type containing a spin_lock or
>> any next-gen datastructure node/head.
>>
>> Currently, for non-MAP_VALUE types, reg_btf_record will only search for
>> a record using struct_meta_tab if the reg->type exactly matches
>> (PTR_TO_BTF_ID | MEM_ALLOC). This exact match is too strict: an
>> "allocated obj" type - returned from bpf_obj_new - might pick up other
>> flags while working its way through the program.
>>
> 
> Not following. Only PTR_TO_BTF_ID | MEM_ALLOC is the valid reg->type that can be
> passed to helpers. reg_btf_record is used in helpers to inspect the btf_record.
> Any other flag combination (the only one possible is PTR_UNTRUSTED right now)
> cannot be passed to helpers in the first place. The reason to set PTR_UNTRUSTED
> is to make then unpassable to helpers.
> 

I see what you mean. If reg_btf_record is only used on regs which are args,
then the exact match helps enforce PTR_UNTRUSTED not being an acceptable
type flag for an arg. Most uses of reg_btf_record seem to be on arg regs,
but then we have its use in reg_may_point_to_spin_lock, which is itself
used in mark_ptr_or_null_reg and on BPF_REG_0 in check_kfunc_call. So I'm not
sure that it's only used on arg regs currently.

Regardless, if the intended use is on arg regs only, it should be renamed to
arg_reg_btf_record or similar to make that clear, as current name sounds like
it should be applicable to any reg, and thus not enforce constraints particular
to arg regs.

But I think it's better to leave it general and enforce those constraints
elsewhere. For kfuncs this is already happening in check_kfunc_args, where the
big switch statements for KF_ARG_* are doing exact type matching.

>> Loosen the check to be exact for base_type and just use MEM_ALLOC mask
>> for type_flag.
>>
>> This patch is marked Fixes as the original intent of reg_btf_record was
>> unlikely to have been to fail finding btf_record for valid alloc obj
>> types with additional flags, some of which (e.g. PTR_UNTRUSTED)
>> are valid register type states for alloc obj independent of this series.
> 
> That was the actual intent, same as how check_ptr_to_btf_access uses the exact
> reg->type to allow the BPF_WRITE case.
> 
> I think this series is the one introducing this case, passing bpf_rbtree_first's
> result to bpf_rbtree_remove, which I think is not possible to make safe in the
> first place. We decided to do bpf_list_pop_front instead of bpf_list_entry ->
> bpf_list_del due to this exact issue. More in [0].
> 
>  [0]: https://lore.kernel.org/bpf/CAADnVQKifhUk_HE+8qQ=AOhAssH6w9LZ082Oo53rwaS+tAGtOw@mail.gmail.com
> 

Thanks for the link, I better understand what Alexei meant in his comment on
patch 9 of this series. For the helpers added in this series, we can make
bpf_rbtree_first -> bpf_rbtree_remove safe by invalidating all release_on_unlock
refs after the rbtree_remove in same manner as they're invalidated after
spin_unlock currently.

Logic for why this is safe:

  * If we have two non-owning refs to nodes in a tree, e.g. from
    bpf_rbtree_add(node) and calling bpf_rbtree_first() immediately after,
    we have no way of knowing if they're aliases of same node.

  * If bpf_rbtree_remove takes arbitrary non-owning ref to node in the tree,
    it might be removing a node that's already been removed, e.g.:

        n = bpf_obj_new(...);
        bpf_spin_lock(&lock);

        bpf_rbtree_add(&tree, &n->node);
        // n is now non-owning ref to node which was added
        res = bpf_rbtree_first();
        if (!m) {}
        m = container_of(res, struct node_data, node);
        // m is now non-owning ref to the same node
        bpf_rbtree_remove(&tree, &n->node);
        bpf_rbtree_remove(&tree, &m->node); // BAD

        bpf_spin_unlock(&lock);

  * bpf_rbtree_remove is the only "pop()" currently. Non-owning refs are at risk
    of pointing to something that was already removed _only_ after a
    rbtree_remove, so if we invalidate them all after rbtree_remove they can't
    be inputs to subsequent remove()s

This does conflate current "release non-owning refs because it's not safe to
read from them" reasoning with new "release non-owning refs so they can't be
passed to remove()". Ideally we could add some new tag to these refs that
prevents them from being passed to remove()-type fns, but does allow them to
be read, e.g.:

  n = bpf_obj_new(...);
  bpf_spin_lock(&lock);

  bpf_rbtree_add(&tree, &n->node);
  // n is now non-owning ref to node which was added
  res = bpf_rbtree_first();
  if (!m) {}
  m = container_of(res, struct node_data, node);
  // m is now non-owning ref to the same node
  n = bpf_rbtree_remove(&tree, &n->node);
  // n is now owning ref again, m is non-owning ref to same node
  x = m->key; // this should be safe since we're still in CS
  bpf_rbtree_remove(&tree, &m->node); // But this should be prevented

  bpf_spin_unlock(&lock);

But this would introduce too much addt'l complexity for now IMO. The proposal
of just invalidating all non-owning refs prevents both the unsafe second
remove() and the safe x = m->key.

I will give it a shot, if it doesn't work can change rbtree_remove to
rbtree_remove_first w/o node param. But per that linked convo such logic
should be tackled eventually, might as well chip away at it now.

>> However, I didn't find a specific broken repro case outside of this
>> series' added functionality, so it's possible that nothing was
>> triggering this logic error before.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Fixes: 4e814da0d599 ("bpf: Allow locking bpf_spin_lock in allocated objects")
>> ---
>>  kernel/bpf/verifier.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1d51bd9596da..67a13110bc22 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -451,6 +451,11 @@ static bool reg_type_not_null(enum bpf_reg_type type)
>>  		type == PTR_TO_SOCK_COMMON;
>>  }
>>
>> +static bool type_is_ptr_alloc_obj(u32 type)
>> +{
>> +	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ALLOC;
>> +}
>> +
>>  static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
>>  {
>>  	struct btf_record *rec = NULL;
>> @@ -458,7 +463,7 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
>>
>>  	if (reg->type == PTR_TO_MAP_VALUE) {
>>  		rec = reg->map_ptr->record;
>> -	} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
>> +	} else if (type_is_ptr_alloc_obj(reg->type)) {
>>  		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
>>  		if (meta)
>>  			rec = meta->record;
>> --
>> 2.30.2
>>
