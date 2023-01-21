Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215DA6763FE
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 06:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjAUFau (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Jan 2023 00:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAUFat (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Jan 2023 00:30:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4618A41;
        Fri, 20 Jan 2023 21:30:46 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30L5E3bU014987;
        Fri, 20 Jan 2023 21:30:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=zSnpic1dXoTp89ROpEtfNaEZ28gJze+duICXbT4WpfI=;
 b=We0vpZJyXOhoIL+UbNLykw38YJMkSp3Hj3nE3I4odr0vNY/kYM68nCDO+5q7htWKNzsv
 Z2jhqtAxK+masXx0hGXCOwpXK/vaU9IBLFpnruclCZwMizaStvCs1EmMh85y9AL+HoAl
 C49dccTC75afVCgc3hLyz1c6JANJVxJUkI9c7P9ZnA4bMbj0G1gMW/W5eMyZTR07VIz3
 KgaJncGr07mTRB0BdF0pBMFCCnxahJwRTFP8nVgAhsqqfnG315cOrGKBdasN5y4qEcPT
 1e2SDZ3diAB28N/PsUz4Db3dmOYgyCbimIYAis1R68ZrmmPj8gZUVmfPzFJVA3MySb2k Kw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by m0089730.ppops.net (PPS) with ESMTPS id 3n6vyjxkq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 21:30:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coGDLAWdo6T5XxXxINjprc3fydkGnhJRGYakjCZ3luNFSkk/N8te6DYeszok1M0RgGpzSY1jPYQhLpRWFoYAEVIOlIKDZa82Zx3UW7RLFOIS0gXDf1/14snD2Jtu77dFSTi3V2Rg90sb4bUNS+Ulp3tr4tttn4B4CB9KRuH09WmKEgbNZlWn+1JTF2/XN72Gn+IwTXtp7LwRUzYvk/TGN7ihxMemLl6opucUlW/0Pf1XEfehcGfdhGsIAW9ddn8+V3fblr75cE2sDAhZxhZ101e1HA7Sbo7AAtSa7ULWzw9POzMmr3hwsCs6o7FmXXoGfXvHohh0G3Vji6nbzYCArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSnpic1dXoTp89ROpEtfNaEZ28gJze+duICXbT4WpfI=;
 b=b1VR89LcTb7r5FJJxN/42CC3W6G2gSInFySCrG4HPz2PFbKlIRYotE0TItlHS7dtcrIdumHCXh5icUbtsHH8MSxIlqc3T7qomwKGVYOonnpgK3G5YV95K8snU3J8qRY/Rm3UCFIVlgbWZmjEi2mq42BnKa56YUDYEU/hoUEBL73Yq2i8N1rXqHbv6WrGYKjsO/IBiwcYtPX/wfe9C2eztRRgAIYKjOTpwIOttg5Sb+BsVhksRGFUr03QrU0tV8FajmxmROYF3GECdVLve+JQ0zPCtZ8uFy73awQ/JXceNEUyKjU99Y2PLotSvmFjKcomQ+CnOac3qlpQUoHuhEvCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN0PR15MB5323.namprd15.prod.outlook.com (2603:10b6:208:372::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 05:29:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Sat, 21 Jan 2023
 05:29:58 +0000
Message-ID: <ac273c04-3066-dd63-934c-f62650c41f8f@meta.com>
Date:   Fri, 20 Jan 2023 21:29:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BTF, pahole and static functions (was Re: [PATCH] libbpf: resolve
 kernel function name optimization for kprobe)
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
 <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
 <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
 <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
 <03e16727-7a0a-0e1e-e9b9-c947a64becb9@meta.com>
 <eaf64a4b-85ab-bb5a-5c33-d7cd80b034e7@meta.com>
 <7bfb49fb-99c1-163a-fb86-3e72369adbf6@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <7bfb49fb-99c1-163a-fb86-3e72369adbf6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN0PR15MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f0a121-ae73-49db-cec7-08dafb70893a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpkPw37lvWaHV0JAYJKi3UcQ7m6K3KBKwGHCfYuNK/GVtNW3vo2QzTx/rbcs+E8TiZaaVzb2VLWBUzidbePW28F66AU/bW/VA4kWAprrKtr/q4vPwDlqNeqJYftHswJZrBb4vcwCzyIczjVYatDF3uAxCdqSdgcxu2x/qb2+2SuL08x2zOVdSjuUQNxEOXQ+7aDt/XGUU9ciHNdYf8qrjrFWVN8nhg5uHP7a8T45TJug17s9JjVwGQK8pkmSutO9ClZ9hJKD/XbTHink/2aQkaPPTuz5WEdigJcyVZoV2D3KPXtqyFuUZU+hLgZwF2toYThqvKwLRpQM7R0/ZaEbCMUg17YiOB5HYZv/xNs7C9o9VEht3bEKFIS3G+6XCn5DEZTnNEtkpBKd7gBtq2nPKtOoxzY7o2mh3YbEXqtayMtGe8v3RwrGP7/fjbO33XI76b37PIf2MDeW3pAN2fFgmlcjymG2YTa6v+NCdVplDypQM/fh2lUdEbos1yzQYo5lPqHH/9QAXMuy4H7hZVmiSMDV74TILAiwsuGDd/FZCp7mANRZ3RBkrgPtIgj5mTf2idGJ/NB2axkUhrtD8x2vt5/MqIhy/loJt7TW2CqHXNy3NyD4AMIql2Qim4n4tFymzoF8s+05zi2tbxM2pE7TUynxtuqhGzQGA9xM5XsSTvCc3gYbF3JjPk6/s1sfmwkeckiaMUkgK5fh/eLTtNBOi89AqImhusFjpZBgKY/cgnx9IYSvrPSw3vsrZ2t2MjSBisF7m9p1NqMZGH4eWCGt9jJcXAbhdDqCk8SvS3hWcwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(2906002)(966005)(186003)(110136005)(6506007)(54906003)(6512007)(2616005)(316002)(36756003)(6486002)(38100700002)(6666004)(478600001)(53546011)(31696002)(83380400001)(86362001)(66899015)(41300700001)(4326008)(7416002)(30864003)(8936002)(31686004)(5660300002)(66476007)(66946007)(8676002)(66556008)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2cxYjZBRldnaW82aGRrTXRNKzEzaWQ4TGhxVDRJaFdPZTAweGVjdHd2SGNM?=
 =?utf-8?B?aThSYmdHNWNJcVR3SmJ6U3JMTHVaRGhrbjlmWG1PWmxsdVNGRk1wNGdTcGpx?=
 =?utf-8?B?dURreVdhSWxZOGtKNCt5c0pCRXpwRTZ4WVgwcURkVHc2emUyVUlSZDhrQVV0?=
 =?utf-8?B?WlNIai9tZEdJSXZuM1ZTL0tIdzk0Y1FjYlQ2M1oycUxBZ3I1d2ppTGdqem1S?=
 =?utf-8?B?VUZad2tyRjh5QzhLQUZTQ1hacDRjamhaTmZDQndkZmFwS01VT3d5Q1FiRnJ3?=
 =?utf-8?B?MnR6SWNtejVsYXVyNTdwaUZ1VEIrQnUyeUVSSmJNd1dCNFRUM2ZSaExnL0Fk?=
 =?utf-8?B?UHBRYWlrbmpRUytFcVN6K2Y1RWtGa2taTkl4STlCRzdIdmR5OWVFKzFpcTBX?=
 =?utf-8?B?cExNaGt4TTNBdzJFb0JEM2Y4a3BmUlRmQ3pQTmlwTCtkSXhkdEtVK3QwMWRV?=
 =?utf-8?B?dlNPa25FbG1rQUZyT3poeUkvUWd3OS82cHBYcUs2aFUvUmRrVDlHZ2ZXbUlI?=
 =?utf-8?B?YlNlc0ZRUG1hNzBJMWNXc3FUYVVsWEZLVWppeE5FbExlUXhMZy85cHJxOFMx?=
 =?utf-8?B?Y0JPMkR1KzEyK3kvT1hiMlNQdjNpSkl0NTgxZGNXbkl3RlhEc0R3WVhmOWxD?=
 =?utf-8?B?enJTMFNDaFlqbUl0VlJ4QXB6QXhIa1QrT0ZGRWpDSVYwaXgweXJ4cHlrNHpK?=
 =?utf-8?B?THJFTEphMjVXcVZXTnlLcUpic042OXZNVHZlbDlDT0d4TzZvVnBxckZnTUJG?=
 =?utf-8?B?YXdTMWFRVGEvdjRLQWNqNmVvYzVyOXlPNmJ6TVFETytvb0gvWW91a29VcU54?=
 =?utf-8?B?SlZZaVFncUNWSGh1OHpkdzVKNGRuV0ZZaHdZalJZeG9UQmVyNzFKZ3ppTUU2?=
 =?utf-8?B?V3Y5dEQycERCK2Qvam1Wbk1teGZwTDhORTAyTCtmZkNRcWhBYlU1MlpNNjJE?=
 =?utf-8?B?cGR6b3RyQjNvVktkUzlteC9jaHprdk9ObjNyM1VPQmU4V2lkK3VEeGNuaysz?=
 =?utf-8?B?YWErWFJiNkZpNFpKbUtaSFdOZ0RvdkRzN1JqU3h4K1lQdVRRbHY2dUlKQnFp?=
 =?utf-8?B?bCtGZ3lOUEYxL0gyYWNlaFRNNG43VmZpTTFMN3VEbDlzYkIya3haTVczdUoy?=
 =?utf-8?B?MFdSS3pyazJHZDRtaWNyM21La21UMkhiWlRNdXQ4eUR5L0J0bFFQdFVFWlVG?=
 =?utf-8?B?MVdQcmRxanNhWXpWSXo0dkxvQXFkVUI5ZWpVVHB1OG4vWnhZSFo4OXlBMVhE?=
 =?utf-8?B?cmZyRUF5Y09XbEZBbW4yZkFaOXFPK3lCcVZ2TnIzZGNCdVNEL0xQUEwrTkgy?=
 =?utf-8?B?cVZCTXBtR3RuakdiLzhZRXlTY3Y1akprRFJUTm5YMG92Rm9mS1dqR1dMdWQ0?=
 =?utf-8?B?a3JSMWVCYVpSb2Jsdnl6T3hxdXAzUzJ6VFNaYkhJalVUVHZhRDllN0h6TFpy?=
 =?utf-8?B?c2tGWUthNEFKUno0dWNzRFAxSmpCUy9WN1Q5RzJyNlNQT3FtQmpjN0J1bW5u?=
 =?utf-8?B?Sm9tQW0wYnRmczk1eCtmMGdOWWp3NU9WRWR5MnYyZ1cwc214QktFYUpSQjha?=
 =?utf-8?B?c2dWSEEvdmZpV0FYejQ4RDBtVzAzT1orTWI5cHc3QUMvV1RKT1F6OWlJWjVt?=
 =?utf-8?B?OWdqazNVbk4xUHJCaGhmUnAxVmlwNmN1RlF5MktxekFYODJjY1kzRmhrYTlm?=
 =?utf-8?B?ZUUzT1czUk5ubGFVelpjUURIWmJ1dGJaL25yNytPQm1CZHFENFNuYTlycHRs?=
 =?utf-8?B?MmdHWEJyZFdrSURYR1pGbGIyNm91cHBPMUZITVY0WUtNaVNvakJzbFIwRHlq?=
 =?utf-8?B?NVEvSWN2TmFvZnA3UGhmRHd6d2lmbnBzd3NlckVTT1NVVTlKd0tDVGZ0aHVt?=
 =?utf-8?B?TjFBcnkzZjdTRG9iVUN6ZzRJdDRQMTRZZFd0WTlHTUVKK295a3FqYno3M3Z5?=
 =?utf-8?B?b1lmK0Fzak5IRmltNDdlSEhMZFRtU2hUd0MyYUVKVnRHbDl4a2xqTEpXT1h6?=
 =?utf-8?B?TEtkcDkwU1U0ZHFUY0p1MmY1cnBTbDNEMjllV0V5ZmNXdlFmbXRzR0M4UzJk?=
 =?utf-8?B?TVpDd0VTcmVJQit6eUkveGpyeEtmc3R0dWdZN3FMTGpCVENndW8wcWVYek9k?=
 =?utf-8?B?WXR4bm9wRUU3aCtmWTRidW5oaGJVa3ptZEU5QUhDYTY1SUFmS1hXUHc3YXJr?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f0a121-ae73-49db-cec7-08dafb70893a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 05:29:58.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v7qImQdebItbXKi39Ug0ClMgxR5Ocqj1P1vUDpKcCHxvxwd3buA/O4lqcB5jFCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR15MB5323
X-Proofpoint-ORIG-GUID: 2EjwKiyR1Tmzb15pb9U41RQrs4s6O_hx
X-Proofpoint-GUID: 2EjwKiyR1Tmzb15pb9U41RQrs4s6O_hx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_01,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/20/23 5:20 AM, Alan Maguire wrote:
> On 18/01/2023 18:15, Yonghong Song wrote:
>>
>>
>> On 1/13/23 12:00 AM, Yonghong Song wrote:
>>>
>>>
>>> On 1/12/23 1:07 PM, Alexei Starovoitov wrote:
>>>> On Thu, Jan 12, 2023 at 2:20 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> On 12/01/2023 07:23, Yonghong Song wrote:
>>>>>>
>>>>>>
>>>>>> On 1/9/23 7:11 PM, Menglong Dong wrote:
>>>>>>> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
>>>>>>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>>>>>>
>>>>>>>>> The function name in kernel may be changed by the compiler. For example,
>>>>>>>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
>>>>>>>>>
>>>>>>>>> This kind optimization can happen in any kernel function. Therefor, we
>>>>>>>>> should conside this case.
>>>>>>>>>
>>>>>>>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
>>>>>>>>> kallsyms and check if there is a similar function end with '.xxx', and
>>>>>>>>> retry.
>>>>>>>>
>>>>>>>> This might produce incorrect result, so this approach won't work
>>>>>>>> for all .isra.0 cases. When a function name is changed from
>>>>>>>> <func> to <func>.isra.<num>, it is possible that compiler may have
>>>>>>>> make some changes to the arguments, e.g., removing one argument,
>>>>>>>> chaning a semantics of argument, etc. if bpf program still
>>>>>>>> uses the original function signature, the bpf program may
>>>>>>>> produce unexpected result.
>>>>>>>
>>>>>>> Oops, I wasn't aware of this part. Can we make this function disabled
>>>>>>> by default and offer an option to users to enable it? Such as:
>>>>>>>
>>>>>>>        bpf_object_adapt_sym(struct bpf_object *obj)
>>>>>>>
>>>>>>> In my case, kernel function rename is common, and I have to
>>>>>>> check all functions and do such adaptation before attaching
>>>>>>> my kprobe programs, which makes me can't use auto-attach.
>>>>>>>
>>>>>>> What's more, I haven't seen the arguments change so far, and
>>>>>>> maybe it's not a common case?
>>>>>>
>>>>>> I don't have statistics, but it happens. In general, if you
>>>>>> want to attach to a function like <foo>, but it has a variant
>>>>>> <foo>.isra.<num>, you probably should check assembly code
>>>>>> to ensure the parameter semantics not changed, and then
>>>>>> you can attach to kprobe function <foo>.isra.<num>, which
>>>>>> I assume current libbpf infrastructure should support it.
>>>>>> After you investigate all these <foo>.isra.<num> functions
>>>>>> and confirm their argument semantics won't change, you
>>>>>> could use kprobe multi to do attachment.
>>>>>>
>>>>>
>>>>> I crunched some numbers on this, and discovered out of ~1600
>>>>> .isra/.constprop functions, 76 had a missing argument. The patch series
>>>>> at [1] is a rough attempt to get pahole to spot these, and add
>>>>> BTF entries for each, where the BTF representation reflects
>>>>> reality by skipping optimized-out arguments. So for a function
>>>>> like
>>>>>
>>>>> static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
>>>>>                                  const struct in6_addr *gw_addr, u32 tbid,
>>>>>                                  int flags, struct fib6_result *res);
>>>>>
>>>>> Examining the BTF representation using pahole from [1], we see
>>>>>
>>>>> int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);
>>>>>
>>>>> Comparing to the definition, we see the last parameter is missing,
>>>>> i.e. the "struct fib6_result *" argument is missing. The calling pattern -
>>>>> where the callers have a struct fib6_result on the stack and pass a pointer -
>>>>> is reflected in late DWARF info which shows the argument is not actually
>>>>> passed as a register, but can be expressed as an offset relative to the current
>>>>> function stack (DW_OP_fbreg).
>>>>>
>>>>> This approach howvever introduces the problem that currently the kernel
>>>>> doesn't  allow a "." in a function name. We can fix that, but any BTF encoding
>>>>> that introduced optimized functions containing a  "." would have to be opt-in
>>>>> via a pahole option, so we do not generate invalid vmlinux BTF for kernels
>>>>> without that change.
>>>>>
>>>>> An alternative approach would be to simply encode .isra functions
>>>>> in BTF without the .isra suffix (i.e. using "function_name" not
>>>>> "function_name.isra"), only doing the BTF encoding if no arguments were
>>>>> optimized out - i.e. if the function signature matches expectations.
>>>>> The 76 functions with optimized-out parameters could simply be skipped.
>>>>> To me that feels like the simpler approach - it avoids issues
>>>>> with function name BTF encoding, and with that sort of model a
>>>>> loose-matching kallsyms approach - like that described here - could be used
>>>>> for kprobes and fentry/fexit. It also fits with the DWARF representation -
>>>>> the .isra suffixes are not present in DWARF representations of the function,
>>>>> only in the symbol table and kallsyms, so perhaps BTF should follow suit
>>>>> and not add the suffixes. What do you think?
>>>>
>>>> Sounds like a great idea to me.
>>>> Addresses this issue in a clean way.
>>>
>>> Yes, the second approach seems a reasonable approach. If the number
>>> of parameters for the *actual* functions equals to the number
>>> of parameters for the defined function (abstract_origin),
>>> we can roughly assume the actual function signature matches
>>> the prototype. Although it is theoretically possible that
>>> compiler might change parameter types, e.g., from a
>>> struct pointer (struct foo *p) to a int value (p->field1).
>>> But this should be extremely rare and we need compiler emitting
>>> additional dwarf data (might through btf_decl_tag) to discover
>>> such cases.
>>
> 
> Thanks! I've prototyped a solution at [1].
> 
> The key problem is pahole processing compilation units separately;
> the issue is that for some functions, they have optimized out
> parameters in some compilation units but not others (NF_HOOK()
> does this for example).  It's a pain, especially as we want to
> preserve parallel BTF encoding as much as possible, so the
> best solution I could come up with was to save information on
> functions that had a suffix match in a global encoder binary
> tree.  Then, when we are collecting threads, they can be safely
> added prior to BTF merging, since at that point we have
> recorded if they have optimized-out parameters in any compilation
> unit.  There may be a better way to handle this, but I think
> we are stuck with comparing binary-wide to see if the
> parameters are consistent.  The code is (I think) careful
> to limit this to cases where "."-suffixed functions are found.

I agree that for this .isra.<num> issue and later static functions
with different signature issue, global view is needed to make
proper decision.

> 
> In testing this however, I think there is a wider issue with
> BTF encoding of static functions which may require a similar global
> comparison mechanism.  More below...
>   
>> I checked with some compiler guys at Meta. They confirmed that clang
>> might have the same optimization (eliminating some function parameters
>> for static functions), but clang won't change function linkage name.
>> So that means, clang won't do static function cloning and it will
>> only remove function parameters if this can be applied to all call sites.
>>
> 
> Great, that simplifies things a lot.
> 
>> I checked the clang (clang16) build kernel with latest bpf-next
>> and didn't find a single instance that a static function's parameter
>> is removed.
>>
> 
> Excellent!
> 
>> Also, current libbpf kprobe API supports to pass a function address
>> to kernel. So user space can always do their own /proc/kallsyms search
>> and find func address for either regular function or function
>> with .isa.<num>/.constprop.<num> suffixes.
> 
> Right; one way I've done this is to have a special "okprobe" section
> name where we support matching with a "." suffix as well as with
> the exact name. Might be worth adding that support to libbpf itself
> if the above approach lands.

I am not sure about this. We should keep a good default to handle
.isra functions as we discussed earlier. If user still wants
to kprobe a .isra function which is filtered out by our default
handling, user can use addr instead, in which case, user needs
to check dwarf output and/or assembly to make sure they understand
how many arguments are actually used and how they are used.

> 
> The bigger concern I have is in testing this I hit a problem which
> at first looked like a parallel BTF encoding problem, but on
> deeper analysis looks like a conceptual issue in how we handle
> static functions.
> 
> To demonstrate, generate vmlinux BTF twice, once with a single thread
> and once with 2 threads.  We observe a different number of functions
> that end up in BTF for the exact same object:
> 
> $ LLVM_OBJCOPY=objcopy pahole -J -j1 --btf_gen_floats --lang_exclude=rust .tmp_vmlinux.btf
> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|wc -l
> 57596
> 
> $ LLVM_OBJCOPY=objcopy pahole -J -j2 --btf_gen_floats --lang_exclude=rust .tmp_vmlinux.btf
> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|wc -l
> 57714
> 
> So we see 118 more functions in the latter case. Why would this differ? If we sort
> and strip out duplicates, we see that the cause is multiple copies of functions:
> 
> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|awk '{print $3}'|sort|uniq|wc -l
> 57596
> 
> Once clue is that each encoder maintains a function table of ELF symbols, and
> marks a symbol as generated if it has been added to BTF.  As the encoder
> traverses CUs, it adds to the encoder symbol table.  In a single-threaded encoding,
> we will see only one instance of a function in the final BTF because the first
> match of the binary seach of the function list will be returned.  With multiple
> BTF encoders however - each with its own internal representation of the symbol
> table - there will be multiple instances of functions added to each individual
> encoder's BTF fragment.  This is supposed to be okay because BTF deduplication
> will handle merging these.
> 
> However, this does not take into account the fact that the same function name
> may live in different CUs as a static function with a different function signature.
> Could this explain the extra functions?

Could be as you explained below. Also, the original behavior for static 
function with one thread seems wrong. User only find one static function
definition in BTF and may assume it is the one user expected. But this 
may not be the case since other same-name static functions may be
simply ignored.

> 
> It seems to account for many of them. To take an example tcp_in_window()
> has two representations:
> 
> 122435] FUNC_PROTO '(anon)' ret_type_id=122409 vlen=7
>          'ct' type_id=65074
>          'dir' type_id=2170
>          'index' type_id=6
>          'skb' type_id=2012
>          'dataoff' type_id=6
>          'tcph' type_id=61910
>          'hook_state' type_id=29004
> [122436] FUNC 'tcp_in_window' type_id=122435 linkage=static
> 
> [66683] FUNC_PROTO '(anon)' ret_type_id=372 vlen=4
>          'seq' type_id=23
>          'end_seq' type_id=23
>          's_win' type_id=23
>          'e_win' type_id=23
> [66684] FUNC 'tcp_in_window' type_id=66683 linkage=static
> 
> ...one from nf_conntrack_proto_tcp.c, the other from tcp_minisocks.c.
> 
> This raises the conceptual problem - what do we do with such cases?
>  From a code perspective, it's totally fine to have conflicting static
> functions in different CUs, and one approach would be to retain multiple
> conflicting function signatures; however this is not really useful as
> there is no mapping from BTF function signature to site.  As a result
> we have no way of knowing which signature applies to which function site.
> So perhaps the best approach is to eliminate such inconsistent static
> function descriptions? The actual amount is small, ~100 functions.

