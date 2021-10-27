Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFBB43C0BA
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 05:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhJ0DVN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 23:21:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232200AbhJ0DVM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 23:21:12 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19R1APp1003377;
        Tue, 26 Oct 2021 20:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=a7XPRpO6nx8/dxwTjvAztwdockiIl9g4polC14bPAHU=;
 b=gCNt3iyW4vVfuKIrqOnpGEyosOj8NDmsQ5uitcctD/Pf7zN0gY3FjHrfVrikbpN+Wmm7
 VcEcHy2vLo3PRFehq48yBxozNbQ4En++w1UBUk1KOIddpnAp4Ah8VViVGSHqTlxXN4Iv
 JJQvrWnLfIwNVt/5EMZhu/iHvt+07KdYBaQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bxvv80hmu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Oct 2021 20:18:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 26 Oct 2021 20:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyF9+VV7ETBOOBimQJ/Lj/19iLcou2M5aqHXgPqDUZfW6NVfPwZa3df9w+W0Lsh2A+KSH2tziF+vgC1/gdLOzsBKimJVVv9xY6gg7d1FemS1QqrIs3oSXn+TLp6L/i6yrZpgWaHi/gaENL/wKLH3Tv7w8nsafqxgAyE3O2ZD+YoteJUaDGUZII0RWhjBoLWc1QZQ0C3Y6mMmpdqAgIjYhD4FqTRqvrdQo3cll5aHO/effzhjLgip596Bs9rQp3PLqCeR/rV58d4ajHBHqMavfsWAglPcMiem5NJa7Rry6vMy7X5y165/EccAXwHHlsnCEDFIOqnySUwnw9w0i9BSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7XPRpO6nx8/dxwTjvAztwdockiIl9g4polC14bPAHU=;
 b=gF8zk0ID/QFzgD/FHTV5h38QxvitwTCAfjzAoZc69USYsA90ak3OXQJcpk4lHryrX2EvFCLWbGAb4ushm+hAM9j9i+6PvD8ep295H58F4WyZpUSMY/kYohB7Ssd3KhTxWKdoTvcNOwccyT2Rtw5VqgHZJvsZgY6Ury76D2UJPAgyB/1OF2b2/H2e6r+iSTYlf8El+MAMUUFPrSF04tvl8cJtvEaqB/D6C54Xvn12ggTgnv8UcelDoQjJHYybCeIvDvCP5soKdfUWSs69wJxGjW8WUZmIzpDdIyfeX/YXaLNkM7+4Rpva7WYwcVfDGAR7A8JXBEjEiU8d9xdmm1fV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from MW3PR15MB3980.namprd15.prod.outlook.com (2603:10b6:303:48::23)
 by MW4PR15MB4778.namprd15.prod.outlook.com (2603:10b6:303:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 27 Oct
 2021 03:18:45 +0000
Received: from MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::517a:2932:62df:1075]) by MW3PR15MB3980.namprd15.prod.outlook.com
 ([fe80::517a:2932:62df:1075%3]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 03:18:45 +0000
Subject: Re: [PATCH v5 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, <andrii@kernel.org>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andriin@fb.com>
Message-ID: <086460a2-6213-2b1b-9368-166229a91847@fb.com>
Date:   Tue, 26 Oct 2021 20:18:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211022220249.2040337-2-joannekoong@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:303:87::15) To MW3PR15MB3980.namprd15.prod.outlook.com
 (2603:10b6:303:48::23)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:2103:b2:4e6a:72dd:1ddf] (2620:10d:c090:400::5:8f40) by MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 03:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a11f838a-7201-492c-afa1-08d998f87c45
