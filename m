Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31465325B8D
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 03:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBZCRT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 21:17:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41076 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229460AbhBZCRN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 21:17:13 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q2B49p014747;
        Thu, 25 Feb 2021 18:16:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9ogAdRbbs+afEgHgDIvqh2CSTPsBoUxa/bXF+7+JBMI=;
 b=dvuAZqKdQdcDTQzzEXoid6Z3+ktlQVwQwNW2UqfwXbRpAm+izdtiVVg9jT3H0DHb132Z
 lvpgd2WZ4zXfjlBSS7sRM27/j9CJSbNXsmcPVh5UiT3sTEKwCbMMHDS0lb/tb8ca+SDP
 eOa73ur/lf7O/WHqYIhnC/Kd6AZ84Uh2zV4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36wvqdgyet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 18:16:16 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 18:16:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mry9NUS0aOnB3ooqRshj1yns+rhp50FYFd30Xz0spcT63NyYBYtmhLlcB5Ob+6LCQVgyzkcA1gMbsWcLgPV2P2b1xtUkLw1+SoBpJ7OBETBvq4+e6IrxiDxaEB/Wr7pHlQOO0Vm5iQ946hGCEMA3uR2FwoiM/4AuSXFejm5FKMB3Es/z7th+flUVoAm4UGopYKO/ygcDA+QKKIXxK1UTRhIAE7opVE3lblMnvUoz/jVlwcG4S7EgC/wVruC/QWZSUOdJ1kCdLbi+FVwRQczO5A5IRa7uqR9DSZk9im+zK8VEsCDiMAFVya4UMo6ysLPOj34hC/IArKgq3fFtwIYmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ogAdRbbs+afEgHgDIvqh2CSTPsBoUxa/bXF+7+JBMI=;
 b=F6zXqdKN1xVX74tYJskLPzritme/cuX+xUjj4Gsn6Vmvu1aFWJiyG6Gjahs0WynkHaiawMXNwPR79j89bpMRLNIOHwAgj9fKWGABoo637j2TYQvEwjgQxU9s48WgEzhNoQ4/PQlKfog4n0ZEx9IA5sWCuCpFLoGisL95SHHShEdCOWI52WEr0Z5lCH9Nha7sg/Xh242uxK0Mye1l3vz1OeTSSHa2cT6DJWt8+TPmxOacQvUrs9KNQ9eQZZ/Ldsf3onM2Js5zLKRQ6+CyOoV2sCc9t1bo2VV01e0Hq8PsY9aybIbYLkIXP+Jqa64GBNvZUTjzU8wz9D9c4YjkCXg4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4641.namprd15.prod.outlook.com (2603:10b6:806:19c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 02:16:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 02:16:13 +0000
Subject: Re: [PATCH bpf-next v3 04/11] bpf: add bpf_for_each_map_elem() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
 <20210225073313.4120653-1-yhs@fb.com>
 <CAEf4BzZMCOi__1Y86AbQDD_=kgT22G10pJqzEVwF5r37M2CB6A@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c042d2c7-a15f-c9b3-be7e-c729c1cf7184@fb.com>
Date:   Thu, 25 Feb 2021 18:16:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzZMCOi__1Y86AbQDD_=kgT22G10pJqzEVwF5r37M2CB6A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c091:480::1:6469]
X-ClientProxiedBy: BL1PR13CA0442.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:6469) by BL1PR13CA0442.namprd13.prod.outlook.com (2603:10b6:208:2c3::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Fri, 26 Feb 2021 02:16:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd8cdb7e-7560-4369-1f3b-08d8d9fc7d6b
X-MS-TrafficTypeDiagnostic: SA1PR15MB4641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB46414759657FAA1864FD7776D39D9@SA1PR15MB4641.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2E3Y8dBll8fvEll+9/XdZCl7NRQy5rJ9/Kiq8QMTlx9/VMYFvk/eJvAKSqYa8zxHXsJpA7FLbEAXp1XbCNztPR+oLjoDORXlRjvhP8QKyxBiIpEr0uqXhD8zhwhYTnn8A5750m9N//HRTMezDrKgk1z7T/kXxAzd3xSQcK9BYOU5l72DbwQfTIpFA2feV7TvEQkOQMbpQawiuv3A7xcabOanIIDqiDgDCe1d6wiEGQJJy7WLgp98hp2KGUaLXj+zusp8GgDzI1n0MV4L5oZofVKD+QoQ2kxY5yJ7jqQuo+EFfiHsa4zMxHz0EnSXVSkBKahN51zzvGGIbbJCM+DLBMiBlupQk2/NbX2B+KHVnVYkVhhUNwxcnjNNbGglOh0P0QO85xfvTogGVVs38PDkPwTCSs/Wrt5JOdHKvkQRYvIIhxqSwWq27Nsy6fFfXsu5+MvVE+ng3TAjEqADq379feEebjMVzY0B9dWUD9EvKhGm1Jpbt2Aa1zSshuZLcvmHc9ICFJNLczY7xNRbmV1wrBL/3xV2aIjX3lUyG5cwfs+prk/N3mrOlnWsv4K/QwTLzHvkP+mTfNBeTrxle0ml2wTPeUKzJkUYUa6P8Tlber1n2xrpxh9lCxWHog/HNVFGCHm7h3/4O7wYQhQ/K56/BORDDbACg+oo0JKaGSQWZ8ZwoxJbsSSchntTbDd5x5Nu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(376002)(39860400002)(6916009)(6486002)(30864003)(5660300002)(16526019)(2616005)(186003)(2906002)(478600001)(966005)(316002)(52116002)(54906003)(8936002)(4326008)(8676002)(53546011)(83380400001)(36756003)(86362001)(31696002)(66476007)(31686004)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QkhBeFpjRGlyTVlVNmJwTnFDMHBoMW5Dakt6QXppbUlkdVdoT2JBa0NwUjlU?=
 =?utf-8?B?RHkvTFl1d0tkVzNzT0lvSWFxQkZyRUQ3ZC92MHNBbU1YV1BKeEVDWTUxRklS?=
 =?utf-8?B?Y3pYeHc3eTVDUElvajJ5YXlsZzVDMHVYMFVHVm9Td1ZUeU5JemdxUm5kak4v?=
 =?utf-8?B?VUJad2xEMzVCYUNEYnV5ZFR4TFJKWStLaTVJNk5hOUVEMU9hdzZ3MTB6ZW1R?=
 =?utf-8?B?akJlVjBUMDBISVBETk52ODg0cEtjcXZqTnpYaEZJNDU1aElVWU5ubFViRGJN?=
 =?utf-8?B?ZmFMTDZnKzFxdHdXZFVUcEYrRFh2VHJ5aGZodWNheStBK3JOU2R3VXZFMFF0?=
 =?utf-8?B?NEpNMlFnd2VIUWdUMXBpTzVSRW85dVBRWm1JTW9McTdEMStyWjB5S25LZGlm?=
 =?utf-8?B?NUpPM1ZCTHZFdzhKYlQwN3BOWHE1QnpONlQ5OUFXTDhDbzFIeXFqMDRSOGFC?=
 =?utf-8?B?azBRVnNURWVwdjNaQk5UNXhOUStyaWE2VElyMHB6MEdwKzlFdWUyL1Q3WXBY?=
 =?utf-8?B?NWpFUTJCMmtFc3liOVNXdUJ3N2g5OUVEZjdzazBvc3hyQ0xBc0pxOUthbUc5?=
 =?utf-8?B?UFdWZXBMWlRaTlR0dUMrYzRHWUpPQmp1bytwbkdxK0thVW9ZWU53a01OWU5F?=
 =?utf-8?B?bkpGbjJlNVloTElIaTNzREQzTDBaeUtmN1BpekhzUUx1VStmRE1MVUpsMk9n?=
 =?utf-8?B?R3FSZjdkdk1veGJHZmJnVDVVampBeVlvUTNtUm1VbDkvSXNJQjVwTFFmQ25X?=
 =?utf-8?B?VTdBVnNlRUdYbFlBdkNWU0RaZ1ExckFDTzgwZFFia2hUU3VZQXBsaDY5bFN6?=
 =?utf-8?B?a3Y1ZFBhSlU1MmszbllEd1lkOVhhVUgrYnFRTmdpNnRsV1pESGVEZlg5OVNl?=
 =?utf-8?B?YXg1cTRBcTdnVVJKV0lxbzc1NzJEeDQwWmo3TlJueS8zRzF3NVpVNWg3ZUNE?=
 =?utf-8?B?c0Y3UUl4TnR1TngrTER4SHpiWmRlcjJJbkVuWEZ1YjVrVTZSeXlYTkROWDZa?=
 =?utf-8?B?ZEpCWm1qOTl2QkFvZnFxOGxDcFUvcllTSklmLzBnT1lBZkc1bXFaVFBER1dy?=
 =?utf-8?B?MjJoVTNucWRQbXQzWDdRVEJtdE5YKzM1cUY1Znh5cnVUdm1BUEhFOTRVbUEz?=
 =?utf-8?B?cDh6cFc0UTlmN2U5TnU2d2lKTUZsYVllQkZ6RG5zUVpBLzBWTC9HMjJNMmho?=
 =?utf-8?B?YlZPdCtJU2J5R3FtaDl0OVVKOW5qZkc3azRZZWhMR3diMitOWTBnbHhaZWxS?=
 =?utf-8?B?RUZQemozUnRtOEQ0Rk5hQ09OaU5aV3NXZStiT0k1a0Y3dG1Yd1ZOU0JaNmlE?=
 =?utf-8?B?cmMrQkFoS2p0eFYxaW14UWQxNlNzR0dxeXNPdDcxZFRjOGNPaElpcU5vYTV1?=
 =?utf-8?B?UDhCQk4zaFJlL1JEcUFHb2xWUDhxUDJVdTNDWE54OVZDU09MTWJ1SlpkYWZQ?=
 =?utf-8?B?V3Z5My9xa3FSdVBxdDk2Z2MzYThHemVOS0xMTGN0ckVGMkNpaFJsNXo2N1BR?=
 =?utf-8?B?UG1SaFBEc29WN1RtU3pZTmpPM2ZleG9FMUZYWHhkTklhRGlKUG5IMXNxTEhr?=
 =?utf-8?B?WG40UDl5VkVFQ1FLTzJUeXRZM2NsdFhPejVKKyt2a2VENEt2Zjl2TG1sYXB1?=
 =?utf-8?B?VDJyaHV1K2tpY1ZJVmw2ajI3V0dpNmh3WmxXMGQyZFR2MkloMU92QWoyTVNQ?=
 =?utf-8?B?Zlh3OWwraUlnN1NFN2tnS1JqR2lwR1I2RnBpdk9FUVJ0eFRpZzZNRkhmS01Y?=
 =?utf-8?B?NW1rdlpXMUVsVFZEUHMxMi9rNHE5YWM2Z0FTMm1jSlg5QWlWUVBLWTJHcTNU?=
 =?utf-8?Q?FvmoSUQ4bjDbbeDaBxwZp1ibZXi+o6Fn12DMc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8cdb7e-7560-4369-1f3b-08d8d9fc7d6b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 02:16:13.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjJaS6q6Bqi0jqEeNILan+de5IGaE0+CTnielIDZBhTNMNzeZEKkeEwV/3kbFLBZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4641
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_15:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 2:41 PM, Andrii Nakryiko wrote:
> On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> The bpf_for_each_map_elem() helper is introduced which
>> iterates all map elements with a callback function. The
>> helper signature looks like
>>    long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
>> and for each map element, the callback_fn will be called. For example,
>> like hashmap, the callback signature may look like
>>    long callback_fn(map, key, val, callback_ctx)
>>
>> There are two known use cases for this. One is from upstream ([1]) where
>> a for_each_map_elem helper may help implement a timeout mechanism
>> in a more generic way. Another is from our internal discussion
>> for a firewall use case where a map contains all the rules. The packet
>> data can be compared to all these rules to decide allow or deny
>> the packet.
>>
>> For array maps, users can already use a bounded loop to traverse
>> elements. Using this helper can avoid using bounded loop. For other
>> type of maps (e.g., hash maps) where bounded loop is hard or
>> impossible to use, this helper provides a convenient way to
>> operate on all elements.
>>
>> For callback_fn, besides map and map element, a callback_ctx,
>> allocated on caller stack, is also passed to the callback
>> function. This callback_ctx argument can provide additional
>> input and allow to write to caller stack for output.
>>
>> If the callback_fn returns 0, the helper will iterate through next
>> element if available. If the callback_fn returns 1, the helper
>> will stop iterating and returns to the bpf program. Other return
>> values are not used for now.
>>
>> Currently, this helper is only available with jit. It is possible
>> to make it work with interpreter with so effort but I leave it
>> as the future work.
>>
>> [1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gmail.com/
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> It looks good from the perspective of implementation (though I
> admittedly lost track of all the insn[0|1].imm transformations). But
> see some suggestions below (I hope you can incorporate them).
> 
> Overall, though:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>   include/linux/bpf.h            |  13 +++
>>   include/linux/bpf_verifier.h   |   3 +
>>   include/uapi/linux/bpf.h       |  29 ++++-
>>   kernel/bpf/bpf_iter.c          |  16 +++
>>   kernel/bpf/helpers.c           |   2 +
>>   kernel/bpf/verifier.c          | 208 ++++++++++++++++++++++++++++++---
>>   kernel/trace/bpf_trace.c       |   2 +
>>   tools/include/uapi/linux/bpf.h |  29 ++++-
>>   8 files changed, 287 insertions(+), 15 deletions(-)
>>
> 
> [...]
> 
>> @@ -3850,7 +3859,6 @@ union bpf_attr {
>>    *
>>    * long bpf_check_mtu(void *ctx, u32 ifindex, u32 *mtu_len, s32 len_diff, u64 flags)
>>    *     Description
>> -
>>    *             Check ctx packet size against exceeding MTU of net device (based
>>    *             on *ifindex*).  This helper will likely be used in combination
>>    *             with helpers that adjust/change the packet size.
>> @@ -3910,6 +3918,24 @@ union bpf_attr {
>>    *             * **BPF_MTU_CHK_RET_FRAG_NEEDED**
>>    *             * **BPF_MTU_CHK_RET_SEGS_TOOBIG**
>>    *
>> + * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void *callback_ctx, u64 flags)
>> + *     Description
>> + *             For each element in **map**, call **callback_fn** function with
>> + *             **map**, **callback_ctx** and other map-specific parameters.
>> + *             For example, for hash and array maps, the callback signature can
>> + *             be `long callback_fn(map, map_key, map_value, callback_ctx)`.
> 
> I think this is the place to describe all supported maps and
> respective callback signatures. Otherwise users would have to dig into
> kernel sources quite deeply to understand what signature is expected.
> 
> How about something like this.
> 
> Here's a list of supported map types and their respective expected
> callback signatures:
> 
> BPF_MAP_TYPE_A, BPF_MAP_TYPE_B:
>      long (*callback_fn)(struct bpf_map *map, const void *key, void
> *value, void *ctx);
> 
> BPF_MAP_TYPE_C:
>      long (*callback_fn)(struct bpf_map *map, int cpu, const void *key,
> void *value, void *ctx);
> 
> (whatever the right signature for per-cpu iteration is)
> 
> This probably is the right place to also leave notes like below:
> 
> "For per_cpu maps, the map_value is the value on the cpu where the
> bpf_prog is running." (I'd move it out from below to be more visible).
> 
> If we don't leave such documentation, it is going to be a major pain
> for users (and people like us helping them).

Good idea. Will write detailed documentation here.

> 
>> + *             The **callback_fn** should be a static function and
>> + *             the **callback_ctx** should be a pointer to the stack.
>> + *             The **flags** is used to control certain aspects of the helper.
>> + *             Currently, the **flags** must be 0. For per_cpu maps,
>> + *             the map_value is the value on the cpu where the bpf_prog is running.
>> + *
>> + *             If **callback_fn** return 0, the helper will continue to the next
>> + *             element. If return value is 1, the helper will skip the rest of
>> + *             elements and return. Other return values are not used now.
>> + *     Return
>> + *             The number of traversed map elements for success, **-EINVAL** for
>> + *             invalid **flags**.
>>    */
> 
> [...]
> 
>> @@ -1556,6 +1568,19 @@ static int check_subprogs(struct bpf_verifier_env *env)
>>
>>          /* determine subprog starts. The end is one before the next starts */
>>          for (i = 0; i < insn_cnt; i++) {
>> +               if (bpf_pseudo_func(insn + i)) {
>> +                       if (!env->bpf_capable) {
>> +                               verbose(env,
>> +                                       "function pointers are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
>> +                               return -EPERM;
>> +                       }
>> +                       ret = add_subprog(env, i + insn[i].imm + 1);
>> +                       if (ret < 0)
>> +                               return ret;
>> +                       /* remember subprog */
>> +                       insn[i + 1].imm = find_subprog(env, i + insn[i].imm + 1);
> 
> hm... my expectation would be that add_subprog returns >= 0 on
> success, which is an index of subprog, so that precise no one needs to
> call find_subprog yet again (it's already called internally in
> add_subprog). Do you think it would be terrible to do that? It doesn't
> seem like anything would break with that convention.

Will change find_subprog() to return subprogno. It does not break 
existing cases.

> 
>> +                       continue;
>> +               }
>>                  if (!bpf_pseudo_call(insn + i))
>>                          continue;
>>                  if (!env->bpf_capable) {
> 
> [...]
> 
>>   static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   {
>>          struct bpf_verifier_state *state = env->cur_state;
>> @@ -5400,8 +5487,22 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>
>>          state->curframe--;
>>          caller = state->frame[state->curframe];
>> -       /* return to the caller whatever r0 had in the callee */
>> -       caller->regs[BPF_REG_0] = *r0;
>> +       if (callee->in_callback_fn) {
>> +               /* enforce R0 return value range [0, 1]. */
>> +               struct tnum range = tnum_range(0, 1);
>> +
>> +               if (r0->type != SCALAR_VALUE) {
>> +                       verbose(env, "R0 not a scalar value\n");
>> +                       return -EACCES;
>> +               }
>> +               if (!tnum_in(range, r0->var_off)) {
> 
> if (!tnum_in(tnum_range(0, 1), r0->var_off)) should work as well,
> unless you find it less readable (I don't but no strong feeling here)

Will give a try.

> 
> 
>> +                       verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
>> +                       return -EINVAL;
>> +               }
>> +       } else {
>> +               /* return to the caller whatever r0 had in the callee */
>> +               caller->regs[BPF_REG_0] = *r0;
>> +       }
>>
>>          /* Transfer references to the caller */
>>          err = transfer_reference_state(caller, callee);
>> @@ -5456,7 +5557,8 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>>              func_id != BPF_FUNC_map_delete_elem &&
>>              func_id != BPF_FUNC_map_push_elem &&
>>              func_id != BPF_FUNC_map_pop_elem &&
>> -           func_id != BPF_FUNC_map_peek_elem)
>> +           func_id != BPF_FUNC_map_peek_elem &&
>> +           func_id != BPF_FUNC_for_each_map_elem)
>>                  return 0;
>>
>>          if (map == NULL) {
>> @@ -5537,15 +5639,18 @@ static int check_reference_leak(struct bpf_verifier_env *env)
>>          return state->acquired_refs ? -EINVAL : 0;
>>   }
>>
>> -static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn_idx)
>> +static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>> +                            int *insn_idx_p)
>>   {
>>          const struct bpf_func_proto *fn = NULL;
>>          struct bpf_reg_state *regs;
>>          struct bpf_call_arg_meta meta;
>> +       int insn_idx = *insn_idx_p;
>>          bool changes_data;
>> -       int i, err;
>> +       int i, err, func_id;
>>
>>          /* find function prototype */
>> +       func_id = insn->imm;
>>          if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
>>                  verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
>>                          func_id);
>> @@ -5641,6 +5746,13 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>                  return -EINVAL;
>>          }
>>
>> +       if (func_id == BPF_FUNC_for_each_map_elem) {
>> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> 
> so here __check_func_call never updates *insn_idx_p, which means
> check_helper_call() doesn't need int * for instruction index. This
> pointer is just adding to confusion, because it's not used to pass
> value back. So unless I missed something, let's please drop the
> pointer and pass the index by value.

As mentioned in one of my previous emails, *insn_idx_p indeed changed as
the next to-be-checked insn will be the callee.

> 
>> +                                       set_map_elem_callback_state);
>> +               if (err < 0)
>> +                       return -EINVAL;
>> +       }
>> +
>>          /* reset caller saved regs */
>>          for (i = 0; i < CALLER_SAVED_REGS; i++) {
>>                  mark_reg_not_init(env, regs, caller_saved[i]);
> 
> [...]
> 
>> +       case PTR_TO_MAP_KEY:
>>          case PTR_TO_MAP_VALUE:
>>                  /* If the new min/max/var_off satisfy the old ones and
>>                   * everything else matches, we are OK.
>> @@ -10126,10 +10274,9 @@ static int do_check(struct bpf_verifier_env *env)
>>                                  if (insn->src_reg == BPF_PSEUDO_CALL)
>>                                          err = check_func_call(env, insn, &env->insn_idx);
>>                                  else
>> -                                       err = check_helper_call(env, insn->imm, env->insn_idx);
>> +                                       err = check_helper_call(env, insn, &env->insn_idx);
> 
> see, here again. Will env->insn_idx change here? What would that mean?
> Just lots of unnecessary worries.
> 
>>                                  if (err)
>>                                          return err;
>> -
>>                          } else if (opcode == BPF_JA) {
>>                                  if (BPF_SRC(insn->code) != BPF_K ||
>>                                      insn->imm != 0 ||
> 
> [...]
> 
