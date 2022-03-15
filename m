Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1B4DA44B
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 22:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348039AbiCOVDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 17:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344223AbiCOVDR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 17:03:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388985548A
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 14:02:04 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22FGWWAh028687;
        Tue, 15 Mar 2022 14:01:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ARl6iW5PH4wC6ErSLLlpf0xQ846uvjvPHU/4xnx+E4E=;
 b=VXoB1uGF7E5Mid2QFVFfZdFPmkRrXmVyGRi4/ap5CdAg7O0VQL9J1M6IolXeqMSZpTGi
 I672X65J8SmmV+28+piNFaeRpKDHDSV/hP+X3tMKp1Qka82ewpPvCfqs4jPVtd3fhSC5
 Sxn1Eq4BlPjUfRVIzmoQyLR/XxF1LzZfeoY= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by m0089730.ppops.net (PPS) with ESMTPS id 3et99mjm9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:01:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrJLdD6HWCHk/oc9Pa+UVq65BsWAr5ix904Dhid0pq9pJb06xesBKZBObmtHwDA1sKPuDdOPq0GbZ3B92YiFLmLJx1huk6xJe33SMc9syYByuQcXqLOlHGJtwowIUppIDZm5gbTCkpoeUy0ME3E/9I/Hc9qoOUzul2OE3WykUW7MutugqTMxd04ZR0+D/GxWFQjm+IyToOIlxFWbtsHGEg4DKD//QQmLzwGNhHHOAovMnmeWdTBx4GgpNMAwpufgnzzuDayuU+NnZsoWMkCZsx9Hw5O9zzXJD7QkO0bSh9N6y1f3gPpE39ydEQHpJfwYBy4coat9Gzri1p5LU0iq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARl6iW5PH4wC6ErSLLlpf0xQ846uvjvPHU/4xnx+E4E=;
 b=im2mDBS5AvFJbAojlCv9S5Z/8tiTMyS9/i8cgqOLkQiql3tuQEY8ec10IIiQwge3PUygqpvNPDd7SJ/l1VRVtk6T8aOFZKwYbuhLnMP5urACe8e2TdMRC6EBLNVc/zVoPC/62JxeEnYX6euV+56GcjwQ4ewOQg2MK2ByA8pmsCBN5WQUmdMNjm2yxaPVUNAdVCjrrdaAFr/+roIreRNlUMolUY/Jxn0Xfg/osctg858pGNA1zfT6LwL94Z5D1D2bKPk7fIgFgekOBnXuW2Rmp/fz/IkewhO5H9dzjlaSa22U8BR632WUnMTvCIJ32gYIci73hbUtdQmxnZ5lbLLJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BYAPR15MB2806.namprd15.prod.outlook.com (2603:10b6:a03:15c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 21:01:46 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 21:01:46 +0000
Date:   Tue, 15 Mar 2022 14:01:42 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next v1] bpf: Enable non-atomic allocations in local
 storage
Message-ID: <20220315210142.slkwr4dxal4lxunk@kafai-mbp.dhcp.thefacebook.com>
References: <20220312011643.2136370-1-joannekoong@fb.com>
 <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
 <20220315190455.7v6wjovhrhnezvxi@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5P8frjjvQR5Q=nhsXiTyEsuJU4wY3w-Mbk2pbAVM8vJQ@mail.gmail.com>
 <CAADnVQL1Fa3uDSqaJu=0F1FjF7P_=VnXEj_8xKPDVmtCvPo06A@mail.gmail.com>
 <CACYkzJ5AWNDkmFqCCMXKN3ZCpuZmEqsFuqi4yVeU8euoJ7puzw@mail.gmail.com>
 <CAJnrk1bTSuoDf4FJr3nSiYWc_eAtXfZzyQ4GYLhAfyoAWVhpxw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1bTSuoDf4FJr3nSiYWc_eAtXfZzyQ4GYLhAfyoAWVhpxw@mail.gmail.com>
