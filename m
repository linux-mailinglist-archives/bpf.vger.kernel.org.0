Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606694FE6A0
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358010AbiDLRPs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358012AbiDLRPo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 13:15:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F960CC1;
        Tue, 12 Apr 2022 10:13:26 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23CFFEOP006081;
        Tue, 12 Apr 2022 10:13:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wlVn6fY+kYU0+d2DIEXTBmOvS1VyeF2b/+ulkmqFdcA=;
 b=ZN3YOxWDtUcv0OELbjzvuhTUeyxshptSR7wgfCjDBvn8CnwyA3r4gDkDnhF7aiOAUisQ
 JefWbb8iA85rh/m11DlzPsUYh8EMmUXGx/E4FPfXASIxZ4g18mNWa08B5BukRntkA4YY
 28ooL/lrWqE1rvBahr8oq18eXHyWskT1UFM= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fckykh1mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 10:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COpTlTfXAvbYQgGdKtJbu2YqoZavXOjVwHEHnfGyPxI68/uKvgoqnvFs4E1zFiSF1G9lsYjB5Z+DVbeM/lXGYsQLZBLnmu2Q29zFCMjr/0d+AyAPb/HsUITuTFJTps14K18gpWRWh1vD5y4ugXyRow+/0aGbG8gcLTmJAuOdhYZ4xY9B2NpR/2MZhQ53kLsS7/yhV2DE4+SoQwMjfixl3H1UfQ03K18Tmv1LqEsCFAMAc/z4OklMhV4aO4vKF70O0TkgnxCmxF/XbzWYjvQ3Ux46Su809pvjdmLS2dLUhXi32R/Quhtzu3iXN/PMnLcOgF5OGYsSq2zzR1w6ZjQAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlVn6fY+kYU0+d2DIEXTBmOvS1VyeF2b/+ulkmqFdcA=;
 b=RzbgnkJy+9LsfKCBinUJ75HYOAyLPVKWSuQ8bioUevjyGWRt2bjLS2zJjWjnrSeEu8olfCG5OiFNCC/ntEi4J0QJUItQkkMA0mBLF/0CLNo0pqx2craunUuBSulsDIO9U3WuIpz8FId3LT9ALu2AMc4pVcQtv2kU6uqyiCRmnSP1xWBta2rd0Gcgyz+TR5Dg54r4OM2BDup+FUJn0rTqjnr4WxuAoQ4oEXm+9ykAUn4KRLDmKtak8GUZDM/TN27rgZW699rsf1PgQQKzwDWz7D188wkm93lqfrkmKM9VCutr3Gh/GOyCUVcer3dC32l7qE+eDvnGoGAEKvkxfmv/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by CH2PR15MB4792.namprd15.prod.outlook.com (2603:10b6:610:12::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 17:13:17 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::100b:5604:7f1e:e983]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::100b:5604:7f1e:e983%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 17:13:17 +0000
Date:   Tue, 12 Apr 2022 10:13:15 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>, andrii@kernel.org,
        ast@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
Message-ID: <20220412171315.i6e6n3b6v7xclje6@kafai-mbp.dhcp.thefacebook.com>
References: <20220401130114.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <CANn89iLicuKS2wDjY1D5qNT4c-ob=D2n1NnRnm5fGg4LFuW1Kg@mail.gmail.com>
 <20220401152037.GD4285@paulmck-ThinkPad-P17-Gen-1>
 <20220401152814.GA2841044@paulmck-ThinkPad-P17-Gen-1>
 <20220401154837.GA2842076@paulmck-ThinkPad-P17-Gen-1>
 <7a90a9b5-df13-6824-32d1-931f19c96cba@quicinc.com>
 <CACYkzJ4FzbFu5NfdRMParp3Ome=ygVAqQPs2v6UGzRDt2LC6iw@mail.gmail.com>
 <20220405203818.qsi7j74jpsex7oky@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5PkwidPAomc-+js=OTFdzwf38hMO01Q_rbsPM-HZTTkg@mail.gmail.com>
 <CACYkzJ77k7=UwAve-DBkhO7cmBh7W9e6JgFrc3HoHQ3AU1Xfsg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ77k7=UwAve-DBkhO7cmBh7W9e6JgFrc3HoHQ3AU1Xfsg@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 770f5a91-0e27-49fb-04a9-08da1ca7bc5e
