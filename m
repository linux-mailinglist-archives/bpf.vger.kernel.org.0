Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7AE220128
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGNXyK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jul 2020 19:54:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2680 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgGNXyJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jul 2020 19:54:09 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ENoxfR017807;
        Tue, 14 Jul 2020 16:53:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=iqVE10pHo7+USA10wuXkxjaVcBYsrrRvcIGcCTy7GYI=;
 b=GO/eKREFOZ2MIKuFOjKcKrN//19fsg1vUZo3nU3WJM+QKXGnB+nl6Zi8IMCcBTY8zSda
 1gSQtDMNiEtwPpjeLhPfE0MQMHBAoNXcA5XAesyAOp2suCKklCD+HRuPKPflvmSAZgWj
 IeobfYJW6g8ZOrepAe1gPrP9Ce4kMppNLJQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 327axn83en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jul 2020 16:53:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 16:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bcsxnfe5iTyrb1W2mmy5gELZ16vKKUXZORNBsXk4quXCowvvRhnB1QLlDrPGkPzh/Cc5b7y72w9Mo0pbw3VHhdlLazue4fpmW2Gg6w14otSZy/pgVMm7MPcD5gll1d4+sT0nGwh5fXTO0t5LMS1mnE466KxquvkW6beGA3wM3+F2FeVyf2SV+zwoi+AinV5JZXEFp+COBeoYBD5Y5eTP/gJqXdw0roQD40kuFWqLYzvxvr2jc+4X5nY4bwYa0Hq0/EbXUCkslee1m8ldPIWDvJyNunf0/ENyaER5Z6Ro7r5MBxaJ03ctbpOr2DYL/mv/kTriIYiaMAqtALktZ36RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqVE10pHo7+USA10wuXkxjaVcBYsrrRvcIGcCTy7GYI=;
 b=bzNQ0c7Q+xneozI0XduyjOMCyk1kJ7iEDNjlZTOZIj5GNz/EYPm7mHVI44H/w0Vzst38q6vJ5gEIkIMMxuVov4yoanmJ9diX8+ntk387gO1Zpdp3TH6adpJpEAf3KFlWLwtKlSQJozL2roedK3tRAyE0Y6X7A4PFiliHt2Rs2ZkmQ3EMBWojxv8Kcpetu0AX9sjNcP80YjvuVQ3LJS8FH2QTAVfQt9I4SaPj/8P4vLBTukO4u4gOSt5TGQ81vS8WW2REhF/dB9I2TwHHdjX3SYS6ICYTwhZmRTh3dTN2Y1UHT2As1tdDv1fqYwguV1MQoyjusHC3fvQDUqGRsYM5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqVE10pHo7+USA10wuXkxjaVcBYsrrRvcIGcCTy7GYI=;
 b=EuLVTD/8OzlaJtZe0t0FqIZkRBdiN0R0KaZDj5bH91f2Gtx5H2Oe3I5ua5G5pdUU/CHb0OngvlErK9a/Mjx7HlkGrdr3tE562EdlXNHqrQLmX7gWQWY4Pp5J1uPUbO2XZ8f6pRcdZt3s5Ilq/uk6ixElc1PzYMbs8BCo3GZeumM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2405.namprd15.prod.outlook.com (2603:10b6:a02:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 23:53:51 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 23:53:50 +0000
Date:   Tue, 14 Jul 2020 16:53:44 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
Message-ID: <20200714235344.jl7cqxxvy5knxbnu@kafai-mbp>
References: <cover.1594333800.git.zhuyifei@google.com>
 <6c368691a54345cfeba099b42e69c84814afdae1.1594333800.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c368691a54345cfeba099b42e69c84814afdae1.1594333800.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:dd26) by BYAPR02CA0020.namprd02.prod.outlook.com (2603:10b6:a02:ee::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 23:53:49 +0000
X-Originating-IP: [2620:10d:c090:400::5:dd26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07bd43d0-6d20-49ff-cda6-08d8285127fe
X-MS-TrafficTypeDiagnostic: BYAPR15MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB240547693B3A0F053DA69411D5610@BYAPR15MB2405.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcC2VCUvCVg7qELP+nGEHOQoJEkzybraR/Nnyxp2GpXZkROhIFv7l3O7jC7yhWtVp/XPA2ZynMQDKJgNn2BOkXM/yU561tDBSTrUjgVubmOnKMafsBVbdvPljt/zb/8d1Yfjf+DPBarbN1mXF8c4A6Wyp5gyxti3fkNGF4b+O12Xk25914W6OPxTb1/A3tb0Wr2SEkdS7N+/r40fHHkdi0dtmYUIu6eqYgpQzWGNtUr4wPhBk1RWL43IuCesV9AidX/3fM7WM5i0YEAiz6cYqUFpKzeCoPT4Qti8cHvXh/USXdIojwTG0dAskJTDovEcdjoZHDssC7ZMFUz78yx9Fem8inGm0fIDn6bYnEiqdlU/SEdE5GT5Zm70GqgF3oLvuNEpLYMAae4iRCLUNIPmFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(52116002)(478600001)(86362001)(83380400001)(1076003)(16526019)(186003)(2906002)(54906003)(33716001)(6916009)(8936002)(66556008)(8676002)(66476007)(66946007)(5660300002)(6496006)(966005)(30864003)(9686003)(55016002)(316002)(6666004)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VQ9jTvMRoC5nXLx9X+r6vu5gw2fAv6IP4ZoMy36SMDSPA0FQrW8r7szUGNDkj0jiucJucElMrsvmq7N4DG6+kTmRYUybSbzZbqbbpw0yphoMThMNVJrwoU4LNHiVXnrEQyQe5GRyqM5iBxAE+A0PplIolXqBfZEfbhhRK6fmJvp93w2pEQVVta3SjnO3ebgLKm5QxwCgAabhlCBG6ZN7Wl8kzFhtMk6MNsPMVe3OeglHzvVhCHNPFviWhChcsIy46ZVCICVGJOtwstMURRPwDiWnuXyNeGiZBvOxnMJ6O6aI91j8Veiq1yMbRGYBO+DOSyGv9+OHb89mBiw/12DmpVd2XzmZBHB9mQPl+AD7I7+rSgBtbWBtjDMiGmKiJgKSTMgZ0kcQO4jYVnxd1/wfNQEdO/IkS0OJuiVl9iY0NCt8kz5VGIv6ws2u4hiHR3sJmv2VkxLvgqJPMu20TKmNtYZKgvEmNe0R6hkg0ZrLUo9enfsWGrVPM5pQpz4CvxktkRBtgdu3poK2oZL84oyNsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bd43d0-6d20-49ff-cda6-08d8285127fe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 23:53:50.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ka7T7QPxgJkgh0guixLvB0QEenUfSJqZTtCUwp243mFniikaX24R7Tt8za8Yyr7d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_09:2020-07-14,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140167
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 09, 2020 at 05:54:49PM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> This change comes in several parts:
> 
> One, the restriction that the CGROUP_STORAGE map can only be used
> by one program is removed. This results in the removal of the field
> 'aux' in struct bpf_cgroup_storage_map, and removal of relevant
> code associated with the field, and removal of now-noop functions
> bpf_free_cgroup_storage and bpf_cgroup_storage_release.
> 
> Second, because there could be multiple attach types to the same
> cgroup, the attach type is completely ignored on comparison in
> the map key. Newly added keys have it zeroed. The only value in
> the key that still matters is the cgroup inode.
> 
> Third, because the storages are now shared, the storages cannot
> be unconditionally freed on program detach. There could be two
> ways to solve this issue:
> * A. Reference count the usage of the storages, and free when the
>      last program is detached.
> * B. Free only when the storage is impossible to be referred to
>      again, i.e. when either the cgroup_bpf it is attached to, or
>      the map itself, is freed.
> Option A has the side effect that, when the user detach and
> reattach a program, whether the program gets a fresh storage
> depends on whether there is another program attached using that
> storage. This could trigger races if the user is multi-threaded,
> and since nondeterminism in data races is evil, go with option B.
> 
> The both the map and the cgroup_bpf now tracks their associated
> storages, and the storage unlink and free are removed from
> cgroup_bpf_detach and added to cgroup_bpf_release and
> cgroup_storage_map_free. Storages are now always individually
> unlinked so the function bpf_cgroup_storages_unlink is now unused
> and removed.
> 
> Fourth, on attach, we reuse the old storage if the key already
> exists in the map. Because the rbtree traversal holds the spinlock
> of the map, during which we can't allocate a new storage if we
> don't find an old storage, instead we preallocate the storage
> unconditionally, and free the preallocated storage if we find an
> old storage in the map. This results in a change of semantics in
> bpf_cgroup_storage{,s}_link, and rename cgroup_storage_insert to
> cgroup_storage_lookup_insert that does both lookup and conditionally
> insert or free.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

[ ... ]

> @@ -101,22 +93,23 @@ static void cgroup_bpf_release(struct work_struct *work)
>  	struct cgroup *p, *cgrp = container_of(work, struct cgroup,
>  					       bpf.release_work);
>  	struct bpf_prog_array *old_array;
> +	struct list_head *storages = &cgrp->bpf.storages;
> +	struct bpf_cgroup_storage *storage, *stmp;
> +
>  	unsigned int type;
>  
>  	mutex_lock(&cgroup_mutex);
>  
>  	for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
>  		struct list_head *progs = &cgrp->bpf.progs[type];
> -		struct bpf_prog_list *pl, *tmp;
> +		struct bpf_prog_list *pl, *pltmp;
>  
> -		list_for_each_entry_safe(pl, tmp, progs, node) {
> +		list_for_each_entry_safe(pl, pltmp, progs, node) {
>  			list_del(&pl->node);
>  			if (pl->prog)
>  				bpf_prog_put(pl->prog);
>  			if (pl->link)
>  				bpf_cgroup_link_auto_detach(pl->link);
> -			bpf_cgroup_storages_unlink(pl->storage);
> -			bpf_cgroup_storages_free(pl->storage);
>  			kfree(pl);
>  			static_branch_dec(&cgroup_bpf_enabled_key);
>  		}
> @@ -126,6 +119,11 @@ static void cgroup_bpf_release(struct work_struct *work)
>  		bpf_prog_array_free(old_array);
>  	}
>  
> +	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> +		bpf_cgroup_storage_unlink(storage);
> +		bpf_cgroup_storage_free(storage);
cgroup_storage_map_free() is also doing unlink and free.
It is not clear to me what prevent cgroup_bpf_release()
and cgroup_storage_map_free() from doing unlink and free at the same time.

A few words comment here would be useful if it is fine.

> +	}
> +
>  	mutex_unlock(&cgroup_mutex);
>  
>  	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
> @@ -290,6 +288,8 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
>  	for (i = 0; i < NR; i++)
>  		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
>  
> +	INIT_LIST_HEAD(&cgrp->bpf.storages);
> +
>  	for (i = 0; i < NR; i++)
>  		if (compute_effective_progs(cgrp, i, &arrays[i]))
>  			goto cleanup;
> @@ -422,7 +422,6 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	struct list_head *progs = &cgrp->bpf.progs[type];
>  	struct bpf_prog *old_prog = NULL;
>  	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> -	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>  	struct bpf_prog_list *pl;
>  	int err;
>  
> @@ -458,10 +457,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
>  		return -ENOMEM;
>  
> +	bpf_cgroup_storages_link(storage, cgrp);
here. After the new change in bpf_cgroup_storage_link(),
the storage could be an old/existing storage that is
being used by other bpf progs.

> +
>  	if (pl) {
>  		old_prog = pl->prog;
> -		bpf_cgroup_storages_unlink(pl->storage);
> -		bpf_cgroup_storages_assign(old_storage, pl->storage);
>  	} else {
>  		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
>  		if (!pl) {
Pasting the context cut-out by git here:
>			bpf_cgroup_storages_free(storage);
It doesn't seem right to free here if the storage is "old".

>			return -ENOMEM;
>		}

> @@ -480,12 +479,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	if (err)
>  		goto cleanup;
>  
> -	bpf_cgroup_storages_free(old_storage);
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
>  	else
>  		static_branch_inc(&cgroup_bpf_enabled_key);
> -	bpf_cgroup_storages_link(pl->storage, cgrp, type);
Another side effect is, the "new" storage is still published to
the map even the attach has failed.  I think this may be ok.

>  	return 0;
>  
>  cleanup:
> @@ -493,9 +490,6 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>  		pl->prog = old_prog;
>  		pl->link = NULL;
>  	}
> -	bpf_cgroup_storages_free(pl->storage);
> -	bpf_cgroup_storages_assign(pl->storage, old_storage);
> -	bpf_cgroup_storages_link(pl->storage, cgrp, type);
>  	if (!old_prog) {
>  		list_del(&pl->node);
>  		kfree(pl);
> @@ -679,8 +673,6 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
>  
>  	/* now can actually delete it from this cgroup list */
>  	list_del(&pl->node);
> -	bpf_cgroup_storages_unlink(pl->storage);
> -	bpf_cgroup_storages_free(pl->storage);
>  	kfree(pl);
>  	if (list_empty(progs))
>  		/* last program was detached, reset flags to zero */

[ ... ]

> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 51bd5a8cb01b..3baac07bc65c 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -20,7 +20,6 @@ struct bpf_cgroup_storage_map {
>  	struct bpf_map map;
>  
>  	spinlock_t lock;
> -	struct bpf_prog_aux *aux;
>  	struct rb_root root;
>  	struct list_head list;
>  };
> @@ -38,10 +37,6 @@ static int bpf_cgroup_storage_key_cmp(
>  		return -1;
>  	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
>  		return 1;
> -	else if (key1->attach_type < key2->attach_type)
> -		return -1;
> -	else if (key1->attach_type > key2->attach_type)
> -		return 1;
>  	return 0;
>  }
>  
> @@ -81,8 +76,9 @@ static struct bpf_cgroup_storage *cgroup_storage_lookup(
>  	return NULL;
>  }
>  
> -static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
> -				 struct bpf_cgroup_storage *storage)
> +static struct bpf_cgroup_storage *
> +cgroup_storage_lookup_insert(struct bpf_cgroup_storage_map *map,
> +			     struct bpf_cgroup_storage *storage)
>  {
>  	struct rb_root *root = &map->root;
>  	struct rb_node **new = &(root->rb_node), *parent = NULL;
> @@ -101,14 +97,15 @@ static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
>  			new = &((*new)->rb_right);
>  			break;
>  		default:
> -			return -EEXIST;
> +			bpf_cgroup_storage_free(storage);
> +			return this;
>  		}
>  	}
>  
>  	rb_link_node(&storage->node, parent, new);
>  	rb_insert_color(&storage->node, root);
>  
> -	return 0;
> +	return NULL;
>  }
>  
>  static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
> @@ -131,10 +128,7 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
>  	struct bpf_cgroup_storage *storage;
>  	struct bpf_storage_buffer *new;
>  
> -	if (unlikely(flags & ~(BPF_F_LOCK | BPF_EXIST | BPF_NOEXIST)))
> -		return -EINVAL;
> -
> -	if (unlikely(flags & BPF_NOEXIST))
> +	if (unlikely(flags & ~(BPF_F_LOCK | BPF_EXIST)))
>  		return -EINVAL;
>  
>  	if (unlikely((flags & BPF_F_LOCK) &&
> @@ -250,16 +244,15 @@ static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
>  		if (!storage)
>  			goto enoent;
>  
> -		storage = list_next_entry(storage, list);
> +		storage = list_next_entry(storage, list_map);
>  		if (!storage)
>  			goto enoent;
>  	} else {
>  		storage = list_first_entry(&map->list,
> -					 struct bpf_cgroup_storage, list);
> +					 struct bpf_cgroup_storage, list_map);
>  	}
>  
>  	spin_unlock_bh(&map->lock);
> -	next->attach_type = storage->key.attach_type;
The map dump (e.g. bpftool map dump) will also show attach_type zero
in the key now.  Please also mention that in the commit message.

