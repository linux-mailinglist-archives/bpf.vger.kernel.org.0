Return-Path: <bpf+bounces-9768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D879D66D
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 18:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05757281E88
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AD380E;
	Tue, 12 Sep 2023 16:35:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23A38E;
	Tue, 12 Sep 2023 16:35:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2ECF;
	Tue, 12 Sep 2023 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694536548; x=1726072548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59Kay4eKd19BWWzORZ2XFuirPpkJIuD3bk1Rj8gXqp4=;
  b=iqhAZDajut2U876U1gjkJfaTGVggzgwyq2N1jesK9KkZ/RCVsYFcXztD
   xkuyzp/FKAb3pU8LGuhSYxQsOvpMyXD0xsQFwYd9rqREslO0tC8jRbojs
   gxCJ7/F0+Hhm+gWGsPd4Uy8h+SzcxjfUfhOBgW8slwNzAcbiW/+SjEbHU
   KIxtdVxq4/WPLHt37kJdR4tNeR3CpDdw1Dt5ldsePGKSj0CaEAHUqC846
   9HRUBG1/djlhO9kwksWQ2BSWqBcxwwVaNYcjDSzzLIMBKxLLoXZmYZSiA
   g9fbo0KtW3S6V88GMEcelxccmsDZ9UQ4iS+/LDA3TazsthgfEJsUfYaQQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409381349"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="409381349"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:35:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737175502"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="737175502"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:35:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qg6MY-008dN3-32;
	Tue, 12 Sep 2023 19:35:42 +0300
Date: Tue, 12 Sep 2023 19:35:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
Message-ID: <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
 <20230912152031.GI401982@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912152031.GI401982@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> > It's rather a gigantic list of heards that is very hard to follow.
> > Sorting helps to see what's already included and what's not.
> > It improves a maintainability in a long term.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Hi Andy,
> 
> At the risk of bike shedding, the sort function of Vim, when operating
> with the C locale, gives a slightly different order, as experssed by
> this incremental diff.
> 
> I have no objections to your oder, but I'm slightly curious as
> to how it came about.

!sort which is external command.

$ locale -k LC_COLLATE
collate-nrules=4
collate-rulesets=""
collate-symb-hash-sizemb=1303
collate-codeset="UTF-8"

-- 
With Best Regards,
Andy Shevchenko



