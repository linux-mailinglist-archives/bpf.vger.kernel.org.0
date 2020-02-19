Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8106C164F37
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 20:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSTuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 14:50:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61482 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbgBSTuX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Feb 2020 14:50:23 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JJYRer024930;
        Wed, 19 Feb 2020 11:50:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=iBp7+5ba1fc+tsITmdQ4P+tHwYd93KKrV/3zGS1AeM0=;
 b=cATklVgz3NjRq58ChLvNoQGgTNZr+hwr5Q7+0fHX37ki6HF5fW/w74xDFmnY/s4lsMAK
 V1+f6C5L4Tpc6Vexmedg1+gn9rNrg3Vg3D4vms+3LCjnonpU/gwGTj7sSQPLb8iRRIAm
 jDs+0ARgeq8zO1yjgicABqH07GS1gTTeQmY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2y8ubdvev7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Feb 2020 11:50:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 19 Feb 2020 11:50:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxRgDOFp4bnG+IdDu9uKBcergoYsmYcL2Co7WgB0KTj8gxdgf0V6ZlNx7zNhSq79OX1+JkckaGd8SH/CzzXRP1VfVfA0phU1LFUmjcfCVpiOnv/GMhyxRJ6V9P7yJg8VlU+8UQd7hLx9oDV5ouarYtpLidzbUoXS1xGbvXkOkFTu0fbWa8cMGDo3YFl/oQQ8dHWz+qJ5CRanAtpk5FcusfcwFiuQgeFqCfEJzMGqOYJRNTj4O86U7uhMq1uB9/xrdHxTH3cgwyOb2qk/s1rJh8odsml6OAFOXcxR97e3GUi6f+oV+tW82Iiafpg0ntDG0zqjD3BkxaGuUIABUIeBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBp7+5ba1fc+tsITmdQ4P+tHwYd93KKrV/3zGS1AeM0=;
 b=V39Ktc064B7b1Yc5Jh/n4c7bQDpZypjLr0xZzBXIRDN1SVUp+SpASjE3tA7RMoxRL78SpruM6rxNKI1o9aZOk1Ktg8qdzj/cXppFpEazHE3J5f5raGnXWeLcbh2JeLwNU9WdyhfPtpaTqg4XboK73H2zFEAbt4ycnTYzpVaJ3e/nNwKZceiPjvnuYUlm26RqI7xfmDV/Fni0Twpkfnhwv9K47c5ajXpLgRIZ+yQs5nJxfj6oVHV4aRaDny48W0yc0nKrMbHs3TN5K8i0qd5Jdjkzik4Z57JXm90pDy/poGorXJUrqOMu1MuP67Gr5vh8DG+IZH291xwl4XVjkQ7Tcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBp7+5ba1fc+tsITmdQ4P+tHwYd93KKrV/3zGS1AeM0=;
 b=IN3Mx1zdtvfRGyGGtlJOhopZgu7lRC9XgYtCXycotChp3fYvydOyBqNwrH9cLIWcu17X9MdwGiKZqNnD0xnzgU8PtZINXb2hym1zTblOylKUNA7gAcVlTstMxZ5FsSZlqcplV+x9RKaqhV/htWLI2hNJjUB0YGyVSM6w4hTX4vE=
Received: from BYAPR15MB2278.namprd15.prod.outlook.com (52.135.199.17) by
 BYAPR15MB3255.namprd15.prod.outlook.com (20.179.57.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 19:50:06 +0000
Received: from BYAPR15MB2278.namprd15.prod.outlook.com
 ([fe80::4d5a:6517:802b:5f47]) by BYAPR15MB2278.namprd15.prod.outlook.com
 ([fe80::4d5a:6517:802b:5f47%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 19:50:06 +0000
Date:   Wed, 19 Feb 2020 11:49:59 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf v3] bpf: fix a potential deadlock with
 bpf_map_do_batch
Message-ID: <20200219194959.v7zamotbfkmwvvcd@kafai-mbp>
References: <20200219193106.2246922-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219193106.2246922-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: MWHPR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:300:16::20) To BYAPR15MB2278.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:3a53) by MWHPR13CA0010.namprd13.prod.outlook.com (2603:10b6:300:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.8 via Frontend Transport; Wed, 19 Feb 2020 19:50:04 +0000
X-Originating-IP: [2620:10d:c090:400::5:3a53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 749d90c2-1493-437f-b034-08d7b574eac5
X-MS-TrafficTypeDiagnostic: BYAPR15MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB32551DE523D63C9522F22CE3D5100@BYAPR15MB3255.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(9686003)(55016002)(8936002)(1076003)(6496006)(186003)(16526019)(33716001)(6666004)(86362001)(66556008)(2906002)(5660300002)(81166006)(81156014)(8676002)(6862004)(66476007)(54906003)(6636002)(52116002)(4326008)(66946007)(498600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3255;H:BYAPR15MB2278.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5bHzqrCjKbbDs7juryckkvZmWjLdw9hIIKfktdfejIU6E2LuchU7T9qW3pEUaD0B9NjQ+AEWU4/tRwdc8+Kiwe4WwzI/0MyHffnAIvLDLCmmIqUZ+hBIbuE9/GoCfbBuZUqRDBzGPH+LFaXrcAo567XRiOMW6pcucQlhfQwm1RBzF+J3y3qRPS+7Bwv3iULPorBnAK9joCEWJf0/uyKzt2MFOiYmOUTYvoEEY1RkjcdM0pqPYTp5z0HqkJJ8Lg5DlGe4o1yzCOuXdQLen1hwl7lXXXJM2VPVIsw1EyNHvf0tCE7DzJ9xleMOOjHn7lCXVlJOinqK1VSeJuw7uVpE/CePumwEVxmntzPMTO+sriFg0VnP0UOehArvtWCbIt95HBzFoAg8wwmzGxR4TGBICRnAo0Kz50q3/9jrvWNbL6JCQHTFkEK6TE4GEHSiCzE
X-MS-Exchange-AntiSpam-MessageData: IjJxVoVBMY5zO13JOkWX4U9slFJurfSUiloWi+WNLPHnsqbyxVvjNFaZTQEJpRXofezbDVH9Cl5eBfeibxqNcCotPmcEgMHlBK4QvGc5v/w7B9sd0Tz/FSk53ySaO7nBTnqFaXE6x5xiVpvA4oEXz1wUXykUjK0a/B7efU9qfUKgFgxhlSu3o+jF/BqjbaCc
X-MS-Exchange-CrossTenant-Network-Message-Id: 749d90c2-1493-437f-b034-08d7b574eac5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 19:50:05.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hA00MoMKD6mzLVuE7TeYI/Dyh1MzBLuH3vYlsf4Jpl1ZzxtyF1Us8hbHKEhhGaq5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3255
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_05:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=731
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 19, 2020 at 11:31:06AM -0800, Yonghong Song wrote:
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
>  kernel/bpf/hashtab.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> Changelog:
>   v2 -> v3:
>      . changed variable name, fixed reverse Christmas tree
>        coding style and added more comments, from Martin.
Acked-by: Martin KaFai Lau <kafai@fb.com>
