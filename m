Return-Path: <bpf+bounces-55008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF0A76F9B
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8513A3ABFEC
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C88B21ABB4;
	Mon, 31 Mar 2025 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M0M9Stdc"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693B13C9A3
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453895; cv=none; b=i+Qlx1RbkkYXOK1s1z2Cf5LM5W+F7T9e3fRN3Xk2tx/i4Eauh0G6FJF+uQELKGyCL7b6cHJEvUu+5mOls76nGO/K8DAWUUK4fluwy5QvnhhLCqkPk4abc5ChJgtGXRQ8wfvOHX8ZhRGnw9dL9iq25aVsfv3T/EHzK5EQWnaA8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453895; c=relaxed/simple;
	bh=A5kHAqHWJDYvoVXmtqF9sLfxheRYN8d4mKVknr5HPX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5f/8sc+9qdrdrA3J4XOhUBzMzU05RNfAnUfTzVqfYnLT1tPsVPrZteCDdD5nnapgwFMIaXzOZv93O6vXVlsMreyITXT9sHGmBRqquzlB6nUPQUbkzIXtHZly5nx9+dtoMyCZI322x2JfNSDZkCcwODjbK8TqHv3y0zrrSkkyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M0M9Stdc; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8910c6a2-9a57-4eae-826b-2c81dbd9150d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743453890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s1ikD+eto2ZOHWAzUxRJSmAOyChfYiE2agGB/R2Iua8=;
	b=M0M9Stdc8Nz9jK2xZY6jFve847s2v5cYidhaKS04iT7Ndf8Ubcli0R1Bah68r29vNPiSZk
	oSHdbo/alBphAKHGmuZ+25xW9b7+FGbNaN6XtJqH1aJUzpK7CIayIBjaq9oeudrDw8JVtf
	mwc/Ryt1g2xR2/qI5bRkaFl4qn/x5yY=
Date: Mon, 31 Mar 2025 13:44:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket
 iterators
To: Jordan Rife <jrife@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>,
 Aditi Ghag <aditi.ghag@isovalent.com>
References: <20250313233615.2329869-1-jrife@google.com>
 <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
 <c53cee32-02c0-4c5a-a57d-910b12e73afd@linux.dev>
 <CADKFtnT+c2XY96NCTCf7qpptq3PKNrkedQt68+-gvD9LK-tBVQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADKFtnT+c2XY96NCTCf7qpptq3PKNrkedQt68+-gvD9LK-tBVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/31/25 10:23 AM, Jordan Rife wrote:
>> We can also consider if the same sk batch array can be reused to store cookies
>> during stop(). If the array can reuse, it would be nice but not a blocker imo.
> 
>> In term of slowness, the worst will be all the previous stored cookies cannot be
>> found in the updated bucket? Not sure how often a socket is gone and how often
>> there is a very large bucket (as mentioned at the hashtable's key earlier), so
>> should not be an issue for iteration use case? I guess it may need some rough
>> PoC code to judge if it is feasible.
> 
> I like the idea of reusing the sk batch array. Maybe create a union
> batch_item containing struct sock * and __u64. I'll explore this
> direction a bit and see if I can come up with a small PoC. Lots of

sgtm. Thanks.

I think udp should be easier to begin with for PoC.

tcp may need some thoughts. It seems it may be a good time to have some bpf 
specific implementation instead of reusing the existing tcp ones, e.g. 
tcp_seek_last_pos(). Not sure.

> array scanning could be slow, but since changes to a bucket should be
> rare, one optimization could be to only compare to the saved socket
> cookies if the bucket has changed since it was last seen. I think
> saving and checking the head, tail, and size of the bucket's linked
> list should be sufficient for this?

Not sure if head, tail, and size stay the same is enough to imply the bucket('s 
linked list) has not changed. I think tcp may be ok since I currently don't see 
a way to re-bind() a bind()-ed socket without close()-ing it. I don't know about 
the connected UDP...etc.

A quick thought is to keep it simple and scan the 1st cookie from the beginning 
of the bucket. The current saved "offset" should be no longer necessary.

Then start finding the 2nd, 3rd... cookies from the bucket's location where the 
1st cookie was found.

For the amount of work, this should be similar to the current "offset" which 
needs to walk the list till the "offset" point also. In the unlikely case a 
cookie cannot be found, it may need to scan from the beginning of the list to 
ensure it is indeed gone.

