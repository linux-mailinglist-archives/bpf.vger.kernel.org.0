Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24354DCD2B
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 19:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiCQSGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 14:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCQSGf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 14:06:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095D718FAE7
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 11:05:17 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22HCegoY016590;
        Thu, 17 Mar 2022 11:04:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7iNNHLVSMd3E3yU69dy3jrff+LvoVMAhr2rqWhOkLY8=;
 b=CqSHcDT5BTszt6IyeVHFphDf8236mdUUrdV4psNWG2n2TfUfcvX9/vyoKOPyPktnBw+W
 IUaL9XxkT5kE/CRY1txXQIMWcbjRInyvqpTnEX310JcW5pk4r8fNWmfBN6f+XZFGj4Yg
 rZ9LCY8be9cYnrTOJUt/+6n948ebP422n38= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ev5702dv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 11:04:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWEkSKhrUtmr/yp/rg7oBhlBzKv0EwlC9pngXTX3RP0FGXpRhG/U5l8PHatEyIXqJvW3K/PEbEyrnE7A7aBZxrnBXkj1kYZKU5MroO3+zSTaYTcrSSWFlAHC3cgnglTyoqsmcKpkGHJFxXvcJMsweMno4fuGz82xOicNFG0xvDvpZX+fM2VIy9D8aDmNlQpGVGqvJMErtNwyvR7Y1JFrSAI+Y7j2QOuTqPktRlGgATb4qT6XjsGkzImMvpW3DVWeSuCht3REo07xJzJVOv4oQ0IJjCTRuTHW1WmvorfrF1YMNToFJJDbvra46WXTxiAyBLXWmFlvao3oq+wIpJPsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iNNHLVSMd3E3yU69dy3jrff+LvoVMAhr2rqWhOkLY8=;
 b=PoL6VbK8iYxE2x1ya6bi7EIFXKDu9VB+amVKBgqaZ0alvfZMJqDNDYzWKHKlZqlUcg7yocLlffydcbCceHvWERiGePehph4E+SdmAlwNm58rOnOViAJ6NZh2j6+Zq6KGjH1bRkr6nQb1nJ5Hq6oIyhHQyB6iC065rC/RidkrRf8rwxo/0DCa2Q2P26HRjLr2E+gEwnnc3ih3Up/vue0kZqR26hOBfhnxXAOO+fCq1dwns2bqO5aR3wWLZZ1S3MrxhKU07TBMW6BeGwGprOtaA3w44QDgFDHBhNmmf+VdZIDu5/QaMTN74hvpfUtR1XvwAHi61re+GczdaLqEIjfb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BYAPR15MB3160.namprd15.prod.outlook.com (2603:10b6:a03:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 18:04:35 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 18:04:35 +0000
Date:   Thu, 17 Mar 2022 11:04:31 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next v2] bpf: Enable non-atomic allocations in local
 storage
Message-ID: <20220317180431.nfdo27ux65w53xlv@kafai-mbp.dhcp.thefacebook.com>
References: <20220316195400.2998326-1-joannekoong@fb.com>
 <20220317022329.7wpltaqviw45qabl@kafai-mbp.dhcp.thefacebook.com>
 <CAJnrk1Z=hX_zayU084mJjd_UDqw4dBkTgoRy+9xGeGoSYfL1TQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Z=hX_zayU084mJjd_UDqw4dBkTgoRy+9xGeGoSYfL1TQ@mail.gmail.com>
