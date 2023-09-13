Return-Path: <bpf+bounces-9898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A879E5F7
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DA41C214D5
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B41E500;
	Wed, 13 Sep 2023 11:10:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D51E52A;
	Wed, 13 Sep 2023 11:10:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7619A6;
	Wed, 13 Sep 2023 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694603428; x=1726139428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uqF9R+6e0mdQgOwFpYVrH+65K7xWTsBoK2ERwBn9lEo=;
  b=DqUL5wJ9hV7rl9CYxi2lVdXWWur+r4l7lxNAc8+5mzcaH6DhhN0T4ST9
   hOgqEf4J3wNBU7XseuaUQhvCld3wXjPBI/Sl4Ax7kbXYVxSHNKd8FCumP
   l0k8zI5d/yS4Eak3hY87ji5Hv6vcfxArjgUeZ7esB9NQ0iQuly/N8CMy8
   SRpenCvCsS+FKuKG4LLCeFT1QjGXk1uNIm6N+MgemBqzxDzf6gK7ruxHZ
   6PqLZqRaNdwGbeFjivYfMc9vi75SmmqTos9lE6i88WIIMhD3F4Uhem9eV
   q/W0f6AJGJTLfi/OrAtNvxFhxXHDbBiqNp1IxjKSaavW+s4/iI7jVVe3R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358899721"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="358899721"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809639357"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="809639357"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:10:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qgNlH-008qY6-13;
	Wed, 13 Sep 2023 14:10:23 +0300
Date: Wed, 13 Sep 2023 14:10:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
Message-ID: <ZQGYnoHt8PAT23A4@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
 <20230912152031.GI401982@kernel.org>
 <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
 <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
 <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
 <32a8715a63b686aa0ac19fdae22b5d605d47ae35.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a8715a63b686aa0ac19fdae22b5d605d47ae35.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 12, 2023 at 07:25:48PM +0200, Paolo Abeni wrote:
> On Tue, 2023-09-12 at 20:04 +0300, Andy Shevchenko wrote:
> > On Tue, Sep 12, 2023 at 06:53:23PM +0200, Paolo Abeni wrote:
> > > On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:

...

> > > Please repost the first patch standalone.
> > 
> > Why to repost, what did I miss? It's available via lore, just run
> > 
> >   b4 am -slt -P _ 20230911154534.4174265-1-andriy.shevchenko@linux.intel.com
> > 
> > to get it :-)
> 
> It's fairly better if actions (changes) on patches are taken by the
> submitter: it scales way better, and if the other path take places we
> can be easily flooded with small (but likely increasingly less smaller)
> requests that will soon prevent any other activity from being taken.
> 
> Please, repost the single patch, it would be easier to me.

Done.

-- 
With Best Regards,
Andy Shevchenko



