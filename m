Return-Path: <bpf+bounces-15730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB907F583B
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 07:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA88B21024
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C8F9F0;
	Thu, 23 Nov 2023 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpHsX4Ix"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51773A2;
	Wed, 22 Nov 2023 22:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700721152; x=1732257152;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rY/TBxnNGUbD9+yFwuL9Z437C7emu75hU1E4ZvjYwlQ=;
  b=YpHsX4Ixn0piYabmN7Rn/qZSFAUUjG1A8nAiELjZ2PIlpDcvZAnbAO7D
   xzqc9K4b7Jgsnw7ux12KzWZ5eE5ykreV0qeZDv/A0tTSDY8R2F4U8NBhs
   wJc/zyLEH/Z8GPcRGIwIigbLpHexKk0WuqZ8BTvdZFPoqGmDa6JCUkhSg
   lCPDYcNCLztb0qIP6QbtNMXxl3qRKzOmopFjHh+FZmXdG7VFiukWTQHVs
   Ot36o+Md9tgZzOIqRYI95KYrzWjcTHeuo+t7M7oV94Dagq8SjjM/blsb1
   fjKVU6hD5isuK/3zS0OkIsqBXPgb20UJdH3ieFKqbruCwmp2cF6BRWmls
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382607301"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="382607301"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:32:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="858029742"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="858029742"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:32:28 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org,  paul@paul-moore.com,  jmorris@namei.org,
  serge@hallyn.com,  omosnace@redhat.com,  mhocko@suse.com,
  linux-mm@kvack.org,  linux-security-module@vger.kernel.org,
  bpf@vger.kernel.org,  ligang.bdlg@bytedance.com,  Eric Dumazet
 <edumazet@google.com>
Subject: Re: [RFC PATCH v2 2/6] mm: mempolicy: Revise comment regarding
 mempolicy mode flags
In-Reply-To: <20231122141559.4228-3-laoar.shao@gmail.com> (Yafang Shao's
	message of "Wed, 22 Nov 2023 14:15:55 +0000")
References: <20231122141559.4228-1-laoar.shao@gmail.com>
	<20231122141559.4228-3-laoar.shao@gmail.com>
Date: Thu, 23 Nov 2023 14:30:28 +0800
Message-ID: <87il5t7zi3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yafang Shao <laoar.shao@gmail.com> writes:

> MPOL_F_STATIC_NODES, MPOL_F_RELATIVE_NODES, and MPOL_F_NUMA_BALANCING are
> mode flags applicable to both set_mempolicy(2) and mbind(2) system calls.
> It's worth noting that MPOL_F_NUMA_BALANCING was initially introduced in
> commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
> nodes") exclusively for set_mempolicy(2). However, it was later made a
> shared flag for both set_mempolicy(2) and mbind(2) following
> commit 6d2aec9e123b ("mm/mempolicy: do not allow illegal
> MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()").
>
> This revised version aims to clarify the details regarding the mode flags.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>

Thanks for fixing this.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

And, please revise the manpage for mbind() too.  As we have done for
set_mempolicy(),

https://lore.kernel.org/all/20210120061235.148637-3-ying.huang@intel.com/

--
Best Regards,
Huang, Ying

> ---
>  include/uapi/linux/mempolicy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index a8963f7ef4c2..afed4a45f5b9 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -26,7 +26,7 @@ enum {
>  	MPOL_MAX,	/* always last member of enum */
>  };
>  
> -/* Flags for set_mempolicy */
> +/* Flags for set_mempolicy() or mbind() */
>  #define MPOL_F_STATIC_NODES	(1 << 15)
>  #define MPOL_F_RELATIVE_NODES	(1 << 14)
>  #define MPOL_F_NUMA_BALANCING	(1 << 13) /* Optimize with NUMA balancing if possible */

