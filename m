Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4299834B30F
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCZX0c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:26:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231189AbhCZX02 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 19:26:28 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12QNPTRt002515;
        Fri, 26 Mar 2021 16:26:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1gexgQLjcG1c0CftFiBSi9/HhMwcjcQwgjE3i1C11Z0=;
 b=PVvZmQw+dGdvW5rEFETdMAOlwi8b6zMsnLm2uiYIDSbzQK0RfcM5pYAl2PpDrqfqx8xF
 6ydFWJN9yFD5NzZsNwXsfExgbUi6aimFNW8eXCY0q9WEoTggK3CzcUDofVs/jlcCEFdF
 fdYawjp46KuTZt/8S9dW1CpC7JaF3kG49Xc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37hqk2rh98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 16:26:25 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 26 Mar 2021 16:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFWUdOalKJBDORw7P7Mj8agYklzgh+3i4wL73V3ahKhfqZbdCl0hEdVtP7tm3IGgSaupMtz9YV9AamPLD5fVc4YW6BjlMrGMMuoy1sIXVy9YAiisTsvdGjy3nxHBaNCnBPZjI7qxkRoKiCemOBFdDWuLwvvzYQ20Pp+tm0o8VaHn7WLW5GSGHEV3iDNR8etIhp2cJh/b4EneSFv3EhHS0hzleRUT/R7fnprKcHAFZte8ohNlNjb3Af8zRgdZMgBap62+0s7s7F2Espoyq6X1BJ3VIaikvdFhY5LU2H0krhlF7NCjxOawugQ/OY4JHru5KymkedZ44+afmHEcc66fYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gexgQLjcG1c0CftFiBSi9/HhMwcjcQwgjE3i1C11Z0=;
 b=NQitlnbkyCr5ylOifZVh6FD3+I6/13c8XpzwuUqzD8YOqG4ezG9p6o4kgVCtQaoy6Zl4e42oeoFSdIF9q+hoEEHOEcd0c+RqGU1WgV+0xPE1hbQ//JdatuZ4JM49sBUCxrbqU4Y8qW4iAha1RHZ7F6WJPfehRZPZQwxPgr47QWsOmZd1klLylP0s+g6WaZPt2xV4gPGRfDl+5odT86VrnK2z80bf2t01OOLIw/uadvPVvISoTTZ9MMi+DVgEZYXdLBwPfuIGG5PWdflZtbWXUrjMzIRd1Yg2zN1T12DidCvxhuZdNxm9+EZvy775oJDkXGPeRyk4JaPJCOyaJM4wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3789.namprd15.prod.outlook.com (2603:10b6:806:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 26 Mar
 2021 23:26:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 23:26:22 +0000
Subject: Re: [PATCH dwarves 1/3] dwarf_loader: permits flexible HASHTAGS__BITS
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065322.3121605-1-yhs@fb.com>
 <CAEf4BzYcfEjeRHD_aVPvJNXqtqR2Uso4Rt+Q4SmCk5+GUoAzEg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <55c83f03-1b86-ad79-2bfa-69c8c26fa7d2@fb.com>
