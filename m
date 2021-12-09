Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA55646E2D8
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 08:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhLIHEJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 02:04:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231804AbhLIHEI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 02:04:08 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B95tFTg008910;
        Wed, 8 Dec 2021 23:00:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=IT/uFEyB5hW1f6WyRSq8NmVMp+YSIqaYs761RhGvz8c=;
 b=jci0CtO9OL4Bb3JefFKdJxBVj+XNgBDgjlNEVoLh6IDYLCSE/dPmMtvlqPWjcZeiepPk
 pygOvG6fREM3rUC1Z566e3kWozxkDxAsLvh9p1y8VCPS3FhmJl8VvlNlB/5k3tqreF2U
 hkChFm4H5K5bVj/dJfHmdsvCPSRvDNgNs8U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cuc2nr7w2-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Dec 2021 23:00:10 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 23:00:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDdPRN78R2ILb8D9gXVsMrmBO6QV9V0WaJPjGIt5VPrpzoC9yUUqOVO6kyHUvoTtZDQxCfsiXEd74J8GTZH6DO7FGDlJQYwZfS/8C5HwNW6grtb+mxQ3VqnRkOAlLSQreZvxRRUuVNSTsb2gkBIJpIqNvIDVRyiBeRqeepiURGBUgscwvPji47O+EFcgCKPRKN1Ptyy6FKC6lB0cSyuYWMTCA+cIp/tRbbZO90oIfekfWLItUa5vq9QBAQ9zWl7Tu6AbqhHPHAQNJo4LEGlLqRBQhKM4IEpTTeC3s2neO1Nc51CNkba8GnkRXCgQFunhkFF113uREmpbvabcMdSVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT/uFEyB5hW1f6WyRSq8NmVMp+YSIqaYs761RhGvz8c=;
 b=oYVs8ILnD/4+i2NHX54XFgNjyXWReHVfmuVCc0TFEgF0KvsjQ+pPtMd8B0FCFg6/ilHt+5rwnt19BEzXScoMdJLCQc9i92Sf5PrSZdatoya7eAzb6fms35PScLve4DEpWLRTVRJuAXMCwZNiTKiMwENzPqnnAhu2IUeOTQ4y6Dmavxk5LO7A8i1UoBGMOeCwSQuMsuDEyhXiOllWnq/x+xyrthTtHPOkM76Rl3a/s73yrORjh/f0xcyRajnTsLDKVwlexPd6IHIJtG4p2labe3BVRwb68qaiqrR/6bOJiyTl6bxrcARS7fflExVMjQyQQD213mvtw/yMes0sLz/T+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR1501MB1997.namprd15.prod.outlook.com (2603:10b6:805:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 9 Dec
 2021 07:00:08 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%7]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 07:00:08 +0000
Date:   Wed, 8 Dec 2021 23:00:04 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Allow bpf_local_storage to be used
 by sleepable programs
