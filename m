Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A35B3FE898
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 06:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhIBEp6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 00:45:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38698 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhIBEp5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 00:45:57 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1824ic1D000754;
        Wed, 1 Sep 2021 21:44:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YxMG04chYy4MRjv+iYrryE3NbK/JKobx+XI3Ud+gwmM=;
 b=Sv+BAetvm6LVauBQZAzVw00iEAqMU1LOR2P/FNpVuGesTSyVrkULvcu33L/ThAUGio6D
 RPQCohid/IpWxs289HsTUXQclo4GC2PctggNzFxoOQiRMjVtrQ6H+OFu2J6oUWEHj2RI
 qUqtL0b0KeGetdPvPJYSymp7UZwzO4t+voM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdxv66bv-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Sep 2021 21:44:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 21:44:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpl1/Of44wMNDcqMHzFs5fbxlKbviT2WCxd5Bms/NkSs9CNbipM4ONSTNVWvlwYgk1eNfEG4w2adZnSw3PPJBb/uvFEyhF7E98ruDE96ZMoKOiaMBldeHI1Nt/cKOLHGjMTW7ewQ81G0D1dCyhYB9ovayAYjZBUNdCjEfOrDbBv0fUnXKkTXM7XUR2W+FD4zS4ApTeCVxmirnd+1nCsPNhPdsUVZ2bCln0B3fUZywDI7upIV9D1bgKCjgcdOjw24O86ZTjdztYIFyU9jGKVEI8Xqt015LXPd2jcvmbtcNPTk/jxsQUB5z70qYLjnVGgkZlv8CP36MveSQl+f0TjH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YxMG04chYy4MRjv+iYrryE3NbK/JKobx+XI3Ud+gwmM=;
 b=EXCefUlfuV70CMQhmNShqFj78Q0HEBRIheZER7ALp5Lf2w0mHRvy/DQT0GA3+xKNqwKTfNT3n46gJohuFudEpXD4w2KXmhNUoMUhRgLiQBISpS35L12rbgghMVxT+rmgbiBjFpalVReVkIKyFmlyeq5gTFOxFLWrlKgsRnx+r28QdBzh0MSs7i3iMQg4TudslPEP48ykPfKo20SmexbDdd9TcmGByDlbF/R/Y2xXsyD/6BrlFtTBWy7pylnUNdCLnXnszOCOUscY8t0PytF2wHYgtbohuapJ5a7KflYyfG7pQwpiUr3+RhIf7M9mpLJajJW5C0LW/asxUtrmAaIB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4806.namprd15.prod.outlook.com (2603:10b6:806:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 2 Sep
 2021 04:44:33 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%9]) with mapi id 15.20.4478.021; Thu, 2 Sep 2021
 04:44:33 +0000
