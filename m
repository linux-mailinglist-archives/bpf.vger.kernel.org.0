Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791FE247BB3
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 03:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgHRBGs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 21:06:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11994 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbgHRBGq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Aug 2020 21:06:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I10Wo5019986;
        Mon, 17 Aug 2020 18:06:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eNL/FpVSvxB4YGO1JaZjjV4a5f4mHcyKudlXBgZURhc=;
 b=pHwHZmgMH+4Tb70ZWcnf6LyCMSLGrZmxZVG8dA6egLvfAlMCZ3GRqasUuGiJogX36Yis
 bQJS2d7ySm+q3Lx3VArKqlx4v+A1pnS3OVj5RT0YxvATa6zoLs3BXLB2bGb4KJnPFS9S
 DN3EOZlcReahPFqd4zavPyuJEuo/OwyPem4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p382u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Aug 2020 18:06:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 17 Aug 2020 18:05:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXw7kitk4vko/UdQLqt5ncIWEUxenQoQtgRBAfyLUqNoGB0PX0bIXG2vWbI1LwhphgjiDIDwKLNtUIHQ7ayxK3pj3FDpljaSVfCDDf4uOeUzzg1jVxFzHxyu+mmxL6z8RTOrQbZGPGYWmwSId7wUf7lormmC1Xcv0fkbwYKhqiH7RjH0PsDBOjlkjPknpnrct2n4+wwLx+F25nixeWURHbbcVhl59IhwNDfhgenm8smZagjjZwVS+q+XEoMzL5No2fJU75jU1t8F4bEe5moWmoguDqrzQB4MD3+GcpSSOyYQx+GYC5KbkjiAaWikWoPTx9dtUl0qCZW4SvWuUe+IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNL/FpVSvxB4YGO1JaZjjV4a5f4mHcyKudlXBgZURhc=;
 b=OFcgGzdC1w4t1+2sTWJ9RjDBGQ2cV/tbJY23Y2pmOrilgDolL9O+VVZDCVENxxkm/KQZiYH72rJdwOR9sKvrtHAFsE95qBuOjINe1txDCJAxiUQ5LGtT1oLFANUDebmOgS5ooTORd/pivcJMhqWxx3LjYgB4Y7t3BU4/qSnKPVHELBqmFqqEhNIYAnO768FnksMDKP3qpmXtLal0mqhbVWcWilgx734DsH27IQsGDihr7b1NnVfaa4/kcVd6uPf05GnKqxVikvyP3+Pln+WNNbM7269QK3KV2nRViI8znigz4B0HMjA5cuFrX6npWyp9bZ/ZlryRnwP+Hu6fdaaOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNL/FpVSvxB4YGO1JaZjjV4a5f4mHcyKudlXBgZURhc=;
 b=cWIHHpDTrZlB0bJpuWJl4CKwOURtMhme+P3roOSVbExDTI5o2Gi9K1h0BP2BcynCEUrGPRXnBiBY/tzzOEK5tK8FfWpE7eDbwT9GzIueX+T+Z7oig9YQqyVAxLONL7hZ3GZ2VlS6pDZjwTW3vlujfsC76DoEVyjX53qEl7OMbP8=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2645.namprd15.prod.outlook.com (2603:10b6:a03:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 18 Aug
 2020 01:05:50 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Tue, 18 Aug 2020
 01:05:50 +0000
Date:   Mon, 17 Aug 2020 18:05:45 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v8 3/7] bpf: Generalize bpf_sk_storage
Message-ID: <20200818010545.iix72le4tkhuyqe5@kafai-mbp.dhcp.thefacebook.com>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-4-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803164655.1924498-4-kpsingh@chromium.org>
X-ClientProxiedBy: BY5PR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:a03:167::33) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:4b70) by BY5PR17CA0056.namprd17.prod.outlook.com (2603:10b6:a03:167::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 01:05:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:4b70]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd920c9f-fc3b-4cb7-6950-08d84312d906
X-MS-TrafficTypeDiagnostic: BYAPR15MB2645:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2645F72032FC0D3C2286B284D55C0@BYAPR15MB2645.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWohyAwCoNdQSxInqifUOWcJToYsrrBJ8Rh5O4OALwBm07stVr80yKAntw2RXYlLKq2vZRgaPfI4b9/e+npMNMVovk7rjLPMBetYVkxrj6PychfmyAR4PMJpnASKGE76hDQ5xHQs0pvjBvtrxckKGBeIIzoMnc89KwMw6OlulS0pJqIRFGKQ6VRNNHupqUerNWlPVSYnmmI0de/bmnIUlzDdwVPNShpdFZWC9IOXwBJiktKr66uvzIQcDxOMPmzchijiH/yyDhMiQF8WTi8DCcFWckAXXNKKxlk7PAXvv6hBgBvILa5DLiGfXZoyZa2/Lm7LrjVWnG2NjovBQeYN/lXF3fImyW8JVxlXjN/hcCg1RTfl7BC3jIuxTY6I7De9RZrkD+BN4NgNsVt7flN1uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(376002)(136003)(366004)(346002)(6666004)(966005)(66946007)(66556008)(52116002)(9686003)(7696005)(66476007)(55016002)(83380400001)(6506007)(478600001)(8676002)(86362001)(54906003)(6916009)(316002)(2906002)(16526019)(30864003)(4326008)(186003)(5660300002)(8936002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hQqfYoMapPykM0yC1wlhHsyHuu1WxUBzMNtmUuPkAI9DRBO1d8em6W5s4AkyZRyVIry8GHlAlCoLaOI4kL4a4t7sNOfrN6DVo9oMFTolUZDf/b4UI/YT2ESiVupHT0ZdIiBRGAaSdMW5V6+G5YZvGj7QC2TQeoXuiu9JqW7btbnSE+XK1uBuiSWw7VaPB0Tcx2x7ny1QRd58ouMrc3AwJK9G36iBrDpUQ/bNteM28PaoRx7wKihqIZ3S/gfHFKZaEb1WcA19ud6/bb226c+JZ0WtY251N/n/4IaomYMWrIB+OagPvp7sWyX0wpQRR6jD2y6mWlL2LIbZqPMViIIcy9JWQEHZwXGI1E7Uc2wMiMHBRMjERaKeNqD0nAcd4kXez13SttBmihDqBGWneIrNtkp/syKp3HZmHtS09HGL7MLrLgX48rBkW/2e3+w/TRsVYO4XAnkG9ZeE/uZ3zc9RvM0sk02ikF4mKSzD18MB1ulpUt8r/0aVhDY9rLkTWVGFyAEWIiG+zYjR0vVwxZG2BGBt7B5NwlOW0KoHvM8Gb61MkXVIzS+axxLeM6TUbYs0+Z0B8SYjUOYP/34oIxFA5jm5EvfJjQ0vNZWcaaOQ3hQSfCs8tos9kTl5bMg1MqMPkQoadIbgxXp3BJYxEiB+yisSRlNgQUeXvZHZu/PkIR0=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd920c9f-fc3b-4cb7-6950-08d84312d906
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 01:05:50.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UvlfnWozihJgY/ycV1pLxbI3mBihAuM47bUQGq/vyk0xC+kg0nPugZpswFe7bE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2645
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 03, 2020 at 06:46:51PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Refactor the functionality in bpf_sk_storage.c so that concept of
> storage linked to kernel objects can be extended to other objects like
> inode, task_struct etc.
> 
> Each new local storage will still be a separate map and provide its own
> set of helpers. This allows for future object specific extensions and
> still share a lot of the underlying implementation.
> 
> This includes the changes suggested by Martin in:
> 
>   https://lore.kernel.org/bpf/20200725013047.4006241-1-kafai@fb.com/
> 
> which adds map_local_storage_charge, map_local_storage_uncharge,
> and map_owner_storage_ptr.
A description will still be useful in the commit message to talk
about the new map_ops, e.g.
they allow kernel object to optionally have different mem-charge strategy.

> 
> Co-developed-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/linux/bpf.h            |   9 ++
>  include/net/bpf_sk_storage.h   |  51 +++++++
>  include/uapi/linux/bpf.h       |   8 +-
>  net/core/bpf_sk_storage.c      | 246 +++++++++++++++++++++------------
>  tools/include/uapi/linux/bpf.h |   8 +-
>  5 files changed, 233 insertions(+), 89 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cef4ef0d2b4e..8e1e23c60dc7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -34,6 +34,9 @@ struct btf_type;
>  struct exception_table_entry;
>  struct seq_operations;
>  struct bpf_iter_aux_info;
> +struct bpf_local_storage;
> +struct bpf_local_storage_map;
> +struct bpf_local_storage_elem;
"struct bpf_local_storage_elem" is not needed.

>  
>  extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
> @@ -104,6 +107,12 @@ struct bpf_map_ops {
>  	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
>  			     struct poll_table_struct *pts);
>  
> +	/* Functions called by bpf_local_storage maps */
> +	int (*map_local_storage_charge)(struct bpf_local_storage_map *smap,
> +					void *owner, u32 size);
> +	void (*map_local_storage_uncharge)(struct bpf_local_storage_map *smap,
> +					   void *owner, u32 size);
> +	struct bpf_local_storage __rcu ** (*map_owner_storage_ptr)(void *owner);
>  	/* BTF name and id of struct allocated by map_alloc */
>  	const char * const map_btf_name;
>  	int *map_btf_id;
> diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
> index 950c5aaba15e..05b777950eb3 100644
> --- a/include/net/bpf_sk_storage.h
> +++ b/include/net/bpf_sk_storage.h
> @@ -3,8 +3,15 @@
>  #ifndef _BPF_SK_STORAGE_H
>  #define _BPF_SK_STORAGE_H
>  
> +#include <linux/rculist.h>
> +#include <linux/list.h>
> +#include <linux/hash.h>
>  #include <linux/types.h>
>  #include <linux/spinlock.h>
> +#include <linux/bpf.h>
> +#include <net/sock.h>
> +#include <uapi/linux/sock_diag.h>
> +#include <uapi/linux/btf.h>
>  
>  struct sock;
>  
> @@ -34,6 +41,50 @@ u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache);
>  void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
>  				      u16 idx);
>  
> +/* Helper functions for bpf_local_storage */
> +int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
> +
> +struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr);
> +
> +struct bpf_local_storage_data *
> +bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> +			 struct bpf_local_storage_map *smap,
> +			 bool cacheit_lockit);
> +
> +void bpf_local_storage_map_free(struct bpf_local_storage_map *smap);
> +
> +int bpf_local_storage_map_check_btf(const struct bpf_map *map,
> +				    const struct btf *btf,
> +				    const struct btf_type *key_type,
> +				    const struct btf_type *value_type);
> +
> +void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
> +			    struct bpf_local_storage_elem *selem);
> +
> +bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
> +			      struct bpf_local_storage_elem *selem,
> +			      bool uncharge_omem);
> +
> +void bpf_selem_unlink(struct bpf_local_storage_elem *selem);
> +
> +void bpf_selem_link_map(struct bpf_local_storage_map *smap,
> +			struct bpf_local_storage_elem *selem);
> +
> +void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem);
> +
> +struct bpf_local_storage_elem *
> +bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
> +		bool charge_mem);
> +
> +int
> +bpf_local_storage_alloc(void *owner,
> +			struct bpf_local_storage_map *smap,
> +			struct bpf_local_storage_elem *first_selem);
> +
> +struct bpf_local_storage_data *
> +bpf_local_storage_update(void *owner, struct bpf_map *map, void *value,
Nit.  It may be more consistent to take "struct bpf_local_storage_map *smap"
instead of "struct bpf_map *map" here.

bpf_local_storage_map_check_btf() will be the only one taking
"struct bpf_map *map".

> +			 u64 map_flags);
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
>  struct bpf_sk_storage_diag *
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b134e679e9db..35629752cec8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3647,9 +3647,13 @@ enum {
>  	BPF_F_SYSCTL_BASE_NAME		= (1ULL << 0),
>  };
>  
> -/* BPF_FUNC_sk_storage_get flags */
> +/* BPF_FUNC_<local>_storage_get flags */
BPF_FUNC_<kernel_obj>_storage_get flags?

