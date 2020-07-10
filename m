Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8644521AFD0
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 08:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgGJG7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 02:59:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbgGJG7t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 02:59:49 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06A6xQi1015574;
        Thu, 9 Jul 2020 23:59:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=J5jg16NjEbSARFlGNj8wo3QNScAICPQgKgFYq2afaGc=;
 b=icdzPbi5pKqr0+86uEf9UZJW7VKmpDXC+dPDo5lX85hBs6pi51WChyX/soueyzCuilIg
 YBEuJTiabYubZZThN9xmVPsL1gkIh/vV5pGZ/kJMdOKhZU9zFbiEkyu17YQs3cdurRjd
 YFMya0RabY28k8teB7Soyo/15wc3y6kF73k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 325k1s0nyw-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Jul 2020 23:59:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 23:59:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig+dNaVJPvaffoFJKmhSex9L8zBGts9tomGp5N1s4n3F87vDouGM8qbyMc/1HOZ1lXZPkg3zJO4S94xJTYtKcSul46eT3O2fscfysH/uLMEJCchy6A/o+VVYL2lxWL40bCqfyUQjpr6h+sTsDET4EHJQVgNYnrvjYI+KUZXCndqomhUsAIAO45/7+iHl/M9un6rihgj2qqItPgrMmQW3eRT6ROdW/4XLQGQyFW/7il9UqWYK7eD29Rbf53G6JzkXL2+6T2FnDchNOgKOiHS877FfkEmpAmwxUHc4CwH0GILTT4VdBoTQb47gnPC6ugCj8hiGXMzh3f7zHny0krABYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5jg16NjEbSARFlGNj8wo3QNScAICPQgKgFYq2afaGc=;
 b=IQEHhMsjq9b2q7VzVEMuNvu286aMau+YFsAyT1tJ45Kxv7vymg8hSbfvbxG9qupaO+mDSmOTeO5XXd6lDSYUKbi5GLVxGyPts/NrJY+0mZLO9meSC6RHtRzwF4+EZ0+vFWQJJnnD9wWML7BTewwHV8IkmYBHy1sjtfi2dazJUN97y76fS7AHeMbiGzE8mMgkpG2kNRtQfbQJ1pSYL016LY90gt3eocAFeffSH9HPa3JkSIbucKi+t+KOP7P93B9sCbJ33SJEUGidbzVBDoGpEATXz7SopYYl1azbtjiigcdY1dqbpzS+IgOtKC0IJ97dHDNzpqu31cA3Z26VieHpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5jg16NjEbSARFlGNj8wo3QNScAICPQgKgFYq2afaGc=;
 b=PLLHP0SkLBuYBQdbqZWqJaCBm3O5bwN+uOAS+68muW1HKws2pXUYOJG0tHN2vvwObrzv4YTYWvz23OVM7BTG3wm4ovWTtGOcgl0LJ8dLs7naVABEx8MomtGYGABm1TtmMxsucg+BT3Ly1HPDB+mace1EA1CoT+XFn3sYB1gVIC0=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3000.namprd15.prod.outlook.com (2603:10b6:a03:b1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 06:59:19 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 06:59:19 +0000
Date:   Thu, 9 Jul 2020 23:59:17 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Generalize bpf_sk_storage
Message-ID: <20200710065917.4333wchwofpl7m2s@kafai-mbp>
References: <20200709101239.3829793-1-kpsingh@chromium.org>
 <20200709101239.3829793-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709101239.3829793-2-kpsingh@chromium.org>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:31b2) by BYAPR11CA0075.namprd11.prod.outlook.com (2603:10b6:a03:f4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 06:59:18 +0000
X-Originating-IP: [2620:10d:c090:400::5:31b2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8698a75b-7965-420b-64a5-08d8249ec406
X-MS-TrafficTypeDiagnostic: BYAPR15MB3000:
X-Microsoft-Antispam-PRVS: <BYAPR15MB300012F4B8B549A5EACD6B0CD5650@BYAPR15MB3000.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK2X7dfVlV3d5wjZluuV4aBqUEEdMpXiTe3asBTrYx2ArRYKQuFw7f8qhQGc18hoNPILZNqgkkTWCLeFvbkMPSTzLFyVYXNntWmNTmn8GnpvWlYpayrP0KMhG2n+oWKadlxSFfGdc2gnoNN4yaTspJcVof1hsoJY85zRd38EkevJQG5gG7lya/LJwi48XNO40orRj+tbWzVsMlyoFNlu+e5RUw2rj2vf7+9dkqGC1xHjebm6kjEyL3Od01nk+0bfrgyjqveeJTWzZJbDXHgcJOd5NjJXv+KStM/ZKvJg9nQfJ2IracqDdxSn5SJz19wkwRxd8jF3uehOUayEeL5PzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(6916009)(8936002)(186003)(9686003)(316002)(16526019)(2906002)(55016002)(6496006)(66476007)(478600001)(52116002)(86362001)(66556008)(4326008)(66946007)(33716001)(83380400001)(5660300002)(30864003)(1076003)(54906003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UO2M+5v+jzdgj6lo0fpv6FK/QVuAFyt+HGgH0I9ZkblIK80bXUFML0P5D+ZOC4T60uXZ7WtbyaBgR/CiqEuw0LWlA0k1QE7Ow7j1HKqK1F0bVptrnZHJ4rOTcdeme4Zug+WxIu0/WI+LA9H/GpI8Unpq6GFpLcu1J9lJqX6AJ/9KJ/r0Liz3rbS8nkY2lhQoEjmOEQPFTCCY924wEWtyrImHCFOjFwp+yTDQ3jwTV88B5p7J76BRv/qTlTCLTsOLnNXjVU75cn+dp+e/ZLhg8NMooVwtvYWQ3RkNkwbEUN6zeFhlHOUe2/RCqU9t1n0r5x7/w4e97X0hFd42u3NJO5pOZotH4AWm0xbirNMdZSuZQN2LCdyw3AEz9NXBA4Yn4+nEc/Mkg7wjoW0WoVNAK+FUQGAi9sXSuYdxd9nfD+FJyYH4eZ6oepjfMBsHjQjYwvBWCKeKhzOvBVsVN7YW9xHUYELgir2fx0yYUiOvMpEUxA5kV62oMTneVgbBSAVrU9q4bS42bUk/C/0Qdt/Itw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8698a75b-7965-420b-64a5-08d8249ec406
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 06:59:18.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tku1ZRMox3UsHtFKFvMfq5bq3CNPtTpxQGh7R/a8hGYXuYM1nl/Jztl3iaoRPqbG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3000
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_02:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 priorityscore=1501 suspectscore=2
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 09, 2020 at 12:12:36PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Refactor the functionality in bpf_sk_storage.c so that concept of
> storage linked to kernel objects can be extended to other objects like
> inode, task_struct etc.
> 
> bpf_sk_storage is updated to be bpf_local_storage with a union that
> contains a pointer to the owner object.

> The type of the
> bpf_local_storage can be determined using the newly added
> bpf_local_storage_type enum.
This is out dated.

> 
> Each new local storage will still be a separate map and provide its own
> set of helpers. This allows for future object specific extensions and
> still share a lot of the underlying implementation.
Thanks for v4.

I do find it quite hard to follow by directly moving to
bpf_local_storage.c without doing all the renaming locally
at bpf_sk_storage.c first.  I will try my best to follow.

There are some unnecessary name/convention change and function
folding that do not help on this side either.  Please keep them
unchanged for now and they can use another patch in the future if needed.
It will be easier to have a mostly one to one naming change
and please mention them in the commit message.

[ ... ]

> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> new file mode 100644
> index 000000000000..605b81f2f806
> --- /dev/null
> +++ b/include/linux/bpf_local_storage.h
> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 Facebook
> + * Copyright 2020 Google LLC.
> + */
> +
> +#ifndef _BPF_LOCAL_STORAGE_H
> +#define _BPF_LOCAL_STORAGE_H
> +
> +#include <linux/bpf.h>
> +#include <linux/rculist.h>
> +#include <linux/list.h>
> +#include <linux/hash.h>
> +#include <linux/types.h>
> +#include <uapi/linux/btf.h>
> +
> +#define LOCAL_STORAGE_CREATE_FLAG_MASK					\
> +	(BPF_F_NO_PREALLOC | BPF_F_CLONE)
> +
> +struct bucket {
Since it is in a .h, it can use a more specific name.
May be bpf_local_storage_map_bucket.

> +	struct hlist_head list;
> +	raw_spinlock_t lock;
> +};
> +

[ ... ]

> +struct bpf_local_storage {
> +	struct bpf_local_storage_data __rcu *cache[BPF_STORAGE_CACHE_SIZE];
> +	struct hlist_head list;		/* List of bpf_local_storage_elem */
> +	/* The object that owns the the above "list" of
> +	 * bpf_local_storage_elem
> +	 */
> +	union {
> +		struct sock *sk;
Instead of having a specific pointer type and then union them here,
would one "void *owner;" work as good?

> +	};
> +	struct rcu_head rcu;
> +	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
> +};
> +
> +/* Helper functions for bpf_local_storage */

[ ... ]

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> new file mode 100644
> index 000000000000..c818eb6f8261
> --- /dev/null
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -0,0 +1,517 @@
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
> +
> +#define SELEM(_SDATA)                                                          \
> +	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
> +#define SDATA(_SELEM) (&(_SELEM)->sdata)
> +
> +static struct bucket *select_bucket(struct bpf_local_storage_map *smap,
> +				    struct bpf_local_storage_elem *selem)
> +{
> +	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
> +}
> +
> +static bool selem_linked_to_node(const struct bpf_local_storage_elem *selem)
The suffix was selem_linked_to"_sk" and it is changed to "_node" here.
However, the latter bpf_selem_unlink has removed the _sk suffix instead.

Instead of _to_node, it is linked to storage.  How about
selem_linked_to_storage()?

> +{
> +	return !hlist_unhashed(&selem->snode);
> +}
> +
> +static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
> +{
> +	return !hlist_unhashed(&selem->map_node);
> +}
> +
> +struct bpf_local_storage_elem *
> +bpf_selem_alloc(struct bpf_local_storage_map *smap, void *value)
> +{
> +	struct bpf_local_storage_elem *selem;
> +
> +	selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
> +	if (selem) {
> +		if (value)
> +			memcpy(SDATA(selem)->data, value, smap->map.value_size);
> +		return selem;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* local_storage->lock must be held and selem->local_storage == local_storage.
> + * The caller must ensure selem->smap is still valid to be
> + * dereferenced for its smap->elem_size and smap->cache_idx.
> + *
> + * uncharge_omem is only relevant for BPF_MAP_TYPE_SK_STORAGE.
> + */
> +bool bpf_selem_unlink(struct bpf_local_storage *local_storage,
> +		      struct bpf_local_storage_elem *selem, bool uncharge_omem)
It is originated from __selem_unlink_sk() which does not take the
local_storage->lock.

How about keeping the _sk suffix here somehow to distinguish it from
unlink_map?
was __selem_unlink_sk => bpf_selem_unlink_storage()?

> +{
> +	struct bpf_local_storage_map *smap;
> +	bool free_local_storage;
> +
> +	smap = rcu_dereference(SDATA(selem)->smap);
> +	free_local_storage = hlist_is_singular_node(&selem->snode,
> +						    &local_storage->list);
> +
> +	/* local_storage is not freed now.  local_storage->lock is
> +	 * still held and raw_spin_unlock_bh(&local_storage->lock)
> +	 * will be done by the caller.
> +	 * Although the unlock will be done under
> +	 * rcu_read_lock(),  it is more intutivie to
> +	 * read if kfree_rcu(local_storage, rcu) is done
> +	 * after the raw_spin_unlock_bh(&local_storage->lock).
> +	 *
> +	 * Hence, a "bool free_local_storage" is returned
> +	 * to the caller which then calls the kfree_rcu()
> +	 * after unlock.
> +	 */
> +	if (free_local_storage)
> +		smap->map.ops->map_local_storage_unlink(local_storage,
> +							uncharge_omem);
> +
> +	hlist_del_init_rcu(&selem->snode);
> +	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
> +	    SDATA(selem))
> +		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> +
> +	kfree_rcu(selem, rcu);
> +
> +	return free_local_storage;
> +}
> +
> +void bpf_selem_link(struct bpf_local_storage *local_storage,
> +		    struct bpf_local_storage_elem *selem)
was __selem_link_sk() => bpf_selem_link_storage()

> +{
> +	RCU_INIT_POINTER(selem->local_storage, local_storage);
> +	hlist_add_head(&selem->snode, &local_storage->list);
> +}
> +
> +void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
> +{
> +	struct bpf_local_storage_map *smap;
> +	struct bucket *b;
> +
> +	if (unlikely(!selem_linked_to_map(selem)))
> +		/* selem has already be unlinked from smap */
> +		return;
> +
> +	smap = rcu_dereference(SDATA(selem)->smap);
> +	b = select_bucket(smap, selem);
> +	raw_spin_lock_bh(&b->lock);
> +	if (likely(selem_linked_to_map(selem)))
> +		hlist_del_init_rcu(&selem->map_node);
> +	raw_spin_unlock_bh(&b->lock);
> +}
> +
> +void bpf_selem_link_map(struct bpf_local_storage_map *smap,
> +			struct bpf_local_storage_elem *selem)
> +{
> +	struct bucket *b = select_bucket(smap, selem);
> +
> +	raw_spin_lock_bh(&b->lock);
> +	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
> +	hlist_add_head_rcu(&selem->map_node, &b->list);
> +	raw_spin_unlock_bh(&b->lock);
> +}
> +
> +void bpf_selem_unlink_map_elem(struct bpf_local_storage_elem *selem)
How about keep the original no-suffix to mean unlink from both map and storage.
was selem_unlink() => bpf_selem_unlink()

> +{
> +	struct bpf_local_storage *local_storage;
> +	bool free_local_storage = false;
> +
> +	/* Always unlink from map before unlinking from local_storage
> +	 * because selem will be freed after successfully unlinked from
> +	 * the local_storage.
> +	 */
> +	bpf_selem_unlink_map(selem);
> +
> +	if (unlikely(!selem_linked_to_node(selem)))
> +		/* selem has already been unlinked from its owner */
> +		return;
> +
> +	local_storage = rcu_dereference(selem->local_storage);
> +	raw_spin_lock_bh(&local_storage->lock);
> +	if (likely(selem_linked_to_node(selem)))
> +		free_local_storage =
> +			bpf_selem_unlink(local_storage, selem, true);
> +	raw_spin_unlock_bh(&local_storage->lock);
> +
> +	if (free_local_storage)
> +		kfree_rcu(local_storage, rcu);
Part of these is folding the selem_unlink_sk() into here.
Please don't do it for now.
Keep them in __bpf_selem_unlink_storage().  Hence, we only
need to remember the original "__" meaning is flipped
from unlock to lock.

> +}
> +

[ ... ]

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 6f921c4ddc2c..a2b00a09d843 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c

[ ... ]

> +static void unlink_sk_storage(struct bpf_local_storage *local_storage,
>  			      bool uncharge_omem)
>  {
> -	struct bpf_sk_storage_map *smap;
> -	bool free_sk_storage;
> -	struct sock *sk;
> -
> -	smap = rcu_dereference(SDATA(selem)->smap);
> -	sk = sk_storage->sk;
> +	struct sock *sk = local_storage->sk;
>  
> -	/* All uncharging on sk->sk_omem_alloc must be done first.
> -	 * sk may be freed once the last selem is unlinked from sk_storage.
> -	 */
>  	if (uncharge_omem)
> -		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
Where is smap->elem_size uncharged?

> -
> -	free_sk_storage = hlist_is_singular_node(&selem->snode,
> -						 &sk_storage->list);
> -	if (free_sk_storage) {
> -		atomic_sub(sizeof(struct bpf_sk_storage), &sk->sk_omem_alloc);
> -		sk_storage->sk = NULL;
> -		/* After this RCU_INIT, sk may be freed and cannot be used */
> -		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
> -
> -		/* sk_storage is not freed now.  sk_storage->lock is
> -		 * still held and raw_spin_unlock_bh(&sk_storage->lock)
> -		 * will be done by the caller.
> -		 *
> -		 * Although the unlock will be done under
> -		 * rcu_read_lock(),  it is more intutivie to
> -		 * read if kfree_rcu(sk_storage, rcu) is done
> -		 * after the raw_spin_unlock_bh(&sk_storage->lock).
> -		 *
> -		 * Hence, a "bool free_sk_storage" is returned
> -		 * to the caller which then calls the kfree_rcu()
> -		 * after unlock.
> -		 */
> -	}
> -	hlist_del_init_rcu(&selem->snode);
> -	if (rcu_access_pointer(sk_storage->cache[smap->cache_idx]) ==
> -	    SDATA(selem))
> -		RCU_INIT_POINTER(sk_storage->cache[smap->cache_idx], NULL);
> -
> -	kfree_rcu(selem, rcu);
> -
> -	return free_sk_storage;
> -}

[ ... ]

> +static struct bpf_local_storage_data *
> +sk_storage_update(void *owner, struct bpf_map *map, void *value, u64 map_flags)
>  {
> -	struct bpf_sk_storage_data *old_sdata = NULL;
> -	struct bpf_sk_storage_elem *selem;
> -	struct bpf_sk_storage *sk_storage;
> -	struct bpf_sk_storage_map *smap;
> +	struct bpf_local_storage_data *old_sdata = NULL;
> +	struct bpf_local_storage_elem *selem;
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_map *smap;
> +	struct sock *sk;
>  	int err;
>  
> -	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
> -	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> -	    /* BPF_F_LOCK can only be used in a value with spin_lock */
> -	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
> -		return ERR_PTR(-EINVAL);
> +	err = bpf_local_storage_check_update_flags(map, map_flags);
> +	if (err)
> +		return ERR_PTR(err);
>  
> -	smap = (struct bpf_sk_storage_map *)map;
> -	sk_storage = rcu_dereference(sk->sk_bpf_storage);
> -	if (!sk_storage || hlist_empty(&sk_storage->list)) {
> -		/* Very first elem for this sk */
> -		err = check_flags(NULL, map_flags);
> -		if (err)
> -			return ERR_PTR(err);
> +	sk = owner;
> +	local_storage = rcu_dereference(sk->sk_bpf_storage);
> +	smap = (struct bpf_local_storage_map *)map;
>  
> -		selem = selem_alloc(smap, sk, value, true);
> +	if (!local_storage || hlist_empty(&local_storage->list)) {
> +		/* Very first elem */
> +		selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
hmmm... If this map_selem_alloc is directly called here in sk_storage instead
of the common local_storage, does it have to be in map_ops?

>  		if (!selem)
>  			return ERR_PTR(-ENOMEM);
>  
> -		err = sk_storage_alloc(sk, smap, selem);
> +		err = map->ops->map_local_storage_alloc(owner, smap, selem);
>  		if (err) {
>  			kfree(selem);
>  			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);

[ ... ]

> -static void bpf_sk_storage_map_free(struct bpf_map *map)
> +static void *bpf_sk_storage_lookup_elem(struct bpf_map *map, void *key)
Hmmm... this change here... keep scrolling down and down .... :)

>  {
> -	struct bpf_sk_storage_elem *selem;
> -	struct bpf_sk_storage_map *smap;
> -	struct bucket *b;
> -	unsigned int i;
> -
> -	smap = (struct bpf_sk_storage_map *)map;
> -
> -	cache_idx_free(smap->cache_idx);
> -
> -	/* Note that this map might be concurrently cloned from
> -	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
> -	 * RCU read section to finish before proceeding. New RCU
> -	 * read sections should be prevented via bpf_map_inc_not_zero.
> -	 */
> -	synchronize_rcu();
> -
> -	/* bpf prog and the userspace can no longer access this map
> -	 * now.  No new selem (of this map) can be added
> -	 * to the sk->sk_bpf_storage or to the map bucket's list.
> -	 *
> -	 * The elem of this map can be cleaned up here
> -	 * or
> -	 * by bpf_sk_storage_free() during __sk_destruct().
> -	 */
> -	for (i = 0; i < (1U << smap->bucket_log); i++) {
> -		b = &smap->buckets[i];
> -
> -		rcu_read_lock();
> -		/* No one is adding to b->list now */
> -		while ((selem = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&b->list)),
> -						 struct bpf_sk_storage_elem,
> -						 map_node))) {
> -			selem_unlink(selem);
> -			cond_resched_rcu();
> -		}
> -		rcu_read_unlock();
> -	}
> -
> -	/* bpf_sk_storage_free() may still need to access the map.
> -	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
> -	 * which then made the above while((selem = ...)) loop
> -	 * exited immediately.
> -	 *
> -	 * However, the bpf_sk_storage_free() still needs to access
> -	 * the smap->elem_size to do the uncharging in
> -	 * __selem_unlink_sk().
> -	 *
> -	 * Hence, wait another rcu grace period for the
> -	 * bpf_sk_storage_free() to finish.
> -	 */
> -	synchronize_rcu();
> -
> -	kvfree(smap->buckets);
> -	kfree(map);
> -}
> -
> -/* U16_MAX is much more than enough for sk local storage
> - * considering a tcp_sock is ~2k.
> - */
> -#define MAX_VALUE_SIZE							\
> -	min_t(u32,							\
> -	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK - sizeof(struct bpf_sk_storage_elem)), \
> -	      (U16_MAX - sizeof(struct bpf_sk_storage_elem)))
> -
> -static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
> -{
> -	if (attr->map_flags & ~SK_STORAGE_CREATE_FLAG_MASK ||
> -	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
> -	    attr->max_entries ||
> -	    attr->key_size != sizeof(int) || !attr->value_size ||
> -	    /* Enforce BTF for userspace sk dumping */
> -	    !attr->btf_key_type_id || !attr->btf_value_type_id)
> -		return -EINVAL;
> -
> -	if (!bpf_capable())
> -		return -EPERM;
> -
> -	if (attr->value_size > MAX_VALUE_SIZE)
> -		return -E2BIG;
> -
> -	return 0;
> -}
> -
> -static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
> -{
> -	struct bpf_sk_storage_map *smap;
> -	unsigned int i;
> -	u32 nbuckets;
> -	u64 cost;
> -	int ret;
> -
> -	smap = kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
> -	if (!smap)
> -		return ERR_PTR(-ENOMEM);
> -	bpf_map_init_from_attr(&smap->map, attr);
> -
> -	nbuckets = roundup_pow_of_two(num_possible_cpus());
> -	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
> -	nbuckets = max_t(u32, 2, nbuckets);
> -	smap->bucket_log = ilog2(nbuckets);
> -	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
> -
> -	ret = bpf_map_charge_init(&smap->map.memory, cost);
> -	if (ret < 0) {
> -		kfree(smap);
> -		return ERR_PTR(ret);
> -	}
> -
> -	smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
> -				 GFP_USER | __GFP_NOWARN);
> -	if (!smap->buckets) {
> -		bpf_map_charge_finish(&smap->map.memory);
> -		kfree(smap);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	for (i = 0; i < nbuckets; i++) {
> -		INIT_HLIST_HEAD(&smap->buckets[i].list);
> -		raw_spin_lock_init(&smap->buckets[i].lock);
> -	}
> -
> -	smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
> -	smap->cache_idx = cache_idx_get();
> -
> -	return &smap->map;
> -}
> -
> -static int notsupp_get_next_key(struct bpf_map *map, void *key,
> -				void *next_key)
> -{
> -	return -ENOTSUPP;
> -}
> -
> -static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
> -					const struct btf *btf,
> -					const struct btf_type *key_type,
> -					const struct btf_type *value_type)
> -{
> -	u32 int_data;
> -
> -	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
> -		return -EINVAL;
> -
> -	int_data = *(u32 *)(key_type + 1);
> -	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
.... finally got it :p

> -{
> -	struct bpf_sk_storage_data *sdata;
> +	struct bpf_local_storage_data *sdata;
>  	struct socket *sock;
> -	int fd, err;
> +	int fd, err = -EINVAL;
This is a bug fix or to suppress compiler warning?

>  
>  	fd = *(int *)key;
>  	sock = sockfd_lookup(fd, &err);
> @@ -752,17 +223,18 @@ static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
>  	return ERR_PTR(err);
>  }
>  

[ ... ]

>  static int sk_storage_map_btf_id;
>  const struct bpf_map_ops sk_storage_map_ops = {
> -	.map_alloc_check = bpf_sk_storage_map_alloc_check,
> -	.map_alloc = bpf_sk_storage_map_alloc,
> -	.map_free = bpf_sk_storage_map_free,
> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> +	.map_alloc = sk_storage_map_alloc,
> +	.map_free = sk_storage_map_free,
>  	.map_get_next_key = notsupp_get_next_key,
> -	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
> -	.map_update_elem = bpf_fd_sk_storage_update_elem,
> -	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
Why this "_fd_" name change?

> -	.map_check_btf = bpf_sk_storage_map_check_btf,
> -	.map_btf_name = "bpf_sk_storage_map",
> +	.map_lookup_elem = bpf_sk_storage_lookup_elem,
> +	.map_update_elem = bpf_sk_storage_update_elem,
> +	.map_delete_elem = bpf_sk_storage_delete_elem,
> +	.map_check_btf = bpf_local_storage_map_check_btf,
> +	.map_btf_name = "bpf_local_storage_map",
>  	.map_btf_id = &sk_storage_map_btf_id,
> +	.map_local_storage_alloc = sk_storage_alloc,
> +	.map_selem_alloc = sk_selem_alloc,
> +	.map_local_storage_update = sk_storage_update,
> +	.map_local_storage_unlink = unlink_sk_storage,
>  };
