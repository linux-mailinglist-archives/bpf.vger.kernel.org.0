Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9CF45AF10
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 23:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhKWWdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 17:33:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230191AbhKWWdN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 17:33:13 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANIdRHf032747;
        Tue, 23 Nov 2021 14:29:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=14w4erbEPN6azHe6EILnqez9Bpzrlp5hfYVvbC2n0eo=;
 b=eznNthGu1fFfzGY/uTbSX8h+ENn5mMqQZdov4Y50gWqFVHOAp4NUO136QE+cey07/eDT
 BMzFHyYYFvtScwVWNQJd+/ZXT6iYZ6OAVdqMiwsn6j0M9Pniscf+vwoT2s5bXRJtey2l
 xzwRfYLBb1culogI4VzKAGTXQQZlRHFYxK8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch3jstjvh-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 14:29:46 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub101.TheFacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 14:29:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 14:29:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYNyAUYVjsX0RtiAxBuGivhOfyY/jRyOSEALdv9/cZ3gW9wfqsMuHSd26VBBUH1uOpx5vq2Eys4L87CM7HemHGA0EyQTQQA5A7YODQIt8vICWkBFydgy38t3883+MjXyyYbz+dJsxmtTzdAO8oR3KpG5arAufbdjUt6EWrPWN84qcR5NnTrvptxa3qJ5LyNW94697jAqAwUoHsFd1SbyS6pFBFHEJmXhLSWZIAe8Jbc2LG88TV9EIxtJsgDQ0TPvOoHw2GIuWcfsFOQ4zHwf76zuanRvwUb7rlGKC2PflMhlN0FApbUwmac5fWKEU/aCtdjrHyjgDDskeOcibKpuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14w4erbEPN6azHe6EILnqez9Bpzrlp5hfYVvbC2n0eo=;
 b=JWWuQmKw/nX/IMQUNtvcuNTatpKMdVdUGVKAO35wQMb5N+8G1I4cOAcTB8jZwhft3WPwirGsdJtYQo/xvLxmVH4BR0ECurmwOkbvjJQ6hYKysQAQJliHyNcq7vvENEvVwqICY36yTGe2jrWMIX33Ja9zeSiwtptGp1LGo3HEHC379qpz5+HlDk5spLp01jHD0XlZASHKni47V0t6RrUdrEyNlq4vUf7dmQFmVPpNdnoQlgeiUqrmSCQ3Y8IPSwSFGmiR6d+q6f++G5LFLEeYZWvB311FFy/5Nwu82RoumxFFDoCNjK1SRG2Lb33cKpMCsh0TOU323elggosU6AqF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3821.namprd15.prod.outlook.com (2603:10b6:806:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 22:29:44 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%6]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 22:29:44 +0000
Date:   Tue, 23 Nov 2021 14:29:40 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        KP Singh <kpsingh@kernel.org>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jann Horn" <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        "Brendan Jackman" <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20211123222940.3x2hkrrgd4l2vuk7@kafai-mbp.dhcp.thefacebook.com>
References: <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1>
 <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
 <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:e3bd) by MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 22:29:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50133196-689c-4d0c-4313-08d9aed0bfa1
