Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD534F762
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 05:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhCaDUw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 23:20:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233648AbhCaDUa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 23:20:30 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12V3CdX4014478;
        Tue, 30 Mar 2021 20:20:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ayyBCJC0JNf0Hb8+2+Fqbqc3kWKVESrvsTGbGZd8PZc=;
 b=fvLiNA5yEUpquIIkh9GlP67hRfbLpqpyyLwMImOoNb2BoQCzlUzYmwr7u9M5zaBbLUii
 GDaDHgiB/NNx5lpNLT9azLjebOkgfeZUvxCgMbxyINHZyvIvDFSFwqNfmbHYGlQG/PR3
 yLWK6CaSeC99wzIuiRf4gwxzcmLOb5umtSw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37mabqht25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 20:20:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 20:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb8kMMFgBwOy6sOCQZ9OT0UDj7AU54Xvx5JYLh6DSNiIdoIchCESTg6UL1ae/p4nHL2H9tZYWsdx+HCKTEYdQl/WpgTTd9z5nXdWlpA7oleTRYAUIV4x8GNdOs8PpuaPHhpMeXDFMG6+Fbhw/Pw+beU18QrFkuRwmNQq2aUQh3aOKEyiawdYHcQ0FL/3QPodKnqC9/rmw1cv5/aI8JYUZUd0fi2CpNiKItVaskVRB0xzGfPDHh+Gha2Nbb2L0Sm9vpouudfVYXt01z5VfS1Dij752pj5ykJlHr3swSBmxO8AJkiCDVjwvKQhu+sN7yKt/CjbgrkikQ/BoT+dkL/L5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayyBCJC0JNf0Hb8+2+Fqbqc3kWKVESrvsTGbGZd8PZc=;
 b=mS9ihFXXdooD2rqMw465cvISxLRm4lUYAjFjjF8zQVN3aCD2k6ib3sDnjZKHH1+n2QyOzPke0wUpPWdVHduMRsb+BQ30fhrOjn6jXzeneBw1FmtdFZ8MGx//ZR0h/fJRtgjzyRbqadRDvAmayfJqcSHac5dtseMTdHgHZQrY+l/i24N5rLSbuRaH2uE6tiEyS51Hl7FBzTf/4dYy03hhjZL1S2yiYz01tyEuMYjhjAnTHHINExxcP6SOou+rvdKG9be5HXLlvhkOYx+8NMwLwPlQsnehLnZsEszK9MsVmIzQeo4pvv0qfNwzU3zKdxpG+0bfdiFWwA4GjxqSxImC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4451.namprd15.prod.outlook.com (2603:10b6:806:196::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 03:20:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 03:20:24 +0000
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20210328201400.1426437-1-yhs@fb.com>
 <YGIQ9c3Qk+DMa+C7@kernel.org> <YGM/Uh61RVExWnTU@kernel.org>
 <YGNpBlf7sLalcFWB@kernel.org> <YGNs4QxfGvQozqGS@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <503f852c-a7f4-efb2-5fd3-8431721dd67a@fb.com>