X-MS-TrafficTypeDiagnostic: MW4PR15MB4778:
X-Microsoft-Antispam-PRVS: <MW4PR15MB477871D7E4511FB4B6DF7A90C6859@MW4PR15MB4778.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAMfObnBqaq3w8VYLY20bhhqKKWPD0sWAYjNXp0m59CfjHIzsSCfCCKK7o/dzRKolqxnCdAqAbpCt0EjBaxIv0e3ad8Jt1CpxCVaHqoJQ6O8qgjDujyK3FEwth37yC37BZ0Kg9toLTp8h8ZxpHTujODC5/RADCXuxTW5yWBGinRuRVuEHQv2bybgsoKWH/GfLWzrXlbuGOFC0MLxkscDizGS4ku8rGTMZ8cS1RXlpApBOwsxyzNuVJ6kGyjUK6UKScDWA7lxopJjWi80Fjt+15zd+B6/DChUAkAFrtxwAetHTYFMsRKhk80AO6jJJy/ZYtwhwBoQkR2U09v9uP3aezZoMtX//O9jqfERTwiv4TbiikZg+WGu4xmEpnbfbcJ0V5UAy/oiirnID3EGkSH7f8KZHsd2MsnGG4D060ODdURaxRXmj1UktvfedU0L3u/arqKioO3bSuxes/mKSHa/8hEY1zV5l8QT4JpkTomZh60TXK/pt8CNUV8hsgr89px34uX6xIuyQptz42duzbUwK4XVKK2Fkqc44pFUFFOUR5QrJMmh8+xd6X2D64+5oCPKg7b97fvKeD9VZutVJh6hS9a5JfE/LQEbMqt5N6jzMLwC9fXLVl0FxBzLwuIxGdHMmtHBap99zza/5HNUgZAH+CxEDuvx+cWaYJJ6Jh3dkawXjSgnsIBDTgiaPnn5zdSaP5QxJ3KbVgeHVUMIsSwpBnhRFyaXCTbcG9zz2iqh1msUqp73aI4yG2Mj3tJ1IPMa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3980.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(31686004)(2616005)(4326008)(86362001)(508600001)(316002)(31696002)(38100700002)(5660300002)(53546011)(83380400001)(36756003)(186003)(2906002)(66556008)(8936002)(66476007)(6486002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWY1UzlPcC9ITk5HUWxJenU1ZXpUUEwvUHR2RG9TUWFhWEovMEdnTmJiTWkz?=
 =?utf-8?B?aUNUWVZVNE5yWDkveUI0UWJiNEE2NitXaEs4QWVvYnFoOVFZbjVpRzhldUZj?=
 =?utf-8?B?dUM2YjBnSmxFRDVoM3pGWjRmNGNBcWM3Rk9yenVKc3RKNnVIVWFsd3VJcU5X?=
 =?utf-8?B?c0gzbXdoc3c1cW9pWnJ6cUkwdk1lNlNTdDFVamZjSTlvTSt6VG1RejFDUDNz?=
 =?utf-8?B?Z2R5QlNpbng5eThuRTZQNUxnWkRYWE5JUnEza3M2Tnk1RlFsTyttdkw2b3o3?=
 =?utf-8?B?T0FTcEJ1NXBGSXFsaWVSQ0RwZStaY3dVdWtjTGllaVhJQSsyd2t0VG5qTDFR?=
 =?utf-8?B?cFhmWHVDUmF5eW9MVXFIQjQ0ZmZobmF4bCtadTNDeGpSeEZKNDhPUFBnbXdt?=
 =?utf-8?B?aHpWcHBXZW1WTndYRVFhU2o0QlpudVhiQWFtbEZrdWlFajYxUWFsckpqZDAx?=
 =?utf-8?B?d3AzVWk5bTRKWTF0ODBYZ1FRT2svbGc0Q0pBVXZKQnZ5SzlMbGJhR0g0M0Ur?=
 =?utf-8?B?T1NtVW9Vc2JrbmtUeldkUkMxTjQ5Y0Z3Z2R5YnVicStuc3NvMGJJUTk2MTN1?=
 =?utf-8?B?VFRVbjJ6RU55dVBFR3RBa0t6dXZTS1dCd0g0NTI3TldhbDZ5OXIxMlY5ZCtP?=
 =?utf-8?B?ZEtyR1prVVdUOE43Vnh6VlZVTkVIcGdEV052Q25heFhCR3RnNmZib09Ta1p5?=
 =?utf-8?B?aGNkZWxyQkw4K0tPUG5NeVZwSzBtUHA5akNxZkVoM1RZcHpUa09FZ3Y1RGxX?=
 =?utf-8?B?dWtUMFJCWDU5bWlRTGhIWmY3OU1zTk5CeWU4WFcrVnc3Um1SRkpVS0FvN25B?=
 =?utf-8?B?dHFiTTZyQ0h0eGtlSUtjYVBkWS9sUnczSld2UnlsVk9mWlR6T3NPOEt4eEZl?=
 =?utf-8?B?UzVacXVHYTl0ZUxlVHYway9EQjFRUGdtaTYzYWVYMlNxN0p4K2JQVHBKQnA2?=
 =?utf-8?B?RUhteFMrRlNXNk9ySXNyV0FOZndNd2ZDRzMrM2hLYTR6MElFSmFRNGltVmVv?=
 =?utf-8?B?cE01aGo0dzJwSndzQVJtbXpDYzZXV25nUWwvNzhqeFVxNUJrL3MvN1pQWW5m?=
 =?utf-8?B?RTlMK295ZnZnSytQc0psckE4OEM5NkxUM1k4L3FNTkUxWllTTDBYQ3F5VENu?=
 =?utf-8?B?dVVhUGk1N01SYTQxaVFaOHRmQjU1WE5MMjBrVm9jRWZuWWdPbHVXTFV1STFQ?=
 =?utf-8?B?Q2FhWHc0SWtOQWtGSE1TbUtOR1pzaWduRU14RzduNUl1YWtkZnI5clhQNEh1?=
 =?utf-8?B?SGFsWVhEZXQxeldSOXRwNmNJZVplazMwdkdMRy93WWVYRjlmcEZ0MzhmQmNp?=
 =?utf-8?B?NmZEdWhmd1RWWWN4VVNuWUwrbXBRM2c3WFFjQW00YjczcTAwZXVER1QwbVRX?=
 =?utf-8?B?UHRYanlNVVVhbEFrQnE0NXVHRG96aDBHM05TVWFWYUxaNlpwWW5MZHB0YzZp?=
 =?utf-8?B?UHdXNHNUWUlUUlFIMkJjOWZwNVBFNEwvTWZrdU93UmlEVVMrVW9EajZhWmVO?=
 =?utf-8?B?S2c5UEpJVktLdEw1NmFaVFlnM1FTd1B0NGRlSE9qanNFU0lyc3lYejFDamlH?=
 =?utf-8?B?VldOckFxWFpTaWwwdDdrZjdDa0ltNFYxTU05L01uM3lyZkhhRE1sMVZFU1pL?=
 =?utf-8?B?SXdjTHJ3Z3hyL3hKa0FGTjhOQTRIK2dtU2hNQVdMcVNzczdhZXFkT2xtaGo3?=
 =?utf-8?B?L2h1NjU3R0Fwckh6TWhselB5bE9kK3pUM1F5TE5Id21ud1p2QS82MHNyTFRn?=
 =?utf-8?B?SExGWXorV0paTjhZRG54eU9Cd2RIMDM2VTd1b2gwUzMrRFZlcTltY2NONURB?=
 =?utf-8?B?enEvY1BRdkhVOEV4VFQvSFlKSFZPWFdmVWl1UUphblRWZDlhY2RqV3ZOSTdG?=
 =?utf-8?B?c01CTTdUejZkRGRiQkUyem91eWR5M2tFTjd3TlhEeG1oYkdUenE0R1dPeDR2?=
 =?utf-8?B?aXQydi9Hbng4bjhneTRMT3djQW9DTWF4cEtVWmFTZGxHcVhYMkZ2WDFnYzJ5?=
 =?utf-8?B?ZEJpYXNTa0pNeWsrNjlKbkQvM284T2dRRUg5UG1PVTU4Si9mQTZDVjJtUDdS?=
 =?utf-8?B?WFpkZ3NSZUErM0NyOUw5RERrQ091dzBTaVYyQWxrYzFZTmVqdVhWeVI5NHVR?=
 =?utf-8?B?d0lqQWpubGZGNGxjei83SHZwcjZGMUxBNDNYbjRpZUZ1SE5wQTRaZ2ZwcmdE?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a11f838a-7201-492c-afa1-08d998f87c45
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3980.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 03:18:45.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s41cqe/ndOF0v+DahkbcY/6uEViE0/gEc4Ysb8EclSXy7/Us+JfEHcgqrS/foKzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4778
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JeHT2Hp4w-dDbgzTMatUSpqcROuJU8ix
X-Proofpoint-ORIG-GUID: JeHT2Hp4w-dDbgzTMatUSpqcROuJU8ix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_07,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 10/22/21 3:02 PM, Joanne Koong wrote:
> This patch adds the kernel-side changes for the implementation of
> a bpf bloom filter map.
>
> The bloom filter map supports peek (determining whether an element
> is present in the map) and push (adding an element to the map)
> operations.These operations are exposed to userspace applications
> through the already existing syscalls in the following way:
>
> BPF_MAP_LOOKUP_ELEM -> peek
> BPF_MAP_UPDATE_ELEM -> push
>
> The bloom filter map does not have keys, only values. In light of
> this, the bloom filter map's API matches that of queue stack maps:
> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> APIs to query or add an element to the bloom filter map. When the
> bloom filter map is created, it must be created with a key_size of 0.
>
> For updates, the user will pass in the element to add to the map
> as the value, with a NULL key. For lookups, the user will pass in the
> element to query in the map as the value, with a NULL key. In the
> verifier layer, this requires us to modify the argument type of
> a bloom filter's BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE;
> as well, in the syscall layer, we need to copy over the user value
> so that in bpf_map_peek_elem, we know which specific value to query.
>
> A few things to please take note of:
>   * If there are any concurrent lookups + updates, the user is
> responsible for synchronizing this to ensure no false negative lookups
> occur.
>   * The number of hashes to use for the bloom filter is configurable from
> userspace. If no number is specified, the default used will be 5 hash
> functions. The benchmarks later in this patchset can help compare the
> performance of using different number of hashes on different entry
> sizes. In general, using more hashes decreases both the false positive
> rate and the speed of a lookup.
>   * Deleting an element in the bloom filter map is not supported.
>   * The bloom filter map may be used as an inner map.
>   * The "max_entries" size that is specified at map creation time is used
> to approximate a reasonable bitmap size for the bloom filter, and is not
> otherwise strictly enforced. If the user wishes to insert more entries
> into the bloom filter than "max_entries", they may do so but they should
> be aware that this may lead to a higher false positive rate.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---


