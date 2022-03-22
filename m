Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7E4E48B6
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 22:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiCVV6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 17:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbiCVV6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 17:58:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B6C6EB1E
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 14:57:16 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MIHtUX014737;
        Tue, 22 Mar 2022 14:57:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AFTpztHBTatuwV8woABzOROwfadljKgXf67PXzvKgaY=;
 b=RF0GTNT3OZyl68n3Uglq+ckbdgzDt4EOFS7tJ2vXsUqPOsCMD1anxlQA31CN6RvYD+GT
 wlu4+8Y75Zrhk0R/RrcxJV5H8RqsDA6rfW4G9UTWTBzzv1NFRq+frBCQY5uqf2C/4k4Q
 +9+irCxZ23CdlS6ncCigmJku4pNcdwKLIEw= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ey865xvu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 14:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrJBruQdNEL4X8VWjFeQeYwvxPqQ7IDqtR/Ikbwj7R39FkJ/Kx820Yzuy8jVKWaupZCK0d18uJukagiglNx3D6K4eWhy3soeFSj9w51XI5LNBXEEMSaHgmaLGgq/leStaUjaTTvoeoGsyYZ7UBoPgdX9MaKhuo3ESzrkIix1p8NYtBdUk9vbq6t9uwjjnzSKC+40HZfe+ktRCWz7NtndwXsG0IJgRY+sg+aF72qxpTjAx2V79oYQ5j0WG/3FUjqx7uGQzvJWpBvhw7EdUYtHcGkz3Fe1NBtD/s83Y37qwUfRJzwWfxWiaqZ+x8DJ8ued8q70X50rwSQe1cNJRJNOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFTpztHBTatuwV8woABzOROwfadljKgXf67PXzvKgaY=;
 b=npOxPJn125XjzsFT1bpbdu1H8vyscVohDpfPu90DZ9EsPgmOwoarCxLymXO5eIAiUjpGWTvic9/kb0HLlEmmA/dI3d9u1gZmt+Aijn+LAHdtCLU5fYfrFULcEFIz8uDC2jBysNYYGsJFQLsRfb8N1vtuXQ6U9hNnYXLTAuFcjNxr2Bk5qgycVzyDrUJPCOcavsiUogpNVEPVsHBCoBvFBVwPKcN4jg+D88v10XsA8L7LJuDQxIJchKkYk+3aNNJ06TrsrpulWrh1pzTsT/LkCvmnOlng/oAi1DYHuGe7qmVeCtjq0nEixlL7SFJMXNkYNg0TQVljcYTTCFUkYbhwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM5PR15MB1642.namprd15.prod.outlook.com (2603:10b6:3:126::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 21:56:59 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 21:56:59 +0000
Date:   Tue, 22 Mar 2022 14:56:56 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next v1] bpf: bpf_local_storage_update fixes
Message-ID: <20220322215656.xkfzvuc3blrl7mlq@kafai-mbp.dhcp.thefacebook.com>
References: <20220322211513.3994356-1-joannekoong@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322211513.3994356-1-joannekoong@fb.com>
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d098d294-9804-48b7-6743-08da0c4ee38f
X-MS-TrafficTypeDiagnostic: DM5PR15MB1642:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB16428EABE0B18B59E177B3D2D5179@DM5PR15MB1642.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeesfefB4uidGXBpHlePUw225VjVDFTtPKtghVwccGZB9UWfBp58Itj8Dlo5wTXfyd0DbvYAjinrYLA18XGAEtjWpGYZx6XRx9LPMquHoTnbRaXCkNyb5rFbV9XBDkVlqI4YpmzjvuIy6k9Xfalxad+jWkqE4yxBltu2CJAXV5KqRqkfbkEkL0bZtRr2/sFvVx3G8XXqNuC6CdGYwhCH7g827hg36PJSkDQdNxyg5mSpuCqd/lrAUBmrDIc3PA95b4blLY+6QIiVKErZhG3Syh4Rte2IRaXaSEQPKQP+Ux5w7Ttv6W8JfM0RpPYPuAmJE9QRo4OduKdZGuDXxHk0W51PsUOZ1qqxRJycwZrBf56B2qlsPV9DTucXsieRvD7HKsDvTp2MrLq6A5YT8gqsibZ7F+6nWUvBV3EmFyFnttvzBsS4Zf1/dfnqI+LeH90Kfoc0B6siX3CvPBf0uUvco6DoTP27Hk5m6knI4o4Yo3o/4/HCjJxmNH2NvO0kFKV5cwq0ThbHNwGyLPxWa+VCzkGrJT+7IZJ2tehhzD7dnTYngskKjPG2lBSjtYssK4azqAQ8v/EAlJEWUxbaSv/GuEAf+30QJ4c0YsTBMNFTYJ+4QluKvqblt83sTPpTj/j8hUiWzlIRi4YClxGTe4UNVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(186003)(1076003)(9686003)(6506007)(6512007)(6666004)(52116002)(83380400001)(316002)(6862004)(4326008)(66946007)(66556008)(66476007)(6486002)(54906003)(508600001)(6636002)(2906002)(38100700002)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u39aAeV60CnSnTLq9Z9mbBjTFMzr7t+PZnNKEDhoR+hIjoPu29XZplDOpMXy?=
 =?us-ascii?Q?/B5fJnQTWJ6VxXeLh5FtpXuf1WNrc/Md7PfUQbSGjEWr0Fq67Z+C6yP/Q1kF?=
 =?us-ascii?Q?PDGXfUVrSELQq1CcZ3ZpNdwfde0DeYnwEh4OPM3XcZOG9mmb71qTVxJ7OO1H?=
 =?us-ascii?Q?HaTCKVoLbe7GA482tB+VTjOt5FOGHf/SMxnER4Vby4BKy8IHXHMNTZKhtwYR?=
 =?us-ascii?Q?4c8fVTiO9VAoT0kpwjIlTopFGHHbyCYpVuA3WMDR63t2D2uTKXlFTkQe+UR0?=
 =?us-ascii?Q?5LadD/G2CBC74h4bT7EgbEZiqRFKhL4wWBiVsBSX8Q+owChTxR7r/X/5dKKJ?=
 =?us-ascii?Q?d6U3m+vMGI9Wx09WmSgvI/hbKdb1AGeLI39paIMDTVMFoPGuTKiR6puvgtTI?=
 =?us-ascii?Q?lJ71qVEAjTpZY5Gv6Rl923RLwALnNcR1QT347xHSgtK63xEyfOkanmk7g+D6?=
 =?us-ascii?Q?kXfPGFCpEZZyQYcBovKTEYdH5rFYgR3O2cbhgKtWATck5X7OQbYJ3BqJOWGp?=
 =?us-ascii?Q?wR3UlK0KhmSprMzQNP+Ar9WXwYvxK+OhT8cSsBB76V685Lo5io0vr8d26gB1?=
 =?us-ascii?Q?VBTK7UBNJRv9Cfzb8QMzEJi0z5Zv1Ej1F99Was9y3QUSk5P1pErlTLRZiij/?=
 =?us-ascii?Q?U+DosZfl3WPsyRgmlkMPXMVlZ0yCvqOYLWkRQggpqEoqugCpAIDsa4dhYKfD?=
 =?us-ascii?Q?HZUJD9DS9kAjJRYs4dcTg4VOyEF8a906Pj/qTI/4vcTgAsqY4Cue2WflDLmc?=
 =?us-ascii?Q?jeW0pxr0aEdO9rsiKNCAafugwVMkwZAu8Ry57tJlCCoV1lHSOW9hTVFWS5np?=
 =?us-ascii?Q?Mmb5a1Vu3blcVVVbUZkPByDKoPOimulpeA4JMV4bNHBh0HVMnQtTg0Y8aD4Z?=
 =?us-ascii?Q?UmmTmzEtI5/WF34Qmmwaj6AdV2TlnkO4l9Awjw3t7JUst35WMzn1kTW0qVW9?=
 =?us-ascii?Q?rlldMJkdN+kmoJoZRWn8Hk9qHYoz8efsiex6V99s6YPXdweQojxlfHo8zxtw?=
 =?us-ascii?Q?oSGeXne0UQMuT/iK88dj9mO1D0QY9YaHNexZjuLhsjXDutOFQBXbRNil9bbc?=
 =?us-ascii?Q?+VHXTsN9tr2tLnZJRTW0rmzAhiY+DwnWMrILD60wLdJkyB4/RyJX8smAPtpT?=
 =?us-ascii?Q?NW9MRtRFbA7MJy3KIjbAhCv2zu15IIWEdxSwaPC8QjK/aN1ov1hljcuFP3ak?=
 =?us-ascii?Q?Pe0ePPyK1z/jYopOGU74bgJF4QpTYBOQ1/8GRMAiXDvWjYzGOoCn5GDNjShW?=
 =?us-ascii?Q?qVuZ580c79K2sFvwXigArup3o4+5dJMd6GyWs2EH6cujTk2ExenDZTqMlvpP?=
 =?us-ascii?Q?nyvuy+sjoNYBxFvt/pSE8IjrG4fSbXRGlWauK0T1jspiq0uNr/oVgoQ8NbHF?=
 =?us-ascii?Q?qUGIZjakcMqmDg1pf4BFkqgSwiFQw5N2Cx2isXKs0fg+OO8Dlj7TOdZJ9+0A?=
 =?us-ascii?Q?0/SGXsi7HAea4Nk9GYOV+fYPZPKa/fZnZo51z0xp/sIFNBGaF7ls6Q=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d098d294-9804-48b7-6743-08da0c4ee38f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 21:56:59.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIweN3UhSprujvXBNDQYchOGjMXmZoMpAyRmqBchPjZGE3pTlWLN60dnIiODP4SE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1642
