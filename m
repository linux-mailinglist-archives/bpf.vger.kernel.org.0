Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB248164BAD
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 18:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgBSRSy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 12:18:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22482 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgBSRSx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Feb 2020 12:18:53 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JH9Ls1002289;
        Wed, 19 Feb 2020 09:18:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tFlThwAAXB6WpWFGQo4L60R7Uuq2PZQJnY6G7HRti0M=;
 b=Z+qKvO6h7tLwQhVqFPqJXdNGsLkUpPnPlSOki3I4UtocZq0UU+kGATkTdgq5ySsxsP1C
 vxXuTV4LCqCj+1A57eZZpvcAGHyKEdBPAIOKA6I8xeY/fZ9S3fZ3caKsmUttJQrFod+m
 Kfa8ol9ZQXJ2cLk1Fd2DOGUdiY9VSV4EHl8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y8ubw3mus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Feb 2020 09:18:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 19 Feb 2020 09:18:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpO3f71VoTnTLanpLjp035thgguGZks3ixeizVijhQYc9918g8DXe//ldzWBiweFNbLs2Gq7pUfOPwV8ufNVID8vPeXiUKiOdGvhmCT4Hkw8KL+trCQXotvWhU5tQ6p6pF8WeHzqrCa9S6mttRNF1k17tBUzRC9dBOY5NGlJqjn0JVCGobrnWeAhE+v3fB2Tp2k6H05hHzPmOgd7PSnpfv+Y/52YqDj04Q6v5NBGnd9wCX0OhmL4XLkwBNtAOEXHBMKEgAvZnck2zxQLpkewAxUYIRQ/8OgJbxoPYNZHhPpWZSoP62hwVzUTaAQ1QCsaWMCKya9sHxjSeih7v03srw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFlThwAAXB6WpWFGQo4L60R7Uuq2PZQJnY6G7HRti0M=;
 b=Rl5pBwW2jaqyMonxaFEhwDWgB1IzwW8XJsTjn/fz+0jxZc4PEvzotUx7sqKUKdif16hmNbnXl6kAbLM/z45EYEieiTO7MLTfAZXK2TzrxbiXWlgaGzA/FtuAKdOqz7tSZRcTIrGcYD9gyk5KDP+drVLAt/iOujNph7nC2rp2J9Quyx3m78GFJvsWXrs2u7uOQeKn4WG3iYzFvsfSTclZYVNNHbu9UQMhbiXDox/9UmEPS08AUqHxlzfvFcSdGNuWOFpUTDjlcIDUxRLjoF0GgRtdr5aLNB/qgD2pjTG6K5r25Xt67LSvjxgRtqlgaZ/9orMP0dC95RcG5UvhttA1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFlThwAAXB6WpWFGQo4L60R7Uuq2PZQJnY6G7HRti0M=;
 b=J9iNz/4eByje8NTq2sqORyqaWPVpcnJPDXcRICNjoUdyIUSM0rkAkajQ7MBXfTHlC0uQusygY2KtzNXeaDZFE9WFzubwgBlZySYx00uUDNC3HIuaQG1Wjo/nKyYsIaW4APhi/GKMlJGlbfLYa4pQJsAO78y+sBmZ/QV5ci2c3aI=