Message-ID: <20211209070004.gj5b4ybrcdxqblbp@kafai-mbp.dhcp.thefacebook.com>
References: <20211206151909.951258-1-kpsingh@kernel.org>
 <20211206151909.951258-2-kpsingh@kernel.org>
 <20211209015938.s2f4wmjtiqagjwqy@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ77G4f_FJ=q7BKCta-rodWiescgEnkqE5U+kAW+=bw5_w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACYkzJ77G4f_FJ=q7BKCta-rodWiescgEnkqE5U+kAW+=bw5_w@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0266.namprd04.prod.outlook.com
 (2603:10b6:303:88::31) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:70d4) by MW4PR04CA0266.namprd04.prod.outlook.com (2603:10b6:303:88::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Thu, 9 Dec 2021 07:00:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515bf643-3b43-432e-64cb-08d9bae188eb
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1997:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB19977B6E0651AAB685419C09D5709@SN6PR1501MB1997.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bNcSDN86jRaK1zUCKzetZA1iGENXQOcOpwjxLTNXQWgGYm3MAsIASB/tBFaqVNixR+7W4p1mFMJLzv7u9K8QldxljAY1hcyh9FEYaiTTY5Sk6ymvQ+B9cb7Cqi3qGYT2vmSX5QlHcXqgJWXYIqBlHamE3sgEYoc3fWP3xmJNrM2w4EI1I/Dn/QKokQ3pCJU/lb8+GTwfx8+pcCLE1Ej4yznY3Mzj4t0iHY2REIhSCNwvd8ihgIQuGpAAnmAwWtHr13eWlWXYymOO6PA9eEvg2hATq8Vzjx8jZZS31PeO0r2hDhLlQuClqrSmqIGToWDr72xoP2LE+99XldLRkrDb4Z9ng0ix1+LOT6F8Djq0rR8DpZDDDgFnXV2OxC7w3s46CycQKyWG2KivbktqM8uHzAgW20yTTCdRudUUNBp7h6fMCc/EY0Rwd+RxjRyYhxex3dO6enRObcJUYFuMaWKhN/l2YfnmGBeFr/QOXcLSmvYFoDWuqsLuRAcNBjNiDnQj+IRvhF0u4VrLrdUze0RWKS2Pi7DXx0phuVe4EV/H5wm59xnysFFSARrmGvt05le+fOTl62eVzBNltbaFao1Iv84C8rzHrZC8BYJQyzrbQ16C++9VfNvE4B711JQBiLGTSnj2QUKIuUguDAhBPFBIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(1076003)(9686003)(6666004)(38100700002)(508600001)(8676002)(2906002)(5660300002)(4326008)(66476007)(55016003)(83380400001)(186003)(66556008)(53546011)(54906003)(6506007)(52116002)(6916009)(7696005)(86362001)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nqXRWvggWm42YMCxoFos8SPpFvuUkgpu/ISsE3gu05I4SpmdUVwUCcmccZCV?=
 =?us-ascii?Q?5QeJIVWawatu5EbPcyT+IWZdRVjvDImPO2E4uM+JCOdb3nHm9rQEgxgQzjSn?=
 =?us-ascii?Q?TEQVbhp/orAgciyLmSRIDcV5igFaAQP67d1Oob1Lpx8PE5vCtKIyiYRJNUrD?=
 =?us-ascii?Q?AusErcrTT1sNPpESMQHNfN+EcNAkgAg5L8tc/BQM1OkNdXFHjHAEDAXGf+JQ?=
 =?us-ascii?Q?JvDHauEstrdZnwPS4B9Io+jc8BuFoHXn5ecYVSYULS35PtoileVH85DBXj7M?=
 =?us-ascii?Q?AG1TTLW1NZ9L8BX6aZg3sXPyDQ6avM7SSx9N+05l1XCdO3+crk5j5Yf1IP12?=
 =?us-ascii?Q?Buf/MP23Kiy6yJiwDBnbZLyH9lUP78dgkIcSOB213E/miZVPq6AthGisfcv7?=
 =?us-ascii?Q?l2einH4vy0KGwR+44GI0x+wBY6c3sAx5a6ilCzeqLVWITeIBzPAbI+JOvHu5?=
 =?us-ascii?Q?eFcRj10TE3O3xjpOZJjjLjBe+IFbc2yaeONHOlHM03rXziPUJusEAzVXdTvK?=
 =?us-ascii?Q?M492MnNunZL8Vg/KdlrOecr64o+66Y57BhbYYaXiRep93hqxR+sicbH+WZ/t?=
 =?us-ascii?Q?/huaoqt3r1PY3FUB3DufuMgCBgilJBSEu49D/qgbkSYBPYrqFt4otzEBAzHA?=
 =?us-ascii?Q?ndd0c8GOxKD9Ra9pA2DO2BWp+0/b+sWIxntGjAaDGJXlj9jwC/C2Shmh5G4b?=
 =?us-ascii?Q?RCYZNHvtCD4V5Ye1JP9Ssps4ynyVQS6/IcdjlsleTTSXS+JEo83tlZepW7BX?=
 =?us-ascii?Q?mM3fD2+2VUNIIDBJhBxvbURX6ftgIs/PaITNQsZoAhaFohP3FPdKczDBmIxJ?=
 =?us-ascii?Q?M49byDjHguCeggCVoUNK6YO5JYacFFp22hgq2/VORIlp/JjbRibr7DM62qKI?=
 =?us-ascii?Q?l46aMP2a61RvsPPBHv8BykFp4xvS098eQ0He+sudiB366Sj2c5usvhu3MKf8?=
 =?us-ascii?Q?sH3HY4M4sGA7OQhwYgD76ce3+QtKG/qsiR+jrpxoa90cvVqLlKN7ly2h0LdY?=
 =?us-ascii?Q?+O3yg3V7F0fQDL3FBtLXp5Gax8w8c05/TVCxaqgsj9JTLXhmS9xJKwgebJ2A?=
 =?us-ascii?Q?17rcQK2lqKFYtn53MvOWHsUG+lVM6PoilfPhH6BwIB7w1zLkcu4Gs2lI5dD6?=
 =?us-ascii?Q?+l5YdmHawjj9j91h8V6DUlMMxp+CisoRgV1GviYMrfAIrM8kDbZaCASRVwCz?=
 =?us-ascii?Q?ReiXpvLJvLETr28TDxYZ00IKaa+yWq3kMKpOXc6Nkn4WkjiP/KfPgrKsfFHd?=
 =?us-ascii?Q?q5/SjyfRs5MgpBWVe7HO6orGyRtdTV3XfQzFoHDApk6VyE/QppJ3QT1G4I79?=
 =?us-ascii?Q?BBjjBX9sLUhBEctT3JD+ttNuKLRkY0qiw/Q98TiS6hSY4jI1nUXkiC+EtrNJ?=
 =?us-ascii?Q?RcwQKmm4uiaXOencW2edLAj4Cl6ldJ47xPaFgyPtY/ddwTHgmM2c8VJrDgtu?=
 =?us-ascii?Q?w66mOcS3aKEDrecc2QDMQ1v6uUrQb+3HqBbB5kJd8chsv/JCtji2kEG83sH+?=
 =?us-ascii?Q?+tu081y6zcSW+i+fTMsgl7hoBurrl9F1HCZfM1zDnC32YW4bt4fo0ra9suLV?=
 =?us-ascii?Q?/rdMleC+hYUhnceGBmCoBbrA5dXDZaf+eH0MTB7y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 515bf643-3b43-432e-64cb-08d9bae188eb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:00:07.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/RCgD10+PPCq/Q7RXR3g0waesCJezIon/r2/42qbLwd8/9/1kxCy2FRQ+u0eZFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1997
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: EkDR8GpAdXCzXvPQDUasFsYAzxQ98wUU
X-Proofpoint-ORIG-GUID: EkDR8GpAdXCzXvPQDUasFsYAzxQ98wUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_03,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=897 spamscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 09, 2021 at 03:18:21AM +0100, KP Singh wrote:
> On Thu, Dec 9, 2021 at 3:00 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Mon, Dec 06, 2021 at 03:19:08PM +0000, KP Singh wrote:
> > [ ... ]
> >
> > > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > > index 96ceed0e0fb5..20604d904d14 100644
> > > --- a/kernel/bpf/bpf_inode_storage.c
> > > +++ b/kernel/bpf/bpf_inode_storage.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/bpf_lsm.h>
> > >  #include <linux/btf_ids.h>
> > >  #include <linux/fdtable.h>
> > > +#include <linux/rcupdate_trace.h>
> > >
> > >  DEFINE_BPF_STORAGE_CACHE(inode_cache);
> > >
> > > @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> > >       if (!bsb)
> > >               return NULL;
> > >
> > > -     inode_storage = rcu_dereference(bsb->storage);
> > > +     inode_storage =
> > > +             rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
> > >       if (!inode_storage)
> > >               return NULL;
> > >
> > > @@ -97,7 +99,8 @@ void bpf_inode_storage_free(struct inode *inode)
> > >        * local_storage->list was non-empty.
> > >        */
> > >       if (free_inode_storage)
> > > -             kfree_rcu(local_storage, rcu);
> > > +             call_rcu_tasks_trace(&local_storage->rcu,
> > > +                                  bpf_local_storage_free_rcu);
> > It is not clear to me why bpf_inode_storage_free() needs this change
> > but not in bpf_task_storage_free() and bpf_sk_storage_free().
> > Could you explain the reason here?
> 
> I think I carried this forward from my older version and messed it up
> while applying diffs, I tested on the linux-next branch which has it
> for the other storages as well.
> 
> We will need to free all these under trace RCU. Will fix it in v3.
For sk, bpf_sk_storage_free() is called when sk is about to be kfree.
My understanding is the sleepable bpf_lsm should not be running
with this sk in parallel at this point when the sk has already reached
the bpf_sk_storage_free().  iow, call_rcu_tasks_trace should not
be needed here.  The existing kfree_rcu() is for the
bpf_local_storage_map_free.

I was not sure for inode since the inode's storage life time
is not obvious to me, so the earlier question.

After another thought, the synchronize_rcu_mult changes in
bpf_local_storage_map_free() is also not needed.  The first
existing synchronize_rcu() is for the bpf_sk_storage_clone().
The second one is for the bpf_(sk|task|inode)_storage_free().
