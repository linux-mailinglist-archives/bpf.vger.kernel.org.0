Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247CB357802
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 00:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhDGWyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 18:54:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16842 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhDGWyB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Apr 2021 18:54:01 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137MoF9I017486;
        Wed, 7 Apr 2021 15:53:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AfcXJ5fLyHXqnR3DPnCHQYEbXVfagMoAZxfN3Azf0Mo=;
 b=DIc0uNaVZXSyPb0BIv+/0iQxAd7e0KzzEVxjX6E9Pup4u7U7MGCRrLp1ZOu8VsMZxWUX
 amwtezxLM+WUD6BkCHKW4bU/Dkf4yXO9E92b1MlYKnvCu/3ZT66O41vhEPqNOu/wnHGd
 D7l3Eky33EMtG6mI1cu9FISfMzcOrRgibcs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37sh2nj1x6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Apr 2021 15:53:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 15:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY1EDeDR41FuOypON7iIC4VbtIHB1HhTlRMybftpKY+SNllN7Balef7663ImiW2vZXN1QYN1objqJiPAyFuxDl4vOV5j/d9iaRSfGTDzbdoYxzbXBZrqj+vVAvaKES3XJ/L/GNEgnD+58Dx+ti5zxcEVs0epvh8Hy3KTaPZb34doj/W8ONSXsNxfsLTgb1IzwuMuZt0Ht/4esUvXscnKqY54qLEO2NwqVpLLxAPhAQj9xEj0ExQmfm0YHQCBsu6HOj8SiaCHjYSBT1mQSBqLCzgFXrzp500xK13kCMXhNs4fAwaKzyJjTb0+BS4O7BkpP0pBMs37Aln680h/HEApcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfcXJ5fLyHXqnR3DPnCHQYEbXVfagMoAZxfN3Azf0Mo=;
 b=oEW11BkJhRg/eHpiPYz47LsAUhZhIjDS6i4ox4HlcNUnztLAPVkdxS3I4qk+Y8xXJC/ZH0BZON0s3q0ZtVOcv0hs7cPugwWClmh8qpEelSzClmPWbRxF4aEtk+6NKpONYybJIDaruqwkfQ9KjEpTpCa/LCPLfYBgp0ptXkTFU3Swff1NSUmwX7ezHDCl/Pec2zE2U/ja7IuTK5mceiYsgphmIzpYK4t0bkP0shXmfiroPXs8Xk6p3K3b01dCHHYto0g2tVVeozqWzXT5yw/yIGFp5gXKcYBnvUavH+QQ9XNfTAt8GmJvGZMqLnKva6tieuImufpnG0O+5b8T7qwOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2127.namprd15.prod.outlook.com (2603:10b6:805:2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 7 Apr
 2021 22:53:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 22:53:35 +0000
Subject: Re: [RFT] prepping up pahole 1.21, wanna test it? was Re: [PATCH
 dwarves] dwarf_loader: handle subprogram ret type with abstract_origin
 properly
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>, <dwarves@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org> <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
 <be7079b4-718c-e4a7-dff4-56543e5854a6@fb.com> <YG3RpVgLC9UEUrb8@kernel.org>
 <YG3SYoNWqb8DlP61@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7cdd9179-df5e-bdb5-ab36-983acddcbc1c@fb.com>
Date:   Wed, 7 Apr 2021 15:53:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <YG3SYoNWqb8DlP61@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:3758]
X-ClientProxiedBy: CO1PR15CA0092.namprd15.prod.outlook.com
 (2603:10b6:101:21::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::10dc] (2620:10d:c090:400::5:3758) by CO1PR15CA0092.namprd15.prod.outlook.com (2603:10b6:101:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 22:53:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60477f46-bd40-483c-7779-08d8fa17f9d0
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2127F54DD49E1ABCB0C25EC6D3759@SN6PR1501MB2127.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRG5dNfWjE6FEEAF/zTym2Ma2kQpiyRdc4NYeJaunCO+7I5qAgx4lqUNkmPQLYoOq1MZwl9k8qCjR1xFukdmKp34p1m1pTY3S+IXYXbqHNMHdF/pXg+gxO+fuWtSL2+kW6tTUCKsAOVZ2yMCcgKpCvq+Tmi/Phaj4esxLchzWgnWiGbCw+M0zYbwQVLfQjFA1JBIUpXyukJhxR5UCNI8siQly0m/X5OLdV1CKSzB6nRDzG81LNjHM1GIdmhT0pevFD2PgXlbjNppa5DY+QuWy50zacJtmLuxpvDaxOV+Y06J/GEeoP3HGKBTyEg4+EGcpTh7SnVFcMHvG6MRna62iHJQ4wLqq0KUQVXU1SzBbu+d1LIBnarkQDYivU4kClp8ScYERazNncEjOKYYzGWQENiCzhThAkBhg/Qem5AUmoMIgVcZpIAwtjuiRAd0EYyzemC23qaQ+dl2nLqpsr/MgplN1pkgZrjI4ggai4dgW2qax4y7yzZohl3N7MM/OqLikEzt3c6VEBGqMhc+zoObJSW/h0Y+M3dIwJJaCIhxdnXGhiYiNOcDK5RUNTMu3AGTR3KXvph8EQbtyOU4GmvvrZzBTf8WbvjadanE886ExPJkBaJXOdEy9Fn9E0puqxLDKlZDZMFyLw0wkAbHo1XVnZsG+iTbyqj3MQqRl37NxntZmOjRNV6NcmLMjEIEURogWwRQZOrs1ZrEvZ64dNpjxSCiBTRkQfkPPJGLUp13eLCy/R+h0zQPsdAb+72XaM+uB5aqeX1ZjRm5sx0KF54wVTtBShv0xX5vuocc4gB5Z08GvDtevhRQDTPTEEVxtFBU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(366004)(39860400002)(8936002)(5660300002)(66476007)(83380400001)(478600001)(2906002)(31686004)(66556008)(4326008)(8676002)(66946007)(36756003)(53546011)(16526019)(186003)(6486002)(52116002)(966005)(316002)(2616005)(31696002)(38100700001)(86362001)(6916009)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDgreGRHeWp4NE1HaCtRVW9YR0U5NElaOUNUcHRIWm1RRVFJSGd1VEp5UHZF?=
 =?utf-8?B?SEJJdURwOHBsM1JzdmlrY09CM015M2tYZWZFNnFwNlRwaFZwOGV4VkluMHhw?=
 =?utf-8?B?bjJKRUVpL3E2U2F4NDRkK2VJdFNVNTllK1pNY2FKM2pacmV6Tk1QQTJIaWJq?=
 =?utf-8?B?akF0NC8ybkhsSFIwOUNSUW41S3ZPTVAweElWdS9KRWlGa0EzZjlIbHBpNkNS?=
 =?utf-8?B?UFVpa1JmUm9IUENwY0FYSEhaSld4TEplYmtnYjhheUt5cE5POHJaOGpTS0lx?=
 =?utf-8?B?WXhRQkV5YU96ZHFaUTBmNnAycFJxWXBMTlFIY1VMQVNXdHdnVC9NdWJDdFJz?=
 =?utf-8?B?TSsyNENIT3JnaFdBUXpCQkZJSjRDTklWcC9FY3ZtQWlabnNRTDNkdnNHNXl2?=
 =?utf-8?B?cW0wRVNCdUdjYnN3eStLaGM2OTNpcnhXTVhoYmZOK3hHL3RZTitFZFlLcDhJ?=
 =?utf-8?B?RFhNU3BGS21rQW5NMzdKekIzZmhoU0Y1UlBveHdvWDhXWG5nclVPcEswVVho?=
 =?utf-8?B?MmpuSytOeDhmTDM3b0FCendFSGlKS2pKeHdScU91bEpjNExDWU02QnpGYVpU?=
 =?utf-8?B?ZFB5N1ZMNzltRFJQR010dFRBSzc5SzRZNFkyS3poaFpzOVpTQlEzWVkvUUZ1?=
 =?utf-8?B?Z3lidWx0NUhzb1BRbCtSOHdWT3M1TG1lV3hPZ1U1N2JFSG5JL2tzb3dQMFpm?=
 =?utf-8?B?emQxWEZrbGc2dFRpVXcrQkVGbUhKeC9ia0dVUmF5MThuMU5yemswSGcrT3p5?=
 =?utf-8?B?NE41a0o2aU0rd29JbUwzeWVhQk95S2NHM1RRL3FKaWR4dXNwam1GcnN0aGlL?=
 =?utf-8?B?NW9jRmFCcnd1d3piWkVJaWpiRGZGeTVmTFNrRjhEejFQbmlPdzZRejNlM09O?=
 =?utf-8?B?cE5GTU96VlByckF0QXlRSUNuSDkvZWdnL2tyWjZVdWYxVzcyTnUyR3A5OXZ0?=
 =?utf-8?B?Z0Q1V1o5L0RBRjJaN1FKL1M0Nm9OcTNmbXp6ZGcyZnRxb3FzVlkxbW1paWNQ?=
 =?utf-8?B?cjNXaTdOSnZBblBNRHVTazNTanZSQXFkbGJ0ZGR0Vm00VDhxK2FMWXQrRXRq?=
 =?utf-8?B?T3FKdFBvSWxiOEhuSEUrZUhScG1oK1lOMllFR2t6TDgxNlkzOE90KzNEdndK?=
 =?utf-8?B?VzZZd1NJbyt2YmlZNEo1c2Y0WTdRbHd3NWVvNWluQlhWby9zMEc1MEhuSEJh?=
 =?utf-8?B?R2lnZjZ2RWU0Wmk1SDVTdVRlYzJwMW9hWFBEeU9CcDA0cG1xZU1zR01qaE1n?=
 =?utf-8?B?ZGhFY3F2YmpUUkZNTUZ1c1l3bkt5ZmNCWTZUYlY2WHpBcXdRUnNOeE94ZVlG?=
 =?utf-8?B?K2hHcm5NMUFhaHlpdFhza1pSMktuYysvdHpBY0FYU1ZwZFV0WWdZYTVxbUhT?=
 =?utf-8?B?YmJXNTAwaDZEUlZVcWtJSjN6dVYvWm9BbmEwazQxU3duVUR3cTBzS2xtWTNM?=
 =?utf-8?B?bVZDRUQ3VWhRcjNLMWdoaXRuQWFLdzlOTXpWZlRpVDdVWit1dDUyWmV6SjJ5?=
 =?utf-8?B?bVplN2J2M1N0SUsyMUpBUXBucm1DN1dHWFRxSS9MamE4U21MZDR6aFhlWG5m?=
 =?utf-8?B?Y05wMVdRVlhwVFJDUUxiNUxnanhqb0pYTHJXY0xQdWNCRHpPRitJSW1JY3NV?=
 =?utf-8?B?Y3NQd1RLdmFnaStyMmVycGdSNDNtenk0RytaZE1VTnlKWU13REo5OU5XOHVU?=
 =?utf-8?B?bFl2eitYOVdEQjZxbTNlU0tGQWJldnNLd2tGWnMwOW9tNHlWdkdRVXhpZDVZ?=
 =?utf-8?B?YS9uenNPaGkwVzZ2ZVdVc3lSdGxmRnNZalJuMko5RGwrcXU5MDREOVFPUjJ1?=
 =?utf-8?Q?Aq7umLqSQt6LwtW2Nmiv7yYUVKfmG2P8vmj20=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60477f46-bd40-483c-7779-08d8fa17f9d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 22:53:35.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOMtqFt7VKm+SRTC/2SlELaF/lyhvaEasE2dgdspiezNJAV9dJetnb0lC5SgqxOd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2127
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: aL5SAGcLs9cLt7GQipxjw7cTAYknWVK-
X-Proofpoint-GUID: aL5SAGcLs9cLt7GQipxjw7cTAYknWVK-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_11:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/7/21 8:40 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 07, 2021 at 12:37:09PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Apr 07, 2021 at 07:54:26AM -0700, Yonghong Song escreveu:
>>> Arnaldo, just in case that you missed it, please remember
>>> to fold the above changes to the patch:
>>>     [PATCH dwarves] dwarf_loader: handle subprogram ret type with
>>> abstract_origin properly
>>> Thanks!
>>
>> Its there, I did it Sunday, IIRC:
>>
>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master&id=9adb014930f31c66608fa39a35ccea2daa5586ad
> 
> So I pushed it all to the master branch, hopefully some more people may
> feel encouraged to give it a try for the various things it fixes since
> 1.20:
> 
> [acme@quaco pahole]$ git log --oneline v1.20..
> ae0b7dde1fd50b12 (HEAD -> master, origin/tmp.master, origin/master, origin/HEAD, github/master, five/master, acme.korg/tmp.master, acme.korg/master) dwarf_loader: Handle DWARF5 DW_OP_addrx properly
> 9adb014930f31c66 dwarf_loader: Handle subprogram ret type with abstract_origin properly
> 5752d1951d081a80 dwarf_loader: Check .notes section for LTO build info
> 209e45424ff4a22d dwarf_loader: Check .debug_abbrev for cross-CU references
> 39227909db3cc2c2 dwarf_loader: Permit merging all DWARF CU's for clang LTO built binary
> 763475ca1101ccfe dwarf_loader: Factor out common code to initialize a cu
> d0d3fbd4744953e8 dwarf_loader: Permit a flexible HASHTAGS__BITS
> ffe0ef4d73906c18 btf: Add --btf_gen_all flag
> de708b33114d42c2 btf: Add support for the floating-point types
> 4b7f8c04d009942b fprintf: Honour conf_fprintf.hex when printing enumerations
> f2889ff163726336 Avoid warning when building with NDEBUG
> 8e1f8c904e303d5d btf_encoder: Match ftrace addresses within ELF functions
> 9fecc77ed82d429f dwarf_loader: Use a better hashing function, from libbpf
> 0125de3a4c055cdf btf_encoder: Funnel ELF error reporting through a macro
> 7d8e829f636f47ab btf_encoder: Sanitize non-regular int base type
> [acme@quaco pahole]$

I tested with llvm-project "main" branch and latest bpf-next.
clang non-lto, dwarf4/5: okay
clang thin-lto, dwarf4/5: okay
gcc (8.4.1, non-lto, default dwarf4): okay

So pahole looks good. Thanks!

> 
> - Arnaldo
> 
