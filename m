Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CA4DA2F5
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 20:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351267AbiCOTHH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351359AbiCOTHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 15:07:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEF6344C8
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 12:05:17 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22FGWX29028703;
        Tue, 15 Mar 2022 12:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=08b/2ICqQBMnSwLvqee7Fg3SFV9B/4jhLKdP1s06jzg=;
 b=ECZqlM2hTJfgel7BLbZaDUjLxpMgXAgmxgRjWLQMGidwNJ5PTKaAsGRmVy8h+ANYFBSD
 5PtDaU1v3Ty52dttFcjFQoRH+TqZiVrR1w44gZg/oBKN9Ih/hhe0D4owEGxH3ry7wTha
 ET+G6oZHt5C2ZwvqiKv5dnbIGb4Z1W4JZFc= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by m0089730.ppops.net (PPS) with ESMTPS id 3et99mhqy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 12:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8N283/XgsOO2jeopzaWhWPWYsxOZz9qgif2Se4bTs/B/DMTXyzbbYwIOzKF/8EkO8b5hUHR0upexGM6/QN7pP0Y9cbS+FSLdVR/1hXgwULx/wPtxT/9tTbXyMSnnl9fpnLmJEkKqia53ZcDdw7TYEEdICH3Cnp4ndMXAcX4b0TSKEeZfIPNG+GNOLA1joGT2h1M2GebqZpeZ34o4dHXZAKb16OuzumnsxaALjsQzZnxlYEh6W2v/OCYcDVFca4C9XRHHmwAFX/srUYR+4Gs6okh/EB/zCknlPzj0rM2TLFaBbAj7FSXcm0XWNfdwrBGPXmMa1G8bTcQx7YMxhiXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08b/2ICqQBMnSwLvqee7Fg3SFV9B/4jhLKdP1s06jzg=;
 b=ZDCz462n6ocYA83R3s1sXuMo8N4WyGLgcuGQgA8rNT4wNnhPkTg1RaoUByrMVN6sKsQxHgXeauwrb6rWHzhjQCC62vrcMORBsjvRCPH8SlFjKt24bi0bkrxVXSrS7pF2g5ReN6XI4mGG83imTRQD41KOLKYjUEg5f0VeVl1WJSNvkrAdqTkOwJkvq6Mawfs1Ykg9P8NublRtzN6iraeZDzajB9t2NyVrEH62GKkDTzhnFRF8w3/tAz9zDZBcC/ueYwFuaRckN3eHzOLwf2In1BytCpzco7WxVdtmqZPsTcOvofc5SPiofqwEpkRy63NXixAmsqX460Yaaa+RRc2SSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BY3PR15MB4850.namprd15.prod.outlook.com (2603:10b6:a03:3b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.29; Tue, 15 Mar
 2022 19:04:59 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 19:04:59 +0000
Date:   Tue, 15 Mar 2022 12:04:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>, Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, tj@kernel.org, davemarchevsky@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Enable non-atomic allocations in local
 storage
Message-ID: <20220315190455.7v6wjovhrhnezvxi@kafai-mbp.dhcp.thefacebook.com>
References: <20220312011643.2136370-1-joannekoong@fb.com>
 <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ6TWGOWk5UTh6juuEO2xYheu7MEh-m=R8h20sCG5sV71g@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0388.namprd04.prod.outlook.com
 (2603:10b6:303:81::33) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 720d421f-a905-469a-93dd-08da06b6b3bf
X-MS-TrafficTypeDiagnostic: BY3PR15MB4850:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB48509F03689052D53A21CCB9D5109@BY3PR15MB4850.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwAhypUpMiVfzjc2vuPzFB1kF7gdkqCHDqoYPV5kzcMWmr6O9Mrn43msUJpK23psuO0I8GFzohFKScoHqCxr4tHtGsXvbgi/EE0N0jMz6AnCsflSfU4nbkySo18S0TVBoY2kZfbptGkuLwDdLsR7NVcx53Vv5eVUA0tezCJ+9rljsV8gEEaU7zE1+7w9NST5MAXgS2MyPb4lVCW5GOND4jkxWzoy1DfATVbO170HFflmcxGgv0KqNQjF9hDPluAthg2wq5KmqIHtmyvafgzpyNH5ZPXj+V6NfwJeZwdhDu8p+5GlghdY8J5271B/fjo928n+m2eIPHV73sSJ+7kMHk3nKo7XnkmIk2hAthW6/uMttGhunpuRzwi96DbkniP+MfRsNhhFGGXdvBfEMJx8Ga1nNXHmzv/EceITPq/LZjZs6zaS4nbghqsDpNeu6bY+9zTxUDVDa5XlcBZMlvdr/OA0ets6S7XxB1DaJmOnfmzim4IyYFlOCkxJRSqDGxCAKjClnYUV51ThJYQee4iOijjK4GT18x4UnW9Y69YwFUoD9FSD2D/Y8mXDzFZQVcDlogm1y7KeN3v7Ku21CnBYHA64+CyCWe/C2oAkXZWSaTAm118ZxTzEvomSyAIJ42d0VTgkCv8qZkWFixfdhi9dig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(4326008)(5660300002)(8936002)(38100700002)(86362001)(8676002)(110136005)(52116002)(1076003)(508600001)(6486002)(186003)(9686003)(6512007)(6666004)(6506007)(66946007)(66556008)(66476007)(83380400001)(6636002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vHMZbf69qUY9afslo8Erri3bpJCphHbbPfNPuyO2n77MSK9hXL/g3N/7k2lp?=
 =?us-ascii?Q?Rk2Ouoclyfqdre7IKZyA6ciKZVCJ9yKOnV0uLHtVW8krgNsBCJNo+Yz8EToQ?=
 =?us-ascii?Q?8RMlDOcDCkHIyvpK7vP7OPBnLVRRdEV1bSqxaZwgG2lKbEM/y8QE/6Ikmpgi?=
 =?us-ascii?Q?XRM7aL3VH+p9Ln9LA0LNEpZ91091fI3MABqA1PYNNKerOCNVxz+Yz+Jv2Nts?=
 =?us-ascii?Q?bUFy8wjAJ+ocvFgomz+VmUAQadHgb9tZjO1/99RhN5auBIHm4ic368xhONt+?=
 =?us-ascii?Q?JJDLA9CVSf0lXDgrYBE4Ab7E57MW9DosYgwp4u+bxVtKM/7dEbucX9cJSmpw?=
 =?us-ascii?Q?s3y6P5EiB+bKijXhUsItNLbl8IZSi1w8rGmi/iJcUzhe7AP/Wz2KP+GN/gRP?=
 =?us-ascii?Q?EyeiFJHWm/EIGqcc8+YzHe5rKEMGgVgahAY82W0krEsB9Z/iXdX4AKZ2vIWE?=
 =?us-ascii?Q?jdR0kQ7pu3mR8Lso1444Chs72r/XwdBXmpBNLLtHOrmUxFjk8Rb5vmZWdPpJ?=
 =?us-ascii?Q?MlQfZpeJtIvDjE1azg9y363LscV6gbfkkhMNyrYI83CqdrCXs5BSUs65iNwV?=
 =?us-ascii?Q?asfgef0KMdowUgJzJK6or+4xySxMQVNIsrpiJp/LyySkwbc1O1GnUskvF+Zc?=
 =?us-ascii?Q?rMwL6qt+z0S3S/lsdBJDMxexDqXhsx0ldOeyGEUs114vXMdlPKzBEYdfIm+g?=
 =?us-ascii?Q?5DBVLareNbWVDPrNdEaYd/J4QiwkVcabEmdy2Nqt5S7zus1/4nMeUkRGw535?=
 =?us-ascii?Q?53D8CqiDvOe1N6I+re6Bc6tRkpt6tjc0Gcf3QsR2BWgiVinJPRNmZT6hxFn8?=
 =?us-ascii?Q?Iowf3gcSgqMhoVJBe8jarB0AoMV9tiFnrlWlXRT+EuN3SwYTxDA8cnx7OP95?=
 =?us-ascii?Q?zbqvqVJ0MIQsJQdTKSskJVs0+184Ax8Fn2vG5sN3BCR8NbboNMCT0XY64YDk?=
 =?us-ascii?Q?Qtj+pX7HMADBtJ9Ec5GcLOvCFzaed5n5ZNb++BiVpxhAk7DVXAnna6f7m4no?=
 =?us-ascii?Q?4TczeofSTrr2101AMAtU+Lc59BOapIy+eZZD0RxISBBM2ujk/F182qx2R6J2?=
 =?us-ascii?Q?nLZYAWtodTCsF378+0ENLRHKi6n3mpPQLz7+0ck3RXrYtPIZOQZYJkEmwBwX?=
 =?us-ascii?Q?+BppYpf5pbApvK9UFXfk29Y1ow2E6IjUhH9BhWiyfM2XWhLV8n+SkwEcGQvd?=
 =?us-ascii?Q?P3au0HwsewyGMqvGq84IxlgmRi8T+kcO0KYpedNoYwTr21KuHq/mhZWD6Eyd?=
 =?us-ascii?Q?Uctqa6XP4lipVWVjmrhW4zI4T39wwZ9SPLgmKbXSiprvmFV7qSmbzaXNNEbs?=
 =?us-ascii?Q?sCofGgOBBLN7lcDsdiYqRFftL+hcOVbDhwTGz1CJW28GphPgW38mmMGv72IU?=
 =?us-ascii?Q?kh+2QzFkjw28s4Gzj80v0LrQfr6TPqE+0Wttjfx5ZCS4VPfq42QTwLjknfcT?=
 =?us-ascii?Q?EFoOIB3hr40EmWRgG3B5WRVm9+syqltQVHSQ+kWnwpQwcuxx609Avg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720d421f-a905-469a-93dd-08da06b6b3bf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 19:04:59.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qCOB3CfFAl3Wkibo68eAF4V028WhC0uDdQPTb5LhVNxUVpZ6eruhtPELYrxmtkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4850
X-Proofpoint-GUID: f43XO0k4HUAz9Ed99PVQno1KrPyDjI_x
X-Proofpoint-ORIG-GUID: f43XO0k4HUAz9Ed99PVQno1KrPyDjI_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_09,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 03:26:46AM +0100, KP Singh wrote:
[ ... ]

> >  struct bpf_local_storage_data *
> >  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> > -                        void *value, u64 map_flags)
> > +                        void *value, u64 map_flags, gfp_t mem_flags)
> >  {
> >         struct bpf_local_storage_data *old_sdata = NULL;
> >         struct bpf_local_storage_elem *selem;
> >         struct bpf_local_storage *local_storage;
> >         unsigned long flags;
> > -       int err;
> > +       int err, charge_err;
> >
> >         /* BPF_EXIST and BPF_NOEXIST cannot be both set */
> >         if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> > @@ -373,11 +373,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >                 if (err)
> >                         return ERR_PTR(err);
> >
> > -               selem = bpf_selem_alloc(smap, owner, value, true);
> > +               selem = bpf_selem_alloc(smap, owner, value, mem_flags);
> >                 if (!selem)
> >                         return ERR_PTR(-ENOMEM);
> >
> > -               err = bpf_local_storage_alloc(owner, smap, selem);
> > +               err = bpf_local_storage_alloc(owner, smap, selem, mem_flags);
> >                 if (err) {
> >                         kfree(selem);
> >                         mem_uncharge(smap, owner, smap->elem_size);
> > @@ -404,6 +404,19 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >                 }
> >         }
> >
> > +       /* Since mem_flags can be non-atomic, we need to do the memory
> > +        * allocation outside the spinlock.
> > +        *
> > +        * There are a few cases where it is permissible for the memory charge
> > +        * and allocation to fail (eg if BPF_F_LOCK is set and a local storage
> > +        * value already exists, we can swap values without needing an
> > +        * allocation), so in the case of a failure here, continue on and see
> > +        * if the failure is relevant.
> > +        */
> > +       charge_err = mem_charge(smap, owner, smap->elem_size);
> > +       selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
> > +                               mem_flags | __GFP_NOWARN);
> > +
> >         raw_spin_lock_irqsave(&local_storage->lock, flags);
> >
> >         /* Recheck local_storage->list under local_storage->lock */
> > @@ -425,25 +438,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >         if (old_sdata && (map_flags & BPF_F_LOCK)) {
> >                 copy_map_value_locked(&smap->map, old_sdata->data, value,
> >                                       false);
> > -               selem = SELEM(old_sdata);
> > -               goto unlock;
> > +
> > +               raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > +
> > +               if (!charge_err)
> > +                       mem_uncharge(smap, owner, smap->elem_size);
> > +               kfree(selem);
> > +
> > +               return old_sdata;
> > +       }
> > +
> > +       if (!old_sdata && charge_err) {
> > +               /* If there is no existing local storage value, then this means
> > +                * we needed the charge to succeed. We must make sure this did not
> > +                * return an error.
> > +                *
> > +                * Please note that if an existing local storage value exists, then
> > +                * it doesn't matter if the charge failed because we can just
> > +                * "reuse" the charge from the existing local storage element.
> > +                */
> 
> But we did allocate a new element which was unaccounted for, even if
> it was temporarily.
> [for the short period of time till we freed the old element]
> 
> Martin, is this something we are okay with?
It is the behavior today already.  Take a look at the bpf_selem_alloc(...., !sold_data)
and the later "if (old_sdata) { /* ... */ bpf_selem_unlink_storage_nolock(..., false); }"
Most things happen in a raw_spin_lock, so this should be very brief moment.
Not perfect but should be fine.

If it always error out on charge failure, it will risk the case that the
userspace's syscall will unnecessary be failed on mem charging while it only
tries to replace the old_sdata.

If the concern is the increased chance of brief moment of unaccounted memory
from the helper side now because GFP_KERNEL is from the helper only,
another option that came up to my mind is to decide to do the alloc before or
after raw_spin_lock_irqsave() based on mem_flags.  The GFP_KERNEL here is only
calling from the bpf helper side and it is always done with BPF_NOEXIST
because the bpf helper has already done a lookup, so it should
always charge success first and then alloc.

Something like this that drafted on top of this patch.  Untested code:

diff --git c/kernel/bpf/bpf_local_storage.c w/kernel/bpf/bpf_local_storage.c
index 092a1ac772d7..b48beb57fe6e 100644
--- c/kernel/bpf/bpf_local_storage.c
+++ w/kernel/bpf/bpf_local_storage.c
@@ -63,7 +63,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool charge_mem)
+		void *value, bool charge_mem, gfp_t mem_flags)
 {
 	struct bpf_local_storage_elem *selem;
 
@@ -71,7 +71,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 		return NULL;
 
 	selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
-				GFP_ATOMIC | __GFP_NOWARN);
+				mem_flags | __GFP_NOWARN);
 	if (selem) {
 		if (value)
 			memcpy(SDATA(selem)->data, value, smap->map.value_size);

@@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		}
 	}
 
