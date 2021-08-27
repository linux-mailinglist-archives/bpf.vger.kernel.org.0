Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192483FA0EE
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 22:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhH0U4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Aug 2021 16:56:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231751AbhH0U4n (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Aug 2021 16:56:43 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17RKtXGT025853;
        Fri, 27 Aug 2021 13:55:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ng+KESeh9piRN0Wxh92AKmAzck6fuJc06o575uPc4ZI=;
 b=cS9sPV8xvBwT+wZuHrarHC6cDnr78AZ2jKbovDjO0+X1etrour0UYv9vIPEyTKEH+xL8
 ojNR2VrL6QoNGkwKSyMfPPEh8wDijHzIUerR/aXd1t4lrTdsYeRfKmBeETeJ3uezke+b
 6P81nPuh5QzEzpS3nkJSSd5ApygaVnwj8rc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aq1xd2bea-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Aug 2021 13:55:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 13:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWS+Cqew0vJkPD/zYyaP1dP+xPwRMQnk7QG7poAyrbRIfGeDLcICiy4r65RmwiCHSOMQ2rgny8ulLK3b5KmHf/lDy0aXU7SrTPgjRSRlSdgjTNc1yxS7rP4lqejm6zCVSZSzHg8oRMlg2qHYtVDOnR2WyM0hysnWgjyQhWZxXoWuG6+/tYzH8pu8XYqEsAjlkvbB52waZ+cbIIDU33EthkEvFB0IqbTqjTbsv/b59P0VENL3yTdP7Lb0dpZ3w6kZ4oAtq7zM91js6BnzR3BgsaKKxdFObX7RxUGLF390TKae03MHNruGCmjvRKBF2pVjPqJ8lgb8fDtqEwUeSPVibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng+KESeh9piRN0Wxh92AKmAzck6fuJc06o575uPc4ZI=;
 b=mT9FYsW4F3wQOgqEO2xE1pOck1ciEe6vXtB6VkXXm0ixHQ/XLl+TkQjthJlJJazf4qPnjX5k13L+nu30a6uJ9Nl5pcvtunk9/Y21oHAD479eJa8CX8cib2FvhEALMLKClHZsIZaHZ8g/wK6UeTC61voQRuOzZjGz8P3j1wqw0b9CtHkljaWR2/p9gH1Eczfd0U8NeGN2YFi0CnER0NxfXwPu0tJ9cw8QokxrzKWLC2qK9IpAM6fEQ50ElmjsBLm/HLYlSn2RUQnCChSph8V2m+jdhFLa15OUggn9685GFR3FFvM1RQKNy6GjmwUac8Wpxh2KJECVxaHd6Uco6Kv1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4981.namprd15.prod.outlook.com (2603:10b6:806:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 20:55:33 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%7]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 20:55:33 +0000
Date:   Fri, 27 Aug 2021 13:55:30 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
References: <20210826235127.303505-1-kpsingh@kernel.org>
 <20210826235127.303505-2-kpsingh@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210826235127.303505-2-kpsingh@kernel.org>
X-ClientProxiedBy: BY5PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::27) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:d687) by BY5PR17CA0014.namprd17.prod.outlook.com (2603:10b6:a03:1b8::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Fri, 27 Aug 2021 20:55:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03713977-fd49-4306-7bd3-08d9699d02d3
X-MS-TrafficTypeDiagnostic: SA1PR15MB4981:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4981776FF0E6CA7D50CE7365D5C89@SA1PR15MB4981.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAveNl/NB4MWf60qBeUHd7BXDbnVDdmcubCwQ0ZwPjMVkNUMkU8qzvvxpldOgz/5bJLkJkPYX0vLTkG652Cu5yPvSjKcgvIBO32bHfr/pGPSdsY/f9Ll7PD1SxYb9ERO3Ra1u77FX2Vsns+SxVPdAUTULyUaEaDFS/rSXGUotWFI14KtQ+gbr5wQBn6QNI03uqpGs0KyRKxd7b7cOpi0aXWSY0aHjSbsQQGAwtot50ZpSF0AySM0u8m85MZn0s+z+Oms8e2j5yaFKVL+R3sHYrHQLmazNJ138gjiEk3rHNGRsJUtAZmAjUlrwgGvasZfB5G7OJojCneREe9orOd8i8cNWDDVPDIgjywG7DbYZ8Vt6Xs/3hhx3mC8oFlWoLXRLzSc+80J4IlwFZsswIpiockV7suBsYLb7D92VQ3kT72UK7+Mg/RS2mTSVPqtu2zQJrIz9WWvnPyMe16aHtnCcxwZd3GyDlWcxciG4gjBJISeESzaofDMZkjZ95f2GnFy3DnBA+k6atCRciOGdp/sgPmXCgAwYJUvieM6djcfq4HhP+p7quyUnYaOPgpI+ZypG2tq3Hkj3LGi2/X5AOwaYxjXPokWN6fV7V+Kqk6p1UnYdlcdEVZlHRV7NdpkrxX+5AzbddsAecdlK4zjerSXpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(83380400001)(2906002)(316002)(186003)(8936002)(9686003)(55016002)(86362001)(38100700002)(54906003)(6916009)(478600001)(33716001)(52116002)(66946007)(4326008)(6496006)(8676002)(5660300002)(66476007)(66556008)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sP4ZjKK1Lb8QzTXw60EYcAeqJrhP4ZI9roZKISxcwSMeS4FInXs2M8ue5G4P?=
 =?us-ascii?Q?3uaS0n6tBeoyNIsc9GPbNfHvMmrDOheWuyPXUU5FnEV2dVza7u+kXgUEenj3?=
 =?us-ascii?Q?H8bocdpNM7NQnZJyIw/3oZkjPYwZGmGcI1ff8u3VgEIxQZ0RHgJcW0evoeVL?=
 =?us-ascii?Q?gCxFg4Ojgp8Agx+LPcrLZikSL37d9mGN9B7oIjbB33WRucJgxWFRe7gMzw1C?=
 =?us-ascii?Q?K56oT7VFS1rVLRCxHEapxU2C7kS2khADrjARJeOT02YefvuQpe4ja16sGxts?=
 =?us-ascii?Q?5Te5ZPmDr2YWVf7jiU+81FRJZS+HfHrPTCbVz5GeFkxWoy9CveRqpZ9MPL0i?=
 =?us-ascii?Q?7rODZ+hMfuN5My8yyhEYcTmafqU1Q9Y2g7pygQUm3fiXgG2xRQ/GCjEIPkbv?=
 =?us-ascii?Q?j2axuNkZpgT0oygKIwfsAduJ12heIqPN5c1BVhdBZvz4B3+6WzudGicQHVv/?=
 =?us-ascii?Q?7acOJ1Qd7qQxg4r8ZuPDLPFI6h3C87o4TPebwAeApkH0T/Or+eOu2BeKPlyB?=
 =?us-ascii?Q?fLfx4pIvjompuxafKWY3xZjRCB0r0RnMqkw/UvovaHvFGjb5WXqXsJYRqrPn?=
 =?us-ascii?Q?kFT/Z6If34slwPmH+kdfCdMW1fnJsjwkiFU06dJMIz6hp3fLMdxBrOxyAGAc?=
 =?us-ascii?Q?eoglyIRv60MFLYRadTl43WupwbE0GrOL/5A5NWH0VIbFynjGovO+lrw/SmpI?=
 =?us-ascii?Q?B6J9u80PrBiDI+KZlXbBcdbLVw38YfN4Kso3cZAh72Nt08YBeR16xdVdaAHI?=
 =?us-ascii?Q?ONO2erGPJFupJu1p7p6CGcUhau1+bpD7FxropAuITn1VOIAipEKruEpMUolq?=
 =?us-ascii?Q?joHw/9PKH5pQiiuY5kOM+w928Qo/yg58QuDUlxFeos3M2h8tWe3VrQYT+BjD?=
 =?us-ascii?Q?a1+tBkKx5cMuvI7KoB3yf95+ahPnkq/1LSSP5oT1nb0/43eZ352HdDPAAW9L?=
 =?us-ascii?Q?u/6O5G3MCSIK76kqmddxXOfxeTm5icpyOT5spnu7Ag3M9ri9JsCRzvEBjicB?=
 =?us-ascii?Q?2QOPAK2yJDVY71lief0Ve+jMYG2PkPFk4itEfqgW9BH372XqZbBnNFSuVt6n?=
 =?us-ascii?Q?RnBXEHW1l0s0ExbxQhKwu12VVUuaBqfuXsGrXEplCtuB7SMaJd5NKP6XdvXm?=
 =?us-ascii?Q?QXAxBBsXnT52uxZfVyPBtcAP6W8NOP0nQYSeCwtWuw28djZ6KFnGAeCouRnD?=
 =?us-ascii?Q?2DoWUNkLWyWChbu9dZJ4rZrTMqi7Api4A8d4dQRgaVKlp9BhwBDEbA+v2wtg?=
 =?us-ascii?Q?fJzBN3/l8+rSXZvJLO0YKcZW2X0rWtgznb3v0auIxJdV4K3B9sOsbO7S+BEd?=
 =?us-ascii?Q?FlAqmKmXHkwGMPdY8V1VculE8sRantvi3z2FPbLFc8UkEA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03713977-fd49-4306-7bd3-08d9699d02d3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:55:33.1535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWYHqg+wYuQTcHAozJs2wWSeF8zsEdj/G233hReUMfFdfBiEFd7muMidAlfkYdYR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4981
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: l0KBnEeudhkqGp6B-ERxi0yKG4516Gus
X-Proofpoint-GUID: l0KBnEeudhkqGp6B-ERxi0yKG4516Gus
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_06:2021-08-27,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108270123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 26, 2021 at 11:51:26PM +0000, KP Singh wrote:
> Other maps like hashmaps are already available to sleepable programs.
> Sleepable BPF programs run under trace RCU. Allow task, local and inode
> storage to be used from sleepable programs.
> 
> The local storage code mostly runs under the programs RCU read section
> (in __bpf_prog_enter{_sleepable} and __bpf_prog_exit{_sleepable})
> (rcu_read_lock or rcu_read_lock_trace) with the exception the logic
> where the map is freed.
> 
> After some discussions and help from Jann Horn, the following changes
> were made:
> 
> bpf_local_storage{_elem} are freed with a kfree_rcu
> wrapped with a call_rcu_tasks_trace callback instead of a direct
> kfree_rcu which does not respect the trace RCU grace periods. The
> callback frees the storage/selem with kfree_rcu which handles the normal
> RCU grace period similar to BPF trampolines.
> 
> Update the synchronise_rcu to synchronize_rcu_mult in the map freeing
> code to wait for trace RCU and normal RCU grace periods.
> While this is an expensive operation, bpf_local_storage_map_free
> is not called from within a BPF program, rather only called when the
> owning object is being freed.
> 
> Update the dereferencing of the pointers to use rcu_derference_protected
> (with either the trace or normal RCU locks held) and add warnings in the
> beginning of the get and delete helpers.
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_local_storage.h |  5 ++++
>  kernel/bpf/bpf_inode_storage.c    |  9 +++++--
>  kernel/bpf/bpf_local_storage.c    | 43 ++++++++++++++++++++++++-------
>  kernel/bpf/bpf_task_storage.c     |  6 ++++-
>  kernel/bpf/verifier.c             |  3 +++
>  net/core/bpf_sk_storage.c         |  8 +++++-
>  6 files changed, 61 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 24496bc28e7b..8453488b334d 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -16,6 +16,9 @@
>  
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
>  
> +#define bpf_local_storage_rcu_lock_held()			\
> +	(rcu_read_lock_held() || rcu_read_lock_trace_held() ||	\
> +		rcu_read_lock_bh_held())
There is a similar test in hashtab.  May be renaming it to a more
generic name such that it can be reused there?

[ ... ]

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index b305270b7a4b..7760bc4e9565 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -11,6 +11,8 @@
>  #include <net/sock.h>
>  #include <uapi/linux/sock_diag.h>
>  #include <uapi/linux/btf.h>
> +#include <linux/rcupdate_trace.h>
> +#include <linux/rcupdate_wait.h>
>  
>  #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
>  
> @@ -81,6 +83,22 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>  	return NULL;
>  }
>  
> +void bpf_local_storage_free_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_local_storage *local_storage;
> +
> +	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
> +	kfree_rcu(local_storage, rcu);
> +}
> +
> +static void bpf_selem_free_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_local_storage_elem *selem;
> +
> +	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> +	kfree_rcu(selem, rcu);
> +}
> +
>  /* local_storage->lock must be held and selem->local_storage == local_storage.
>   * The caller must ensure selem->smap is still valid to be
>   * dereferenced for its smap->elem_size and smap->cache_idx.
> @@ -118,12 +136,12 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
>  		 *
>  		 * Although the unlock will be done under
>  		 * rcu_read_lock(),  it is more intutivie to
> -		 * read if kfree_rcu(local_storage, rcu) is done
> +		 * read if the freeing of the storage is done
>  		 * after the raw_spin_unlock_bh(&local_storage->lock).
>  		 *
>  		 * Hence, a "bool free_local_storage" is returned
> -		 * to the caller which then calls the kfree_rcu()
> -		 * after unlock.
> +		 * to the caller which then calls then frees the storage after
> +		 * all the RCU grace periods have expired.
>  		 */
>  	}
>  	hlist_del_init_rcu(&selem->snode);
> @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
>  	    SDATA(selem))
>  		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
>  
> -	kfree_rcu(selem, rcu);
> +	call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
Although the common use case is usually storage_get() much more often
than storage_delete(), do you aware any performance impact for
the bpf prog that does a lot of storage_delete()?

