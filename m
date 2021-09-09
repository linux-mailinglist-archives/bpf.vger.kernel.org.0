Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5749A404532
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhIIFwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:52:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47690 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350877AbhIIFwK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 01:52:10 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1895TW6x025201;
        Wed, 8 Sep 2021 22:50:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1148QoFJ7VL6Moki25eFGTbOe7hPlHsHwFLkPlFSONo=;
 b=ftd3ag9PBe7Vll4PFhb41C8MRAmxDN1zCFwp+gyM0S8ZbLPHLEB972qalt3zlNevocy8
 ePUoxWJ0AZedjO0a+PY7EiLteG2SfRfAAM+FtSudWAzWyQQYB7vvVch/PAqfIG8/WjuP
 YrLgLwZG8Q13xl9s50SF4rn7FzwZSPrE29E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ay5vk2eu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 22:50:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 22:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUB9xyNtDskB151bH0b+6OlJyC/TBOQuoImC9uXkK91vW1UYNN/qk4JWHrCH8On7Hwsb52lduoui7KfCnugxX3qrGc5jW3k2Poi9sf7FHfDiJsxYSStHidQjoK1+8O1ksOCuZdmVQ1G3FhrDXKcSyvqb2INaVl9rfda2B+PMIpTEGo91BoU1J7rRADIvGaEJUavsY551OZt3ZOyQhSEpHO3P47Z76Fyj9biV4D1b3Rr2yDYBsxk4YPhg6C1xYL70IUhDGvSuQPlJt9agZARPNaphyoM1QJ+eB8j3Mrr1XHosnA9bxQiF4RSrZ7UkL4bNFCFqirKBwF/9mkaLOC4OvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1148QoFJ7VL6Moki25eFGTbOe7hPlHsHwFLkPlFSONo=;
 b=ISuoF6qHTsX7P31mFA0XW7o3mppEZOhvrGJ9UXJjwy5s8wf91dlZILF5je6PFLwOdFtx2Mn63uTG9Hu44a0Y3XT9H4NK0reWVVQplaEt1pa81tHWSupgysRXrV0BSA4QNz29I22HIUa84EO+95Lhrn3HibAul9hBWix2GJbNs8fHMOgiSAc64D+MF6f+B4Hc3igfcUSlL7PO8YF0egivRkw1nZ00rQCY+goLEIqenAkJz53VVowinG1pOyFHASgYFcctFwmSX44m7pUgsTlpyaZvKa1vCtUJlJRKVvChaq3eB8rz7ovzQfEoo/2pO+DBq5GNoYjkhKns8V5CtszPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4901.namprd15.prod.outlook.com (2603:10b6:806:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 05:50:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 05:50:38 +0000
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "walken@fb.com" <walken@fb.com>
References: <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
 <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
 <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
 <20210908183032.zoh6dj5xh455z47f@revolver>
 <20210908184912.GA1200268@ziepe.ca>
 <7aece51f-141c-db55-5d4c-8c6658b6a1fc@fb.com>
 <20210908233331.GA3544071@ziepe.ca>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <18766a42-ea2f-e019-a8f7-43db50870300@fb.com>
Date:   Wed, 8 Sep 2021 22:50:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210908233331.GA3544071@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21d6::108f] (2620:10d:c090:400::5:fa3d) by BY5PR16CA0010.namprd16.prod.outlook.com (2603:10b6:a03:1a0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 05:50:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86efaf83-a137-4a65-b12c-08d97355bff4
X-MS-TrafficTypeDiagnostic: SA1PR15MB4901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB49019483A03A82E1ABCF4978D3D59@SA1PR15MB4901.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJoHsfGwyuYDeIFQoeeQaD5PkGOMb4bAB4Z3cJQ1WkvcySDNpeUYhB7drk8M9nqtqtdAcZd/adPloam5IDl5Z9unHLUyFZbz+aWIbp47frjsOBUT5rScEdT99ysZVd0yOinXhlpsMOeGclQqS4+cAUTvcBd7NXrh1hCr/kVon9P4uSXGoTE8oUIJf3d7Ze9GNhUQCUgs5b7z40F7plD/a3vd4vrUo3lfDgvxPJQMvspzt8uL8xiI9IH7+F3z1thW7HzFjt9cFqTy/naaMsPByRxxlLQTTsw9zwndOzgA3FclfcR7ldoVi12foyNGDfRi4USv0V5qQG5SKeL47kTr/Ufn1k5Wl8qYuWuE9isUueHGEyFshPNKzV0Qb0fFyuLLfDZPRUIPZKYr+gf88nOtGtiAMBd1+c/K6D171OHAGet+/TmKMT/z+oKHlPRjGJwAceWW0DBKD+fKHdGAX7rtJbSWpXqT6Xq1SafobkQCfL2gjElrr5mLloxnnSEjo9c8Pm9cmz6neCv84ShgKd3rkFGE9OtPeP/mZH1AMPWQ487SYpHUIuZOD7CzTCkjHgO/9+eepqEgt/wO2AiBXv8qeSPolqB8Y2LzNk9jN7zJBenohmjuYTWKRHyyXj29eGzLq9lP8fJXsInxl+AqWVg/WAAqypBocVgVSeHEP9VBMDCmOPasOGcbEvDAmlCGvddIoUx7HttwEFbIJeJ02GZfa2B1ZDZfXXETa0IzSy6sRJT1Mxw38R6TTXHHhO97zNs1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6486002)(38100700002)(5660300002)(53546011)(31696002)(186003)(54906003)(31686004)(86362001)(2906002)(52116002)(8676002)(4326008)(6916009)(36756003)(316002)(2616005)(7416002)(8936002)(66946007)(83380400001)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUpCOCtJVDZTOG9SSnVNTVBEa0orUlVvNkJIZUdHZm05WUhiREV4SGtBYUQ3?=
 =?utf-8?B?MzJSSElXTG04RUNyOGd6NWxSQ3diRlAzNExydjl6UzRJb096MmRVS0Q3TlVt?=
 =?utf-8?B?eUhKeHZsbHFNSEpzRFpjZ3FBRnRNNGw4aFNMR3ZmcGllMkZnRlFKem5RNmZn?=
 =?utf-8?B?TEdkTVZFQkNiNk1nQ2I1RjBOdVVyU0t3cDEzWmIyN3BsWk9peXJidGxIUmFC?=
 =?utf-8?B?MEZKMkhaNzZNMUFnVlFQTlcxaENjSnFGcTBpUHJVdmYrQk05QUs2dG8yRVlN?=
 =?utf-8?B?cytlSy9VdVE2UDFzL0ZnTUFRd29INVdhcE1FeDFDR2VUQlhHbTgvbll1bzBR?=
 =?utf-8?B?UnJncmtQcTZzMzBtR1ExRTJ0S0ZwbmVjSHlnQS9CSXQyeFBhbVpjYU40aDRw?=
 =?utf-8?B?a2dqN2kzbkVsV0k4Z0FFdldwQ0hpdUtzRUVOSkdFUGxwR21ZL2lwZGw3SDUz?=
 =?utf-8?B?SnJrYUE4WStTbmkzZHN2dEMvOXlVaXVPd1VIR09qQzFvNVowOHZ3ZUZIUWN1?=
 =?utf-8?B?Y21nWWx5Zm9QQnpEUWt2aVJLYW9xSVdEc1JZcy9JTzQvUGdreHFNNGRacC9z?=
 =?utf-8?B?MEZuR2ZmT3pHL3BYNVp0WGMwSG40UmtYbTA0YXNheGd5LzNOTTBpUDhnMjNY?=
 =?utf-8?B?aVZRNnpIcWU0SmN1U3JZMncyRENYUVdPVXFDdm55c1A4Wkt0NUdpbFIvdTA1?=
 =?utf-8?B?WWRjdCszdEp6b3I5SzhXbWI5ZTdRZTZUaE9odFdGZU1CTVh3cjZOa0I5SUVu?=
 =?utf-8?B?c0RQREdKM253bERvSGdzeGdlQUNYeFFMcTNrU3BZMFlMSVhDdXNDWEJGT3By?=
 =?utf-8?B?WjJURitqK21NTHJWMmRNUHRHWXpRT1lNdFJUNlkyTVI4blF1eHZ2Y2FTWXdL?=
 =?utf-8?B?NGFkM3hjR28wamRKbXNYRHZwYS83am9YTzhoLzRRa3d3S0duNFZEdS82Q24z?=
 =?utf-8?B?NWFGbnhIblVwN1F4alFHQ2lMdjdxclo1UEw0d3RYNy9idk5wQUxGdHdoUnA0?=
 =?utf-8?B?dmZ2TEROVDdUMGd0Y3dXYjhyUDE0WnJVVndqb21SVXU2R1hQOEZGVGY4UVFp?=
 =?utf-8?B?Y01DZFlubjRGSElXSjNoT3BDdTJOVmxkaFRXbHA4dXc0emJDeGNlQjVnb2xz?=
 =?utf-8?B?a0d1Ukt3aVZrMU5FS2dpZE5ibXVXN2tGUEJxRzZWSHU1dnBEeEFNL2pleE5k?=
 =?utf-8?B?NmVVRWx1akhvTWpYU0JQRlFENFBGbGR2UUdPSHZFSGZHU0lqS2dZM21FczFj?=
 =?utf-8?B?bVZsNHVtdklzK3kzSHgvMEVxeTYxS0RqZXVneVUwSmU5K2VkRzZtYmszSk9v?=
 =?utf-8?B?KytaMnpZb0U4eU1pd3VZTUs5VFpoblppb25WWGlscVZ3SmY4a0VaUG5iZTZU?=
 =?utf-8?B?Mk5sSi85ZDB1RUxnSEZwTkdXS3lPdVpJL2k0REtCNy9iOVNoTkdiTlliNm9q?=
 =?utf-8?B?NXoySHBpZVR0VUxiZzNPVE9nZTlYb3JTT0VPcm52N3pncHZmajB6dkVaQXZq?=
 =?utf-8?B?MCs3cmI4MGtXbjh3WDhxa0IrTVh4Q09pWVJnOEdCUEVmZXF3bUF0RkVzdFhi?=
 =?utf-8?B?LzFZTWp3cTRiRWxKeFBTZ2svTkppTkt5ck1EdGRlakdvdjZRcHd4Z0lZRkJZ?=
 =?utf-8?B?eW8yTDRHc2ZNend4NWRqWG1pemF6dmN4UVpNdTV2Q05rYW1NejA3NFJ4N2ZQ?=
 =?utf-8?B?Vi9CbzVFV2V1Yis1b1JsOHFyRFovV0lHNnZ6dUN4V0kyNW9CM3NQa0FXdUpO?=
 =?utf-8?B?c0h4Nzg4eXlmNEh6aDQ3UmloQ0cvc2gwTnVHMXJseExjQVlOdmhNbXJaNERB?=
 =?utf-8?Q?BY5b/wL95lPTqbORQ2CHqu+6vH/tniVFwa6O8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86efaf83-a137-4a65-b12c-08d97355bff4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 05:50:38.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVt6yqUTXadtRpXGojT7wHO3QqdCWj5v/dA6vY7LAP6nc23WKUJUKvA50r/VGy9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4901
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Cp2GAwIoW7ENyIJikDjMPp4eug61mz6Z
X-Proofpoint-ORIG-GUID: Cp2GAwIoW7ENyIJikDjMPp4eug61mz6Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_01:2021-09-07,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109090033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/8/21 4:33 PM, Jason Gunthorpe wrote:
> On Wed, Sep 08, 2021 at 12:11:54PM -0700, Yonghong Song wrote:
>>
>>
>> On 9/8/21 11:49 AM, Jason Gunthorpe wrote:
>>> On Wed, Sep 08, 2021 at 06:30:52PM +0000, Liam Howlett wrote:
>>>
>>>>    /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
>>>> -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>>>> +struct vm_area_struct *find_vma_non_owner(struct mm_struct *mm,
>>>> +					 unsigned long addr)
>>>>    {
>>>>    	struct rb_node *rb_node;
>>>>    	struct vm_area_struct *vma;
>>>> -	mmap_assert_locked(mm);
>>>> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>>>>    	/* Check the cache first. */
>>>>    	vma = vmacache_find(mm, addr);
>>>>    	if (likely(vma))
>>>> @@ -2325,6 +2326,11 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>>>>    	return vma;
>>>>    }
>>>> +struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>>>> +{
>>>> +	lockdep_assert_held(&mm->mmap_lock);
>>>> +	return find_vma_non_owner(mm, addr);
>>>> +}
>>>>    EXPORT_SYMBOL(find_vma);
>>>>    /*
>>>>
>>>>
>>>> Although this leaks more into the mm API and was referred to as ugly
>>>> previously, it does provide a working solution and still maintains the
>>>> same level of checking.
>>>
>>> I think it is no better than before.
>>>
>>> The solution must be to not break lockdep in the BPF side. If Peter's
>>> reworked algorithm is not OK then BPF should drop/acquire the lockdep
>>> when it punts the unlock to the WQ.
>>
>> The current warning is triggered by bpf calling find_vma().
> 
> Yes, but that is because the lockdep has already been dropped.
> 
> It looks to me like it basically does this:
> 
>          mmap_read_trylock_non_owner(current->mm)
> 
>          vma = find_vma(current->mm, ips[i]);
> 
>          if (!work) {
>                  mmap_read_unlock_non_owner(current->mm);
>          } else {
>                  work->mm = current->mm;
>                  irq_work_queue(&work->irq_work);
> 
> 
> And the only reason for this lockdep madness is because the
> irq_work_queue() does:
> 
> static void do_up_read(struct irq_work *entry)
> {
>          struct stack_map_irq_work *work;
> 
>          if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
>                  return;
> 
>          work = container_of(entry, struct stack_map_irq_work, irq_work);
>          mmap_read_unlock_non_owner(work->mm);
> }
> 
> 
> This is all about deferring the unlock to outside an IRQ context. The
> lockdep ownership is transfered from the IRQ to the work, which is
> something that we don't usually do or model in lockdep.
> 
> Lockdep complains with the straightforward code because exiting an IRQ
> with locks held is illegal.
> 
> The saner version is more like:
> 
>          mmap_read_trylock(current->mm)
> 
>          vma = find_vma(current->mm, ips[i]);
> 
>          if (!work) {
>                  mmap_read_unlock(current->mm);
>          } else {
>                  work->mm = current->mm;
>                  <tell lockdep we really do mean to return with
> 		 the lock held>
>                  rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
>                  irq_work_queue(&work->irq_work);
> 
> 
> do_up_read():
>         <tell lockdep the lock was already released from the map>
>         mmap_read_unlock_non_owner(work->mm);
> 
> ie properly model in lockdep that ownership moves from the IRQ to the
> work. At least we don't corrupt the core mm code with this insanity.

Thanks for the suggestion! I verified the above change indeed work.
Will send v4 soon.

> 
> Jason
> 
