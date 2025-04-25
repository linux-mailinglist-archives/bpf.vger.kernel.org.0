Return-Path: <bpf+bounces-56706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC8A9CE66
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FB417CA63
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFAE1A3A8A;
	Fri, 25 Apr 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kLEeiQJI"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C11A3152
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599275; cv=none; b=Y6Y+Z8eKLJqoL5t1fimByxjDBHqY1v/yB2ninRRGIcM8jNPVd66aQYCLFiHwmkVujhcei2KTIZZcYpVZsTNsmtk5S5DEXcFdcv5YfniYVNiNB/ME/mhqoWbaZSO/D8z6VBUanmlFeIiyFQ1oRQ+u3fJfaPp5WA+zuzTgTzd+TyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599275; c=relaxed/simple;
	bh=vethVVunbe1Q5SQCylYzutdqWco+Ngv8Xi7v6r+iMZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctLkv0vsVMlKPfO/z+f/eTBbPrRvsUQgPQjuVpNn2CvlyYw/CjnS6CfuldD+6AkoWq88gqFJkC9xVC/5qWcEdldNg4aSr6d51ddFlPXSnLV1hWxtNX5Pl84TTmo0AMSNrGqyvGH/Z+/nzWHOPWC/d2Lx2/aKXH0iShB/nCiUFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kLEeiQJI; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <81fc481c-5421-42ad-a13a-b9e9c6ededb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745599258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHSrpe12Y1pxiw8ELGseS+nSJC0BYehyKGWYkJrVVkU=;
	b=kLEeiQJI+lSVpNE+MujsvDmdOvFr+GTsmzeNP/ArvocV6l9t6cL8/aSF2dIfE2+q+ou+Cs
	x9TRK1jwO9Iouhdtqu4fUk+7tfOU5SJ7DWlS2Qj39um3BiI7NEow+q4+KhM106ur7WHTdc
	zDCqpaWIIDBxHfq3Dn+4NyvM2+5YDQ4=
Date: Fri, 25 Apr 2025 09:40:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
To: Jordan Rife <jordan@jrife.io>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20250423235115.1885611-1-jordan@jrife.io>
 <20250423235115.1885611-3-jordan@jrife.io>
 <CAADnVQLTJt5zxuuuF9WZBd9Ui8r0ixvo37ohySX8X9U4kk9XbA@mail.gmail.com>
 <kjcasjtjil6br6qton7uz52ql25udddmzbraaw6qmjadbqj5xm@3o5c2rgdt5bt>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <kjcasjtjil6br6qton7uz52ql25udddmzbraaw6qmjadbqj5xm@3o5c2rgdt5bt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 8:39 AM, Jordan Rife wrote:
>> It looks like overdesign.
>> I think it would be much simpler to do GFP_USER once,
> 
> Martin expressed a preference for retrying GFP_USER, so I'll let him
> chime in here, but I'm fine the simpler approach. There were some
> concerns about maximizing the chances that allocation succeeds, but
> this situation should be be rare anyway, so yeah retries are probably
> overkill.

No strong opinion on how many retries on GFP_USER, so no objection on trying 
GFP_USER only once and then retry one last time with GFP_NOWAIT|__GFP_NOWARN.

> 
>> grab the lock and follow with GFP_NOWAIT|__GFP_NOWARN.
>> GFP_ATOMIC will deplete memory reserves.
>> bpf iterator is certainly not a critical operation, so use GFP_NOWAIT.
> 
> Yeah, GFP_NOWAIT makes sense. Will do.
> 
> Jordan