>  
>  	return free_local_storage;
>  }
> @@ -154,7 +172,8 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
>  	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>  
>  	if (free_local_storage)
> -		kfree_rcu(local_storage, rcu);
> +		call_rcu_tasks_trace(&local_storage->rcu,
> +				     bpf_local_storage_free_rcu);
>  }
>  
>  void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
> @@ -213,7 +232,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
>  	struct bpf_local_storage_elem *selem;
>  
>  	/* Fast path (cache hit) */
> -	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
> +	sdata = rcu_dereference_protected(local_storage->cache[smap->cache_idx],
> +					  bpf_local_storage_rcu_lock_held());
There are other places using rcu_dereference() also.
e.g. in bpf_local_storage_update().
Should they be changed also?

[ ... ]

> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -13,6 +13,7 @@
>  #include <net/sock.h>
>  #include <uapi/linux/sock_diag.h>
>  #include <uapi/linux/btf.h>
> +#include <linux/rcupdate_trace.h>
>  
>  DEFINE_BPF_STORAGE_CACHE(sk_cache);
>  
> @@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
>  	struct bpf_local_storage *sk_storage;
>  	struct bpf_local_storage_map *smap;
>  
> -	sk_storage = rcu_dereference(sk->sk_bpf_storage);
> +	sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
> +					       bpf_local_storage_rcu_lock_held());
>  	if (!sk_storage)
>  		return NULL;
>  
> @@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
>  {
>  	struct bpf_local_storage_data *sdata;
>  
> +	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
>  	if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
sk is protected by rcu_read_lock here.
Is it always safe to access it with the rcu_read_lock_trace alone ?

>  		return (unsigned long)NULL;
>  
