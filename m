Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E704DBCF2
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 03:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiCQCZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 22:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiCQCZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 22:25:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330891C910
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 19:23:50 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GHCduq028585;
        Wed, 16 Mar 2022 19:23:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=e2tDHeRMy9CFvYejyIF+TBAPLt6ggLqWg0pC0T3e5Bg=;
 b=Tuya6rBv5ArBJRTIdpClowAd455Hx4E68wV4vKIlUGa3vwCJ9/gFlvLIG59ONaYszXaq
 ZJhed16cewA0J6hdBQljApVCHa0wrVFFlyN7GLytNBcig8UENPNBF+YWhJRMw4ePFHHr
 yFYG5ludwoP4xM/nM0H++ooa6VF3OberX3k= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eucf46v4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 19:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3PONmILFQ8G7wO2ZT6EaF0iAOJiQMVuJAvmtRXN1aCpjrw/tKmPKDTu8+9ocXrPfpXSOC6Br0wfJLtZc3st3zJQ1e4DcezY7tjbIe2BMznU6auqsFfsaVJrvYd/GCs2f+0JAzFJDWL4Ow8Bt3v0VNr1ZCAKt+xpodxDsOQYybkmp0FIBRYuuPaizoDYkCqFSTRKVlTECm0ox9uOdkCOIl5OcBETUTS3wQ4UL64pIz7//RfUgDZlGol7O1/R0dtDKOs0C9S0rwTn28EOhioHq8ht3yf59f0P6B9IDQg/nq0O7OzM4Pp6uqm0u3Abwn9H14RA1B5Po4bOn1sBZCfYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2tDHeRMy9CFvYejyIF+TBAPLt6ggLqWg0pC0T3e5Bg=;
 b=HAvSemz+jldn6ozjCjJ/a6wwXC8NsV1zgnJks1tfLXY4dXLaJ/XHTIi3A4MWV69fHOPiZHIu/lVj98lJLqjUGX1gI/A3ZPYJt58RLVgnLpfPlAkdyPAiByA1luOXeTl9ySfDvmTzmt7TgHK3Z5UFBKpd4ZysWt6JDktt+cjrSTMCUwcvcOwHhM1pcZ2I9Bf/HLp/8LZni0nrwL9unAr5WE3C41kDwtxfsXdLBImYXadu6fyaDg77PMU2XMR99XBtLgR0rfQBe+l8POwoNEmyaSnn0sYakM9a478sGTYs4L74Wif+z7YXhKEHpc1richvs9GPdOH+SjvnMj/7HgUW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by PH0PR15MB4624.namprd15.prod.outlook.com (2603:10b6:510:8c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 02:23:33 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 02:23:33 +0000
Date:   Wed, 16 Mar 2022 19:23:29 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org, kpsingh@kernel.org, memxor@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, davemarchevsky@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Enable non-atomic allocations in local
 storage
Message-ID: <20220317022329.7wpltaqviw45qabl@kafai-mbp.dhcp.thefacebook.com>
References: <20220316195400.2998326-1-joannekoong@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316195400.2998326-1-joannekoong@fb.com>
X-ClientProxiedBy: MWHPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:300:129::13) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e6d887f-8084-4aff-8293-08da07bd221b
X-MS-TrafficTypeDiagnostic: PH0PR15MB4624:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB46247FFDA1C6B977396E0808D5129@PH0PR15MB4624.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bic8nhRiZw8YgbXui2sxxoAaE9xM4CkHkDYBazeRs9Iv8AsGnDGYhxv4v8+2GWSi8WAhuAB05meCpxM12ur+Pia3NAA3/ki4BPhFq0mLdDc3sG6VZU6yy8nF2e5bsgkDM66WYeRpUhajLqFEY/5lZJKuaX5tCPh32KhwkGM/ACrJoP/lbUURCkvf8ifTfLNJcj40AkosX2FoGlo/horwAqkiaI0s1jyfiaxHBU5Op9B66q27nf9fE8aeHllcKotP+QWEMdENCLpzJrgHuL9LeVyV35RKtNF/VqN78aTf9v1UKopNgoZExg44k7IDUHf9tGNLzwyUpwK00SB8mOa/fRip2rG4k5WaeRCvmBRiIROlEypm74E9SZ7x4WH2bN04N39SBbpCpylbljVRc01nstqld8WZrzNLIAjne6LPPp2q8EEN3y1GmwnIQsqnaiOK2TmiTFwaTmOjfn3ngXTm4B9tk5Xq4UxH8IjqB+ZXwkGbanm2WLOflvs2jfBoNx676F4ZdN2ci4W4bo0VMjy4gyCaoEzvvlziYsg9JtyURn+Rq4ze0EKoSAtUR1dUwXFL04pEewFXXjPeZHKEPt1Ekl4LcS6756LlhgG6eTkSggukj4BvalN7AokqWpH2dbbzXO8LfWEPLS3ACAfhtCJOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66476007)(316002)(186003)(66556008)(8936002)(1076003)(6636002)(38100700002)(6486002)(4326008)(2906002)(6862004)(8676002)(508600001)(83380400001)(52116002)(6666004)(5660300002)(9686003)(6512007)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?exGZLkCs3kxRVY52TC469jKX4t6G0sEAwL8vBu34NDU/OEhohkQcO6ffXYPf?=
 =?us-ascii?Q?urpSQa/OBgqhi3A19j5PsS0ziyAxDyLcsgTdX+1hWlgpSzACc9bzgbxr//22?=
 =?us-ascii?Q?6x/9KSyLECrlI85Du1SvGZJWng7r2Rg1bSnDYYkeD35SMhKXsmTxoKA9Tjm9?=
 =?us-ascii?Q?1pXuNzDVG5TSwcvm4fjPgJAY1AvGxAoJZQutFPNagbdvL6q+BgL0H+M0VXJz?=
 =?us-ascii?Q?npBFiUhH0WFMIfFo6iEaLOb7wbti+W/oyRDsWLtrvOhBjUSF+fVdIOnFFUJY?=
 =?us-ascii?Q?gPFhIjXeROMmalRgwzXR8ACv6MJEHARVT2sy60SHIgvjkERApi+8a6WSWi3n?=
 =?us-ascii?Q?eHx67typotr4q/XxkdDOqsRPmv5PcJITKRedrwIOePqdyQQCcwjVqVoKRdqE?=
 =?us-ascii?Q?KRWtXZ/UCOvbrZsCRc1LTO5ydVmsfMc/yt2Sp4JwdH8wdpOVCWXOsZOnEaMc?=
 =?us-ascii?Q?XS7LZ0wrTuRAmJRedrdl8soC7uvXvpkGjVPMcKRsgzRPS6G/CdK0NQVjAekZ?=
 =?us-ascii?Q?vn9W2lTQlpEDgDz0eJfIdeNNEPlNuegdTRk4O8P88Yxz/6QkCLCD49LKDzOv?=
 =?us-ascii?Q?SSopwVvJhFDQE9VWFsv/8md1Z2SofJBwiTE0sFcnyXh8YGcIdG0khOoSrCL+?=
 =?us-ascii?Q?dXmVwdVS+uR4xaA7Nqm2DoTXm2YDMDLBsUDgLA+8EigVIU233fNdtvTMY8fU?=
 =?us-ascii?Q?i2bcDiDZ0H9HXuVLmxaRks9yX00704ff+rQOZRyO3jnYfOFF/22tUs82lX0q?=
 =?us-ascii?Q?QntnIaa42aEd/aGgqa8eLGv5EuA+U2yv9r6kWX0MDa/3GtsclEnhX+MdiNyo?=
 =?us-ascii?Q?E9xOOpRYp0TjRZ/sabxKUQl2ngmEBm1w4yKYUPoZOtIgOu/Ia8E8Tlm0i9B5?=
 =?us-ascii?Q?HexqCae13NYtZNhEaQnF8RpXVCZV07+8NHTDxTLRJXDJvsOMp+CZ/VPAGbkH?=
 =?us-ascii?Q?GQSysgGsfTMMOuBMMVFQZ50fteaATHPWnDZ9pZLKQ8esDAOwOzMLgcCOCoaW?=
 =?us-ascii?Q?lLQiMFlCwwCdYeuaOrc2dCoxz5WchPVuEhljZVgWZ+szBDBR76+BoXK9ocrd?=
 =?us-ascii?Q?9kOvJrQT3ew/NIGNfA//X6q7KQcq9Id4EKrDW3NexGCnxxr1VdnH0tpv64rK?=
 =?us-ascii?Q?roNkM8sbsA6r2NQLsGVIAjZjIdoBaGkGVzlxw435oDr/nEBbsrRnj8JN3BX5?=
 =?us-ascii?Q?tPF0hzbeiegoWppRHBXeEOKx75Bdb6oIaE13th+/hvidTM9C+zO6ueP+ADuK?=
 =?us-ascii?Q?VL0J5+ntU6wK7TBv3f7iXFLTOcOmw4nNjr28NBfxb95ckERXPfTMBhAZOCgJ?=
 =?us-ascii?Q?WAXTLMgJp44drPRTVqMghb5mOayaXV45uwR5XTc28FCxOuYFdCpWhDarsfII?=
 =?us-ascii?Q?1XmD426W9CrRsGH/dGNjRUtjCsFyBaxhuRYaDz9hjpR96IpsuFPTaKWeSz14?=
 =?us-ascii?Q?kow4kEieGHbbbNJ2EJ3rESRCQhwovMoia6oMxheaO3SFkYfBA9kqEQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6d887f-8084-4aff-8293-08da07bd221b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 02:23:33.1287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FN/U/LcUcSkb3S3jsZM/ZRwwkzFFx3pf8krzXzIExvxp7H2Mr6d/p6Xbtwlt7bF+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4624