Apart from few minor comments below and the stuff that Martin mentioned, 
LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>   include/linux/bpf.h            |   2 +
>   include/linux/bpf_types.h      |   1 +
>   include/uapi/linux/bpf.h       |   8 ++
>   kernel/bpf/Makefile            |   2 +-
>   kernel/bpf/bloom_filter.c      | 198 +++++++++++++++++++++++++++++++++
>   kernel/bpf/syscall.c           |  19 +++-
>   kernel/bpf/verifier.c          |  19 +++-
>   tools/include/uapi/linux/bpf.h |   8 ++
>   8 files changed, 250 insertions(+), 7 deletions(-)
>   create mode 100644 kernel/bpf/bloom_filter.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 31421c74ba08..953d23740ecc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -193,6 +193,8 @@ struct bpf_map {
>   	struct work_struct work;
>   	struct mutex freeze_mutex;
>   	u64 writecnt; /* writable mmap cnt; protected by freeze_mutex */
> +
> +	u64 map_extra; /* any per-map-type extra fields */


It's minor, but given this is a read-only value, it makes more sense to 
put it after map_flags so that it doesn't share a cache line with a 
refcounting and mutex fields


>   };
>   
>   static inline bool map_value_has_spin_lock(const struct bpf_map *map)
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 9c81724e4b98..c4424ac2fa02 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -125,6 +125,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STACK, stack_map_ops)
>   BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
>   #endif
>   BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>   
>   BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>   BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c10820037883..66827b93f548 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -906,6 +906,7 @@ enum bpf_map_type {
>   	BPF_MAP_TYPE_RINGBUF,
>   	BPF_MAP_TYPE_INODE_STORAGE,
>   	BPF_MAP_TYPE_TASK_STORAGE,
> +	BPF_MAP_TYPE_BLOOM_FILTER,
>   };
>   
>   /* Note that tracing related programs such as
> @@ -1252,6 +1253,12 @@ struct bpf_stack_build_id {
>   
>   #define BPF_OBJ_NAME_LEN 16U
>   
> +/* map_extra flags
> + *
> + * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the number of hash
> + * functions (if 0, the bloom filter will default to using 5 hash functions).
> + */
> +


This comment makes more sense right before map_extra field below. I 
noticed it only accidentally.


>   union bpf_attr {
>   	struct { /* anonymous struct used by BPF_MAP_CREATE command */
>   		__u32	map_type;	/* one of enum bpf_map_type */
> @@ -1274,6 +1281,7 @@ union bpf_attr {
>   						   * struct stored as the
>   						   * map value
>   						   */
> +		__u64	map_extra;	/* any per-map-type extra fields */
>   	};
>   
>   	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */


[...]

