Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0B20020F
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 08:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgFSGnx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 02:43:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9298 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbgFSGnw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 02:43:52 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J6eZ42008233;
        Thu, 18 Jun 2020 23:43:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SuMMtdl81vRO6QEfu5V+miFgzsRXOx+7Icy+hSogAfg=;
 b=QjZAixo2wR5NDtH703rR1aITT9h3DIiFLTKG74mFQUDK4KgI8EMaPCxcJeG6LdflHB/2
 rpvay/Zq9UVjqgtAfI4gjUQuM0RAGyYVsQ3dPXSTT/I+6z37IXEFjYpPx4hw/WXqvpAi
 UJsVnJ5jonETy+wd+JrFdKaSIBbKqQLakI0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31rg9jsxj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 23:43:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 23:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JobPelCVEJZ50vjiiNeWgXdkqIcH1a+XC9WOBYOR8163LYFZ4s6Ht8Y/xjmx4z91kgjhvKVjALQa3hikge0wOAfpPoqswaqbIdPpZlz6rCeKegepTGyXie86GLZAsEF01FbJqnfKtHR9mG3zZLIcxmFVX9e3Kj1mgUItkC7N7Hp8gv54FtDmLnGt6bJKJ5hktRiQwhYCVsAT+dmcG9zLBz6+K4bPkbvaQlvixsm+cndtFnSVaz2NvmNP6ss78XLJFuJd5rn+wArMW0uB87awpDApu8vvxVqEOfFMZlErD55c6EkdpNTCo6RaTHQDTiaxaP0mIifR/8A1uUMJKCdRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuMMtdl81vRO6QEfu5V+miFgzsRXOx+7Icy+hSogAfg=;
 b=W2hhV6uniXbDEsctor8sk/fQsp1cmfK0lO5V79SNNtKdUu2fqhhGekV0XDVvkKlRF4/rknzdYFb2QnUlow3HmFUp9JnYGHycRmpIWQo+bTR1EBSOId5+AlAbvm+51xsYPrY4vP7cb3IVIbcHSxNtA46Zxwa+uKh2TMtmHzpOT8ZKiNIk+/7Ra1HH9LdrmbgOlIi2CSGNIIfOYHI2MfPv+yi4gDHprZEvg0JcPfVINIvSmRiKB4c9o5mlOXd8lGsvJNxZRJgzKBUpFtAV0li3HUXyRFgKzfs0nPmW/wrCVKXKplVT7IrRoTsXAh6+w0IJ1TTSjHCNnD+UwgBr9JLgrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuMMtdl81vRO6QEfu5V+miFgzsRXOx+7Icy+hSogAfg=;
 b=S+I6TCpdhEVjT7UsF41GP82/s1nI6KPAbk11jJpX3do3IVWs7wRgs5c6T78fP1HbaUP2vvS7imPA3H2twiwS8xYOWc6yMZIdq/IPUnN973J/P1zfBo9Ba5nC2QyLIbXA+bLJg6z0WJWQWmStjD5p/iDtR7GbA88jmTZGMqyJId4=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 06:43:34 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 06:43:33 +0000
