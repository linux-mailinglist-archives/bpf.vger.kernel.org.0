Return-Path: <bpf+bounces-16467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F168014D1
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77EB2B21149
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A658AA0;
	Fri,  1 Dec 2023 20:50:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0610D;
	Fri,  1 Dec 2023 12:50:41 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id F317B788; Fri,  1 Dec 2023 14:50:39 -0600 (CST)
Date: Fri, 1 Dec 2023 14:50:39 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, omosnace@redhat.com, mhocko@suse.com,
	ying.huang@intel.com, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com
Subject: Re: [PATCH v3 3/7] mm, security: Fix missed
 security_task_movememory()
Message-ID: <20231201205039.GB109168@mail.hallyn.com>
References: <20231201094636.19770-1-laoar.shao@gmail.com>
 <20231201094636.19770-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201094636.19770-4-laoar.shao@gmail.com>

On Fri, Dec 01, 2023 at 09:46:32AM +0000, Yafang Shao wrote:
> Considering that MPOL_F_NUMA_BALANCING or  mbind(2) using either
> MPOL_MF_MOVE or MPOL_MF_MOVE_ALL are capable of memory movement, it's
> essential to include security_task_movememory() to cover this
> functionality as well. It was identified during a code review.

Hm - this doesn't have any bad side effects for you when using selinux?
The selinux_task_movememory() hook checks for PROCESS__SETSCHED privs.
The two existing security_task_movememory() calls are in cases where we
expect the caller to be affecting another task identified by pid, so
that makes sense.  Is an MPOL_MV_MOVE to move your own pages actually
analogous to that?

Much like the concern you mentioned in your intro about requiring
CAP_SYS_NICE and thereby expanding its use, it seems that here you
will be regressing some mbind users unless the granting of PROCESS__SETSCHED
is widened.

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/mempolicy.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10a590ee1c89..1eafe81d782e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1259,8 +1259,15 @@ static long do_mbind(unsigned long start, unsigned long len,
>  	if (!new)
>  		flags |= MPOL_MF_DISCONTIG_OK;
>  
> -	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
> +	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {

MPOL_MF_MOVE_ALL already has a CAP_SYS_NICE check.  Does that
suffice for that one?

> +		err = security_task_movememory(current);
> +		if (err) {
> +			mpol_put(new);
> +			return err;
> +		}
>  		lru_cache_disable();
> +	}
> +
>  	{
>  		NODEMASK_SCRATCH(scratch);
>  		if (scratch) {
> @@ -1450,6 +1457,8 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
>  /* Basic parameter sanity check used by both mbind() and set_mempolicy() */
>  static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>  {
> +	int err;
> +
>  	*flags = *mode & MPOL_MODE_FLAGS;
>  	*mode &= ~MPOL_MODE_FLAGS;
>  
> @@ -1460,6 +1469,9 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>  	if (*flags & MPOL_F_NUMA_BALANCING) {
>  		if (*mode != MPOL_BIND)
>  			return -EINVAL;
> +		err = security_task_movememory(current);
> +		if (err)
> +			return err;
>  		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
>  	}
>  	return 0;
> -- 
> 2.30.1 (Apple Git-130)

