Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7040D22484F
	for <lists+bpf@lfdr.de>; Sat, 18 Jul 2020 05:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGRDbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 23:31:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50806 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728129AbgGRDbL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jul 2020 23:31:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06I3TiMF010937;
        Fri, 17 Jul 2020 20:30:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4+B8+61CL4GftsyK2P+ZmJeWmsXIQTaZnV/jo4b+cTI=;
 b=Vgn241L06XpknhCu05jzhDYA4CiC2fYPKV6OaTR3b4kK0VUFr4kqMesVSMXopfMQvPrD
 pshiWA/49QzXdqiTQDjz1hF880hAcMgL+TXk4Ed9lFXvyIGfX15PESOgePLj/nBum8j3
 bQMlYwsa/1V84SIlhk6X0Ytj4YOD/YK1t4I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32bgc6t0c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 20:30:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 17 Jul 2020 20:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEwlx8fJtDLY7TLB3l97Hn2WZaEUXwQw2p3o+geuxrUqTxBWZ1MmC5jhqD7ck+QY/pqbU+agbFkQIaCoUIbvKazIXMR0WQ07icj8ecgpe8tUsepy349KOGaiE0PVVC0vTnhSzf8yD8QM7CP501Ylgpv/jfpw2TBOF1Cy4lZHj9gBGYvJeZ4OyvMoOOZXnKaOPCftuxnlIQcTfC+u2klSf/4Xux7UPZxSn1cyO4RPoXs/p/WTb4GEqYQmG4/AdYc5QiOoX/mKDCnwMwW+52a21sPI5i9B2I+W9xXacQWlKtcZmmdza/+v3o6xfLTQUe/2i2NoN9jpwpacwOSj9BHYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+B8+61CL4GftsyK2P+ZmJeWmsXIQTaZnV/jo4b+cTI=;
 b=ILRMm55Ku6HJHOy0bdpL6De00Qtbvq9DdyZubpPBx71zvHw0/C+S5oPkHD28w8eE38q7wGLI8S/QQLPedN7H2o2gEoDivUBZPUQF9brMUpekL/zMDxGpdgnzU5KADb3Zk+Gao5ZGuw8Ms1qTGT568hMCFLoW1dy/fLeSiFI3TLCxqjMZ4dQuGhtdnBEJdgmGXLTa7g0YogRnPvvYmIIVpJPqezINEcS34MukVy0O6zPhkLOQy74iSAggu146ksGvT+WAwgIMUUhiDJPCg3eM2ZIXDECRVqrRjdj2JxqZZB0SCwvrREtq59KLtJRi4jDpLLvhfLayIEjSUYlXLc2Jtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+B8+61CL4GftsyK2P+ZmJeWmsXIQTaZnV/jo4b+cTI=;
 b=JefzSyVQXXWoXy1IchltwkH0RMQKHOF9Tu94uuOp4ET6uhDOYMUXwTE6iQ/uHP/wNzkbM7m2z1yRCbvvGk34FtvNwT23JqI/lC9ejeT+NeR4KV/x+FVV8FX4hqAGtZH+gW4WDTILT+12wJ830SFYbNYlVBGJvAFth4cfvUvQVt4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2373.namprd15.prod.outlook.com (2603:10b6:a02:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Sat, 18 Jul
 2020 03:30:46 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.026; Sat, 18 Jul 2020
 03:30:46 +0000
Date:   Fri, 17 Jul 2020 20:30:44 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v3 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
Message-ID: <20200718033044.ms2ievjoseaoenwj@kafai-mbp>
References: <cover.1594944827.git.zhuyifei@google.com>
 <4321b6199e2719b49ec6e55dae4ebbfb4f7ed0be.1594944827.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4321b6199e2719b49ec6e55dae4ebbfb4f7ed0be.1594944827.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::48) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:fa48) by BYAPR06CA0071.namprd06.prod.outlook.com (2603:10b6:a03:14b::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Sat, 18 Jul 2020 03:30:45 +0000
X-Originating-IP: [2620:10d:c090:400::5:fa48]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b991746-f0f6-4c6f-2076-08d82acaf52d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2373732B8374B5B262849BDFD57D0@BYAPR15MB2373.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIN1knNTfmRD1krpgSoxamnFTYJz7mCpAY4cyHtlZkqt0rKNfOSNb0QFRCGO/+QuTbWn7y5AYU48yVYQq0mSfhzjXbn0KujHFKVaod3dDzjIBJFms2sOUemZ+DbUUZuF+C4q/egQoqJQTVmURqQqX5v4BcjSQDB+k+0TyiDaDLh6nWBPWJGaaWGdVxKuQNl3qCc4tRN5u57JAHGhmu/E2KIhoh5820h3deT66cOnPVdbwW9UEfClfMUHdDG7KxXRdplRU5bwdGWQci9Vkch9K5MLYc4LQxng5KzKEXkfo7sGlccuP4r7cXAr7pGMP2u4fXfBHd6Bz0DespUmVjI6PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(6916009)(8676002)(9686003)(8936002)(83380400001)(4326008)(6496006)(52116002)(478600001)(33716001)(2906002)(55016002)(5660300002)(30864003)(1076003)(86362001)(186003)(16526019)(316002)(66946007)(66556008)(54906003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Yn01FWnOZHVylObFxdULRM8X4f40zkOpJYUWdUjY36Ea/ghUICE45k/NsimgNPFTW5T5hrex9vQci/Ph3Dm7stowz3Lrx3MleGaI/4WC7nkkea5iX1x8GN0vxxksbuijYSNMWHtn4yDZrOCj1jlG69aENXg0HtkVofffgnEwhsB9wOl5Ssmv7Cl+7WMNrtaAUjrvRrY46d4kpi2grQKV+8WkJGuDXlbWyd7wLE4HGEYC1NrgXHtnFRovsjmRsBky1H7xxE51PeNeFt0gVsi0DTVd+ed5MZdX9IaHYakrgY0UKn+CFOiz0T1se2PG1I3fMNffKfVy90Z0Qz8N7Ob3xJBOuORqqq19XnGgNIMoW7AtHFN7ov9x7azdrD7Cv2NqKQaZTY3T/YkSnRjDcT1uMA48tBXUBchD7/8VoE3hIKpJAcKbKq8L8Qb8zPB0QB7trO5ylt+LeVENuO1jWNFgF8iEaCX9jZ5nWvnDVRLhwHwqi3QO7wPP5wXA398Z9gVcWA2XoIuP0u6qbM2d6BO98A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b991746-f0f6-4c6f-2076-08d82acaf52d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2020 03:30:46.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XREkct06PRgiGMTsWFglpzuNLkecGAoX5LBdjxgAS6ddnTPkWkXQNTRj/Q/AB8MC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2373
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_11:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=2
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007180023
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 16, 2020 at 07:16:27PM -0500, YiFei Zhu wrote:

> Fourth, on attach, we reuse the old storage if the key already
> exists in the map. Because the rbtree traversal holds the spinlock
> of the map, during which we can't allocate a new storage if we
> don't find an old storage, instead we preallocate the storage
> unconditionally, and free the preallocated storage if we find an
> old storage in the map. This results in a change of semantics in
> bpf_cgroup_storage{,s}_link, and rename cgroup_storage_insert to
> cgroup_storage_lookup_insert that does both lookup and conditionally
> insert or free. bpf_cgroup_storage{,s}_link also tracks exactly
> which storages are reused in an array of bools, so it can unlink
> and free the new storages in the event that attachment failed
> later than link. bpf_cgroup_storages_{free,unlink} accepts the
> bool array in order to facilitate that.

[ ... ]

> ---
>  include/linux/bpf-cgroup.h     | 15 +++---
>  include/uapi/linux/bpf.h       |  2 +-
>  kernel/bpf/cgroup.c            | 69 +++++++++++++++------------
>  kernel/bpf/core.c              | 12 -----
>  kernel/bpf/local_storage.c     | 85 ++++++++++++++++------------------
>  tools/include/uapi/linux/bpf.h |  2 +-
>  6 files changed, 91 insertions(+), 94 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 2c6f26670acc..c83cd8862298 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -46,7 +46,8 @@ struct bpf_cgroup_storage {
>  	};
>  	struct bpf_cgroup_storage_map *map;
>  	struct bpf_cgroup_storage_key key;
> -	struct list_head list;
> +	struct list_head list_map;
> +	struct list_head list_cg;
>  	struct rb_node node;
>  	struct rcu_head rcu;
>  };
> @@ -78,6 +79,9 @@ struct cgroup_bpf {
>  	struct list_head progs[MAX_BPF_ATTACH_TYPE];
>  	u32 flags[MAX_BPF_ATTACH_TYPE];
>  
> +	/* list of cgroup shared storages */
> +	struct list_head storages;
> +
>  	/* temp storage for effective prog array used by prog_attach/detach */
>  	struct bpf_prog_array *inactive;
>  
> @@ -164,12 +168,11 @@ static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
>  struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
>  					enum bpf_cgroup_storage_type stype);
>  void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
> -void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
> -			     struct cgroup *cgroup,
> -			     enum bpf_attach_type type);
> +struct bpf_cgroup_storage *
> +bpf_cgroup_storage_link(struct bpf_cgroup_storage *new_storage,
> +			struct cgroup *cgroup, bool *storage_reused);
>  void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
>  int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *map);
> -void bpf_cgroup_storage_release(struct bpf_prog_aux *aux, struct bpf_map *map);
>  
>  int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
>  int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
> @@ -383,8 +386,6 @@ static inline void bpf_cgroup_storage_set(
>  	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
>  static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
>  					    struct bpf_map *map) { return 0; }
> -static inline void bpf_cgroup_storage_release(struct bpf_prog_aux *aux,
> -					      struct bpf_map *map) {}
>  static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
>  	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return NULL; }
>  static inline void bpf_cgroup_storage_free(
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7ac3992dacfe..b14f008ad028 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -78,7 +78,7 @@ struct bpf_lpm_trie_key {
>  
>  struct bpf_cgroup_storage_key {
>  	__u64	cgroup_inode_id;	/* cgroup inode id */
> -	__u32	attach_type;		/* program attach type */
> +	__u32	attach_type;		/* program attach type, unused */
>  };
>  
>  /* BPF syscall commands, see bpf(2) man-page for details. */
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index ac53102e244a..6b1ef4a809bb 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -28,12 +28,14 @@ void cgroup_bpf_offline(struct cgroup *cgrp)
>  	percpu_ref_kill(&cgrp->bpf.refcnt);
>  }
>  
> -static void bpf_cgroup_storages_free(struct bpf_cgroup_storage *storages[])
> +static void bpf_cgroup_storages_free(struct bpf_cgroup_storage *storages[],
> +				     bool *storage_reused)
>  {
>  	enum bpf_cgroup_storage_type stype;
>  
>  	for_each_cgroup_storage_type(stype)
> -		bpf_cgroup_storage_free(storages[stype]);
> +		if (!storage_reused || !storage_reused[stype])
> +			bpf_cgroup_storage_free(storages[stype]);
>  }
>  
>  static int bpf_cgroup_storages_alloc(struct bpf_cgroup_storage *storages[],
> @@ -45,7 +47,7 @@ static int bpf_cgroup_storages_alloc(struct bpf_cgroup_storage *storages[],
>  		storages[stype] = bpf_cgroup_storage_alloc(prog, stype);
>  		if (IS_ERR(storages[stype])) {
>  			storages[stype] = NULL;
> -			bpf_cgroup_storages_free(storages);
> +			bpf_cgroup_storages_free(storages, NULL);
>  			return -ENOMEM;
>  		}
>  	}
> @@ -63,21 +65,24 @@ static void bpf_cgroup_storages_assign(struct bpf_cgroup_storage *dst[],
>  }
>  
>  static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
> -				     struct cgroup* cgrp,
> -				     enum bpf_attach_type attach_type)
> +				     struct cgroup *cgrp, bool *storage_reused)
>  {
>  	enum bpf_cgroup_storage_type stype;
>  
>  	for_each_cgroup_storage_type(stype)
> -		bpf_cgroup_storage_link(storages[stype], cgrp, attach_type);
> +		storages[stype] =
> +			bpf_cgroup_storage_link(storages[stype], cgrp,
> +					        &storage_reused[stype]);
>  }
>  
> -static void bpf_cgroup_storages_unlink(struct bpf_cgroup_storage *storages[])
> +static void bpf_cgroup_storages_unlink(struct bpf_cgroup_storage *storages[],
> +				       bool *storage_reused)
>  {
>  	enum bpf_cgroup_storage_type stype;
>  
>  	for_each_cgroup_storage_type(stype)
> -		bpf_cgroup_storage_unlink(storages[stype]);
> +		if (!storage_reused || !storage_reused[stype])
> +			bpf_cgroup_storage_unlink(storages[stype]);
>  }
>  
>  /* Called when bpf_cgroup_link is auto-detached from dying cgroup.
> @@ -101,22 +106,23 @@ static void cgroup_bpf_release(struct work_struct *work)
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
> @@ -126,6 +132,11 @@ static void cgroup_bpf_release(struct work_struct *work)
>  		bpf_prog_array_free(old_array);
>  	}
>  
> +	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> +		bpf_cgroup_storage_unlink(storage);
> +		bpf_cgroup_storage_free(storage);
> +	}
> +
>  	mutex_unlock(&cgroup_mutex);
>  
>  	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
> @@ -290,6 +301,8 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
>  	for (i = 0; i < NR; i++)
>  		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
>  
> +	INIT_LIST_HEAD(&cgrp->bpf.storages);
> +
>  	for (i = 0; i < NR; i++)
>  		if (compute_effective_progs(cgrp, i, &arrays[i]))
>  			goto cleanup;
> @@ -422,7 +435,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	struct list_head *progs = &cgrp->bpf.progs[type];
>  	struct bpf_prog *old_prog = NULL;
>  	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> -	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> +	bool storage_reused[MAX_BPF_CGROUP_STORAGE_TYPE];
>  	struct bpf_prog_list *pl;
>  	int err;
>  
> @@ -455,22 +468,22 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	if (IS_ERR(pl))
>  		return PTR_ERR(pl);
>  
> -	if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
> -		return -ENOMEM;
> -
>  	if (pl) {
>  		old_prog = pl->prog;
> -		bpf_cgroup_storages_unlink(pl->storage);
> -		bpf_cgroup_storages_assign(old_storage, pl->storage);
>  	} else {
>  		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
> -		if (!pl) {
> -			bpf_cgroup_storages_free(storage);
> +		if (!pl)
>  			return -ENOMEM;
> -		}
> +
>  		list_add_tail(&pl->node, progs);
>  	}
>  
> +	err = bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog);
> +	if (err)
> +		goto cleanup;
> +
> +	bpf_cgroup_storages_link(storage, cgrp, storage_reused);
> +
>  	pl->prog = prog;
>  	pl->link = link;
>  	bpf_cgroup_storages_assign(pl->storage, storage);
> @@ -478,24 +491,24 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
>  
>  	err = update_effective_progs(cgrp, type);
>  	if (err)
> -		goto cleanup;
> +		goto cleanup_unlink;
>  
> -	bpf_cgroup_storages_free(old_storage);
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
>  	else
>  		static_branch_inc(&cgroup_bpf_enabled_key);
> -	bpf_cgroup_storages_link(pl->storage, cgrp, type);
>  	return 0;
>  
> +cleanup_unlink:
> +	bpf_cgroup_storages_unlink(storage, storage_reused);
> +
I still failed to understand why there is a need to do this dance
that always link/publish first and then unlink/unpublish during failure.
It causes all these changes to add and track "storage_reused" params
in a few functions for handling this one failure. That also requires
to introduce the cgroup_storage_lookup_insert().

Going back to my earlier comment in v2 which I didn't here any feedback:

**** snippet ****
>> lookup old, found=>reuse, not-found=>alloc.
>>
>> Only publish the new storage after the attach has succeeded.
*** snippet ****

I try to put them in code here (uncompiled code).  wdyt?

static int bpf_cgroup_storages_alloc(struct bpf_cgroup_storage *storages[],
				     struct bpf_cgroup_storage *new_storages[],
				     struct bpf_prog *prog,
				     struct cgroup *cgrp)
{
	enum bpf_cgroup_storage_type stype;
	struct bpf_cgroup_storage_key key;
	struct bpf_map *map;

	key.cgroup_inode_id = cgroup_id(cgrp);
	key.attach_type = 0;

	for_each_cgroup_storage_type(stype) {
		map = prog->aux->cgroup_storage[stype];
		if (!map)
			continue;

		storages[stype] = cgroup_storage_lookup((void *)map, &key, false);
		if (!storages[stype]) {
			struct bpf_cgroup_storage *new_storage;

			new_storage = bpf_cgroup_storage_alloc(prog, stype);
			if (IS_ERR(new_storage)) {
				bpf_cgroup_storages_free(new_storages);
				return PTR_ERR(new_storage);
			}
			storages[stype] = new_storage;
			new_storages[stype] = new_storage;
		}
	}

	return 0;
}

@@ -422,7 +439,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
-	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog_list *pl;
 	int err;
 
@@ -455,17 +472,16 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (IS_ERR(pl))
 		return PTR_ERR(pl);
 
-	if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
+	if (bpf_cgroup_storages_alloc(storage, new_storage,
+				      prog ? : link->link.prog, cgrp))
 		return -ENOMEM;
 
 	if (pl) {
 		old_prog = pl->prog;
-		bpf_cgroup_storages_unlink(pl->storage);
-		bpf_cgroup_storages_assign(old_storage, pl->storage);
 	} else {
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
 		if (!pl) {
-			bpf_cgroup_storages_free(storage);
+			bpf_cgroup_storages_free(new_storage);
 			return -ENOMEM;
 		}
 		list_add_tail(&pl->node, progs);
@@ -480,12 +496,11 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (err)
 		goto cleanup;
 
-	bpf_cgroup_storages_free(old_storage);
 	if (old_prog)
 		bpf_prog_put(old_prog);
 	else
 		static_branch_inc(&cgroup_bpf_enabled_key);
-	bpf_cgroup_storages_link(pl->storage, cgrp, type);
+	bpf_cgroup_storages_link(new_storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -493,9 +508,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 		pl->prog = old_prog;
 		pl->link = NULL;
 	}
-	bpf_cgroup_storages_free(pl->storage);
-	bpf_cgroup_storages_assign(pl->storage, old_storage);
-	bpf_cgroup_storages_link(pl->storage, cgrp, type);
+	bpf_cgroup_storages_free(new_storage);
 	if (!old_prog) {
 		list_del(&pl->node);
 		kfree(pl);

[ ... ]

> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 51bd5a8cb01b..78ffe69ff1d8 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
[ ... ]
> @@ -318,6 +313,17 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  static void cgroup_storage_map_free(struct bpf_map *_map)
>  {
>  	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
> +	struct list_head *storages = &map->list;
> +	struct bpf_cgroup_storage *storage, *stmp;
> +
> +	mutex_lock(&cgroup_mutex);
> +
> +	list_for_each_entry_safe(storage, stmp, storages, list_map) {
> +		bpf_cgroup_storage_unlink(storage);
> +		bpf_cgroup_storage_free(storage);
> +	}
> +
> +	mutex_unlock(&cgroup_mutex);
>  
>  	WARN_ON(!RB_EMPTY_ROOT(&map->root));
>  	WARN_ON(!list_empty(&map->list));
> @@ -431,13 +437,10 @@ int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *_map)
>  
>  	spin_lock_bh(&map->lock);
>  
> -	if (map->aux && map->aux != aux)
> -		goto unlock;
>  	if (aux->cgroup_storage[stype] &&
>  	    aux->cgroup_storage[stype] != _map)
>  		goto unlock;
>  
> -	map->aux = aux;
Is spin_lock_bh(&map->lock) still required in this function?

