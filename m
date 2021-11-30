Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C3462A8D
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 03:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhK3Ch5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 21:37:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20538 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237616AbhK3Ch4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Nov 2021 21:37:56 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATIlAx0003208;
        Mon, 29 Nov 2021 18:34:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3xeEYzOXZ2yS9cxkE9wMRry4ijpiJYAxDWSZhfxfzUY=;
 b=XAKyeSQaMfM2hfZcF0Dfn/mTpmv6W8EO909EL6Vw/T39FQOxPb0qOEq3sdgVvO9KwlNg
 HjiiB+sG7jSO5zXl9ECphqAGEyHmbASM6SRNat1cS20OgdoyC4CwgdJPz5qQkXsU6KFP
 R+hO3N5R7cLdO2oyyuv0nWvk/9yztm42Bd8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cn1acvcy1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Nov 2021 18:34:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 18:34:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLIYwYWTPihiIcoBgFQWQ3qZUi6UJgRNulOBDqMIXjzuvxrq6Lya/5lhXRwxNCUn4dibznQkPhQ70yXQHftP1tBoSw0iiFgjUcCQWBMq1t58k53RTMRFP/3+djKWe9dmJz+1ieZWZ7Dwj8ofcFB2peyjzk/cq0pyBp8afdFqjgLwpfVZRjoNdT8Te+K2KU3jdUjBVPdNHBeSnK/YeIsXpmQISVCc35Yg9jHM00JVFbnwUOpi95mRDwjtSEZcIb8hZ645QgdwcfogazMAZwKbm5GfSAnXBUKu/oqEjVBmpohD+8EM1yzDPX/uiBiGR+s/Pbw95R2S7M2I2ue2L2T8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xeEYzOXZ2yS9cxkE9wMRry4ijpiJYAxDWSZhfxfzUY=;
 b=HvfHqZ0lVbRHwxVNEE3+v948UvlHQuRathopgFkbkGsIRsSWgxus+oZIB+3oIhl1PAyR97PVY4MmXE9iIo4X/0gxaCKYFeQr6xUWpPizJXf0TfDxp/REi1EvoqJxNU0igmsDokb05pAXEEuTEIHVOoD/XIY5VjcjTBxvJcYrPQmHPNPYF6l9/CiRP6ywxLQXiQeAViSWVmey0h/+ff77FxWm5H0j87gXTRI3Gvrmn2UGMfvaFNl00KlBysreN4J2cs34M5OrY7/uAAMAWHPhLUv8cfpGTIn6MBYIr3m144YmAyMhwxFGq1JEKSai1atXTRBRj7KFn1eeliYJFOgMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4594.namprd15.prod.outlook.com (2603:10b6:806:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 02:34:14 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::e589:cc2c:1c9c:8010%7]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 02:34:14 +0000
