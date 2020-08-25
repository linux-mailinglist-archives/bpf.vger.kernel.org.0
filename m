Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB8250DD9
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 02:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgHYAxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 20:53:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41652 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgHYAxO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Aug 2020 20:53:14 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P0m7lQ019382;
        Mon, 24 Aug 2020 17:52:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7XHwgvrzbAAoxVMeJhGwebH1WVGpd53V5PExJl+kDZY=;
 b=X9gmCmvyA7i+vHscDLCpxZKQgRxcAeRHj4L1Yw/bL/+vxukYmYChQVZbVbY1p50jsnNa
 S1B9cv+njBo830lRJ0Zqhkbj9xRoNrmFVoSiNlFRMAFJZvYhRDrXdbgEEE6n9lLhy4fC
 i23nFWI5grU+tzeVQ/KvV454H9xS9Kk8Yks= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 333k6k02vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Aug 2020 17:52:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 17:52:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l25whs512FJCbZLQS0NJa+YM+JmZ7bNgkUl4MPudLVGyPiYQcHqgZYeh6VjYPx1eB0GPFScE9c66n5q78YccwVR8BH0iRH/aAZCAq7ce49U/PnIHcK9YchBSMxbTbb2l9VzuxRPzy5kIcCK/V3Oh+x3Wtp/SWubO5sbBSZnHkvsH6XaUSHUNaJAFBNAfOuITrj6zyVqDRPdcmM8K5PNpWuZhHX02c9pLq3UrfaQJM8aR/al2ZStd++1nz82jVZ4u54TC1r/es4lyJy4lg5TvYEOOkUc+w0fsBKrKQudJMhShch4paZnKMxeWbJvlz2yXl+XEbw6Dda/3mBnDiJGkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XHwgvrzbAAoxVMeJhGwebH1WVGpd53V5PExJl+kDZY=;
 b=H+BSk1OA3vV+kvDsvGVCluNAPx5LnUUdfEBXEw+VR3Iqub0teievBYeF7oyvZiI9/5jiCl8YbQ5+XyZQM4mK0kkFPJouPa7R3DZeAKFA7ZlI+9DFiNr7tap8+Cy0IsowL/2JjU4RmZgbhzvjnnSZNVIfrTNM8y1/ddrSXW4DlONvlj8IIJK+XIFqQZtXALJAx/cH2iEg7PvAMmKpK6ntGBdCaVoVg7i6MTaxgweyDxX7PCcgGF+x4NBNdbi+z4ICucv+INMs4TJuUhFDqOi6PQabvC3VFTU9lg3ElaDfAm4U5U8mDMXx1rf+jm4RDIwy/1DI5ZnN3tuFIK2CFs5PoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XHwgvrzbAAoxVMeJhGwebH1WVGpd53V5PExJl+kDZY=;
 b=K+Sax5Bt9YvSG+fXCkMhjD0eA3sUVCbZxW2xiq4ZanQvr+U3FJj9BmGIez7t+ma6gHZ+TtdEGfPI0NMMTbQgGk/HUld49RN3R7UEUEAA93W1kWhX46QmrC8Isnm+pY2+IXKUmQm19R+KpdSzGu16LyJU1zdB7pABfoElj4kWMhY=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3207.namprd15.prod.outlook.com (2603:10b6:a03:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 00:52:55 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 00:52:55 +0000
Date:   Mon, 24 Aug 2020 17:52:49 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v9 5/7] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200825005249.tu4c54fg36jt3rh4@kafai-mbp.dhcp.thefacebook.com>
References: <20200823165612.404892-1-kpsingh@chromium.org>
 <20200823165612.404892-6-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823165612.404892-6-kpsingh@chromium.org>
