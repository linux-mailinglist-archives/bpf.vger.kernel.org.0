Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2241E15E
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbhI3Ss5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 14:48:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344678AbhI3Ssx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Sep 2021 14:48:53 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UH4WG0019443;
        Thu, 30 Sep 2021 11:46:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eg263IqeCmBpo7j7ocMeQjOTnj/mLMupNoaNDYgF+Co=;
 b=iPwECL12tz8/2XBRfI7GwGQiaZiBq/aYp697snkHYLbfJmKP9oIUY0drY5eym1zEpxGg
 /qOWneByslerdnPZP9Jbfqlw3ZhVqMx+3CTPQ27zCh4Pp+ZcviB0NyzjlUQ+OV0zcYSI
 MVyase7kUvOtHU+KyPG8bIhCbqVVIu4QA5Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bdh9sgs3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Sep 2021 11:46:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 30 Sep 2021 11:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmzGqeW4wpcyRDGXo5oO+QCqAej0hwYAmp6M7I8JFkz32hX0V/E+JsBnVxLMePpbUwzhsN/i1/nWZyWWBODEGuJCf1gY9uqF+a52tIeuPGtuApqGAiEQrbff4J2zLRAKRyf/I6Xra3t75IWfXQZTfdmEYJBqusynsFYRtP9Gshf6i+4Fvt69CzgAtfiEm677gNvSRZIOZJuI/FdVsXciAQk4pahkdpnxdobV1mt5LnP/3oGyZBHsLeNy4oZZ3K28NGx5Xk+M96nhmiPYv31bFlnPzSWyR0ub5H1liUb9IBXjZZWwZBPOnqs34L6eleSq19S9JbXT3n1uSuPBo/UYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eg263IqeCmBpo7j7ocMeQjOTnj/mLMupNoaNDYgF+Co=;
 b=H/UC94kfSqQGl4HLEW2WqewK4EuS0Ujt29NgsMsYZTQXZ00fHFwLo5XT7KixQOyqsk0p4N0a1clYgJQ9itx64Mo1VzRXnbWVoF5Ik1s/J3pa64WB5s5HtAXY19dwiiM4f6IQEpjDuQ4ZiDgT5UD8MXnDFCbJscD0rDOSE33aAmSSqReW8zo+OPK2jZy7TWKeFARmevll4EYdwECPcoiVvdrqwC8iC6kCDSsitsgd+GcB0FjyrTYxgFUBtO1vopTLwBsbWbOscAT51bB7Hrk+zqMzJjcBhJkoJh64aSfqguO8cU66D579Yt1r8MLZtzUZlVMJUfqC1cZ4fL+h4YoUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4770.namprd15.prod.outlook.com (2603:10b6:806:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 30 Sep
 2021 18:46:47 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%6]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 18:46:47 +0000
Date:   Thu, 30 Sep 2021 11:46:42 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20210930184642.drfinqwgxgeuf3iz@kafai-mbp.dhcp.thefacebook.com>
References: <20210826235127.303505-1-kpsingh@kernel.org>
 <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
 <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
 <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