Date:   Thu, 18 Jun 2020 23:43:32 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Generalize bpf_sk_storage
Message-ID: <20200619064332.fycpxuegmmkbfe54@kafai-mbp.dhcp.thefacebook.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617202941.3034-2-kpsingh@chromium.org>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:a03:80::28) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:7c9) by BYAPR11CA0051.namprd11.prod.outlook.com (2603:10b6:a03:80::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 06:43:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:7c9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 317d569f-bc18-4e4b-e6ef-08d8141c15e1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2822B2775A72CBD129346A26D5980@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGmJlj7M8PbeAPblDL2TQOz0h8Bcb/OqoiHZOzq8RR2M+iYLXGo/HxgsqZB4S4On+LJ90x7nvQD1dDH0tVuuI49Mr46R8NGFoZP+2qglfs+zA+EL8/H5Ot/hDoheAhcwso1E7SiQK3yTDQuKisQDdKFU2LPODJ8DwqEjlqb4KkgPV6N5/xEYAMwcm3AkCV1QqUQgdKw1FE4QxPDDHTRh/DHYNc8fpRMJSjGJyBi26qQ2aKqWv4dCUbD984IM8ISJ+JLtYrHeLH7OY7mSOM5jL3A+yupsTPGNos8zBTxQoo9W3i8Nw7ef+QM8Bhb5wdRhmX+qlc+7eIuJwO7fCKI67Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(478600001)(52116002)(7696005)(186003)(6506007)(16526019)(1076003)(66946007)(54906003)(66476007)(9686003)(55016002)(316002)(66556008)(83380400001)(86362001)(5660300002)(4326008)(8936002)(8676002)(6916009)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0eI/5MAnACFJ/QK1mRAz4kmac1tNaQdBy9PHO5yhFs3aw/FdI+ICcQICStq4DbEMrmTArny4BjE7OntKZczrqJ6+4I/eWlSznGHjEmPPMwNbLm/ZjAqxA/PPFPs8UwQvD7dWoLsrlD7D3cGFrfOD42KBpK0zsvbO/YrkmDNRMypbWYPKSffLu/bKh78Vb6W9S62OMnO/YYZWHq8TOkfPSfUiyBavfCoTzwls566pkLX1TirmzEjLbF08/zZ1zzKpQpILwW/7XtiLKgzTRh2BfvMwHO90IwKHQPdO1mG5SAY1qC8P7xqqQvO2Kjm+kLEMBkblExFEkm7Rs8166WBWn/7ddecfhW2YgRloscpeK11DJowJSzEHBH07JI3m4c3YFz8jbvw2PAFiW/NbWUoxu9qa9z6pfL9ZYSb6s5U5Bgqg+TP4yxOXjyCXA/4RIUOEB+qXYelf6DzV8AdSuIvA8Uk9h5BMy4GNyKtbN5pAhq4ljkefKS0ltlOImwGse6+ZzLIfSSlbGcQZgCEo6rIHng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 317d569f-bc18-4e4b-e6ef-08d8141c15e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 06:43:33.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9CkVKSgb8C8BCqz5eP5xJlBTkyJhgW+scrRG94ooozJpU4846z9WfiUW78btf6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_04:2020-06-18,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 cotscore=-2147483648
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=2 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 10:29:38PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Refactor the functionality in bpf_sk_storage.c so that concept of
> storage linked to kernel objects can be extended to other objects like
> inode, task_struct etc.
> 
> bpf_sk_storage is updated to be bpf_local_storage with a union that
> contains a pointer to the owner object. The type of the
> bpf_local_storage can be determined using the newly added
> bpf_local_storage_type enum.
> 
> Each new local storage will still be a separate map and provide its own
> set of helpers. This allows for future object specific extensions and
> still share a lot of the underlying implementation.
Thanks for taking up this effort to refactor sk_local_storage.

I took a quick look.  I have some comments and would like to explore
some thoughts.

> --- a/net/core/bpf_sk_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -1,19 +1,22 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2019 Facebook  */
> +#include "linux/bpf.h"
> +#include "asm-generic/bug.h"
> +#include "linux/err.h"
"<" ">"

>  #include <linux/rculist.h>
>  #include <linux/list.h>
>  #include <linux/hash.h>
>  #include <linux/types.h>
>  #include <linux/spinlock.h>
>  #include <linux/bpf.h>
> -#include <net/bpf_sk_storage.h>
> +#include <linux/bpf_local_storage.h>
>  #include <net/sock.h>
>  #include <uapi/linux/sock_diag.h>
>  #include <uapi/linux/btf.h>
>  
>  static atomic_t cache_idx;
inode local storage and sk local storage probably need a separate
cache_idx.  An improvement on picking cache_idx has just been
landed also.

[ ... ]

> +struct bpf_local_storage {
> +	struct bpf_local_storage_data __rcu *cache[BPF_STORAGE_CACHE_SIZE];
> +	struct hlist_head list;		/* List of bpf_local_storage_elem */
> +	/* The object that owns the the above "list" of
> +	 * bpf_local_storage_elem
> +	 */
> +	union {
> +		struct sock *sk;
> +	};
>  	struct rcu_head rcu;
>  	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
> +	enum bpf_local_storage_type stype;
>  };

[ ... ]

> +static struct bpf_local_storage_elem *sk_selem_alloc(
> +	struct bpf_local_storage_map *smap, struct sock *sk, void *value,
> +	bool charge_omem)
> +{
> +	struct bpf_local_storage_elem *selem;
> +
> +	if (charge_omem && omem_charge(sk, smap->elem_size))
> +		return NULL;
> +
> +	selem = selem_alloc(smap, value);
> +	if (selem)
> +		return selem;
> +
>  	if (charge_omem)
>  		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
>  
>  	return NULL;
>  }
>  
> -/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
> +static void __unlink_local_storage(struct bpf_local_storage *local_storage,
> +				   bool uncharge_omem)
Nit. indent is off.  There are a few more cases like this.

> +{
> +	struct sock *sk;
> +
> +	switch (local_storage->stype) {
Does it need a new bpf_local_storage_type?  Is map_type as good?

Instead of adding any new member (e.g. stype) to
"struct bpf_local_storage",  can the smap pointer be directly used
here instead?

For example in __unlink_local_storage() here, it should
have a hold to the selem which then has a hold to smap.

> +	case BPF_LOCAL_STORAGE_SK:
> +		sk = local_storage->sk;
> +		if (uncharge_omem)
> +			atomic_sub(sizeof(struct bpf_local_storage),
> +				   &sk->sk_omem_alloc);
> +
> +		/* After this RCU_INIT, sk may be freed and cannot be used */
> +		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
> +		local_storage->sk = NULL;
> +		break;
> +	}
Another thought on the stype switch cases.

Instead of having multiple switches on stype in bpf_local_storage.c which may
not be scalable soon if we are planning to support a few more kernel objects,
have you considered putting them into its own "ops".  May be a few new
ops can be added to bpf_map_ops to do local storage unlink/update/alloc...etc.

> +}
> +
> +/* local_storage->lock must be held and selem->local_storage == local_storage.
>   * The caller must ensure selem->smap is still valid to be
>   * dereferenced for its smap->elem_size and smap->cache_idx.
> + *
> + * uncharge_omem is only relevant when:
> + *
> + *	local_storage->stype == BPF_LOCAL_STORAGE_SK
>   */

[ ... ]

> @@ -845,7 +947,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
>  	   void *, value, u64, flags)
>  {
> -	struct bpf_sk_storage_data *sdata;
> +	struct bpf_local_storage_data *sdata;
>  
>  	if (flags > BPF_SK_STORAGE_GET_F_CREATE)
>  		return (unsigned long)NULL;
> @@ -854,14 +956,14 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
>  	if (sdata)
>  		return (unsigned long)sdata->data;
>  
> -	if (flags == BPF_SK_STORAGE_GET_F_CREATE &&
> +	if (flags == BPF_LOCAL_STORAGE_GET_F_CREATE &&
>  	    /* Cannot add new elem to a going away sk.
>  	     * Otherwise, the new elem may become a leak
>  	     * (and also other memory issues during map
>  	     *  destruction).
>  	     */
>  	    refcount_inc_not_zero(&sk->sk_refcnt)) {
> -		sdata = sk_storage_update(sk, map, value, BPF_NOEXIST);
> +		sdata = local_storage_update(sk, map, value, BPF_NOEXIST);
>  		/* sk must be a fullsock (guaranteed by verifier),
>  		 * so sock_gen_put() is unnecessary.
>  		 */
> @@ -887,14 +989,14 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
>  }
>  
>  const struct bpf_map_ops sk_storage_map_ops = {
> -	.map_alloc_check = bpf_sk_storage_map_alloc_check,
> -	.map_alloc = bpf_sk_storage_map_alloc,
> -	.map_free = bpf_sk_storage_map_free,
> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> +	.map_alloc = bpf_local_storage_map_alloc,
> +	.map_free = bpf_local_storage_map_free,
>  	.map_get_next_key = notsupp_get_next_key,
> -	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
> -	.map_update_elem = bpf_fd_sk_storage_update_elem,
> -	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
> -	.map_check_btf = bpf_sk_storage_map_check_btf,
> +	.map_lookup_elem = bpf_sk_storage_lookup_elem,
> +	.map_update_elem = bpf_sk_storage_update_elem,
> +	.map_delete_elem = bpf_sk_storage_delete_elem,
> +	.map_check_btf = bpf_local_storage_map_check_btf,
>  };
>  
>  const struct bpf_func_proto bpf_sk_storage_get_proto = {
> @@ -975,7 +1077,7 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
>  	u32 nr_maps = 0;
>  	int rem, err;
>  
> -	/* bpf_sk_storage_map is currently limited to CAP_SYS_ADMIN as
> +	/* bpf_local_storage_map is currently limited to CAP_SYS_ADMIN as
>  	 * the map_alloc_check() side also does.
>  	 */
>  	if (!bpf_capable())
> @@ -1025,10 +1127,10 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
>  }
>  EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
Would it be cleaner to leave bpf_sk specific function, map_ops, and func_proto
in net/core/bpf_sk_storage.c?

There is a test in map_tests/sk_storage_map.c, in case you may not notice.