X-ClientProxiedBy: MWHPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:300:4b::17) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53270b18-3f78-43ca-4a3b-08da06c70436
X-MS-TrafficTypeDiagnostic: BYAPR15MB2806:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB280614D1F90358C17E2F2418D5109@BYAPR15MB2806.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RvhWAIXlzCErSJLmeETIKWiisjXLvd6pMoboGlYTe5sVhk2eKPPw3yZqKMVe2aqP0UT4/nJ92HdVA+IlDvaHmAGaj+7yGqpwDtvH0UJP4TrTdkgQZO2uBq1yBHSm81qh8Q015FgtNcjtM1lvD8gCRVYfV5Qo5ohu08BsbpQV+qzgWmt9rt0sfL6TnlSQTR1SpRk2DYkwf7kWX1QeGQpSSM3O9h87DYWnIOj8kzJ4mNYMUBhPcB94hJdRyOmBQAxvdHSYnZIk5G7cpQNcqaikSm6S1VcRHIbY1wD9TDNEZ9EqK7xfZu83ovWubnPRQhRY4soDCHIerl4UMQB8efBkBdv0V+W6thficW61q0fFgeLwHzLTfauwjMYvYNrzYzR0XkpA5uFF9rzPcXtXPVbAFeLjvDIDd/wDpiAs8R1zOCcebwpKbDxrolslBX28fci4th7DHn9ghJSEMMvetF0xLli5bzK4ctE5vfpFU0KfTscc+ZSPf3Y0r0eABeNUQWxhb5yu35bc9qegshj0V+Z/PTqgXmXiOKkeX/zfQJm8uyUaQoqArLnKdUfpYFptyS0RIYT2skvGsG4nHpzhsPuVOoqkWA8ieas77KvJY9Ed/8Y8CANV5jbAMiq1pvG83QdWLHdev6J3PqeNOhl+DkWCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66556008)(38100700002)(186003)(83380400001)(52116002)(86362001)(1076003)(6666004)(6506007)(9686003)(6512007)(508600001)(316002)(6916009)(54906003)(66946007)(8936002)(6486002)(66476007)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wI/+Zgv8Wj+Be1km54wSGXiHoxy/gtpdfCVyKKU1gOQLkWUT7WUfMzq6nEkt?=
 =?us-ascii?Q?/EGcs++8CRV+2PfoSpI/5rWK8AVy0EBje7uVEcOrj6yANjDvpyP+0I+clVQo?=
 =?us-ascii?Q?3tcBbSf2AoRErR9zDfYufEXz/E30AyupyK8H2FJRyUOngSOLTJL3Sik5aKe/?=
 =?us-ascii?Q?BktDvtTy4VoCl8uX0K8/nC6sSqUQLW/yXA9dpQATDwXW9WtzbxGQGwgEEKgL?=
 =?us-ascii?Q?VI2atvEqdIRVsK5OTLFwW2hApDb5VNYc2XQ/br8L+UoF1kAWWpqSJpsgz1Js?=
 =?us-ascii?Q?Qa4Gg2zZu5BlxN1nx5IkUoQhUxYKdmDvS49biEVaii+fsDPoO1Ixs7OiWsz2?=
 =?us-ascii?Q?eXwBJ62639A1iPmcCE0/FVovOmuq96yO5e4cRvXGVk6RVuyjQdf7Mr66duGr?=
 =?us-ascii?Q?mvsWJ9IZ4ll4fdTtADea60bZu5gt7L+cSOfHNkO4r2XvYmVruzN/1yDHTcxc?=
 =?us-ascii?Q?K0hhfGNn0p5Ex5KhxVaadPoIRoQG32yHS1mFhuv0Of2HLhLVv5kH8/ZxiHev?=
 =?us-ascii?Q?U6RcV2AHc+Y7DSSzOzcsfTxY5Kg34t0JVFU4GbZ0gwF4et4dY4zCVGLTHWmX?=
 =?us-ascii?Q?TM7zS0nV9LNU+7H7yB0eujVsL3/kPHDtNoNl3fGQb5jUT4qdTizi3fhWmlPT?=
 =?us-ascii?Q?ReixU1CWRn3Y34ZI3UPfvJW6CXKMda2MZAG8VfYQndivb5IwT6+ezJsL17Bx?=
 =?us-ascii?Q?3XBYq2YTFIWnJzgydyHbAWD3o50T9nBzFYn5mSwyQoLZXG4N2dWKWEgCIS1C?=
 =?us-ascii?Q?m+6VPyAIu8kZUBUCGo6st5nK9TrKDihGIy0J53OjDDMJTbmbAuYZivNNQPOg?=
 =?us-ascii?Q?2VBOQGvO80IKeZy6u1ZS3+AXc1NRjkzO1Sc50Ereygpw0nseHiNIHS/5olMu?=
 =?us-ascii?Q?F4JLrVS4GuPjBUYn4y6kFoSt86XTQbI2bIEQI/9gi7Em1/Q79ZkD7axJZZhK?=
 =?us-ascii?Q?9/+O3mW0Z8+91s20tAVad1qVWig5HIkSOxfaSDw7+lCC7I2i5amG1xPDb33X?=
 =?us-ascii?Q?cb0RuKaDa/m0/50RMNy2T6rCtreK0Wo3PxL2UV4nDQ8QaEvgw4WQxF4VQlUu?=
 =?us-ascii?Q?JHLUA5FZ24RQGNY+n1dFtWRUgBTRUT3BfG/Mi6Tun3LLGN2ep8R8PPVJuach?=
 =?us-ascii?Q?iptZn7vLvVrK8eRBsvY+prcVOr8Ce9FAs24pEoAHYomKo14RaNJZEl+hpYWg?=
 =?us-ascii?Q?DkTyAmcanaN+Yfqo0HPKJU8NXC40ZmsNb1yHS7EnRK7v0x7rnxQAHZWJKTcC?=
 =?us-ascii?Q?z5E/+i0ApjLxWVogexZ58jZks5vOrCMmmzrdr+qACysrlDAPb4RegDZXE/vG?=
 =?us-ascii?Q?pmZB4Vd5b6D57FZZMiovjcWGdXeKE7bK98Ia7ykz1pnyELNbgz2vWwU3WVoU?=
 =?us-ascii?Q?yC4udHTFovpKhvDGJbBxWfd7qhKP4HAGTAB+0RRUHETUf14E+giwkH1oYRCJ?=
 =?us-ascii?Q?VUlqHEyWqV9pfZCcemfeG7XteYWb5scRI31FwZ0rpB1aVbjlvE+QkA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53270b18-3f78-43ca-4a3b-08da06c70436
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 21:01:46.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRFKnYe3KVVdiNUQzQHkLWf5uN26s1m88qhgX0CR1khdknN1pfJz3qNq2PakuwGq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2806
X-Proofpoint-GUID: 7q_1Nk0ssQ50YxM8boM0jk7t0Lf-wgNa
X-Proofpoint-ORIG-GUID: 7q_1Nk0ssQ50YxM8boM0jk7t0Lf-wgNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_10,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 01:33:05PM -0700, Joanne Koong wrote:
> > > > > > > @@ -425,25 +438,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > > > >         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> > > > > > >                 copy_map_value_locked(&smap->map, old_sdata->data, value,
> > > > > > >                                       false);
> > > > > > > -               selem = SELEM(old_sdata);
> > > > > > > -               goto unlock;
> > > > > > > +
> > > > > > > +               raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > > > > > +
> > > > > > > +               if (!charge_err)
> > > > > > > +                       mem_uncharge(smap, owner, smap->elem_size);
> > > > > > > +               kfree(selem);
> > > > > > > +
> > > > > > > +               return old_sdata;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       if (!old_sdata && charge_err) {
> > > > > > > +               /* If there is no existing local storage value, then this means
> > > > > > > +                * we needed the charge to succeed. We must make sure this did not
> > > > > > > +                * return an error.
> > > > > > > +                *
> > > > > > > +                * Please note that if an existing local storage value exists, then
> > > > > > > +                * it doesn't matter if the charge failed because we can just
> > > > > > > +                * "reuse" the charge from the existing local storage element.
> > > > > > > +                */
> > > > > >
> > > > > > But we did allocate a new element which was unaccounted for, even if
> > > > > > it was temporarily.
> > > > > > [for the short period of time till we freed the old element]
> > > > > >
> > > > > > Martin, is this something we are okay with?
> > > > > It is the behavior today already.  Take a look at the bpf_selem_alloc(...., !sold_data)
> > > > > and the later "if (old_sdata) { /* ... */ bpf_selem_unlink_storage_nolock(..., false); }"
> > > > > Most things happen in a raw_spin_lock, so this should be very brief moment.
> > > > > Not perfect but should be fine.
> > > > >
> > > > > If it always error out on charge failure, it will risk the case that the
> > > > > userspace's syscall will unnecessary be failed on mem charging while it only
> > > > > tries to replace the old_sdata.
> > > > >
> > > > > If the concern is the increased chance of brief moment of unaccounted memory
> > > > > from the helper side now because GFP_KERNEL is from the helper only,
> > > > > another option that came up to my mind is to decide to do the alloc before or
> > > > > after raw_spin_lock_irqsave() based on mem_flags.  The GFP_KERNEL here is only
> > > > > calling from the bpf helper side and it is always done with BPF_NOEXIST
> > > > > because the bpf helper has already done a lookup, so it should
> > > > > always charge success first and then alloc.
> > > > >
> > > > > Something like this that drafted on top of this patch.  Untested code:
> > > >
> > > > I think this looks okay. One minor comment below:
> > > >
> > > > >
> > > > > diff --git c/kernel/bpf/bpf_local_storage.c w/kernel/bpf/bpf_local_storage.c
> > > > > index 092a1ac772d7..b48beb57fe6e 100644
> > > > > --- c/kernel/bpf/bpf_local_storage.c
> > > > > +++ w/kernel/bpf/bpf_local_storage.c
> > > > > @@ -63,7 +63,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
> > > > >
> > > > >  struct bpf_local_storage_elem *
> > > > >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > > > > -               void *value, bool charge_mem)
> > > > > +               void *value, bool charge_mem, gfp_t mem_flags)
> > > > >  {
> > > > >         struct bpf_local_storage_elem *selem;
> > > > >
> > > > > @@ -71,7 +71,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > > > >                 return NULL;
> > > > >
> > > > >         selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > > > > -                               GFP_ATOMIC | __GFP_NOWARN);
> > > > > +                               mem_flags | __GFP_NOWARN);
> > > > >         if (selem) {
> > > > >                 if (value)
> > > > >                         memcpy(SDATA(selem)->data, value, smap->map.value_size);
> > > > >
> > > > > @@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > > > >                 }
> > > > >         }
> > > > >
> > > > > +       if (mem_flags == GFP_KERNEL) {
> > > >
> > > > It seems like what this check really is (and similarly for the other
> > > > mem_flags based check you have below.
> > > >
> > > > "am I called from a sleepable helper"
> > > >
> > > > and I wonder if, instead of the verifier setting mem_flags, could set
> > > > a boolean "sleepable_helper_call"
> > > > which might be more useful and readable and is more relevant to the
> > > > check that the verifier is
> > > > performing "if (env->prog->aux->sleepable)"
> > >
> > > I think you're proposing to pass a boolean flag
> > > into the helper instead of gfp_t?
> > > I think gfp_t is cleaner.
> > > For example we might allow local storage access under bpf_spin_lock
> > > or other critical sections.
> > > Passing boolean flag of the prog state is not equivalent
> > > to the availability of gfp at the callsite inside bpf prog code.
> >
> > Ah yes, then using gfp_t makes sense as we may have other use cases.
> >
> > I think we can follow up with the changes Martin suggested separately as
> > the current behaviour is essentially the same.
> >
> > In any case, you can add my:
> >
> > Acked-by: KP Singh <kpsingh@kernel.org>
> 
> Thanks for the discussion, KP, Kumar, Martin, and Alexei!
> 
> For v2, I will make the following changes:
> 1) Allocate the memory before/after the raw_spin_lock_irqsave,
> depending on mem_flags
> 2) Change the comment "*mem_flags* is set by the bpf verifier" to
> "*mem_flags* is set by the bpf verifier. Any value set through uapi
> will be ignored"
It will also be useful to double check if the existing sleepable
lsm selftests can cover this change.