Date:   Wed, 1 Sep 2021 21:44:30 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
References: <20210826235127.303505-1-kpsingh@kernel.org>
 <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
 <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a1b) by BYAPR08CA0030.namprd08.prod.outlook.com (2603:10b6:a03:100::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 04:44:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1901d1f1-e91d-4fe6-2e37-08d96dcc5bf7
X-MS-TrafficTypeDiagnostic: SA1PR15MB4806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB48063D6BBDE3D6FE5B5425ABD5CE9@SA1PR15MB4806.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46ykkAyXqLNl2WOO2VGjeBgKO3d5/Iu9l2v+7slUultykx1TpLsb8PGLFawcvSauS67FMjQTGbn7O2RjitFJBflXn4ftzy0LzwlelC1SyRDLMY5OxBQ4jacyp7b4VZgxH3ec54o1j0crSj0B04gFOabapj6Z9uEUP253KDu4XVXJGHGMOOw0EOZSbOdEZaHm9Ja9a94ApresonUphxJbAb6gBqMkmZQbhAZEP73Sl42ePPm73nQgup0cD0ZQgGPlNe/MJM++j7CHynR+Ug7MIveM9s/O3Y6WQeI941hJSPIj4qAT+KeVJT1QP37MKxL2/RtThU99v6I1u5eVI91kvJ0YWKiY/3HQDDpw4hvYgaF80wNS7ZdiK+bd5RGsVmqhzrhP6FSQZVRttz2yMk+gtdiFSqaAoelH5QGp89oyrwqJKiZUc8lip/JiNkdLEV0PqB8jB9WEBVV9gW01ctMEt1nI4y3lx0GTbcDacFOBQnCGd6Qr+3yy1Dl3dSx1XniMktXw8nxoJJ3i5Qo9pHS6Sj+mP3ZNMMwAmw1Vfd98PzeKZl1kWfQy0LD5cRKEoTXjm5x2uyiTe0zm6m2UuOrXRMGXAdhfZz8LkYYXkHx3IMeRzuTTRekuCy3T6zr2e7NigxNUvZdSdcITxyF6jtKD2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(54906003)(7696005)(52116002)(83380400001)(9686003)(8936002)(186003)(1076003)(6916009)(5660300002)(316002)(478600001)(38100700002)(4326008)(86362001)(8676002)(6506007)(55016002)(66556008)(66476007)(2906002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MR8o4cUgv08ljm0qLSTOwKx6s2+Ti691Lf1NpQGGcSzWdS0q3CGSn0Vc342z?=
 =?us-ascii?Q?DBL6AcZmL0qhVKIsV7TPaX7FoOeJB/kgeSddhrxaSI33skKMgVd4QOKNFJB/?=
 =?us-ascii?Q?I1aBEkBAm7xD6nLtOpkXyzyfU4ZhxsxjN5linq8q5x5oiDtzbCIF/vAiMNU3?=
 =?us-ascii?Q?7fwbqJtbDtFfBhLS34sktFJ4OUeVqN0TURyRqEB4w3pJ9ybPdbli9fmTNWcb?=
 =?us-ascii?Q?SWhHMTlspT5pKjwl1PXR7KRxaooR/eXPAlYcqZSNo77Q5Teym95ZXvHoY1wU?=
 =?us-ascii?Q?pD9JtKc3lvY5j1On1eNnfSzjIYukDrnZ2NzPmrcjL2/bfi1gjw/hp1JXKBq6?=
 =?us-ascii?Q?MsWsR+FY45f/pNaEDZHk6FdCpUHYS8j97r5OUjrJQJShg1dqbYklLIPqhjEd?=
 =?us-ascii?Q?C2OCXGfHroT8pfbjSoU7L3AIooCDHsG3ImNTKRHxfHq7XcT/9TxtxiJ+PIC+?=
 =?us-ascii?Q?EOXW58oK7HgiPR4qBkGhRRyLIsBJ6ur+eCQKQKc3KQUJK005jeQOIurPmueB?=
 =?us-ascii?Q?BHBX0soZoYyjLcupGnjCxjPNwJxd7bRyxf9BT86hawUWUhmdWE6y7C6IY5Va?=
 =?us-ascii?Q?5fil0hGPTIMbv4GzpdtuPntCPG+FkLpdjBNiCKiE6PQuiDwTpOD1TIm77AVW?=
 =?us-ascii?Q?NsQZk/nnoBUZvFj+lQr9XInLQUiMOCQnCxDeMwwj2buFT7auieHEo7rKEKR7?=
 =?us-ascii?Q?dVaOwo/3g8eYrf3luheDlT8pivqJeDNYFidQqCP5JPfJ6np1YpkA0obnwUqW?=
 =?us-ascii?Q?Edg2+QO4obp6SJf+/gOBgU/usL0la8nsppqFjgYnX+R2Zw0Ry8zAxhf8ywfS?=
 =?us-ascii?Q?8sB4JcUFQyNhI/R2BJnCp4ORSpYUVQKhV7Y77H7pXNgrQ51QPAKb32knAeL1?=
 =?us-ascii?Q?0p+dPWBNGk+z2mUO4P35bxKKqyMtJBY2Yy/oWHfCAusBZG+e6Vd4XYGMErqe?=
 =?us-ascii?Q?3BmJcSvRHIiScOC4k9ClZZ7irokMAJ1IgVGmB8GLbmeoEbACohVUX3met5ZK?=
 =?us-ascii?Q?6CbrOPP7uG9DpEed9zJB3JmmcSbirpJIoBfSDfvQCMNxUd8J3K5Y/Ud465mu?=
 =?us-ascii?Q?Rj/fkGuMc86icGhITSOs2LTicbg6M7iaU1W56Otvv1MU3fM94C4TIGPLxsIC?=
 =?us-ascii?Q?07A2d8hjuitMnvOHJ+mPE2cjeuKbChcfs2EYFVWYqF0TzVQulHLpwABdWxRE?=
 =?us-ascii?Q?wLg1tqCBQBMOCmT5nsWPVgo/IAhHXFt3tDwJusJiuUeIRsjAHv+jZJONMPL3?=
 =?us-ascii?Q?MPES4Yciv3GQQTY3bcuSSldb+0bUOCoQ8ptKyRDjPpQO44a6mwPthX/8LPwc?=
 =?us-ascii?Q?dCuLV52gGgzRoSJd/QUEcNuxBbpdr7R8Eg+tJiv6Mh5YJA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1901d1f1-e91d-4fe6-2e37-08d96dcc5bf7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 04:44:33.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYaS0qP07GepVggy4qKXYnYcbPH5KcjBWHLt6/fGKK7sRJgDI0gkZdcoBoHaftoW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4806
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -DnjymhClPLbSSF8m-CFjXhCIv5Ox9qZ
X-Proofpoint-GUID: -DnjymhClPLbSSF8m-CFjXhCIv5Ox9qZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_01:2021-09-01,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 01, 2021 at 01:26:05PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 31, 2021 at 11:32:17PM -0700, Martin KaFai Lau wrote:
> > On Tue, Aug 31, 2021 at 09:38:01PM +0200, KP Singh wrote:
> > [ ... ]
> > 
> > > > > > > > > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > > > > > > > >           SDATA(selem))
> > > > > > > > >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> > > > > > > > >
> > > > > > > > > -     kfree_rcu(selem, rcu);
> > > > > > > > > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > > > > > > Although the common use case is usually storage_get() much more often
> > > > > > > > than storage_delete(), do you aware any performance impact for
> > > > > > > > the bpf prog that does a lot of storage_delete()?
> > > > > > >
> > > > > > > I have not really measured the impact on deletes, My understanding is
> > > > > > > that it should
> > > > > > > not impact the BPF program, but yes, if there are some critical
> > > > > > > sections that are prolonged
> > > > > > > due to a sleepable program "sleeping" too long, then it would pile up
> > > > > > > the callbacks.
> > > > > > >
> > > > > > > But this is not something new, as we have a similar thing in BPF
> > > > > > > trampolines. If this really
> > > > > > > becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORAGE and only maps
> > > > > > > with this flag would be allowed in sleepable progs.
> > > > > > Agree that is similar to trampoline updates but not sure it is comparable
> > > > > > in terms of the frequency of elems being deleted here.  e.g. many
> > > > > > short lived tcp connections created by external traffic.
> > > > > >
> > > > > > Adding a BPF_F_SLEEPABLE_STORAGE later won't work.  It will break
> > > > > > existing sleepable bpf prog.
> > > > > >
> > > > > > I don't know enough on call_rcu_tasks_trace() here, so the
> > > > > > earlier question on perf/callback-pile-up implications in order to
> > > > > > decide if extra logic or knob is needed here or not.
> > > > >
> > > > > I will defer to the others, maybe Alexei and Paul,
> > > >
> > > > > we could also just
> > > > > add the flag to not affect existing performance characteristics?
> > > > I would see if it is really necessary first.  Other sleepable
> > > > supported maps do not need a flag.  Adding one here for local
> > > > storage will be confusing especially if it turns out to be
> > > > unnecessary.
> > > >
> > > > Could you run some tests first which can guide the decision?
> > > 
> > > I think the performance impact would happen only in the worst case which
> > > needs some work to simulate. What do you think about:
> > > 
> > > A bprm_committed_creds program that processes a large argv
> > > and also gets a storage on the inode.
> > > 
> > > A file_open program that tries to delete the local storage on the inode.
> > > 
> > > Trigger this code in parallel. i.e. lots of programs that execute with a very
> > > large argv and then in parallel the executable being opened to trigger the
> > > delete.
> > > 
> > > Do you have any other ideas? Is there something we could re-use from
> > > the selftests?
> > 
> > There is a bench framework in tools/testing/selftests/bpf/benchs/
> > that has a parallel thread setup which could be useful.
> > 
> > Don't know how to simulate the "sleeping" too long which
> > then pile-up callbacks.  This is not bpf specific.
> > Paul, I wonder if you have similar test to trigger this to
> > compare between call_rcu_tasks_trace() and call_rcu()?
> 
> It is definitely the case that call_rcu() is way more scalable than
> is call_rcu_tasks_trace().  Something about call_rcu_tasks_trace()
> acquiring a global lock. ;-)
> 
> So actually testing it makes a lot of sense.
> 
> I do have an rcuscale module, but it is set up more for synchronous grace
> periods such as synchronize_rcu() and synchronize_rcu_tasks_trace().  It
> has the beginnings of support for call_rcu() and call_rcu_tasks_trace(),
> but I would not yet trust them.
> 
> But I also have a test for global locking:
> 
> $ tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs "NOPREEMPT" --kconfig "CONFIG_NR_CPUS=16" --bootargs "refscale.scale_type=lock refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make
> 
> This gives a median lock overhead of 960ns.  Running a single CPU rather
> than 16 of them:
> 
> $ tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs "NOPREEMPT" --kconfig "CONFIG_NR_CPUS=16" --bootargs "refscale.scale_type=lock refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot" --trust-make
> 
> This gives a median lock overhead of 4.1ns, which is way faster.
> And the greater the number of CPUs, the greater the lock overhead.
Thanks for the explanation and numbers!

