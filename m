Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406DC3B0959
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhFVPnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 11:43:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40606 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232291AbhFVPmr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Jun 2021 11:42:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFYWGK010675;
        Tue, 22 Jun 2021 08:40:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ib3Sd/m2/AEMmYDhB6Hlo+IzJF+lm1N7UUnL62EqqDw=;
 b=mkGc4IU8tZ/YKh4XahReOQ6J+aJT/Hrj8U0HLTzPKBlgIfOZm3C31LxDgDjhgXrBSKdh
 VRZ13NqtyfkZObJl8ldhXz//Ay3p7lpOvmUgI8cyvKsY0GZfYiNuHX38Cekx69zwQJUM
 uNki/yDk8QnbYSOweER37N/rojsvy4AMsYU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39axwceyqa-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Jun 2021 08:40:31 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 08:40:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3SAJHCeYWd7H5oLire9xZajxQqxjKA3phj7m/7URHHVQ2GmYkmRtWff4o8PYZ58Vr1oqq3Kcj6JuzKYu9tbigBxkFI1yHB8ebnz3P1WdAhCIqRE7cJnYgZ0Ds/KU73jhk6PG3OcXOAdsYXBoI/dfxwlvha9ligqQAjIIrt8PrAbZDt4XA9wPkPoiKMhx5T2SRRRwjG4KLjMNXh2U3mXphc2SOvBVZxKD/b/9JfCBRpI4nC22wpCaHTwix9AUeSU4G9ElNB3/qGQ/GRy/8uwm1c0b7CpFi/D9dG+02lb71ZEFiTDKo4EHaBf1xP1EJ0IeCwzIz0+xs+pAj2edvKmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib3Sd/m2/AEMmYDhB6Hlo+IzJF+lm1N7UUnL62EqqDw=;
 b=P7BOa/jcr2k9uUMrFYVmGxm6vDbXq/8ar3PyXm/94MtCYZInJ2iu80U5AgocS0nWbqpho2dATEGV5CG11o2Bojzx1tYNaIje2WVhW3IRVDzQkpZqPx2oNiifKJBi0r8TqGflMexKEu7aIGI6F4kuSK4CeimDKoozB3ulmRaHKdYNGOwyVZjZ5c8XPqW8f8YGwo2Z1T1CF8pnr76G4B2jwm2KeqoxzLDQZDu1Zz7Cd7QkQxenHMsjymbUBVKCWTqQKijO1vBYSksFXP59mpnOJD2JpO6ImSwmWOwwz6Tb597HX3n8eRmUOfxm/icpTvydWG3nl9NOYIMeUi7dd3ReLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4436.namprd15.prod.outlook.com (2603:10b6:806:197::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 15:40:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 15:40:28 +0000
Subject: Re: Create inner maps dynamically from ebpf kernel prog program
To:     rainkin <rainkin1993@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <CAHb-xau6SrWN0eU1XB=jjvae3YxnAK0VsU08R0bH4bbRqo4aBA@mail.gmail.com>
 <8e3a8a21-f973-a809-d005-bcde3546e32c@fb.com>
 <CAHb-xav98Hy7=aGZsaU67Vw19OnGV8fsnzD+Xp6FJkGUtmmuZA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8ffd3d8a-6137-da45-b838-a965be7aa18f@fb.com>
Date:   Tue, 22 Jun 2021 08:40:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAHb-xav98Hy7=aGZsaU67Vw19OnGV8fsnzD+Xp6FJkGUtmmuZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:c3ab]
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1643] (2620:10d:c090:400::5:c3ab) by BY3PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:217::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Tue, 22 Jun 2021 15:40:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90582be7-c9bc-40e1-9274-08d935940f37
X-MS-TrafficTypeDiagnostic: SA1PR15MB4436:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4436ADF88C5B2EB17ABDB7DFD3099@SA1PR15MB4436.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBpS1Nj1/oiMpey92GjWe7NCIbHW66CoFDOxlgg779Rhn/jk57cy4DhMOI3ld/mCV+hHff4xakRRDbz5boRfiiJBEvMZx7eAJNIjqLfvgBtC65QQ/dA6QNs3wSo5Q54GSTjaqPTNZ/GrMqePC+9PAs8ftGNdj3BL8X2gq3OJwnFULxozGow2+qWk5p/FJgD/uPN+YVGrKsFbonjwbsuAOkTJY18fls0BHV/KOHVGYJy5tZWOy/zjPGB075dytRvol2n8vMH4TOGQ/Gbg1fCRWssIuG0Qn7DMPxj8l6gwNAppWa1H593YO/rlaGZUtBW6T9AGJCbsL96BI6qTzrmZtnUssmLON1nY4XJnEhpPnsiJUA+L1+s2NS28a0mFA7zml/w6MuKqHrHx8VROkKlyKa5uoyXDGwufyqAVa/+gr0QjonkeONQJmvMpvNbWOVK1tEsh49yoP4k0bD4F5T6IzbeZZQRiI1hX/HzKJEJk+IDsyjKBHSKeNEsnwyyOaRmglJfslbKLZofSa950PatEkmMp7wHwvGQMBug8HC5FArPrhP+DuLQETq0CyZyXy/KrPc/F9a7qQGk3f9A6Nw81UI2U0KQvNvY1zZxshQpdB8L1IDwSan/fbeFNHFeQhV0Gp91UcI5H1XHEXRCRKEiYNJfGb2y9DOUfjdVdJgyf/jq4rffOUuNVKWnnuQfhTZ/FR31X2gGoMnZnAVbteMGA1t150U5AGGk03zx3GjaG8CsAZRY9VozScvvK8IHVLFgitsBrjtG9ngTVWa86AuTWtjZqvzXy6lajoWm2c5KXRnbzYcBXo9gfBunQPjGWFXvrAfLGDR95ACAcqFzyRYBnWJmFFvV2geLx8jOs+dJodl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(83380400001)(53546011)(52116002)(31686004)(6486002)(186003)(16526019)(4326008)(478600001)(6916009)(38100700002)(966005)(8676002)(2906002)(8936002)(316002)(36756003)(66946007)(66476007)(66556008)(2616005)(86362001)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFN1amNuWHJPcktGZURWSEZjTkRqQkpOOG9oRWVpeGYrTTFlSy9OSENodTlo?=
 =?utf-8?B?aVYvYWxLMzI0M0hUTFFvUDM4OGQ3cW1zZ2tjN09ldzVVWUNSZjdtZHJvZ3cy?=
 =?utf-8?B?QVpMbW9TempnZHdNQ2RZWldicWJLMzJzeUJrZHozVUpaaTJ4QW12ei9EeDFS?=
 =?utf-8?B?VTg1THpvVWxPd1A5ZnFtQjBBYVh4UzFmL1h5azViWWgwVlJlMFZPNG9xUWsr?=
 =?utf-8?B?alhqRW5iZW90alVQZWVCSTNQQjM1MGRPWDBQaDdLMDdheE81VmFCRjZrN2lj?=
 =?utf-8?B?OW96Qjc3V0V0L01udHNBUEhBYzg2QUtJWWpuOHd6NDRXMnkvbC9helBhMGtR?=
 =?utf-8?B?dzRUUUhZNklYaFgrWldZYlNtdW01eEUxaHlGeEpPdEtsbzFiTGtjbDNMZnJX?=
 =?utf-8?B?TlZ1c0xlS1FUUGdLN3ViT2c0bERDc0JPTGNWOFFuMFlhdXpLVVV0RkFnVW9B?=
 =?utf-8?B?RlQ4Mkxvc1hFMlV2YVQ4c05Td3ljYnQ3N3g1cVhhWlZHYUtSNDdRRy93YzVr?=
 =?utf-8?B?K3VWdGFHVk9oQWdUQ2Y5dFVXZk9WQithRTFvbWFKOElNSUp6YnlCd0dTYm1z?=
 =?utf-8?B?QU00ZWxTZmR5ZzZOSUoyUElsY0M5TFk4S2g4THNyWUxOSGNZSVE3cnM3SEIw?=
 =?utf-8?B?L3AzYS9ZMmRHVUxKR3Z6aFp6am4wdUJzSjREMGVaVmo2Sk4zTFprQVkrOTlq?=
 =?utf-8?B?eXFSMTZVcHJxYmRwVFpUMXV2b0pOc3pCNktPYmx4aFhNZ0hxcTRDTnRKZmVk?=
 =?utf-8?B?WmRpUENXN2NLTlFCSC9vSTNQTCtpNWhmajJMcFdHZGVWYlU1aWpxMk9QdVNT?=
 =?utf-8?B?dTJrQ1hVZlVveDJlZ213NGk3UmtoejlPdW1Rd25LOGs0SHg4Wlk3RWNXY0xr?=
 =?utf-8?B?ekNDdVI4V0xlU0t1c09KNDQrd1BtMDJTUXplR3RiWWVSSXAyc2J5VnA5TWV3?=
 =?utf-8?B?Rys3TEdZT1NQR3VhbDU4QlB1VWxCWWwrcDIxM01Tbm1pSER5U3BRUHNNYjNj?=
 =?utf-8?B?QTJWZ25aclgrbEZjeG9QbS9lNW84MWRPeUJITXRHTzZDQmRXNnFKQjA4S0tt?=
 =?utf-8?B?d1RMTzRyY0p1eU92UitvaXA4T3FzT0wxOW92MnZGR3dqWmlIRWY1Wmxha2Yr?=
 =?utf-8?B?VFduei9KeEQyYWVTaHpWdThHcHhYSVFKeXJsQ241SnBuME1yUU1idjQxNUwv?=
 =?utf-8?B?dzRCUnBiMWpmQjNWQ1FFeTVTQWl1VFFPK1N5QVhjZjgyTWVMb3IzSkQ4QmNO?=
 =?utf-8?B?YzgrZ1Y3dUJyVE1HcjI0TEVrUHJ4a2tZVDRxMnVlU2tjdGFuKzBUSnZvUEVI?=
 =?utf-8?B?TUcyMjBWS2JYRDYwYzdzMW9wUUJDeVFBT0xXWWY4TXRLaHdZUmF2NkI0WmJT?=
 =?utf-8?B?R1JVZlNRTUhzL0ZFZzVVckJYemdRQjc4Nk80TUNqRHJGakhDK3gzVnFOSWNl?=
 =?utf-8?B?R1NQYWJ0ZHd1SFp2YTNNTzV2MzlNc3NNcU5iTmRCMGRseldqYUQ5SWdKaXBu?=
 =?utf-8?B?VzdTTDlXT1VNcmMvZEYxTndmZzlXMXZGVkFTSS8vZVd5OXlLUGlDTkpFUnVy?=
 =?utf-8?B?WWRjQlZjQ0w5VnloOWJkZzBDaGltMCs0NUcyMjQraFVYeXVpWEZWNkYzUCtt?=
 =?utf-8?B?U2ZWZERvbHAvL25wZDdTUHgwK1l3djB1cEMxb0FCVnZNWUQ0T21OKzgyV1Qv?=
 =?utf-8?B?L3E4Z1c4UUpmekt0M1c5QmUvTDh6ODIvYjR4N3c1c0dQMi92SW5TbGRwWFpi?=
 =?utf-8?B?RjlsenZseUtiK0xvMG1nSlRJeXo0b096UE1rY005elBSS3YzQUFwenM5c05t?=
 =?utf-8?B?MDdQVkk1K2JUVHdTa2RaQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90582be7-c9bc-40e1-9274-08d935940f37
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:40:27.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuaqXeLAGDxZp/LuMkq++vlnsubGyz9OL6TUTTE0cuynWr7MM4KkG+kfHiTBtQ0U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4436
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ar-5V1y-LoeeATG1bvBqcpwE8mujYVPo
X-Proofpoint-GUID: ar-5V1y-LoeeATG1bvBqcpwE8mujYVPo
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_08:2021-06-22,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=993 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106220097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/21/21 11:47 PM, rainkin wrote:
>>
>>
>>
>> On 6/21/21 6:12 AM, rainkin wrote:
>>> Hi,
>>>
>>> My ebpf program is attched to kprobe/vfs_read, my use case is to store
>>> information of each file (i.e., inode) of each process by using
>>> map-in-map (e.g., outer map is a hash map where key is pid, value is a
>>> inner map where key is inode, value is some stateful information I
>>> want to store.
>>> Thus I need to create a new inner map for a new coming inode.
>>>
>>> I know there exists local storage for task/inode, however, limited to
>>> my kernel version (4.1x), those local storage cannot be used.
>>>
>>> I tried two methods:
>>> 1. dynamically create a new inner in user-land ebpf program by
>>> following this tutorial:
>>> https://github.com/torvalds/linux/blob/master/samples/bpf/test_map_in_map_user.c
>>> Then insert the new inner map into the outer map.
>>> The limitation of this method:
>>> It requires ebpf kernel program send a message to user-land program to
>>> create a newly inner map.
>>> And ebpf kernel programs might access the map before user-land program
>>> finishes the job.
>>>
>>> 2. Thus, i prefer the second method: dynamically create inner maps in
>>> the kernel ebpf program.
>>> According to the discussion in the following thread, it seems that it
>>> can be done by calling bpf_map_update_elem():
>>> https://lore.kernel.org/bpf/878sdlpv92.fsf@toke.dk/T/#e9bac624324ffd3efb0c9f600426306e3a40ec
>>> 7b5
>>>> Creating a new map for map_in_map from bpf prog can be implemented.
>>>> bpf_map_update_elem() is doing memory allocation for map elements. In such a case calling
>>>> this helper on map_in_map can, in theory, create a new inner map and insert it into the outer map.
>>>
>>> However, when I call method to create a new inner, it return the error:
>>> 64: (bf) r2 = r10
>>> 65: (07) r2 += -144
>>> 66: (bf) r3 = r10
>>> 67: (07) r3 += -176
>>> ; bpf_map_update_elem(&outer, &ino, &new_inner, BPF_ANY);
>>> 68: (18) r1 = 0xffff8dfb7399e400
>>> 70: (b7) r4 = 0
>>> 71: (85) call bpf_map_update_elem#2
>>> cannot pass map_type 13 into func bpf_map_update_elem#2
>>
>> This is expected based on current verifier implementation.
>> In verifier check_map_func_compatibility() function, we have
>>
>>           case BPF_MAP_TYPE_ARRAY_OF_MAPS:
>>           case BPF_MAP_TYPE_HASH_OF_MAPS:
>>                   if (func_id != BPF_FUNC_map_lookup_elem)
>>                           goto error;
>>                   break;
>>
>> For array/hash map-in-map, the only supported helper
>> is bpf_map_lookup_elem(). bpf_map_update_elem()
>> is not supported yet.
> 
> Thanks for your answer!
> If I understand correctly, the conclusion is that (at least for now)
> *ebpf kernel program*
> CAN only do lookup for array/hash map-in-map, and CANNOT do
> add/update/delete for array/hash
> map-in-map, and CANNOT create reguar hash/array maps dynamically.

Right.

> 
> 
>>
>> For your method #1, the bpf helper bpf_send_signal() or
>> bpf_send_signal_thread() might help to send some info
>> to user space, but I think they are not available in
>> 4.x kernels.
>>
>> Maybe a single map with key (pid, inode) may work?
>>
>>>
>>> new_inner is a structure of inner hashmap.
>>>
>>> Any suggestions?
>>> Thanks,
>>> Rainkin
>>>
> 
> a single map with key (pid, inode) is ok for the above scenario, however,
> when I want to cleanup all entries realted to a certain pid when a
> process exits,
> a single map is NOT ok. I need to go through all the keys of the
> single map and delete keys related
> to the certain pid.

I understand this. Totally agree that it is expensive for the cleanup.

In such cases, map_in_map is the best strategy.
Alexei recently added a support to call bpf create_map/update_map 
syscall in the bpf program ([1]). This needs to be a new program
type though.

In your particular case, you are doing kprobe/vfs_read which is
in the process context and in the beginning of syscall, it probably
safe to call create/update_map syscalls (I did not look at the
kernel codes thoroughly). But verifier needs to ensure it is
indeed safe. There are some ongoing compiler annotation work ([2]),
which may help annotate such functions so verifier can do
an effective work.

BTW, this is all future work. For now, esp. if you are using
4.1x kernels, I guess (pid, inode) probably your best shot.


[1] 
https://lore.kernel.org/bpf/20210514003623.28033-2-alexei.starovoitov@gmail.com/
[2] https://reviews.llvm.org/D103667
