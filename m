Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5232A448
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380089AbhCBKam (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:30:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35226 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233446AbhCBCEC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 21:04:02 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12220Oak014710;
        Mon, 1 Mar 2021 18:02:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=i1bFGyUOtQWhOp6P/YQm2XUL0/NRTwh/ZVxEkHQwHuY=;
 b=LYfL8ElUBDOlOyuUxKUOVOhsVMnzls7LCX8z04bZuz+vjMcB8462TWHcpHvj2WeADm1O
 f7WGDga10h0OH1CQfcyWG1I1q8Pt8zbtHK9073UM5iDYm77HZmbVfgmqs/dVzM1dpDW8
 l6ywP4lAf8FQ1KObZIDa0ku0quug1rOVnlM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37071t0srv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Mar 2021 18:02:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 18:02:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TruecSvk+5db/OMppANJbR2RETSKs4rWGGjOGiSywG8GATSm32uNTyhxGthubYbL35qavOTUba1Klw567m9+86gQ+Slg9sQ5uBWEGx/UD0rhMsnQe66a1T0AtLwPQPnVI0NDtlkoAtK2T+cqiIqfSBAdagOXbBfnah/16OxoYtr8Eo03lLgSNm/pjk6ZMMF7pjU6bSrP+t70E+rPktHCe6Ljw3j0YgeUACYzrxX91KrbW8Ip2s9XVj9v1LVKos+oRqgJRqt8ndXhwkMPgt1yH4iWo3HEtUXFyFd/6LDxWX9G2ZulJiFaOkyiMhg4tiB9pRhiNa6x876LV/4XJ99IUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1bFGyUOtQWhOp6P/YQm2XUL0/NRTwh/ZVxEkHQwHuY=;
 b=mDt4A8snUvbm4bw3wCO12oyOsKBj1eCpUOr0mhp24+wvVBkYcR9dabR9zNMAJy9lqd4m1Dddq8XcOVaCgGyW5wYs/d5slwTf3SZeKLa+S/rKyzNe+HEPLQopdJEDka/UdBbZJynuhHpus1EdqjICOPsPjdALvbwHJy7ZAHSMAEXuvrtzBefuKZHSsW52mpp+4MQgMTUVdpojSeHESNrhETe83sVFVXW1xKvg+fMJjBkgSKudD0GtDuKsbx+C5+bUkHznGoqWz9bz1dUr6s68v6qz+E1lc8IdejOwtvV5197F6icih3yNcb8zYt6MbdAR7/OdNJFFbaDnR8hliJMjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2478.namprd15.prod.outlook.com (2603:10b6:805:1a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 2 Mar
 2021 02:02:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 02:02:41 +0000
Subject: Re: [PATCH v2 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>, <bpf@vger.kernel.org>
CC:     <juraj.vijtiuk@sartura.hr>, <luka.oreskovic@sartura.hr>,
        <luka.perkov@sartura.hr>
References: <YDtk/vr/lk62L4KP@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <d8104f41-4302-7b68-5bc1-fb014a261e42@fb.com>
Date:   Mon, 1 Mar 2021 18:02:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <YDtk/vr/lk62L4KP@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:1f24]
X-ClientProxiedBy: MW4PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:303:69::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:1f24) by MW4PR04CA0023.namprd04.prod.outlook.com (2603:10b6:303:69::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Tue, 2 Mar 2021 02:02:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31ccb89d-949f-4af6-e60d-08d8dd1f42c2
X-MS-TrafficTypeDiagnostic: SN6PR15MB2478:
X-Microsoft-Antispam-PRVS: <SN6PR15MB247823AEFDC4DE571900D12BD3999@SN6PR15MB2478.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0g41vQ6HcjwAJbzI1xDpIYUUOGSNJRy6doJPWDs1sCtFqoCKwA6xVdbQ2KvkMeGxf/I0DxRmOIbC/OjWJbPLCEdqRfdNYITguRAcqGj6Fpew+OIxaLte0wxEt910rKQorsSmYDyobajmZ4I8T3qo6PS/3in0BKosMlrPokNkp+TWwsVriI0CW40upTMMww5Bq1Z/vNdo6vPTJGH4VcAY1E11iRbCwGYSq6EzEXeulnwXXQLU9KzaXcB8G+yoUkk7wUZ89cv+9sfG0LgZx+pPRP3rRcXTZeE78qAPdhEhzRxCob3/be4aAvM4/6bDif2vyfMlcb9RpOAESlM2lXEULogSIuq7Khxy6nb/bWCLM9jxEnBAGEU8E94WYk+QOZ0n5ltlS1thyHmVKXAmU2r9B5Vc+zLYLd1ErJXFw5a0kAez0adJiGY4njjdgiBobUu5FsnylMXj582rKgC6tRqDvDRhloOeUocScYoO+PVAkY2IZcAXe2yomCP0LhilYgViLa3LuDPnSCgdePmm/sLnyetYVManzsB2hbCuw/zOPnttwfW7iU5BE1livfGiMn3E9a93zBoyDMtIcQaes1s8lMYX57Devl4WA9FNlh/F7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(30864003)(31696002)(316002)(2906002)(86362001)(4326008)(52116002)(5660300002)(53546011)(6486002)(186003)(66556008)(8676002)(8936002)(66946007)(478600001)(66476007)(16526019)(83380400001)(36756003)(31686004)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bTNxTFYxR01jcFg3M3FLNkZNWjl3TXRCc3A3VjY3MFBoOGNtV3RaZGdHcEpX?=
 =?utf-8?B?a0w3bGlRNndXOSt6YmVxaDNVNndOaE4rZWJlRHN1bUpvWi80dVVJbGgrV21K?=
 =?utf-8?B?Uk1xK0VKTUNGck95elk1TEZaazhRZ0N4MW1qejBCaVF5UzBreGk5MTRIZVRX?=
 =?utf-8?B?NDk2bXBPZ1BwQ29rQVY2WjNyczcvU3R1NFVpUHdBSmxaT2s1WWNtZllHd0sz?=
 =?utf-8?B?WEVnV0lIWEhMN2xqVzc5UGx4RG5qczE2OHFsS2hyUHp1SWJCZHRNdGVxbE4z?=
 =?utf-8?B?YUE4ckk3ZTFOcEI5R1l6SkRFbEhVZFJGK1hDRmY4UFpNMXN0aFlyeis3bWRR?=
 =?utf-8?B?T0d3aHYwZkYvZ2FlcTJsR2Nwb0RaQ0tPVkVFTCtVNWtNTEswNjA1R0ZaVGc4?=
 =?utf-8?B?djgvUGhSQkVhTjBEdDNSQjNSSkY0N2FSU1FLRXBGclc3Uk1Eek9YeGJjV2pW?=
 =?utf-8?B?UmpndDY2OXF5TVdaMG9NV2QxTlpOOVJORThGUTBkSlc1bmtqbEVRaDlkeHVO?=
 =?utf-8?B?bXJrakQvYWxXOERaSDhxOWUwdmJWVGxnMlVSYzhLRXdkZVMzODZMR0NSMzFJ?=
 =?utf-8?B?UTRzQ3l5SU1mK3E1OW1jbGp0SkVqYWtsWUp2bERmL2Q0SWNTV2ZIUHBPNjA1?=
 =?utf-8?B?eWUrYVRUN1ZHenZrSWx6NS9kamRVVXg4NWhzajRzZG1OeWtvTks1bTRYak05?=
 =?utf-8?B?MGJ0MWdTWVhDY2I5R0hta0ZmVlpxLytwRHMzYmxQclpnSDQ4RXQvVDJXd0No?=
 =?utf-8?B?dG80ZkdkYWZiZW5DOUMzcWlmV1FseE5lZjBrZm5BakRNVkl5Sk9xOXNMeDQ3?=
 =?utf-8?B?Ym5HVGFZN2tmWXNKSENYbGlnbDFwVjBxQTRHMzlaeHFyZVJabmxPcnZqczVY?=
 =?utf-8?B?K3BRT3Jhc0VQc1E2b1lPZkw2eFliZzN6QkRZaXVPeVhXKzV1Y1c5L3Z5QVBF?=
 =?utf-8?B?ZUI2WGllU2h3SFhFL2ZNTTlZUVdBb2xFSldkMlpmMC94dXpjamxBdE52WmI3?=
 =?utf-8?B?TE1kQ2hzVkc0Ri9semQxK3RDL1c2S2t3T2YrVVp6VlFoMWZXVXNoam4reE53?=
 =?utf-8?B?aHZNSjNYRG1lTkRhY29lM1VUWTBlMEdzc2NHQ3o1S281b0FLcmhlVHV2dHNJ?=
 =?utf-8?B?ZWRFQXVzUHBJMENJOGFmMklnRXpld2RxVVdIUHE5bFB0TXhLNWFpTno5eUdM?=
 =?utf-8?B?OFE1RGtoVGhqMXJRb2Jub1p4UCs3NHJNNkFqRVJOSWdVdFVUc2psdkQwbzZh?=
 =?utf-8?B?N0Z0YjFOUzduVHpYWFE0bEVWcXVZZTJrNDNVMVJvTXZEZ25JMTdXem1QMVNZ?=
 =?utf-8?B?MlRpUGdtaDJ6WjhNNHFjS3BheXZEVkQ5RGxBNzM1dWtzTlk2b2hVMWNBSEhS?=
 =?utf-8?B?S2NoemQzdjV3cHAzN3VZS3MzTS8zaEZmZkE0cm9KcHpTTmtVcTBEWkpSWlp0?=
 =?utf-8?B?Tktxa1RkTmtjZnBJRGxldW9US2NvclFZa3JaYnhBeEZBQTBkSnZQeGFVN3JE?=
 =?utf-8?B?VDNXcW9OY3lpQTBuNHkvUGhYMVpnVUpkQU1LWEhLRkFtUEFndDErbCtPRHNl?=
 =?utf-8?B?ZXV0bmZsVjRIZ0Z4UmlBcDZDMG12dTdIWFRuYW9NeGJidUpEVWpqaGYwcWxQ?=
 =?utf-8?B?YVBEdkp2WklDRTExN0NSMk4zQlpmeFo4cDJPZ0g3NEZSYzJkdk5tK2x4cmVT?=
 =?utf-8?B?YkpWWWpIN2J0VU1pTVNiRHViUGREU05rTjFIR0lnbWhIaDVkdW95ZnBoNDlR?=
 =?utf-8?B?ZVZUMjYwMHMzYUt1YjdvaHN0MjVEQllBVkdmMVZRUjFMWGRHWVhFRU16THgz?=
 =?utf-8?Q?j35f0pER/g9jrU2LgVkmhr7d7++FItTg5LT70=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ccb89d-949f-4af6-e60d-08d8dd1f42c2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 02:02:41.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70EWzvT70cVGSAXLoyJOape0NeoBPgz7ajzqI8c2StxH/qKXKfsoaz/TdawhBwi0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2478
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_15:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103020013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/28/21 1:40 AM, Denis Salopek wrote:
> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> hashtab maps, in addition to stacks and queues.
> Create a new hashtab bpf_map_ops function that does lookup and deletion
> of the element under the same bucket lock and add the created map_ops to
> bpf.h.
> Add the appropriate test cases to 'maps' and 'lru_map' selftests
> accompanied with new test_progs.
> 
> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> ---
> v2: Add functionality for LRU/per-CPU, add test_progs tests.
> ---
>   include/linux/bpf.h                           |   2 +
>   kernel/bpf/hashtab.c                          |  80 +++++
>   kernel/bpf/syscall.c                          |  14 +-
>   .../bpf/prog_tests/lookup_and_delete.c        | 283 ++++++++++++++++++
>   .../bpf/progs/test_lookup_and_delete.c        |  26 ++
>   tools/testing/selftests/bpf/test_lru_map.c    |   8 +
>   tools/testing/selftests/bpf/test_maps.c       |  19 +-
>   7 files changed, 430 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4c730863fa77..0bcc4f89af40 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -67,6 +67,8 @@ struct bpf_map_ops {
>   	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
>   	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
> +	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
> +					  void *value);
>   	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>   					   const union bpf_attr *attr,
>   					   union bpf_attr __user *uattr);
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 330d721dd2af..8c3334d1b6b3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1401,6 +1401,82 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
>   	rcu_read_unlock();
>   }
>   
> +static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					     void *value, bool is_lru_map,
> +					     bool is_percpu)
> +{
> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> +	u32 hash, key_size, value_size;
> +	struct hlist_nulls_head *head;
> +	int cpu, off = 0, ret;
> +	struct htab_elem *l;
> +	unsigned long flags;
> +	void __percpu *pptr;
> +	struct bucket *b;
> +
> +	key_size = map->key_size;
> +	value_size = round_up(map->value_size, 8);
> +
> +	hash = htab_map_hash(key, key_size, htab->hashrnd);
> +	b = __select_bucket(htab, hash);
> +	head = &b->head;
> +
> +	ret = htab_lock_bucket(htab, b, hash, &flags);
> +	if (ret)
> +		return ret;
> +
> +	l = lookup_elem_raw(head, hash, key, key_size);
> +	if (l) {
> +		if (is_percpu) {
> +			pptr = htab_elem_get_ptr(l, key_size);
> +			for_each_possible_cpu(cpu) {
> +				bpf_long_memcpy(value + off,
> +						per_cpu_ptr(pptr, cpu),
> +						value_size);
> +				off += value_size;
> +			}
> +		} else {
> +			copy_map_value(map, value, l->key + round_up(key_size, 8));

For hashtab lookup elem, BPF_F_LOCK flag may be set by user, I think 
hashtab lookup_and_delete_elem should also support this flag, so user
can ensure they always get a lock protected sane value.

We have the following libbpf APIs.

LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value);
LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void 
*value,
                                          __u64 flags);
LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
                                               void *value);