+	if (mem_flags == GFP_KERNEL) {
+		selem = bpf_selem_alloc(smap, owner, value, true, mem_flags);
+		if (!selem)
+			return ERR_PTR(-ENOMEM);
+	}
+
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 
 	/* Recheck local_storage->list under local_storage->lock */
@@ -438,10 +448,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	 * old_sdata will not be uncharged later during
 	 * bpf_selem_unlink_storage_nolock().
 	 */
-	selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
-	if (!selem) {
-		err = -ENOMEM;
-		goto unlock_err;
+	if (mem_flags != GFP_KERNEL) {
+		selem = bpf_selem_alloc(smap, owner, value, !old_sdata, mem_flags);
+		if (!selem) {
+			err = -ENOMEM;
+			goto unlock_err;
+		}
 	}
 
 	/* First, link the new selem to the map */
@@ -463,6 +475,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 unlock_err:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	if (selem) {
+		mem_uncharge(smap, owner, smap->elem_size);
+		kfree(selem);
+	}
 	return ERR_PTR(err);
 }
 

> 
> > +               err = charge_err;
> > +               goto unlock_err;
> >         }
> >
> > -       /* local_storage->lock is held.  Hence, we are sure
> > -        * we can unlink and uncharge the old_sdata successfully
> > -        * later.  Hence, instead of charging the new selem now
> > -        * and then uncharge the old selem later (which may cause
> > -        * a potential but unnecessary charge failure),  avoid taking
> > -        * a charge at all here (the "!old_sdata" check) and the
> > -        * old_sdata will not be uncharged later during
> > -        * bpf_selem_unlink_storage_nolock().
> > -        */
> > -       selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
> >         if (!selem) {
> >                 err = -ENOMEM;
> >                 goto unlock_err;
> >         }
> >
> > +       if (value)
> > +               memcpy(SDATA(selem)->data, value, smap->map.value_size);
> > +
> >         /* First, link the new selem to the map */
> >         bpf_selem_link_map(smap, selem);
> >
> > @@ -454,15 +479,17 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> >         if (old_sdata) {
> >                 bpf_selem_unlink_map(SELEM(old_sdata));
> >                 bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> > -                                               false);
> > +                                               !charge_err);
> >         }
> >
> > -unlock:
> >         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> >         return SDATA(selem);
> >
> >  unlock_err:
> >         raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > +       if (!charge_err)
> > +               mem_uncharge(smap, owner, smap->elem_size);
> > +       kfree(selem);
> >         return ERR_PTR(err);
> >  }
> >
> > diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> > index 5da7bed0f5f6..bb9e22bad42b 100644
> > --- a/kernel/bpf/bpf_task_storage.c
> > +++ b/kernel/bpf/bpf_task_storage.c
> > @@ -174,7 +174,8 @@ static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
> >
> >         bpf_task_storage_lock();
> >         sdata = bpf_local_storage_update(
> > -               task, (struct bpf_local_storage_map *)map, value, map_flags);
> > +               task, (struct bpf_local_storage_map *)map, value, map_flags,
> > +               GFP_ATOMIC);
> >         bpf_task_storage_unlock();
> >
> >         err = PTR_ERR_OR_ZERO(sdata);
> > @@ -226,8 +227,9 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
> >         return err;
> >  }
> >
> > -BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > -          task, void *, value, u64, flags)
> > +/* *mem_flags* is set by the bpf verifier */
> 
> Is there a precedence of this happening for any other helpers?
Kumar has also mentioned the timer helper.

> 
> You may want to add here that "any value, even if set by uapi, will be ignored"
> 
> Can we go even beyond this and ensure that the verifier understands
> that this is an
> "internal only arg" something in check_helper_call?
The compiler is free to store anything in R5 before calling the helper, so 
verifier cannot enforce it is unused or not, and the verifier does not have to.

> 
> > +BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> > +          task, void *, value, u64, flags, gfp_t, mem_flags)
> >  {
> >         struct bpf_local_storage_data *sdata;
> >
> > @@ -250,7 +252,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> >             (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
> >                 sdata = bpf_local_storage_update(
> >                         task, (struct bpf_local_storage_map *)map, value,
> > -                       BPF_NOEXIST);
> > +                       BPF_NOEXIST, mem_flags);
> >
> >  unlock:
> >         bpf_task_storage_unlock();
