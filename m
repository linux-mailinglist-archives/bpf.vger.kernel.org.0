Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D687B45B0A2
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhKXAVz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 19:21:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23682 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhKXAVx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:21:53 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMeruZ031297;
        Tue, 23 Nov 2021 16:18:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=p4FVatV8Acxds6qnY9kRVuLA7cBqWkczOKQktC6MnPM=;
 b=piFlEukNPOkbh0x5pV4h5sQQHdjNPvSoZrMDlTIALh2rEuS/I2gFvYx7pJBgXo8in7PQ
 0IUBDKIgM+QxRD/iv8FCIOHE+dk2fgVmw4avSXJmb9dwOUHvlBmhOAsInBski+tmh/DC
 B6yExPErEf+PVLAUdlP9t0Wur9V8Q4hM+/E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch0wp4eu9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 16:18:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:18:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOYrMkb6WDRUHoY/SOQoeKM987CyzMqoBbdFz2SazaThYeNHrxNlwOnxA89ahlMkDH3ggT4B9c8r34Xh/NvweAEUHXjAZ/i43RypxLaf5btgkfUP7MQrbT8XwmapS+wNxl2spEmMPWKGtpd4zEJSkvd3tP6elDNt/7cdsG3fK4PeC0eb6LN8JNh0Lk5IAadVxx14O6t9JzTwvtuOSfUZdbiyrCRkX7T2gnxv21+132LTFQrBplYDft/cx5hhZ9yCtIwGNlG5bn20E1uf90ilt0jXASucz0/EPlM/KYGEiNZoO2yui5kaTaAH/Jru/0spqz7cAlq70WphJSEykFgLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4FVatV8Acxds6qnY9kRVuLA7cBqWkczOKQktC6MnPM=;
 b=UN+WApT2hBZ8KmnetRWXhAJHQtNxaiv/+2eAt6fBL8/7jW56bdUoULUEQYFREexR5pFAxG4fLZ4cPo6qQwKojsnQjS/jv0xMcyUQ8T3icp/kED1cIeLOyZTi+D0MXAf6VVmxBqRKxpTOykQ7hHnwZZ2Fj4VkK7xfI5S9K8cSF9+P+U/mXK0istYakuOtx9aUn7rrw9ZhB2oJFBdc3fM578+tO2bCL7uBcEm7BBN7amTbQQ1nJaZL02uuV+YNsK2obsVP5umUllL5+wDVRtxIMonNFa1I7keBPkTftkg6tbA+4OtkPPqEXY82NCLUWKPrSAeRO60VO3R3lYZ+uz+8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR1501MB4144.namprd15.prod.outlook.com (2603:10b6:805:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 00:18:27 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%6]) with mapi id 15.20.4713.024; Wed, 24 Nov 2021
 00:18:27 +0000
Date:   Tue, 23 Nov 2021 16:18:18 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     "Paul E. McKenney" <paulmck@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20211124001818.43fl5b7npaiaoj7k@kafai-mbp.dhcp.thefacebook.com>
References: <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1>
 <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
 <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1>
 <20211123222940.3x2hkrrgd4l2vuk7@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ6TP19iV3hstamRge42R-7uKynbMQKcMHVLzCyTVEzVKw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACYkzJ6TP19iV3hstamRge42R-7uKynbMQKcMHVLzCyTVEzVKw@mail.gmail.com>
