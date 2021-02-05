Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCAC310F33
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBEQNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 11:13:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46330 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233569AbhBEQIA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Feb 2021 11:08:00 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115HgjHC020333;
        Fri, 5 Feb 2021 09:49:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OIkiksfkN10R26KxtP2NlwJ1HKONRPwIeA1ZR6Owa7o=;
 b=lDS+aFSZHVoPGdFAOYOT8U2zIBZiSOBCNLg3In4Xu6K3mCgJzCRnsdM35pBMVjHD2yoJ
 Gk2ztrkAXQWqmLDvsSLDs+B5t3v2v00M8hwlXdDDSLUlxdJIBEZgIo7UP7k2eBQ1k9iy
 kBwc4wtggkfMhFnNBsk7j2WQ8X/RBofwpWY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36gqfknamm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 09:49:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 09:49:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdv9vB00VMs+O22v5T2Xifs6ztRHkhPZJMuQUye4OvsRVWhDVoU/27HQYvlb4N7QeNNhjbdBGqqGJ5Vtqj+nNkjHuPl+WGRAdD96X4cGKuNFZFvZm0HYw3VfkhZhAVw+rfmoQuqhXIIjYBrBQs9mrvBku+JClt2ydr4GdkQO8vY+Yho3PNcNwE+AQ5C635LKsGvdI9V04XIEZUOwaNyLmOIwr1PKfFJ7QU5RT//32gNXlzrcRnn7C+uam6YKffu2Y4nSUfOM7he8fUbV04pIARHLC2EjP0TOlnTnsB3Dbj+/VWvwSlBaI6Z/u79Kyq2H2giDuOvkeJfafpmRMjnaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIkiksfkN10R26KxtP2NlwJ1HKONRPwIeA1ZR6Owa7o=;
 b=ci+WV2BusRw8v9yahuv69L8YFfMZ/OOzNaVWyNvTrAIPdgQiOrwHB7H1wAyYIUuXxevS7wO7jbKyhCnfk4DMXpxmB7kjdtPOxejlWIKP1KLmDPztcp26k/w+E2GntCDeihYCX7RzROUabOxiDU/8Etjpwmd09dHZqlLwfgBfwABSCreu3n1hfAcgV1RxDwG9eI8cu7PI7Jld1rSoDGPUYe/vq5aspsTIduwAH72+o1C0asMnCn7+zZHn9VJ/xSvnDbD6tXNkgl/cL4yp2OUzlV5CxBssu4j+0iJBYNXUjqXfjiZ3x0PZPpQwkZeYpjNZy/2/DlY2oLA/zN9g2T7J9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIkiksfkN10R26KxtP2NlwJ1HKONRPwIeA1ZR6Owa7o=;
 b=CZ8M845TgxNMxab3VaeXGqgFLYw4f0XQv6sPpRuR/c9JtgBvMUg9I1oubFhB0+rsA5ALSaqOujb+1gnhteEMtG2QcDBQP0DLVqLI6OQOrBKWXJ+ORBOig+NcjIe7343UcJ93hzh04EUPx6yAv3+P8wUVbbSVoqx7KNAxFN0PL8c=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2837.namprd15.prod.outlook.com (2603:10b6:a03:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 5 Feb
 2021 17:49:14 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 17:49:14 +0000
Subject: Re: [PATCH bpf-next 3/8] bpf: add hashtab support for
 bpf_for_each_map_elem() helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234830.1629223-1-yhs@fb.com>
 <20210205062356.blcdj7abj7gwymcc@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <54f4c2cc-e0e3-34d2-32b9-59e86094a930@fb.com>
Date:   Fri, 5 Feb 2021 09:49:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <20210205062356.blcdj7abj7gwymcc@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:b8ac]
X-ClientProxiedBy: MWHPR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:301:15::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::11b4] (2620:10d:c090:400::5:b8ac) by MWHPR2001CA0023.namprd20.prod.outlook.com (2603:10b6:301:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 17:49:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee21bed2-d392-4301-454b-08d8c9fe5a37
X-MS-TrafficTypeDiagnostic: BYAPR15MB2837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2837CB949E8A03A3E26B1F2CD3B29@BYAPR15MB2837.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqoHFqCOYx64ECfwGufbvsvep2phx7uwHuFdDPg8tDaTKGb+9Jqor3EQCyAmi6u+JUrlSxsuseDuEiZR6vb3NO0IU1uX+2RL0Dq8MtjFysp48Y3L7Nh0BovDJgn5z2UHbmWCy8e3KMNfrif1usDV2uGA5paLVth65fc4I5Rj+V8xoOZAwx6aVyYPoYdy1PDoAqGVn5QHpWRPhGgNZ8vBsjuiAaz48XwWwof83toOIWqJwsTfw7Hc1XeNb/Qe6ssIugdsVcLk7UXNeiA55CaZjv/3wmRl0/I6tOU4dsUGW5whComZyEhVRyaIwyH8TemOWu3W9DAe9QXafn0b1nlcBlVSC4oLixwwQ0mumZkF/fbQUxpJiYEK9PrhJYa2c9eW5hu+/RupArycXOYEF6GC6YTheHCZvQ1C4nPGdG+tLphe+OgJFakGQEe+1WglMR9FpcAKUjQGhIs1QDqt6cESvlDsX3PmmZsmjLmxMq9Rlw/cGZXZ40pc11PEOgjvGcsOxNH8M5uJ4J27BmC8abGBkBUJNcZb+J9tMwakjkJjhp7bVKScgQCnSDA8+fQ6z+vpZP56iZTyk+B723D1qSCyfd4M62aMDB8KEOJFTFIGyhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(136003)(366004)(346002)(5660300002)(86362001)(16526019)(6916009)(8676002)(4326008)(54906003)(31686004)(478600001)(66946007)(53546011)(36756003)(316002)(2906002)(6486002)(2616005)(31696002)(66556008)(186003)(66476007)(8936002)(83380400001)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WnkxR1NFVTVNbk9xVU12ZHkyRzJ5TW5EazU3L2RaSEc3N3FZbElKMFRhTnM0?=
 =?utf-8?B?ZWdYVm03TFVJaGxzdzRtZEVoazNkYktIT3R5ZlFaaFFxNnZJcnlRcjdtenNB?=
 =?utf-8?B?R0tLNVlVL3NuYVg4a2dqazRGZkFNV21iTk9WUDR0Y2VWZi9ESHErd1JjYngy?=
 =?utf-8?B?d01GL1NCTHM5QWNidXdCNUJlVitzbDJ1SlRvOVc3WDV1Vmo0TC9oYzR1U1J3?=
 =?utf-8?B?K1NjQmR2czdnaU5LSDJ3K3puZ1AxQ1hSb1JWY2p0eG1DQVh2MTVFanpidWsz?=
 =?utf-8?B?cEJ0QThsajd0ZG5pRDZ2SGJLVGVILzl1OE5seG85ZElIWm0wb3MyUXpvVEha?=
 =?utf-8?B?b0FOUFdTRWhwUVRuaCtQUzRMSFgyekJwdXNjOU11aFl1ZC95enFReXpIVllJ?=
 =?utf-8?B?YXV1WFV0Um9sSFJ6RENSTy9qOVVzMVFVZlRqS1ZzM0FaUUYvNkVNWURuOSsw?=
 =?utf-8?B?VmJRZ2tCZHNpeE8wQXBJeVRiUk54bWNmMXp5THpOenI1ZjZEVkJTNzBiSU9K?=
 =?utf-8?B?dkNlcGZqajgwUE1RUURRUkY3K1RRcEVjQjlJK1lhZFpZWFozWWQ2Vjk5cTk5?=
 =?utf-8?B?Tk90NDhrY25ud3Vzd0c1UC9rcEthRFdVL3BvZGhjWms4VjV0Q2MzZmJ3VDdl?=
 =?utf-8?B?RTBRK0k5ZmVuVm1MY0t1LzdabXRIakxMVVFZVkhZYjY2citXUVNrdUNVamFh?=
 =?utf-8?B?akpvZW5wN1dLcFkvRnQvVU1YWDhjM2d6NjJ0K3NMcG9nSFhQcTM0Q2l0cDJt?=
 =?utf-8?B?N1VUR0Z4L2ZZSEZLd1N2clhXUjJPSjlNUS9ubUV2TFBEbHE1Ylh3Ymh2TVpq?=
 =?utf-8?B?RUxCMmRXWVo4ci91Tld0akpOMjkrQ2kyTHdmOGt1c2FYZ0xYak85Z3ZyZEVV?=
 =?utf-8?B?MDU0NHcvZVI3SCtySU9La0xuTitqVktmSTZVSlRuRVFpcE5SbHNuSVpBU1dr?=
 =?utf-8?B?Tm9hQ3pvc1NwdDdxRzVtWTl1bDZ4TFVRVkRCeE1UK1lEdXZRcVlrMkh1Tzg4?=
 =?utf-8?B?Q2FsRHcraTNWTEZrOFlJdE5vMktMWGJ0UUt3V2hyNGZyZFZkK1VSNnRQd0Vy?=
 =?utf-8?B?alhKMUVydVI2dWltVlRjUDdlRjduVldqQ0JLelVSdlB2MlZodXRFMlhoSmYw?=
 =?utf-8?B?WUQ5MlpkajhIcEY1dHNhc2pLUzNMYnNTYmNGcEFjMFkwM3R0Q0x4bk5ISmsv?=
 =?utf-8?B?VlkwNTVKQWRMdDIvSWI2Y0IyZEI3RlN5a2hYamg1T3N4NnZkSDR0YzQ5K01H?=
 =?utf-8?B?Szc2aFpVLzhpOFh2b3JuVE5LZWxBU0FNVS9RTGZxaWxkYU1XazdsRnBqSnVM?=
 =?utf-8?B?bWlxZWdCNUFLUG51dzVrTDk3WkZpL1NkQ0hCZDF0SEg5Q0xJa3hZUERIdk53?=
 =?utf-8?B?MVBhNEtSN2JSdm9PM3lsNjVkL1U2bE83S1JFTnUwOVZZQmJwcm8ydHdlVTBQ?=
 =?utf-8?B?UzN5OC96OFhoYitaQ0o4Tmp2blp6Z002OXptMjE1UmhsSkZXZ1RJVWRwZjNy?=
 =?utf-8?B?S0g0WUFhR204OFA2UnhKOC9VNmdHNjhJekNkZk5WZytEZDZLZTFzQUpYMTIr?=
 =?utf-8?B?Q3hCalJtWGJHdjFJcjRJQUxQWnMyaVNqd2JBais0SDMyakdsczJoRUdBWHB5?=
 =?utf-8?B?QXBteXNnaUpxZ1o2VXNPVlpSck1sc2NFOXBPeGgydDQzaXM3N0NwZTlHQWpo?=
 =?utf-8?B?c1I4ZGw4dkhwODRQM2NLWE85QUVZN0NHamRNNGkvR2l3VWZyb056QndWYXNh?=
 =?utf-8?B?RytrdmFuT01wV3orVE9jaU1UOThvcytSOTI1ZWZDR3dFcjJlOFpqaEpyelFV?=
 =?utf-8?Q?Qc6I61LfnXIlPupD/q066x2uRljigKmKXU1Ao=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee21bed2-d392-4301-454b-08d8c9fe5a37
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 17:49:14.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaEkgk8WDsPoQXzXtVPXE/jq3DUkr2VqNKUKhNRDxTAZ+RdadQtDrOvzyoCFbrO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2837
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/21 10:23 PM, Alexei Starovoitov wrote:
> On Thu, Feb 04, 2021 at 03:48:30PM -0800, Yonghong Song wrote:
>> This patch added support for hashmap, percpu hashmap,
>> lru hashmap and percpu lru hashmap.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h   |  4 +++
>>   kernel/bpf/hashtab.c  | 57 +++++++++++++++++++++++++++++++++++++++++++
>>   kernel/bpf/verifier.c | 23 +++++++++++++++++
>>   3 files changed, 84 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index c8b72ae16cc5..31e0447cadd8 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1396,6 +1396,10 @@ void bpf_iter_map_show_fdinfo(const struct bpf_iter_aux_info *aux,
>>   int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
>>   				struct bpf_link_info *info);
>>   
>> +int map_set_for_each_callback_args(struct bpf_verifier_env *env,
>> +				   struct bpf_func_state *caller,
>> +				   struct bpf_func_state *callee);
>> +
>>   int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
>>   int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
>>   int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index c1ac7f964bc9..40f5404cfb01 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -1869,6 +1869,55 @@ static const struct bpf_iter_seq_info iter_seq_info = {
>>   	.seq_priv_size		= sizeof(struct bpf_iter_seq_hash_map_info),
>>   };
>>   
>> +static int bpf_for_each_hash_elem(struct bpf_map *map, void *callback_fn,
>> +				  void *callback_ctx, u64 flags)
>> +{
>> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>> +	struct hlist_nulls_head *head;
>> +	struct hlist_nulls_node *n;
>> +	struct htab_elem *elem;
>> +	u32 roundup_key_size;
>> +	void __percpu *pptr;
>> +	struct bucket *b;
>> +	void *key, *val;
>> +	bool is_percpu;
>> +	long ret = 0;
>> +	int i;
>> +
>> +	if (flags != 0)
>> +		return -EINVAL;
>> +
>> +	is_percpu = htab_is_percpu(htab);
>> +
>> +	roundup_key_size = round_up(map->key_size, 8);
>> +	for (i = 0; i < htab->n_buckets; i++) {
>> +		b = &htab->buckets[i];
>> +		rcu_read_lock();
>> +		head = &b->head;
>> +		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
>> +			key = elem->key;
>> +			if (!is_percpu) {
>> +				val = elem->key + roundup_key_size;
>> +			} else {
>> +				/* current cpu value for percpu map */
>> +				pptr = htab_elem_get_ptr(elem, map->key_size);
>> +				val = this_cpu_ptr(pptr);
>> +			}
>> +			ret = BPF_CAST_CALL(callback_fn)((u64)(long)map,
>> +					(u64)(long)key, (u64)(long)val,
>> +					(u64)(long)callback_ctx, 0);
>> +			if (ret) {
>> +				rcu_read_unlock();
>> +				ret = (ret == 1) ? 0 : -EINVAL;
> 
> one more thing that I should have mentioned in patch 2.
> In prepare_func_exit would be good to add:
> if (callee->in_callback_fn)
>    check that r0 is readable and in tnum_range(0, 1).
> and then don't assign r0 reg_state anywhere.

Yes, indeed. I added the constraint of return value 0/1 in the
last minute. My previous constraint is 0 for continue and non-0 for 
return. I changed it as I feel it is not extensible.

Will add contraint for r0 readable and tnum_range(0, 1)
in the next revision.

> 
>> +				goto out;
>> +			}
>> +		}
>> +		rcu_read_unlock();
> 
> Sleepable progs can do cond_resched here.
> How about adding migrate_disable before for() loop
> to make sure that for_each(per_cpu_map,...) is still meaningful and
> if (!in_atomic())
>     cond_resched();
> here.
> Since this helper is called from bpf progs only the in_atomic check
> (whether prog was sleepable or not) is accurate.
> 
>> +	}
>    
>    migrate_enable() here after the loop.

will do. I have not thought about sleepable program much yet. I suspect
I may miss some additional checking somewhere.

> 
>> +out:
>> +	return ret;
>> +}
>> +
>>   static int htab_map_btf_id;
>>   const struct bpf_map_ops htab_map_ops = {
>>   	.map_meta_equal = bpf_map_meta_equal,
>> @@ -1881,6 +1930,8 @@ const struct bpf_map_ops htab_map_ops = {
>>   	.map_delete_elem = htab_map_delete_elem,
>>   	.map_gen_lookup = htab_map_gen_lookup,
>>   	.map_seq_show_elem = htab_map_seq_show_elem,
>> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
>> +	.map_for_each_callback = bpf_for_each_hash_elem,
>>   	BATCH_OPS(htab),
>>   	.map_btf_name = "bpf_htab",
>>   	.map_btf_id = &htab_map_btf_id,
>> @@ -1900,6 +1951,8 @@ const struct bpf_map_ops htab_lru_map_ops = {
>>   	.map_delete_elem = htab_lru_map_delete_elem,
>>   	.map_gen_lookup = htab_lru_map_gen_lookup,
>>   	.map_seq_show_elem = htab_map_seq_show_elem,
>> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
>> +	.map_for_each_callback = bpf_for_each_hash_elem,
>>   	BATCH_OPS(htab_lru),
>>   	.map_btf_name = "bpf_htab",
>>   	.map_btf_id = &htab_lru_map_btf_id,
>> @@ -2019,6 +2072,8 @@ const struct bpf_map_ops htab_percpu_map_ops = {
>>   	.map_update_elem = htab_percpu_map_update_elem,
>>   	.map_delete_elem = htab_map_delete_elem,
>>   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
>> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
>> +	.map_for_each_callback = bpf_for_each_hash_elem,
>>   	BATCH_OPS(htab_percpu),
>>   	.map_btf_name = "bpf_htab",
>>   	.map_btf_id = &htab_percpu_map_btf_id,
>> @@ -2036,6 +2091,8 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
>>   	.map_update_elem = htab_lru_percpu_map_update_elem,
>>   	.map_delete_elem = htab_lru_map_delete_elem,
>>   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
>> +	.map_set_for_each_callback_args = map_set_for_each_callback_args,
>> +	.map_for_each_callback = bpf_for_each_hash_elem,
>>   	BATCH_OPS(htab_lru_percpu),
>>   	.map_btf_name = "bpf_htab",
>>   	.map_btf_id = &htab_lru_percpu_map_btf_id,
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 050b067a0be6..32c8dcc27da8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -4987,6 +4987,29 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	return 0;
>>   }
>>   
>> +int map_set_for_each_callback_args(struct bpf_verifier_env *env,
>> +				   struct bpf_func_state *caller,
>> +				   struct bpf_func_state *callee)
>> +{
>> +	/* pointer to map */
>> +	callee->regs[BPF_REG_1] = caller->regs[BPF_REG_1];
>> +
>> +	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
>> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
>> +	callee->regs[BPF_REG_2].map_ptr = caller->regs[BPF_REG_1].map_ptr;
>> +
>> +	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
>> +	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
>> +	callee->regs[BPF_REG_3].map_ptr = caller->regs[BPF_REG_1].map_ptr;
>> +
>> +	/* pointer to stack or null */
>> +	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
> 
> This hard coding of regs 1 through 4 makes sense.
> May be add a comment with bpf_for_each_map_elem and callback_fn prototypes,
> so it's more obvious what's going on.

Yes. an explicit callback_fn prototype comment makes sense.

> 
>> +
>> +	/* unused */
>> +	__mark_reg_unknown(env, &callee->regs[BPF_REG_5]);
> 
> I think it should be __mark_reg_not_init to make sure that callback_fn
> doesn't use r5.
> That will help with future extensions via new flags arg that is passed
> into bpf_for_each_map_elem.

Will do.
