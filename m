Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5943FCCF0
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHaSXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 14:23:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233943AbhHaSXa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 14:23:30 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VI8WXr008579;
        Tue, 31 Aug 2021 11:22:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=llHQ9uQij2uWHDltT+Oac1wOGSXG39B9jw9vlG4FX98=;
 b=LTEq8zkW2NBbWWV/5Dnp4Auvv/Xz9l2Bv7ujSBFMuQoW/CbIXUqlCDduJYztS8r0fJWh
 I/24fQ5eFRlYx4Ks4uuT/ynHmf7DYW/5N6Rd1C1khAw25gh13bBELuubTf+meMONDe3Y
 NCozUQG68+n4DY8/6/ITBa5piLy6wrje7h8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3asscrr5ft-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 31 Aug 2021 11:22:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 11:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYXBdDQZNY2RSPlgDea/EaFHgRQrRhQslIbhSIGUneL1gtIbrCKKHbqzea0HKHx9uo5Xrh46RNcPvcmQ27TQMqHiABknZrPF3Ge6qcjb6E58GSqSxcTaFXIUUCevUah8mIjM8EkQI/7WmWnImEZuY32Klbd2oOFx3vXTENl3UvbHdArydVduZ6cPOqDMzEvYPyu6TGfqv170sVUqDPFefKrj57/22mbc9OZUk9ejJ0FjvmERJcHOGtGOeJoZZcx/GcBT5w/mViqnQkP9JGsVcVLPbLzSYS71quxnUvWmlXxSUv2PAXhWzKDstE6QReYpc3fFw3vmjsxEc11nESfxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llHQ9uQij2uWHDltT+Oac1wOGSXG39B9jw9vlG4FX98=;
 b=Ly/kTCCAeBtBMSh7QUXsqPRp0UamoowAWXizFAZwb4hYEcVUPM7SXauWyjkXfW8BzMH3+ggFy0a2vqX52y0+23htn00zZtNeMV5KBdVEf3pyZRIDnsugsX67fq7ADQL/o9Cn7hkdE5tQxP9NGfjpo1Flm7lJWMFBrxd1snzUPRDivCJ6anq94EjJwCgm22HUI8569nR3Xomn5JoTvo6o1H6aixQJGTgcPKJ9m5Wn3VHMtKOPHMdgdj+L4VfQgngBIpQ381IdGK/RxIddx/o/+qEN5CYENlA4rmCTA35HaN3I9kN7+QpwZ9kLk4ejczsdtMf3gpsA4QbZ9T//EjncLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN7PR15MB4208.namprd15.prod.outlook.com (2603:10b6:806:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 18:22:10 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 18:22:10 +0000