X-ClientProxiedBy: MWHPR01CA0037.prod.exchangelabs.com (2603:10b6:300:101::23)
 To SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:6c43) by MWHPR01CA0037.prod.exchangelabs.com (2603:10b6:300:101::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Wed, 24 Nov 2021 00:18:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d56ddb9-74e2-4b40-4247-08d9aedfef5e
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4144:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB414466D73487F54B93561361D5619@SN6PR1501MB4144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPtqMJepg/mRLTai+El/p+FUQ9pyDkhKt+aUpQ1H+tgPemntl6JetAymljmz+hd76B2y4gzFdvlujd271OpouzSU99LWgE2m1/2pUO7SBbPiTmDvgOhs9kqdXth6sacYY2f8nZLn2EwuZj5UZqNBLa3qBRNs7nJugbysHzNBH8+XMYSMu9rA9Vx1S3wYymNvUGyk+/HOfAfS7mbSaKVt31sWCtW6Jy9TcdMtAgF8EMHvkpO0NMosamzZtBd6pZNEo3J4ADsjd3CPs2Avfqe837PoFA8B5G/t1+zQjf7FUtdXYfxs1lDJUOyck58TFyMv1bfDKTJHVM6vJli2BrX87DOWXyqlQB9arZkl3NXViK9IAzAbzgNZgZtjp7Wlto0UUAnIf+7Q5VUSl1UJV6nAEpFMFfUkTfgxKV5QS5m7gBWwDKNI8lZ4HRv4J4flHa327pO2Qnkerh21fswiNB76Csv/h208c3bowbsJvdRBN83frR7f96A8hCXEn1VoIrtWvefUNnhlboj/NUSfi5srKF13KDWmQslNJDsZ3GSBjesa9xWzHTYkswiPlMBW3BJAlhYVt8Il7WFywn8N7aVO+ZgoNY9bNturyBOZLQ4OhQEwL8G1tkQqnlus4VF4wdJB15c+wY22s5e/vKkFoyc5dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(38100700002)(8936002)(8676002)(86362001)(55016003)(66946007)(316002)(6916009)(5660300002)(6666004)(66476007)(66556008)(52116002)(7696005)(83380400001)(9686003)(508600001)(4326008)(1076003)(54906003)(53546011)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbyjLEMq3CPOc70z/4TI/18PM3aEJEYeUsGer0h9/JaJKXITgqqnxdeVd91t?=
 =?us-ascii?Q?EdtlRJ4zGzwiVIxXGyMW49odLSpL4O9HD+rpufxVWaMmJmbVejxdaK3nTX/X?=
 =?us-ascii?Q?7X7JI4gO/2CAe7aKNJPJozEeByMGvxk61En4nl0IdaBTR7VV5CCDfAiptwh7?=
 =?us-ascii?Q?FIF2xXwZ93wMciiO70Aehbrn8vj/mITkMDJitfxUTM+iNKGCy+tmMtLRL8Lv?=
 =?us-ascii?Q?6woCtfT/zoYeaHmH5qtP9+aEB7S2mGhgrOrjDr6Y1JkWjf8hXP+9cO37GpDy?=
 =?us-ascii?Q?BUdBQNrVfuPh5Ra1PrGkvB+Rw9OEJsGI20G47XcfFimiBN+aNzS/QsbgcW5G?=
 =?us-ascii?Q?iuPh9ukKkplMmweLtMd5ooKljLYU5XKvgI3Gtu3vkPZUQGC+SCgbUmuDnDrQ?=
 =?us-ascii?Q?UDXNBOImJkGWtgzhbUfdwfmorCiJ02P92bkJeQU6C/Yb2SpZ6hoqRYtn63NH?=
 =?us-ascii?Q?eBhyri6KXw2tuqs4BIKA/8qaRunvwqgePK86SOlqbmVEZmT2D6sneF9ECN0U?=
 =?us-ascii?Q?tze+mN6WhrLOTiG5V5D/JavqMirN5jz3ParUDRJTOLy67vwLgvwJhnQvTKj4?=
 =?us-ascii?Q?bBHUTev2fzJB3Gnrv92HdWGaU2PwWyriIcKpearTIEvo4WNqwswp9t4q1L+m?=
 =?us-ascii?Q?6tmGfnuYoatIp2qDwRyTp4T1+Y325neLWt3n74ObvpkOezSkm8mMnd6fX5hx?=
 =?us-ascii?Q?xuK3HKMNwUEvQ+Y6xt7yMrVqU10TWWRykU4F9iqXhz1LvgWC3SGvQclaYgVQ?=
 =?us-ascii?Q?UAwdI9WE7/BUudpsgmhzswwAvjeLXZnDGtWbn3fICSqc74Xjw5SXnaZ0w/Rf?=
 =?us-ascii?Q?7gnVRmslDXfUbUsYONXRTjveUX5l3LgmyC71eIsb8pzbuj4RVTEZOyrurtxF?=
 =?us-ascii?Q?EIi2N+u3SD+3aD45Mkarj8mV0azshyz3oqh1R5xO9jVg92yqB66F2Hnhf8Yh?=
 =?us-ascii?Q?3TAU2qBcOpNFK9kwVwIAgMOywMLUThxlHlzM7xvJ/HXoc8qNwxQxr7NBItRZ?=
 =?us-ascii?Q?WmmrBInFnSUy0s+lTMAs7Rm3q8z8e3AODSBr2F2xIOHY45nmOEdlpYkMGukj?=
 =?us-ascii?Q?BuKKdJTkJMtApLrqUiBUMxC1xyqJ8e41q0/gGvP73eGncfrrj23CCINRiYCJ?=
 =?us-ascii?Q?Rwk7Zc73ueIutco1yiXWQiG9ByswCa7oTn1KSnDLGaaXRv0+Zj9NiQgDUKe5?=
 =?us-ascii?Q?9Fc9dNnUUBRWBRwAjUIaiG/DIjQqgmXfeWbKMRHv/gIB+BsIsupUyPzw++F0?=
 =?us-ascii?Q?jhOe/Hc79q48olpmhnDP9pcMZ95b/ZVsaLYiu1+A1/5S+8qy/jJvHsVVX4/h?=
 =?us-ascii?Q?TWQS0L66rmMtWFz2xB+A8eKdA27YBqSOqM4p3pH5Gx5GEoN/FyEF4cY6HD8V?=
 =?us-ascii?Q?RiUpF8sD9E5PFojB71R0AGTYzCDbAgubRK3Z+xt/H1jRp+iKZUDeqnkfQ1IN?=
 =?us-ascii?Q?RJ4iNcVxj8LIX4GHlRhg9dlgZWsTmUcoNYz5EdpqwmfJ3kmDTNtXDqZOwpve?=
 =?us-ascii?Q?TyPw9fF5pUNyBVVUZLZ7cu8XrONA+ARzKRnIGLRHv3yFVs3eZaOPdpv4e5de?=
 =?us-ascii?Q?Hj4y6ppOgR/SzaWVCA8jMFCL82U7J8sM4/pEkXdw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d56ddb9-74e2-4b40-4247-08d9aedfef5e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 00:18:27.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6XAzwkrI7KO3UIhHtJnpX6MDTqF+Lkaegf2yzmPGyjoFrppohBSglFnkNrpE3bx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4144
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: zUmslrmdDOg_CfOI1pgzeHFjNDf_QBOW
X-Proofpoint-GUID: zUmslrmdDOg_CfOI1pgzeHFjNDf_QBOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=918 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 12:14:29AM +0100, KP Singh wrote:
> On Tue, Nov 23, 2021 at 11:30 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Nov 23, 2021 at 10:22:04AM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 23, 2021 at 06:11:14PM +0100, KP Singh wrote:
> > > > On Thu, Sep 2, 2021 at 6:45 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > I think the global lock will be an issue for the current non-sleepable
> > > > > netdev bpf-prog which could be triggered by external traffic,  so a flag
> > > > > is needed here to provide a fast path.  I suspect other non-prealloc map
> > > > > may need it in the future, so probably
> > > > > s/BPF_F_SLEEPABLE_STORAGE/BPF_F_SLEEPABLE/ instead.
> > > >
> > > > I was re-working the patches and had a couple of questions.
> > > >
> > > > There are two data structures that get freed under RCU here:
> > > >
> > > > struct bpf_local_storage
> > > > struct bpf_local_storage_selem
> > > >
> > > > We can choose to free the bpf_local_storage_selem under
> > > > call_rcu_tasks_trace based on
> > > > whether the map it belongs to is sleepable with something like:
> > > >
> > > > if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
> > Paul's current work (mentioned by his previous email) will improve the
> > performance of call_rcu_tasks_trace, so it probably can avoid the
> > new BPF_F_SLEEPABLE flag and make it easier to use.
> >
> > > >     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > > else
> > > >     kfree_rcu(selem, rcu);
> > > >
> > > > Questions:
> > > >
> > > > * Can we free bpf_local_storage under kfree_rcu by ensuring it's
> > > >   always accessed in a  classical RCU critical section?
> > >>    Or maybe I am missing something and this also needs to be freed
> > > >   under trace RCU if any of the selems are from a sleepable map.
> > In the inode_storage_lookup() of this patch:
> >
> > +#define bpf_local_storage_rcu_lock_held()                      \
> > +       (rcu_read_lock_held() || rcu_read_lock_trace_held() ||  \
> > +        rcu_read_lock_bh_held())
> >
> > @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> >         if (!bsb)
> >                 return NULL;
> >
> > -       inode_storage = rcu_dereference(bsb->storage);
> > +       inode_storage = rcu_dereference_protected(bsb->storage,
> > +                                                 bpf_local_storage_rcu_lock_held());
> >
> > Thus, it is not always in classical RCU critical.
> 
> I was planning on adding a classical RCU read side critical section
> whenever we called the lookup functions.
> 
> Would that have worked? (for the sake of learning).
ah. ic. You meant local_storage could be under rcu_read_lock()
if we wanted to since it is not exposed to the sleepable
bpf_prog which is under rcu_read_lock_trace()?

It should work after a quick thought but then we
need to figure out the needed places to add
an extra rcu_read_lock().  What is the
reason for doing this?
