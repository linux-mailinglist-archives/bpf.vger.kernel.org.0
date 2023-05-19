Return-Path: <bpf+bounces-949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615B5708F8E
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 07:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0371B1C21233
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 05:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A865C;
	Fri, 19 May 2023 05:46:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAC7C
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 05:46:10 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6710CE
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 22:46:07 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34J040Qo024166;
	Thu, 18 May 2023 22:46:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=VZ34/yQZOOXr3oFYpx43qng8SGDVKDgDrcQc3B2KeL0=;
 b=fMupqYpP8tYUqwYiNgDG+6LkkeLIUrCGr2zCRL9IELHvCuN5eInSY5rr80q5JkKuVdeF
 ET0z9qwTzlziSP3iItAJ5Yo7gCvXjn9+cqQvHfdpH1jrtWSHbTwORMwmcir46XYSErBr
 qr5551ppSiAyFWK1klapMG9mGY3srHzVd7b3jMaSqzdF4/FrlyXvP5WI5+UX47cDA/C5
 9mgxiVmJQvvOSV78Ckd4fb3ejq9luFBX8gLmhMgd89/9dbu1z9xEbJ0wajnYQ99gNpm2
 oWoM3TezBA3Bb2LwhOxCFkuW6YXP0c+aV224PZ8CnnZmxnqOm6j14TmSnKLphsA8eeZB BA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qnhe96ypa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 May 2023 22:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGkIqWhTH1tvCAH33T1J3gVSfjVOHhUTciaok9L0gX7S0CVnhLmmxXn9jgMJsoAEyiLuZEq1Mav6l+5hyIf50QuvpusD/nYO8xwJiwr8Zg/nYV2pLMoszggq4erLQoMpFdIoyGDyhmEf4sV4ETlwwJfXtW/wZXRV0bbQg9crTgEy26uRIZeKBo/aXsTr37d3J1kJS3i/BXCZByCHh7qwJJ2ZqgQ+59rewdEDuThtAT9yVLfQotjAEPvfhtm7YxXUjuBQ9jQb2lxv23Hvv3QcwpsVhZpVbDPJOqv96W0zMLK/gqvT9V/FhWKwFK+ROxk+BtDz2SC/9G3ZzbCIue094g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ34/yQZOOXr3oFYpx43qng8SGDVKDgDrcQc3B2KeL0=;
 b=UVkO9D3GUAhheuWxsX8aQpHQg/Qn7P2KvxI9j1actA0nXHey9GipcA8xMglpIE2ygjZdznmdSe3aVgKG88X/tLbFT+hSUzBCQjdO0lSVN+bZp+pXtgXaoAzbubu7+muhOHxKjuQ6meDmfj0ptigxMsyEVCcsVxPacoKUrOjlnhb9QkoeN+jaxKPpIATVc3nNptR4+BbjLwPuao5Z1J7Rn16/IQ+MgNtisT2+hMOBYk3BnnOdWlxxg8xeqVoVqBOSKL3Ku6AsILodFrHnim2TIZmK1K83yzu5E79fg0KT+6E8T7ri4oid0Gwym4/hYWf4LJqVPf3trCWFoDFz6ShC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4544.namprd15.prod.outlook.com (2603:10b6:510:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 05:46:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 05:46:01 +0000
Message-ID: <2fb9b408-0791-4a33-bd0f-298703c740c5@meta.com>
Date: Thu, 18 May 2023 22:45:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v8 bpf-next 01/10] bpf: tcp: Avoid taking fast sock lock
 in iterator
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: bpf@vger.kernel.org, kafai@fb.com, sdf@google.com
References: <20230517175458.527970-1-aditi.ghag@isovalent.com>
 <66d39520-d85c-834b-22b3-0cf7a1a45aaf@meta.com>
 <CC590F34-1A80-41D2-87BA-9247910D0434@isovalent.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CC590F34-1A80-41D2-87BA-9247910D0434@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 41493d44-fb33-48d5-68de-08db582c53f7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fKbDvd36nX0xB3jT4ZYyRmmAzAebfmi6zDsPpLoLLgGhXcOdtvZU295lLBIXgggb51DPfSDEZ29dg4t+whw7RtuRZAH5up3nhzR8qThoNND6zZyHwjk1gz55ouKr8JwZ3NmBA09IQgg3KHt4z0LBdDH1SISbFl8BERyfkYBOYVwqkjXB4NaPRa5uAMlZ/3drCbvC9Z2rkFBav45YDn1HUtrCY8Va8ek1Mt/kIzsuZOCXHHjNMnAKGukRrL0YhBrIc3YZjgojNhZ5B7KpX+qFJu07i6/Y687fH9BIEyrPMaQNkZ5YqxroFwNB5gjwVP+lwp2w9cqDCA08ntbF2HJhY7bx2XMZqq4TEf7/zHKn8/7tzP1q/nDOF1z4jkGfvbKHLrW4502p1oCJovJLVDG26hOAA9CzQFbClpmWF3CDLFai1slqt6pXsZ8HgecQLc02DNQT2bMTU2l/CAQjZcr6QajOUNrT6TgH81GEhKOZxoKYImZD+EI1w/vjz+2LA3xEpFQUFqbAcv+W5sZCD4R6urfHE/1QvtLDrf7JmrKoqzkMv2B72hgKe6vvey0NHAG2tssuHcCp6g2OSI0Zc/kxEtLrt04yUlgjdzKkUzwCXDQJy0+cIWupfx0HgOXonlc3zHNJJEJmpVXat7dxkCxHDw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(2906002)(316002)(478600001)(30864003)(41300700001)(4326008)(8676002)(6916009)(31686004)(8936002)(6486002)(5660300002)(6666004)(45080400002)(66556008)(66946007)(66476007)(53546011)(966005)(6506007)(6512007)(38100700002)(186003)(83380400001)(36756003)(2616005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZnZtQW91SjV4akFLNGtiRDRySisvVVMrV3EzNVd4Zk1iNjBzNDg4R0lyd3A5?=
 =?utf-8?B?dGxQVlNMMDEwSnVsTmJqK2NvbEk5TTB3WnYzcUJnZGg0WndGYjZ1cFBHQ3RK?=
 =?utf-8?B?a1V4b2pOZTNEUjBteVVEUTRkQnJOZXlsZjhlYWdRUXJUZjhjTExCZUM4SHJo?=
 =?utf-8?B?bEpadEc5M0hlcld1TmRETjNYK3A5QVNyekVSdUNyZTdCODZ5SERMdFhBUC9j?=
 =?utf-8?B?eWt2UUkvSzBOa01INERzRHorajJYeXFZMiszRGNnSW0yc1IxUTFwVkJhaUZx?=
 =?utf-8?B?MG4wMk5yVTgwcWNPUHIzOEllS1g0TzJuUHpTOGQ3T1hES0tGWGV3SCtsaDc2?=
 =?utf-8?B?L1JZVFlUTnlld3dlYUtwVno0U1k2OXZUaHJPSHZhWkVOZ3F1WG5jQU1BVXB2?=
 =?utf-8?B?QWRZeGVsN2tMRFhRRGpnV2lydkxuSWxEY21zMlQ4cXRoVDlYZzYzRjg1QnlH?=
 =?utf-8?B?MUNkMG53QnpqMWpCOEJMNnlsei9RbUhlWURrRHE0SjBkZ0s4SW9scWxxK25G?=
 =?utf-8?B?djZsWUFjWmErYXJZN0VkMHlZZlQ1OTNydkJSZURzMzdMOXdnS3hjUDU4NXdB?=
 =?utf-8?B?UEx4VzJRV3F3Q2RGenQ2UjRVWCtNYjdsZnJVQ1NjbnNmcHg1aENSbHZqMVdK?=
 =?utf-8?B?aXpjcyt0TzE1dUdRcXRSTDN0WC9mby9uQ2x3SG0xZ0l2S3F0eFRCdDNObkRj?=
 =?utf-8?B?cEladFNaWG5yNjVQRVZpb01JSkU0L2ZmS1JQWGgyLzdzbVNFckVxTlcxVysx?=
 =?utf-8?B?czVSVk54N1J0WDFMbkdPa2kwdW5sdFZaaHA0Z1pKQUJCaElMSU83Q3VTZ3hQ?=
 =?utf-8?B?Y0RrN2Iwc1pFUzIwUUhPOHVGeGtHVFp4bkQydEtOeVhsVWRoYm5LWFVnVzhk?=
 =?utf-8?B?WmhDeUJrTEg2d1ozbDVLdnl6R0h2SDJyS2RadG04dWhKaFdZcE9iY3psTlQw?=
 =?utf-8?B?K0xHOU11b2gyNXFhVTczYjd6U0xWY1U2WFZHdE4xMHVMZHNJdkFLMlNlSEpB?=
 =?utf-8?B?cmhQQzF5K01Hd1kydkZEWUZFNjZLWGl3amN2MlRKVzRFdlQrSGM1ZS9yTk9n?=
 =?utf-8?B?Z25SSkVFVWRWa1A2S0VLdzNHVExlRHFxTVl6d3ZJWVp2UmpYU1RyTWtsemNG?=
 =?utf-8?B?YkNqWTVNbTQ4cUlqUFAwWnVselZFT2tlcTdWSFpKZjV6ajc4RTh3bWdXbUF4?=
 =?utf-8?B?SUM2MjVscnI2M3pVTWpPNmYrUktDcSsyczZaaUVDbXlHQTgybGxRb3NYcXBR?=
 =?utf-8?B?WFF0eE1KUFpMMHRMMGphY2toa01BY3hhalIreEsxOXNHaGNETCt3UUN6Rjkw?=
 =?utf-8?B?ZzZpajNEbGFvaXpsNURPMHFLSDM2UGM3eXNuSVc2YUpzbVA2T3IxTnNkRE93?=
 =?utf-8?B?Tmg1QStibUpaSGg3OHF5SU1IWnFKejQwUHFWSUdOYk9xT3dLc1FYOGtwNFgw?=
 =?utf-8?B?akJNWURreUhJTTh1eEdrM2pkbjM2Q1JyWDlwK3VQRnlTWUZHdHFFc2NZM2JY?=
 =?utf-8?B?R3hTUXZTYS9DMzArMEc1VzRFUzZBSlVyMTFjVUVaTlZyZTI3c3h3SzdSTm5U?=
 =?utf-8?B?czlIbTcvNnQ1UEplb09TR3hCLzBqa1pqaTQwMVp6Qk13QkdQY2s1T01yM2tD?=
 =?utf-8?B?L1ErVlRObFN4by8zWVc0YTBEemQ3Q0xNUWRCdi9SNm8rV3BLSGY3YVNIc1lE?=
 =?utf-8?B?YWFuZ1pYN3ZKY2VuWHhudC95RlhtVml5VENEdzRxcVBjTXBjT0FEaVZLMkNT?=
 =?utf-8?B?clRmZkxaWXF5MmZYdGdibXpXNWhBMjhyVDBLNEFGcERhVDM1VitDbUtleEdo?=
 =?utf-8?B?c0VsWjVxamZIQXBibW9WTE4vMEhNVHpUNFZ2aWZiWkpDZlVUd2d2RWZ1dmJn?=
 =?utf-8?B?dDNJUHg0V0pEWWpCOFpOUm42N2VtTHllK1p1MkJ5Sm1OLzN1RUN1bU5lL1lP?=
 =?utf-8?B?Q0R6L09xbmM3NDZQcVp5cmJXc2UzUy95MUFaNDhnNCtjOEViTVFzTjBxZzly?=
 =?utf-8?B?OTZ6Y0wxcFM1Y243K0dGdFZzbDFSY2RLRmcwS0N4RW5kbG91Z3RpM3pSc1ZM?=
 =?utf-8?B?aU53cTh4alJneTA2ZjFjcVI2TFcralVZaWtvOEtYdnBFbXFBOWV6WlUyQjR0?=
 =?utf-8?B?eWJIVUVJdVB6OVpYbjhLeFJBcHZ3cXU0ZGVvZGJ2YVE1Q3c1Tks2UkgyV0Q3?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41493d44-fb33-48d5-68de-08db582c53f7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 05:46:01.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3as8dD5kvcuPDsYsT9kiW0KAd55gYqRlr+KPm31Z+27C8kRx0rPtRJ8g2eL3TkWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4544
X-Proofpoint-GUID: 6WT3dQ4WYHRh2XTwDUPdw1oax6foLOBF
X-Proofpoint-ORIG-GUID: 6WT3dQ4WYHRh2XTwDUPdw1oax6foLOBF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_02,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/18/23 4:04 PM, Aditi Ghag wrote:
> 
> 
>> On May 18, 2023, at 11:57 AM, Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 5/17/23 10:54 AM, Aditi Ghag wrote:
>>> This is a preparatory commit to replace `lock_sock_fast` with
>>> `lock_sock`, and faciliate BPF programs executed from the iterator to be
>>
>> facilitate
> 
> Yikes! I'll fix the typos.
> 
>>
>>> able to destroy TCP listening sockets using the bpf_sock_destroy kfunc
>>> (implemened in follow-up commits).  Previously, BPF TCP iterator was
>>
>> implemented
>>
>>> acquiring the sock lock with BH disabled. This led to scenarios where
>>> the sockets hash table bucket lock can be acquired with BH enabled in
>>> some context versus disabled in other, and  caused a
>>> <softirq-safe> -> <softirq-unsafe> dependency with the sock lock.
>>
>> For 'and caused a <softirq-safe> -> <softirq-unsafe> dependency with
>> the sock lock', maybe can be rephrased like below:
>>
>> In such situation, kernel issued an warning since it thinks that
>> in the BH enabled path the same bucket lock *might* be acquired again
>> in the softirq context (BH disabled), which will lead to a potential
>> dead lock.
> 
> 
> Hi Yonghong, I thought about this a bit more before posting the patch series. My reading of the splat was that the deadlock scenario that was specifically highlighted was with respect to the pair of bucket and sock locks.
> 
> As for the bucket lock, there might a deadlock scenario with a set of events such as:
>   1) Bucket lock is acquired with BH enabled in a process context  (e.g., __inet_hash below called from process context)
>   2) the process context was interrupted before the lock was released by...
>   3) Another context with BH disabled (e.g., sock_destroy called for listening socket from iterator) tries to acquire the same lock again
> 
> contd...
> 
>>
>> Note that in this particular triggering, the local_bh_disable()
>> happens in process context, so the warning is a false alarm.
> 
> 
> Right, the sock_destroy program is run from the iterator as opposed to BPF programs being executed on kernel events. However, my understanding is that because local_bh_disable is called, the lock dep validator treats it as an irq-safe context.
> 
> Based on my reading of the documentation [1], there can be a deadlock issue with the bucket lock by itself (ref: Single-lock state rules), or deadlock issue with the pair of bucket and sock locks that the splat highlights (ref: Multi-lock dependency rules).
> 
> Let me know if this makes sense, or I'm missing something.
> 
> 
> [1] https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst
> 
> 
> -------- Posting a snippet of the splat again just for reference  --------
> 
> [    1.544410] which would create a new lock dependency:
> [    1.544797]  (slock-AF_INET6){+.-.}-{2:2} -> (&h->lhash2[i].lock){+.+.}-{2:2}
> [    1.545361]
> [    1.545361] but this new dependency connects a SOFTIRQ-irq-safe lock:
> [    1.545961]  (slock-AF_INET6){+.-.}-{2:2}
> [    1.545963]
> [    1.545963] ... which became SOFTIRQ-irq-safe at:
> [    1.546745]   lock_acquire+0xcd/0x330
> [    1.547033]   _raw_spin_lock+0x33/0x40
> [    1.547325]   sk_clone_lock+0x146/0x520
> [    1.547623]   inet_csk_clone_lock+0x1b/0x110
> [    1.547960]   tcp_create_openreq_child+0x22/0x3f0
> [    1.548327]   tcp_v6_syn_recv_sock+0x96/0x940
> [    1.548672]   tcp_check_req+0x13f/0x640
> [    1.548977]   tcp_v6_rcv+0xa62/0xe80
> [    1.549258]   ip6_protocol_deliver_rcu+0x78/0x590
> [    1.549621]   ip6_input_finish+0x72/0x140
> [    1.549931]   __netif_receive_skb_one_core+0x63/0xa0
> [    1.550313]   process_backlog+0x79/0x260
> [    1.550619]   __napi_poll.constprop.0+0x27/0x170
> [    1.550976]   net_rx_action+0x14a/0x2a0
> [    1.551272]   __do_softirq+0x165/0x510
> [    1.551563]   do_softirq+0xcd/0x100
> [    1.551836]   __local_bh_enable_ip+0xcc/0xf0
> [    1.552168]   ip6_finish_output2+0x27c/0xb10
> [    1.552500]   ip6_finish_output+0x274/0x510
> [    1.552823]   ip6_xmit+0x319/0x9b0
> [    1.553095]   inet6_csk_xmit+0x12b/0x2b0
> [    1.553398]   __tcp_transmit_skb+0x543/0xc30
> [    1.553731]   tcp_rcv_state_process+0x362/0x1180
> [    1.554088]   tcp_v6_do_rcv+0x10f/0x540
> [    1.554387]   __release_sock+0x6a/0xe0
> [    1.554679]   release_sock+0x2f/0xb0
> [    1.554957]   __inet_stream_connect+0x1ac/0x3a0
> [    1.555308]   inet_stream_connect+0x3b/0x60
> [    1.555632]   __sys_connect+0xa3/0xd0
> [    1.555915]   __x64_sys_connect+0x18/0x20
> [    1.556222]   do_syscall_64+0x3c/0x90
> [    1.556510]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [    1.556909]
> [    1.556909] to a SOFTIRQ-irq-unsafe lock:
> [    1.557326]  (&h->lhash2[i].lock){+.+.}-{2:2}
> [    1.557329]
> [    1.557329] ... which became SOFTIRQ-irq-unsafe at:
> [    1.558148] ...
> [    1.558149]   lock_acquire+0xcd/0x330
> [    1.558579]   _raw_spin_lock+0x33/0x40
> [    1.558874]   __inet_hash+0x4b/0x210
> [    1.559154]   inet_csk_listen_start+0xe6/0x100
> [    1.559503]   inet_listen+0x95/0x1d0
> [    1.559782]   __sys_listen+0x69/0xb0
> [    1.560063]   __x64_sys_listen+0x14/0x20
> [    1.560365]   do_syscall_64+0x3c/0x90
> [    1.560652]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [    1.561052] other info that might help us debug this:
> [    1.561052]
> 
> 
> [    1.561658]  Possible interrupt unsafe locking scenario:
> [    1.561658]
> [    1.562171]        CPU0                    CPU1
> [    1.562521]        ----                    ----
> [    1.562870]   lock(&h->lhash2[i].lock);
> [    1.563167]                                local_irq_disable();
> [    1.563618]                                lock(slock-AF_INET6);
> [    1.564076]                                lock(&h->lhash2[i].lock);
> [    1.564558]   <Interrupt>
> [    1.564763]     lock(slock-AF_INET6);
> [    1.565053]
> [    1.565053]  *** DEADLOCK ***
> 
>>
>>> Here is a snippet of annotated stack trace that motivated this change:
>>> ```
>>> Possible interrupt unsafe locking scenario:
>>>        CPU0                    CPU1
>>>        ----                    ----
>>>   lock(&h->lhash2[i].lock);
>>>                                local_irq_disable();
>>>                                lock(slock-AF_INET6);
>>>                                lock(&h->lhash2[i].lock);
>>
>>                                  local_bh_disable();
>>                                  lock(&h->lhash2[i].lock);
>>
>>>   <Interrupt>
>>>     lock(slock-AF_INET6);
>>> *** DEADLOCK ***
>> Replace the above with below:
>>
>> kernel imagined possible scenario:
>>     local_bh_disable();  /* Possible softirq */
>>     lock(&h->lhash2[i].lock);
>> *** Potential Deadlock ***

I applied the whole patch set (v8) locally except Patch 1, running
selftest and hit a different warning:

   ...
   [  168.780736] watchdog: BUG: soft lockup - CPU#0 stuck for 86s! 
[test_progs:2331]
   [  168.781385] Modules linked in: bpf_testmod(OE)
   [  168.781751] CPU: 0 PID: 2331 Comm: test_progs Tainted: G 
OEL     6.4.0-rc1-00336-g2fa1ad98e6e8-dirty #258
   [  168.782570] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
   [  168.783457] RIP: 0010:queued_spin_lock_slowpath+0xd8/0x500
   [  168.783904] Code: 00 ff ff 44 23 33 45 09 fe 48 8d 7c 24 04 e8 0f 
54 ca fe 44 89 74 24 04 41 81 fe 00 01 00 00 73 28 45 85 f6 75 04 eb 0f 
f3 90 <48> 89 df e8 d0 51 ca fe 80 3b 00 6
   [  168.785503] RSP: 0018:ffff888114557c00 EFLAGS: 00000202
   [  168.785964] RAX: 0000000000000000 RBX: ffff888113fd0a98 RCX: 
ffffffff827c84a0
   [  168.786576] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: 
ffff888113fd0a98
   [  168.787192] RBP: 0000000000000000 R08: dffffc0000000000 R09: 
ffffed10227fa154
   [  168.787837] R10: 0000000000000000 R11: dffffc0000000001 R12: 
ffff888113fd0a98
   [  168.788505] R13: 0000000000000002 R14: 0000000000000001 R15: 
0000000000000000
   [  168.789119] FS:  00007fc34f075500(0000) GS:ffff8881f7400000(0000) 
knlGS:0000000000000000
   [  168.789804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   [  168.790306] CR2: 0000559382dd9057 CR3: 0000000102ab8004 CR4: 
0000000000370ef0
   [  168.790976] Call Trace:
   [  168.791218]  <TASK>
   [  168.791434]  _raw_spin_lock+0x84/0x90
   [  168.791785]  tcp_abort+0x13c/0x1f0
   [  168.792125]  bpf_prog_88539c5453a9dd47_iter_tcp6_client+0x82/0x89
   [  168.792701]  bpf_iter_run_prog+0x1aa/0x2c0
   [  168.793098]  ? preempt_count_sub+0x1c/0xd0
   [  168.793488]  ? from_kuid_munged+0x1c8/0x210
   [  168.793886]  bpf_iter_tcp_seq_show+0x14e/0x1b0
   [  168.794326]  bpf_seq_read+0x36c/0x6a0
   [  168.794686]  vfs_read+0x11b/0x440
   [  168.795024]  ksys_read+0x81/0xe0
   [  168.795341]  do_syscall_64+0x41/0x90
   [  168.795689]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
   [  168.796172] RIP: 0033:0x7fc34f25479c
   [  168.796514] Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 
e8 c9 fc ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 
0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 8
   [  168.798197] RSP: 002b:00007fffc299b5a0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
   [  168.798891] RAX: ffffffffffffffda RBX: 0000559382dc77f0 RCX: 
00007fc34f25479c
   [  168.799552] RDX: 0000000000000032 RSI: 00007fffc299b640 RDI: 
0000000000000019
   [  168.800213] RBP: 00007fffc299b690 R08: 0000000000000000 R09: 
00007fffc299b4a7
   [  168.800868] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000559382b2bf70
   [  168.801530] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
   [  168.802196]  </TASK>
The lockup seems true since no further progress of selftest since the 
above error/warning. So we hit a real deadlock here.

I did some analysis, the following is what could be happened:
    bpf_iter_tcp_seq_show
      lock_sock_fast
        __lock_sock_fast
          spin_lock_bh(&sk->sk_lock.slock);
    ...
    tcp_abort
      local_bh_disable();
      spin_lock(&((sk)->sk_lock.slock)); // from bh_lock_sock(sk)

So we have deadlock here for the sock.
With Patch 1, we use 'lock_sock', sock lock is not held, so there is no 
dead lock.
static inline void lock_sock(struct sock *sk)
{
         lock_sock_nested(sk, 0);
}
void lock_sock_nested(struct sock *sk, int subclass)
{
         /* The sk_lock has mutex_lock() semantics here. */
         mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);

         might_sleep();
         spin_lock_bh(&sk->sk_lock.slock);
         if (sock_owned_by_user_nocheck(sk))
                 __lock_sock(sk);
         sk->sk_lock.owned = 1;
         spin_unlock_bh(&sk->sk_lock.slock);
}
EXPORT_SYMBOL(lock_sock_nested);
void __lock_sock(struct sock *sk)
         __releases(&sk->sk_lock.slock)
         __acquires(&sk->sk_lock.slock)
{
         DEFINE_WAIT(wait);
         for (;;) {
                 prepare_to_wait_exclusive(&sk->sk_lock.wq, &wait,
                                         TASK_UNINTERRUPTIBLE);
                 spin_unlock_bh(&sk->sk_lock.slock);
                 schedule();
                 spin_lock_bh(&sk->sk_lock.slock);
                 if (!sock_owned_by_user(sk))
                         break;
         }
         finish_wait(&sk->sk_lock.wq, &wait);
}

The current stack trace and analysis likely from some of
previous versions of patch.

I suggest to rerun based on the latest patch set, collect
the warning message and resubmit Patch 1.

>>> process context:
>>> lock_acquire+0xcd/0x330
>>> _raw_spin_lock+0x33/0x40
>>> ------> Acquire (bucket) lhash2.lock with BH enabled
>>> __inet_hash+0x4b/0x210
>>> inet_csk_listen_start+0xe6/0x100
>>> inet_listen+0x95/0x1d0
>>> __sys_listen+0x69/0xb0
>>> __x64_sys_listen+0x14/0x20
>>> do_syscall_64+0x3c/0x90
>>> entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>> bpf_sock_destroy run from iterator in interrupt context:
>>> lock_acquire+0xcd/0x330
>>> _raw_spin_lock+0x33/0x40
>>> ------> Acquire (bucket) lhash2.lock with BH disabled
>>> inet_unhash+0x9a/0x110
>>> tcp_set_state+0x6a/0x210
>>> tcp_abort+0x10d/0x200
>>> bpf_prog_6793c5ca50c43c0d_iter_tcp6_server+0xa4/0xa9
>>> bpf_iter_run_prog+0x1ff/0x340
>>> ------> lock_sock_fast that acquires sock lock with BH disabled
>>> bpf_iter_tcp_seq_show+0xca/0x190
>>> bpf_seq_read+0x177/0x450
>>> ```
>>> Acked-by: Yonghong Song <yhs@meta.com>
>>> Acked-by: Stanislav Fomichev <sdf@google.com>
>>> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
>>> ---
>>>   net/ipv4/tcp_ipv4.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>>> index ea370afa70ed..f2d370a9450f 100644
>>> --- a/net/ipv4/tcp_ipv4.c
>>> +++ b/net/ipv4/tcp_ipv4.c
>>> @@ -2962,7 +2962,6 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>>>   	struct bpf_iter_meta meta;
>>>   	struct bpf_prog *prog;
>>>   	struct sock *sk = v;
>>> -	bool slow;
>>>   	uid_t uid;
>>>   	int ret;
>>>   @@ -2970,7 +2969,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>>>   		return 0;
>>>     	if (sk_fullsock(sk))
>>> -		slow = lock_sock_fast(sk);
>>> +		lock_sock(sk);
>>>     	if (unlikely(sk_unhashed(sk))) {
>>>   		ret = SEQ_SKIP;
>>> @@ -2994,7 +2993,7 @@ static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
>>>     unlock:
>>>   	if (sk_fullsock(sk))
>>> -		unlock_sock_fast(sk, slow);
>>> +		release_sock(sk);
>>>   	return ret;
>>>     }
> 