Date:   Tue, 31 Aug 2021 11:22:07 -0700
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
Message-ID: <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
References: <20210826235127.303505-1-kpsingh@kernel.org>
 <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
 <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:2ae6) by BYAPR07CA0076.namprd07.prod.outlook.com (2603:10b6:a03:12b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Tue, 31 Aug 2021 18:22:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bcefc85-5781-4542-978a-08d96cac3f4d
X-MS-TrafficTypeDiagnostic: SN7PR15MB4208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB4208775C4477DB5598D5AC0AD5CC9@SN7PR15MB4208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IT4BD+ZymDlVo/PWGN2pVn2rJLD8rFDVDurZ9KUmJ/2S1V2w27VAORn6GTsgaCR0zcZcujTvSqKdbjqXmXOlLUxU7BgZE76X1V/Y09rhw/RZgOnHO9EqsaMWBb8bVvd4/fvSbBCOF0s4OcaXlyF8smXhEJmAdxVsAyDjN4HvMMktWxyrytdNSfDriue7mBf1JkJBM9np+9dX57aoO90UtuZY+xhbzQrCU0fxRXzbEVqv2jjSUp8xKkC7Wsi9t0ATb6go33g1WrUTIMYimnqi0aGqBOW6DflATacafQlKDCW99sB/Ql17C/0rKya/bXYzktc6OlFqr9ZzJaOmADxbNlqGREBL195J6lAM7NZDhzUb+lP/N/8U22pdC31jHjqyadBGrGZO9PZs6tPnFEjeCrTO4Xpzvz7SasOFpAR5P/EwTna/KkipHoGjMZ2garVkYy73iZiQhNSSSq6tT+OGnDOoe0s4R77YqJv3ztlh99J/aO9NdUThafrlz2+jk1x3ims4ztrKSEYUDsMf5+JDkIeZQbMKGUv2HdOh2Mh/oY0YDGSplgfSY52Z0ITiApq6MuI99yTMfHYL5gnxWRI+xGjfOkfXMb5Y+6h/oyn0sHokdUNZPQxjfFHeD3pUiUeS6VZfOGlbIrsLrvLODC2wvzs1OKyDavFlzIW4CvaVuiFglLmzmEAKdTk+qWe2syw3B6F5eNdYz5I9qMJWWrpJhdAZ9GzHXabXL5w4h/p6ZyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(5660300002)(966005)(52116002)(7696005)(8936002)(6506007)(186003)(8676002)(508600001)(6916009)(53546011)(316002)(2906002)(83380400001)(66476007)(54906003)(1076003)(66556008)(9686003)(55016002)(86362001)(66946007)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k990f/cKzvBlGIJ9d/LvOUULQHwQYER1ekrW1R0CjtW8SXri9YQN8VTWtg2c?=
 =?us-ascii?Q?pRLpcavbF2qR8so/zBZmlPTznyOS2bTFs4HwuQWdiMOmwq3NUydoF3DWLz02?=
 =?us-ascii?Q?qWU6VdNvp6qToyHfld6+YbkTCLiG3E+CFZRSC139zwYkaezHfaalk/Ph+R6w?=
 =?us-ascii?Q?P/QeLqyMS9hZXE3faYdI+CEo8p+Q1LtD6zaQdMYEvlq5yMb/RKi7x0lyLhX/?=
 =?us-ascii?Q?w68S9hKEy3XsZBm1zijR9kR9x0qXaXGMVr1zIflNI1Tuoi/MefhHx6PYBaem?=
 =?us-ascii?Q?wiG9o+yWAUbFV11a5w8vYw4FC5UL6Zlxw4AaHcr/alVxWPnnLlACVpMhvKzG?=
 =?us-ascii?Q?mQNm40vhX6Lcbq3XzfhlEXtTsvD5RnJ+jvSTbcJhdt9k5ljmDHbIlVxDtbVe?=
 =?us-ascii?Q?t9eBVuH92aeOS4UtipDbuNyuWJSBxaUqMXdLxEcJw0PuyEpafgLlVevCgdtb?=
 =?us-ascii?Q?/tJ4eN0pdPEb64T15c4W/OXfKH0UL7+n1hLbvHMVTZi3c3m+YDIHaYtbV4/o?=
 =?us-ascii?Q?QhlgrjP9v8YFZjqYWnT778cuo/9ylgiO6rJwSwJZ0mx9h8SoALVJ37E+rZjN?=
 =?us-ascii?Q?AThQMK1dIN7bWrucmHq3mZNoIrk/NGdX7/NfAVQPYDEepIhmYPnyrbQDJpWh?=
 =?us-ascii?Q?xgM0NeOM7G6VE2+Rerkd0jb2N0FbDj+FsDzmj9ZZX3RCAE00o+4Mf3y8kuEu?=
 =?us-ascii?Q?cB0+6y1AP9thfah80Icn8tL4v5JbbLNF1ouncdqKbxf1fweHL8NQ1h+Z18OM?=
 =?us-ascii?Q?ijSRTRbxGNfKac3ZqQjasATJ6RTbJYAtqxRfE0sVkAb9TxqN1Br96Wb5/Sde?=
 =?us-ascii?Q?dDiNm/LIJWQs6Ilqs8e7bTLREsxqfISpLTb8XJEA2+1gV+EbwtW9scTflQW/?=
 =?us-ascii?Q?oL5+rvc4WX2XZVtFQlnOzkJzqd/YDLjctF/+tdNa3CmkU9g2X3iW8Cvrg1sO?=
 =?us-ascii?Q?IiVMCm1LM+utHTJsuA/lqJWB1x0HYBEBYEioP2bpslofL4jZ2G0ndPl2BEFX?=
 =?us-ascii?Q?Vx5TnrTOhi7UowfbfS8PVkOjwtHOoue7agxncRoTcThQWNAr0BTXngPfmBvX?=
 =?us-ascii?Q?jJg7XShh4RnWdWLIRxvcL4OdE54YI+IUfn7QjgDZfGw7cN1toLbJ/JW/uzba?=
 =?us-ascii?Q?OzZq9W2aixDWK92QF2mOKzYlZ8wrMAdw/cr1hs+g0pfdulkTtXgRW4xPublm?=
 =?us-ascii?Q?hviFT8d772SvQF76uoYMsZvOiRWXN/Py43q+f613CGMeWs0FXrR8gXlT2nxw?=
 =?us-ascii?Q?weLWzIuPoUmKjHxMj2lR7X+jiKR2nsNWzzzPlFRI+66znDA8Kok6lyXE90/x?=
 =?us-ascii?Q?L/Fz8kBYIaZQ3n3R5s8ibWDngUfWiBmwkLDyvqlZTBawgQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcefc85-5781-4542-978a-08d96cac3f4d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 18:22:10.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpbuUlWDT53EEY0SvTqQSsvkFv2egKtAbqhrj4Izi4GdzQW/1eeZZtWuBLSuQMs5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4208
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: fQJAYXl0L9LC4A5fuH0SkSyplKsWQcXX
X-Proofpoint-ORIG-GUID: fQJAYXl0L9LC4A5fuH0SkSyplKsWQcXX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_08:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 11:50:48AM +0200, KP Singh wrote:
> On Tue, Aug 31, 2021 at 4:11 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Sun, Aug 29, 2021 at 11:52:03PM +0200, KP Singh wrote:
> > [ ... ]
> >
> > > > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > > > > index b305270b7a4b..7760bc4e9565 100644
> > > > > --- a/kernel/bpf/bpf_local_storage.c
> > > > > +++ b/kernel/bpf/bpf_local_storage.c
> > > > > @@ -11,6 +11,8 @@
> > > > >  #include <net/sock.h>
> > > > >  #include <uapi/linux/sock_diag.h>
> > > > >  #include <uapi/linux/btf.h>
> > > > > +#include <linux/rcupdate_trace.h>
> > > > > +#include <linux/rcupdate_wait.h>
> > > > >
> > > > >  #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
> > > > >
> > > > > @@ -81,6 +83,22 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > > > >       return NULL;
> > > > >  }
> > > > >
> > > > > +void bpf_local_storage_free_rcu(struct rcu_head *rcu)
> > > > > +{
> > > > > +     struct bpf_local_storage *local_storage;
> > > > > +
> > > > > +     local_storage = container_of(rcu, struct bpf_local_storage, rcu);
> > > > > +     kfree_rcu(local_storage, rcu);
> > > > > +}
> > > > > +
> > > > > +static void bpf_selem_free_rcu(struct rcu_head *rcu)
> > > > > +{
> > > > > +     struct bpf_local_storage_elem *selem;
> > > > > +
> > > > > +     selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> > > > > +     kfree_rcu(selem, rcu);
> > > > > +}
> > > > > +
> > > > >  /* local_storage->lock must be held and selem->local_storage == local_storage.
> > > > >   * The caller must ensure selem->smap is still valid to be
> > > > >   * dereferenced for its smap->elem_size and smap->cache_idx.
> > > > > @@ -118,12 +136,12 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > > > >                *
> > > > >                * Although the unlock will be done under
> > > > >                * rcu_read_lock(),  it is more intutivie to
> > > > > -              * read if kfree_rcu(local_storage, rcu) is done
> > > > > +              * read if the freeing of the storage is done
> > > > >                * after the raw_spin_unlock_bh(&local_storage->lock).
> > > > >                *
> > > > >                * Hence, a "bool free_local_storage" is returned
> > > > > -              * to the caller which then calls the kfree_rcu()
> > > > > -              * after unlock.
> > > > > +              * to the caller which then calls then frees the storage after
> > > > > +              * all the RCU grace periods have expired.
> > > > >                */
> > > > >       }
> > > > >       hlist_del_init_rcu(&selem->snode);
> > > > > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > > > >           SDATA(selem))
> > > > >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> > > > >
> > > > > -     kfree_rcu(selem, rcu);
> > > > > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > > Although the common use case is usually storage_get() much more often
> > > > than storage_delete(), do you aware any performance impact for
> > > > the bpf prog that does a lot of storage_delete()?
> > >
> > > I have not really measured the impact on deletes, My understanding is
> > > that it should
> > > not impact the BPF program, but yes, if there are some critical
> > > sections that are prolonged
> > > due to a sleepable program "sleeping" too long, then it would pile up
> > > the callbacks.
> > >
> > > But this is not something new, as we have a similar thing in BPF
> > > trampolines. If this really
> > > becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORAGE and only maps
> > > with this flag would be allowed in sleepable progs.
> > Agree that is similar to trampoline updates but not sure it is comparable
> > in terms of the frequency of elems being deleted here.  e.g. many
> > short lived tcp connections created by external traffic.
> >
> > Adding a BPF_F_SLEEPABLE_STORAGE later won't work.  It will break
> > existing sleepable bpf prog.
> >
> > I don't know enough on call_rcu_tasks_trace() here, so the
> > earlier question on perf/callback-pile-up implications in order to
> > decide if extra logic or knob is needed here or not.
> 
> I will defer to the others, maybe Alexei and Paul,