X-Proofpoint-ORIG-GUID: NicYwcmdXP0c45as1OgbTX_m79TSE65T
X-Proofpoint-GUID: NicYwcmdXP0c45as1OgbTX_m79TSE65T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 12:54:00PM -0700, Joanne Koong wrote:
> From: Joanne Koong <joannelkoong@gmail.com>
> 
> Currently, local storage memory can only be allocated atomically
> (GFP_ATOMIC). This restriction is too strict for sleepable bpf
> programs.
> 
> In this patch, the verifier detects whether the program is sleepable,
> and passes the corresponding GFP_KERNEL or GFP_ATOMIC flag as a
> 5th argument to bpf_task/sk/inode_storage_get. This flag will propagate
> down to the local storage functions that allocate memory.
> 
> Please note that bpf_task/sk/inode_storage_update_elem functions are
> invoked by userspace applications through syscalls. Preemption is
> disabled before bpf_task/sk/inode_storage_update_elem is called, which
> means they will always have to allocate memory atomically.
> 
> The existing local storage selftests cover both the GFP_ATOMIC and the
> GFP_KERNEL cases in bpf_local_storage_update.
> 
> v2 <- v1:
> * Allocate the memory before/after the raw_spin_lock_irqsave, depending
> on the gfp flags
> * Rename mem_flags to gfp_flags
> * Reword the comment "*mem_flags* is set by the bpf verifier" to
> "*gfp_flags* is a hidden argument provided by the verifier"
> * Add a sentence to the commit message about existing local storage
> selftests covering both the GFP_ATOMIC and GFP_KERNEL paths in
> bpf_local_storage_update.

