Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE84F4D96
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448815AbiDEXq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352216AbiDEVew (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 17:34:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCA711437F;
        Tue,  5 Apr 2022 13:38:28 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235I0SlN022631;
        Tue, 5 Apr 2022 13:38:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=G9pm8EK0ENnb10Q7P0KlSRdjL+xbMIKSa/PuzzmjC7c=;
 b=PMUNIIjPjGeji4MNiXXSDzslkCpsA+chq9XDBObW6ebEKEPzrb963NmAyQG6KYBOl6A0
 O/VbHuLf6U1uM6kK7GIYNGWAstiK6ZVwyJrYOHxOvIy3IaaxNNm/iBHnzRDaozisFwmr
 ZRtf5S+P/zWpizIH+YNFROVX7GBRd4/6KbQ= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f8k30vk03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 13:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElkApK/KAaRHmvde1k/9FHYKpybd2xs/ceUkSunarzVFKFCTspIg7yI06KPtapj4ygOA4lgEHiyimq6QKgrfu43npIb9EBhNaoYbhw84yOksrbSOqcTkQPC8g55xvo+PfThvG4JeVXIu0INyC2j2IeFZqdzULnWKudbeaaSgf7m9XcJfxCA+5gasOyPNupe5gbco8nirbHOIq0s5R7b3Rl6KvolCSgQuSvwlVcA6uZDiJq1E8r2ABJ3gHlDErRWncz07mYNLD4MCS5NQlRdVo5UfnA70tLI4b/ey3clT04gxhQ6H69zutHm413DNBu6oNHB67Qaq5cVeDezruKPn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9pm8EK0ENnb10Q7P0KlSRdjL+xbMIKSa/PuzzmjC7c=;
 b=BB6WboE7/bSSq45FeuwFYBhoq85kfZSanA5vaBV200z+4D/RRPi1AmSLe9XOu1qYN3eWGav/3e85Y3JPa2DE3rtwEJFUGYMq5HEB+kdG452b7XKeGf1DWu+3XMd4jo+28lBqfRQdT+CCEUP6ZKHOzO2/PpzNdCFX2EVdRHQGdBy0K7Y9qQRVm73d6yJZAIZT8gFz51dI0SboEuaUZQfmqUZ6WXfAUBfVJceimYrd5wz7Fab6KmQn8UudWmgmhA8k4CJGT82TKQrxgj3wLqoHypCGh5gGFY2qEL4rxapLSba+OLmnL00Qw5JHeMn/lrSFLJbGYPEuy4wVybj9sQQj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by CO1PR15MB5018.namprd15.prod.outlook.com (2603:10b6:303:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 20:38:21 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::bda3:5584:c982:9d44]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::bda3:5584:c982:9d44%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 20:38:21 +0000
Date:   Tue, 5 Apr 2022 13:38:18 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>, andrii@kernel.org,
        ast@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
Message-ID: <20220405203818.qsi7j74jpsex7oky@kafai-mbp.dhcp.thefacebook.com>
References: <CANn89i+rfrkRrdYAq8Baq04n_ACq+VdB+UcsMoq7U-dB-2hKJA@mail.gmail.com>
 <20220401000642.GB4285@paulmck-ThinkPad-P17-Gen-1>
 <CANn89iJtfTiSz4v+L3YW+b_gzNoPLz_wuAmXGrNJXqNs9BU9cA@mail.gmail.com>
 <20220401130114.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <CANn89iLicuKS2wDjY1D5qNT4c-ob=D2n1NnRnm5fGg4LFuW1Kg@mail.gmail.com>
 <20220401152037.GD4285@paulmck-ThinkPad-P17-Gen-1>
 <20220401152814.GA2841044@paulmck-ThinkPad-P17-Gen-1>
 <20220401154837.GA2842076@paulmck-ThinkPad-P17-Gen-1>
 <7a90a9b5-df13-6824-32d1-931f19c96cba@quicinc.com>
 <CACYkzJ4FzbFu5NfdRMParp3Ome=ygVAqQPs2v6UGzRDt2LC6iw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ4FzbFu5NfdRMParp3Ome=ygVAqQPs2v6UGzRDt2LC6iw@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a2da843-c6f3-42e3-8006-08da174438bb
X-MS-TrafficTypeDiagnostic: CO1PR15MB5018:EE_
X-Microsoft-Antispam-PRVS: <CO1PR15MB5018B131C43EDA7E75CDA29DD5E49@CO1PR15MB5018.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JW+vT14C1oDP+qYSDRp09BjubIUVth8Hnd1FYXKEFQAhhk2elgbfvRON+3j2ZvTvxYkQae1o8TEUbKDk+y6CygSYy8At9hEzfZ9Tnf2d6vS0qHviHGBc5KrTQa+BElBHgA791l8E2rCfdDGO6YPZoDwcqpG8fVnwvnFAY2Z5JbuvTDzuZ4Vdfur3PYOkzSreM1L0d6rLAy8WJ1QqWEYFJGdEJ9g4Wsna5/5d5hZv1I5hIKspx09K+T9fC/iKlQN/7WHaKy2p114WKT+smjjc76SSOb1/TLlbPClEebHPrIiWoQ6yBMwpOsZ+BBCZBzD0licyym1umlmt5szjr2fz8MnfXnx+N5psBWVGLKI7kQIXCgj4/dyOb7AtBuTHtJxV/hlk62xEymCCV9kkpm0HuTTd4Tf294XCmmvURjXJ8CnX1pOqbXjt2E1jrnGj7aL++O+M81zIY+/YZBzGb99HrvKhWXV8Pj2PpHO1Gkol8KTo6JTXN1U7CUat2jhS6aBxtgFzrAQUjnhABxr6hS/OeSxLX8JDU4XWAmUo9rGJ8h8FexGHihOXBLaN7r3KJxUUdnedPeEaw4B2WOH/nI2ErPZkiKamt1xJSQNIIZ+aS0ag3khUUm6j1CEDqi7XpIlAoerIdMhLMPsaQ9GH7d+oCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(83380400001)(8936002)(8676002)(66476007)(38100700002)(4326008)(5660300002)(2906002)(6916009)(6666004)(508600001)(6486002)(1076003)(186003)(316002)(6506007)(52116002)(54906003)(86362001)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzJZPXpnULOovVS8WOFEa4Y18N5SgJKzkBUcXLcMELLeniEBiPFWDKOB715T?=
 =?us-ascii?Q?aV3YL9drKj3ErFM1qlptQ+g4RDx8EmK7ER7qli1AwS5whYn+UPuvM64NDqdb?=
 =?us-ascii?Q?WVgUhEQJ9L0YF8tDjsjgsr2nb/4OvI/Q0WkswDzksCI4S6krhUbtBvtyab/K?=
 =?us-ascii?Q?QCCLIG9cJS8UDQO5/j+ssh2eLd8R3SgP/SYHmYv0IoczUXUHIqQgZhRTSUi6?=
 =?us-ascii?Q?gD0YB41dhPvD3k6aIr/kXcO7kNC4uPIw2HoGrgLXXFDAs5cQpLP+mrReEfl6?=
 =?us-ascii?Q?/ETo2MB0T+DqqjpHn5PZKSe1MD1rpzgoftUuoAdc/Z1jkiGyRFcER1Q/Q2CS?=
 =?us-ascii?Q?u9gG9txqNGdM5ORJjf8Id7kzTRRsLq/2Wqm/Mtlsi8/kthChuEECim8YxHqH?=
 =?us-ascii?Q?5/Q1Fxx4KPCtxAiibfOgWgqOwpGZcHId1fmGDQKztiTLpXV5sCjEWM7/NzMi?=
 =?us-ascii?Q?dNLkCGu87KLCNzUvkqnIIF6Yp5KxQpHYlIjE21XMLFx4KmOZ1RFOdswQDVZI?=
 =?us-ascii?Q?DXDY5uSRwQYBO6nsPj112PoYhCYXLIk5y6YdWPzeSM7yRhT815iqYrUIcU1O?=
 =?us-ascii?Q?o+Jmlm2l62ywRjesvMFVbhtkqA6g77TtwMNbvmyg6RD7coWFOBTArsf+ilPG?=
 =?us-ascii?Q?z99CTaBkzk+v4bXs/SKm7CEEsg8A9O9GU0x+6cxGqZTzCS3n+ZypkkhTMDVq?=
 =?us-ascii?Q?nBanhWSx/apT9epGSOGxi2kjs+jab6ICFJip5Ft3LXzycbexN1otiSnU69Wl?=
 =?us-ascii?Q?JUC3/CcCalIeVv3Y/Ga14NR+5hI2REHALBOIqLS0KdnTKaFxNTQnAVFAgvb5?=
 =?us-ascii?Q?xMVwxjHpCr67y8cBdft3Yg6rNZxG6NlKs8cuGxbn3YOggv8kYYCc1ffiEazy?=
 =?us-ascii?Q?NDnv/pdcGFKfFUPGkMZ9VJPm3S86v8mfaWZEsWgjr3b51nou7Hz8QgeYy1eP?=
 =?us-ascii?Q?iMSUUpCIkJZqF7r06F0GfLxAK3eXsR9NYDxemu7bEdTNzVSRzSPwHXNwxA3b?=
 =?us-ascii?Q?3axtwCIJgDlhBRFoaGnvZlwDA9oqDqgUwGwxSzksHP+MyUbx8mdHaTu/OqCc?=
 =?us-ascii?Q?1eI6wSJvabD7X723TkcGJ3Isurx+KJDjwPeHPhnOUoAP+JIfzp5gQzNJ8LqG?=
 =?us-ascii?Q?2R3zWU3KHRcVhQjAN+sh/mnu3brHXluOVGcIy7YDt6mx1dG5uFmxHVVdllMU?=
 =?us-ascii?Q?QYoQ+9mupHhY2H3A5xmQ21teuD7PuJDAW/YBjgLBWNuiUUPza6EpZmrnrphz?=
 =?us-ascii?Q?dcta+24MHzVi0IRwIFAyowKAs9gryOL3e+KT3A3tEdNJP4CtFNKaf+X6p1Io?=
 =?us-ascii?Q?1K9T1UdDUqfqag+UoMHCUgKJKf8p+0GvpunJVkZtrdZVs6gCRirS7nlFKLZX?=
 =?us-ascii?Q?YlBy8ZtCglrwu7au9CnDuUWU04zsIm1+Fkf05rDz833TccRZ6nxDq8CrnHWl?=
 =?us-ascii?Q?udffhrPz6HQNta0KWrLQgFRIJ/nneLIQOEjbs1a4EyIjSl94Cm/sHYqFcxXZ?=
 =?us-ascii?Q?8Cf05WG4OhsYWXReL+U/rzdbzHtVXhIDMP/Z5Af7wUc7DSEgLeFAVKbc9EQS?=
 =?us-ascii?Q?QjhFPxDp34f+HMxDxVq1YCDpIoyfgutbgVGFV4vGgL0ua3MK2U/kUQqUgo6Q?=
 =?us-ascii?Q?GhnXRcGSVjGsHrRmhjHWjbLngxQi8k05/sDM3f20araeG3r9tUO8NoSXWqvx?=
 =?us-ascii?Q?bBE9Vb7VSfq3R00oUTCR5at4kpFjsGUDSF2pv8G5d1vqPM+NFreh0ozUCixy?=
 =?us-ascii?Q?cviBGUlAPERbD0Mjn9Bu/8eUntrMu90=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2da843-c6f3-42e3-8006-08da174438bb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 20:38:21.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T62uQYzYU/Wjs5CgVe7S9b4SEn+TK7hXkkq3T2kmkLLwfD+dMC2A6dexDYuA/5j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5018
X-Proofpoint-ORIG-GUID: AUG7KrGawhcCdhm4pYL46_m1rAsYMCTo
X-Proofpoint-GUID: AUG7KrGawhcCdhm4pYL46_m1rAsYMCTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_07,2022-04-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 05, 2022 at 02:04:34AM +0200, KP Singh wrote:
> > >>> Either way, how frequently is call_rcu_tasks_trace() being invoked in
> > >>> your setup?  If it is being invoked frequently, increasing delays would
> > >>> allow multiple call_rcu_tasks_trace() instances to be served by a single
> > >>> tasklist scan.
> > >>>
> > >>>> Given that, I do not think bpf_sk_storage_free() can/should use
> > >>>> call_rcu_tasks_trace(),
> > >>>> we probably will have to fix this soon (or revert from our kernels)
> > >>>
> > >>> Well, you are in luck!!!  This commit added call_rcu_tasks_trace() to
> > >>> bpf_selem_unlink_storage_nolock(), which is invoked in a loop by
> > >>> bpf_sk_storage_free():
> > >>>
> > >>> 0fe4b381a59e ("bpf: Allow bpf_local_storage to be used by sleepable programs")
> > >>>
> > >>> This commit was authored by KP Singh, who I am adding on CC.  Or I would
> > >>> have, except that you beat me to it.  Good show!!!  ;-)
> 
> Hello :)
> 
> Martin, if this ends up being an issue we might have to go with the
> initial proposed approach
> of marking local storage maps explicitly as sleepable so that not all
> maps are forced to be
> synchronized via trace RCU.
> 
> We can make the verifier reject loading programs that try to use
> non-sleepable local storage
> maps in sleepable programs.
> 
> Do you think this is a feasible approach we can take or do you have
> other suggestions?
bpf_sk_storage_free() does not need to use call_rcu_tasks_trace().
The same should go for the bpf_{task,inode}_storage_free().
The sk at this point is being destroyed.  No bpf prog (sleepable or not)
can have a hold on this sk.  The only storage reader left is from
bpf_local_storage_map_free() which is under rcu_read_lock(),
so a 'kfree_rcu(selem, rcu)' is enough.
A few lines below in bpf_sk_storage_free(), 'kfree_rcu(sk_storage, rcu)'
is currently used instead of call_rcu_tasks_trace() for the same reason.

KP, if the above makes sense, can you make a patch for it?
The bpf_local_storage_map_free() code path also does not need
call_rcu_tasks_trace(), so may as well change it together.
The bpf_*_storage_delete() helper and the map_{delete,update}_elem()
syscall still require the call_rcu_tasks_trace().
