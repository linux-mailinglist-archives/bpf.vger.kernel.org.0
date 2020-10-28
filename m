Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7780B29D392
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 22:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgJ1VpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 17:45:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29646 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgJ1VpQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 17:45:16 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09S1DFX4028484;
        Tue, 27 Oct 2020 18:13:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=y3hy4bwaqu7p6d4Pq72Dz54Ayx+ERH+NHjAW6XuxxPk=;
 b=Ii1F5Tj7xVj2eBKx1cjEE1mjTNdDTi4eOvczsDyjJCqvbIcNOZsiiQwdH5ynhaZ9I+X6
 9AD6s6pFxMwUqAY8dSZ9NQuftX2qhgCg8BDSKwcBxJACuF4pU9n5qQMUQKzbufRPL1Ip
 wNP1tLxvWeGi3p5vOUvpbJKR5+85pWADhVM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34d4hppxx6-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 18:13:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 18:13:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMN2saDmREpUBw9c8cc+lnadY+WADljf0xmqTQdgrh3Oa04mggywhYL9ocqSCJM0O/ZKblSQEmbDNGoO908hPEV5k1RHy2kcqNtRbL4Ynf/PLqBu0BA3rXl6/3VS973RbP9eBpWdZ40OJWDe55uwfg7v909NE0uqn49vYmUc9tra5l3BjAHDeMo05g7Pf3VXWeOqzQF6HKHPY2juaD1blfMsydYilWVRw7qwW2crirCP1rZGSKPWWLaHx8fV+xzZSPp/10zuOESLRzUOQC3d8osHrqReUVIwy1Wn3VLMiiTxh/lZ/T0MEb2uFrm5GqD0B+8o9/oOJsVlLTn+oBLLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3hy4bwaqu7p6d4Pq72Dz54Ayx+ERH+NHjAW6XuxxPk=;
 b=Fb6azW0Yml8an+FD8jEHB8u+F/MlGIPGzy+oxyHyoZZLlm0+UX89uUp9s6XJ1SJPSAHF7KoymExkgmAxM2ZPPrVZ/30ovkO9urqsMvGGg8badT6HK4OjSFOd27ax76m2oQRHqvAeCuDDfLbm0E8Q+KQnv79DObIaOLB4ACUfJZtbLc4RAEYdCDJ3V0VIWdPe9NPLw3AJ6s9mIddroEGHadhX+xuFJWR8YiMu3ETWRnCs9Vh7cbPBwcuyNzr5jc7yk8bZ1Hy9MFQL5q24tVRcLcRL79eVnexMg6uZEdqn3GnSNvjN7p8exaCbQSLkjd3eZSE/Wz8dVfUb8R/ykq0a+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3hy4bwaqu7p6d4Pq72Dz54Ayx+ERH+NHjAW6XuxxPk=;
 b=P4RoQpmRjMFgJ6hZEtc0pb3t3OyLV0MZ9rWvVYCU8yujns2FMsfmFSH3yBb4V8+EyCgi+v15+LmE8drAFxiPokDBX/Zpgj1Rmnj4P2mHgMqB7r/7eXzmyjdqvODCAHx5Snvwt3xrAhdRljy6iau/MwmVLEfRWwQGKHG9VlyN+wA=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3416.namprd15.prod.outlook.com (2603:10b6:a03:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 28 Oct
 2020 01:13:30 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 01:13:30 +0000
Date:   Tue, 27 Oct 2020 18:13:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
Message-ID: <20201028011321.4yu62347lfzisxwy@kafai-mbp>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027170317.2011119-2-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::4:9723]
X-ClientProxiedBy: MW3PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:303:2a::32) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::4:9723) by MW3PR06CA0027.namprd06.prod.outlook.com (2603:10b6:303:2a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 01:13:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6250d085-823b-46bf-9cce-08d87adeadbe
X-MS-TrafficTypeDiagnostic: BYAPR15MB3416:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3416812DAD977224A84EBEF2D5170@BYAPR15MB3416.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywzBOijc+SeMU9UQYCVljOr7DugNTDqlF/2p3xpMhSHwDbb3YBeAs2t34uVTBA7Y0ayY4r/1mftJ3PUMrJYl3x5PozrY95pfVm89wxFvOV1uQK0i1r5lWkHGVn6BcpbUYUdCMFmbFjSFimBrl6clOZ+GC2Ikcc20gPPHTIOnKpQqOo3zetENxoNoGaWEw3B91OPVGDUqHaGGB8BkLqhwSFPPk99OKayoT2Ejm1qAotYjOLTDHy1La8LL7CIbBtkPmtjad0BKfT9ZCsQHVgO2o4ResIgpXnNa0ZukzcAbWN4IPiyzESWVRzHq/OsVxwW4H7zIi+H9FwDeNyLdhrq6BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39860400002)(396003)(376002)(83380400001)(1076003)(33716001)(6496006)(52116002)(6916009)(186003)(16526019)(86362001)(5660300002)(4326008)(54906003)(8936002)(2906002)(8676002)(478600001)(66556008)(66946007)(9686003)(55016002)(6666004)(316002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: o4XENPCzRjrTNfFQMER9jd1nNTY/PejcDgmHoOvcC6Xt//pZv2lmeCvk39sTZPQ2FiXUZg+QeZTRGOglLZQVDbnKLtK2/nXLB694K6xh1LwmLCDF37BnXMGreRev/smBkaXTlO4NEIPoY/AE5/aKrFODmlZv61ycOkyysE1QHMHN54e5fxsvRNdlnWbaBjE9YEk+ZY6APVY+Sd3/zvwLw6I7hPbFDgUCemnBFPoXGcMmkQGrt/6JDk3Ecjy/xjyz+kDKdjihKO9ZUeA3a0/hO9itizsZGsds7ofB9a8GJPMtyEDgUlAsGkj3Mi+IHAkViWMIw6rfOffOCC5YN9C+r0OXRi6BmJqBU5hQPdTgrOycEHBoNPEPtluvRHjTCHHHdHhFzHCYN6XVoXn6G9o+jX9QRYo8BB29HlWJYB444YFieKXuR4UJiN8gh3RG8nJj/cedowYSm6ndf5PK5VN39+ZOgBmSdMUKSddMAnqLsKLIxd557WY0UZBd/iqZyjxu9UQxbgJWfbq85mA7UnW2GlJVzQcJTT6HkMdXFuktQ1wJeP19SbGEaMncyglmM4OOz4yZFCRwZuftk9JaPoXnUxYuak10lt/fF+hGqud6FLCopa0DA1TfF6d9JX6OKnixsHTAI83NGoZ/zMFwopyvJtobBYAbgDpwcb9o7RfoiyY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6250d085-823b-46bf-9cce-08d87adeadbe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 01:13:30.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BniGEJqtArw0uz1/hcPI3hdPcpKjUDTrTybp7lY+1KtlRrkvk9Q7sE4ae70WURDb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3416
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_17:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 suspectscore=5 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 06:03:13PM +0100, KP Singh wrote:
[ ... ]

> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> new file mode 100644
> index 000000000000..774140c458cc
> --- /dev/null
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Facebook
> + * Copyright 2020 Google LLC.
> + */
> +
> +#include "linux/pid.h"
> +#include "linux/sched.h"
> +#include <linux/rculist.h>
> +#include <linux/list.h>
> +#include <linux/hash.h>
> +#include <linux/types.h>
> +#include <linux/spinlock.h>
> +#include <linux/bpf.h>
> +#include <linux/bpf_local_storage.h>
> +#include <net/sock.h>
Is this required?

> +#include <uapi/linux/sock_diag.h>
> +#include <uapi/linux/btf.h>
> +#include <linux/bpf_lsm.h>
> +#include <linux/btf_ids.h>
> +#include <linux/fdtable.h>
> +
> +DEFINE_BPF_STORAGE_CACHE(task_cache);
> +
> +static struct bpf_local_storage __rcu **task_storage_ptr(void *owner)
> +{
> +	struct task_struct *task = owner;
> +	struct bpf_storage_blob *bsb;
> +
> +	bsb = bpf_task(task);
> +	if (!bsb)
> +		return NULL;
> +	return &bsb->storage;
> +}
> +
> +static struct bpf_local_storage_data *
> +task_storage_lookup(struct task_struct *task, struct bpf_map *map,
> +		    bool cacheit_lockit)
> +{
> +	struct bpf_local_storage *task_storage;
> +	struct bpf_local_storage_map *smap;
> +	struct bpf_storage_blob *bsb;
> +
> +	bsb = bpf_task(task);
> +	if (!bsb)
> +		return NULL;
> +
> +	task_storage = rcu_dereference(bsb->storage);
> +	if (!task_storage)
> +		return NULL;
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	return bpf_local_storage_lookup(task_storage, smap, cacheit_lockit);
> +}
> +

[ ... ]

> +static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct task_struct *task;
> +	struct pid *pid;
> +	struct file *f;
> +	int fd, err;
> +
> +	fd = *(int *)key;
> +	f = fget_raw(fd);
> +	if (!f)
> +		return ERR_PTR(-EBADF);
> +
> +	if (f->f_op != &pidfd_fops) {
> +		err = -EBADF;
> +		goto out_fput;
> +	}
> +
> +	pid = get_pid(f->private_data);
n00b question. Is get_pid(f->private_data) required?
f->private_data could be freed while holding f->f_count?

> +	task = get_pid_task(pid, PIDTYPE_PID);
Should put_task_struct() be called before returning?

> +	if (!task || !task_storage_ptr(task)) {
"!task_storage_ptr(task)" is unnecessary, task_storage_lookup() should
have taken care of it.


> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	sdata = task_storage_lookup(task, map, true);
> +	put_pid(pid);
> +	return sdata ? sdata->data : NULL;
> +out:
> +	put_pid(pid);
> +out_fput:
> +	fput(f);
> +	return ERR_PTR(err);
> +}
> +
[ ... ]

> +static int task_storage_map_btf_id;
> +const struct bpf_map_ops task_storage_map_ops = {
> +	.map_meta_equal = bpf_map_meta_equal,
> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> +	.map_alloc = task_storage_map_alloc,
> +	.map_free = task_storage_map_free,
> +	.map_get_next_key = notsupp_get_next_key,
> +	.map_lookup_elem = bpf_pid_task_storage_lookup_elem,
> +	.map_update_elem = bpf_pid_task_storage_update_elem,
> +	.map_delete_elem = bpf_pid_task_storage_delete_elem,
Please exercise the syscall use cases also in the selftest.

> +	.map_check_btf = bpf_local_storage_map_check_btf,
> +	.map_btf_name = "bpf_local_storage_map",
> +	.map_btf_id = &task_storage_map_btf_id,
> +	.map_owner_storage_ptr = task_storage_ptr,
> +};
> +