Previously, bpf_map_lookup_and_delete_elem only supports queue/stack,
which does not need flags as it does not support BPF_F_LOCK so we
are fine.

Maybe similar to bpf_map_lookup_elem_flags() we add a
bpf_map_lookup_and_delete_elem_flags()? Maybe libbpf v1.0
can consolidate into a better uniform api.

> +		}
> +
> +		hlist_nulls_del_rcu(&l->hash_node);
> +		if (!is_lru_map)
> +			free_htab_elem(htab, l);
> +	} else
> +		ret = -ENOENT;
> +
> +	htab_unlock_bucket(htab, b, hash, flags);
> +
> +	if (is_lru_map && l)
> +		bpf_lru_push_free(&htab->lru, &l->lru_node);
> +
> +	return ret;
> +}
> +
> +static int htab_map_lookup_and_delete_elem(struct bpf_map *map,
> +					   void *key, void *value)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, false, false);
> +}
> +
> +static int htab_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
> +						  void *key, void *value)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, false, true);
> +}
> +
> +static int htab_lru_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					       void *value)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, true, false);
> +}
> +
> +static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
> +						      void *key, void *value)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, true, true);
> +}
> +
>   static int
>   __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>   				   const union bpf_attr *attr,
> @@ -1934,6 +2010,7 @@ const struct bpf_map_ops htab_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_map_update_elem,
>   	.map_delete_elem = htab_map_delete_elem,
>   	.map_gen_lookup = htab_map_gen_lookup,
> @@ -1954,6 +2031,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_lru_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
>   	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
>   	.map_update_elem = htab_lru_map_update_elem,
>   	.map_delete_elem = htab_lru_map_delete_elem,
> @@ -2077,6 +2155,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_percpu_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_percpu_map_update_elem,
>   	.map_delete_elem = htab_map_delete_elem,
>   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> @@ -2096,6 +2175,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_lru_percpu_map_update_elem,
>   	.map_delete_elem = htab_lru_map_delete_elem,
>   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c859bc46d06c..2634aa4a2f37 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1495,7 +1495,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   		goto err_put;
>   	}
>   
> -	value_size = map->value_size;
> +	value_size = bpf_map_value_size(map);
>   
>   	err = -ENOMEM;
>   	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
> @@ -1505,6 +1505,18 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>   	    map->map_type == BPF_MAP_TYPE_STACK) {
>   		err = map->ops->map_pop_elem(map, value);
> +	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
> +		if (!bpf_map_is_dev_bound(map)) {
> +			bpf_disable_instrumentation();
> +			rcu_read_lock();
> +			err = map->ops->map_lookup_and_delete_elem(map, key, value);
> +			rcu_read_unlock();
> +			bpf_enable_instrumentation();
> +			maybe_wait_bpf_programs(map);

maybe_wait_bpf_programs(map) is mostly for map-in-map.
but I think it is okay to put it here in case in the future
we will support map-in-map here. If maybe_wait_bpf_programs()
get inlined which mostly likely is the case, the compiler
should be able to optimize it away.

> +		}
>   	} else {
>   		err = -ENOTSUPP;
>   	}
> diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> new file mode 100644
> index 000000000000..05123bbcdc1c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <test_progs.h>
> +#include "test_lookup_and_delete.skel.h"
> +
> +#define START_VALUE 1234
> +#define NEW_VALUE 4321
> +#define MAX_ENTRIES 2
> +
> +static int duration;
> +static int nr_cpus;
> +
> +static int fill_values(int map_fd)
> +{
> +	__u64 key, value = START_VALUE;
> +	int err;
> +
> +	for (key = 1; key < MAX_ENTRIES + 1; key++) {
> +		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
> +		if (CHECK(err, "bpf_map_update_elem", "failed\n"))

You can use
	if (!ASSERT_OK(err, "bpf_map_update_elem"))
to save you from explicit "failed" string.
The same for some later other CHECK usages.

> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fill_values_percpu(int map_fd)
> +{
> +	BPF_DECLARE_PERCPU(__u64, value);
> +	int i, err;
> +	u64 key;
> +
> +	for (i = 0; i < nr_cpus; i++)
> +		bpf_percpu(value, i) = START_VALUE;
> +
> +	for (key = 1; key < MAX_ENTRIES + 1; key++) {
> +		err = bpf_map_update_elem(map_fd, &key, value, BPF_NOEXIST);
> +		if (CHECK(err, "bpf_map_update_elem", "failed\n"))
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
[...]
> diff --git a/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> new file mode 100644
> index 000000000000..eb19de8bb415
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +__u32 set_pid;
> +__u64 set_key;
> +__u64 set_value;

Please add "= 0" to the above declaration to make
it llvm10 friendly.

> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 2);
> +	__type(key, __u64);
> +	__type(value, __u64);
> +} hash_map SEC(".maps");
> +
> +SEC("tp/syscalls/sys_enter_getpgid")
> +int bpf_lookup_and_delete_test(const void *ctx)
> +{
> +	if (set_pid == bpf_get_current_pid_tgid() >> 32)
> +		bpf_map_update_elem(&hash_map, &set_key, &set_value, BPF_NOEXIST);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
[...]
