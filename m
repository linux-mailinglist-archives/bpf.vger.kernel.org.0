Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125F647B352
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhLTTAI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 14:00:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233889AbhLTTAG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Dec 2021 14:00:06 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BKGc4l3030419;
        Mon, 20 Dec 2021 10:59:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=36t50wgd48AlKjMzmzlddHnqiWYTqashvRmut9xMucw=;
 b=NKi3kNQZCmeQuUFnjdAQtLKscCvttEAWDUXe50pE9z9lQ3nMMM/UIx6Mg4XRSjslhxVR
 qR0PlqXv8nnOE60QEeu0ZNzSzwLp835/mzbdTiQlXJ+JfYSHUiiiCAglBxfHF7/uyGvR
 EAab+hJFURHlA0a7y7eIHRBLtsZb5gIi2eA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3d2kkucxcg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Dec 2021 10:59:51 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 10:59:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHjFuJVJYuZwSFUFQjsQ8+xvzDpgINvjWnm0BIvG5Fz74AuSeBfc2hPutdI8ifPLqu9VaPgEleGKy0DjBsUm0qZoWsoXI2NC4J826J6X6WUycxBKoloa2yi6fCTYUaw0AaHI4X4+sOqbhVP2ZmuKip+NimYjgFShz+tS7MVr7Esce0u4+IWIXKVqcdDcHWg8nHqBDaCNxLyZriWG/yyGkqpiI5locPSqiQzqpQT/0whMhDkPB1Wbhr0JoyvuFbF4qx6e0RhYjYEL43MeGETliNKCyym/4cl5WfNytjcDD/3nUJB3rOG3ZCU/Pzr9V26dIzI25J1Lg9LzzKZJc1t5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36t50wgd48AlKjMzmzlddHnqiWYTqashvRmut9xMucw=;
 b=ibN3YRmfhgj8GTq63/aSiF4Xc28nsB3p8PW57ad5nyUpKdV15RBC3UNDoWdkAloymUgc3NQsCukFIBFGZ4KtUnggmdn+kbcnskYBs3ftwPzX2cACXIJQvATWVGpoVCqFXbhpIrbvkM/mvP7UAJQDbw9BzgjygEs5gFVA1fdDtTOTDzoh9hyMYOwcbK2Vl30w/I/MNbmFbO8spQiTa5bWZMC1EVbbhmSN0bwWOsPbF7AVeZAN6K4+CCDXbzqsO0Ni7kawpxbT3qwJgW1o8r8EDHAtlCVpwXKAsUEOxrewQb/NSGeTM9l1Xsp00ia/DyaK5fBsHRx+LihnhqiB8gHU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4369.namprd15.prod.outlook.com (2603:10b6:806:190::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 18:59:49 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%8]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 18:59:49 +0000
Date:   Mon, 20 Dec 2021 10:59:46 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Allow bpf_local_storage to be used
 by sleepable programs
Message-ID: <20211220185946.wx7r5vwwcnarcyfr@kafai-mbp.dhcp.thefacebook.com>
References: <20211206151909.951258-1-kpsingh@kernel.org>
 <20211206151909.951258-2-kpsingh@kernel.org>
 <20211209015938.s2f4wmjtiqagjwqy@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ77G4f_FJ=q7BKCta-rodWiescgEnkqE5U+kAW+=bw5_w@mail.gmail.com>
 <20211209070004.gj5b4ybrcdxqblbp@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211209070004.gj5b4ybrcdxqblbp@kafai-mbp.dhcp.thefacebook.com>
