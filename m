Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2D5A72E0
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 02:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiHaApc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 20:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiHaApC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 20:45:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6794CB0B3C
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 17:43:21 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UMjJY9001013;
        Tue, 30 Aug 2022 17:42:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1gAIYYnOcLjq31tpd3su4H6Yymt/rHHZFEYN1HE2C1o=;
 b=dn3W/G5aOShyNv2oJYW25fSjPV+QMJvB8lZwQbHaiiknsomAqasrir485GenosOE7naU
 q/J9z8i3BIwiT3mSH6MUzFrBNrfIPb1mObHsAXHmY9ISDnQoiWZddsmlfd1+YrwGdx5/
 3zWArudTNHCCU0V1o0kXhHVYeBLLpi2QWCk= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9ywweh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 17:42:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRxObczA4d91Zu8cjJNYWZ1YjAvbPeaQt4ZUMfZKSzF8NWBqGA97ymZvIdKofEDWHt2RYK3LyJ0lrYm2eqZGbLZt/cujNvPo3EJXl/E5kyZ/iYrhlU70IEB8QFSFcfVCCm5XqnoyEzfJUSnPJZ204dnzXCcnWPGClfaDHsezMYYuR+jEL5ktagUF+TUzfAquTPjy0tGvwkFHmw3cQk8bmbbIzSjRVh2tPa7AqRJodjjDjZ6atxCvxZgSTL8/ITNaPQcMVVQ/9+8HUsL6j744qovB5qpT4GkZMmcBNOwP8ZxFjTvdl2c0a50LXUYFu264qWnOlQdx5y3Z+gC17AUerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kRIYsQEOqW9MTzLcB7z1XXXhkzbo09htCYir0I1+Po=;
 b=SAQkhq7eGWbsAUvc92HA5maaA81niVH7Sg5JHYResFaJ5vY+VB0VWADpYNddoX5T7SkwkwsQXdbeLnKK9QBhFqc23p0ryjoS6aIpf/EXmZDWE4Vc0d1S7KLyNVH3lbbiMIk0VvtrmXSa1E1wNv4K15SauhoZzACWPqMzZRwnSa/7yv9JlXFsde9ngnvXM9I1ad/hKhnXEhBnz+Vf5SYQ4M/kpJ94bMVdzIQ0tdSRQHjYPS6eDCgluAkPOHYJFzMfDQjUq+QuhBmwWwv1NSnro26CEAy8kdpFEz2S/aZ39kdGOKphLZP63Gde+dxK1rBMQPsA2hpPHRTKAbk/f6++gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB2807.namprd15.prod.outlook.com (2603:10b6:a03:15a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 00:41:58 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 00:41:58 +0000
Date:   Tue, 30 Aug 2022 17:41:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Use this_cpu_{inc|dec|inc_return} for
 bpf_task_storage_busy
Message-ID: <20220831004155.u2ek3edpdwls6o2w@kafai-mbp.dhcp.thefacebook.com>
References: <20220829142752.330094-1-houtao@huaweicloud.com>
 <20220829142752.330094-2-houtao@huaweicloud.com>
 <20220830005228.xc7nhufvx4oetel3@kafai-mbp.dhcp.thefacebook.com>
 <a0e8ef04-fb9c-1245-9aff-c5aa8520add8@huaweicloud.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a0e8ef04-fb9c-1245-9aff-c5aa8520add8@huaweicloud.com>
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51d2d5ac-83e0-40f1-74c4-08da8ae99c7f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2807:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOGXZTNZjgm8X5Pf0cIKDmDXJEsWXLuY+KwF6CB+NAXXJx8/uzs6Zpe2hr067ATDQ+vqyFCwV7tPbxRD5t9292daOlBbnt23N1Uy4MiKZ2YN6g2tbjfH8yBjxgRvTei7rg9Zv4z05nBeGfNc+Gxa2PwZlKv6VUjessNUhrR5MVlD4ylNDGv6yax31RQUQWSed8tjk1aD/+Uh4LJxXMlz+n6k2mG8uhgtwtxXDFjoOOuU0yI52g69Pu4L1TXTKXXNHlHO+1Z+AUwcDQ1w8bq8v/mClt45yyeT6Uoucwnvfgd4DPdV2/vMttZziW1YYOoOU1IDxWsu7ui5YnewaK0U0ojxaVl4wbVvwwGaeEm8yqHRKELxg5K+VlngfQehRKIfw7PHzcvbA+4BxFv167XFULc+GyT1Nlh3ztKkbO3ZiZm9YCaft8xadm/17Vj90webuDbxdtB3H6vV8VnsT5OFe1Yi4fZcZJAVFnW89ZnmQOTwDg+gOxq67V+aD1whrVUlwbjVeenJqPFAEP+JgH8NLiD+alKCb9g1JuBuhILvU0VY0hBnIrCTvZz13mu6ZVn8vdB9KkSz+XdEu/6nDu82VxvKo2pu2bHGyPrxkvGhYsZeSxNBZuyjhFiehLmK5V9G46dC57qNjdMgAb4/GODiz9zjn9/La/LDwV2XbGEpcnlHzqEBDJxH+DqdVOZ2J5Hrm2K22VMkA7aYfDhb93IttSOnW0phPPqz2J5nbsD+FSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(83380400001)(86362001)(1076003)(186003)(38100700002)(5660300002)(478600001)(7416002)(66946007)(4326008)(66476007)(8676002)(66556008)(2906002)(41300700001)(6666004)(966005)(54906003)(6486002)(6512007)(8936002)(53546011)(52116002)(6506007)(9686003)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1kdaeZjvKCOig8tIyh24Yz0kQyO4r2Ofrin0ZiVjj3882m/awU6CctWzzV?=
 =?iso-8859-1?Q?QzSbHiIPKo7hNW+hehFjXa7c1qNZxj0110FHjIWVEiinEbvIE6D/9AvzGs?=
 =?iso-8859-1?Q?bMwBY7WCXV2BQE1925KD8esbktvQ1Tuc/97P9NyqPjt4TQgWEp77b7bE5A?=
 =?iso-8859-1?Q?3Y/zKnpWWbDiHJjZzZU2v+cwD4ywrH3MsFboUIlQEB93nBpoy55D5dBnBo?=
 =?iso-8859-1?Q?Pa1ylauyLL/DqqDMLDdmqnjOXO79sXxkF3S30VVXmZyL+I9k10a703ZBr1?=
 =?iso-8859-1?Q?4oCTE6QRSRotp/RB2394BVW3oB+6EfyvMhtMjmzDaCb33lH6yC8fT6Q7OI?=
 =?iso-8859-1?Q?b0zFYzNNOurGSCaUORLqc2pp0poP9g4LrCbyGLczfiUt6lixWdJ6tbcpB0?=
 =?iso-8859-1?Q?oXKvj4InBJsHa45sjnWZefQdG0IfKuy5NLKn7HnxOeMJdQN1WovfcKtNkE?=
 =?iso-8859-1?Q?wCvxyau32LCgt9iz+sd2ySmIRUiY/NCh9wTP9y1NmBWcTdkdZJ5eLRZWPJ?=
 =?iso-8859-1?Q?8jHVFdzeBVlweEZo1jZb6G5TEIt7Wbzr+f2AyqBbiJO7031wkJKH9DxTPF?=
 =?iso-8859-1?Q?cBZeyjjBEHnIOFBPmbgU5pro67MjkoqOc8pSaLoXfK++v3VzK0J1m77aXW?=
 =?iso-8859-1?Q?TWzh7LcrWnm881k2RDGUiC6eryGh+4Yza398HvwwwzYBrydJ0UXz6rdg+C?=
 =?iso-8859-1?Q?Iz+hXZUaDX8RElc1WnzSCoprj7p4v89c76g5bztIml3gWVCRlugZcOoHEV?=
 =?iso-8859-1?Q?XmR37oh0kI5gykBE3qZ7/V6SbbCYL3SkxoN56I+47UvgXHWsx9TtdZS9+F?=
 =?iso-8859-1?Q?NRDUMHMYRr670yyK88i/sOJnZwIpcUU7V9uomicEtCJaW96cnDEt2oX7Up?=
 =?iso-8859-1?Q?+Z2uvFn6R62V++pTQkMWHzz+m6uxzN31VCjurYyNpjumVtsS3iPa+ChnRi?=
 =?iso-8859-1?Q?t1ITHCLF51XOcTDJD5CQItsqHWtxpatqPshuGfc2Muxco6VurbnITwVU+W?=
 =?iso-8859-1?Q?FLS2y8q1kwNZZ1O+CJiYA5ndaNEoIUZ8hclUa8gU4A76k+6lFraPRv+7qD?=
 =?iso-8859-1?Q?DsuxHVWbQWjXfj/8X/YyYTSDEiZKZHOrnT71jxPMhHgGtAJMFNfpX3CDzG?=
 =?iso-8859-1?Q?gvSXdZjU5OZcxgPwAPQIwLpHZyW82oIgGMmwmuew8MRWDroN4Q8DtYi6X5?=
 =?iso-8859-1?Q?tNVZtNSyTWzfBNDQ9UScDlm86UgGMVpA9vpdbRw2kVOwLUawICi1dlrQav?=
 =?iso-8859-1?Q?IfwHFvYY5M44uKtfMYytRwVo35oTa3BX/0A4xwcmOaikJSGHZ+bCugTQjn?=
 =?iso-8859-1?Q?EHYg0pqGGfOgAAO2gWNEaYR4LDj2XHdsXHkSUz8+E5QqF6YngOZL76LP5v?=
 =?iso-8859-1?Q?ZRF+MWyD0Ar082Cg3B7G9QM7HM/cFyd4tBtkQ9wVAK6w79FZzA6iv1chab?=
 =?iso-8859-1?Q?JppBR59kkd65LqR45Y9bLE3HJEvT8MVIxoNuqnJBpS9//uE8hrvO2FQ2bS?=
 =?iso-8859-1?Q?c8g1Az55sjEmGc4baSb+s4gk6hgaT30EWn5MY9FBh5t1gXNYMLk/YiIZCU?=
 =?iso-8859-1?Q?Yk4hUArUez0FNvth5Q0vgySrEelB2ru1f7OVUXZEBLhx+OtWmD58KbCsaj?=
 =?iso-8859-1?Q?ynwt7DTGRd2YaZsS8/4BD6utKgoE0PrUjN58am0J6v2m9bD11ie1ySfg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d2d5ac-83e0-40f1-74c4-08da8ae99c7f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 00:41:58.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhoCsPVuMWutlo3+hg1k7/iufVXL06bvKV7Rw7LUWTBbf/ufKwMA8SNHY58quRVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2807
X-Proofpoint-ORIG-GUID: caWjD_CvGaK3on85Wn9ULGGyEjadBZfq
X-Proofpoint-GUID: caWjD_CvGaK3on85Wn9ULGGyEjadBZfq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 10:21:30AM +0800, Hou Tao wrote:
> Hi,
> 
> On 8/30/2022 8:52 AM, Martin KaFai Lau wrote:
> > On Mon, Aug 29, 2022 at 10:27:50PM +0800, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Now migrate_disable() does not disable preemption and under some
> >> architecture (e.g. arm64) __this_cpu_{inc|dec|inc_return} are neither
> >> preemption-safe nor IRQ-safe, so the concurrent lookups or updates on
> >> the same task local storage and the same CPU may make
> >> bpf_task_storage_busy be imbalanced, and bpf_task_storage_trylock()
> >> will always fail.
> >>
> >> Fixing it by using this_cpu_{inc|dec|inc_return} when manipulating
> >> bpf_task_storage_busy.
> SNIP
> >>  static bool bpf_task_storage_trylock(void)
> >>  {
> >>  	migrate_disable();
> >> -	if (unlikely(__this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
> >> -		__this_cpu_dec(bpf_task_storage_busy);
> >> +	if (unlikely(this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
> >> +		this_cpu_dec(bpf_task_storage_busy);
> > This change is only needed here but not in the htab fix [0]
> > or you are planning to address it separately ?
> >
> > [0]: https://lore.kernel.org/bpf/20220829023709.1958204-2-houtao@huaweicloud.com/
> > .
> For htab_lock_bucket() in hash-table, in theory there will be problem as shown
> below, but I can not reproduce it on ARM64 host:
> 
> *p = 0
> 
> // process A
> r0 = *p
> r0 += 1
>             // process B
>             r1 = *p
> // *p = 1
> *p = r0
>             r1 += 1
>             // *p = 1
>             *p = r1
> 
> // r0 = 1
> r0 = *p
>             // r1 = 1
>             r1 = *p
> 
> In hash table fixes, migrate_disable() in htab_lock_bucket()  is replaced by
> preempt_disable(), so the above case will be impossible. And if process A is
> preempted by IRQ, __this_cpu_inc_return will be OK.
hmm... iiuc, it is fine for the preempted by IRQ case because the
operations won't be interleaved as the process A/B example above?
That should also be true for the task-storage case here,
meaning only CONFIG_PREEMPT can reproduce it?  If that is the
case, please also mention that in the commit message.
