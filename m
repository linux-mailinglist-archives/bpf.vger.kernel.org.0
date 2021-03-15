Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC233A905
	for <lists+bpf@lfdr.de>; Mon, 15 Mar 2021 01:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhCOAJN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Mar 2021 20:09:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34130 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhCOAIu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 14 Mar 2021 20:08:50 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F04ZBR001583;
        Sun, 14 Mar 2021 17:08:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=OUR7KY3VZRyAgqKRFVgeQwm4pr1zgKoDA7zRCQmxH5Y=;
 b=NVJy6H5ix3O01CO3fLg2XUE9njXyu80oE8LSzD3WDvv5VMO8Vu+tJ8oqF2JZd7yigoLr
 5Tx4Hfs9btzUiavUn58Msn8lltwthKj9ahhaM8TQ8+QowzeNPq3chHPUcQiTu8K9exhi
 Yw9UxSWWtzCfgCeQBdGpwF6iih/NOL5n9jQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 379e1128q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 14 Mar 2021 17:08:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 14 Mar 2021 17:08:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qfoff2EEjlzexFPSaOtOBd14IbR/ucj2ktrRJb1BtZGlypxU9BKF2cY02EyeRM0BzdSGE2DmGsA6tB3Am9jmaB07fPh8wIO7Pyb1RrR5jey89F6mrqXqOVBL2e1kr9FzO1BtPYT7DDbJSUYM4jdwv6cy8Gbn03M4O82yzdiNasdTiOnTUWu2E/lWoh4nzqXveefuV1jrn//0nQIn2CEr0cNW/2GjwBDhgzp6duQfltKv0SCY+vsCQqOPPxrEdup5vuu9dZSN/sLt5YnvHUXrxbSTh7QQBls3zXeYiDtoPgr0TuckGHp35rdz2cxt+X0ixAduRAisw7RPh1GWcCeaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUR7KY3VZRyAgqKRFVgeQwm4pr1zgKoDA7zRCQmxH5Y=;
 b=SuZTJVQS+T318JQ7lkz7o90lFx6rpzsobt5NAoNORnO+qGo9JnV8MDoRwXImet9wjyjK+tQzZAPcaQhWz0kbRAOhxw/C7keYxSw4ruevZ5Wm9RZZYYlDjrRlAbH6M7MzmQE41nuipcnJcQ0jHA6MqAFaUmVuL2cWv/BAnCWKdW1I9GUgyp2dFMOaBw9COiKBQQdGYPOVRJKR1roko3KFQS1pOwvi61yb0jjLZs9/lcWFPFkhMyxjpthu0vDrM/VBmVxvHqFGhiekeJrfH8BXOfKkBgXpKKiMoH8uRS3P08PU8I60T3hSqzgX9juZrkj6qqmUeSriskBlESOlxPbUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4740.namprd15.prod.outlook.com (2603:10b6:806:19f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 00:08:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 00:08:46 +0000
Subject: Re: [PATCH v2 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>
CC:     <bpf@vger.kernel.org>, <juraj.vijtiuk@sartura.hr>,
        <luka.oreskovic@sartura.hr>, <luka.perkov@sartura.hr>
References: <YDtk/vr/lk62L4KP@gmail.com>
 <d8104f41-4302-7b68-5bc1-fb014a261e42@fb.com> <YEx9qYVBWWdH0LPM@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0eb074ab-907c-dedb-4e71-d38546a64418@fb.com>
Date:   Sun, 14 Mar 2021 17:08:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YEx9qYVBWWdH0LPM@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:896c]
X-ClientProxiedBy: MWHPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:300:c0::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::104e] (2620:10d:c090:400::5:896c) by MWHPR08CA0060.namprd08.prod.outlook.com (2603:10b6:300:c0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 00:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87eb4a2-5ca0-4f31-6588-08d8e746804d
X-MS-TrafficTypeDiagnostic: SA1PR15MB4740:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4740199FF6539484F6914770D36C9@SA1PR15MB4740.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ud3MQ3yiTmWp9VgxTnLivqQ0Xf51fAhSQDIX/vnMKyqjLd9kg36IRTuzT3C+bVEfjaRYb6CwYawbAZ1WSsR/3QCp79rBXpQhMqXVfeYQdzogymYIjrtR8Nz0AMaH2VPX/traBLMcvEuh8jCnBURerbntpWn6FHayplE4vFdLuRFNPPzvJQ3iTomfVoGLz4JojyEN0P7cXUageszDMDqPIYvTxXIkR2Eml/+RR0CzfcA7xuwl3klpRCzSLMJoOcCJOrQTKvg/2wjpthenGNEtlXdIwjQeq2CvTzuioGf2z3yXGt0miF7aY9eUVn4ws6MrjDFLuIKck8YdM41N3kgpVrf+T7nrpfBwhmYb0/KuBfgP5wR4gWVk5yp0oZzByzH6EvXhX/i674GaXv1vSRBxoj26hb0HLR8Wg1waVAPXPftH0WDhhD79tB1QP9262Iu7qPrfWhVufjop9bJpK+Q9/ezwo+E8UA8vSe4LG11luorT9SEdhaX0Fwe++a7EnPnY0TR6jssxbqXRIcS1Xt3PS6PyAYdlSJch9dReCVE5E7Z5bajoU3MWTHh6Ks78VMqwbWgkQ8iVfzrV/Zeg4x/++y37nTxNx6GvZ6lCSTjGYIZi0NTz58pJu1So+pBMVhHwALtNUl61O+vXU9MwnipUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(16526019)(83380400001)(186003)(2906002)(478600001)(31696002)(53546011)(66476007)(36756003)(2616005)(8936002)(8676002)(30864003)(4326008)(66556008)(6916009)(86362001)(6486002)(5660300002)(52116002)(6666004)(316002)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1ZSdC91cEkvL05xSmEwZ3R2eVpvRjdHNmNyY0UyeGU5RWlqU1dGZGJ3K3po?=
 =?utf-8?B?ZFcrWm1GOEdCQ1lPMXRiZG1BOXh1dG8yQ1dacHkwMEJkUHhtYzhKelZKM3dR?=
 =?utf-8?B?MDg2WGFHb3lJVXgvSDNQcGdjWGJoVVdkSWhJSzhObUU0NGdOU2xneUZSeWpV?=
 =?utf-8?B?TUc3R1RFa2tHcmI0RWpQelJzU200RHF3R2ZVUkV5amkxOXhzTmF0aC9PT21q?=
 =?utf-8?B?OEJjZnQyWmNhZU9adm8zTzhUZEJTVkEzc21ONk5Ja3JJNDdHS2xPVzVyMmpZ?=
 =?utf-8?B?ZWdwZkhOVTFqY3lvSjQ4MkJUTTZPbkNsNmNvSnJLWnN0d09MTTVQUkpXUnU2?=
 =?utf-8?B?aFBaNVBqV3lqd2tyWVMwWVljYjhEUStOcTQ3a3BCcDBmZFZ3OHhrTHFHRW5n?=
 =?utf-8?B?dEpUTnk1aU52dlByN2xhUmNSaVhKa1U4b2tCRnV1ZUtXMEVONVhuWUhJQ05j?=
 =?utf-8?B?SjR4cU5GWWpoK3Faem1NMG9mVTBiMnltdzVZUGxuZldheXI1VXp4WG1aSHBk?=
 =?utf-8?B?VDZFVFFTTjFhUFlVWGgvMkF6M3FoK1FlVXVxMlVZdW51T1B3akR4MFZVUjFy?=
 =?utf-8?B?SUVNM0NPSnQxa21YeDFNTklnQjZPSmZqZldFUmt6a1Z2RmdHZHhBZEc2YzBh?=
 =?utf-8?B?cUNhOTBIc2MwRVo4ZWZIOGtld3BTVUd6eDdyYkZzOGNXR3Q2YTREZmtKMHJi?=
 =?utf-8?B?bEtRM3VKTmUzbXJIbFpJbkg4MDRxVm10enQ0WUZYMDQ3WWxleDViazhONFhS?=
 =?utf-8?B?UUV1NUNoR21HL0pwdWk0RlVza0U2N3g5bTJjV1dKR3YrMjNPSnBZNG4vRnBi?=
 =?utf-8?B?UVhFTzE4bnl3K0g4VHZXR29WVnl2N09MdVVKYTRBYWh4MEVjRThlckJuYk9B?=
 =?utf-8?B?aFdOcUlSaC82RnFvU0lQYTZQMUI2ZmswaEM3NHJpaGU4dVJoNmF4NEJGaHZa?=
 =?utf-8?B?SFlWZVlHR1pQZ0JjT2U2MWhCc1A3eHJoYzg0UDNnbjZveUVxRHZCNjRoeWY1?=
 =?utf-8?B?NUpMczBPanNNcm1jdy9PN2EyajBCU0o0L09mR2ZzME1Bd3VMMVhJWldDaVVq?=
 =?utf-8?B?RmxFSXUzMUZoTlUwZlR5OGMzeFN5VWg1aDdIb3BVV0ZZSmhQSExGU3BnRmVz?=
 =?utf-8?B?MTNJbEZNc1JEc0lkRkE1L0ZkM3ZWYmIrekhaZkZLWTNqS0hTcnRKY0V0ZnIr?=
 =?utf-8?B?UUMyMjkwQllCUFgwOVZjU0NnaThkVUJjQkFGR2hxOU9NNU43NXptNmQ4bnpt?=
 =?utf-8?B?alB2ci93Z0ZVSlZ3dS8xQlZ4VUd1Z1daejFYaFlTYzNwWi9ZRzFxUGUzaHhr?=
 =?utf-8?B?TjdHcGRpODc1VFp6bVZPZ09RN0tySkxpWGdJUGZaZFp4MlVnei96VGp1U01I?=
 =?utf-8?B?VGsrUDc4VE1sTmIvblppNHliVmc2N29vMlFlc1p5WXdIdm1tNElGZnVUdmNC?=
 =?utf-8?B?djRHZGllNk1yQ0VyRVY2TTRJWFFHclNZcjJEUUg4bkFCZDJXUkU5WmNPOXg3?=
 =?utf-8?B?Z2doMmZQeTJNZVVaMlF5bnRUUkdBemQyU0hWT0F4N0RXNGRvU2Fsdzc5cXVq?=
 =?utf-8?B?Vzl1dnhmNmJueE0yVThnRWI1bzZlQnJYUU9wc25UdG80SngvNytzQTRvaGhh?=
 =?utf-8?B?ay92VUwxYUJGZWhOR1JrelQwNkRMSjY2eVA0QnZnQkVVV2JVWVB5R0VqVTAw?=
 =?utf-8?B?anRJUHZodCsyNUQ4MmQrejdQME1DcGhrNnZDbFVORjRqckhFY2srS1BZSGdo?=
 =?utf-8?B?QWdOSjAvbmQ3SkpVM3F6cHM4Y3N1ZE1BSHNHN3ZMT25JT3NjaTEwZkF4Sy9o?=
 =?utf-8?Q?vr9ffXCl7W8TEltyRFK9ls1JuknWa3tatC+Bk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a87eb4a2-5ca0-4f31-6588-08d8e746804d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 00:08:46.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liIhMaO4DMOwYH8FrA7Bsgf+QgUFaLdqnnAv/bbkBXoudC2bxaD4wFhX2PDCHvqr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4740
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-14_16:2021-03-12,2021-03-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140188
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/13/21 12:54 AM, Denis Salopek wrote:
> Hello,
> 
> Thank you for your feedback and comments.
> 
> On Mon, Mar 01, 2021 at 06:02:37PM -0800, Yonghong Song wrote:
>>
>>
>> On 2/28/21 1:40 AM, Denis Salopek wrote:
>>> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
>>> hashtab maps, in addition to stacks and queues.
>>> Create a new hashtab bpf_map_ops function that does lookup and deletion
>>> of the element under the same bucket lock and add the created map_ops to
>>> bpf.h.
>>> Add the appropriate test cases to 'maps' and 'lru_map' selftests
>>> accompanied with new test_progs.
>>>
>>> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
>>> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
>>> Cc: Luka Perkov <luka.perkov@sartura.hr>
>>> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
>>> ---
>>> v2: Add functionality for LRU/per-CPU, add test_progs tests.
>>> ---
>>>    include/linux/bpf.h                           |   2 +
>>>    kernel/bpf/hashtab.c                          |  80 +++++
>>>    kernel/bpf/syscall.c                          |  14 +-
>>>    .../bpf/prog_tests/lookup_and_delete.c        | 283 ++++++++++++++++++
>>>    .../bpf/progs/test_lookup_and_delete.c        |  26 ++
>>>    tools/testing/selftests/bpf/test_lru_map.c    |   8 +
>>>    tools/testing/selftests/bpf/test_maps.c       |  19 +-
>>>    7 files changed, 430 insertions(+), 2 deletions(-)
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 4c730863fa77..0bcc4f89af40 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -67,6 +67,8 @@ struct bpf_map_ops {
>>>    	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
>>>    	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
>>>    				union bpf_attr __user *uattr);
>>> +	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
>>> +					  void *value);
>>>    	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>>>    					   const union bpf_attr *attr,
>>>    					   union bpf_attr __user *uattr);
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index 330d721dd2af..8c3334d1b6b3 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -1401,6 +1401,82 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
>>>    	rcu_read_unlock();
>>>    }
>>>    
>>> +static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
>>> +					     void *value, bool is_lru_map,
>>> +					     bool is_percpu)
>>> +{
>>> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>> +	u32 hash, key_size, value_size;
>>> +	struct hlist_nulls_head *head;
>>> +	int cpu, off = 0, ret;
>>> +	struct htab_elem *l;
>>> +	unsigned long flags;
>>> +	void __percpu *pptr;
>>> +	struct bucket *b;
>>> +
>>> +	key_size = map->key_size;
>>> +	value_size = round_up(map->value_size, 8);
>>> +
>>> +	hash = htab_map_hash(key, key_size, htab->hashrnd);
>>> +	b = __select_bucket(htab, hash);
>>> +	head = &b->head;
>>> +
>>> +	ret = htab_lock_bucket(htab, b, hash, &flags);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	l = lookup_elem_raw(head, hash, key, key_size);
>>> +	if (l) {
>>> +		if (is_percpu) {
>>> +			pptr = htab_elem_get_ptr(l, key_size);
>>> +			for_each_possible_cpu(cpu) {
>>> +				bpf_long_memcpy(value + off,
>>> +						per_cpu_ptr(pptr, cpu),
>>> +						value_size);
>>> +				off += value_size;
>>> +			}
>>> +		} else {
>>> +			copy_map_value(map, value, l->key + round_up(key_size, 8));
>>
>> For hashtab lookup elem, BPF_F_LOCK flag may be set by user, I think
>> hashtab lookup_and_delete_elem should also support this flag, so user
>> can ensure they always get a lock protected sane value.
>>
>> We have the following libbpf APIs.
>>
>> LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value);
>> LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void
>> *value,
>>                                            __u64 flags);
>> LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
>>                                                 void *value);
>>
>> Previously, bpf_map_lookup_and_delete_elem only supports queue/stack,
>> which does not need flags as it does not support BPF_F_LOCK so we
>> are fine.
>>
>> Maybe similar to bpf_map_lookup_elem_flags() we add a
>> bpf_map_lookup_and_delete_elem_flags()? Maybe libbpf v1.0
>> can consolidate into a better uniform api.
>>
> 
> If I understood correctly, there shouldn't be much changes for this
> addition:
> - add LIBBPF_API prototype and function in bpf.[hc] - those are
>    practically the same as bpf_map_lookup_elem_flags() but we call
>    BPF_LOOKUP_AND_DELETE_ELEM syscall,