Removing these inconsistent static functions could be a simpler
approach. To really resolve this issue, BTF needs to encode more
information, e.g., DW_AT_low_pc, so this function can be related to a 
particular ksym. We could extend BTF somehow to encode this information.
One possible is to utilize the btf_decl_tag. For same-name static
functions, we could have
     btf_decl_tag("static_func:name:<low_pc_1>") -> foo (first static 
func in btf)
     btf_decl_tag("static_func:name:<low_pc_2>") -> foo (second static 
func in btf)
We only need to do this for static functions which have same names.

In verifier, we could build the above relationship and establish
    btf_id for first foo -> low_pc_1
    btf_id for second foo -> low_pc_2
so verifier can then find the correct ksym addr for a particular
btf_id for 'foo'.

> 
> Assuming that makes sense, the next question is how.  One approach
> would be at BTF deduplication time, but we have seen cases in the
> past where BTF did not fully deduplicate identical structures, and
> in such cases, multiple copies of a function are present which
> have multiple (but identical) parameter type descriptions. If this
> happens, the danger in eliminating both is we might eliminate
> critical kernel functions due to a type deduplication issue. One
> way to avoid this would be a comparison of number of parameters
> and (failing that) parameter names; such a comparison would not
> be subject to issues with identical types leading to identical
> function definitions. Not 100% foolproof, but would work in
> nearly all cases I suspect.
> 
> Another approach would be to re-use the mechanics introduced to
> compare static functions to see if they have optimized-out
> parameters to compare function signatures.  So static functions
> paradoxically have to be stored in a global tree and compared
> to weed out inconsistent duplicates.  Luckily, these comparisons
> can be quite superficial; for the most part number of arguments
> suffices.

If I understand correctly, for same-name static functions,
we would like compare # of parameters
first. If they are the same, we then compare parameter names.
<name>.isra.<num> functions will compare against <name> func
to ensure the number of parameters the same. I am not 100%
sure what is the difference between the above two approaches.
Only implementation difference, right?

> 
> What do you think is the best way forward to solve this problem?
> The optimization-handling code gives us a way to deal with this
> by postponing addition of such functions until we can guarantee
> consistency, and I've roughly prototyped a patch on top of [1]
> that works, but I think first we need to figure out what to do
> with such inconsistent static functions before determining how we
> do it.  What do folks think?
> 
> Alan
> 
> [1] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:btf-optimized