>  	next->cgroup_inode_id = storage->key.cgroup_inode_id;
>  	return 0;
>  
> @@ -318,6 +311,13 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  static void cgroup_storage_map_free(struct bpf_map *_map)
>  {
>  	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
> +	struct list_head *storages = &map->list;
> +	struct bpf_cgroup_storage *storage, *stmp;
> +
> +	list_for_each_entry_safe(storage, stmp, storages, list_map) {
> +		bpf_cgroup_storage_unlink(storage);
> +		bpf_cgroup_storage_free(storage);
> +	}
>  
>  	WARN_ON(!RB_EMPTY_ROOT(&map->root));
>  	WARN_ON(!list_empty(&map->list));

For the high level consideration:

In general, the idea is to allow a bpf-prog to store something locally
at a cgroup.  What to store at the cgroup is defined by the "value" of
the "bpf_cgroup_storage_map".  i.e. The map helps to define
what cgroup-storage a bpf-prog wants to store (and the map also
keeps track of what cgroups have this storage).

This patch allows a cgroup-storage to be shared among different bpf-progs
which is in the right direction that makes bpf_cgroup_storage_map behaves
more like other bpf-maps do.  However, each bpf-prog can still only allow
one "bpf_cgroup_storage_map" to be used (excluding the difference in the
SHARED/PERCPU bpf_cgroup_storage_type).
i.e. each bpf-prog can only access one type of cgroup-storage.
e.g. prog-A stores storage-A.  If prog-B wants to store storage-B and
also read storage-A, it is not possible if I read it correctly.

While I think this patch is a fine extension to the existing
bpf_cgroup_storage_map and a good step forward to make bpf_cgroup_storage_map
sharable like other bpf maps do.  Have you looked at bpf_sk_storage.c which
also defines a local storage for a sk but a bpf prog can define multiple
storages to be stored in a sk.  It is doing similar thing of this
patch (e.g. a link to the storage, another link to the map, the life
time of the storage is tied to the map and the sk...etc.).  KP Singh is
generalizing it such that bpf-prog can store data in potentially any
kernel object other than sk [1].  His use case is to store data in inode.
I think it can be used for the cgroup also.  The only thing missing there
is the "PERCPU" type.  It was not there because there is no such need for sk
but should be something quite doable.

[1]: https://patchwork.ozlabs.org/project/netdev/patch/20200709101239.3829793-2-kpsingh@chromium.org/






