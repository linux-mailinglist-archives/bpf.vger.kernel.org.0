Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71B164D79
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSSPl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 13:15:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31878 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726582AbgBSSPl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Feb 2020 13:15:41 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JIFK07009388;
        Wed, 19 Feb 2020 10:15:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aNKzeYks5C7zXh9N5n79l669SLj+cHJNTGToDp8nKRk=;
 b=BMK4b5blM3JLrx0/pY3hTrL79BtquI47ArKJ9JQAH71XoCq94vm3LLWZecNlmapwiqh3
 JDP6vmbqa+7+e5Zoy4sPqTXGuMIFXal1jHIBmD013gxzEv6vf2JEUr4+7BICgcVpTqdq
 ek+IRRtcv3jpdI2lZHujLLfrEJAhDq+/Mig= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y8ubw3xyh-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Feb 2020 10:15:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 19 Feb 2020 10:15:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/emk2So/pC6PH53EMZPcwddyLCAIXgox2LCP1WDpIdh1aMgcnz38n7ckwwCCXx1L1TIEQxx4GCBH8hJD0d+VM+XKwiaBhGSFeuZbTr6AEuBgiV9ehdCO4or66txQUhOglT0H3ihCQC6QvSZ+aQwcb7ivzLc6Q+0ghAPv5ncRGuoQl9sPVchEyULth+evcnNsXoSr0J6Cl3nf1jDh9jWQpL5sRlEzD3kpZUn5+vc+99JXvPGWufOcPZJnE8V6K/PH/dlJ8qhrPhloVPD4OhB+Rh+SmhjqzZqMNHQTCSxwA3ijP3fTphHpuOlBOHOQ977sgIoNaAEDQeyG2eL1qgbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNKzeYks5C7zXh9N5n79l669SLj+cHJNTGToDp8nKRk=;
 b=Bhqiyf4E58cjJfCW94L96ck+NQbhD98i2uwnKYe8FTMNTbipDpGlhigurExxPLdtu6T1z/ZrPgXML9LNutzE87W31sZ1MZsvA479UIICzkPITvE74BiaX2+dtAXNz1I0RFmVfKCYTPCs4lpmXgml7xPLN3AdmVbD/ZxmzO54xc7H8Qes/k7m1TWxD5d3lpOdlctEZDctqRRVpRVtfo26gaZvs6E2f6RNoSIT8BkijPtUxvZIpdeifhmzpebozz1qJoQl/Vrwe8LwxBmLWTT2fBgcgfE/L2aoYq2nbmCdzlMzAZXYVaxanWVctR8TwH/ZuRTELjOw1koyPebx1Br4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNKzeYks5C7zXh9N5n79l669SLj+cHJNTGToDp8nKRk=;
 b=EIWgmd+zvJDQANSjpwSVPluV5ENrGwTLoESEJZubojysZw0dXl6+gENeFRmHbRKenjuXiaIWlfvl9Ig3zcKVrREZY3TMmsH8LDPr32zeBxASW/N1cEkHLlprmONik35WBdZMqng0P8tCrDZSQGU/z+Gmp8AwM9wEilV/sz9wQ9g=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB2474.namprd15.prod.outlook.com (20.176.71.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Wed, 19 Feb 2020 18:15:25 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 18:15:25 +0000
Subject: Re: [PATCH bpf v2] bpf: fix a potential deadlock with
 bpf_map_do_batch
To:     Martin KaFai Lau <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20200219162301.1551623-1-yhs@fb.com>
 <20200219171826.xwxcivb5hb6z6vst@kafai-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <084e8e50-152b-8df3-006f-6fa953b3a923@fb.com>
Date:   Wed, 19 Feb 2020 10:15:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <20200219171826.xwxcivb5hb6z6vst@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:300:ae::32) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
Received: from marksan-mbp.DHCP.thefacebook.com (2620:10d:c090:400::5:99e4) by MWHPR14CA0022.namprd14.prod.outlook.com (2603:10b6:300:ae::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 18:15:24 +0000
X-Originating-IP: [2620:10d:c090:400::5:99e4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 058c5a2d-790d-4520-9c8c-08d7b567b127
X-MS-TrafficTypeDiagnostic: DM6PR15MB2474:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB24749E17EE33513255A61671D3100@DM6PR15MB2474.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(396003)(376002)(199004)(189003)(31686004)(6512007)(66946007)(8936002)(66556008)(81166006)(8676002)(2906002)(316002)(81156014)(66476007)(54906003)(37006003)(36756003)(5660300002)(6486002)(6506007)(16526019)(186003)(53546011)(52116002)(2616005)(6862004)(4326008)(31696002)(86362001)(478600001)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2474;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7MqRv7dboxd22/bgaMDUorIFhoYKsTOsxVBGTqXWhm14XBB5X/XlyywDdsSLsWvb/du1H1CUeGDqPM1YkvgVHRT4/9SYdHyU19LA7K83ErlbxuYDjRwn81eOcLhCmMPmQcAHL3HXgDA5SrwLo7TPtbMNlKaO7QPpw3lUHGMT8p7cEdLfXG2zQMk5D1xr8YEntxu9okTNZncG7coY9MiIFmRMxJDk/KzmMcKAycT2Eso/zX2BU9rwtWpDiJ354d1H+9xTbHHLZVATRVG5s/UmprcvAk0a6UkJgPOd8i8VofahG9FJ37tmXZ+MSHsBqsjQZYN3tnmgqk3oklzEcZeXLYuTPTNCpUbNlZqz59YrzAan7qm8xBKpiLCwYuJVDIwktefxoYPeiQlW5KX7aDu1LRVS4wJGCjZn5qK3TROQodhBEdoITtcXwIcKFkXWzYx
X-MS-Exchange-AntiSpam-MessageData: nwhMZSCHmUKYJwrzyq7AcyehYMpWDREdKhozlID8sMFLY7jwc4nY92wc/I+9RGN20vACN1q15c5StT+lXVdmHw0jr7ivwhEEQRb242pqE1dEtsNLPq5XyOrYxFZCB47FIabZi7ztPsZY43WlsYDe3qjS4PfNi2UzxskuMeNXrKAYD+gN0b3wKGiGmVao6GHs
X-MS-Exchange-CrossTenant-Network-Message-Id: 058c5a2d-790d-4520-9c8c-08d7b567b127
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 18:15:25.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgGT9FkrP0vo2eIaC+Hojn5HYIZ8XBWJcjea9HVPkEZRtcjEjE//kwNvlOaPnznu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2474
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_05:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=2 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/20 9:18 AM, Martin KaFai Lau wrote:
> On Wed, Feb 19, 2020 at 08:23:01AM -0800, Yonghong Song wrote:
>> Commit 057996380a42 ("bpf: Add batch ops to all htab bpf map")
>> added lookup_and_delete batch operation for hash table.
>> The current implementation has bpf_lru_push_free() inside
>> the bucket lock, which may cause a deadlock.
>>
>> syzbot reports:
>>     -> #2 (&htab->buckets[i].lock#2){....}:
>>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>         _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
>>         htab_lru_map_delete_node+0xce/0x2f0 kernel/bpf/hashtab.c:593
>>         __bpf_lru_list_shrink_inactive kernel/bpf/bpf_lru_list.c:220 [inline]
>>         __bpf_lru_list_shrink+0xf9/0x470 kernel/bpf/bpf_lru_list.c:266
>>         bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:340 [inline]
>>         bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
>>         bpf_lru_pop_free+0x87c/0x1670 kernel/bpf/bpf_lru_list.c:499
>>         prealloc_lru_pop+0x2c/0xa0 kernel/bpf/hashtab.c:132
>>         __htab_lru_percpu_map_update_elem+0x67e/0xa90 kernel/bpf/hashtab.c:1069
>>         bpf_percpu_hash_update+0x16e/0x210 kernel/bpf/hashtab.c:1585
>>         bpf_map_update_value.isra.0+0x2d7/0x8e0 kernel/bpf/syscall.c:181
>>         generic_map_update_batch+0x41f/0x610 kernel/bpf/syscall.c:1319
>>         bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
>>         __do_sys_bpf+0x9b7/0x41e0 kernel/bpf/syscall.c:3460
>>         __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
>>         __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
>>         do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>>     -> #0 (&loc_l->lock){....}:
>>         check_prev_add kernel/locking/lockdep.c:2475 [inline]
>>         check_prevs_add kernel/locking/lockdep.c:2580 [inline]
>>         validate_chain kernel/locking/lockdep.c:2970 [inline]
>>         __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
>>         lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
>>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>         _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
>>         bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:516 [inline]
>>         bpf_lru_push_free+0x250/0x5b0 kernel/bpf/bpf_lru_list.c:555
>>         __htab_map_lookup_and_delete_batch+0x8d4/0x1540 kernel/bpf/hashtab.c:1374
>>         htab_lru_map_lookup_and_delete_batch+0x34/0x40 kernel/bpf/hashtab.c:1491
>>         bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
>>         __do_sys_bpf+0x1f7d/0x41e0 kernel/bpf/syscall.c:3456
>>         __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
>>         __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
>>         do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>>      Possible unsafe locking scenario:
>>
>>            CPU0                    CPU2
>>            ----                    ----
>>       lock(&htab->buckets[i].lock#2);
>>                                    lock(&l->lock);
>>                                    lock(&htab->buckets[i].lock#2);
>>       lock(&loc_l->lock);
>>
>>      *** DEADLOCK ***
>>
>> To fix the issue, for htab_lru_map_lookup_and_delete_batch() in CPU0,
>> let us do bpf_lru_push_free() out of the htab bucket lock. This can
>> avoid the above deadlock scenario.
> Patch looks good.  Some minor comments.
> 
>>
>> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
>> Reported-by: syzbot+a38ff3d9356388f2fb83@syzkaller.appspotmail.com
>> Reported-by: syzbot+122b5421d14e68f29cd1@syzkaller.appspotmail.com
>> Suggested-by: Hillf Danton <hdanton@sina.com>
>> Suggested-by: Martin KaFai Lau <kafai@fb.com>
>> Acked-by: Brian Vazquez <brianvv@google.com>
>> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/hashtab.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> Changelog:
>>   v1 -> v2:
>>      . coding style fix to have braces in both then and else
>>        branch, from Jakub.
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 2d182c4ee9d9..a6e0d6aace62 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -56,6 +56,7 @@ struct htab_elem {
>>   			union {
>>   				struct bpf_htab *htab;
>>   				struct pcpu_freelist_node fnode;
>> +				struct htab_elem *link;
> Considering this usage is very specific, the name "link" sounds
> a bit general.  May be "batch_free_link" or "batch_flink"?

Okay, will use batch_flink, a little bit shorter.
All of "htab", "fnode" and "link" are used during element free.
So batch_flink should reasonably imply batch_free_link.

> 
>>   			};
>>   		};
>>   	};
>> @@ -1255,6 +1256,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>   	void __user *uvalues = u64_to_user_ptr(attr->batch.values);
>>   	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
>>   	void *ubatch = u64_to_user_ptr(attr->batch.in_batch);
>> +	struct htab_elem *node_to_free = NULL;
> Reverse xmas tree ordering.

Will fix.

> 
>>   	u32 batch, max_count, size, bucket_size;
>>   	u64 elem_map_flags, map_flags;
>>   	struct hlist_nulls_head *head;
>> @@ -1370,16 +1372,28 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>   		}
>>   		if (do_delete) {
>>   			hlist_nulls_del_rcu(&l->hash_node);
>> -			if (is_lru_map)
>> -				bpf_lru_push_free(&htab->lru, &l->lru_node);
>> -			else
>> +			if (is_lru_map) {
>> +				/* link to-be-freed elements together so
>> +				 * they can freed outside bucket lock region.
>> +				 */
> Thanks for the comments here.  I think a bit more details will be
> useful in the future.
> 
> May be adding the details to the existing htab_lru_map_delete_elem()
> which is also using a similar lock strategy, e.g.:
> /* The LRU list has a lock (lru_lock).  Each bucket of htab has a
>   * lock (buck_lock).  If both locks need to be acquired together,
>   * the lock order is always lru_lock -> buck_lock and this only
>   * happens in the bpf_lru_list.c logic.
>   *
>   * In hashtab.c, to avoid deadlock casued by lock ordering,
>   * both locks are not acquired together (i.e. one lock is always
>   * released first before acquiring another lock).
>   */
> static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
> {
> 	/* ... */
> }
>      
> and refer them here from here (__htab_map_lookup_and_delete_batch).

Okay. Let me add more detailed comments here.

> 
>> +				l->link = node_to_free;
>> +				node_to_free = l;
>> +			} else {
>>   				free_htab_elem(htab, l);
>> +			}
>>   		}
> [ ... ]
> 
