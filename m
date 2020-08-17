Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72246247B4B
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 01:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHQX4u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 19:56:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgHQX4t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Aug 2020 19:56:49 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HNrJSI012956;
        Mon, 17 Aug 2020 16:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=dXcec1pyJcNiAmil8C3zODSdy5PDonNEiWwfHLAovCI=;
 b=LGF6UJjEFUhiRCOWNtExQRYeF94+AGsFbh8VV59w/ggQfG3vGbPuLv1VPVRicrHFg7pr
 K7TL5WSjZdnkQVvSqIsfMtDcoDvZqZOY5pug9Q3p0wF6RJZkj8aIVXfjZdnggYr19twh
 bMQFIau8F3wk1+u8vPvIpSaa4dmhtK0dPMg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32xyyp86av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Aug 2020 16:56:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 17 Aug 2020 16:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD7mLm+tLrfS55YaZWsw8SU7b4tvu1/1wEn0OP3Lq45rEqAs5Ef2dKW0JYiliBJscRvnz9xO5D0OIYyF/eEU37sHH4pLU5JttPR+4hvYmdiugM4OEuTTdOgZQLbtJD0JEHBI+uagNNBz5pKNLwAU1ik7fF8Qrb0Rf1jh2olvwO4ka4A8gbbg1x9AwZG1IjahE0iPpQK/FwTLLEX7VGnsVv+KgUVX5f+Yi5Niw6k4A8j7yym7nUTtt7JSUOVScCsYoZtD9aEUa6OVZSsdd2YXE8hNfswiLlu9BqZNtsAajxiqQAqvWCAdYbV0UncJFMPFYDVpMRIGVYYuzli1j8P9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXcec1pyJcNiAmil8C3zODSdy5PDonNEiWwfHLAovCI=;
 b=KaMt5HpLU7QVBRvOcTrkrfq96mt/tmMjQeZhUMc+pu5G9gq/5aD3X+ySdlZjX5+uaIBuVwvuoLp9PNgHX7mlMCHWXT+Pmnt+o/CGQi2EZaF1DwU9pBzl4ieagEbeQQ+gFv4hHlHyvTFOz1jRCMWV5J7+25jh3TKqALe+4em4Z9cxz0RdNlrfYPJP1Q4QhGg8V3hnv1xzFSFF97wbkhPFkbV/BTdGCUBxshl+7qb5LEX4uL8HOkfKNtfqCCp6znWKp/LUnOpR8yyfR/l0Bz3P5JUO9fpo6aIcM+KQ59UaxZgDQOshmlMQf3QdP04+Qq8CLben30UjrYHGH6KVFaOF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXcec1pyJcNiAmil8C3zODSdy5PDonNEiWwfHLAovCI=;
 b=HfLRGzltukdoyCndQc4JZ37nhLDXRv7dSeWxIZhDn0ymKEVzwHoPJM5w6omw9ntQrNgG6Sq4K+Bpc4TuxMPKAJ0Fh2WUYG3jnm6gYaAuNboEfofmWCGQudTyjXc3smg1zxD438Ml2HRBIkOG5387CtZ/7zx28/Yta+zBjiMrD5w=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2262.namprd15.prod.outlook.com (2603:10b6:a02:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 23:56:27 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Mon, 17 Aug 2020
 23:56:27 +0000
Date:   Mon, 17 Aug 2020 16:56:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v8 1/7] A purely mechanical change to split the
 renaming from the actual generalization.