[ ... ]

>  struct bpf_local_storage_data *
>  bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
> -			 void *value, u64 map_flags)
> +			 void *value, u64 map_flags, gfp_t gfp_flags)
>  {
>  	struct bpf_local_storage_data *old_sdata = NULL;
> -	struct bpf_local_storage_elem *selem;
> +	struct bpf_local_storage_elem *selem = NULL;
>  	struct bpf_local_storage *local_storage;
>  	unsigned long flags;
>  	int err;
> @@ -365,6 +366,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  		     !map_value_has_spin_lock(&smap->map)))
>  		return ERR_PTR(-EINVAL);
>  
> +	if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
> +		return ERR_PTR(-EINVAL);
> +
>  	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
>  					      bpf_rcu_lock_held());
>  	if (!local_storage || hlist_empty(&local_storage->list)) {
> @@ -373,11 +377,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  		if (err)
>  			return ERR_PTR(err);
>  
> -		selem = bpf_selem_alloc(smap, owner, value, true);
> +		selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
>  		if (!selem)
>  			return ERR_PTR(-ENOMEM);
>  
> -		err = bpf_local_storage_alloc(owner, smap, selem);
> +		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
>  		if (err) {
>  			kfree(selem);
>  			mem_uncharge(smap, owner, smap->elem_size);
> @@ -404,6 +408,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  		}
>  	}
>  
> +	if (gfp_flags == GFP_KERNEL) {
> +		selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
I think this new path is not executed by the existing
"progs/local_storage.c" test which has sleepable lsm prog.  At least a second
BPF_MAP_TYPE_TASK_STORAGE map (or SK_STORAGE) is needed?
or there is other selftest covering this new path that I missed?

Others lgtm.

Acked-by: Martin KaFai Lau <kafai@fb.com>

> +		if (!selem)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +
>  	raw_spin_lock_irqsave(&local_storage->lock, flags);
>  
>  	/* Recheck local_storage->list under local_storage->lock */