X-Proofpoint-GUID: iLquYelp_x4t9TcYnpcj2upJ9FPf0ygw
X-Proofpoint-ORIG-GUID: iLquYelp_x4t9TcYnpcj2upJ9FPf0ygw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_08,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 02:15:13PM -0700, Joanne Koong wrote:
> From: Joanne Koong <joannelkoong@gmail.com>
> 
> This fixes two things in bpf_local_storage_update:
> 
> 1) A memory leak where if bpf_selem_alloc is called right before we
> acquire the spinlock and we hit the case where we can copy the new
> value into old_sdata directly, we need to free the selem allocation
> and uncharge the memory before we return. This was reported by the
> kernel test robot.
> 
> 2) A charge leak where if bpf_selem_alloc is called right before we
> acquire the spinlock and we hit the case where old_sdata exists and we
> need to unlink the old selem, we need to make sure the old selem gets
> uncharged.
> 
> Fixes: b00fa38a9c1c ("bpf: Enable non-atomic allocations in local storage")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/bpf_local_storage.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 01aa2b51ec4d..2d33af0368ba 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -435,8 +435,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  	if (old_sdata && (map_flags & BPF_F_LOCK)) {
>  		copy_map_value_locked(&smap->map, old_sdata->data, value,
>  				      false);
> -		selem = SELEM(old_sdata);
> -		goto unlock;
> +		raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +		if (selem) {
There is an earlier test ensures GFP_KERNEL can only
be used with BPF_NOEXIST.

The check_flags() before this should have error out.

Can you share a pointer to the report from kernel test robot?

> +			mem_uncharge(smap, owner, smap->elem_size);
> +			kfree(selem);
> +		}
> +		return old_sdata;
>  	}
>  
>  	if (gfp_flags != GFP_KERNEL) {
> @@ -466,10 +470,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  	if (old_sdata) {
>  		bpf_selem_unlink_map(SELEM(old_sdata));
>  		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
> -						false);
> +						gfp_flags == GFP_KERNEL);
>  	}
>  
> -unlock:
>  	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>  	return SDATA(selem);
>  
> -- 
> 2.30.2
> 
