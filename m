Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65A231DF1D
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 19:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhBQSaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 13:30:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231704AbhBQSaM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Feb 2021 13:30:12 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11HIPN9n020784;
        Wed, 17 Feb 2021 10:29:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CD40zgkItmia7a4dhZLEfNyV+PdbUI/DVzuPEG7fdt4=;
 b=V2y5/Jda3vYJRVBhpEe+nBl1ZbT/bH6Xx49p6ebHhBkYWTiPJXfaQ7NINrUbMZL6tUHV
 o4b3YJoZEhf8uf90YkUSPaa+cX/KcJQS2nuPsDE7wnrUpG+FYZp2edVHkP/+NzM4T/+D
 wJHsjDphmH1RETbgl1svTrjW0x6+lEMeA2g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36s7fprdph-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Feb 2021 10:29:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 10:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOS7gjQxkdxSr9sBHWYAYDgSPRV1jchxGnOOzUy4CrFlFppNtBzq1E7lRX8xclAmydUM1ML52v5AUho0KhU3Co+kxAxmdeTl98ngNsYORlkUoNfgdh1HyMO4bSQ5USo15j2ycQCmmvUWEJ1e+NMtAgJMH76IgmSZniJtG3JWnsRPVBW3NHW1OpnMcrXb7k31VpQzb1ejucU4+84zPkN3ziRmD/JwGvgTvsKpkiwPPVnbx+7yxUHeCY00KvKzPeaXfl92OpEZd3wTEoLgkKInBQ1nFpOFWY5IkcYYu6tAapcZp6wgzOoYcbPfhkSUuZVUVQHRTxjqr0k9N9+Au/LsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD40zgkItmia7a4dhZLEfNyV+PdbUI/DVzuPEG7fdt4=;
 b=S0Z4xwt6D4dbUpNSWoZfDZJae6BZkDBvXhuTft06RGW+iCsz1V0yBXo0+49XO4r2KsmIHUmBOcsf49YnqJKfn6PTvitOyhTgKFQj/QnwOO/XE0tKJRdxkMhIo7JD1W9qUoe6y3U4FPgBrdNt3yKQZyJuZafzHGCN5ryZENDsQu+LW3aRgjstQIm7UmtTuKTvUMxRTcCcXyeTEGAYXHslhgO4jIK4JOsta55bDTTFlo+kkWeMjPOp/AU9axPnBKj71uBDkAGr0Pvq2LMqrVmCL6UyWCDgUol0Ct+NzU2uuV5Uo/7utspCJDV8fLbv/8m80+BYvSpNVD8ixCgCyhe3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4680.namprd15.prod.outlook.com (2603:10b6:a03:37d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.39; Wed, 17 Feb
 2021 18:29:16 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3846.041; Wed, 17 Feb 2021
 18:29:16 +0000
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add bpf_for_each_map_elem() helper
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
Message-ID: <5ef6c3fe-b894-f760-3591-717518866748@fb.com>
Date:   Wed, 17 Feb 2021 10:29:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210217181803.3189437-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:25bd]
X-ClientProxiedBy: MWHPR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:301:14::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1362] (2620:10d:c090:400::5:25bd) by MWHPR1701CA0015.namprd17.prod.outlook.com (2603:10b6:301:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 18:29:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0590a578-42b3-428b-c343-08d8d371ee95
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4680743CAFBD5B381CAC7342D3869@SJ0PR15MB4680.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErMqvA/g3HDO1Nqzde39z+eKQZZn8tUKHb7QpaZMF9KkL2Z2bDbDCbeiyqpOYSIo/sJMifoK2zp2BL/ffzDg86jArQHnjvadXNYdk7hbKM4CP7bodPHnB8yk+7TfmQ01Eq7i7n6dgpteKf2t2ec9qxmGdvcGxFpMjysedFeVPd5U4sGwozHTpe8zFc/Or++WRtJ9ZYGlN0xiesFp8QH+3MDsQ7mAcINaiH3Z9IZD7YUw8N5AygrqAGCRPYATwiCFcdQho2H1ZzVFB1aQ8k4gtXpednY74IKE24S0ewlK8YJSxHK6e3uh0JS3QYLuPjqnjhWIIlnTbhLsmdZTshwHainaf7ts7etbHwujw1lkVKobigaY51a7zQfA4u/1Ai6bmCtJ2h9q964fdrF+9ePdzcTAJxPCArVCTgQRpmqtNwS34ZYiS3M2X716QW68/Q0MwDKqcMEpi/gN75VqcDCZ71QuBgimVPh/3XQUHwSjxfwpJyDEl4QfQmsfQoKQwSiNKlJUOo1w7wUFiDg8DruZfaBqLzyKcSagHC/QbfBa1/ZqvzI3yMSulVyD2juccob5QSa2yHmUt1ZqT7rkOWUM90wTK/7aKAlQmcAcvr/wzE5C5hnrMnacZOf7ufKQDAE35OULe+0Dp9GsrYmmccjWLXTUjiIT9KCSx/UKUjjhGTM3Pe9J8w5GWbuVZERSHX8m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39860400002)(31686004)(186003)(36756003)(2906002)(16526019)(8936002)(6486002)(83380400001)(316002)(31696002)(6916009)(86362001)(5660300002)(52116002)(2616005)(478600001)(53546011)(966005)(4326008)(54906003)(66946007)(8676002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RXpFQUhwMUtpM25YK2lEV2srS09YSXplVmxKUTFaQ05YUUNnVnA0R2VXcWVS?=
 =?utf-8?B?OThvR1FIVWF6ZGl5dkRaMjlVYWxkVXJ0Qk9OY2RHZUhmVkJMaFBvQUNQQkly?=
 =?utf-8?B?UDFCb1FmQ0d6bWhoQTJCRW1LSWNZd3lub1ZsQzd3cnBXYkQ3M0c1RTlBVk1V?=
 =?utf-8?B?dmtmaUs3UzNOZzBMeFRTWUwrSEU4b2VzMVcvcnRXUWN2WjVtMVI2TGloT2Fp?=
 =?utf-8?B?SElnSUk2UW81MTB2a285MmNHbkoyZm95L3BOemU2QTVRMGxjdUFDODhzVkR4?=
 =?utf-8?B?Tko5QXh2dGtkdzd1UTVGZU5PK1YzYVpBRDcxYU9VNmJydkNqUm50SWVEbHM5?=
 =?utf-8?B?cVBUNU1ISTN4TkM4OVFvbzhjdExXNUVtcVRLSjBlaW8yY2dHM0NjMlVPNEh5?=
 =?utf-8?B?SkFsZmYzempFMHM4WVFRSWlOQWJKN3FiaEJxTDNIWVhyMDkzd29QTlN4ZlFP?=
 =?utf-8?B?aVliTjNUaHNXcGk4dm9DMDIyanlNcVBHam53aUV2QnVOZ25sYzlHdHZ0Y3Na?=
 =?utf-8?B?dlA0ZGdKL2kvYTdIWTJTYWtwZzJGV2RCcVVmeVVnSkVhemQ4eTZhQks3Ty8x?=
 =?utf-8?B?dk1SL1JvYXhQcmNPT0JDMTEwTzZ3ZmlyMkR6bUJVb1Azd3RqU3R6cUlEb2du?=
 =?utf-8?B?cWcrR1FueXNIT2tYai9DcXVOMG14REdjZkVKOGdGK0FTU1dPbWR2MVlkREtH?=
 =?utf-8?B?QTNEa25uM1JZZU9Way9INk1pQW5xR0xlSW1XcWU1RnlIU2R5OW42ZkJ0R05p?=
 =?utf-8?B?Qm1VTVRkL3I4M1U0TllEbThhdXZ3b0V1cE9Fb09uWlZnbm53V3dKTjBWQVZO?=
 =?utf-8?B?aEZ6VjNScGNlMzVkL3ZFVFlWMUQzcDRMQXJMWFd6YmU4ejl5TEpNZjdvTHJk?=
 =?utf-8?B?YzNsYmNqM2dSbzZXVlhuZjFydWI2VSt3ajZmeGM0dUVtNnlRSnE4ZTZkb1dI?=
 =?utf-8?B?MmwvTWdQY3FKVTlMUjhGSUpnUU9FNU9XWTk5MFVvT21sT2tIZDRUSVg5dlhV?=
 =?utf-8?B?MW11ZmhCaVdjdW1kTDQzTkRxZEttRkkzMGR2b2JuSXpQaWRVelZnS0g1MmYz?=
 =?utf-8?B?MmVTT0tuSW5ZYy9CS0xZYWlzbmcxc1pDdUVpZHp0TThCajllNFpXbTZIQldS?=
 =?utf-8?B?dE41dXc3NDZMVUJ6blpVWUFpY2duelJMbDBuQnQ3VGJ5NXFUSEJmS1VMT3g1?=
 =?utf-8?B?MWJBRUdIWFMxQVZpcnZBYUovOEhvSXZKSE5vU1R5L1g2SWU2NXNYTXdoOXFR?=
 =?utf-8?B?MVcvYmx2d2hPcC9jblBieXdFYWxnZ01NY3ljcW85WFA4STdnZHgrZllQcTM4?=
 =?utf-8?B?dkt3T3NsNFpWbzUzUU5zaW9QTlhmZ3ViQ2VBL0ViVndTV05QQ3FvZmZUM1di?=
 =?utf-8?B?a09IVTJKTmllcWh2S2JNdzFMREJUMDZOTnZHYWNvbkdCTkVKdWx6QlV5Wktp?=
 =?utf-8?B?SmJPd0Zxeis0OUtyRVYyTEhYdzltZEVjUDVHYjgrRVI0Uzl5T1QwREZsSmtI?=
 =?utf-8?B?NXhmRDhxWkRhMUZuYVRXbUhka1FmQUZMeTVjcG1FWmp5cVdldkg0ZXlWcGlz?=
 =?utf-8?B?T2lucGZzVU9HLytUcGZkak9OV01jdFozbU5Bb2ExUURYSkRrWEoxNll0Ylgw?=
 =?utf-8?B?R21PTC90My9ZYXcvdFB1KzBFanQ2TjJTNWNFaHRVZVgvU2p0U29CRlBiMkVT?=
 =?utf-8?B?b29VVThRcmhmWDJmWjZMZGZqcG1waGQwNXlIc0N0UkdTUWhQY3JXMFo5Y1My?=
 =?utf-8?B?VnNpbUxSaVloTVZGd25vd1BsRkRkQnQzdllYNVB1YXpRYTF4MmlUWitvNTA4?=
 =?utf-8?B?VGFOU1padVFKK0RJMUJrQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0590a578-42b3-428b-c343-08d8d371ee95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 18:29:16.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjCLiail34RIO35pV3D+VwJprAcfyL+dEQYxrkmFXW/60kAs1zvffvyklzw5f+3X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4680
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=611
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102170134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/17/21 10:18 AM, Yonghong Song wrote:
> This patch set introduced bpf_for_each_map_elem() helper.
> The helper permits bpf program iterates through all elements
> for a particular map.
> 
> The work originally inspired by an internal discussion where
> firewall rules are kept in a map and bpf prog wants to
> check packet 5 tuples against all rules in the map.
> A bounded loop can be used but it has a few drawbacks.
> As the loop iteration goes up, verification time goes up too.
> For really large maps, verification may fail.
> A helper which abstracts out the loop itself will not have
> verification time issue.
> 
> A recent discussion in [1] involves to iterate all hash map
> elements in bpf program. Currently iterating all hashmap elements
> in bpf program is not easy if key space is really big.
> Having a helper to abstract out the loop itself is even more
> meaningful.
> 
> The proposed helper signature looks like:
>    long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
> where callback_fn is a static function and callback_ctx is
> a piece of data allocated on the caller stack which can be
> accessed by the callback_fn. The callback_fn signature might be
> different for different maps. For example, for hash/array maps,
> the signature is
>    long callback_fn(map, key, val, callback_ctx)
> 
> In the rest of series, Patches 1/2/3 did some refactoring. Patch 4
> implemented core kernel support for the helper. Patches 5 and 6
> added hashmap and arraymap support. Patches 7/8 added libbpf
> support. Patch 9 added bpftool support. Patches 10 and 11 added
> selftests for hashmap and arraymap.
> 
> [1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gmail.com/

I missed changelog from v1 to v2 and here it is.

Changelogs:
   v1 -> v2:
     - setup callee frame in check_helper_call() and then proceed to verify
       helper return value as normal (Alexei)
     - use meta data to keep track of map/func pointer to avoid hard coding
       the register number (Alexei)
     - verify callback_fn return value range [0, 1]. (Alexei)
     - add migrate_{disable, enable} to ensure percpu value is the one
       bpf program expects to see. (Alexei)
     - change bpf_for_each_map_elem() return value to the number of iterated
       elements. (Andrii)
     - Change libbpf pseudo_func relo name to RELO_SUBPROG_ADDR and use
       more rigid checking for the relocation. (Andrii)
     - Better format to print out subprog address with bpftool. (Andrii)
     - Use bpf_prog_test_run to trigger bpf run, instead of bpf_iter. 
(Andrii)
     - Other misc changes.

> 
> Yonghong Song (11):
>    bpf: factor out visit_func_call_insn() in check_cfg()
>    bpf: factor out verbose_invalid_scalar()
>    bpf: refactor check_func_call() to allow callback function
>    bpf: add bpf_for_each_map_elem() helper
>    bpf: add hashtab support for bpf_for_each_map_elem() helper
>    bpf: add arraymap support for bpf_for_each_map_elem() helper
>    libbpf: move function is_ldimm64() earlier in libbpf.c
>    libbpf: support local function pointer relocation
>    bpftool: print local function pointer properly
>    selftests/bpf: add hashmap test for bpf_for_each_map_elem() helper
>    selftests/bpf: add arraymap test for bpf_for_each_map_elem() helper
> 
>   include/linux/bpf.h                           |  17 +
>   include/linux/bpf_verifier.h                  |   3 +
>   include/uapi/linux/bpf.h                      |  29 +-
>   kernel/bpf/arraymap.c                         |  39 ++
>   kernel/bpf/bpf_iter.c                         |  16 +
>   kernel/bpf/hashtab.c                          |  63 ++++
>   kernel/bpf/helpers.c                          |   2 +
>   kernel/bpf/verifier.c                         | 346 +++++++++++++++---
>   kernel/trace/bpf_trace.c                      |   2 +
>   tools/bpf/bpftool/xlated_dumper.c             |   3 +
>   tools/include/uapi/linux/bpf.h                |  29 +-
>   tools/lib/bpf/libbpf.c                        |  52 ++-
>   .../selftests/bpf/prog_tests/for_each.c       | 132 +++++++
>   .../bpf/progs/for_each_array_map_elem.c       |  61 +++
>   .../bpf/progs/for_each_hash_map_elem.c        |  95 +++++
>   15 files changed, 829 insertions(+), 60 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
>   create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
>   create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
> 