Message-ID: <20200817235621.ulkqw6mqd2uu647t@kafai-mbp.dhcp.thefacebook.com>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803164655.1924498-2-kpsingh@chromium.org>
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:4b70) by BY3PR10CA0022.namprd10.prod.outlook.com (2603:10b6:a03:255::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 23:56:26 +0000
X-Originating-IP: [2620:10d:c090:400::5:4b70]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dbcc4b3-cd4f-48f5-6a0e-08d843092777
X-MS-TrafficTypeDiagnostic: BYAPR15MB2262:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22625CF6814050EDE0DC55F0D55F0@BYAPR15MB2262.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzn1Sq50Q0UWzcfilZvFBz+utMUBhHjK3NKqzV6xDVRKkXV0VE2ZKkuC9VzfuD6EgXDH4SUp12E1sccES1GTpvs1nplcT8p89y3wfFLbns7j7PvT6hELvEC1iTc5uLtIxs0A53VN73MOYApECPeyckEvaOOO9LlIDVrpW3FxD4zw6JtWg/yQqh+e3PffJXdFqSnajcfIsi7AtPI+vkhBam3XFLm4Rh8cro+IjHNuNMw5O3croKIDRE4kxobksCvGE4u1M6F2F85aAJGvJpkq3J6YnzCwXPRVtdAYi9lmlXPWxv+HqyZXcoJM9SwZu6F3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(346002)(136003)(366004)(55016002)(8936002)(86362001)(5660300002)(4326008)(186003)(16526019)(8676002)(9686003)(6666004)(6916009)(54906003)(1076003)(83380400001)(66946007)(2906002)(6506007)(316002)(66476007)(66556008)(52116002)(478600001)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TZA4/hedizCTsaQzNK4nkI+K7fVMrQFFqE6yW9EWayKCBT2oGyqOFp9qzVx8PxB84gvYWMPt2El//l8EZ0bblgSfDo3owZqETf44ZAH05l2VOmmyM9J2rv7lqWY3+U7hZqKI4m/55GYjTcZpEJ3/zXlVDlXMrHO9QRBvuRD0iPSVaT3WOiGqo4LFMRtQRFqAaZ6/oOYLtU9MPAWQlx3oBHTna7x2UoTBijM4p1KJCzayf2pOzqPDc7xGTg7FheuMYiW0QXLqY5MVenGSHOI6vXXb5pDjhqZAyuCHphOkTsZmIoFvT6fg4XknrvgRXcTejHdyFb534jd1CcAhK9hLncIm8MgxaBqVxPFaTMoIjoBuzZP+YBvd40Ggs9Lo07IO00AW1M6HYvIo0WriFj0e8aX51Kn5W59S120SvNmwPtp86dNvzJs8CkThTEV5kPyGon29yHr4xiHskTUkmbFMqm+t3mXBXiVZ0+hsu92fGoGydWWyK21KH32E5GHvPJ2klYqkxD++tK45ef5uqEz3KdqIuU0AzJEHGsK/UfBwy6hp1J9IcnkuEhElUSrxhyg+EM5N9w8aOQXtAIG2vmL6SEomZ1vb4wrTJUzeoeQijJsV91Utap0TWuPjwawPP1XXCjDvkRUOJLIVuBUgg4MoJdX/kdH+pig6NsXr41cafOQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbcc4b3-cd4f-48f5-6a0e-08d843092777
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 23:56:27.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A77SA7GRiPCad9liF8VkxRiO6matFtYKfyBbNyHz9iTiKEHvbxj/HZNxB67lyEC3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=5 clxscore=1015
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170161
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 03, 2020 at 06:46:49PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Flags/consts:
> 
>   SK_STORAGE_CREATE_FLAG_MASK	BPF_LOCAL_STORAGE_CREATE_FLAG_MASK
>   BPF_SK_STORAGE_CACHE_SIZE	BPF_LOCAL_STORAGE_CACHE_SIZE
>   MAX_VALUE_SIZE		BPF_LOCAL_STORAGE_MAX_VALUE_SIZE
> 
> Structs:
> 
>   bucket			bpf_local_storage_map_bucket
>   bpf_sk_storage_map		bpf_local_storage_map
>   bpf_sk_storage_data		bpf_local_storage_data
>   bpf_sk_storage_elem		bpf_local_storage_elem
>   bpf_sk_storage		bpf_local_storage
> 
> The "sk" member in bpf_local_storage is also updated to "owner"
> in preparation for changing the type to void * in a subsequent patch.
> 
> Functions:
> 
>   selem_linked_to_sk			selem_linked_to_storage
>   selem_alloc				bpf_selem_alloc
>   __selem_unlink_sk			bpf_selem_unlink_storage
>   __selem_link_sk			bpf_selem_link_storage
>   selem_unlink_sk			__bpf_selem_unlink_storage
>   sk_storage_update			bpf_local_storage_update
>   __sk_storage_lookup			bpf_local_storage_lookup
>   bpf_sk_storage_map_free		bpf_local_storage_map_free
>   bpf_sk_storage_map_alloc		bpf_local_storage_map_alloc
>   bpf_sk_storage_map_alloc_check	bpf_local_storage_map_alloc_check
>   bpf_sk_storage_map_check_btf		bpf_local_storage_map_check_btf
> 

[ ... ]

> @@ -147,85 +148,86 @@ static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
>   * The caller must ensure selem->smap is still valid to be
>   * dereferenced for its smap->elem_size and smap->cache_idx.
>   */
> -static bool __selem_unlink_sk(struct bpf_sk_storage *sk_storage,
> -			      struct bpf_sk_storage_elem *selem,
> -			      bool uncharge_omem)
> +static bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
> +				     struct bpf_local_storage_elem *selem,
> +				     bool uncharge_omem)
Please add a "_nolock()" suffix, just to be clear that the unlink_map()
counter part is locked.  It could be a follow up later.