X-ClientProxiedBy: MWHPR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:301:4c::24) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a26dad41-2114-4f83-f1b7-08d9c3eae594
X-MS-TrafficTypeDiagnostic: SA1PR15MB4369:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4369E7AF52585D2434966266D57B9@SA1PR15MB4369.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfUmstIKSJZwgXx2a0ofhyQ7mVD3fh9j3NthugiAWfD0+XeyRjeniIQBvP0zLEBmJkc+QFMsOVSYBgRJHzuqCDY7ruI3j8QAf7t3eoEo/3vcgcz1jMbfAd84EOF7xBQOXWFSGUXBf9fOrf+xWc7rJ1p5cwYDRYPnTq+ZLCuTrdtQTOd/LyORc6CCKM/T4Ghl4l4b5D4TLzxSNz+FxY0t6Nm+k8/vIRHQgCleeHqF0uZ8A4kZRaSYxc9ieAd9D/Ml5cJzgRHaY2cW7w+dKuvfaaG/SdmoAf0YQ1iqhJXlVMa3VVaBulPalLrsi3ZROYL+mas0vOiocjhAuiZhoDzE7zJVx+7viOejYMaEVjrEayXvB+Ho9sq3NE0y47MBVWUMa9BUzKZ5qLOPaUUbjVQF87H0gA6v1O2nC0U0Hw40CTGFbW1VB/49OauERa2ju5uRWBMQ6zGsmCeNy3bLkolcaAW6rvMwANJssJL3DxL+eITtio8osZYcWz1osKFH+5ABjcF27WjEjrrEXvoz0cu+v6CK/Xo/bsXhXp3Y0QILvO3CaF9Q+N3vjUwFBLjRJpOiS/JpikzmfGRxQfNcxpypsoxIUFvZpxc/ofo6AaR276f6Hrd7GfK635+vFN25/OhqXpYG0ZlZuZ/7JXBu/CwLHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6666004)(83380400001)(52116002)(54906003)(4326008)(316002)(8936002)(5660300002)(6916009)(66476007)(66946007)(8676002)(6512007)(86362001)(9686003)(66556008)(6486002)(1076003)(186003)(38100700002)(53546011)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sp1RXK0G9PzelCFTm84wMwdYJlkdXO1Vd/+TlDx/4Nk2995ZrtSLIKGUkPt?=
 =?us-ascii?Q?I00D72zWWzMqsDlLdks9V0GEk7GSmVSaleeDmtR1OuWQNbpb3WJzBqLQ1BSd?=
 =?us-ascii?Q?zC9cVwzZmDnTykyvz7i/t1AvYZFztoZ6TAXbq7ejNPCsAKOAHC1vUSodvLJT?=
 =?us-ascii?Q?yffOucbsXIq3jmY3f86Te7mM/61eHobhbneXvUYwjxaqjenKNKiIL1H45Npz?=
 =?us-ascii?Q?jCtbgHmyHB1DySnRrc05aAyz8Por3BAqhKBciE8kbG6mGS9gEMDqRO9qtTOd?=
 =?us-ascii?Q?eR/OT9g6AEbmsD7LpYyxQcCQ+IFBYPefQ2I8rYZOxSlE3gZmlgx0Z5BhcTKC?=
 =?us-ascii?Q?Xbs4nkBaZR4dvXGj25I6mIb0pys0lysIs0lgHGRYZFx1zebBGVM7GVJe9c2n?=
 =?us-ascii?Q?zyNAD2N9zkhrXNB3WwjHM49tN4pd4TfGxYk+jNg2DS7bhhMnllTyj3BQz3lT?=
 =?us-ascii?Q?7vcT3mi8OyyVEBArrIdd3ypmde1vrU9X29vkowcm0Q4G6nHde9/wys6QDAeL?=
 =?us-ascii?Q?wMAq9+AbAF73n2+qRwiFR4BifULdcfs6aE29eVKn6vGLTZRHe5hbZyZPUnPd?=
 =?us-ascii?Q?lk77kpqkjEzITC2EBdfr9DDIfHLsjH5FoUwjSEL6SxU4S6mvxjxsLvgYqZq7?=
 =?us-ascii?Q?ZD+xUkLv3aeg4EXYgntuVxqntTs/tu71MEJ6VRqpFsQxNVxXOU7KIfH9W+2s?=
 =?us-ascii?Q?acd4qG68jP6P/oN9AYCXvaOSh8EG7HUz2RLhJ/EE6m3xmrxkjM6Mt+Nvj74S?=
 =?us-ascii?Q?JLDu/qQg5saNNMse3k8w7kGwJDIp6kHrEv3QZjGb0NizmudNQlASBmjyfzr/?=
 =?us-ascii?Q?7SUcs4ULcSm161JXx8H4R+RBXKRuY7TnNUxSV1PVwQcBABU55hZAFMpZoRyv?=
 =?us-ascii?Q?fkMbwOfRgwVdHNGqUPJri7i5FTOl4yjRP9TkMCtTXxm5AhuxzxvPQsCys09e?=
 =?us-ascii?Q?YQv6JiqCyG2uOU+DoQDJtcdD6zwLCaN9zmZ75K2MNnNNuHKpE+ut8l3/OGpJ?=
 =?us-ascii?Q?BWjwwJT/ysOHa4Flp2mqXDZnXys1EutS4dwEVccJUIPfoZDQn9ixy7McZNal?=
 =?us-ascii?Q?a4W+YT4jADSOa3qq9Ric5wqen0MGCSQ7XEY8snJOljQm8NqVHMibYsJNh/NG?=
 =?us-ascii?Q?PScZlUOkwXSRn9PlR3KPP5QYh6ZR6A6NqoH9kNwPqlSaHsDLBfnlvxIOjJvm?=
 =?us-ascii?Q?0MRnYGgLRnCPnE0cZjfoqk4q5wWFgwtUOeNA4Oj6FRH7GZykXaMDoaUeWxcF?=
 =?us-ascii?Q?063O/c0XkTOzHp/CXfgfZPSlpWdd3aHZYx/uEyV2MlhJZ8ingYQnc1YcNgio?=
 =?us-ascii?Q?CUOvnjg0boqwcgj36SyPHHEj+lOL8sgJwgAPv5HSLusBMpyYliV3ADN4mhxZ?=
 =?us-ascii?Q?nfv/xuEqCGYixKgqOt6MgDXwgM8nqxKuFGux6Ox+uzIj3r0mOUedZntO05xo?=
 =?us-ascii?Q?lQ6e7fX5u8RFyB0T0stZ/81usk5z5xI09G5a+jSwj5jz7uyBUSYfSbmfXFIk?=
 =?us-ascii?Q?uKRbFCexaXUrjPPppn7FmdsG+XPhDyK6yPHthGxchdj/75lB8QZY3g39KkBQ?=
 =?us-ascii?Q?kzbiATkqk6z4PwRJV+zLycedalD+Sc4V/ylvspYj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a26dad41-2114-4f83-f1b7-08d9c3eae594
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 18:59:49.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuSyGGET8Ie79Qji1J4Yh6n7NzIHfvtmdMO/JgT7W9qSvLT9g2Vy+AXjyQmxm1wT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4369
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qjhMZxxeCH-hr8ImN_Mj-Ib9zD_IchVC
X-Proofpoint-GUID: qjhMZxxeCH-hr8ImN_Mj-Ib9zD_IchVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_08,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=949 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112200106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 08, 2021 at 11:00:04PM -0800, Martin KaFai Lau wrote:
> On Thu, Dec 09, 2021 at 03:18:21AM +0100, KP Singh wrote:
> > On Thu, Dec 9, 2021 at 3:00 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Mon, Dec 06, 2021 at 03:19:08PM +0000, KP Singh wrote:
> > > [ ... ]
> > >
> > > > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > > > index 96ceed0e0fb5..20604d904d14 100644
> > > > --- a/kernel/bpf/bpf_inode_storage.c
> > > > +++ b/kernel/bpf/bpf_inode_storage.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/bpf_lsm.h>
> > > >  #include <linux/btf_ids.h>
> > > >  #include <linux/fdtable.h>
> > > > +#include <linux/rcupdate_trace.h>
> > > >
> > > >  DEFINE_BPF_STORAGE_CACHE(inode_cache);
> > > >
> > > > @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> > > >       if (!bsb)
> > > >               return NULL;
> > > >
> > > > -     inode_storage = rcu_dereference(bsb->storage);
> > > > +     inode_storage =
> > > > +             rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
> > > >       if (!inode_storage)
> > > >               return NULL;
> > > >
> > > > @@ -97,7 +99,8 @@ void bpf_inode_storage_free(struct inode *inode)
> > > >        * local_storage->list was non-empty.
> > > >        */
> > > >       if (free_inode_storage)
> > > > -             kfree_rcu(local_storage, rcu);
> > > > +             call_rcu_tasks_trace(&local_storage->rcu,
> > > > +                                  bpf_local_storage_free_rcu);
> > > It is not clear to me why bpf_inode_storage_free() needs this change
> > > but not in bpf_task_storage_free() and bpf_sk_storage_free().
> > > Could you explain the reason here?
> > 
> > I think I carried this forward from my older version and messed it up
> > while applying diffs, I tested on the linux-next branch which has it
> > for the other storages as well.
> > 
> > We will need to free all these under trace RCU. Will fix it in v3.
> For sk, bpf_sk_storage_free() is called when sk is about to be kfree.
> My understanding is the sleepable bpf_lsm should not be running
> with this sk in parallel at this point when the sk has already reached
> the bpf_sk_storage_free().  iow, call_rcu_tasks_trace should not
> be needed here.  The existing kfree_rcu() is for the
> bpf_local_storage_map_free.
> 
> I was not sure for inode since the inode's storage life time
> is not obvious to me, so the earlier question.
> 
> After another thought, the synchronize_rcu_mult changes in
> bpf_local_storage_map_free() is also not needed.  The first
> existing synchronize_rcu() is for the bpf_sk_storage_clone().
> The second one is for the bpf_(sk|task|inode)_storage_free().
KP, if the above comment makes sense, do you want to respin v3 ?
or I can also help to respin and keep your SOB?  Thanks.