Date:   Tue, 30 Mar 2021 20:20:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YGNs4QxfGvQozqGS@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:d5a5]
X-ClientProxiedBy: CO2PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:104:1::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1120] (2620:10d:c090:400::5:d5a5) by CO2PR05CA0108.namprd05.prod.outlook.com (2603:10b6:104:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.18 via Frontend Transport; Wed, 31 Mar 2021 03:20:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d9ddc6a-a9de-4c52-dcbc-08d8f3f3ec40
X-MS-TrafficTypeDiagnostic: SA1PR15MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4451CE54FB82E87D7D488E1CD37C9@SA1PR15MB4451.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vYSmDF1RrtY78+15sXzNbbjHx8zBHmKZa6RwEPdZllxWmxjjz7vXy5YyFSH1BnX0HolYPBoDekuOJhr6kQeqPRB1dtX3pPjQDy1p7Id8WFl/o42y/V70PKcFQs/LtuUiAUsJswGNOzE83I/kdVKGD7BDiRCdCfnaQlvdZeNMUkgfl9EhE13eGutlUXQUUypN1dcTTmiL4wrjCwzz6VUQkpNM4JvVMhXUK7KU3HgE08Z4ZMUhLPruMu2ZIvklx9oprR9L0R7QJShUtTifbGdu/HDFhQB7je81qBXxREGOAvG03wSNkTT2m0JtQxpvuedU4NK0LxMYhaQlamP9dfIxGXOBc+1cfUCsIFoYbG5xd2KyxBLkV9hOnA0vUCSpQ1fRqtdNCnQf2ZSrp2VlBbx5M8sdHos0IYd1r09MBm7TlMr2v/Qi4cBHTBA1JxkJQE2BZD22VNbpispaXRdPcGEy4IU0jogN3tiIMhiRiI/ffUEGIMBkXlv1lGFC74iMppdeU69zpAyR63UwBedftgMq3HW8D4msguhbR1a5faZ9We7N+5Vp/n5BDj85JKFPAIKe64mFeonPmKbjKS+Ri1BcYo/64ISFfMz+ob48cqYEzI2lsXz80nbKS1cPVB2g7TkNZkTLfNMh7zUcKPizJjxW8oaO6KyUvynuhvcFDfvK5J8crZUTVR/M43Ot/x48SalY0moy0X22NSWU4mCrZfbSrow5ipA5Ys2B61KWbA18AicVcKzmXQZauatKLzzvWJ4w6GnhORjP6RSMxcNoX7a3xgWWlS5fFVN9PDYzq8Ws+E58UNSFJx3mHkK1rcSt91k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(6486002)(4326008)(2906002)(86362001)(316002)(4744005)(8936002)(110136005)(2616005)(36756003)(52116002)(5660300002)(16526019)(186003)(38100700001)(478600001)(31696002)(53546011)(66556008)(66476007)(66946007)(54906003)(966005)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YW9BTjlQZnN3VVJGRGlRTHJxSVEraU02NGsxUWNBK3RYdGJNZzkxN0tqQUxq?=
 =?utf-8?B?K2tLRFMzOVBjbTJlY1pWR1lYWGxKQ0dFSzRVWmFHV010RS9kYzZrWjZGeWUz?=
 =?utf-8?B?UC9URW9ZSXlVWHE4dTlrZnVHWnpzTGdRVXBEeTI1K3NCMHhIc1JYakJ6c09r?=
 =?utf-8?B?YUxGSTFIODZJeGZPTFlYSXN0RHgzcU15SkluVi9MODZBUW1wZDhUM1N5T1Zo?=
 =?utf-8?B?OFpadk5Pb2s5UGo1cGNtZEZINWJXdzZyMm92SWZhY3NvTnRmejdKcVlsSVU1?=
 =?utf-8?B?QXdjME9hRUVadnR1Y0pGZHd5SkY4RFY5Y0NBSHVMSWFqSzVKZ243RklrekhJ?=
 =?utf-8?B?OHhuRUdBYThBb0VRa3NoNXc2dFc4SlVrTjZkWWNBUXZRUldtRVdpVVU0NFN5?=
 =?utf-8?B?YVpzNHArSkpMOHNLUldpc0p2SWVibFIrZHE2anBYRDFkSnA1MlpDbTVmdnYy?=
 =?utf-8?B?ZEVFaytTanRDdnNrMkp6OXJwcUJpdzcrV2xXZHA4QlVGMmFhcjdxNHhlM2ND?=
 =?utf-8?B?WWdGbGF0OTdUZFM5emlGUmxVdVNqN0ZLOWtGcEwzSTlsS243VHdDTTA2RHNa?=
 =?utf-8?B?ZzZwN2NpWGdPSlBhMmlMZmNYK3d0NzYvZ3FXRGo5VmVvdjYvRElBVEE1N3d5?=
 =?utf-8?B?RWxIeWFiaUlkRFhZdEpZNGJNbWlTbFMxT0VMbkxVbm5XdzJQWTVCcXNKeHp6?=
 =?utf-8?B?Wm1RdXAzWUJLYXcxQ0s3K0pORlM4azVjNmlUT1JFcVV4OS83bFRRT0NjT01n?=
 =?utf-8?B?Z1owV2p3S1h2aEl5ek9FdWlUSE55WlBpeVMydno3K2pvWkVabmV4SjJ2UENP?=
 =?utf-8?B?VVJ3eVRKd1hpaE15WEJlT1plL3VGcmJsekhET3FVVHZCN0xPUlgvZ016K1J0?=
 =?utf-8?B?Ulcxa3lqR3U4bzRjU3BWdWY4N2FneG9VbnFod3VqMjBiSFc2YjVsZGMyWmVv?=
 =?utf-8?B?RlBiNFI2TGhrOXlwNnJmcXlmRDRuNDJSZXJjMlM3Z24xbmZDMll1anR3WDdx?=
 =?utf-8?B?MFgwNlNDSVVXeGVlVGhheHIzbkFTL09rNFJxUWJuaC80bWM3Y0hMS0p1NHNF?=
 =?utf-8?B?Sk8yajcyOEpEMU9iZis1Y2VCMUlKQllyYUhmTjJkZEo0d1ZRRzF6SnBFc3hT?=
 =?utf-8?B?VnVNQzMwOTZ0WXZSdjBUVGJGR2hYeElwdjZJbjVBTjdCNVNoVExTNjZqWDBW?=
 =?utf-8?B?d3JMNVRCUXcrZWFMRE9sbEFtazNocEMxSmFaZ2FjczNPMlJkdnhVbk0weE9D?=
 =?utf-8?B?eU9LbHJjQ1RhQWo2QVAvSmhDQWxyclAwdzF2WTREeFFBZHc1bmNobWpla0tm?=
 =?utf-8?B?UVBJbk5FZlZsRFEzbEc2S0ZaSWpmdWpBTC8vMFZUck4yT2UvcEZCM3BWUWxi?=
 =?utf-8?B?WEJsVHhHYU5OdEZ4Sk1WQzkzRjRsNEVDL2l2Z1I4dHZOMXA3MlhNVW1LZFRL?=
 =?utf-8?B?MUZVZVZQTDV0Z0kvWmh6TlN3akZ0NXRQQXQxN3Awa1FCdmhwMFhMSFlnUW56?=
 =?utf-8?B?amx0a3lPbVpGRmkxQUVjWDVHbGo2REhpU1pPMlZUUDBSSzYyazNTMmZFcFNB?=
 =?utf-8?B?WVRJVXJwSm4vT3VhSmNtY29WcGk1cmxXSU50M08yWDNyUnhmNnFSSURTamt1?=
 =?utf-8?B?ZVdKV3MxaTM4Qm9uaXJXUWhaYTR6YU5jVFJWUFQyZnVVTWZqTVgzc1RFNmJN?=
 =?utf-8?B?OGJJWS85YldLYVdpVG9PRmhiLzdNVFVDeVhpb1BoYkYyM1BJR1VGcGlHOTZ1?=
 =?utf-8?B?UWdWd1dpM2E3TG8zZTdwdjl4d2tXOWoyWW9Ra296LzAwUWZkaUlLRjNKWWJL?=
 =?utf-8?Q?5DsfwRHU147fxXMYkz44huTukZf4Rf6X/JbKw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9ddc6a-a9de-4c52-dcbc-08d8f3f3ec40
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 03:20:24.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ4gmP7IE/s4X6tC23Sh97c1dxRnYk6dlRbgQE9WGFIle4U3o1knjuNwwHma8BE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4451
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: -d96KSJPsdq2Trq1iu6ZT_xxjHkR_GmB
X-Proofpoint-ORIG-GUID: -d96KSJPsdq2Trq1iu6ZT_xxjHkR_GmB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_01:2021-03-30,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=803
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 30, 2021 at 03:08:06PM -0300, Arnaldo Carvalho de Melo escreveu:
>> [acme@five pahole]$
>> [acme@five pahole]$
>> [acme@five pahole]$ fullcircle tcp_bbr.o
>> [acme@five pahole]$
>>
>> This one is dealt with, doing some more tests and looking at that
>> array[] versus array[0].
> 
> I've pushed what I have to the main repos at kernel.org and github,
> please check, I'll continue from there.

Looks good. Thanks!

I will try to experiment with an alternative way ([1]) to check whether
cross-cu reference happens or not. But at least checking flags
approach can be adapted to gcc (if we want after comparing the 
alternative) since gcc always has flags in dwarf.

[1] 
https://lore.kernel.org/bpf/d34a3d62-bae8-3a30-26b6-4e5e8efcd0af@fb.com/T/#m1b0b1206091c19a90b15d054aa26239101289f84

> 
> - Arnaldo
> 
