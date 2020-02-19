Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DABD1649B1
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 17:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBSQQc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 11:16:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgBSQQb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Feb 2020 11:16:31 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JG65Lm030862;
        Wed, 19 Feb 2020 08:16:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VeybzCmARzMD4ZhO2PKHOQkwgbcZ9pHIo/VKWheLSlk=;
 b=Kobvh+QwJUti8nIgIjCH/6PsliZYqQlN9FgDxY+09kXx09QNMvQTl76nfeLUNcdubw3N
 PrYib3eiQFTbVOcNMjbfgq1LAwq7/CQwhDLd/m/vCCftYRTbzMHr8ZQfTzPNgkehGQ5C
 oHszAGN3QYCgE2ONUEnPEemRu2rrk8mfhVc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y8uc6ka4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Feb 2020 08:16:12 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 19 Feb 2020 08:15:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc+Zvz2m8hbUpg/VbZV5Q5kLjc1nt75zZNewxR6465q6+M0oOlJm9V2+DRrleIV8+3lTRygq2VCXwhP0AGF5usRbOYA82ENsYaueo2uB4BcmkZhQ/iRwVdNq7HWIFS2Yush/UGOiRsc3jbj71VSkSoUx3Vu2X4JEBbWp4u4a57m6QeO8dJ80wjSUMHAWMD/5EnXoQ/pAXegnqCOEbZLxd/RD9a9llkl043oncEdQL1rJQXyjk/fOi0kHomV4mGXniKuqlMWyMw59KIRjPypiQhlViE1AnX68R9IplIiRr0S5IXQuxzCByOPOGvuzSkXb9vSjtH2UXGYMNXeOJ6+BZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeybzCmARzMD4ZhO2PKHOQkwgbcZ9pHIo/VKWheLSlk=;
 b=UhLo4MRR1975KNE4pKv68a5IjXb+dLWqAvmyIif6fShz+MPGWnS6pZdUPZG/yfwc4LxT0lRJjo8eJmyqb4HYeGPtwUMRic9TFXCo5VMq/EnMjfsjLrXmi05eHswybIMD3vCOjj8NiHzFR02jH0D0376W28WmD04sDoxxwQNhivrmmGIB9oB9w9RPSOP1Tuv/IRBBgY3OeMKx5BUIgB2tvT36tTlRYWd5pSHoZI1R/qsIo9wKwYquNMQGvpz7JERPZbdZGoUBPz9u8roJ6m1e2+qiO/UZYtAHLvfouEAmDMhhP5y/IKfMq6rDf+sqhm2akiTykWyiQQ6cTXTs/iCm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeybzCmARzMD4ZhO2PKHOQkwgbcZ9pHIo/VKWheLSlk=;
 b=h1kfVOHvqf3jH/bljb+e7lU62r6u0rb5NCNWv9xla3BU4nSYnDTvvQXUPMwMBXCbd2AnbUD+D2xdJfPw3OnzOWGmkEQPfha7+hVyCjYp1JBx8hEPlqwNVtNin3k5BklqbMIzpKr5KQP0XTPc5cD7eiMGV725gqkep6rRM1iVfJY=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB4040.namprd15.prod.outlook.com (20.181.4.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 16:15:57 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 16:15:57 +0000
Subject: Re: [PATCH bpf] bpf: fix a potential deadlock with bpf_map_do_batch
To:     Jakub Sitnicki <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Brian Vazquez <brianvv@google.com>
References: <20200219064817.3636079-1-yhs@fb.com>
 <87mu9e6d6f.fsf@cloudflare.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <978c4fab-078f-21e7-ffcd-3d8f18ca18f6@fb.com>
Date:   Wed, 19 Feb 2020 08:15:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <87mu9e6d6f.fsf@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0001.namprd12.prod.outlook.com
 (2603:10b6:301:4a::11) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
Received: from marksan-mbp.DHCP.thefacebook.com (2620:10d:c090:400::5:99e4) by MWHPR1201CA0001.namprd12.prod.outlook.com (2603:10b6:301:4a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Wed, 19 Feb 2020 16:15:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:99e4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a45d4c8-a398-41fd-7623-08d7b55700b0
X-MS-TrafficTypeDiagnostic: DM6PR15MB4040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB4040F0F3A3CD35586C084E77D3100@DM6PR15MB4040.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(6512007)(498600001)(86362001)(31696002)(4326008)(2616005)(53546011)(186003)(6506007)(2906002)(6486002)(16526019)(81166006)(81156014)(6916009)(36756003)(6666004)(31686004)(8936002)(8676002)(54906003)(66946007)(66556008)(66476007)(52116002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB4040;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzXulxutThUWS8HsgZDebQRr15s2ZJKDGW18yc/R00YEc7u+AVTat4IZoWqGhgNCZ9frIDHY4wou2Xz7Op8FY8IZ1WaGX9hv3dYnPzhTYkoVSuXPj8wXHOOr3c/9bKyskK8E/6Zbpws8vrsmbNb868hOsWXhUaisyZWhlsu5SG8hQ0TE3iixLqSw8sDdPV5dM9dqBS/lOjL+mKdYkJnC9F1oX5XV6YBnQY4GkMpDQDGoP6YkTwAtBiLmYrjGq5yyThqu7/mSzbbr+wtGsKoi9pdCc1ZUmde+rlEF2nZZ3myNENsrafbWhJ5RisoZtIhGgkfn+8xi2bdlQasYLOvTGq/MTw8Rkug3L22or7pyBzf15CjsnCpQUMHVR38oo3Nqx4b/3mlnjrcHVvzdg82nJl28/3brL6fyXchafwGi+gYXJevik0clQPrgEbI72SUR
X-MS-Exchange-AntiSpam-MessageData: 4idDa9x4sA/Po1+RB5LGyoaoXZwDIx6C19mKVmSB42z/mnbhesgnc8hFuFNEmJNVxKRF98f072ecbBm1Ef0ff3cxiPyHnMKvuRnwa5ftChzU09DOZWY83l+7u2bFfZK5gpMJhvqrZ7J445d7GUPg9aX4AI9M+Z0IlnAvoy4/gIA9P2dCHPkwALNHqvXw97sI
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a45d4c8-a398-41fd-7623-08d7b55700b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 16:15:57.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KurgUkh5QiWcEP1FxcrEEhPh8DM5sklUOoLZqBva3JNnQEQi9LjqLhVGY9TcCG6G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4040
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_04:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=2 phishscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190122
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/20 3:15 AM, Jakub Sitnicki wrote:
> On Wed, Feb 19, 2020 at 06:48 AM GMT, Yonghong Song wrote:
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
>>
>> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
>> Reported-by: syzbot+a38ff3d9356388f2fb83@syzkaller.appspotmail.com
>> Reported-by: syzbot+122b5421d14e68f29cd1@syzkaller.appspotmail.com
>> Suggested-by: Hillf Danton <hdanton@sina.com>
>> Suggested-by: Martin KaFai Lau <kafai@fb.com>
>> Cc: Brian Vazquez <brianvv@google.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/hashtab.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 2d182c4ee9d9..59083061dd3a 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -56,6 +56,7 @@ struct htab_elem {
>>   			union {
>>   				struct bpf_htab *htab;
>>   				struct pcpu_freelist_node fnode;
>> +				struct htab_elem *link;
>>   			};
>>   		};
>>   	};
>> @@ -1255,6 +1256,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>   	void __user *uvalues = u64_to_user_ptr(attr->batch.values);
>>   	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
>>   	void *ubatch = u64_to_user_ptr(attr->batch.in_batch);
>> +	struct htab_elem *node_to_free = NULL;
>>   	u32 batch, max_count, size, bucket_size;
>>   	u64 elem_map_flags, map_flags;
>>   	struct hlist_nulls_head *head;
>> @@ -1370,9 +1372,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
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
>> +				l->link = node_to_free;
>> +				node_to_free = l;
>> +			} else
>>   				free_htab_elem(htab, l);
> 
> Nit, we need braces in both branches now, as per
> process/coding-style.rst:
> 
> | This does not apply if only one branch of a conditional statement is a single
> | statement; in the latter case use braces in both branches:
> |
> | .. code-block:: c
> |
> |         if (condition) {
> |                 do_this();
> |                 do_that();
> |         } else {
> |                 otherwise();
> |         }

Thanks! Make sense. Will respin.

> 
>>   		}
>>   		dst_key += key_size;
>> @@ -1380,6 +1386,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>   	}
>>
>>   	raw_spin_unlock_irqrestore(&b->lock, flags);
>> +
>> +	while (node_to_free) {
>> +		l = node_to_free;
>> +		node_to_free = node_to_free->link;
>> +		bpf_lru_push_free(&htab->lru, &l->lru_node);
>> +	}
>> +
>>   	/* If we are not copying data, we can go to next bucket and avoid
>>   	 * unlocking the rcu.
>>   	 */
> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> 
