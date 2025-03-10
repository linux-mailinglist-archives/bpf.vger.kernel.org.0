Return-Path: <bpf+bounces-53722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2082AA593EB
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 13:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5717116E1ED
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A522AE59;
	Mon, 10 Mar 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uc2kSMaJ"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DC22A7E0;
	Mon, 10 Mar 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608697; cv=none; b=FBMkM1xrxk1cEX3oGM67Hm0i6leNRaPbmm3rymIoNqKYEjJ31Zgpug1FlXqqqFJG2sBlZvEe7SOdPx7lFMHDoq4fHFbZCgFwDRE/oQVIdw3owBoaqW5YcIy+6VdrSOWBDht0EZ0nTNf3ZnGF205HFype8DZLDcU9XthaPy0SaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608697; c=relaxed/simple;
	bh=B/Zi8tRRc/t7099IxweCQ9wmr8LBRpEjxc54n0VCEzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHt6UeBru2JrCUHnZyT3FNnyt3RobX7MyTLgCnGeqvuzb47VIq6YmqDNJ4S/rFfw2f7Gyg2SENTXCHJDrMGoZ8zxMeIg6BLutB6arQkbYEunhlk45VB3YABLh8+Cppg0PO5Vwe3LZLpVQjGMlGhK5ogtIf5JGBRCvgAKf3bKIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uc2kSMaJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id BAD8B2111421; Mon, 10 Mar 2025 05:11:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAD8B2111421
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741608694;
	bh=wGlVDMVI7jB0uTeQswp0J7PSuFA8+H1jZy79IJtAwJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uc2kSMaJZ2d9mRqMGI9uVePTC1T6zyoq47PuXm1KAkLHEGlSFLadmxyf4t7EhXYgc
	 qJPXVqjZQYPIo2xrAnGCsPXWyKYE9mxrGdN9iUPi4kEpIJvw3IuVpiQ2eLOYX89j/w
	 NaqXKPle32JCMKpmqeqjhSGIpPlBxgMUGEnOafQU=
Date: Mon, 10 Mar 2025 05:11:34 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	KY Srinivasan <kys@microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"leon@kernel.org" <leon@kernel.org>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net] net: mana: Support holes in device
 list reply msg
Message-ID: <20250310121134.GA12177@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741211181-6990-1-git-send-email-haiyangz@microsoft.com>
 <20250307195029.1dc74f8e@kernel.org>
 <MN0PR21MB3437F80F3AD98C82870A9173CAD72@MN0PR21MB3437.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB3437F80F3AD98C82870A9173CAD72@MN0PR21MB3437.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Mar 09, 2025 at 10:01:33PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Friday, March 7, 2025 10:50 PM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> > <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> > <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> > olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> > wei.liu@kernel.org; edumazet@google.com; pabeni@redhat.com;
> > leon@kernel.org; Long Li <longli@microsoft.com>;
> > ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> > daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> > ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> > shradhagupta@linux.microsoft.com; linux-kernel@vger.kernel.org;
> > stable@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH net] net: mana: Support holes in device
> > list reply msg
> > 
> > On Wed,  5 Mar 2025 13:46:21 -0800 Haiyang Zhang wrote:
> > > -	for (i = 0; i < max_num_devs; i++) {
> > > +	for (i = 0; i < GDMA_DEV_LIST_SIZE &&
> > > +		found_dev < resp.num_of_devs; i++) {
> > 
> > unfortunate mis-indent here, it blend with the code.
> > checkpatch is right that it should be aligned with opening bracket
> Will fix it.
> 
> > 
> > >  		dev = resp.devs[i];
> > >  		dev_type = dev.type;
> > >
> > > +		/* Skip empty devices */
> > > +		if (dev.as_uint32 == 0)
> > > +			continue;
> > > +
> > > +		found_dev++;
> > > +		dev_info(gc->dev, "Got devidx:%u, type:%u, instance:%u\n", i,
> > > +			 dev.type, dev.instance);
> > 
> > Are you sure you want to print this info message for each device,
> > each time it's probed? Seems pretty noisy. We generally recommend
> > printing about _unusual_ things.
> Ok. I can remove it.
How about a dev_dbg instead?
> 
> Thanks,
> - Haiyang