X-MS-TrafficTypeDiagnostic: SA0PR15MB3821:
X-Microsoft-Antispam-PRVS: <SA0PR15MB382195808EFF0A3C347DA5EAD5609@SA0PR15MB3821.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gGSK1TKL8Uwt8AJoUvxEQwytLmlB1SFljutpv/Ajod1w8sJ4MUI7OERk7YoQq6ht3XkAhLvA6XicVRMcBcbknXYYaTgtdOoqC8F8y/ebqMbB5O+JAo54PiGdCFFF6MtFAlfraplNIH4QeA/eAZBgO96cExTE8yB2IwFn4c8WmkjU8w+hzPnHEDgDJmVtuy+zucMOBt0Ekhs/nfPzAJkPiwfvTMepeOmW5l3w2wu/LicTxG/7YAXz9+qp1B5WxjVa9mh4TbB5SEAAPKKKHyiQ+XVy4XUUkMIZLr2gEYKOzDH305ONjG4khPGFjnWO2G/VIZc5gBrP8DovjB2LMhoGOmWNeXl6xyLpKfUwzfJoaSJ2krebAbfNB6kQRKAWv+yN4e0WYHWNHYGn34ngq8t5u+DI70TXjMieMzaZw5UJ1eWrf45lZQM2YN6nu7T38g7FhGgdUUZ1wA78TK5seEXbMGodWN4g6b41/MawtrzEphedEbm8WsmFc+SdX7ARg51xkycIoMwGQSsMOp2P307wGk8KgQASvDMq/gucloya2rvDCFvep7QMSTINDvkqgVRYoUov+u2nX6+A6+tPNwSO5zjhUGqb+o9pqkAwvb/KwCJ5JTNSKw4LqYjIKcvaJkvinz2qMgNFbhBgESs6Qga/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(110136005)(86362001)(6506007)(54906003)(7696005)(66946007)(186003)(8936002)(2906002)(52116002)(5660300002)(316002)(1076003)(8676002)(4326008)(66476007)(66556008)(508600001)(55016003)(83380400001)(38100700002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnD8DZEeTlGcas7/jOn3BObdWrkrV9GjT9ZiVqDkhytAaETqyb5Z1Vn44Aul?=
 =?us-ascii?Q?lYVzRWYt1N6zDl2giMq+3U2aV68RFansee6w0MAbx9NyYoTmWYTMG3FgKEQi?=
 =?us-ascii?Q?izQEhpf+r1w2VhfGJeLuQa6Z1MWYhR0GjHYNy39JuHT/BvzRMrD/osdyxQp8?=
 =?us-ascii?Q?04AUZuzuWhH5Ol+nTtHrkIdR2vUt7i6bZZLEgOzQQtZGBWqeV+oQMpf+52u5?=
 =?us-ascii?Q?cqroLSsvvTpNVTFjqzd/A8AUD8tdsA9OeHTjjjvtGQgn4BTaFxHOsHt5S0lJ?=
 =?us-ascii?Q?ZS95yQM7/UrpGiVnZeuVRGPc2XKWaNELhar4O5clJNqNxLJdOVKaZAxCcZrm?=
 =?us-ascii?Q?epk9N87uBCnLw4hjHgq1BlDCxr3NiHOlicEhMUpDhP848vl1xDL3Uh5wcDPK?=
 =?us-ascii?Q?j5Yfq526OFYIYXFHqyGe8wU6dN7Jz7OXmQ/x9vU1kFRM60UnLI4XppGsO/9C?=
 =?us-ascii?Q?+ryKBKh/DuC+llSGMRJH8wrNz/WaiONh68ZpU4xMG6f9zCQBzlTzEwZ2Ie75?=
 =?us-ascii?Q?bpBvS7sWYCJDjCRKc0PAxwiwMIq/ZlLl4rm81v+aRRPXEh86d72/l7Ubf6BA?=
 =?us-ascii?Q?0wK9OhY9b5a7EHkIZgmcQ+Vzxo4fUMOG+jATIrNA6sim7JxWZOUTwN+97eI3?=
 =?us-ascii?Q?tBPeC6R2xbmkIILP7Sw1DoA7ZitTfgE7ZA50ECCBNA9nuUF6XddI5B9vc1n2?=
 =?us-ascii?Q?nvYWPDBHi4aP3vWyoMtJFplgrrl4NmnQhf9NG98yuSMRJtdQpNw4T6KXsrxa?=
 =?us-ascii?Q?UOZYQHxkgq30XNsnWbeaFsV+OpawSd4szjWS05mh7F3aGV695Drtm4pTUFER?=
 =?us-ascii?Q?7PfOZlJ1OhIU0p0CxtDGd0zmDtuz6AhlTJjeflcXPIZ60kEqFs/15tUt95q+?=
 =?us-ascii?Q?Jextz2BK1LXmHNMFN06l0r/yQ2PdKPT4GKldm82uhVWS3ofa3cPjMByZfdwW?=
 =?us-ascii?Q?UjXbDhMv+VNLk7bRZ92V7qAgPs690B/9/b7UfPZ9EX0zzC+GCPlFph8PGfye?=
 =?us-ascii?Q?SnwgDfpp2HHZ9VeLEDWwAhIL1PoSDbUAbhx87j4SM5k0Xv276uAiJ4XQO09V?=
 =?us-ascii?Q?oKnKxk/pMd6rTTH/VViVWPXznyhn3ULrwujVtkDnYPC6cSADTXl4rTt28FdY?=
 =?us-ascii?Q?vQsGC0cVU+lT/NAQg0g6u9lGo+5yIMKJdtFdVmfR+8ZVCTTFbJ6veo/kw68P?=
 =?us-ascii?Q?IOyo+FXwKhR5Lld987WqqyayoP7ZEkAR/NycHZETz9tKX7pdSquFMhH5fCoR?=
 =?us-ascii?Q?ty7gaPiJARxF/V8IkGm6ELBiGbKfAbaRd/hwZqL5ttyH5aWca5He43KM/Sbx?=
 =?us-ascii?Q?DuRSUTM+lk0We82XLZUORcVwhQiichCBUft7OgGF7PaQ7hkdsN02JC3+92dP?=
 =?us-ascii?Q?IgGDDggwDjDOlF7GQZj5SISV59CwzuX2nMD06Z9IOCm7GnKvJhA4f+ptLtAT?=
 =?us-ascii?Q?d/8sMe9bvIoMjTiDnsootkc+XuQZsqCq5UnkOgJ3ZwEvhwQ2ZuPDlTtreth0?=
 =?us-ascii?Q?OfLTPE589g+1WEzzukv1/qxlJ1B7PblijrTXwbiYzpp/qR+f6398zEPjL8u6?=
 =?us-ascii?Q?Jsw5wT/vHsGB9GjuFIHFglyDx8/mlUCJ/OnPHjO2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50133196-689c-4d0c-4313-08d9aed0bfa1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 22:29:44.4557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OM0I/kf9VOfaX4obiDBKotaQnINbeallQrHCX08CGDuHX+QlILYx/o3X4OaT1Db
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3821
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: EMcQPMrJyWpn1J04IHTQeNahQq3XcQqs
X-Proofpoint-ORIG-GUID: EMcQPMrJyWpn1J04IHTQeNahQq3XcQqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 10:22:04AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 23, 2021 at 06:11:14PM +0100, KP Singh wrote:
> > On Thu, Sep 2, 2021 at 6:45 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > > I think the global lock will be an issue for the current non-sleepable
> > > netdev bpf-prog which could be triggered by external traffic,  so a flag
> > > is needed here to provide a fast path.  I suspect other non-prealloc map
> > > may need it in the future, so probably
> > > s/BPF_F_SLEEPABLE_STORAGE/BPF_F_SLEEPABLE/ instead.
> > 
> > I was re-working the patches and had a couple of questions.
> > 
> > There are two data structures that get freed under RCU here:
> > 
> > struct bpf_local_storage
> > struct bpf_local_storage_selem
> > 
> > We can choose to free the bpf_local_storage_selem under
> > call_rcu_tasks_trace based on
> > whether the map it belongs to is sleepable with something like:
> > 
> > if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
Paul's current work (mentioned by his previous email) will improve the
performance of call_rcu_tasks_trace, so it probably can avoid the
new BPF_F_SLEEPABLE flag and make it easier to use.

> >     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > else
> >     kfree_rcu(selem, rcu);
> > 
> > Questions:
> > 
> > * Can we free bpf_local_storage under kfree_rcu by ensuring it's
> >   always accessed in a  classical RCU critical section?
>>    Or maybe I am missing something and this also needs to be freed
> >   under trace RCU if any of the selems are from a sleepable map.
In the inode_storage_lookup() of this patch:

+#define bpf_local_storage_rcu_lock_held()                      \
+       (rcu_read_lock_held() || rcu_read_lock_trace_held() ||  \
+        rcu_read_lock_bh_held())

@@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
	if (!bsb)
		return NULL;

-	inode_storage = rcu_dereference(bsb->storage);
+	inode_storage = rcu_dereference_protected(bsb->storage,
+						  bpf_local_storage_rcu_lock_held());

Thus, it is not always in classical RCU critical.

> > 
> > * There is an issue with nested raw spinlocks, e.g. in
> > bpf_inode_storage.c:bpf_inode_storage_free
> > 
> >   hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> >   /* Always unlink from map before unlinking from
> >   * local_storage.
> >   */
> >   bpf_selem_unlink_map(selem);
> >   free_inode_storage = bpf_selem_unlink_storage_nolock(
> >                  local_storage, selem, false);
> >   }
> >   raw_spin_unlock_bh(&local_storage->lock);
> > 
> > in bpf_selem_unlink_storage_nolock (if we add the above logic with the
> > flag in place of kfree_rcu)
> > call_rcu_tasks_trace grabs a spinlock and these cannot be nested in a
> > raw spin lock.
> > 
> > I am moving the freeing code out of the spinlock, saving the selems on
> > a local list and then doing the free RCU (trace or normal) callbacks
> > at the end. WDYT?
There could be more than one selem to save.

I think the splat is from CONFIG_PROVE_RAW_LOCK_NESTING=y.

Just happened to bump into Paul briefly offline, his work probably can
also avoid the spin_lock in call_rcu_tasks_trace().

I would ignore this splat for now which should go away when it is
merged with Paul's work in the 5.17 merge cycle.

> Depending on the urgency, another approach is to rely on my ongoing work
> removing the call_rcu_tasks_trace() bottleneck.  This commit on branch
> "dev" in the -rcu tree allows boot-time setting of per-CPU callback
> queues for call_rcu_tasks_trace(), along with the other RCU-tasks flavors:
> 
> 0b886cc4b10f ("rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set initial queueing")
> 
> Preceding commits actually set up the queues.  With these commits, you
> could boot with rcupdate.rcu_task_enqueue_lim=N, where N greater than
> or equal to the number of CPUs on your system, to get per-CPU queuing.
> These commits probably still have a bug or three, but on the other hand,
> they have survived a couple of weeks worth of rcutorture runs.
> 
> This week's work will allow automatic transition between single-queue
> and per-CPU-queue operation based on lock contention and the number of
> callbacks queued.
> 
> My current plan is to get this into the next merge window (v5.17).
That would be great.
