Return-Path: <bpf+bounces-9772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C579D726
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03ADB1C20F34
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B272539A;
	Tue, 12 Sep 2023 17:04:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B31C04;
	Tue, 12 Sep 2023 17:04:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5631E10D9;
	Tue, 12 Sep 2023 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694538294; x=1726074294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EIqefRvU8NKd2SxAZ0En1TxLIImgpYvWreFE+T0fKaQ=;
  b=ei8HamJAvr/mN5qpjW6y5rUxUKWDgJJSesZpJDUB0FBEG8GjOURAnfJx
   DjWzkQrPEJI0FtWc7Bf4hIwAIGfdclP+WlAlsTNc54xjq2A0NeMcMqH7Q
   nsh+TwGs9kdqCzbiu0f3xfauBs+09Q0TuQGFzurRo9P21nIwfLRgSFYgJ
   ApAyx7j2Gbh9uiP4GNm1rR3EMyN3ofaBHVxSqTOfkCpIK6s83I6DbQ5pc
   68xNwCNmk3E06XcOKJgE9juATXz4ud2HkCZd/AMyVtJxVyqQzV3rfuMlJ
   sxfTNXX2+B3Z+PBe0RZmyV4c5tBmOGrzkuopyscbo9H/m3OK8hCmDyuN5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381138467"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381138467"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693565253"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="693565253"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:04:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qg6oi-008dnj-32;
	Tue, 12 Sep 2023 20:04:48 +0300
Date: Tue, 12 Sep 2023 20:04:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
Message-ID: <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
 <20230912152031.GI401982@kernel.org>
 <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
 <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 12, 2023 at 06:53:23PM +0200, Paolo Abeni wrote:
> On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:
> > On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> > > On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> > > > It's rather a gigantic list of heards that is very hard to follow.
> > > > Sorting helps to see what's already included and what's not.
> > > > It improves a maintainability in a long term.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Hi Andy,
> > > 
> > > At the risk of bike shedding, the sort function of Vim, when operating
> > > with the C locale, gives a slightly different order, as experssed by
> > > this incremental diff.
> > > 
> > > I have no objections to your oder, but I'm slightly curious as
> > > to how it came about.
> > 
> > !sort which is external command.
> > 
> > $ locale -k LC_COLLATE
> > collate-nrules=4
> > collate-rulesets=""
> > collate-symb-hash-sizemb=1303
> > collate-codeset="UTF-8"
> 
> I'm unsure this change is worthy. It will make any later fix touching
> the header list more difficult to backport, and I don't see a great
> direct advantage.

As Rasmus put it here
https://lore.kernel.org/lkml/5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusvillemoes.dk/
In short term you can argue that it's not beneficial, but in long term it's given
less conflicts.

> Please repost the first patch standalone.

Why to repost, what did I miss? It's available via lore, just run

  b4 am -slt -P _ 20230911154534.4174265-1-andriy.shevchenko@linux.intel.com

to get it :-)

-- 
With Best Regards,
Andy Shevchenko



