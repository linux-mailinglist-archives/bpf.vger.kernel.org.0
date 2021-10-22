Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19022438065
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJVWuT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 18:50:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230426AbhJVWuT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 18:50:19 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19MLBTau023342;
        Fri, 22 Oct 2021 15:47:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=IAZCPJzgBJzctcglfEzzIhcsGrdf5bQfcdeUGgkmdUk=;
 b=K2IdIARUSu9v7zikf5MV3QMD9i6c2PmWbHQga4jo3ht7Wve5eZQtDu4HcZBbkZGUExPa
 w8UfZPV14GVJBHGxt3vH+WX73pBBGzkePiYk2av94/BGg0pwElEzQW+1qaamdFJmpSlI
 zxirUDGa75eGY1cZrsvpT4XvJaiIKZS9UF4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3buu1ydkyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Oct 2021 15:47:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 15:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrxxSzMRV7slr2fUYH84FHKLl+nsPT6U7aKjGr8h5AtkOG5WD7+ZYzUDP1wIHDPNfLFXGBS9IrmH3smY42dAlAkLaYOQNSICPnWHfQD8NzO71h64RgQ8jFJd5WBWUmuuylUlGCQNmO08WYgHOSDBRtmPEnuIkOb3e+JLgEGHjKfV9Z9Qi/ZFGKY73pXZjo4kJVlk9bZ1K6sh1sYGEcYrNxJGAD/6I0XRNSXQSg4Vy8nMhgHaqe2vopNYkABlULbQR1iKwUVSdOJE7JHNM2IQ9O9NfokzfHhK3tqkQTMH1QI9pezPnH8AvIPNh2YFMznx9aKufoRnOaV8ENoMgL5kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAZCPJzgBJzctcglfEzzIhcsGrdf5bQfcdeUGgkmdUk=;
 b=MNNwmTJ87Mcazlxy8HpOZhH198NHkBXgcIDg06S6GlF21wnCluxtJV2qnrrcmQkwKgL35dsIraJAS5DEp0PLGrUvIJzPrLklPewqig7HcJQNesEK+9YKuODW21YmIaNrm4rxrZoF9Tw4UTcaMejwO+xjXZmFOs0eNgjxnzqJ5jWh6RvSjsAQyVpXaKmcs1vmqiMiw+ARF0r2w3KTR26s4bGtjXhe91m9TIcPOVMeenLRFtIjgQahVIy/84fQ0XtkAaA2/tyf0V/b39ULjRRt6jB20ITqwZQL7cTx+SV3Fb8678oOuYxxK//ZcG8j6hPE1HNJdJ1CwoTQcpX0s+pqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR1501MB2189.namprd15.prod.outlook.com (2603:10b6:805:11::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 22:47:37 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 22:47:37 +0000
Date:   Fri, 22 Oct 2021 15:47:33 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH 3/3] bpf: Implement prealloc for task_local_storage
Message-ID: <20211022224733.woyxljoudm3th7vq@kafai-mbp.dhcp.thefacebook.com>
References: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
 <YXB5hWFCzJDISnrK@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YXB5hWFCzJDISnrK@slm.duckdns.org>