> we could also just
> add the flag to not affect existing performance characteristics?
I would see if it is really necessary first.  Other sleepable
supported maps do not need a flag.  Adding one here for local
storage will be confusing especially if it turns out to be
unnecessary.

Could you run some tests first which can guide the decision?

> 
> >
> > >
> > > We could then wait for both critical sections only when this flag is
> > > set on the map.
> > >
> > > >
> > > > >
> > > > >       return free_local_storage;
> > > > >  }
> > > > > @@ -154,7 +172,8 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
> > > > >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > > >
> > > > >       if (free_local_storage)
> > > > > -             kfree_rcu(local_storage, rcu);
> > > > > +             call_rcu_tasks_trace(&local_storage->rcu,
> > > > > +                                  bpf_local_storage_free_rcu);
> > > > >  }
> > > > >
> > > > >  void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
> > > > > @@ -213,7 +232,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> > > > >       struct bpf_local_storage_elem *selem;
> > > > >
> > > > >       /* Fast path (cache hit) */
> > > > > -     sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
> > > > > +     sdata = rcu_dereference_protected(local_storage->cache[smap->cache_idx],
> > > > > +                                       bpf_local_storage_rcu_lock_held());
> > > > There are other places using rcu_dereference() also.
> > > > e.g. in bpf_local_storage_update().
> > > > Should they be changed also?
> > >
> > > From what I saw, the other usage of rcu_derference is in a nested
> > > (w.r.t to the RCU section that in bpf_prog_enter/exit) RCU
> > > read side critical section/rcu_read_{lock, unlock} so it should not be required.
> > hmm... not sure what nested or not has to do here.
> > It is likely we are talking different things.
> >
> Yeah, we were looking at different things.
> 
> e.g. bpf_selem_unlink does not need to be changed as it is in
> a rcu_read_lock.
No.  It is not always under rcu_read_lock().  From the patch 2 test,
it should have a splat either from bpf_inode_storage_delete()
or bpf_sk_storage_delete(), depending on which one runs first.

