Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2645F584
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 20:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhKZTzp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 14:55:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231474AbhKZTxo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Nov 2021 14:53:44 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQEwlqP022169;
        Fri, 26 Nov 2021 11:50:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zeuyVRNuU2M9GsiRFVuSGO3BKyX2PbubjTI+i7pLVzo=;
 b=a/Y8kDsb3Sb8H6xo4HyeA/ixrX65TAcpv+XafSnTj4D78cwhTHKHS5MW1TmotAcLIMzT
 XVOdm7Bdm7QY8DHkStETEzBt82dzeMm/4z6w4ixwgMg4TI6qo0ctQ64kU33iRghraxqE
 iRssCD6ENy2T2quL+R38OS08yGwvI+UCyDQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ck1tn9ehe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Nov 2021 11:50:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 11:50:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS/0v6XzfCNSxp/Bx/7yqPXB7exDf4q1GkL0xHMjy0P8LcC17scGnsWdALmk/duDXLziAWBA0z7QDym6xM3Z4WDYC72c4D/k2AhInNQy9MEwX64/WZ0Aa4fMKiDsAH1RG70At5wbSNQR6dax1dskNmKJ1fw6LuQZfZoKeTEjxQoLyL8puKRvrp444KQ5abM1LbMwR0F+AuopMiho5k9cE/eg6YET97ek/tvBZMqUFRBKW+0TYc3h5mQswBnsDt1IYw1WW8EymAi1TGaQMzV2hLTlaj+pRUU0ESVkmIBPpdkVOSuzudbQ/ZYa4W9/k1zWQvGAX65Mq3e0gUd2FEVmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeuyVRNuU2M9GsiRFVuSGO3BKyX2PbubjTI+i7pLVzo=;
 b=duf+vzxIrzo29h1cPFYWVEruzIaixSDfGGqzo6QstIq+XONvhjFkaIQ159ddI4a3KuGTCXYw4IYPO+EG/eLZTkbpF50+X6v8/ItNwzEFTLWBhNKtirQH95mHEmIVI2HTZXEFbd0lrearqwLIP/VHeB86+DJ7DvWHHnkSyU21Nas0Y+wuROqqkksIThP7uVFfYoImfK1fmE5dOVdvEJIp7/z42HJB4nrALU93BRKAQZOivvL8LRC9tDgFUtOn0zD0XB/UMQVZ3JwXZdpIsZiElgIaBuoDB0Le0Dkp6gcJnjydbdPFL7F6cqcr4CCSG5h31U/O+UyikeoXO3HZF6yQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4376.namprd15.prod.outlook.com (2603:10b6:a03:371::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 26 Nov
 2021 19:50:19 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b%2]) with mapi id 15.20.4734.022; Fri, 26 Nov 2021
 19:50:19 +0000
Date:   Fri, 26 Nov 2021 11:50:15 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yafang Shao <laoar.shao@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 2/6] bpf: sched: add convenient helpers to identify
 sched entities
Message-ID: <YaE6d9NhXCN9i2sM@carbon.dhcp.thefacebook.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
 <20210916162451.709260-3-guro@fb.com>
 <1334F6BA-BAE1-4FF8-B84C-3C1AE733CA7A@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1334F6BA-BAE1-4FF8-B84C-3C1AE733CA7A@gmail.com>