X-MS-TrafficTypeDiagnostic: CH2PR15MB4792:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB47925A4C38A3B29157384052D5ED9@CH2PR15MB4792.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRMA7mCHvGk0+6GKPKHcoBxdZIaqd0xLHmjEQBPDXwGWBQMftM8Cv3lGlFdD0TrDukwteHY+QKYEZE+qXmeOFvEfXUJLDPNlJc4peinBKjsrIe6HGIwlsWg+TpVS4oib0HKoKxjwntDChyyVF4XcyWowRkOeUc7X6pD0+XptJP0aBHtu0+j+DAZ37hCD5vG9S/kdXRxlS0kc+vQ2st9+USHmWtwNMcVsmWUNRvaUrLGFAvZI+yCzXR6XRXBHaA/ZuVlOs6LvoORhzfz5f+AU8GvWwhWm9l3ex0BACny56Q9ZwEF+NpBwlP1XXqGFqTnojBB81rIIxjh5VRqP0daC9wEWQhcCr74YucHNSsIMLE3XVvsG7JclIvQSIhYHpJ4l7WlazsJBokJaCLnDfhCJklL395oauzG+ubNn+nJEwgzZfuQ3KQ7PfoRQeMHtIGLq0CO40p36q8yE5VaUYmpVhvNRpebeNG2WYafqKfp2hzyL8/qG4fwhDKIeMNfEwloSpI7gVhZ0txBGq84HTdE4rtGMX8I8t+O7tWWYRijmbOuHg+TcaAOFpEjPZkz+00e4ZECY+HtA3rX/tCOylCUTqBkbAX1qDMacz2tfiQEpQyDtZsnJKFr4NuoB4v60fx9JDkM1gDym6aaSEmVGVeCh3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(2906002)(316002)(83380400001)(186003)(54906003)(6916009)(8936002)(86362001)(38100700002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(52116002)(53546011)(6512007)(9686003)(6506007)(508600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXQee8Mx993YAp2Amdd9FWM6JzSY1XV0uoVtr0fW/6Rr4SvMKF1cZnLjRdoV?=
 =?us-ascii?Q?sw6enhG819u0RQNOgO4f7DU5F80CcZxMZHF3lCuL1sLaW1GRaRDp6+ALSyXu?=
 =?us-ascii?Q?op2D4WEDSgrjpCW53etU8Wq0Lf27Vs860l9nsSzEHqj5nr49vP3RF+ae6Iuw?=
 =?us-ascii?Q?0Kj57NghlWiuCMYa/bRachNjf014f19K3h69vUePlHT0iSFYkYB2Le5dYHXu?=
 =?us-ascii?Q?0TxjJya4JUwa9ErpLBjxO7fH+mVPfLoORC/e0l6JiUbarGyAbo5MJD1jbRTs?=
 =?us-ascii?Q?37rO+FalzcMwLA1334OdSCIOVV/BWlKb56bi7DIVgb8hUGS5uJ82A2sN0YZS?=
 =?us-ascii?Q?GK64ATGerUt9HRMclIXfHaiYNuTnEJvMymYDKD5c87A/xdoOiSnOVFiHJw32?=
 =?us-ascii?Q?qD66g6KDNIDR6yRC0rA3ZczMaQU5EzNPpVPxjSvJNNYBk5Nf1HGUlfgApI+Y?=
 =?us-ascii?Q?PilS0QeQGKuyKmlo4mA+fUpx2WIARp7UVcTvJY4aGgG/6PobDtfYNhGhs/iq?=
 =?us-ascii?Q?PsD/IgNVQ3cc8x7fd+8ntbAmxZgAxWM+2dymuk6+cc4PyWHgaLBUGchM4Z5G?=
 =?us-ascii?Q?ZZh4u1UB8UxpHswbvt2xjekrlVvUPaiziRMvSsA8OSF8lBFbLS+4tFevpUrd?=
 =?us-ascii?Q?iKXWUr8YxnTW0XU6t1O0bAGx9WXNiPj6QEx27GdJShYp+tkI0w7Z0BdJA5Sl?=
 =?us-ascii?Q?e3JRuK1WVo4pskOMLCXlv5KL+xvhyQ1gEXZOD2oZf1ErcTedJWCMAAt6kbPC?=
 =?us-ascii?Q?ZSp2aYo8gXctfVhiTHnSMjBDeR6QIQLgGsEbiNH5oBuR4sx7u33mi3zPDCl6?=
 =?us-ascii?Q?J9/3bltQ2fUkydTBsmoDIx6/+gGxEx+k+Up6O9QwX0c1prFxDORtek8fBDEC?=
 =?us-ascii?Q?XyNDzmi3QYqCtWjnIwYi1pUShe7d6BlgLNWCM1KloQZPGYtX+qgwdTA/gLXK?=
 =?us-ascii?Q?5ezM2jHO/2OnJGiXU7wOp7fWam2xRxblwDlK397eOOQSxtIVyIOmADplXXmX?=
 =?us-ascii?Q?nFol7O6ZBfNqShxzFt5GpxBBErx6yk3uay2rH5DOp3g67SULEetd5BJQxdqb?=
 =?us-ascii?Q?sPpStQqYIypK06AWtrtyKx5e/ej9gIFVQSKVfrVWfylF4CEgKYP2lnVu/7YC?=
 =?us-ascii?Q?TQXjoDfb8c3cnhfWGFjJuwCMI2kWYv+Qczmv9NPZSD+QupF9oD6tWwKy+18x?=
 =?us-ascii?Q?tyMa0Gsswucdcx3d1R9ivZhfnHsp2kA81giOuU12XtcaBiXngCoyjmwlG7S2?=
 =?us-ascii?Q?pB9Vtffni2vQxsjBeN/qY6CLTicAaBnVZulGprfXcX4jOY+pwtT8ZRbByvxg?=
 =?us-ascii?Q?6s03bwaZpa6XT+Vsjv4LMQIGssDKJNANkuLw4bVaiLikxLtOeryIyJckDrWL?=
 =?us-ascii?Q?ttJOE/uHfGGc/w0jRJmGLxLFb9vCIDSXN/GAP23Xf6JYEUnG8iMIIBhNnORp?=
 =?us-ascii?Q?D7tHv13IIcUMdWuSymmN7nMDEnnnqH/BrIi4tUQOzDVgK12GnbvCP2WPf0a6?=
 =?us-ascii?Q?rTLci+tXt2u1KlBh6vW3tsj5txkRUi4U9s2OJbsInExjulLcUmrQsE/L3UgI?=
 =?us-ascii?Q?kJdAwtR1HcQXx+AIvtXhvVMIab9DCXJKmJMxwS+C5nNhtDu9lPHRj0y8sqsT?=
 =?us-ascii?Q?QY7Rn7u3Oq5qv5HU7t5ezZ2O3ICuy8qJsu5yyZLC/XeYHdCIGS21R9LMofNo?=
 =?us-ascii?Q?UMTbOMllqBVgBshsbdhum7OAFKE+ORaVrclxW+VBzODVcpXwSiAUi8Bo5aRa?=
 =?us-ascii?Q?/xSwkMtjxSlKCIKiVnUf6EwU+ymypOs=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770f5a91-0e27-49fb-04a9-08da1ca7bc5e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 17:13:17.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMeRxsk7hrCno3viHlwSEAkppzRalH8NJBc3jNPvxsk9OPAJfw0U6v0FfZGDw5nC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB4792
X-Proofpoint-ORIG-GUID: Jhy6_aaxOZ6MfTaFgRzo92aHYK9YMs7i
X-Proofpoint-GUID: Jhy6_aaxOZ6MfTaFgRzo92aHYK9YMs7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 12, 2022 at 08:28:07AM +0200, KP Singh wrote:
> On Wed, Apr 6, 2022 at 5:44 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Tue, Apr 5, 2022 at 10:38 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Tue, Apr 05, 2022 at 02:04:34AM +0200, KP Singh wrote:
> > > > > >>> Either way, how frequently is call_rcu_tasks_trace() being invoked in
> > > > > >>> your setup?  If it is being invoked frequently, increasing delays would
> > > > > >>> allow multiple call_rcu_tasks_trace() instances to be served by a single
> > > > > >>> tasklist scan.
> > > > > >>>
> > > > > >>>> Given that, I do not think bpf_sk_storage_free() can/should use
> > > > > >>>> call_rcu_tasks_trace(),
> > > > > >>>> we probably will have to fix this soon (or revert from our kernels)
> > > > > >>>
> > > > > >>> Well, you are in luck!!!  This commit added call_rcu_tasks_trace() to
> > > > > >>> bpf_selem_unlink_storage_nolock(), which is invoked in a loop by
> > > > > >>> bpf_sk_storage_free():
> > > > > >>>
> > > > > >>> 0fe4b381a59e ("bpf: Allow bpf_local_storage to be used by sleepable programs")
> > > > > >>>
> > > > > >>> This commit was authored by KP Singh, who I am adding on CC.  Or I would
> > > > > >>> have, except that you beat me to it.  Good show!!!  ;-)
> > > >
> > > > Hello :)
> > > >
> > > > Martin, if this ends up being an issue we might have to go with the
> > > > initial proposed approach
> > > > of marking local storage maps explicitly as sleepable so that not all
> > > > maps are forced to be
> > > > synchronized via trace RCU.
> > > >
> > > > We can make the verifier reject loading programs that try to use
> > > > non-sleepable local storage
> > > > maps in sleepable programs.
> > > >
> > > > Do you think this is a feasible approach we can take or do you have
> > > > other suggestions?
> > > bpf_sk_storage_free() does not need to use call_rcu_tasks_trace().
> > > The same should go for the bpf_{task,inode}_storage_free().
> > > The sk at this point is being destroyed.  No bpf prog (sleepable or not)
> > > can have a hold on this sk.  The only storage reader left is from
> > > bpf_local_storage_map_free() which is under rcu_read_lock(),
> > > so a 'kfree_rcu(selem, rcu)' is enough.
> > > A few lines below in bpf_sk_storage_free(), 'kfree_rcu(sk_storage, rcu)'
> > > is currently used instead of call_rcu_tasks_trace() for the same reason.
> > >
> > > KP, if the above makes sense, can you make a patch for it?
> > > The bpf_local_storage_map_free() code path also does not need
> > > call_rcu_tasks_trace(), so may as well change it together.
> > > The bpf_*_storage_delete() helper and the map_{delete,update}_elem()
> > > syscall still require the call_rcu_tasks_trace().
> >
> > Thanks, I will send a patch.
> 
> Martin, does this work? (I can send it as a patch later today)
LGTM. Thanks.