I think the global lock will be an issue for the current non-sleepable
netdev bpf-prog which could be triggered by external traffic,  so a flag
is needed here to provide a fast path.  I suspect other non-prealloc map
may need it in the future, so probably
s/BPF_F_SLEEPABLE_STORAGE/BPF_F_SLEEPABLE/ instead.

[ ... ]

> > [  143.376587] =============================
> > [  143.377068] WARNING: suspicious RCU usage
> > [  143.377541] 5.14.0-rc5-01271-g68e5bda2b18e #4966 Tainted: G           O
> > [  143.378378] -----------------------------
> > [  143.378857] kernel/bpf/bpf_local_storage.c:114 suspicious rcu_dereference_check() usage!
> > [  143.379914]
> > [  143.379914] other info that might help us debug this:
> > [  143.379914]
> > [  143.380838]
> > [  143.380838] rcu_scheduler_active = 2, debug_locks = 1
> > [  143.381602] 4 locks held by mv/1781:
> > [  143.382025]  #0: ffff888121e7c438 (sb_writers#6){.+.+}-{0:0}, at: do_renameat2+0x2f5/0xa80
> > [  143.383009]  #1: ffff88812ce68760 (&type->i_mutex_dir_key#5/1){+.+.}-{3:3}, at: lock_rename+0x1f4/0x250
> > [  143.384144]  #2: ffffffff843fbc60 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x45/0x160
> > [  143.385326]  #3: ffff88811d8348b8 (&storage->lock){..-.}-{2:2}, at: __bpf_selem_unlink_storage+0x7d/0x170
> > [  143.386459]
> > [  143.386459] stack backtrace:
> > [  143.386983] CPU: 2 PID: 1781 Comm: mv Tainted: G           O      5.14.0-rc5-01271-g68e5bda2b18e #4966
> > [  143.388071] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.el7.centos 04/01/2014
> > [  143.389146] Call Trace:
> > [  143.389446]  dump_stack_lvl+0x5b/0x82
> > [  143.389901]  dump_stack+0x10/0x12
> > [  143.390302]  lockdep_rcu_suspicious+0x15c/0x167
> > [  143.390854]  bpf_selem_unlink_storage_nolock+0x2e1/0x6d0
> > [  143.391501]  __bpf_selem_unlink_storage+0xb7/0x170
> > [  143.392085]  bpf_selem_unlink+0x1b/0x30
> > [  143.392554]  bpf_inode_storage_delete+0x57/0xa0
> > [  143.393112]  bpf_prog_31e277fe2c132665_inode_rename+0x9c/0x268
> > [  143.393814]  bpf_trampoline_6442476301_0+0x4e/0x1000
> > [  143.394413]  bpf_lsm_inode_rename+0x5/0x10
> 
> I am not sure what line 114 is (it is a blank line in bpf-next), but
> you might be missing a rcu_read_lock_trace_held() in the second argument
> of rcu_dereference_check().
Right, this path is only under rcu_read_lock_trace().