X-ClientProxiedBy: MWHPR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:300:94::18) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:792e) by MWHPR19CA0056.namprd19.prod.outlook.com (2603:10b6:300:94::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Fri, 22 Oct 2021 22:47:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01039e58-b011-41f3-50f6-08d995adf227
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2189:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB218902609F5AD8D4E98D84C8D5809@SN6PR1501MB2189.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSO+CNgjUq0TNpuEHZKo3MVAFJRsibkRzkvP4+XQs47imRHp6wUcZcFJdpH0fZfcUHTK26X51CuGzIoRPIW6ufSOB95WcGq4vBGzKwl4yqar9RlZIFmIhus2qBTIncIk597v0UbXbgpBYTBHPn0+AiGiOCMxucF/aHNw9iCPQC4ySqBTFQtv/PJ8QyM13Lo+FcbbttqET3HxwgdnCEEj50nqSpuzOOAXrPzVUMmBl3PqyECM0AtFwbW/rXVHUya546QFiOCmtbAHFbDoSUYySsMVzP1+Ezy9mLRaBMMJjElOPCqnPOtgKOAsbkgZtUXIp4iWtWoU+GROofijTS50TeXjArRjWxBALfLlToTrSbJs9zHwx4dMVTfKxC7ggmgMOuDP/iVBGfRBaFAI8zJ5IaULKE7R/CqEDgOSAv/78ROTwuY4x6Wqatx51CdrkVMaohgUPbdG1IYPZ4MWTpVolspIciH/2yba7BjzSrbflXLRyf5pTrSIRD/vIoZCDRKuiBtoEjTbRrzmnjcgn8TolpQP8C5e/LA4Duddb2eXD6ikOO3Hz01BXtdxv71qMA+c9k5Ojgaby/XQMe5oSduHPiwsp1zLmsCxUQLxhU42kYeJvlkcUKfxYJBhIf6tActUdizsi+UeTjrbuCItbmYF4eFgiP12YJsV3rQTD3H+Fe9+r1gqZdBTRnNiOETMPuL0DkVNmlaeVGKKh+h7Vzjk05N7cGz8OfN5YpgTEiMWMqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(83380400001)(9686003)(8936002)(66556008)(66946007)(6666004)(52116002)(7696005)(186003)(6916009)(66476007)(38100700002)(5660300002)(54906003)(316002)(2906002)(86362001)(6506007)(1076003)(508600001)(966005)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3rZ/oaalm1xryqPepASQlCr1HMhYH36FmaAIvF4PLRHbKK1YHOhnAI0qMty?=
 =?us-ascii?Q?eZftqmZk2YZ8avtPMVp5+RSV6Aw9dQk6KNkgHEpYUbzxs3QxIeQ5CMP7Qr+l?=
 =?us-ascii?Q?wr4ac1Ga2Y2LIXWrU1CHYd2qRxU0GdC7ol5Dn/ZGgq1wkHafEwa4SOmTkQNN?=
 =?us-ascii?Q?l2yGXfEB9StSZsKFkYIB94Qt0YT87P3L3qpIXK9CuMTebGkfwZ75nQA7Eu7C?=
 =?us-ascii?Q?H/5caVOxTBr79pdumMik0YQ9vYHJFfsYm/0e5ghrRSGSgDR6Fm+MpI61KXp6?=
 =?us-ascii?Q?ekyuHqcEfWmsMVIZktk0BTKipoxjVKx0fsxgC/lGdq3NMxJnZ3S75P6GaPIS?=
 =?us-ascii?Q?7ue5gKXg4jkspPbqfJuX8b+qV0YvxZrU8geoVNKJGDm28uYY94KP3bH0Q2MJ?=
 =?us-ascii?Q?1W5twku9eQ1jMt/6iacSuY+FaHtj3M5Qmu3DDyRBYsDsrhLaS40bpoMYR+Yj?=
 =?us-ascii?Q?OwQ0pvFwoEcDgR+nKnmx7Q/zGNPyLisL7GYqRJJjq50AWG1Jkn7DsLc/2Yjd?=
 =?us-ascii?Q?4nZf8YaXAkJgS1Isardb2IwCkDiewlocG22i5OdoMlUWK0zEaXHOK/lAcFIq?=
 =?us-ascii?Q?ZjIlmXHwd/xSTU0UqzxzGxqZiYzVxDS62e8+xg0IZftDI6+yXMzRQ+dtCPl+?=
 =?us-ascii?Q?uGMZXbnCbD2YTk6MmPL9XE00Jl1rCs18SbiaWIZlmSu6iHqw1zxi4hGR4Hr9?=
 =?us-ascii?Q?OkfYdOBf6agGhM3ufE88rQ3UF/tJZ4gNQaeAyxYp64uQ09T4NZh7jzef16VM?=
 =?us-ascii?Q?Rbbz6xc3pt/pO4MyK7DLK0xymFXYkahZnn1T7m5q1dVPu9diWPxUDEYWmV0K?=
 =?us-ascii?Q?fRj6KeSa3TQcwgVHJdeV3Gb17TFFJXUZtnld6WhJ7B+si+tQ7Lu3GqRblbk9?=
 =?us-ascii?Q?5rx4+FA8LO/vh+6PbAbjay5eIFF22bgMbx0sqgrg/r+yG0mhOX13xaPboOwS?=
 =?us-ascii?Q?e8yHfJmtyeRb5OtdGlE3D72pFhchiw3yehOVqLmC5Z1y7U9DJPpq0mZJiOqy?=
 =?us-ascii?Q?ifvOx6lH9kqawdsMRX5ofDwwVLh0KeDi5qXWAqgCcQbGR64qXV78or0Fypiz?=
 =?us-ascii?Q?JmwbTuPKGphBN1eSwHQLRTLydzIuweH/ifkyyLUtzsMJaxQUc/Xd1ifYqmoS?=
 =?us-ascii?Q?XypZbfy+aGYU96K930s0uAQJDmE7vnOtWAMxMtOqwzorX3pgE/TNxXWpDlxs?=
 =?us-ascii?Q?k5LLI94XNTrExbJbL8pB/53oAJcDvb/QTCdvGprcSkqZgFAh+mdFPpgKm7e3?=
 =?us-ascii?Q?NK6Q/i6Qj4uGWLQhu3JxLVKCZ0iU3PskWWu4TqqY15RntOvMllYVbxrWFi9l?=
 =?us-ascii?Q?waQsUC9tdCL4N1/cwR202GWXLZ1SLUvGgs4SSpdRjDvmAG3nruDZON64AJ+K?=
 =?us-ascii?Q?6t2eAxwsYlNkKst5k07IF4JWns2xpnvBr+dvzFMuLr12B/FMN3OsL2kZh0Jt?=
 =?us-ascii?Q?6UYdRKQubme/xCFYl9TzVuDAci2W2Rlc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01039e58-b011-41f3-50f6-08d995adf227
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 22:47:37.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kafai@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2189
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Z3rWpD8u7gJflLXpFzA5uUFwD0IECktH
X-Proofpoint-ORIG-GUID: Z3rWpD8u7gJflLXpFzA5uUFwD0IECktH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=986
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110220128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 10:18:13AM -1000, Tejun Heo wrote:
> From 5e3ad0d4a0b0732e7ebe035582d282ab752397ed Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 20 Oct 2021 08:56:53 -1000
> 
> task_local_storage currently does not support pre-allocation and the memory
> is allocated on demand using the GFP_ATOMIC mask. While atomic allocations
> succeed most of the time and the occasional failures aren't a problem for
> many use-cases, there are some which can benefit from reliable allocations -
> e.g. tracking acquisitions and releases of specific resources to root cause
> long-term reference leaks.
>
> Prealloc semantics for task_local_storage:
> 
> * When a prealloc map is created, the map's elements for all existing tasks
>   are allocated.
> 
> * Afterwards, whenever a new task is forked, it automatically allocates the
>   elements for the existing preallocated maps.
> 
> To synchronize against concurrent forks, CONFIG_BPF_SYSCALL now enables
> CONFIG_THREADGROUP_RWSEM and prealloc task_local_storage creation path
> write-locks threadgroup_rwsem, and the rest of the implementation is
> straight-forward.

[ ... ]

> +static int task_storage_map_populate(struct bpf_local_storage_map *smap)
> +{
> +	struct bpf_local_storage *storage = NULL;
> +	struct bpf_local_storage_elem *selem = NULL;
> +	struct task_struct *p, *g;
> +	int err = 0;
> +
> +	lockdep_assert_held(&threadgroup_rwsem);
> +retry:
> +	if (!storage)
> +		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
> +					  GFP_USER);
> +	if (!selem)
> +		selem = bpf_map_kzalloc(&smap->map, smap->elem_size, GFP_USER);
> +	if (!storage || !selem) {
> +		err = -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	rcu_read_lock();
> +	bpf_task_storage_lock();
> +
> +	for_each_process_thread(g, p) {
I am thinking if this loop can be done in bpf iter.

If the bpf_local_storage_map is sleepable safe (not yet done but there is
an earlier attempt [0]),  bpf_local_storage_update() should be able to
alloc without GFP_ATOMIC by sleepable bpf prog and this potentially
will be useful in general for other sleepable use cases.

For example, if a sleepable bpf iter prog can run in this loop (or the existing
bpf task iter loop is as good?), the iter bpf prog can call
bpf_task_storage_get(BPF_SK_STORAGE_GET_F_CREATE) on a sleepable
bpf_local_storage_map.

This pre-alloc then can be done similarly on the tcp/udp socket side
by running a bpf prog at the existing bpf tcp/udp iter.

[0]: https://lore.kernel.org/bpf/20210826235127.303505-1-kpsingh@kernel.org/

> +		struct bpf_local_storage_data *sdata;
> +
> +		/* Try inserting with atomic allocations. On failure, retry with
> +		 * the preallocated ones.
> +		 */
> +		sdata = bpf_local_storage_update(p, smap, NULL, BPF_NOEXIST);
> +
> +		if (PTR_ERR(sdata) == -ENOMEM && storage && selem) {
> +			sdata = __bpf_local_storage_update(p, smap, NULL,
> +							   BPF_NOEXIST,
> +							   &storage, &selem);
> +		}
> +
> +		/* Check -EEXIST before need_resched() to guarantee forward
> +		 * progress.
> +		 */
> +		if (PTR_ERR(sdata) == -EEXIST)
> +			continue;
> +
> +		/* If requested or alloc failed, take a breather and loop back
> +		 * to preallocate.
> +		 */
> +		if (need_resched() ||
> +		    PTR_ERR(sdata) == -EAGAIN || PTR_ERR(sdata) == -ENOMEM) {
> +			bpf_task_storage_unlock();
> +			rcu_read_unlock();
> +			cond_resched();
> +			goto retry;
> +		}
> +
> +		if (IS_ERR(sdata)) {
> +			err = PTR_ERR(sdata);
> +			goto out_unlock;
> +		}
> +	}
> +out_unlock:
> +	bpf_task_storage_unlock();
> +	rcu_read_unlock();
> +out_free:
> +	if (storage)
> +		kfree(storage);
> +	if (selem)
> +		kfree(selem);
> +	return err;
> +}

[ ... ]

> +int bpf_task_storage_fork(struct task_struct *task)
> +{
> +	struct bpf_local_storage_map *smap;
> +
> +	percpu_rwsem_assert_held(&threadgroup_rwsem);
> +
> +	list_for_each_entry(smap, &prealloc_smaps, prealloc_node) {
Mostly a comment here from the networking side,  I suspect the common use case
is going to be more selective based on different protocol (tcp or udp)
and even port.  There is some existing bpf hooks during inet_sock creation
time, bind time ...etc.  The bpf prog can be selective on what bpf_sk_storage
it needs by inspecting different fields of a sk.

e.g. in inet_create(), there is BPF_CGROUP_RUN_PROG_INET_SOCK(sk).
Would a similar hook be useful on the fork side?

> +		struct bpf_local_storage *storage;
> +		struct bpf_local_storage_elem *selem;
> +		struct bpf_local_storage_data *sdata;
> +
> +		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
> +					  GFP_USER);
> +		selem = bpf_map_kzalloc(&smap->map, smap->elem_size, GFP_USER);
> +
> +		rcu_read_lock();
> +		bpf_task_storage_lock();
> +		sdata = __bpf_local_storage_update(task, smap, NULL, BPF_NOEXIST,
> +						   &storage, &selem);
> +		bpf_task_storage_unlock();
> +		rcu_read_unlock();
> +
> +		if (storage)
> +			kfree(storage);
> +		if (selem)
> +			kfree(selem);
> +
> +		if (IS_ERR(sdata)) {
> +			bpf_task_storage_free(task);
> +			return PTR_ERR(sdata);
> +		}
> +	}
> +
> +	return 0;
> +}
