Return-Path: <bpf+bounces-9776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A979D775
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B09281F01
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3218F67;
	Tue, 12 Sep 2023 17:22:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BE33E9;
	Tue, 12 Sep 2023 17:22:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7754B10EB;
	Tue, 12 Sep 2023 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694539339; x=1726075339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n5o2BGwm5d37hkTfdXWX46j/uvchHMbw7aE25EhJnpc=;
  b=cxhXC1Aa9JcLv1/OCH1APeTO+0fMvhLoaYcTnqupx5GrOJui62OdUMcC
   u+IFrq1WwsRjFa+2R8LDpwzXiXtRHYoPiKHhCztkDhy2B7WRYJXp2Qyho
   OCrvTQ3Cvhzuwbc4/dKgvxo6COUqLbe6evAkjGL2a+TqOxyO5Ab4M3ZeF
   9X5bwfaT//Ql6TrjQ1InDtuwKGH58sngKtAF1JFD7LTd0hR2Q5CfaTssl
   FIcnNRDWfJl+aAlfnyFPKhtIc32vPwFWI+POe1qpTvYpE7lXYK3nRrBse
   060IOBmFR8yd9hI2vkqEeYu9XlRZDCX9h7q1jdOB/O0VSxKy3DHAM2f+Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357874641"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="357874641"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="813920768"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="813920768"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:22:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qg75Q-008e4I-2e;
	Tue, 12 Sep 2023 20:22:04 +0300
Date: Tue, 12 Sep 2023 20:22:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
Message-ID: <ZQCePNVobAeCVUjI@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
 <20230912152031.GI401982@kernel.org>
 <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
 <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
 <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
 <CAADnVQLk4JRKXoNA6h=hd25bmCuVP=DM0yRswM0a=wgKuYbdhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLk4JRKXoNA6h=hd25bmCuVP=DM0yRswM0a=wgKuYbdhA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 12, 2023 at 10:07:35AM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 12, 2023 at 10:05 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 12, 2023 at 06:53:23PM +0200, Paolo Abeni wrote:
> > > On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:
> > > > On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> > > > > On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:

...

> > > I'm unsure this change is worthy. It will make any later fix touching
> > > the header list more difficult to backport, and I don't see a great
> > > direct advantage.
> >
> > As Rasmus put it here
> > https://lore.kernel.org/lkml/5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusvillemoes.dk/
> > In short term you can argue that it's not beneficial, but in long term it's given
> > less conflicts.
> 
> I agree with Paolo.

I see.

> This is just code churn.
> The includes will become unsorted eventually.
> Headers might get renamed, split, etc.
> Keeping things sorted is a headache.

Keeping the mess is simpler, I agree. :-(

-- 
With Best Regards,
Andy Shevchenko



