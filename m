Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B9403F34
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhIHSrS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 14:47:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1426 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240231AbhIHSrP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 14:47:15 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188IhBMO021690;
        Wed, 8 Sep 2021 11:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RFmN7YFIY4x/DPIoajaOqRFdZF+ErOzzFxAibSCnz6o=;
 b=ja4wu07sagtuFKMEuYWHAFjf4vEiij0vgkBnxLOeG9k/fLU73Y9mP6YLQl9/4lM0L4Qr
 aL04hbpfViLR2bvU064qYcs4/JAvg4xbc8FJu8BIQ5hTQhRSxDM3Ug9zwgJOjPtPsu57
 pDdOfXCqiurX0Q3H5VU7QwKmX6BF0lNv/Go= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpgsdyc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 11:45:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 11:45:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMGYGYsQiDsu2nVc94xMfj96dvEkw5fKNlhAdUCL6pCM1wuiJJ0gK2s+kgmVDsHqPtXid8r1DkXprIBAInrXilM/6xEkbsFrC54kX6vWvimLs43jLcIvRTpXqnRSWmrVk3V2LfC09j+9gmBEd08SSg1Aev6YsRRI4GCqV9zp4b2tk+LaL7UhjRwv75jE/JDU6jBj1KTBz/nNR5I4J+xDyOFRpPAgJT/nghFekxo8Zyjgxe6UkPEulhzMTPLKeB6SAiBb3OpTDszog1nU6Hti0SDhzustQ3V3ivbWD0mrh4rEFbRozqhx06Zy++K5NHIKkByvLg1pIccCAXFfVKVxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RFmN7YFIY4x/DPIoajaOqRFdZF+ErOzzFxAibSCnz6o=;
 b=KtUxcbdKzxsx5A5FXXBoSY5tS8hZ4xOiKcpSmB6Urp1A2uYScEzurtqUqg9tlqOxNHn2RWngpAkTzonEysoL43DLevSOKitebNtSz0QB260IPaMM9ukkOVjQksWnQrBfdJv2xJQqFEu/3bxv/N31kaXbtaaUvbZ0ExRXH0amib+oL/vVJohQh3cCFk6vGQTVxc00NlMmdeHOOj3gyy0LYRUz0t4Z3Au+oMea9g8JLCYhNoQ9dp1isAfkTiVDqnbp2BVAtmYs5xuO/aXefbekLmviFNuiaJGr1yeAxc1tsUVIEeobgY80eNXZU/O6J3ANEDyq7JGYpIitt3Cbnl3X6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB2908.namprd15.prod.outlook.com (2603:10b6:5:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 18:45:17 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::80a7:bdbd:d33b:e03c]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::80a7:bdbd:d33b:e03c%5]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 18:45:17 +0000
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
To:     Liam Howlett <liam.howlett@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "walken@fb.com" <walken@fb.com>
References: <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
 <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
 <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
 <20210908183032.zoh6dj5xh455z47f@revolver>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <97b17544-b572-30b4-bc2f-6e7b77892a39@fb.com>