X-ClientProxiedBy: CO2PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:102:2::14) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a58a48c2-170f-4a18-c0e9-08da084097eb
X-MS-TrafficTypeDiagnostic: BYAPR15MB3160:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB31608098301370D811B248D2D5129@BYAPR15MB3160.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrRLdUHf2mfPHJ9jx0PqDd1/ph/gWzqWZ4z2EAk3zbOn2k7w8p/luGZf/EDqF6VkDgGEFtSp9AJ4nAHgO7NnP2BdKsh3UFgNLxc9CC4xz4OLB1BFOHG0LP0p3CCny+2ZtK+y3CeCUgCoNargJ6CnnCXic5v3l3A/jkhUiu6WaW+QsS4xB6bpmHA+0bc54CWALxZhF/LWTT/jXonl8kYIwv8bQYZ78jA+T8eqa6zOSTGV1O+YbUXZzUe4QobGPZa7qXGKyaD4etN6HUeH3oPcvnLt5oU+lQrHjfTiQqmlaNMrK1M+LWiGmAABxEbm55fo5EOx5NXLEuVOSJ1/Yeds8N/zK2DO+qIBot0fO1TzjoJERkul9vcVunpdgMPX71qyqYSl2RHiQJoqk8b0IlT4z/hSluGe9CZcWrgGgMospZNvlpbCc3FErmQ3CBLbTQbzzaZQJozagQ3RYIabzYRojcU8KnOHprjQbXC1gpqyfsqHa+nSG0Y1isQVNek8aQXQuz7+P3CXi+1pxxCBwLPGsXRvsLN9AWRy3AOdKM5yO4lrpnn9Jy6qI/ItS0iK0rPkmNmvQrX3E3/7jhhhk75xLoK7i9bmB5+LRrWNG0nQVfE4Vaq5fzWcq1clB/HiBV/UW1BMo4/9bmUQ7YkFufL1mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(83380400001)(2906002)(66556008)(316002)(9686003)(6512007)(508600001)(6486002)(86362001)(6916009)(52116002)(54906003)(53546011)(6506007)(186003)(6666004)(38100700002)(4326008)(66476007)(8676002)(1076003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g/bXHR5Ry7nA4WzhxErYdaqhJnR0OC5YfwYcqmOUI0ywFJktzWoD5R0mXSq9?=
 =?us-ascii?Q?Cas5njln3OBei7Tsq3Q8JcdM8dAnKWhwgG4blhlYvIhJzOJ4XAe6k/5/cEW3?=
 =?us-ascii?Q?bD1S/qKh0F+zeobWjQstrg5wT03pasB4Q+dmBXt8PUS42UJo11R0n01PaPNu?=
 =?us-ascii?Q?IwjaXIU7i2M4PShdh0yihegyzeDSRQY7ESmZfa9d5hzfsGA3YSCfJ9ZPpHiT?=
 =?us-ascii?Q?4holiEEliQL2zga9e4yfKlSP8N26tJPrLO+NvHfzQgJnfR9ZGzGl8kmQ5YEZ?=
 =?us-ascii?Q?f/ELwL7w9js064G9msjYuPsfHRI+zx5HDpVO7jYKIM9vQyKD2vJV+yGwlNsL?=
 =?us-ascii?Q?WAnog34XtfX9laVnSzF/ggAXPXBwlhkKefwB9Rx9LIs66AHw6Ygtm8PaaPa9?=
 =?us-ascii?Q?issgo0ellJf4mQ7QOFabsZviHS9UZGyxcV9t/sKmb8EUM1zMW6nsknpOgLTj?=
 =?us-ascii?Q?svedAtWNE4Z2vDljY2H/w85ggMDpDeaCPYsEUmqzNGedM1W4abZK0XgtLxr5?=
 =?us-ascii?Q?JE9HYxhKlyioeJ+TN7kA58Kg7RpbDonIhXt9sE+X2KQYNUg0G2j0m/RnhQ+S?=
 =?us-ascii?Q?UvKF+1RHuxNpga+9th6m5SupiS2+7cffPYH47tqkXRcwGjEhOAzwHRIMGVPi?=
 =?us-ascii?Q?PVaB9/eDEj1XzuT4OAS6HpODxb3tSssROVqWN6KARleTIQMeAXEC+/UdTyRf?=
 =?us-ascii?Q?KUzt24jpYNM9lWlZlGPECPYKdxdcrubiM+ixLtIpeL99++SR5754Rzz60zL/?=
 =?us-ascii?Q?u3I+PnpFwse+I7YBYPX00QGH1FxC/WrLrG7YsiwY8vqmlu4cnzQNboNAuv97?=
 =?us-ascii?Q?h3zvFOwaWJhU4P+IbaGEJL+InUkXypT9ddnyeOEgPQq6LM6S1uRwtouwR9XH?=
 =?us-ascii?Q?ColFScpevuikaeyKLBn9zTIeH0rjfkmRYpFJrhgkmr8aKPDk9htXbW4fMo6S?=
 =?us-ascii?Q?/wrFiP8C25//K+/qrjbNHqp8MS78muB/MnymKRMuUcYlQbqG1VLH0by1SHxu?=
 =?us-ascii?Q?EWxfWwvg805yFob/aA0+DIPBujU6PiBmOBBCAcssZFP3+8u6Gb4cYNZ3/GOG?=
 =?us-ascii?Q?zbQYr68SweQFMAjnKxJvqgCfhEqU/qvx1aL9YBR2f52ARwGMp2XNt9j0NnT0?=
 =?us-ascii?Q?IIChGmBtyrbogsXTDx/v6JohLl4i7DQFXJ/wEhaKB6b867rOL197F2IBXbcN?=
 =?us-ascii?Q?AmAbNXfbQ6MbR33MedFdu6wYP/t12hIIYRD0ueOkoZ5QSyZT5vGxYii3FQaO?=
 =?us-ascii?Q?r1Aewtdbd40F1m7Qkq42VyffXws3KrBP7CiPlnK7us4rj3h5rFB3n6HpuBWD?=
 =?us-ascii?Q?jrc6yjwFGWqEGJg8Dm5rjqOvLl3jMPUwiLlboRN/lP7LCayXNBwqo7aD+wp4?=
 =?us-ascii?Q?aCYe/8yhcD5s/r+StBcjG8CdVhNC84DkBmXEHzBn+BagynJ35qvyUvdFJRIN?=
 =?us-ascii?Q?dNq3ebowKzOntHAXq9let+0QHWs04ch2MRpsYmKSj6VCEo9dhFhgrw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58a48c2-170f-4a18-c0e9-08da084097eb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 18:04:35.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGQ5a4goDM2Nq12gKdUwyOQkagrA8KUVcoKttJwathY/TtO/f8cXIW53sBjVII5o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3160
X-Proofpoint-GUID: UR39HUKDvJ11URZTvdNIG3J3P_IhAVFW
X-Proofpoint-ORIG-GUID: UR39HUKDvJ11URZTvdNIG3J3P_IhAVFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_07,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 10:26:57PM -0700, Joanne Koong wrote:
> On Wed, Mar 16, 2022 at 7:23 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Wed, Mar 16, 2022 at 12:54:00PM -0700, Joanne Koong wrote:
> > > From: Joanne Koong <joannelkoong@gmail.com>
> > >
> > > Currently, local storage memory can only be allocated atomically
> > > (GFP_ATOMIC). This restriction is too strict for sleepable bpf
> > > programs.
> > >
> > > In this patch, the verifier detects whether the program is sleepable,
> > > and passes the corresponding GFP_KERNEL or GFP_ATOMIC flag as a
> > > 5th argument to bpf_task/sk/inode_storage_get. This flag will propagate
> > > down to the local storage functions that allocate memory.
> > >
> > > Please note that bpf_task/sk/inode_storage_update_elem functions are
> > > invoked by userspace applications through syscalls. Preemption is
> > > disabled before bpf_task/sk/inode_storage_update_elem is called, which
> > > means they will always have to allocate memory atomically.
> > >
> > > The existing local storage selftests cover both the GFP_ATOMIC and the
> > > GFP_KERNEL cases in bpf_local_storage_update.
> > >
> > > v2 <- v1:
> > > * Allocate the memory before/after the raw_spin_lock_irqsave, depending
> > > on the gfp flags
> > > * Rename mem_flags to gfp_flags
> > > * Reword the comment "*mem_flags* is set by the bpf verifier" to
> > > "*gfp_flags* is a hidden argument provided by the verifier"
> > > * Add a sentence to the commit message about existing local storage
> > > selftests covering both the GFP_ATOMIC and GFP_KERNEL paths in
> > > bpf_local_storage_update.
> >
> > [ ... ]
> >
> > >  struct bpf_local_storage_data *
> > >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > -                      void *value, u64 map_flags)
> > > +                      void *value, u64 map_flags, gfp_t gfp_flags)
> > >  {
> > >       struct bpf_local_storage_data *old_sdata = NULL;
> > > -     struct bpf_local_storage_elem *selem;
> > > +     struct bpf_local_storage_elem *selem = NULL;
> > >       struct bpf_local_storage *local_storage;
> > >       unsigned long flags;
> > >       int err;
> > > @@ -365,6 +366,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >                    !map_value_has_spin_lock(&smap->map)))
> > >               return ERR_PTR(-EINVAL);
> > >
> > > +     if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
> > > +             return ERR_PTR(-EINVAL);
> > > +
> > >       local_storage = rcu_dereference_check(*owner_storage(smap, owner),
> > >                                             bpf_rcu_lock_held());
> > >       if (!local_storage || hlist_empty(&local_storage->list)) {
> > > @@ -373,11 +377,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >               if (err)
> > >                       return ERR_PTR(err);
> > >
> > > -             selem = bpf_selem_alloc(smap, owner, value, true);
> > > +             selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
> > >               if (!selem)
> > >                       return ERR_PTR(-ENOMEM);
> > >
> > > -             err = bpf_local_storage_alloc(owner, smap, selem);
> > > +             err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
> > >               if (err) {
> > >                       kfree(selem);
> > >                       mem_uncharge(smap, owner, smap->elem_size);
> > > @@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > >               }
> > >       }
> > >
> > > +     if (gfp_flags == GFP_KERNEL) {
> > > +             selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
> > I think this new path is not executed by the existing
> > "progs/local_storage.c" test which has sleepable lsm prog.  At least a second
> > BPF_MAP_TYPE_TASK_STORAGE map (or SK_STORAGE) is needed?
> > or there is other selftest covering this new path that I missed?
> Thanks for your feedback. I think I'm misunderstanding how the
> progs/local_storage.c test and/or local storage works then. Would you
> mind explaining why a second map is needed?
> 
> This is my (faulty) understanding of what is happening:
> 1) In "local_storage.c" in "SEC("lsm.s/inode_rename")" there is a call
> to bpf_inode_storage_get with the BPF_LOCAL_STORAGE_GET_F_CREATE flag
> set, which will call into bpf_local_storage_update (which will create
> the local storage + the selem, and put it in the RCU for that
> inode_storage_map)
From reading the comment above the bpf_inode_storage_get(BPF_LOCAL_STORAGE_GET_F_CREATE):
"new_dentry->d_inode can be NULL", so it is expected to fail.
Meaning no storage is created.