>  enum {
> -	BPF_SK_STORAGE_GET_F_CREATE	= (1ULL << 0),
> +	BPF_LOCAL_STORAGE_GET_F_CREATE	= (1ULL << 0),
> +	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
> +	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
> +	 */
> +	BPF_SK_STORAGE_GET_F_CREATE  = BPF_LOCAL_STORAGE_GET_F_CREATE,
>  };
>  
>  /* BPF_FUNC_read_branch_records flags. */
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 99dde7b74767..bb2375769ca1 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -84,7 +84,7 @@ struct bpf_local_storage_elem {
>  struct bpf_local_storage {
>  	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
>  	struct hlist_head list; /* List of bpf_local_storage_elem */
> -	struct sock *owner;	/* The object that owns the the above "list" of
> +	void *owner;		/* The object that owns the the above "list" of
>  				 * bpf_local_storage_elem.
>  				 */
>  	struct rcu_head rcu;
> @@ -110,6 +110,33 @@ static int omem_charge(struct sock *sk, unsigned int size)
>  	return -ENOMEM;
>  }
>  
> +static int mem_charge(struct bpf_local_storage_map *smap, void *owner, u32 size)
> +{
> +	struct bpf_map *map = &smap->map;
> +
> +	if (!map->ops->map_local_storage_charge)
> +		return 0;
> +
> +	return map->ops->map_local_storage_charge(smap, owner, size);
> +}
> +
> +static void mem_uncharge(struct bpf_local_storage_map *smap, void *owner,
> +			 u32 size)
> +{
> +	struct bpf_map *map = &smap->map;
> +
> +	if (map->ops->map_local_storage_uncharge)
> +		map->ops->map_local_storage_uncharge(smap, owner, size);
> +}
> +
> +static struct bpf_local_storage __rcu **
> +owner_storage(struct bpf_local_storage_map *smap, void *owner)
> +{
> +	struct bpf_map *map = &smap->map;
> +
> +	return map->ops->map_owner_storage_ptr(owner);
> +}
> +
>  static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
>  {
>  	return !hlist_unhashed(&selem->snode);
> @@ -120,13 +147,13 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
>  	return !hlist_unhashed(&selem->map_node);
>  }
>  
> -static struct bpf_local_storage_elem *
> -bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
> -		void *value, bool charge_omem)
> +struct bpf_local_storage_elem *
> +bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> +		void *value, bool charge_mem)
>  {
>  	struct bpf_local_storage_elem *selem;
>  
> -	if (charge_omem && omem_charge(sk, smap->elem_size))
> +	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
>  		return NULL;
>  
>  	selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
> @@ -136,40 +163,42 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
>  		return selem;
>  	}
>  
> -	if (charge_omem)
> -		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
> +	if (charge_mem)
> +		mem_uncharge(smap, owner, smap->elem_size);
>  
>  	return NULL;
>  }
>  
> -/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
> +/* local_storage->lock must be held and selem->sk_storage == sk_storage.
This name change belongs to patch 1.

Also,
selem->"local_"storage == "local_"storage

>   * The caller must ensure selem->smap is still valid to be
>   * dereferenced for its smap->elem_size and smap->cache_idx.
>   */