X-ClientProxiedBy: MN2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::15) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c091:480::1:492e) by MN2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:208:1a0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Thu, 30 Sep 2021 18:46:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 136fb4dd-5dbb-4451-0aec-08d98442a845
X-MS-TrafficTypeDiagnostic: SA1PR15MB4770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB47700674E5FC075B6978694FD5AA9@SA1PR15MB4770.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4xg+rHgcauylagQOChxS3iDPzEBPUQfhLwX0XQyJQqmpSbl0UoaIOL75DCIPDkFK8c0+S7u2iqzKEqiM5dwtjVu/tL9Jjo2elnxDiwM4Z33tBa+p6X2nZNtpNE2/FDJ8EHEKOfrNqCSnWV+kNp53zMEJ70TCAHdJ/IT0eF3DKLLlTfC5c8xKpCBxzSkqqs7crQx5lbQaXxs7Pb888w/ylHQQf/8HWCklHzcXDG4QCPbH8UZO1GzTQs0ooIgrHdBFIvHejd8z2Ver9N5NGe7V01jYmP6xkETa9o43xfKrnLhHy8czkBbG3Z10L2/Ad9lsUI2QUZywOpY1+8lER13V3H7B0U0Epdmc+a61aFiZKDuNyl/ZuItSvCNM2BrU80NaSuYyCb0YFepKHcO/AAHYcTwWxdwvxMsmUVthPYvRe/iYEr6+tIeSSDWr+bvwEnUeDeF295dhO+FNxmhnI0EuHb7OxUvQFPVymeivPCvM3vJaPI5spN0cIS2gXD2z5l2Xz+qkZLrNSgGV87YzeiK1EFnmqwUaAlGWU0H3eXWdpjSzN7D8GPQr9ZUARUyUWzNi2K410AggXZ07Ez4dx4BiQiilN0EmCgMMk0DsF9bwjrNpGYDTv/cCseFnC60lKj6IKVKDyMX+wn9mK0aJ0H6axkYOtZ8slu8Dh49mO/X42TZZOCb3k66uoK4mZzug4oaa2scMUcbi+YtxKp/1uNPh/UI2TtS4lO/bFxXMWuVomY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(4326008)(86362001)(316002)(8936002)(6506007)(6916009)(66476007)(66556008)(83380400001)(54906003)(2906002)(7696005)(8676002)(966005)(38100700002)(66946007)(186003)(55016002)(5660300002)(1076003)(9686003)(508600001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?buSgNR9UyANy/Uu6GseuU8UBnU3vphpJC4WtrHo/nX1g+5KD2TKTyrK7XQLr?=
 =?us-ascii?Q?g0Tp+pxNm/151ZPOzSJ9suKLaQFJV0r9a8qb571/m3u3ORew3DIGfL/mMK9+?=
 =?us-ascii?Q?Mj3n4TvVD8bOt+W1CqTI0tP8wfkOs1NO4MfFQM0bKABrT+OluMhz+xP76iyO?=
 =?us-ascii?Q?84DQ6cE7eQoO/aR1IoInwVxl5XPnA7vpdtxjKtHnCm1ZBz+DWnJBk/sraIF0?=
 =?us-ascii?Q?Tmb/WIm884uh4DSJ20DNVVJ2Fk5o/hdwFY/pNA9D4CUCK30AKLl7xtgH9CCx?=
 =?us-ascii?Q?FAQ5ruVn34K3NDtfUwHRLPOPKskBig7c4I2pBt3cyWUgSQsZseEpYHcNPeGP?=
 =?us-ascii?Q?ChL8EoyCGuyYyEHpWlMc9WgNTdtzbvWvXpwKV4dfnTGGJqY/pO1DjzeH5bC2?=
 =?us-ascii?Q?6oMCxgdicjgygR2wYHYJ5YfmFV0KF9uak+l9h4f2SdG5SSs6+xTYK2Z9SIAf?=
 =?us-ascii?Q?f/jLYNtkFDePQHb3ENqimIRdsk41A/el15SfQBJsCTUpp17uFi5uGku9zCk/?=
 =?us-ascii?Q?h3DoKu5r0G3nxpKouLKZVj5dZIHloeYbcpse9rdhKGxgcGedES1jIGEXjGic?=
 =?us-ascii?Q?M76Gq+b6x7rQXGG5RDqaXu2rasdzerjs4aK+fy016TGhWxeJoayZVv6o8zGj?=
 =?us-ascii?Q?zxFgoLLqnBIWzYlrlkRmeF9iUigyOexai4SMknEpPSqqA4ib8S9rCHMJBlyw?=
 =?us-ascii?Q?mG+cShmXSSP+6HiFdchXI6scXR/CDCzOkRW0RYKmO+wZn8wnyA32R+2ENF1u?=
 =?us-ascii?Q?2HQ0aLL39r3NgcCNHnhrrnwBY2WtMPB3C7C4BcADRKuy+Bm0/vdRqmk9tJmg?=
 =?us-ascii?Q?5D9facFnisJ/MlKvYZkME+xJwf3CSBr/bS1CInY9wAQaBL/HE3FL9qXJd6a1?=
 =?us-ascii?Q?Yg3ryWFc/DKjxE0/IySaZ2QA6WZwCU/spNcAqqIF6itsoFcDpIQ/7IUkTHC3?=
 =?us-ascii?Q?wZ6hKwRlkO+fBqVvOY1JR4LZGy+hW2mSS59ZJJsNd0wYYtZMF+RQNATZnSCT?=
 =?us-ascii?Q?QOuhJnMvvUnSci8BYgQFLylJ0Fnu0ParZugfXTwmpZ+M+BbD5lUU4Kckr+84?=
 =?us-ascii?Q?l8tnZNkPsAv8mPym8OOPwlD0Eam0rL5wjdbmMAwZqXB0bAeWP60Y/dodgQeF?=
 =?us-ascii?Q?0AxqpEO/QVMYHWY+lo9M6lKp0JWqTnYDwwcy6vd4dGjKu3FN1ksCrkeJrIHP?=
 =?us-ascii?Q?uyGKbl2J9iq766kDjiokB3KOMlkAObknhgjApMRbstJn31fPk8wS6XXOYb6G?=
 =?us-ascii?Q?PfnvtH30hmMriJpRqo2db7l8kV4Qi1eQN3p3VlR/0UvPLrwG4UzGF+cCMU2C?=
 =?us-ascii?Q?DZjkG7JXhlXJPvD77ie0IlloIq4XNa1zZtx0QBiS9rBglw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 136fb4dd-5dbb-4451-0aec-08d98442a845
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 18:46:47.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQKFjuc67jMMKXFOzS5Qs1Q0c5Udyq8osUX3D/QMqp1qgmP10JYNCNqVhH+YYJkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4770
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -cSeN0aSLJ4ULfLtIZv2r3A5ixawvR-u
X-Proofpoint-GUID: -cSeN0aSLJ4ULfLtIZv2r3A5ixawvR-u
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_06,2021-09-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=941 phishscore=0 clxscore=1011 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 11:32:17PM -0700, Martin KaFai Lau wrote:
> > > > > > > > --- a/net/core/bpf_sk_storage.c
> > > > > > > > +++ b/net/core/bpf_sk_storage.c
> > > > > > > > @@ -13,6 +13,7 @@
> > > > > > > >  #include <net/sock.h>
> > > > > > > >  #include <uapi/linux/sock_diag.h>
> > > > > > > >  #include <uapi/linux/btf.h>
> > > > > > > > +#include <linux/rcupdate_trace.h>
> > > > > > > >
> > > > > > > >  DEFINE_BPF_STORAGE_CACHE(sk_cache);
> > > > > > > >
> > > > > > > > @@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> > > > > > > >       struct bpf_local_storage *sk_storage;
> > > > > > > >       struct bpf_local_storage_map *smap;
> > > > > > > >
> > > > > > > > -     sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > > > > > > > +     sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
> > > > > > > > +                                            bpf_local_storage_rcu_lock_held());
> > > > > > > >       if (!sk_storage)
> > > > > > > >               return NULL;
> > > > > > > >
> > > > > > > > @@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> > > > > > > >  {
> > > > > > > >       struct bpf_local_storage_data *sdata;
> > > > > > > >
> > > > > > > > +     WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
> > > > > > > >       if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
> > > > > > > sk is protected by rcu_read_lock here.
> > > > > > > Is it always safe to access it with the rcu_read_lock_trace alone ?
> > > > > >
> > > > > > We don't dereference sk with an rcu_dereference though, is it still the case for
> > > > > > tracing and LSM programs? Or is it somehow implicity protected even
> > > > > > though we don't use rcu_dereference since that's just a READ_ONCE + some checks?
> > > > > e.g. the bpf_prog (currently run under rcu_read_lock()) may read the sk from
> > > > > req_sk->sk which I don't think the verifier will optimize it out, so as good
> > > > > as READ_ONCE(), iiuc.
> > > > >
> > > > > The sk here is obtained from the bpf_lsm_socket_* hooks?  Those sk should have
> > > > > a refcnt, right?  If that is the case, it should be good enough for now.
> > > >
> > > > The one passed in the arguments yes, but if you notice the discussion in
> > > >
> > > > https://lore.kernel.org/bpf/20210826133913.627361-1-memxor@gmail.com/T/#me254212a125516a6c5d2fbf349b97c199e66dce0
> > > >
> > > > one may also get an sk in LSM and tracing progs by pointer walking.
> > > Right.  There is pointer walking case.
> > > e.g. "struct request_sock __rcu *fastopen_rsk" in tcp_sock.
> > > I don't think it is possible for lsm to get a hold on tcp_sock
> > > but agree that other similar cases could happen.
> > >
> > > May be for now, in sleepable program, only allow safe sk ptr
> > > to be used in helpers that take sk PTR_TO_BTF_ID argument.
> > > e.g. sock->sk is safe in the test in patch 2.  The same should go for other
> > > storages like inode.  This needs verifier change.
> > >
> > 
> > Sorry, I may be missing some context. Do you mean wait for Yonghong's work?
> I don't think we have to wait.  Just saying Yonghong's work could fit
> well in this use case in the future.
> 
> > Or is there another way to update the verifier to recognize safe sk and inode
> > pointers?
> I was thinking specifically for this pointer walking case.
> Take a look at btf_struct_access().  It walks the struct
> in the verifier and figures out reading sock->sk will get
> a "struct sock *".  It marks the reg to PTR_TO_BTF_ID.
> This will allow the bpf prog to directly read from sk (e.g. sk->sk_num)
> or pass the sk to helper that takes a "struct sock *" pointer.
> Reading from any sk pointer is fine since it is protected by BPF_PROBE_MEM
> read.  However, we only allow the sk from sock->sk to be passed to the
> helper here because we only know this one is refcnt-ed.
> 
> Take a look at check_ptr_to_btf_access().  An individual verifier_ops 
> can also have its own btf_struct_access.  One possibility is
> to introduce a (new) PTR_TO_RDONLY_BTF_ID to mean it can only
> do BPR_PROBE_MEM read but cannot be used in helper.
KP,  not sure how far you are with the verifier change, if it is
moving well, please ignore.  Otherwise,
I looked at the sock a bit and I currently don't see
potential concern on the following pointer case without the
rcu_read_lock for those sock-related sleepable lsm hooks in bpf_lsm.c.
If cases did come up later (e.g. other lsm hooks are added or something got
overlooked), we could bring in a bigger hammer to make the above verifier
change.  I think it should be fine to stop some exotic usage
later that is proven to be not safe.  For the lsm sleepable hook case,
another option is to lock the sock first before calling the bpf prog.

If you agree a similar situation is also true for inode and task,
do you want to respin the patches addressing other points
discussed in this thread.
