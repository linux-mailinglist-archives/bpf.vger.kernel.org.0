Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F06247BD2
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 03:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgHRB21 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 21:28:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54222 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgHRB2X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Aug 2020 21:28:23 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07I1OEd7002461;
        Mon, 17 Aug 2020 18:28:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=E5JO0Ck19xyHdhZoxllY4gv5oQnWExvznN6WPjQujF8=;
 b=mC3bSg5MDYALzTedzNP/uwV5uUeisr0/8TrYli7fw3N3pDWN4D22RrOSnRcKhUDod+pP
 TaT82zPzTzEsOSdd40CSBpDDdZXAhb2vIsypVgBerG5zPPFX2emGoqa+n/jOHD+DF0gO
 JIzDP6vg9220sD0FNiTZtum6OKM73kfYh3M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3304jq05tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Aug 2020 18:28:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 17 Aug 2020 18:28:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr6o6U6L6Fp3MhYsx13jHXGmXMJxhK7HUVgYbfrgL7ZLvNq4VK9uwsNxp8qCB7Mk66JjKR0TCTzVb95Sr743LekaCmhFhew7YmTeiXGxb3qWQau0i348VTNyNoLhT28eCEUCP71KOXX0aKiNJaFwsdBjlB0MjcZLBj6CNwgck9zXGox6odbwlrvwExEUKu0PhrwbjQ47L8+NRqmO3M7Akq9hDvhRabiiN1tk98wK58e7BF4+OcX4N6PQh2aDuhr15FyJ8LgcuZkuK1jaUj/EKxQxQEPAQgcac1HOzME+kP1QGuyQnQKFw7HzyUgfb3JakjK0RGDVAcGJosrIJNGYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5JO0Ck19xyHdhZoxllY4gv5oQnWExvznN6WPjQujF8=;
 b=mb4xn29EBDdOSpjgjq+rf7dfzUdwJFFakCZhbu0DsqCe211cFuf55FoUv930v7YUsFZkUXIqoyuAHInMsiamdKXaRUVMB1m6wq5v2RJ50+qH3J2UBS7mBEpBer7Ozcan2QSpryIJ9FYykm4/6QF5MTYS11TkoUi+VVfacxdzME7amZN6bLDXF/845YRu2hI2NE41TAGTgFHkj5o9n7QxMDTf0yI+uDZ8rh8xzX3UZjUfnNGhN5fN/y3CnB5ZbshOHu7XC/X5cQlJQv2sZ6eU2IJmtVBltKDezMF9L0jt4j2FFfv2LdWZd70jtdB/d6dpYN+RNWLIb6T3ujTyDQr++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5JO0Ck19xyHdhZoxllY4gv5oQnWExvznN6WPjQujF8=;
 b=XKLdO8gIA/CWGSnpraNwxBFVdXFiySKeuW4uSBGd2v5H/cX2x1Klphhm5QcjYbBGv+y6kO0eTpgm/++YCS07vaTtr7TcSFBe2ChZQDwT58DiQhHXS5BrdwzqiAIx2AIS7yyx95NCiUzwlkriWrT077LhY5oqIrYhlMuwz/W13uA=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2646.namprd15.prod.outlook.com (2603:10b6:a03:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.24; Tue, 18 Aug
 2020 01:28:03 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Tue, 18 Aug 2020
 01:28:03 +0000
Date:   Mon, 17 Aug 2020 18:27:58 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v8 5/7] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200818012758.4666zlknkr4x6cbl@kafai-mbp.dhcp.thefacebook.com>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-6-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803164655.1924498-6-kpsingh@chromium.org>
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:4b70) by BY3PR10CA0009.namprd10.prod.outlook.com (2603:10b6:a03:255::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Tue, 18 Aug 2020 01:28:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:4b70]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52f9ed0b-945f-47cd-29b5-08d84315f344
X-MS-TrafficTypeDiagnostic: BYAPR15MB2646:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26463D6F07BB026C6DACAB47D55C0@BYAPR15MB2646.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRgaCtXkWAxavpnS9gJg69iv7nq9YpWfoqHNsZGoRZ84qBX6FLDFdavh5iVjJb0RoXX9E35zModCugcKq3eWD6weEH3b3pnL2lCdS1Xg3A2LzSrACM/9LgC1UiqtTst6dNWdKqPaYPo6iWmzIV1ro1ADO+eVTqz3xdTfRyWORjHdbPz6r2yN/wgsbtYDmFinHUcGI4u1hY71z7njPPqsVw3GL48IzZLeVF5sOHGndDebQDlLrFytbX+uoS6yoYifmPSPlC6vjsAw825mw+nbmEFHxH5RIHpgQRXV9tFuw1EaQPzr1XEBq1KxFvZ3l+QmgkkYTrLmPjwvCeAbjoy1mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(366004)(346002)(316002)(6506007)(52116002)(7696005)(4326008)(2906002)(6916009)(478600001)(54906003)(55016002)(9686003)(1076003)(83380400001)(16526019)(186003)(66476007)(86362001)(66556008)(66946007)(8676002)(5660300002)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: x3EcnWdJx9df0W22DK5Gz7eJ3G7HMpIqyseBr7lkEPyxgcF0fsxe16GPYk3+3Y6PbU0+1SCrWp15MCsLmiizI51aWg4FvAcOAdgc2Z1eBpDJ8vbJqCNGiGLDhSkWT5Ws1Vqx3po2v2kcOxFfIp2qiv5TXVqocJ3Z6eWXaAT0v9mmFE2LsdInAUTTQnLWP1yhvES/zAE3dfhtvQfYYCBgRfsGV3XdE1AxQujxKAjkCvTDQ8IX/mkXrwjVV27KzyBDqzyTGQXagjcm1UFTdRFQtOrHl3vyoC/g+xa28TY0m0djkv+boETpbqNUDyFke5XviXFKhUwEvzOcb0yA+3APA7pmH8KrU0FlGNz+3hC/pjrHCR+QQ61sahVnyDn5AHI5DVgW+rZYX6nAE3VzWmDknA6Z6MjWggYU1HyloWqL7M8nsoJ1s0jIHQ2Z7GX3P0wpaoo9VchwwwairC8R5z3sS8euCf4QrAImVa1NQ3Zo9T9xrTJxNbooqqileDgn9TGXuqZChfXYDlZFN6nS/CrFtnf6E5VZ+rXyCaBKWPSOr7Fs40OoXJ48iqoWbUXsUw5wrQgi/+6B9TTy5YW39GHMcfYoYcK6dC25eIB2M1ktJ2Z7RyzaavCcuVsobjWtue70RSnSAD/OsHjmMULkSmtHpB8DMq5XGlVB6mL4fJVCLfA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f9ed0b-945f-47cd-29b5-08d84315f344
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 01:28:02.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp2N61bsZ78gsyAQPffWk0s0FhZr6VmO3sRcWfLBHd4plFBT32G7sjT1pY2vf55L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 suspectscore=5 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180009
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 03, 2020 at 06:46:53PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Similar to bpf_local_storage for sockets, add local storage for inodes.
> The life-cycle of storage is managed with the life-cycle of the inode.
> i.e. the storage is destroyed along with the owning inode.
> 
> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> security blob which are now stackable and can co-exist with other LSMs.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/linux/bpf_local_storage.h             |  10 +
>  include/linux/bpf_lsm.h                       |  21 ++
>  include/linux/bpf_types.h                     |   3 +
>  include/uapi/linux/bpf.h                      |  38 +++
>  kernel/bpf/Makefile                           |   1 +
>  kernel/bpf/bpf_inode_storage.c                | 265 ++++++++++++++++++
>  kernel/bpf/syscall.c                          |   3 +-
>  kernel/bpf/verifier.c                         |  10 +
>  security/bpf/hooks.c                          |   7 +
>  .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
>  tools/bpf/bpftool/map.c                       |   3 +-
>  tools/include/uapi/linux/bpf.h                |  38 +++
>  tools/lib/bpf/libbpf_probes.c                 |   5 +-
>  14 files changed, 403 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/bpf/bpf_inode_storage.c
> 
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 3685f681a7fc..75c76847fad5 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -160,4 +160,14 @@ struct bpf_local_storage_data *
>  bpf_local_storage_update(void *owner, struct bpf_map *map, void *value,
>  			 u64 map_flags);
>  
> +#ifdef CONFIG_BPF_LSM
> +extern const struct bpf_func_proto bpf_inode_storage_get_proto;
> +extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
> +void bpf_inode_storage_free(struct inode *inode);
> +#else
> +static inline void bpf_inode_storage_free(struct inode *inode)
> +{
> +}
> +#endif /* CONFIG_BPF_LSM */
This is LSM specific.  Can they be moved to bpf_lsm.h?