Received: from BYAPR15MB2278.namprd15.prod.outlook.com (52.135.199.17) by
 BYAPR15MB3400.namprd15.prod.outlook.com (20.179.59.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 17:18:34 +0000
Received: from BYAPR15MB2278.namprd15.prod.outlook.com
 ([fe80::4d5a:6517:802b:5f47]) by BYAPR15MB2278.namprd15.prod.outlook.com
 ([fe80::4d5a:6517:802b:5f47%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 17:18:34 +0000
Date:   Wed, 19 Feb 2020 09:18:26 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf v2] bpf: fix a potential deadlock with
 bpf_map_do_batch
Message-ID: <20200219171826.xwxcivb5hb6z6vst@kafai-mbp.dhcp.thefacebook.com>
References: <20200219162301.1551623-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219162301.1551623-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: MWHPR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:320:31::28) To BYAPR15MB2278.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3a53) by MWHPR18CA0042.namprd18.prod.outlook.com (2603:10b6:320:31::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 17:18:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:3a53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e4cae80-7bad-4309-61bb-08d7b55fbfe1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3400AFDADF0D112EC343DD6DD5100@BYAPR15MB3400.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(346002)(136003)(189003)(199004)(5660300002)(16526019)(8676002)(81156014)(7696005)(4326008)(81166006)(52116002)(6862004)(186003)(6636002)(54906003)(6506007)(2906002)(316002)(66476007)(8936002)(9686003)(66556008)(6666004)(55016002)(86362001)(1076003)(66946007)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3400;H:BYAPR15MB2278.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdh1jhDNBvvj/K05swlLrWHiUg2G76FzKFRmNkm+2ymnzZvlOSmnyb/rPxiY5cayIlqJziF2p/r7MKHmoovpHudrTAT/RaNm4CDuIaEo7rY7OnHiwFJc9ch4O3pG3k+FGsIywj68GVMKOCNkR4Pymwl+oTD5han/VzXEN4Qy5rUgIyhQSd2Cc/kcjJ7Ffbjf5UneGs/0iwS4dsXCwZDstAAgCHwi92xhQqfGm7A9h34PuQcWqUgBM2k2QrfezHPDa+koXj1XhUCr638kgsDZKLhNAaCl3AwBSDbLBH0Ss73G3ki4UpcpDVTSWvSwGoSxzrzxDDh89CDxuZG2J6zgkslzBY1OmjoaC94jZrFyBDNzyeDZ4f6qL4F28HmB7p4ayqeGiqx97eEkiYLhougyRsBmumLjhCvLMQ47GHUTeCNVnqiq4WV0QbAr3OsytMjY
X-MS-Exchange-AntiSpam-MessageData: mtQNlyeNpGjgsEt5YK3jstbmAF3PoPUNOSzYkdGaL5OOBOuCQcYFuRUhh8hXBTBPfUfN9FCPA5ybS5Bb5rwfnfeBSXxWjAkMEx/4QV+yTvYOei2ihQCqiaB/eEVhWrJBMW9WKpK9MfkKMI2eX7I258SL+RPQ5sRRI9I7ZCmVf6rn0BMAOWOdVFp0Enx+5t2E
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4cae80-7bad-4309-61bb-08d7b55fbfe1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 17:18:34.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDg3vi0OLPDSXxL2p/oCmzDvUXOHbkr/XwuT93/NroojRBjhPcD5aDP47yjL0rVl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3400
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_04:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 suspectscore=2 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002190131
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 08:23:01AM -0800, Yonghong Song wrote:
> Commit 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> added lookup_and_delete batch operation for hash table.
> The current implementation has bpf_lru_push_free() inside
> the bucket lock, which may cause a deadlock.
> 
> syzbot reports:
>    -> #2 (&htab->buckets[i].lock#2){....}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
>        htab_lru_map_delete_node+0xce/0x2f0 kernel/bpf/hashtab.c:593
>        __bpf_lru_list_shrink_inactive kernel/bpf/bpf_lru_list.c:220 [inline]
>        __bpf_lru_list_shrink+0xf9/0x470 kernel/bpf/bpf_lru_list.c:266
>        bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:340 [inline]
>        bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
>        bpf_lru_pop_free+0x87c/0x1670 kernel/bpf/bpf_lru_list.c:499
>        prealloc_lru_pop+0x2c/0xa0 kernel/bpf/hashtab.c:132
>        __htab_lru_percpu_map_update_elem+0x67e/0xa90 kernel/bpf/hashtab.c:1069
>        bpf_percpu_hash_update+0x16e/0x210 kernel/bpf/hashtab.c:1585
>        bpf_map_update_value.isra.0+0x2d7/0x8e0 kernel/bpf/syscall.c:181
>        generic_map_update_batch+0x41f/0x610 kernel/bpf/syscall.c:1319
>        bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
>        __do_sys_bpf+0x9b7/0x41e0 kernel/bpf/syscall.c:3460
>        __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
>        __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
>        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>    -> #0 (&loc_l->lock){....}:
>        check_prev_add kernel/locking/lockdep.c:2475 [inline]
>        check_prevs_add kernel/locking/lockdep.c:2580 [inline]
>        validate_chain kernel/locking/lockdep.c:2970 [inline]
>        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
>        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
>        bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:516 [inline]
>        bpf_lru_push_free+0x250/0x5b0 kernel/bpf/bpf_lru_list.c:555
>        __htab_map_lookup_and_delete_batch+0x8d4/0x1540 kernel/bpf/hashtab.c:1374
>        htab_lru_map_lookup_and_delete_batch+0x34/0x40 kernel/bpf/hashtab.c:1491
>        bpf_map_do_batch+0x3f5/0x510 kernel/bpf/syscall.c:3348
>        __do_sys_bpf+0x1f7d/0x41e0 kernel/bpf/syscall.c:3456
>        __se_sys_bpf kernel/bpf/syscall.c:3355 [inline]
>        __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:3355
>        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>     Possible unsafe locking scenario:
> 
>           CPU0                    CPU2
>           ----                    ----
>      lock(&htab->buckets[i].lock#2);
>                                   lock(&l->lock);
>                                   lock(&htab->buckets[i].lock#2);
>      lock(&loc_l->lock);
> 
>     *** DEADLOCK ***
> 
> To fix the issue, for htab_lru_map_lookup_and_delete_batch() in CPU0,
> let us do bpf_lru_push_free() out of the htab bucket lock. This can
> avoid the above deadlock scenario.
Patch looks good.  Some minor comments.

> 
> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> Reported-by: syzbot+a38ff3d9356388f2fb83@syzkaller.appspotmail.com
> Reported-by: syzbot+122b5421d14e68f29cd1@syzkaller.appspotmail.com
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Suggested-by: Martin KaFai Lau <kafai@fb.com>
> Acked-by: Brian Vazquez <brianvv@google.com>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/hashtab.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> Changelog:
>  v1 -> v2:
>     . coding style fix to have braces in both then and else
>       branch, from Jakub.
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 2d182c4ee9d9..a6e0d6aace62 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -56,6 +56,7 @@ struct htab_elem {
>  			union {
>  				struct bpf_htab *htab;
>  				struct pcpu_freelist_node fnode;
> +				struct htab_elem *link;
Considering this usage is very specific, the name "link" sounds
a bit general.  May be "batch_free_link" or "batch_flink"?

>  			};
>  		};
>  	};
> @@ -1255,6 +1256,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  	void __user *uvalues = u64_to_user_ptr(attr->batch.values);
>  	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
>  	void *ubatch = u64_to_user_ptr(attr->batch.in_batch);
> +	struct htab_elem *node_to_free = NULL;
Reverse xmas tree ordering.

>  	u32 batch, max_count, size, bucket_size;
>  	u64 elem_map_flags, map_flags;
>  	struct hlist_nulls_head *head;
> @@ -1370,16 +1372,28 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  		}
>  		if (do_delete) {
>  			hlist_nulls_del_rcu(&l->hash_node);
> -			if (is_lru_map)
> -				bpf_lru_push_free(&htab->lru, &l->lru_node);
> -			else
> +			if (is_lru_map) {
> +				/* link to-be-freed elements together so
> +				 * they can freed outside bucket lock region.
> +				 */
Thanks for the comments here.  I think a bit more details will be
useful in the future.

May be adding the details to the existing htab_lru_map_delete_elem()
which is also using a similar lock strategy, e.g.:
/* The LRU list has a lock (lru_lock).  Each bucket of htab has a
 * lock (buck_lock).  If both locks need to be acquired together,
 * the lock order is always lru_lock -> buck_lock and this only
 * happens in the bpf_lru_list.c logic.
 *
 * In hashtab.c, to avoid deadlock casued by lock ordering,
 * both locks are not acquired together (i.e. one lock is always
 * released first before acquiring another lock).
 */
static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
{
	/* ... */
}
    
and refer them here from here (__htab_map_lookup_and_delete_batch).

> +				l->link = node_to_free;
> +				node_to_free = l;
> +			} else {
>  				free_htab_elem(htab, l);
> +			}
>  		}
[ ... ]