>  {
> -	struct bpf_sk_storage_map *smap;
> -	bool free_sk_storage;
> +	struct bpf_local_storage_map *smap;
> +	bool free_local_storage;
>  	struct sock *sk;
>  
>  	smap = rcu_dereference(SDATA(selem)->smap);
> -	sk = sk_storage->sk;
> +	sk = local_storage->owner;
>  
>  	/* All uncharging on sk->sk_omem_alloc must be done first.
> -	 * sk may be freed once the last selem is unlinked from sk_storage.
> +	 * sk may be freed once the last selem is unlinked from local_storage.
>  	 */
>  	if (uncharge_omem)
>  		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
>  
> -	free_sk_storage = hlist_is_singular_node(&selem->snode,
> -						 &sk_storage->list);
> -	if (free_sk_storage) {
> -		atomic_sub(sizeof(struct bpf_sk_storage), &sk->sk_omem_alloc);
> -		sk_storage->sk = NULL;
> +	free_local_storage = hlist_is_singular_node(&selem->snode,
> +						    &local_storage->list);
> +	if (free_local_storage) {
> +		atomic_sub(sizeof(struct bpf_local_storage), &sk->sk_omem_alloc);
> +		local_storage->owner = NULL;
>  		/* After this RCU_INIT, sk may be freed and cannot be used */
>  		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
>  
> -		/* sk_storage is not freed now.  sk_storage->lock is
> -		 * still held and raw_spin_unlock_bh(&sk_storage->lock)
> +		/* local_storage is not freed now.  local_storage->lock is
> +		 * still held and raw_spin_unlock_bh(&local_storage->lock)
>  		 * will be done by the caller.
>  		 *
>  		 * Although the unlock will be done under
>  		 * rcu_read_lock(),  it is more intutivie to
> -		 * read if kfree_rcu(sk_storage, rcu) is done
> -		 * after the raw_spin_unlock_bh(&sk_storage->lock).
> +		 * read if kfree_rcu(local_storage, rcu) is done
> +		 * after the raw_spin_unlock_bh(&local_storage->lock).
>  		 *
> -		 * Hence, a "bool free_sk_storage" is returned
> +		 * Hence, a "bool free_local_storage" is returned
>  		 * to the caller which then calls the kfree_rcu()
>  		 * after unlock.
>  		 */
>  	}
>  	hlist_del_init_rcu(&selem->snode);
> -	if (rcu_access_pointer(sk_storage->cache[smap->cache_idx]) ==
> +	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
>  	    SDATA(selem))
> -		RCU_INIT_POINTER(sk_storage->cache[smap->cache_idx], NULL);
> +		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
>  
>  	kfree_rcu(selem, rcu);
>  
> -	return free_sk_storage;
> +	return free_local_storage;
>  }
>  
> -static void selem_unlink_sk(struct bpf_sk_storage_elem *selem)
> +static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
>  {
> -	struct bpf_sk_storage *sk_storage;
> -	bool free_sk_storage = false;
> +	struct bpf_local_storage *local_storage;
> +	bool free_local_storage = false;
>  
> -	if (unlikely(!selem_linked_to_sk(selem)))
> +	if (unlikely(!selem_linked_to_storage(selem)))
>  		/* selem has already been unlinked from sk */
>  		return;
>  
> -	sk_storage = rcu_dereference(selem->sk_storage);
> -	raw_spin_lock_bh(&sk_storage->lock);
> -	if (likely(selem_linked_to_sk(selem)))
> -		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
> -	raw_spin_unlock_bh(&sk_storage->lock);
> +	local_storage = rcu_dereference(selem->local_storage);
> +	raw_spin_lock_bh(&local_storage->lock);
> +	if (likely(selem_linked_to_storage(selem)))
> +		free_local_storage =
> +			bpf_selem_unlink_storage(local_storage, selem, true);
> +	raw_spin_unlock_bh(&local_storage->lock);
>  
> -	if (free_sk_storage)
> -		kfree_rcu(sk_storage, rcu);
> +	if (free_local_storage)
> +		kfree_rcu(local_storage, rcu);
>  }
>  
> -static void __selem_link_sk(struct bpf_sk_storage *sk_storage,
> -			    struct bpf_sk_storage_elem *selem)
> +static void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
> +				   struct bpf_local_storage_elem *selem)
Same here. bpf_selem_link_storage"_nolock"().

Please tag the Subject line with "bpf:".

Acked-by: Martin KaFai Lau <kafai@fb.com>