Date:   Fri, 26 Mar 2021 16:26:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAEf4BzYcfEjeRHD_aVPvJNXqtqR2Uso4Rt+Q4SmCk5+GUoAzEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:2920]
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1777] (2620:10d:c090:400::5:2920) by MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Fri, 26 Mar 2021 23:26:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209c4eff-7dd0-4ad2-729c-08d8f0ae9157
X-MS-TrafficTypeDiagnostic: SA0PR15MB3789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB37892D2903AB9226DB53BF0CD3619@SA0PR15MB3789.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZfwXY6/pVzRXW73IYiKltJxIT3bS4XH4RFYnd4LP4U6UM7hOAAKxqDWVDGhBMeOWs5vbbYpCSXyHE4SNwMXRV8iF0ZzPxNQ3m5N10nmD9j/Q21FyHVNp5aaxzE67ZszSoKa/zrc3/LbZyji3IK92LgrKHOWhaPALQucIDPxtQdccdLxlNgWT/WSs2DmsNEDbXFYyeVHgDw6Arm/CO3MwM1zSPF62LM+4kRxjJxvqUxELw/xkP2+kjehVX7f8HwZ1B9PH6gUmz86b/5QLkiNFl1kg3D+AerQBMxlZZfhHB1kUy7DbxU/fmM5Xl7vV2QZN1F07P6wPoQydRiwDylmfluJxhxgOPceJQxFOX0uEVbjcbMGKAuodbdhtl/GGS70k2vGYz+ilua8gymfCJODuhfhIe+IatDK36BlWCoNju+QqS8Ychz80tzXtALIqzYsuKvm4Z+lHzEWnTlc62nGoJMkZXG7tvhI6gqrU2m/c+eyoEPbWPlwzEN6hhC2CEOwyCYY/dq4vk0yPbPZ0Ml19kK8ki+CjcT6yct3lUIezsrvHa2v9bRHXOJxhvNYPMraRMrya4phYOEgaAUmM1jGeSOrSAl6zfRl50fEevRSI5wcisFAz5q4ZJAljiijdkZ39LMc5S41ZQkYWgHJQ9M4/Hx8/ISCkV0RH8EqKTjXJJb7zAmhtBN594BJ3nVeqJ/dk1+RFMur1HUZVutER/cJ+Jg7wKpi8meJ73tvsg7hxsFNH1jglDTtCTPXhV5D6e6U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(136003)(376002)(38100700001)(83380400001)(186003)(2906002)(36756003)(86362001)(31686004)(54906003)(478600001)(16526019)(4326008)(316002)(8676002)(2616005)(5660300002)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(53546011)(31696002)(8936002)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rjk2M0xZTXZ0V1BodURJcGFtbDJwSGRCTVd1WSt3VlpYakk0OVcveDVReExQ?=
 =?utf-8?B?TDl3eFZGY1krY251bnE2bzFtMXVuMldnZjFTMnVTTU1renVJcmlsR2txb1N2?=
 =?utf-8?B?SDh2anFVWmJ4Y3ArQkU2QjZqU3lMN2pFV2dydHB4em8vVExrbEJJYkZ5N21p?=
 =?utf-8?B?eTR2cmlIU0Mzd09PTjBTdkRxMWFnL2VpTkErWDVBYU81OTFmb1Q0d2Rjejcz?=
 =?utf-8?B?a2VZUlBkSjhpNHk4Q3pQMGw3R1JvQURCbTIzYXVHWVpuQUJ5YXoyYzZnSFM0?=
 =?utf-8?B?UUp1OEQ0RU9RbHkxQkY0K2dTREhlUmVRN0d2Wjl1VjZEMEFEc0tpa1gwYm5a?=
 =?utf-8?B?ckdzWkZ0QjlNTmpjWnc4U3FqdXlRWUFJeW5zVE8xUTNOaVlzbGdzZjdReDht?=
 =?utf-8?B?VkcxYVNXaGpXTU1pNTMwMzN6VjdyNm9uM0VSN3pCVzhqdGVUT2VTeEI3aGFN?=
 =?utf-8?B?QnRrVGtzdi9hZjhQK1R0WGl1aUpSbVdqVGVvckZOMFhLblEvRGlBcE5NRVVt?=
 =?utf-8?B?OURyVE5MZmtaQ3A5aDdMYkRBQWRKT3BkODh2blJsQkV6bGxIelp0Rk5NVXNF?=
 =?utf-8?B?M1dCcUJXR2c1bTdqN1NaeVJ4SzQxTDVYV0pMcXVrMnpaK2YvN0lrelBxeVY0?=
 =?utf-8?B?dXZMK29FVExDbTloeXRjWWxKeFhvRTFjMXJRUW5qV0tLeFpYNmFUYTJRTDI2?=
 =?utf-8?B?eHR6elBTdkFpR0dzb2VUdGZMV3pSUjdaTnFVTXgyNHFtYUQrcmpOQk5EeFFw?=
 =?utf-8?B?aXRpbldBUmgySjhxSWtFQXFiTW93eFpUNnhmSkVIMGVSeUlhak5HU3ptbUF4?=
 =?utf-8?B?c2hnWkQwSExsWE1lNHdMWE5RMmxjMGxWUzFTRTgwa3prTUhCN2IrWkNQdU5m?=
 =?utf-8?B?ZDRrQ01OcVRaNzJtTUgxR3hDalJUNFhWQmJqZ2VOa3M1c0Y0TTBLb1RPUkVu?=
 =?utf-8?B?dnRDMm5KdzlKclN5M3QyU1FnZ3Y5Tm5HVWVkK2M5OStVL000dmg4ZCtsTGRP?=
 =?utf-8?B?VytCcVNFaEFGYUIwNEZpQlFDbG9RZWU2T2J5MUxnK2x4ZmVpNmpYUnhLYTdF?=
 =?utf-8?B?NkIxdEZDN1d4bEFFSjJFVlBKTmFmbjFZdlBGanJaTDIrMCtTdkxURVhXckt3?=
 =?utf-8?B?dG1VV3YyanBiY2d5TzVwYnFBYUx4TzRSVXFCWXhWUFNFaFozNkJMVWFHQytv?=
 =?utf-8?B?SU9RZzRhQ09JOHkyMWhPeEJXYWNrU1Znd0w2Q2EvQ2NndUl2RlZ4MlNJQ1NV?=
 =?utf-8?B?TFRFMjdMYStIWVYzTTdjL2FXWGNTZkhHQ1g4M2NOVi92RnNRUkJILy8rTDk0?=
 =?utf-8?B?aS9KK0JheWZENzc2bWlJUlVLTHRsUUtXL2dZc2xqMzlTbzlWcm5YUWJHcU9C?=
 =?utf-8?B?Z2dqNkkrSWdwSWkzODRsbGZvZ3BCbmhVa3FqalNScThyblY3UXQyR2FMQjZ5?=
 =?utf-8?B?UGpXOVk1SVZzVU96ZmR0YThIK0lqOHp0SHEwdkVvWGJVZm1TSjY0c3NQQkt6?=
 =?utf-8?B?TnlOcldIb1EyZWJNWnlURGVITHhRWnpneWVoR2ZSaUZZTlhiZks1cnZaeUw4?=
 =?utf-8?B?bUM0cERSSGEvTVJvdk02L2N0eE5pR2pWd1Uvb2FJNWpBQTZqM0tDM0ZCcG85?=
 =?utf-8?B?SDdXRmViUFJDak00RDVRSFhRbTlza2lUMGcyYUg1TndiYjhJL3BPVFBvaEw5?=
 =?utf-8?B?cnJpMDNDQU9CYmxVWDQrR1pGcVFaTWg1Vk11OG00ZWVxbmt3ck5KK0g0dU9Y?=
 =?utf-8?B?WTVuaEl6VlBhTURPb2RMWWgzMklGL2twYm5ST0FObVpKREp5OGN4dXJhMUFv?=
 =?utf-8?Q?RDRjbhQA+b8ORyZQeuRowjcFeJ7nDK7b/Svys=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 209c4eff-7dd0-4ad2-729c-08d8f0ae9157
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 23:26:22.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv8Iwd4m38F1nnqvI10xrZlGxtDxrUEVYWxDXs4OthkIIHZXvJrBuL11csBUJOiz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3789
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 4rMCDJldG8nP1inWYTuFv76nkvLTO1yO
X-Proofpoint-GUID: 4rMCDJldG8nP1inWYTuFv76nkvLTO1yO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_16:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103260175
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/26/21 4:13 PM, Andrii Nakryiko wrote:
> On Wed, Mar 24, 2021 at 11:53 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, types/tags hash table has fixed HASHTAGS__BITS = 15.
>> That means the number of buckets will be 1UL << 15 = 32768.
>> In my experiments, a thin-LTO built vmlinux has roughly 9M entries
>> in types table and 5.2M entries in tags table. So the number
>> of buckets is too less for an efficient lookup. This patch
>> refactored the code to allow the number of buckets to be changed.
>>
>> In addition, currently hashtags__fn(key) return value is
>> assigned to uint16_t. Change to uint32_t as in a later patch
>> the number of hashtag bits can be increased to be more than 16.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   dwarf_loader.c | 48 +++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 37 insertions(+), 11 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index c106919..a02ef23 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -50,7 +50,12 @@ struct strings *strings;
>>   #define DW_FORM_implicit_const 0x21
>>   #endif
>>
>> -#define hashtags__fn(key) hash_64(key, HASHTAGS__BITS)
>> +static uint32_t hashtags__bits = 15;
>> +
>> +uint32_t hashtags__fn(Dwarf_Off key)
>> +{
>> +       return hash_64(key, hashtags__bits);
> 
> I vaguely remember pahole patch that updated hash function to use the
> same one as libbpf's hashmap is using. Arnaldo, wasn't that patch
> accepted?
> 
> But more to the point, I think hashtags__fn() should probably preserve
> all 64 bits of the hash?

I don't know the context. If the purpose is to avoid future changes
in case that the hashtags__bits > 32 happens, yes, the change may
make sense.

> 
>> +}
>>
>>   bool no_bitfield_type_recode = true;
>>
>> @@ -102,9 +107,6 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
>>          *(dwarf_off_ref *)(dtag + 1) = spec;
>>   }
>>
>> -#define HASHTAGS__BITS 15
>> -#define HASHTAGS__SIZE (1UL << HASHTAGS__BITS)
>> -
>>   #define obstack_chunk_alloc malloc
>>   #define obstack_chunk_free free
>>
>> @@ -118,22 +120,41 @@ static void *obstack_zalloc(struct obstack *obstack, size_t size)
>>   }
>>
>>   struct dwarf_cu {
>> -       struct hlist_head hash_tags[HASHTAGS__SIZE];
>> -       struct hlist_head hash_types[HASHTAGS__SIZE];
>> +       struct hlist_head *hash_tags;
>> +       struct hlist_head *hash_types;
>>          struct obstack obstack;
>>          struct cu *cu;
>>          struct dwarf_cu *type_unit;
>>   };
>>
>> -static void dwarf_cu__init(struct dwarf_cu *dcu)
>> +static int dwarf_cu__init(struct dwarf_cu *dcu)
>>   {
>> +       uint64_t hashtags_size = 1UL << hashtags__bits;
> 
> I wish pahole could just use libbpf's dynamically resized hashmap,
> instead of hard-coding maximum size like this :(
> 
> Arnaldo, libbpf is not going to expose its hashmap as public API, but
> if you'd like to use it, feel free to just copy/paste the code. It
> hasn't change for a while and is unlikely to change (unless some day
> we decide to make more efficient open-addressing implementation).
> 
>> +       dcu->hash_tags = malloc(sizeof(struct hlist_head) * hashtags_size);
>> +       if (!dcu->hash_tags)
>> +               return -ENOMEM;
>> +
>> +       dcu->hash_types = malloc(sizeof(struct hlist_head) * hashtags_size);
>> +       if (!dcu->hash_types) {
>> +               free(dcu->hash_tags);
>> +               return -ENOMEM;
>> +       }
>> +
> 
> [...]
> 