X-ClientProxiedBy: BY5PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:a03:167::28) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY5PR17CA0051.namprd17.prod.outlook.com (2603:10b6:a03:167::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 00:52:54 +0000
X-Originating-IP: [2620:10d:c090:400::5:87f3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 405b4b3a-1344-4167-e215-08d848913393
X-MS-TrafficTypeDiagnostic: BYAPR15MB3207:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32074FC1BC72F40213D75BBED5570@BYAPR15MB3207.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFYkxCuy+yebnNZqHO7PIhIPunKSQL0Kvu5AQBo58jFhoh9JMWLrggDeC8RypL7DQezYXAvCP4BTAJIoDrNGt9snzWq5XFSiqBvxBc6NlM6CrLXky6fI5TRfg5WUSLpvM4zdMJCLMr0/rcm2oHYM1gvF4Jgqg6iOUywaTxtQ86RrZrALchQVm625g+PKeWhlQJuePwyX1sOhhW1TwcKQ26P96pkzRv5Bkx6ZQb6tArFo56ocaniRmBwuG/gDlKzEeOnanIlvGYlwThjqVdatF40tNKgkpIiMn7sk+F31J/DiCoSIT2jdaEkWhzZjrgn0RWaHX+xp7dLsGAfdap70fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(83380400001)(6486002)(186003)(5660300002)(6916009)(52116002)(956004)(86362001)(4326008)(66946007)(16576012)(66556008)(9686003)(6666004)(8676002)(316002)(8936002)(2906002)(66476007)(54906003)(1076003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1cJL8Y4ZN5M9oJDcyu5TjAOmk4UlROze2SbN8iWHECGvGMjKoBTJjQrk8D9xttkRyRrErnFQhqT9M0FEnJw25VKkselF4ezKfDMEq2Gc2ryBWn6eMc79BdWveEWhZ9iKoc6mTxsE4wrFJh5eKK2SymH7eu7i1gRT+aLnONObG7cvtpZCPSLUtY8rLLD95LpWKiMbUhXYr/OzyS+B0faviXx1XCmEgbiidCoWBPEeDvGUmmwgpUmQTpSXbL/+ECfakuNQEoaDrGD/uzUvj/t0GWm5vUeO6wJG7wpJnKHAks/Nnfa8yaCV/aKvF3xnH3VSQ8VeJB1DJNL8SmVqWbXY9C+4i/lR/7dGadPFGESiveCVg/fHE+LCPJxfz9zE6O7pdsVCcatEJoJiegLaLymh7/AwuLLwf9Axd+NT/U7OxcV7ShDnMpHIsQrjgH8/GBrH8niuTjTiOrVV8bocGV8S4mY3KHEarvThYk/L5otEcTwEZ5yrZWCOnEO5X1mZpiA+GgConUi8JyTIM//l47BVBfJY4g4tdgmjCax6gZKda1pE9VjD4I2n8h9LN//9o/EXRrSEHQnjsAb0P+qOyvjiWPNlvTxqKD+qLbIYCu92t55Ou3oqyarordSAwmyjm4ImK92t9e1vus8dHti/R8OMBkF2kyrYdXDKCWSHFBFwKTc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b4b3a-1344-4167-e215-08d848913393
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 00:52:54.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxlSDn9xYhU47sxQYR40qQeOHuJOw54Qpk9P/5pEtUBWWO9D3v+CU6IW6wOHbHV3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3207
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxlogscore=843 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250004
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 23, 2020 at 06:56:10PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Similar to bpf_local_storage for sockets, add local storage for inodes.
> The life-cycle of storage is managed with the life-cycle of the inode.
> i.e. the storage is destroyed along with the owning inode.
> 
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> security blob which are now stackable and can co-exist with other LSMs.
> 
[ ... ]

> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> new file mode 100644
> index 000000000000..b0b283c224c1
> --- /dev/null
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Facebook
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include <linux/rculist.h>
> +#include <linux/list.h>
> +#include <linux/hash.h>
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/bpf.h>
> +#include <linux/bpf_local_storage.h>
> +#include <net/sock.h>
> +#include <uapi/linux/sock_diag.h>
> +#include <uapi/linux/btf.h>
> +#include <linux/bpf_lsm.h>
> +#include <linux/btf_ids.h>
> +#include <linux/fdtable.h>
> +
> +DEFINE_BPF_STORAGE_CACHE(inode_cache);
> +
> +static struct bpf_local_storage __rcu **
> +inode_storage_ptr(void *owner)
> +{
> +	struct inode *inode = owner;
> +	struct bpf_storage_blob *bsb;
> +
> +	bsb = bpf_inode(inode);
> +	if (!bsb)
> +		return NULL;
just noticed this one.  NULL could be returned here.  When will it happen?

> +	return &bsb->storage;
> +}
> +
> +static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> +							   struct bpf_map *map,
> +							   bool cacheit_lockit)
> +{
> +	struct bpf_local_storage *inode_storage;
> +	struct bpf_local_storage_map *smap;
> +	struct bpf_storage_blob *bsb;
> +
> +	bsb = bpf_inode(inode);
> +	if (!bsb)
> +		return NULL;
lookup is fine since NULL is checked here.

> +
> +	inode_storage = rcu_dereference(bsb->storage);
> +	if (!inode_storage)
> +		return NULL;
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	return bpf_local_storage_lookup(inode_storage, smap, cacheit_lockit);
> +}
> +

[ ... ]

> +static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
> +					 void *value, u64 map_flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct file *f;
> +	int fd;
> +
> +	fd = *(int *)key;
> +	f = fget_raw(fd);
> +	if (!f)
> +		return -EBADF;
> +
> +	sdata = bpf_local_storage_update(f->f_inode,
This will be an issue.  bpf_local_storage_update() will not check NULL
returned by inode_storage_ptr().  It should be checked here in the inode code
path first before calling the bpf_local_storage_update() since
this case is specific to inode local storage.

Same for the other bpf_local_storage_update() cases.

> +					 (struct bpf_local_storage_map *)map,
> +					 value, map_flags);
> +	fput(f);
> +	return PTR_ERR_OR_ZERO(sdata);
> +}
> +

[ ... ]

> +BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
> +	   void *, value, u64, flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +
> +	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
> +		return (unsigned long)NULL;
> +
> +	sdata = inode_storage_lookup(inode, map, true);
> +	if (sdata)
> +		return (unsigned long)sdata->data;
> +
> +	/* This helper must only called from where the inode is gurranteed
> +	 * to have a refcount and cannot be freed.
> +	 */
> +	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
> +		sdata = bpf_local_storage_update(
> +			inode, (struct bpf_local_storage_map *)map, value,
> +			BPF_NOEXIST);
> +		return IS_ERR(sdata) ? (unsigned long)NULL :
> +					     (unsigned long)sdata->data;
> +	}
> +
> +	return (unsigned long)NULL;
> +}
> +

> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 32d32d485451..35f9b19259e5 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -3,6 +3,7 @@
>  /*
>   * Copyright (C) 2020 Google LLC.
>   */
> +#include <linux/bpf_local_storage.h>
Is it needed?

>  #include <linux/lsm_hooks.h>
>  #include <linux/bpf_lsm.h>
>  
> @@ -11,6 +12,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
>  	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
> +	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
>  };
>  
>  static int __init bpf_lsm_init(void)
> @@ -20,7 +22,12 @@ static int __init bpf_lsm_init(void)
>  	return 0;
>  }
>  
> +struct lsm_blob_sizes bpf_lsm_blob_sizes __lsm_ro_after_init = {
> +	.lbs_inode = sizeof(struct bpf_storage_blob),
> +};
> +
>  DEFINE_LSM(bpf) = {
>  	.name = "bpf",
>  	.init = bpf_lsm_init,
> +	.blobs = &bpf_lsm_blob_sizes
>  };
