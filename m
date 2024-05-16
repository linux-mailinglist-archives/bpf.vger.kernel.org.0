Return-Path: <bpf+bounces-29883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2C8C7F07
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F451C21CDB
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4022C6BB;
	Thu, 16 May 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N84Tt+Mw"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10539AEA
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715903116; cv=none; b=kx9TmeC86KaWDBF76b2Y51KNSzJYbteDfv1lUT+iBWYSHy9ttTkAMUPxd08mPDYJ67Vxb+j2g+8lP9D1IMKzo2MFnQvqVITECelM0HFJe5bJpZq7ww5UtSESOkjP3Odk8C9QT2ixymChsVtGv3vWIeJPeG20cLQs9wxFgnShVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715903116; c=relaxed/simple;
	bh=TSJi9b30LawXWCPkojmLISujI7fTBLvMOHdpTKGPhA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEhcs/g6tyNIkVca83+y2TEVhBglTqbyazGmZXSWscLtYltO3rdLs7FqnhHdj+QkWhkHcCVMEQY9GVPrrXo8TxLoONwAJHDv8V5cLEKT83x1ohb1boPUMpPA+FLGzJQzMXVh7nUi4bXQfuoGNz2nk03vdbfXJHyO4Nf6XOdsTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N84Tt+Mw; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ameryhung@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715903111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MKHvYGBz+hZzXa57a9JgopriJpjeGaV2aKd8zp2KQ6M=;
	b=N84Tt+MwfmffeSq6iY/5QvvXFtL82mK1Qd+/9AT4sRjWLSiRoaqZJh5+QeC5WZAuwC2CQi
	079gcdR4MVXDj0YPgOf7TkitpGiaVOTVulo/KsOXlWRhiuJIghELfIFjlrs+rE9v+Iyt6i
	yTcTMjP2jrgo4RqhVCW7/Pkg0iGHe08=
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: yangpeihao@sjtu.edu.cn
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: toke@redhat.com
X-Envelope-To: jhs@mojatatu.com
X-Envelope-To: jiri@resnulli.us
X-Envelope-To: sdf@google.com
X-Envelope-To: xiyou.wangcong@gmail.com
X-Envelope-To: yepeilin.cs@gmail.com
Message-ID: <184079b1-1ad0-414d-b8ff-179b5525c439@linux.dev>
Date: Thu, 16 May 2024 16:43:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v8 02/20] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Amery Hung <ameryhung@gmail.com>, Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-3-amery.hung@bytedance.com>
 <b2486867-0fee-4972-ad71-7b54e8a5d2b6@gmail.com>
 <CAMB2axN3XwSmvk2eC9OnaUk5QvXS6sLVv148NrepkbtjCixVwg@mail.gmail.com>
 <CAMB2axMG2Pr11-O8ZRh3=T-4VqUmfoKQ7=ukQxK3rHONaTXypQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axMG2Pr11-O8ZRh3=T-4VqUmfoKQ7=ukQxK3rHONaTXypQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/16/24 4:14 PM, Amery Hung wrote:
> I thought about patch 1-4 a bit more after the discussion in LSFMMBPF and
> I think we should keep what "ref_acquried" does, but maybe rename it to
> "ref_moved".
> 
> We discussed the lifecycle of skb in qdisc and changes to struct_ops and
> bpf semantics. In short, At the beginning of .enqueue, the kernel passes
> the ownership of an skb to a qdisc. We do not increase the reference count
> of skb since this is an ownership transfer, not kernel and qdisc both
> holding references to the skb. (The counterexample can be found in RFC v7.
> See how weird skb release kfuncs look[0]). The skb should be either
> enqueued or dropped. Then, in .dequeue, an skb will be removed from the
> queue and the ownership will be returned to the kernel.
> 
> Referenced kptr in bpf already carries the semantic of ownership. Thus,
> what we need here is to enable struct_ops programs to get a referenced
> kptr from the argument and returning referenced kptr (achieved via patch
> 1-4).
> 
> Proper handling of referenced objects is important for safety reasons.
> In the case of bpf qdisc, there are three problematic situations as listed
> below, and referenced kptr has taken care of (1) and (2).
> 
> (1) .enqueue not enqueueing nor dropping the skb, causing reference leak
> 
> (2) .dequeue making up an invalid skb ptr and returning to kernel
> 
> (3) If bpf qdisc operators can duplicate skb references, multiple
>      references to the same skb can be present. If we enqueue these
>      references to a collection and dequeue one, since skb->dev will be
>      restored after the skb is removed from the collection, other skb in
>      the collection will then have invalid skb->rbnode as "dev" and "rbnode"
>      share the same memory.
> 
> A discussion point was about introducing and enforcing a unique reference
> semantic (PTR_UNIQUE) to mitigate (3). After giving it more thoughts, I
> think we should keep "ref_acquired", and be careful about kernel-side
> implementation that could return referenced kptr. Taking a step back, (3)
> is only problematic because I made an assumption that the kfunc only
> increases the reference count of skb (i.e., skb_get()). It could have been
> done safely using skb_copy() or maybe pskb_copy(). In other words, it is a
> kernel implementation issue, and not a verifier issue. Besides, the
> verifier has no knowledge about what a kfunc with KF_ACQUIRE does
> internally whatsoever.
> 
> In v8, we try to do this safely by only allowing reading "ref_acquired"-
> annotated argument once. Since the argument passed to struct_ops never
> changes when during a single invocation, it will always be referencing the
> same kernel object. Therefore, reading more than once and returning
> mulitple references shouldn't be allowed. Maybe "ref_moved" is a more
> precise annotation label, hinting that the ownership is transferred.

The part that no skb acquire kfunc should be available to the qdisc struct_ops 
prog is understood. I think it just needs to clarify the commit message and 
remove the "It must be released and cannot be acquired more than once" part.


> 
> [0] https://lore.kernel.org/netdev/2d31261b245828d09d2f80e0953e911a9c38573a.1705432850.git.amery.hung@bytedance.com/


