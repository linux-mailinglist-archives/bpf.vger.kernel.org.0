Return-Path: <bpf+bounces-15732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D07F586E
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 07:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1341B1C20CD5
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 06:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C711CBA;
	Thu, 23 Nov 2023 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E54Rc0DF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F50C1;
	Wed, 22 Nov 2023 22:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700721590; x=1732257590;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sNJFJlh3rji6zudwDz3TzUsgtizbU6T+kzRcilJIPLk=;
  b=E54Rc0DFgbn8lGZBk7GcFCC/uTQwbxLXJZsxCdmW0d8f33+D3X3vtVp6
   5OAMwdEL4j4DOxKKsqfo3cwilBln7Q/sP8vx/4TwSGBPJgCgjLsnPJ04a
   hZUDQcGFnq6ZSGaq1AQnyBces4YVadcgmh70jwrCyJYvO8QtoEbQPkJEe
   YpCZSMll0NfIFAEGq6BNN8VJTACFhjKifRgqEzBlC+TR60SjsGELqTrqT
   /tE52A0cEk5iq+iYnZRPM9fJhSHdUFIWzp4E0BuOXwyChFxrqaZpTnaP1
   dNjHuEAt8C1wJUshSz5JGTMuvbPdODTkiAPv56LCh0T7FC4tG9A2JhTRz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456542538"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="456542538"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="8751510"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:39:47 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org,  paul@paul-moore.com,  jmorris@namei.org,
  serge@hallyn.com,  omosnace@redhat.com,  mhocko@suse.com,
  linux-mm@kvack.org,  linux-security-module@vger.kernel.org,
  bpf@vger.kernel.org,  ligang.bdlg@bytedance.com
Subject: Re: [RFC PATCH v2 1/6] mm, doc: Add doc for MPOL_F_NUMA_BALANCING
In-Reply-To: <20231122141559.4228-2-laoar.shao@gmail.com> (Yafang Shao's
	message of "Wed, 22 Nov 2023 14:15:54 +0000")
References: <20231122141559.4228-1-laoar.shao@gmail.com>
	<20231122141559.4228-2-laoar.shao@gmail.com>
Date: Thu, 23 Nov 2023 14:37:45 +0800
Message-ID: <87edgh7z5y.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yafang Shao <laoar.shao@gmail.com> writes:

> The document on MPOL_F_NUMA_BALANCING was missed in the initial commit
> The MPOL_F_NUMA_BALANCING document was inadvertently omitted from the
> initial commit bda420b98505 ("numa balancing: migrate on fault among
> multiple bound nodes")
>
> Let's ensure its inclusion.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  .../admin-guide/mm/numa_memory_policy.rst     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index eca38fa81e0f..19071b71979c 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -332,6 +332,33 @@ MPOL_F_RELATIVE_NODES
>  	MPOL_PREFERRED policies that were created with an empty nodemask
>  	(local allocation).
>  
> +MPOL_F_NUMA_BALANCING (since Linux 5.12)
> +        When operating in MPOL_BIND mode, enables NUMA balancing for tasks,
> +        contingent upon kernel support. This feature optimizes page
> +        placement within the confines of the specified memory binding
> +        policy. The addition of the MPOL_F_NUMA_BALANCING flag augments the
> +        control mechanism for NUMA balancing:
> +
> +        - The sysctl knob numa_balancing governs global activation or
> +          deactivation of NUMA balancing.
> +
> +        - Even if sysctl numa_balancing is enabled, NUMA balancing remains
> +          disabled by default for memory areas or applications utilizing
> +          explicit memory policies.
> +
> +        - The MPOL_F_NUMA_BALANCING flag facilitates NUMA balancing
> +          activation for applications employing explicit memory policies
> +          (MPOL_BIND).
> +
> +        This flags enables various optimizations for page placement through
> +        NUMA balancing. For instance, when an application's memory is bound
> +        to multiple nodes (MPOL_BIND), the hint page fault handler attempts
> +        to migrate accessed pages to reduce cross-node access if the
> +        accessing node aligns with the policy nodemask.
> +
> +        If the flag isn't supported by the kernel, or is used with mode
> +        other than MPOL_BIND, -1 is returned and errno is set to EINVAL.
> +
>  Memory Policy Reference Counting
>  ================================

--
Best Regards,
Huang, Ying