[ ... ]

> @@ -367,7 +401,7 @@ static int sk_storage_alloc(struct sock *sk,
>  		/* Note that even first_selem was linked to smap's
>  		 * bucket->list, first_selem can be freed immediately
>  		 * (instead of kfree_rcu) because
> -		 * bpf_sk_storage_map_free() does a
> +		 * bpf_local_storage_map_free() does a
This name change belongs to patch 1 also.

>  		 * synchronize_rcu() before walking the bucket->list.
>  		 * Hence, no one is accessing selem from the
>  		 * bucket->list under rcu_read_lock().
> @@ -377,8 +411,8 @@ static int sk_storage_alloc(struct sock *sk,
>  	return 0;
>  
>  uncharge:
> -	kfree(sk_storage);
> -	atomic_sub(sizeof(*sk_storage), &sk->sk_omem_alloc);
> +	kfree(storage);
> +	mem_uncharge(smap, owner, sizeof(*storage));
>  	return err;
>  }
>  
> @@ -387,9 +421,9 @@ static int sk_storage_alloc(struct sock *sk,
>   * Otherwise, it will become a leak (and other memory issues
>   * during map destruction).
>   */
> -static struct bpf_local_storage_data *
> -bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
> -			 u64 map_flags)
> +struct bpf_local_storage_data *
> +bpf_local_storage_update(void *owner, struct bpf_map *map,
> +			 void *value, u64 map_flags)
>  {
>  	struct bpf_local_storage_data *old_sdata = NULL;
>  	struct bpf_local_storage_elem *selem;
> @@ -404,21 +438,21 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
>  		return ERR_PTR(-EINVAL);
>  
>  	smap = (struct bpf_local_storage_map *)map;
> -	local_storage = rcu_dereference(sk->sk_bpf_storage);
> +	local_storage = rcu_dereference(*owner_storage(smap, owner));
>  	if (!local_storage || hlist_empty(&local_storage->list)) {
> -		/* Very first elem for this object */
> +		/* Very first elem for the owner */
>  		err = check_flags(NULL, map_flags);
>  		if (err)
>  			return ERR_PTR(err);
>  
> -		selem = bpf_selem_alloc(smap, sk, value, true);
> +		selem = bpf_selem_alloc(smap, owner, value, true);
>  		if (!selem)
>  			return ERR_PTR(-ENOMEM);
>  
> -		err = sk_storage_alloc(sk, smap, selem);
> +		err = bpf_local_storage_alloc(owner, smap, selem);
>  		if (err) {
>  			kfree(selem);
> -			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
> +			mem_uncharge(smap, owner, smap->elem_size);
>  			return ERR_PTR(err);
>  		}
>  
> @@ -430,8 +464,8 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
>  		 * such that it can avoid taking the local_storage->lock
>  		 * and changing the lists.
>  		 */
> -		old_sdata =
> -			bpf_local_storage_lookup(local_storage, smap, false);
> +		old_sdata = bpf_local_storage_lookup(local_storage, smap,
> +						     false);
Pure indentation change.  The same line has been changed in patch 1.  Please change
the identation in patch 1 if the above way is preferred.

>  		err = check_flags(old_sdata, map_flags);
>  		if (err)
>  			return ERR_PTR(err);
> @@ -475,7 +509,7 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
>  	 * old_sdata will not be uncharged later during
>  	 * bpf_selem_unlink_storage().
>  	 */
> -	selem = bpf_selem_alloc(smap, sk, value, !old_sdata);
> +	selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
>  	if (!selem) {
>  		err = -ENOMEM;
>  		goto unlock_err;
> @@ -567,7 +601,7 @@ void bpf_sk_storage_free(struct sock *sk)
>  	 * Thus, no elem can be added-to or deleted-from the
>  	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
>  	 *
> -	 * It is racing with bpf_sk_storage_map_free() alone
> +	 * It is racing with bpf_local_storage_map_free() alone
This name change belongs to patch 1 also.

>  	 * when unlinking elem from the sk_storage->list and
>  	 * the map's bucket->list.
>  	 */
> @@ -587,17 +621,12 @@ void bpf_sk_storage_free(struct sock *sk)
>  		kfree_rcu(sk_storage, rcu);
>  }
>  
> -static void bpf_local_storage_map_free(struct bpf_map *map)
> +void bpf_local_storage_map_free(struct bpf_local_storage_map *smap)
>  {
>  	struct bpf_local_storage_elem *selem;
> -	struct bpf_local_storage_map *smap;
>  	struct bpf_local_storage_map_bucket *b;
>  	unsigned int i;
>  
> -	smap = (struct bpf_local_storage_map *)map;
> -
> -	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
> -
>  	/* Note that this map might be concurrently cloned from
>  	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
>  	 * RCU read section to finish before proceeding. New RCU
> @@ -607,11 +636,12 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
>  
>  	/* bpf prog and the userspace can no longer access this map
>  	 * now.  No new selem (of this map) can be added
> -	 * to the sk->sk_bpf_storage or to the map bucket's list.
> +	 * to the bpf_local_storage or to the map bucket's list.
s/bpf_local_storage/owner->storage/

>  	 *
>  	 * The elem of this map can be cleaned up here
>  	 * or
> -	 * by bpf_sk_storage_free() during __sk_destruct().
> +	 * by bpf_local_storage_free() during the destruction of the
> +	 * owner object. eg. __sk_destruct.
This belongs to patch 1 also.

>  	 */
>  	for (i = 0; i < (1U << smap->bucket_log); i++) {
>  		b = &smap->buckets[i];
> @@ -627,22 +657,31 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
>  		rcu_read_unlock();
>  	}
>  
> -	/* bpf_sk_storage_free() may still need to access the map.
> -	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
> +	/* bpf_local_storage_free() may still need to access the map.
It is confusing.  There is no bpf_local_storage_free().

> +	 * e.g. bpf_local_storage_free() has unlinked selem from the map
>  	 * which then made the above while((selem = ...)) loop
>  	 * exited immediately.
>  	 *
> -	 * However, the bpf_sk_storage_free() still needs to access
> +	 * However, the bpf_local_storage_free() still needs to access
Same here.

>  	 * the smap->elem_size to do the uncharging in
>  	 * bpf_selem_unlink_storage().
>  	 *
>  	 * Hence, wait another rcu grace period for the
> -	 * bpf_sk_storage_free() to finish.
> +	 * bpf_local_storage_free() to finish.
and here.

>  	 */
>  	synchronize_rcu();
>  
>  	kvfree(smap->buckets);
> -	kfree(map);
> +	kfree(smap);
> +}
> +
> +static void sk_storage_map_free(struct bpf_map *map)
> +{
> +	struct bpf_local_storage_map *smap;
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
> +	bpf_local_storage_map_free(smap);
>  }
>  
>  /* U16_MAX is much more than enough for sk local storage
> @@ -654,7 +693,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
>  	       sizeof(struct bpf_local_storage_elem)),			\
>  	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
>  
> -static int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
> +int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
>  {
>  	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
>  	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
> @@ -673,7 +712,7 @@ static int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
>  	return 0;
>  }
>  
> -static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
> +struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
>  {
>  	struct bpf_local_storage_map *smap;
>  	unsigned int i;
> @@ -711,9 +750,21 @@ static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
>  		raw_spin_lock_init(&smap->buckets[i].lock);
>  	}
>  
> -	smap->elem_size = sizeof(struct bpf_local_storage_elem) + attr->value_size;
> -	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
> +	smap->elem_size =
> +		sizeof(struct bpf_local_storage_elem) + attr->value_size;
Same line has changed in patch 1.   Change the indentation in patch 1 also
if the above way is desired.

Others LGTM.