Date:   Wed, 8 Sep 2021 11:45:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210908183032.zoh6dj5xh455z47f@revolver>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e8::15db] (2620:10d:c090:400::5:ffd6) by BYAPR07CA0068.namprd07.prod.outlook.com (2603:10b6:a03:60::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Wed, 8 Sep 2021 18:45:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 393b3d16-b7aa-4a91-f066-08d972f8cd42
X-MS-TrafficTypeDiagnostic: DM6PR15MB2908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB29088D186E6D67F1EB6A10BED3D49@DM6PR15MB2908.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkpqkkrkZMZe1NKr6wpIUVSPv6cS6XR1la9bbm8aQwhKgtgxRrAcBBSocIH2jP3fzBJ3SYlHgtLFN3vKAK8Lz32pJ0plXspTZ+5a3R70fCbbpflApvZ4hcvewxUxdf0Y6WoaqpXcRbY62GnqSI1ZIXJ9Lk/OvbuZxQRTgXCCMnQV6om1++9MDSeRQ1mzu4h8MO6SUPFlz8aTRxFyHu87Sqw8a9wdE06BvcDQVfpBUWZAVfk553rU90ICYdZnD381AkGfC2MP+4kiWZlk/CigNseVGVX2V8b/8u6SzRf+5Afprdaf0LnpYzwjFqV+8oZ5LP9Tpj4cgvsTVLn/SR6O5byyW2TA70itQVXfOvTXw1QX/2GsYcrwHP24XmMrq/KjySi6EPOdesJe4P+u/aKAToxVzCPSJx6jYO6OvtZsDTY7aiUViMKtwPCmj7U9kW9i6PSZtgzmpnXXqtrThN1IQaduHkaHYDSZv38iU6Pas95twqHqqdSWLQNkpp/rYkYy7EFUuolVbdKlu5TWXU/O5s8aTyqqgJWqlMO8kEwZvGWfxIuJRYXNXUkpRPX+SKsJu8QZxE1G5RHz5ralcrF5NPq2DWdOtZ6Mn9Sd94qLBAHUucysBoX+z5+p/IwijYh9lrXZomNN4655HW6kCu2sFltTMYbM5784YoyoUXplJbY4zoNTC/I+6NCvdb5Lplfzt1TLzXBP/skrvhFXlG7HgYHxRaT6K73qgbP9xNxF8iY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(2906002)(86362001)(8676002)(5660300002)(31696002)(8936002)(54906003)(508600001)(83380400001)(186003)(66476007)(53546011)(110136005)(66946007)(66556008)(7416002)(36756003)(52116002)(31686004)(2616005)(38100700002)(6486002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3lvdHQrMTNSNlNaczFJTDhjOXJXWHJiUUQxalJ6eEU2U284WGVBdXV0em1r?=
 =?utf-8?B?RFNyQTZmeERHdFZoeWtkNjk0U1pMSklsekRDMXd5VnhlMGlRYkp6NG9Gb0F4?=
 =?utf-8?B?Mlhjci9ldnRsMHFvL044NjFGWmxFWFhPQ25iT0lKVjZHT1BrSEpGZ3F0RHE2?=
 =?utf-8?B?Vm5HOXVVSENpcHA5RklicFJWSkZ6eTdZWjVhZDRrVWsrM3BGcjRlaU5KZEZY?=
 =?utf-8?B?MXBsVktvQ1hhWk9iUWdrVzR2ejJWclZ0c2RSMERzbVM3ZWJoQnp0WDNsZWdj?=
 =?utf-8?B?UUxiUm5IN3pZWG1kOHZPaEpiMFhpZkI3L1pVbElVMnhtWXlVQlVwZHpGRHUw?=
 =?utf-8?B?U3kvWDhObXcweU12KzVDUFg3UjN3aDdoSkJDVHVyazhqekRNNGFwZ3Z6VlNG?=
 =?utf-8?B?cGl0ZSs1bFhOelFtWHBURGFRdEZJL211MWZGMEVWc3ZiTUh5cVNKblVLKzc1?=
 =?utf-8?B?RUNFR3cyb2ZlMTdUbHlGQVMwZmJVUEFJZUhpNE9QLzRCTU9sTlBaaVFFL01q?=
 =?utf-8?B?cmxWWEU5T3pDaGtJZnZMYTl5Y1JMTFJLQnp4QjNRUGk2N1NabWIyUzZzdlVW?=
 =?utf-8?B?OUt1b1VaWWczOFhBRjhvOUpSNlNoeFVtVmNhSDl3TVBBbDBaK2F5eks4aSs3?=
 =?utf-8?B?ZmlyWmhZMmlHSXM3TG9tMzZKSVBoYTNjTTB1ODkrMWl3RjFQdmZmdVhDZkFj?=
 =?utf-8?B?aUM0N1ZSaGkxaFVpSUJZaHhTK3ltM01GNmRTZE5TcXhDTlUyWHp6WnVwVS93?=
 =?utf-8?B?OXJyQ1JBbGdVb0FqUWdpSHFJM1JqTmZxQUtsL3J3dFgvTWdFcFVHZ0J1OVJO?=
 =?utf-8?B?ZjdIR05rYllITlljUERhWGkwRmNBTXBuS0QrSG55a0h5SGJrUVAvb0dScWZa?=
 =?utf-8?B?bHg2TkFBZFR4RG1HUzVucjN0cGdSZkQ3UDA5NHlneDV4NVVDMmRyQ3htZkht?=
 =?utf-8?B?UHJFdTJ0clkxaDB0ZVVSdjRCcXkrMFBZNnAvUGRMN3djNU1KbGQ1c3dmaTBw?=
 =?utf-8?B?bEhNTmUwUnk1ZFBtOG5Vc09JN0MzMFJBYzBNdXZsbGcvNEZsam13dmFWcXV2?=
 =?utf-8?B?L3R0WDVJSzJOMkw3b3B4V1RpdzAyTVdPN3dRSEdsYXVWcWdMeXFQQUlQWU9O?=
 =?utf-8?B?NUlCc251TytIZ0M0M200MVhwTi9jRVozeTZiR0xCeEtQeTQvZmh4QUU3TERv?=
 =?utf-8?B?MUZ0SnpaNmtaTGV3WWdjOVcvYXN1TTBlelFoWjRiUVhqRHZaNG1qaFJLVmJs?=
 =?utf-8?B?aFhOUUswckxjTzY2b2dvRzNIeno4WWc5bGZFNEJkOEV0VEs5bzdSNzdIeUtr?=
 =?utf-8?B?ZEQzTzNZVmxwM1dtZU5NOWg3anQrd1lCR0hwUDNjenN6UktpQlZMNDZ1ZkxP?=
 =?utf-8?B?QzhzdUhtaUNQQlZPVEh4WDhCRE9jNHhibDB2NTlKMTNaRVB0UlBObmU4bVBY?=
 =?utf-8?B?YzNINERsSmdRczF2Z3orR0J6R1NaWUVMWFNJd0xQKzJlS3RlNjBacUJlV1BJ?=
 =?utf-8?B?Z2E1Z2tib1U4dlFTT2xJK2oxbnM0UnZUTndCaFVkNlA5UC8wcWJDU0ZyYVpC?=
 =?utf-8?B?Q2FyTU9NeGVSa1NHTjBvUFJyRVhiWUxiYTM5WVZFUnVrbnlCZUVjVTJUMTVX?=
 =?utf-8?B?bmVTalN6T0YxUCtLWXVsbktUcklvZ2Q2MnhqdDUvT2hiZFB3bWFPNFB2Mits?=
 =?utf-8?B?a2x5UkpMMnBaQlNEUS9rK0hKK0JTN3Y1eXVtZmVJTnRmb2ZQc0R4M1ZXQmow?=
 =?utf-8?B?czhHV2FHMjRwQzR6VFkwUkM4bmNnV1YrKzI2TXM3TnAzZzQySHNnb3YvbzU4?=
 =?utf-8?B?YUJ1T1Q2SlJpOHdtQkIyUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 393b3d16-b7aa-4a91-f066-08d972f8cd42
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:45:17.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9eMGhIe5hNBbVQmefuvok6penyfiNud0/Jg4xAsSpfMQamm+7CgAnx11w7aE8nH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2908
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: pE0joGGRzygyjoTIMUq_e3AAIt4TiVqD
X-Proofpoint-GUID: pE0joGGRzygyjoTIMUq_e3AAIt4TiVqD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 11:30 AM, Liam Howlett wrote:
> * Alexei Starovoitov <alexei.starovoitov@gmail.com> [210908 14:21]:
>> On Wed, Sep 8, 2021 at 11:15 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> On Wed, 8 Sep 2021 11:02:58 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>>
>>>>> Please describe the expected userspace-visible change from Peter's
>>>>> patch in full detail?
>>>>
>>>> User space expects build_id to be available. Peter patch simply removes
>>>> that feature.
>>>
>>> Are you sure?  He ends up with
>>
>> More than sure :)
>> Just look at below.
>>
>>> static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>>                                            u64 *ips, u32 trace_nr, bool user)
>>> {
>>>          int i;
>>>
>>>          /* cannot access current->mm, fall back to ips */
>>>          for (i = 0; i < trace_nr; i++) {
>>>                  id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>>>                  id_offs[i].ip = ips[i];
>>>                  memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>>>          }
>>>          return;
>>> }
>>>
>>> and you're saying that userspace won't like this because we didn't set
>>> BPF_STACK_BUILD_ID_VALID?
>>
>> The patch forces the "fallback path" that in production is seen 0.001%
>> Meaning that user space doesn't see build_id any more. It sees IPs only.
>> The user space cannot correlate IPs to binaries. That's what build_id enabled.
> 
> I was thinking of decomposing the checks in my first response to two
> functions.
> 
> Something like this:
> --------------
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dce46105e3df..8afc1d22aa61 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2293,12 +2293,13 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>   EXPORT_SYMBOL(get_unmapped_area);
>   
>   /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
> -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +struct vm_area_struct *find_vma_non_owner(struct mm_struct *mm,
> +					 unsigned long addr)
>   {
>   	struct rb_node *rb_node;
>   	struct vm_area_struct *vma;
>   
> -	mmap_assert_locked(mm);
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>   	/* Check the cache first. */
>   	vma = vmacache_find(mm, addr);
>   	if (likely(vma))
> @@ -2325,6 +2326,11 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>   	return vma;
>   }
>   
> +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
> +{
> +	lockdep_assert_held(&mm->mmap_lock);
> +	return find_vma_non_owner(mm, addr);
> +}
>   EXPORT_SYMBOL(find_vma);
>   
>   /*
> 
> --------------
> 
> Although this leaks more into the mm API and was referred to as ugly
> previously, it does provide a working solution and still maintains the
> same level of checking.
> 
> Would it push the back actors to just switch to non_owner though?

Thanks, Liam. This should work for bpf side as well as we can just call
find_vma_no_owner(). I will submit v3 soon.

> 
> 
> Thanks,
> Liam
> 
