Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B156374F0D
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 07:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhEFFyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 May 2021 01:54:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231172AbhEFFyQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 May 2021 01:54:16 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1465onpE021052;
        Wed, 5 May 2021 22:53:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aPDZtWq853TsGU3jUt7UizJ4xyj/aTs/Vb/IXxlfTGA=;
 b=Go8wb8BfSiRmTYVmA0gzwZVk23XqK+IhYVoZZRvgsQl20So6FQYEG3r0msYSw4dfzf6H
 eCvNGe0Ma+lOAR7P39cv9s1BihmoXVm3LeLyq6y4Fxp+jvcN2DH0y7El3qpPlTCzqELs
 ctzSp4kjsOe1YujLIO2zyEvTEq/1V95dkG8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 38bed201kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 22:53:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 22:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1Ffl4tNZhFwL7HcRZuqI0+7z0u6/9gSG8y4o5aWNOuiRLV7Xsw0e21oK5lFa137FapI2/V66XEncgoxNZVnwKk4GC0GP6WlUbb0nBp/Kp0ksWU6u+nhtUoYavcegTx6aqOmPp3LzZO4UYNxPsWdtLWCC7bcrkOZ5GictbZVn4hEkxq7GhIQDsB3e0jphZbwdo90kxnfOSE2mj57gwyM9j0didWUp05eVLMpar8WOWkVIiXX/t0oqvwrcn3SVhGT33EykTPkhUHkGfaMDWfgckXDssK5ZjQRc0Yr9DFkLuN8kIB9YuFcZfjdE0uXEKRzoszxdgUG+2hOzaMetYoGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPDZtWq853TsGU3jUt7UizJ4xyj/aTs/Vb/IXxlfTGA=;
 b=MP624uev5CN4UtXxLUr0XNpTNDbj4g6xBWc6Z/aT128LB+fnnPJP0emm1Tqw+fXohm914J0zlpl91/bby/qSrZe05xjsv7shGqjaEGqvm0Npe2rQ49UwLG2s1uAlRmIJIpOYOnroNxftWwMnDlIWRQmfeNvd3rjC6+9RLlgIYKvU4V1FuBDgAkVZezf5uuR7plT79iiOXvZVtARZMbLAvxQ5ZZPr97E5v1MhTt8fNCAKbCz+Tpi7JXnKYghZq4HfzF0IYnQLGNAGetnaDBimtwoxJGVAOsimqq/HhFCILyua5qTjWwyLdSObb++60oHUR6kzNMBQxqHSaROARliUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4642.namprd15.prod.outlook.com (2603:10b6:806:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 6 May
 2021 05:53:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 05:53:03 +0000
Subject: Re: [PATCH v6 bpf-next 1/3] bpf: add lookup_and_delete_elem support
 to hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>, <bpf@vger.kernel.org>
CC:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20210505094028.22079-1-denis.salopek@sartura.hr>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f4da4c98-081c-c43a-92ca-039855d81773@fb.com>
Date:   Wed, 5 May 2021 22:52:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210505094028.22079-1-denis.salopek@sartura.hr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ea17]
X-ClientProxiedBy: MWHPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:300:ee::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::13e3] (2620:10d:c090:400::5:ea17) by MWHPR04CA0031.namprd04.prod.outlook.com (2603:10b6:300:ee::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 05:53:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1f222ef-c614-4f33-1d00-08d91053369a
X-MS-TrafficTypeDiagnostic: SA1PR15MB4642:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4642C429D1953722D1181317D3589@SA1PR15MB4642.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZzaVQfJQZzgouPtuJft3hDvZLWqmD0hchphEIx8siredzKjF1lVXjVEYpyBUkJVteZ3c810xptb1ElbWPcAKILocAH7IXImaXwl2Sd31Ku8ldqPQpH/STdrm4LnZnd1Sp8Gb/ff/1HMDBM5ZoSGWbGEAxKwHzD2Bev0dl4isRN5hhmYGX8nXU/XhHWhj/tkP75RqX7sqfD+w1ZBCxnGS/bfAfOa7fCqf8E6mNtmwY1Z14M3gY/NFoo94rgNSX2VGwZ/T6/HfchGVukOEuc+fuYdmUoBNP+7NvZRXSf/+w6yK3fErouwXfzv/8mDgPskInMsCtYIa+kNZ913plvhb7ACOberUMg79L3ZJ5lTYv+gOy3ByKUy4VT0nYbYkpNr8LaLdHZYBOeYgqggiY60xq6UnYDn834toFZcgqlc/BNl6Z42znhS+oVFT0rZJ+fvaCBruCg/9WU16/eMkuAVqidkdoqKqeXt1W2Nb1uCE0GpTVfy177rjiSmCJr9ZKVsDa2Zd5t8qLwsLU8BWO25mQvd52y1F1s9vYIzjJsy14Jl8dEQJezyXf3r/t08aL3gLea7NucPQJsKbI6W/4m749CsQgzenhXfeHaMj5rllQyAira3m9BvXQo1P2Xz2pRRtcnCmS6Wqu578eUut+4mMxNY8lWLuGl7pyy12t/ANPdq291EgKbTarddTOZmFuEH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(66556008)(83380400001)(66476007)(66946007)(2906002)(31686004)(86362001)(4326008)(316002)(54906003)(31696002)(52116002)(36756003)(53546011)(5660300002)(6666004)(2616005)(8936002)(478600001)(8676002)(16526019)(38100700002)(6486002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWUrQVR0QWpLYStUUExwYzRJUUVNclRnaUIxT3R6WXhkZDZPZ2ZlbjJRd0Jm?=
 =?utf-8?B?ZlQ1RFlkTVBwejRRSUNWUExoNFZTTWU1NTRoa3NOaXFjQmdwRWEzTkJudVdu?=
 =?utf-8?B?MUJJL1FjbUJSTWJackJSRllxTFZwMHBRdEwycHhzVkZhQkpkNjQyS0cwUU5w?=
 =?utf-8?B?ZENrNi81K3pTeUlPaTNDODQ1YjYzd0RXT1F1NlFUcGhLMHoxemdhS0tjRm9B?=
 =?utf-8?B?LzdncUlGVWFQZ1JDWmhpbUNHOTlQeWo5cnJ3M3M3WDR4ZS9qVW5PZGVwenRG?=
 =?utf-8?B?dUk0YWRPTnVVOEk0cW8vTVZtQi9kLzZ6ZGpEVEkyQWNVRGFCMTdCMVhHQmY1?=
 =?utf-8?B?V0hDTWI2S2IvMjF5Si8veC9JczFZL3cwNndWMHdWb2NTQ0dndGZhWlBuTzhT?=
 =?utf-8?B?ZGo4NGJTSVh1SVArRy90TlMxdzM3RnJvNmpNdjc1K3BsbmRNSndDc3lTL2JL?=
 =?utf-8?B?WE9ma3c5VzM1dmZBaVhNdXVNYzhzdXZGcnN1YjRBbCtrSkFNVnRDKzZnbUdN?=
 =?utf-8?B?TW1POGJPUWlNMTRwcWlUYUEyK08wT3ZVL1A4NHFaa3NnSU80Nkg1b3pab29D?=
 =?utf-8?B?THhMclVtRkdIUXNUUTNsS0ZCVGtGZ2ZqdVdHWFo3QWtzdHZiQW9RZ0FMUVJn?=
 =?utf-8?B?Y3g5L2dmMWVvUnVHTmV1WnhIODAxZXc4M0k3UUZnTDhhb0I1elkveUp5dXZ1?=
 =?utf-8?B?WTVYQjNqcE9rRGhZVXQ4blNoN2ZzOEMyODFxM0RxbGhXYUtvVHV1a1VuY2JG?=
 =?utf-8?B?L2hOZ2VJNnlGd0dvSERvZjI0aVlNL2JIRkM0dkhVNXNTWlZ2WWJHN29OQ21O?=
 =?utf-8?B?eTl0Z0Rmc0psc3dIVUpYcGlzNnJaTnppQTAvMWRocWhnc00zQzdzYXd2c1B0?=
 =?utf-8?B?NmpOMDBHRGZyVFl4MXkvNjQ4Sm9LTk9yZzZNOUhXNjRNQmh3VnBUTHhYdlNV?=
 =?utf-8?B?MGdWQkJ0dVR5U3lpVXdwZGFJcUxkOUNmMXFHeXlVUDFKaUtDd2Zlais2RnFI?=
 =?utf-8?B?L3RzUDVuMVIvaVFoYTRza3g0eWVXejJkMUI4TGE4UjZTREkvaWh3eHNVbEZF?=
 =?utf-8?B?VGFhY3dvU3B4U2dnU3cwMFhaOTh6VThjTjdXTnJoSzlzR0k0Qk45ZzlLRFZY?=
 =?utf-8?B?VjZWYkw5ZzU1UTRaVUVsRWJmTnlXdWFnU2F0ZGFTZTJzV0pxa2YrSERQRWtl?=
 =?utf-8?B?NmY1WTRrWEFRNWN1eVpxODJFVy92VmFKRE8rbVZ4VmowaGpaaEFyUGRmTWIv?=
 =?utf-8?B?S3FRWTAyQVBncG5meWVkOUhIN3AvbWdsL0N5cWFTQmdSS01kdGswbVhuVm11?=
 =?utf-8?B?enhtRGE4aFBhdE1DVVMvZEdhS1d3SExFc1NsUGlOL2ZqRzdBY2tveDhRbXFM?=
 =?utf-8?B?TkM5aGNiQm9YUWROWG43aEVrUDM2QUxMUS9VTmVnWmFFU3MzUGxZZC9kU09o?=
 =?utf-8?B?OHo4ZU55YnRGaXdFOU1NbGRKb1R6L05pcHFjdzNjSXZnL3hjdW9ZNFVBOE5w?=
 =?utf-8?B?TTFYM0tzRnhGZExlb0lwT0huUG9zQlhqbGl0ZHU4dlVHei9sTGNVTFVoMktF?=
 =?utf-8?B?MXRVQXAva2xXTjhBeEVkTEl3N2FlbGxkRFM5UWp4dE1GeHgzRkllT1RBRldH?=
 =?utf-8?B?MWM1QVFEQllFZGgvakI3eEJzRGI0dHFXY1kydEpjMXFkd09OQXRpemlNc1JE?=
 =?utf-8?B?VUJiUHc1bTVmSmpibFJtb05ucVo1Z0lHZFhxeHJ0QU54VlUrcDBDNmlTazJE?=
 =?utf-8?B?TWtnVFU2VmZzaTFWUzQzN3ZHc3JEeDUyTWFaZ0tVc1pIL2V1NVR5MjRsdVA4?=
 =?utf-8?B?WDNoSHF4MldDMHh3TVRLUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f222ef-c614-4f33-1d00-08d91053369a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 05:53:03.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV0o3vZ2XLKJW2HleA6ICpqZKYsTXe5lq8ECUGrrbx92EVAX2yVPANFPXIoZpmfq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4642
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: foN0c46WnVIYw02DlwCdRnzAJK-lbGgc
X-Proofpoint-ORIG-GUID: foN0c46WnVIYw02DlwCdRnzAJK-lbGgc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_05:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105060039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/5/21 2:40 AM, Denis Salopek wrote:
> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> hashtab map types, in addition to stacks and queues.
> Create a new hashtab bpf_map_ops function that does lookup and deletion
> of the element under the same bucket lock and add the created map_ops to
> bpf.h.
> 
> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>

It would be good if you can have a cover letter since this is
a 3-patch series and the changelog below can be put in
the cover letter too.

The patch looks good to me with a nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v2: Add functionality for LRU/per-CPU, add test_progs tests.
> v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
> flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
> v4: Fix the return value for unsupported map types.
> v5: Split patch to 3 patches. Extend BPF_MAP_LOOKUP_AND_DELETE_ELEM
> documentation with this changes.
> v6: Remove unneeded flag check, minor code/format fixes.
> ---

Since the above changelog is not part of commit message, people
typically either put in the cover letter or put right before the
"diff --git ..." as when the patch is applied, the changelog
will be ignored.

>   include/linux/bpf.h            |  2 +
>   include/uapi/linux/bpf.h       | 13 +++++
>   kernel/bpf/hashtab.c           | 97 ++++++++++++++++++++++++++++++++++
>   kernel/bpf/syscall.c           | 34 ++++++++++--
>   tools/include/uapi/linux/bpf.h | 13 +++++
>   5 files changed, 155 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 02b02cb29ce2..9da98d98db25 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -69,6 +69,8 @@ struct bpf_map_ops {
>   	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
>   	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
> +	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
> +					  void *value, u64 flags);
>   	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>   					   const union bpf_attr *attr,
>   					   union bpf_attr __user *uattr);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ec6d85a81744..c10ba06af69e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -527,6 +527,15 @@ union bpf_iter_link_info {
>    *		Look up an element with the given *key* in the map referred to
>    *		by the file descriptor *fd*, and if found, delete the element.
>    *
> + *		For **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map
> + *		types, the *flags* argument needs to be set to 0, but for other
> + *		map types, it may be specified as:
> + *
> + *		**BPF_F_LOCK**
> + *			Look up and delete the value of a spin-locked map
> + *			without returning the lock. This must be specified if
> + *			the elements contain a spinlock.
> + *
>    *		The **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map types
>    *		implement this command as a "pop" operation, deleting the top
>    *		element rather than one corresponding to *key*.
> @@ -536,6 +545,10 @@ union bpf_iter_link_info {
>    *		This command is only valid for the following map types:
>    *		* **BPF_MAP_TYPE_QUEUE**
>    *		* **BPF_MAP_TYPE_STACK**
> + *		* **BPF_MAP_TYPE_HASH**
> + *		* **BPF_MAP_TYPE_PERCPU_HASH**
> + *		* **BPF_MAP_TYPE_LRU_HASH**
> + *		* **BPF_MAP_TYPE_LRU_PERCPU_HASH**
>    *
>    *	Return
>    *		Returns zero on success. On error, -1 is returned and *errno*
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d7ebb12ffffc..d68d403795e4 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1401,6 +1401,99 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
>   	rcu_read_unlock();
>   }
>   
> +static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					     void *value, bool is_lru_map,
> +					     bool is_percpu, u64 flags)
> +{
> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> +	struct hlist_nulls_head *head;
> +	unsigned long bflags;
> +	struct htab_elem *l;
> +	u32 hash, key_size;
> +	struct bucket *b;
> +	int ret;
> +
> +	key_size = map->key_size;
> +
> +	hash = htab_map_hash(key, key_size, htab->hashrnd);
> +	b = __select_bucket(htab, hash);
> +	head = &b->head;
> +
> +	ret = htab_lock_bucket(htab, b, hash, &bflags);
> +	if (ret)
> +		return ret;
> +
> +	l = lookup_elem_raw(head, hash, key, key_size);
> +	if (!l) {
> +		ret = -ENOENT;
> +	} else {
> +		if (is_percpu) {
> +			u32 roundup_value_size = round_up(map->value_size, 8);
> +			void __percpu *pptr;
> +			int off = 0, cpu;
> +
> +			pptr = htab_elem_get_ptr(l, key_size);
> +			for_each_possible_cpu(cpu) {
> +				bpf_long_memcpy(value + off,
> +						per_cpu_ptr(pptr, cpu),
> +						roundup_value_size);
> +				off += roundup_value_size;
> +			}
> +		} else {
> +			u32 roundup_key_size = round_up(map->key_size, 8);

nit: let us have an empty line between declaration and other statements.

> +			if (flags & BPF_F_LOCK)
> +				copy_map_value_locked(map, value, l->key +
> +						      roundup_key_size,
> +						      true);
> +			else
> +				copy_map_value(map, value, l->key +
> +					       roundup_key_size);
> +			check_and_init_map_lock(map, value);
> +		}
> +
> +		hlist_nulls_del_rcu(&l->hash_node);
> +		if (!is_lru_map)
> +			free_htab_elem(htab, l);
> +	}
> +
> +	htab_unlock_bucket(htab, b, hash, bflags);
> +
> +	if (is_lru_map && l)
> +		bpf_lru_push_free(&htab->lru, &l->lru_node);
> +
> +	return ret;
> +}
[...]