yes.

> - add global declaration for bpf_map_lookup_elem_flags() in libbpf.map,

bpf_map_lookup_and_delete_elem_flags()

> - make the necessary checks for flags and the lock in the functions,

yes.

> - call copy_map_value_locked() if BPF_F_LOCK is set,

yes.

> - mask lock with check_and_init_map_lock().

not sure about, current implementation is supposed to already
take care of this, but please double check.

> 
> Is this right or is there anything else I've missed?

yes, almost right except some minor comments above.

> 
>>> +		}
>>> +
>>> +		hlist_nulls_del_rcu(&l->hash_node);
>>> +		if (!is_lru_map)
>>> +			free_htab_elem(htab, l);
>>> +	} else
>>> +		ret = -ENOENT;
>>> +
>>> +	htab_unlock_bucket(htab, b, hash, flags);
>>> +
>>> +	if (is_lru_map && l)
>>> +		bpf_lru_push_free(&htab->lru, &l->lru_node);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int htab_map_lookup_and_delete_elem(struct bpf_map *map,
>>> +					   void *key, void *value)
>>> +{
>>> +	return __htab_map_lookup_and_delete_elem(map, key, value, false, false);
>>> +}
>>> +
>>> +static int htab_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
>>> +						  void *key, void *value)
>>> +{
>>> +	return __htab_map_lookup_and_delete_elem(map, key, value, false, true);
>>> +}
>>> +
>>> +static int htab_lru_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
>>> +					       void *value)
>>> +{
>>> +	return __htab_map_lookup_and_delete_elem(map, key, value, true, false);
>>> +}
>>> +
>>> +static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
>>> +						      void *key, void *value)
>>> +{
>>> +	return __htab_map_lookup_and_delete_elem(map, key, value, true, true);
>>> +}
>>> +
>>>    static int
>>>    __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>>    				   const union bpf_attr *attr,
>>> @@ -1934,6 +2010,7 @@ const struct bpf_map_ops htab_map_ops = {
>>>    	.map_free = htab_map_free,
>>>    	.map_get_next_key = htab_map_get_next_key,
>>>    	.map_lookup_elem = htab_map_lookup_elem,
>>> +	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
>>>    	.map_update_elem = htab_map_update_elem,
>>>    	.map_delete_elem = htab_map_delete_elem,
>>>    	.map_gen_lookup = htab_map_gen_lookup,
>>> @@ -1954,6 +2031,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
>>>    	.map_free = htab_map_free,
>>>    	.map_get_next_key = htab_map_get_next_key,
>>>    	.map_lookup_elem = htab_lru_map_lookup_elem,
>>> +	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
>>>    	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
>>>    	.map_update_elem = htab_lru_map_update_elem,
>>>    	.map_delete_elem = htab_lru_map_delete_elem,
>>> @@ -2077,6 +2155,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
>>>    	.map_free = htab_map_free,
>>>    	.map_get_next_key = htab_map_get_next_key,
>>>    	.map_lookup_elem = htab_percpu_map_lookup_elem,
>>> +	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
>>>    	.map_update_elem = htab_percpu_map_update_elem,
>>>    	.map_delete_elem = htab_map_delete_elem,
>>>    	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
>>> @@ -2096,6 +2175,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
>>>    	.map_free = htab_map_free,
>>>    	.map_get_next_key = htab_map_get_next_key,
>>>    	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
>>> +	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
>>>    	.map_update_elem = htab_lru_percpu_map_update_elem,
>>>    	.map_delete_elem = htab_lru_map_delete_elem,
>>>    	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index c859bc46d06c..2634aa4a2f37 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -1495,7 +1495,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>>>    		goto err_put;
>>>    	}
>>>    
>>> -	value_size = map->value_size;
>>> +	value_size = bpf_map_value_size(map);
>>>    
>>>    	err = -ENOMEM;
>>>    	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
>>> @@ -1505,6 +1505,18 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>>>    	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>>>    	    map->map_type == BPF_MAP_TYPE_STACK) {
>>>    		err = map->ops->map_pop_elem(map, value);
>>> +	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
>>> +		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>>> +		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
>>> +		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
>>> +		if (!bpf_map_is_dev_bound(map)) {
>>> +			bpf_disable_instrumentation();
>>> +			rcu_read_lock();
>>> +			err = map->ops->map_lookup_and_delete_elem(map, key, value);
>>> +			rcu_read_unlock();
>>> +			bpf_enable_instrumentation();
>>> +			maybe_wait_bpf_programs(map);
>>
>> maybe_wait_bpf_programs(map) is mostly for map-in-map.
>> but I think it is okay to put it here in case in the future
>> we will support map-in-map here. If maybe_wait_bpf_programs()
>> get inlined which mostly likely is the case, the compiler
>> should be able to optimize it away.
>>
> 
> I didn't realise at first it's only for map-in-map and forgot to remove
> it later, so I can remove this if you think it's better?

Originally I thought to keep it as the compiler should
be able to optimize it away. But since there is no immediate
use case yet for lookup-and-delete for hash of map-in-maps,
so let us remove maybe_wait_bpf_programs() to avoid confusion.
We can add it later if BPF_MAP_TYPE_HASH_OF_MAPS is added.

> 
>>> +		}
>>>    	} else {
>>>    		err = -ENOTSUPP;
>>>    	}
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>>> new file mode 100644
>>> index 000000000000..05123bbcdc1c
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
>>> @@ -0,0 +1,283 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +#include <test_progs.h>
>>> +#include "test_lookup_and_delete.skel.h"
>>> +
>>> +#define START_VALUE 1234
>>> +#define NEW_VALUE 4321
>>> +#define MAX_ENTRIES 2
>>> +
>>> +static int duration;
>>> +static int nr_cpus;
>>> +
>>> +static int fill_values(int map_fd)
>>> +{
>>> +	__u64 key, value = START_VALUE;
>>> +	int err;
>>> +
>>> +	for (key = 1; key < MAX_ENTRIES + 1; key++) {
>>> +		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
>>> +		if (CHECK(err, "bpf_map_update_elem", "failed\n"))
>>
>> You can use
>> 	if (!ASSERT_OK(err, "bpf_map_update_elem"))
>> to save you from explicit "failed" string.
>> The same for some later other CHECK usages.
>>
> 
> Ok.
> 
>>> +			return -1;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int fill_values_percpu(int map_fd)
>>> +{
>>> +	BPF_DECLARE_PERCPU(__u64, value);
>>> +	int i, err;
>>> +	u64 key;
>>> +
>>> +	for (i = 0; i < nr_cpus; i++)
>>> +		bpf_percpu(value, i) = START_VALUE;
>>> +
>>> +	for (key = 1; key < MAX_ENTRIES + 1; key++) {
>>> +		err = bpf_map_update_elem(map_fd, &key, value, BPF_NOEXIST);
>>> +		if (CHECK(err, "bpf_map_update_elem", "failed\n"))
>>> +			return -1;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>> [...]
>>> diff --git a/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
>>> new file mode 100644
>>> index 000000000000..eb19de8bb415
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
>>> @@ -0,0 +1,26 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include "vmlinux.h"
>>> +#include <bpf/bpf_helpers.h>
>>> +
>>> +__u32 set_pid;
>>> +__u64 set_key;
>>> +__u64 set_value;
>>
>> Please add "= 0" to the above declaration to make
>> it llvm10 friendly.
>>
> 
> Ok, I'll add this. Sorry, checkpatch.pl gave me an error with it, that's
> why I removed it.

Song Liu recently added a patch to suppress the warning:
   commit 5b8f82e1a17695c9e5fec5842b234967782d7e5b
   Author: Song Liu <songliubraving@fb.com>
   Date:   Thu Feb 25 17:22:08 2021 -0800

     checkpatch: do not apply "initialise globals to 0" check to BPF progs

You should be good now.

> 
>>> +
>>> +struct {
>>> +	__uint(type, BPF_MAP_TYPE_HASH);
>>> +	__uint(max_entries, 2);
>>> +	__type(key, __u64);
>>> +	__type(value, __u64);
>>> +} hash_map SEC(".maps");
>>> +
>>> +SEC("tp/syscalls/sys_enter_getpgid")
>>> +int bpf_lookup_and_delete_test(const void *ctx)
>>> +{
>>> +	if (set_pid == bpf_get_current_pid_tgid() >> 32)
>>> +		bpf_map_update_elem(&hash_map, &set_key, &set_value, BPF_NOEXIST);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +char _license[] SEC("license") = "GPL";
>> [...]
