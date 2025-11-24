Return-Path: <bpf+bounces-75333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5521C80430
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 12:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79E0634205D
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D02FE066;
	Mon, 24 Nov 2025 11:49:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307A277CB8
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984949; cv=none; b=Ya7GXAXxfiPmstujtqIbtgdEO9GpR1wZDSHnkMXJRSEIEw/VZE4tepRZ2IGhxOuN1GGFgfwpgoEgMzUVErq7rgqeLPjTz/y0fZcBGYGnW9YfUrOXZZGVdbIhrruOhKOWQSEeUGPtC04zzkAZMzzpv4PzHXRr3VN0LAvNm/9F6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984949; c=relaxed/simple;
	bh=fCvI/sbr3HiiVYD7jXTWnz1g7VtjButbOYRMtM6WBIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpJkIO6PD+Sjbvz+Q5MWjM8PhQNh87JzLa0LCqMBzPuEZPmOrp+nD6vOA2EVLVB/vHygo71ev8tfbwlHu3tZkwHBU+cjsegmCTlfhf2fWtTti5AGgO85hZIWdTiJkMsG3la9BhhO+bpJoMiSbQ0Q4KgxKj3xeTF1C36Xg77St4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (bharat.asicdesigners.com [10.193.191.68])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 5AOBmhPo018745;
	Mon, 24 Nov 2025 03:48:44 -0800
Date: Mon, 24 Nov 2025 17:18:42 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and
 CONFIG_CHELSIO_T4=y (was CONFIG_KCSAN)
Message-ID: <aSRGGmN0bAC2rQDW@chelsio.com>
References: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
 <d296ec97-933a-4b19-aa75-714e69b3ac4f@oracle.com>
 <7161e3e3-7bd0-47ec-892d-72a58b06df33@acm.org>
 <87641066-a837-41ff-acbc-9f4453d0ae58@oracle.com>
 <b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com>
 <aR9YasvOhnSI564i@chelsio.com>
 <bc54daab-3b01-4a25-8032-52a123fa823f@oracle.com>
 <452a2c4c-e9eb-40a0-922b-a1b99048ee08@acm.org>
 <b427abf4-9bba-4ecd-b3a2-dcb220d51f98@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b427abf4-9bba-4ecd-b3a2-dcb220d51f98@oracle.com>

On Friday, November 11/21/25, 2025 at 23:45:03 +0530, Alan Maguire wrote:
> On 21/11/2025 17:22, Bart Van Assche wrote:
> > On 11/20/25 2:18 PM, Alan Maguire wrote:
> >> FYI I verified that changing sched_class to ch_sched_class like the
> >> following resolves the build issue:
> > 
> > Since the Chelsio cxgb4 maintainer has not yet responded, how about
> > posting these changes as a formal patch? If this change is posted as
> > a formal patch, feel free to add:
> > 
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > 
> 
> Sure, sent [1]. Thanks!
> 
> Alan
> 
> [1]
> https://lore.kernel.org/netdev/20251121181231.64337-1-alan.maguire@oracle.com/
>

Sorry for the delayed response, I did try with latest gcc, pahole and the 
required kconfig options enabled but i didnt see the reported issue. Compile just 
ran fine. I am probably missing some other config option.

# gcc --version
gcc (GCC) 14.3.0
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# pahole --version
v1.31

Anyways, I am okay with the proposed patch. Thanks!
> > Thanks,
> > 
> > Bart.
> 