> +
>  #endif /* _BPF_LOCAL_STORAGE_H */
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index af74712af585..d0683ada1e49 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -17,9 +17,24 @@
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>  
> +struct bpf_storage_blob {
> +	struct bpf_local_storage __rcu *storage;
> +};
> +
> +extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
> +
>  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  			const struct bpf_prog *prog);
>  
> +static inline struct bpf_storage_blob *bpf_inode(
> +	const struct inode *inode)
> +{
> +	if (unlikely(!inode->i_security))
> +		return NULL;
> +
> +	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
> +}
> +
>  #else /* !CONFIG_BPF_LSM */
>  
>  static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> @@ -28,6 +43,12 @@ static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline struct bpf_storage_blob *bpf_inode(
> +	const struct inode *inode)
> +{
> +	return NULL;
> +}
> +
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */

[ ... ]

> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> new file mode 100644
> index 000000000000..a51a6328c02d
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
> +	bsb = bpf_inode(inode);
> +	if (!bsb)
> +		return NULL;
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
> +		return ERR_PTR(-ENOENT);
ERR_PTR is returned here...

> +
> +	inode_storage = rcu_dereference(bsb->storage);
> +	if (!inode_storage)
> +		return NULL;
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	return bpf_local_storage_lookup(inode_storage, smap, cacheit_lockit);
> +}
> +
> +void bpf_inode_storage_free(struct inode *inode)
> +{
> +	struct bpf_local_storage_elem *selem;
> +	struct bpf_local_storage *local_storage;
> +	bool free_inode_storage = false;
> +	struct bpf_storage_blob *bsb;
> +	struct hlist_node *n;
> +
> +	bsb = bpf_inode(inode);
> +	if (!bsb)
> +		return;
> +
> +	rcu_read_lock();
> +
> +	local_storage = rcu_dereference(bsb->storage);
> +	if (!local_storage) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	/* Netiher the bpf_prog nor the bpf-map's syscall
> +	 * could be modifying the local_storage->list now.
> +	 * Thus, no elem can be added-to or deleted-from the
> +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> +	 *
> +	 * It is racing with bpf_local_storage_map_free() alone
> +	 * when unlinking elem from the local_storage->list and
> +	 * the map's bucket->list.
> +	 */
> +	raw_spin_lock_bh(&local_storage->lock);
> +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> +		/* Always unlink from map before unlinking from
> +		 * local_storage.
> +		 */
> +		bpf_selem_unlink_map(selem);
> +		free_inode_storage =
> +			bpf_selem_unlink_storage(local_storage, selem, false);
> +	}
> +	raw_spin_unlock_bh(&local_storage->lock);
> +	rcu_read_unlock();
> +
> +	/* free_inoode_storage should always be true as long as
> +	 * local_storage->list was non-empty.
> +	 */
> +	if (free_inode_storage)
> +		kfree_rcu(local_storage, rcu);
> +}
> +
> +
> +static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct file *f;
> +	int fd;
> +
> +	fd = *(int *)key;
> +	f = fcheck(fd);
> +	if (!f)
> +		return ERR_PTR(-EINVAL);
> +
> +	get_file(f);
> +	sdata = inode_storage_lookup(f->f_inode, map, true);
> +	fput(f);
> +	return sdata ? sdata->data : NULL;
sdata can be ERR_PTR here and a few other cases below.

May be inode_storage_lookup() should just return NULL.

> +}
> +
> +static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
> +					 void *value, u64 map_flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct file *f;
> +	int fd;
> +
> +	fd = *(int *)key;
> +	f = fcheck(fd);
> +	if (!f)
> +		return -EINVAL;
> +
> +	get_file(f);
get_file() does atomic_long_inc() instead of atomic_long_inc_not_zero().
I don't see how that helps here.  Am I missing something?

> +	sdata = bpf_local_storage_update(f->f_inode, map, value, map_flags);
> +	fput(f);
> +	return PTR_ERR_OR_ZERO(sdata);
> +}
> +