> But you are right there is another in bpf_local_storage_update which I will fix.
> 
> > Did you turn on the lockdep rcu debugging in kconfig?
> 
> Yes I have PROVE_RCU and LOCKDEP
> 
> >
> > afaik, lockdep uses the second "check" argument to WARN on incorrect usage.
> > Even the right check is passed here, the later rcu_dereference() will still
> > complain because it only checks for rcu_read_lock_held().
> 
> 
> >
> > Also, after another look, why rcu_dereference_protected() is used
> > here instead of rcu_dereference_check()?  The spinlock is not acquired
> > here.  The same comment goes for similar rcu_dereference_protected() usages.
> 
> 
> Good catch, it should be rcu_dereference_check.
> 
> >
> > >
> > > If there are some that are not, then they need to be updated. Did I miss any?
> > >
> > > >
> > > > [ ... ]
> > > >
> > > > > --- a/net/core/bpf_sk_storage.c
> > > > > +++ b/net/core/bpf_sk_storage.c
> > > > > @@ -13,6 +13,7 @@
> > > > >  #include <net/sock.h>
> > > > >  #include <uapi/linux/sock_diag.h>
> > > > >  #include <uapi/linux/btf.h>
> > > > > +#include <linux/rcupdate_trace.h>
> > > > >
> > > > >  DEFINE_BPF_STORAGE_CACHE(sk_cache);
> > > > >
> > > > > @@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> > > > >       struct bpf_local_storage *sk_storage;
> > > > >       struct bpf_local_storage_map *smap;
> > > > >
> > > > > -     sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > > > > +     sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
> > > > > +                                            bpf_local_storage_rcu_lock_held());
> > > > >       if (!sk_storage)
> > > > >               return NULL;
> > > > >
> > > > > @@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> > > > >  {
> > > > >       struct bpf_local_storage_data *sdata;
> > > > >
> > > > > +     WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
> > > > >       if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
> > > > sk is protected by rcu_read_lock here.
> > > > Is it always safe to access it with the rcu_read_lock_trace alone ?
> > >
> > > We don't dereference sk with an rcu_dereference though, is it still the case for
> > > tracing and LSM programs? Or is it somehow implicity protected even
> > > though we don't use rcu_dereference since that's just a READ_ONCE + some checks?
> > e.g. the bpf_prog (currently run under rcu_read_lock()) may read the sk from
> > req_sk->sk which I don't think the verifier will optimize it out, so as good
> > as READ_ONCE(), iiuc.
> >
> > The sk here is obtained from the bpf_lsm_socket_* hooks?  Those sk should have
> > a refcnt, right?  If that is the case, it should be good enough for now.
> 
> The one passed in the arguments yes, but if you notice the discussion in
> 
> https://lore.kernel.org/bpf/20210826133913.627361-1-memxor@gmail.com/T/#me254212a125516a6c5d2fbf349b97c199e66dce0
> 
> one may also get an sk in LSM and tracing progs by pointer walking.
Right.  There is pointer walking case.
e.g. "struct request_sock __rcu *fastopen_rsk" in tcp_sock.
I don't think it is possible for lsm to get a hold on tcp_sock
but agree that other similar cases could happen.

May be for now, in sleepable program, only allow safe sk ptr
to be used in helpers that take sk PTR_TO_BTF_ID argument.
e.g. sock->sk is safe in the test in patch 2.  The same should go for other
storages like inode.  This needs verifier change.

In the very near future, it can move to Yonghong's (cc) btf tagging solution
to tag a particular member of a struct to make this verifier checking more
generic.