Date:   Mon, 29 Nov 2021 18:34:10 -0800
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
Message-ID: <20211130023410.hmyw7fhxwpskf6ba@kafai-mbp.dhcp.thefacebook.com>
References: <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1>
 <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
 <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1>
 <20211123222940.3x2hkrrgd4l2vuk7@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ4VDMzp2ggtVL30xq+6Q2+2OqOLhuoi173=8mdyRbS+QQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACYkzJ4VDMzp2ggtVL30xq+6Q2+2OqOLhuoi173=8mdyRbS+QQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:1f47) by MW4PR03CA0293.namprd03.prod.outlook.com (2603:10b6:303:b5::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 02:34:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6779bbb7-4d51-4dfa-4b6c-08d9b3a9e61b
X-MS-TrafficTypeDiagnostic: SA1PR15MB4594:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4594574239569103E6390B97D5679@SA1PR15MB4594.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: giDWskw8tbn3YEAY3weEmtRPDlNCzEOxeZ/BU8RS8a32feSEdFiHjsjft5lk6dW3JCJKFSDL9QUetencfWL3XYalhsygKUDpvUnI4d6IBnrf2t4hEEyYpPiyLR0dl8M2BZMhBJOQ8VbRJkH3Jxa1CZoV0Iq1qpQZ3ojW3vvJegSWpwAO7DHVEHqWI7NOkpNUm0N9SU27K0n7/XeWmzwGuZV1RIB98bRBcJ0YR1Zf/RMVV7pQaJrjjckaY4EO6pMqDix294M7Jnzj4aHEGGJXl+l4T2OJxehdbeW29Bm5i1IqrT2EXrAYnIexxJ8EG5z+F3PX8u0xpou9G92T+zDdEiuiOvamW8BWSM915FqtaS5vTin5kLQxd4KcF4bNMrW75a9aeXQs0hzM9c8VyrUBHD6WSnbII82Td9Y3zxMzJ0YmafusMCQH87d66mIpQoLQFA1KTrAQ2/M3XpALSrsE4nnmZtGWlEJPtQVx2r3uiE8b9oqT5cfLyz3QZYjHgzBg+sTnphwNuktfSOxdkQ088Xm41aim4oQVPc3bL1F1ctfDRv34LqA5Mh4GMZ1Y3FteIpRImh6LXbvjFG4d/mxxR+cHjs/q4q+unk7Ee3ifsAfhVZEVrl6mHqaXVh6eJsgzLFdnXE+hbiUoguJ1IRrHWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(2906002)(5660300002)(8936002)(52116002)(508600001)(83380400001)(6506007)(4326008)(53546011)(55016003)(7696005)(9686003)(186003)(66556008)(54906003)(66946007)(86362001)(66476007)(6916009)(316002)(8676002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0fBRakh+cVsgO01fcDhowKjrOtGpbII0iobv/J2eB/iue5NVC5ydREdqqiV?=
 =?us-ascii?Q?RjnVxrWgZ3rPmWwIvAdtIQ7gq9xe+/CfLJyc2o9U6V5745WmLf8vvLzquDQH?=
 =?us-ascii?Q?Ue1w2WupeNY/28nCMDl6DE98zKYmVKqAaHINSxGu+WBVY5MmSSkuZkXjvNBG?=
 =?us-ascii?Q?rvTaDRe3vk9cqSfaCTwoR2Rk54FA/BGXnC4hKhE3m05WHccszkyRbKjhAXWb?=
 =?us-ascii?Q?g5BP4Pl9KFurX6QepoGliI9byvAqLULWbmW46LGJrWQkU9JTngp5mji3RhFt?=
 =?us-ascii?Q?8FpNpLqmbw7me4UMS7CGH1f1YJ7WjtxBl5ZlnQtHTzn83XbZnaTzFEkDmJ3S?=
 =?us-ascii?Q?rXlfSeYnxo59rvaJ5epoH9SkLKF21evdeM5BzxzEwIunY7X6tcAgX0N47Tut?=
 =?us-ascii?Q?+wmMqSS4EEckSW+jws63qhyk2SmFgzuAKefzljq8s4cOqGc4fU9cKbHEoulr?=
 =?us-ascii?Q?aRlm5gjzWlGQO94O506fCSQiyedJ3IwXF0IULn/fLP1AfJtpQnOacvFNmHM/?=
 =?us-ascii?Q?rsR4ohAsUYA0EZjeS3kDjuAqzyRpvQi0Xk922KyM3db5OVbr7ZkdCfuRWbOV?=
 =?us-ascii?Q?PGsuhRISEQUf+rhR6BEr+tOv6L6OraHGktYWXUX0t69WyodidQVgNr2P98Zc?=
 =?us-ascii?Q?y+LIpma/3aptrCBoZqZNLyakBpLnYLJ8UFgYBsUfLTLp5wIxlaunTlq7LRgv?=
 =?us-ascii?Q?rq2AIxi0r1302eXy8fhiORHEwTjvXbtmdAkpoB0kCjcZOMioF+beRm967/rL?=
 =?us-ascii?Q?fZJ5MFQezvjKcSMGHoCPIGpybZr1Mep2sfnFSAiSrAGDR+FzwlfnKbB25SuJ?=
 =?us-ascii?Q?zywWOi313n34kqPgYXI7hbkLt5dPopXcEXAAkIsIjvMZEDBUnGuxbQe2h50T?=
 =?us-ascii?Q?H8f8cOyJqfpT3Mdq1/XeyLYZShJ8enUk5PSjJ9B1yX79ETt0UE45ehbC7FSn?=
 =?us-ascii?Q?1W96cum1GExhN99o6LcRnnTSn9vKHodv5XxNN3k4Iu03VZaRD8xdmIMjMzvh?=
 =?us-ascii?Q?ZNdIhdjqAXyIR9FbpHQFkp2x3K0TJ+Jruitkd29jExRlhBeHPFyCB28w+7eG?=
 =?us-ascii?Q?8KqJxSIhH9crmJxnGEnEMxQo+cG02MlREmvkPWfpJGZX+s4LthYL8199qdel?=
 =?us-ascii?Q?SguFZA+kwfCHwyyz0pgJ0c5qg3/6YsoFuUwCnvSQQ3uvSJTpNkDehTRI2XWJ?=
 =?us-ascii?Q?GLU66kJLN0N20SyPOYYsbpe5K/+6qjLbq9vMSESik7dtMSEGZvAc93FvztMU?=
 =?us-ascii?Q?U3g1rguE7BN23GNglY3ES1+ilzumnpfkJ/tKACWm8P4NP0HBByuvpCU9PuL3?=
 =?us-ascii?Q?DLwNN/F7dICiYowZj8xyXd+NT8UIpBQ5721smmYH/M25hXjfAo87rjmK0BT6?=
 =?us-ascii?Q?sYoTwnxXvvZMqyuyqu+4ESQZB1oRFsr31ThKLhwt/OlaXwFL3jchel362BON?=
 =?us-ascii?Q?/ml1Igpt5Xggmic8U6Pwv8w+pspUwPO9JiLL2T0cMAronNvPRxpTw3f6fue/?=
 =?us-ascii?Q?cW61r3BMh6lycebSV8VwrEa6cOebv2rluzshZuQT9Z3Fy7dm+xmPCgNmkUXk?=
 =?us-ascii?Q?d1kU1aHDk1ifByR913dNlNypyEXkGgoBopzh9Wra?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6779bbb7-4d51-4dfa-4b6c-08d9b3a9e61b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 02:34:14.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCFAkT2kwGExehmeYf1MVSEHEaQDpG+yu237YfUoATOU51Bf46BoQr79yW0F5ge0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4594
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: yi_VK7UdnXetMO2Qm4bo8UNEO_CZfq0A
X-Proofpoint-GUID: yi_VK7UdnXetMO2Qm4bo8UNEO_CZfq0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_11,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 11:20:40PM +0100, KP Singh wrote:
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
> >
> > > >
> > > > * There is an issue with nested raw spinlocks, e.g. in
> > > > bpf_inode_storage.c:bpf_inode_storage_free
> > > >
> > > >   hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > > >   /* Always unlink from map before unlinking from
> > > >   * local_storage.
> > > >   */
> > > >   bpf_selem_unlink_map(selem);
> > > >   free_inode_storage = bpf_selem_unlink_storage_nolock(
> > > >                  local_storage, selem, false);
> > > >   }
> > > >   raw_spin_unlock_bh(&local_storage->lock);
> > > >
> > > > in bpf_selem_unlink_storage_nolock (if we add the above logic with the
> > > > flag in place of kfree_rcu)
> > > > call_rcu_tasks_trace grabs a spinlock and these cannot be nested in a
> > > > raw spin lock.
> > > >
> > > > I am moving the freeing code out of the spinlock, saving the selems on
> > > > a local list and then doing the free RCU (trace or normal) callbacks
> > > > at the end. WDYT?
> > There could be more than one selem to save.
> 
> Yes, that's why I was saving them on a local list and then calling
> kfree_rcu or call_rcu_tasks_trace after unlocking the raw_spin_lock
> 
> INIT_HLIST_HEAD(&free_list);
> raw_spin_lock_irqsave(&local_storage->lock, flags);
> hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>     bpf_selem_unlink_map(selem);
>     free_local_storage = bpf_selem_unlink_storage_nolock(
>     local_storage, selem, false);
>     hlist_add_head(&selem->snode, &free_list);
> }
> raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> 
> /* The element needs to be freed outside the raw spinlock because spin
> * locks cannot nest inside a raw spin locks and call_rcu_tasks_trace
> * grabs a spinklock when the RCU code calls into the scheduler.
> *
> * free_local_storage should always be true as long as
> * local_storage->list was non-empty.
> */
> hlist_for_each_entry_safe(selem, n, &free_list, snode) {
>     if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
>         call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
>     else
>         kfree_rcu(selem, rcu);
> }
> 
> But... we won't need this anymore.
Yep, Paul's work (thanks!) will make this piece simpler. 

KP, this set functionally does not depend on Paul's changes.
Do you want to spin a new version so that it can be reviewed in parallel?
When the rcu-task changes land in -next, it can probably
be merged into bpf-next first before landing the sleepable
bpf storage work.