X-ClientProxiedBy: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:9cb2) by CO2PR04CA0117.namprd04.prod.outlook.com (2603:10b6:104:7::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Fri, 26 Nov 2021 19:50:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fdb59f9-83bc-43bb-ab49-08d9b115f9dd
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4376:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4376CD6471386E91DD80461CBE639@SJ0PR15MB4376.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5qSUgOB0f1W2x+mEfQv36TTWuSr+hrGDjD3QTrxM6Ep1r60FCJ/ka/yUSQecH+wGedmxSgPwmORjKaysTp3sLt4xYbLy+/ZR37EFni+kdGAcaVa3+8ysTrYGJNy0yovCx2Q/L2T940qo0i7GPCXSF4ts6m57DKa8Y15311/AjOnljwxMVzicGLQ969UkvDdWGPTb6cuhMrHaUf26/FPVgSJBUqlrR8k4HvqGCoXPs0eokGB4bvvBqMacsSF89gqQOxXaWOCgWBLsXj8jl0Ydrn2tKH192BtoaQQXjcw0RaRD5Vb3L1uY4aLKF7VyE8zSwj55PmiZFMncrYevCjfFUgUa2ld6zrJPTWl8Vph2XaJWZZXi4dnM/mIOvUGEhmVeqLlGEa66NoGQOobxEZ35iwno7yAqSewsh1prygyA0QqEdrkC2+Zynit8bnjpaFpsPEcDOuaTJE/FcyV8CYRQkb5JFzLxvlLHfI9iCIUUJ6oBcIpkWdmVSmeerMM25qXI13E/uk8lpi+FohVdmraiEVLOhl1HLSVa7MED24W+8zRCByJyqVEPU9XBNRAFi8az+qlLWCb/ZFtQpKF8tll97olczmUfMLPb4yIQYxu61qh9zfoFCxKCvLLWciot9UCi0m6NtbdCMPJJp17iSnf3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8676002)(8936002)(66556008)(55016003)(66476007)(6666004)(9686003)(83380400001)(186003)(54906003)(86362001)(6506007)(38100700002)(508600001)(316002)(6916009)(53546011)(5660300002)(2906002)(4326008)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A47HAIyOuizpoO2PexLkWZhUBdbsKqAL+MxlIwdgoMKqdnZDllhScSJXhOsT?=
 =?us-ascii?Q?jrb6nKoKBs7Y1SKo+eK1GtvmxxSdXz7tdNd4ILzzFDQEkVgPRfX7eoeYzIOW?=
 =?us-ascii?Q?zRx4U91AmuNZozpKm501+vz5RjbIseNP1ucVu1yUx1nQNhCRCBrNizGv5Wyn?=
 =?us-ascii?Q?BXuNZKRgdswQN4yWu89jBIRpjuWGTkEDWFPgvZW+b2xFKKn98Ou8En2vicTq?=
 =?us-ascii?Q?MbbNPcFLkrfw7E8ssT6r7Mb4L/dzx0N7iuseolXc3xMWcERkUTGJHHyT0bFf?=
 =?us-ascii?Q?XckGXPbELParI7wWhPW3pqO5ela9wWvDhnQuiNJ+qlVXOeaaQV/7yfQbNum7?=
 =?us-ascii?Q?c+UFxVH2Q8e/XTwspPkSuL1R+SGBFr+GUpITZ3wSynFOxYk0lJ3mxBSLR8pP?=
 =?us-ascii?Q?a+MhhsNdtINHurh4Y5ddj8t4YSSzKpp5BDYu3YhTS9o+Mv/2fIPyXhs3m0aJ?=
 =?us-ascii?Q?9ZwM1j1BNStNzPy1W2JJ5u42iuwbPysW7OD2aYAOjx9PAUMXs4NBMb96vxzK?=
 =?us-ascii?Q?vfmSHmpwZ7RGQFmYGiMJGP6GFSCF1nawAePuFmyp/8oijJkEedAmyz1dmPuI?=
 =?us-ascii?Q?T+443khfh17IS9TazrZB2nrcKXZTyTu+gzGeUf07nxVS2yOiZyhJ7qsAnK6e?=
 =?us-ascii?Q?EepB0sIWFREcE6bdzvObbjq1zWfxFqcAXqBgLrP3xcwgpHB4CA+o63d5+WCL?=
 =?us-ascii?Q?EBnw+XvTG/Zw6qzG6Gbrh//VJU5Dr1Luip2APRi10wvs57zPc347puMnaxbF?=
 =?us-ascii?Q?LPwMPREsoU0cznZBXS5jAY+GBDwZav9zfsPa/2SComlf1pONzDugiCgAWWay?=
 =?us-ascii?Q?XqG9mr49VmS+M+9pEKFLqUMOvawXrgkYYP2qKbOpBIxwhhSQ+9t5ITvRlLDw?=
 =?us-ascii?Q?afMF195YZgeEtXEYo18PRFNMDt8IuOmkdjkLYHfpnvYMkD8MkDNMUS5JZE+G?=
 =?us-ascii?Q?+fO61Yek6987pCmgY4d0hODKHjFBpf3vWcbHPtAP/BCxms+iOEhlscngLKdv?=
 =?us-ascii?Q?pu4WzMu4cc4ssj6yiC5eU2F2UbY2JoV33refBCz1rBmK6TZ6FXeJ5Pq4vXib?=
 =?us-ascii?Q?VW7uuoumOMJKGuxRjrqcDmS/oleAdma49aZLYZ+wF2TlE84TXDzUhct+KW2+?=
 =?us-ascii?Q?NOn/C665AcjD3F51HSzAocP5/aIiamWJI10G3jgjQNCq/K0Gs642vXiNdSmg?=
 =?us-ascii?Q?s3ZviVlxsyCFvv8NBsiu+yW9vcqD6fh/Y9Aoy1tTyjSGp5f+CRT094OKajeX?=
 =?us-ascii?Q?9v6L3MqeUyt8yCO+NZGGNSyWWXCH/u2YzlhtqbRFqwxNatalf1+Tn/lHbZpZ?=
 =?us-ascii?Q?20x6jGztJvSgfhDJDZ08dYWyzx2U2pV31xrarZ15oNkMGt7XJJ8wuaAjwY4n?=
 =?us-ascii?Q?W6vc4jM6l6/JCHmhzsp/SbplA/vfdA2ePOKRkW5iKG9cVMDH1EaJ/KNb4l0z?=
 =?us-ascii?Q?d7AlWLwTDjNxn6n7J8LzSiUM8OJoIdY0WWe/5gUCJFeIknNzTGHL4dwthvO8?=
 =?us-ascii?Q?urtHcWj2ypg0hKCL/WOoGaN0eD6C10/nOGV2MC7GnOWBMYi+y7+aRnpA8ap6?=
 =?us-ascii?Q?FfwhcmyZkBBMSfjhMXvNhxS6wPz1cPKtvztln5Xm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdb59f9-83bc-43bb-ab49-08d9b115f9dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:50:19.5278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqdGLYA6nujH3PFX2fxhYwMXPBLVW20WH23em1lzu9Vt2awty9mo6+GQaRwvHiZe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4376
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: xb4I4Q08_oai9UzbWpZ6cfh94JAqbEaO
X-Proofpoint-GUID: xb4I4Q08_oai9UzbWpZ6cfh94JAqbEaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_06,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=775
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111260115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 25, 2021 at 02:09:00PM +0800, Yafang Shao wrote:
> 
> 
> > On Sep 17, 2021, at 12:24 AM, Roman Gushchin <guro@fb.com> wrote:
> > 
> > This patch adds 3 helpers useful for dealing with sched entities:
> > u64 bpf_sched_entity_to_tgidpid(struct sched_entity *se);
> > u64 bpf_sched_entity_to_cgrpid(struct sched_entity *se);
> > long bpf_sched_entity_belongs_to_cgrp(struct sched_entity *se, u64 cgrpid);
> > 
> > Sched entity is a basic structure used by the scheduler to represent
> > schedulable objects: tasks and cgroups (if CONFIG_FAIR_GROUP_SCHED
> > is enabled). It will be passed as an argument to many bpf hooks, so
> > scheduler bpf programs need a convenient way to deal with it.
> > 
> > bpf_sched_entity_to_tgidpid() and bpf_sched_entity_to_cgrpid() are
> > useful to identify a sched entity in userspace terms (pid, tgid and
> > cgroup id). bpf_sched_entity_belongs_to_cgrp() allows to check whether
> > a sched entity belongs to sub-tree of a cgroup. It allows to write
> > cgroup-specific scheduler policies even without enabling the cgroup
> > cpu controller.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> > include/uapi/linux/bpf.h       | 23 +++++++++++
> > kernel/sched/bpf_sched.c       | 74 ++++++++++++++++++++++++++++++++++
> > scripts/bpf_doc.py             |  2 +
> > tools/include/uapi/linux/bpf.h | 23 +++++++++++
> > 4 files changed, 122 insertions(+)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6dfbebb8fc8f..199e4a92820d 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -4900,6 +4900,26 @@ union bpf_attr {
> > *		**-EINVAL** if *flags* is not zero.
> > *
> > *		**-ENOENT** if architecture does not support branch records.
> > + *
> > + * u64 bpf_sched_entity_to_tgidpid(struct sched_entity *se)
> > + *	Description
> > + *		Return task's encoded tgid and pid if the sched entity is a task.
> > + *	Return
> > + *		Tgid and pid encoded as tgid << 32 \| pid, if *se* is a task. (u64)-1 otherwise.
> > + *
> > + * u64 bpf_sched_entity_to_cgrpid(struct sched_entity *se)
> > + *	Description
> > + *		Return cgroup id if the given sched entity is a cgroup.
> > + *	Return
> > + *		Cgroup id, if *se* is a cgroup. (u64)-1 otherwise.
> > + *
> > + * long bpf_sched_entity_belongs_to_cgrp(struct sched_entity *se, u64 cgrpid)
> > + *	Description
> > + *		Checks whether the sched entity belongs to a cgroup or
> > + *		it's sub-tree. It doesn't require a cgroup CPU controller
> > + *		to be enabled.
> > + *	Return
> > + *		1 if the sched entity belongs to a cgroup, 0 otherwise.
> > */
> > #define __BPF_FUNC_MAPPER(FN)		\
> > 	FN(unspec),			\
> > @@ -5079,6 +5099,9 @@ union bpf_attr {
> > 	FN(get_attach_cookie),		\
> > 	FN(task_pt_regs),		\
> > 	FN(get_branch_snapshot),	\
> > +	FN(sched_entity_to_tgidpid),	\
> > +	FN(sched_entity_to_cgrpid),	\
> > +	FN(sched_entity_belongs_to_cgrp),	\
> > 	/* */
> > 
> > /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/sched/bpf_sched.c b/kernel/sched/bpf_sched.c
> > index 2f05c186cfd0..ead691dc6e85 100644
> > --- a/kernel/sched/bpf_sched.c
> > +++ b/kernel/sched/bpf_sched.c
> > @@ -42,12 +42,86 @@ int bpf_sched_verify_prog(struct bpf_verifier_log *vlog,
> > 	return 0;
> > }
> > 
> > +BPF_CALL_1(bpf_sched_entity_to_tgidpid, struct sched_entity *, se)
> > +{
> > +	if (entity_is_task(se)) {
> > +		struct task_struct *task = task_of(se);
> > +
> > +		return (u64) task->tgid << 32 | task->pid;
> > +	} else {
> > +		return (u64) -1;
> > +	}
> > +}
> > +
> > +BPF_CALL_1(bpf_sched_entity_to_cgrpid, struct sched_entity *, se)
> > +{
> > +#ifdef CONFIG_FAIR_GROUP_SCHED
> > +	if (!entity_is_task(se))
> > +		return cgroup_id(se->cfs_rq->tg->css.cgroup);
> > +#endif
> > +	return (u64) -1;
> > +}
> > +
> > +BPF_CALL_2(bpf_sched_entity_belongs_to_cgrp, struct sched_entity *, se,
> > +	   u64, cgrpid)
> > +{
> > +#ifdef CONFIG_CGROUPS
> > +	struct cgroup *cgrp;
> > +	int level;
> > +
> > +	if (entity_is_task(se))
> > +		cgrp = task_dfl_cgroup(task_of(se));
> > +#ifdef CONFIG_FAIR_GROUP_SCHED
> > +	else
> > +		cgrp = se->cfs_rq->tg->css.cgroup;
> 
> It is incorrect. 
> It  should use se->my_q->tg->css.cgroup and some possible NULL check.  (for autogroup)
> se->cfs_rq and se->my_q are different. se->my_q is the cfs_rq of this se itself, while the se->cfs_rq may be the parent.

Indeed. Thanks, will fix in the next version.