> 
> 2) Then, further down in the "local_storage.c" file in
> "SEC("lsm.s/bprm_committed_creds")", there is another call to
> bpf_inode_storage_get on the same inode_storage_map but on a different
> inode, also with the BPF_LOCAL_STORAGE_GET_F_CREATE flag set. This
> will also call into bpf_local_storage_update.
I belive this is the inode and the storage that the second
bpf_inode_storage_get(..., 0) in the "inode_rename" bpf-prog is supposed
to get.  Otherwise, I don't see how the test can pass.

> 
> 3) In bpf_local_storage_update from the call in #2, it sees that there
> is a local storage associated with this map in the RCU, it tries to
> look for the inode but doesn't find it, so it needs to allocate with
> GFP_KERNEL a new selem and then update with the new selem.
Correct, that will be the very first storage created for this inode
and it will go through the "if (!local_storage || hlist_empty(&local_storage->list))"
allocation code path in bpf_local_storage_update() which is
an existing code path.

I was talking specifically about the "if (gfp_flags == GFP_KERNEL)"
allocation code path.  Thus, it needs a second inode local storage (i.e.
a second inode map) for the same inode.  A second inode storage map
and another "bpf_inode_storage_get(&second_inode_storage_map, ...
BPF_LOCAL_STORAGE_GET_F_CREATE)" should be enough.

It seems it needs a re-spin because of the sparse warning.
I don't see an issue from the code, just thinking it will
be useful to have a test to exercise this path.  It
could be a follow up as an individual patch if not in v3.
