Return-Path: <bpf+bounces-61275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FDAE3C49
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE103A2EFC
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23823AE9B;
	Mon, 23 Jun 2025 10:28:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9922F1B4240;
	Mon, 23 Jun 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674514; cv=none; b=joXbe0v97/p25otNPbE6arqV6PhhaKN81MJF7LREjR1VwtL6JIa3DQx7wbDKg3Oa3p4zRJU9gzZVI0MI1pYfJnl8NqI89/jvRL6zzwnOPOn1TUpBSWecCEPcC2rYQNgIy4LRRgQeKyDPuw+QG/EHhp9InqUIKPD9PoCuXxmS+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674514; c=relaxed/simple;
	bh=N7ZQxV+Tkg0+Ls4X+f9GzaVY7wm4dgYAmb5ovUUI3Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qytbLPF1ZR/ehPA2CoataopSkn8E0AR2SSznpb8LUrg8E6RIL9br4sjC3vauEKryaCHiMUv2l20r7bdU6SuwyCZk8WQO8OLWQ6JbxXlEQdhaya7thzx94GOqj5n1rqwTm8wQaiKnmGPUmaXryrvmOfyAXcwN0Preo2FJTOs+I7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-cd-68592c4b26b2
Date: Mon, 23 Jun 2025 19:28:21 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250623102821.GC3199@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-2-byungchul@sk.com>
 <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRiGefd+p00HX8vqLX8U62BZOQup54faQaoPOxgF0Qlq5EebzRWb
	mgaBlhlJWi07TZNpZJ5gNQ+bYVJLnbJAs7RVprZUCMwwD2SW5oyofxf3/XBx/3g4rDDTCzit
	PkE06NU6JSOjZF/8C1ZvX3VAE/r6fgDkWcsZKPueDA96HDTklVYjGBl/z8JwvYuBewVjGPJa
	0ikYtf7A0NfoZaHMthO6i/opqL1ox+C90sRAVvoEhifjgyyccxRLoLU6m4acH/cx2FN7WHj1
	OI+BrvIpGvqdWRQ0m0so6M7eCI2WuTDmHkBQb7VLYOzyXQaut1kY+JTejaDtuZeC3LRsBNY6
	Dw0T36cduQ1d7MYlwvOBr1ioLHkrEWrMH1jBYksUKoqDhUxPGxZspZcYwfbNxAqdHbWM0HR7
	ghJqHMMSIev8ICMM9b2jhK917YxgrWynhBeWenb3rIOy8FhRp00SDarIozKN60kNc+oVm9zU
	8xKnoik6E3Ec4cNIWufCTCSdQZd7EvuY4pcSp/sm42OGDyIez/hMHsAvJ7aMh9Ms4zCfzxBL
	TudMMZtXk1umTxIfy/n15G1l18yRgr+ByJCtjP5TzCLNd3opH2M+mHgmP0t8IzAfSB5Mcr5Y
	ykcSk7kR+XgOv5g8rXZJfB7COzgyNGDGf5bOJ8+KPdRVxJv/05r/05r/aS0IlyKFVp8Ur9bq
	wkI0KXptcsixk/E2NP0xRWd/HnKgb617nYjnkNJfftR/v0ZBq5OMKfFORDisDJA7N+/TKOSx
	6pQzouHkEUOiTjQ6USBHKefJ146djlXwx9UJ4glRPCUa/rYSTrogFYlsu99o6OGcxSUfMxzl
	fjqX4YJJNedXxwbp5vDRXa9V1i6VfUtc77PCbSNyb4QpLj2qxb0yQRcdJX2jii6ovdIRnlO3
	KSZwXdSLp0Zn7zIajXgnVmTHaPM7x+fvqYpkkV9D2L79GRUR/WX6RY+qGqJTBgd2XLq2dchS
	mHt7XlGQkjJq1GuCscGo/g1pi+z/LQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zds5xNDqtVSclgkVU6yoUvWGIFNSfzOpTmhF6yINbeWPL
	WySZrkJRy0uZxxkzU+cFV0t0hkbM8sKivGCsLCeaUSKWaZJZ1mZEffvxPM/v/fSypPIn5cvq
	4s6J+jghRk3LKfmRgMytwVtOaHe09BJgstbTUPctBaqH7TIw1TYhmJkbZGD6SScNFeWzJJhe
	GCn4av1OwljHCAN1thBwV72noPVqMwkj17poyDXOk9A2N8lAht1CQHtZtwx6mvJkUPS9koTm
	9GEG+h+aaBiq/yWD945cCrqlGgrceUHQYV4Js84JBE+szQTM5pTRUNhnpmHU6EbQ1z5CQeml
	PATWRy4ZzH/z3Ch9OsQErcftE59I3FjzisAt0lsGm22J+IFFg7NdfSS21WbR2PalgMFvXrbS
	uOvWPIVb7NMEzs2cpPHU2GsKf3o0QOOKD58JbG0coI4pw+V7o8QYXZKo3x4YKdd2trXQCf1M
	StdwL5mOfsmykQ/Lczv5TucC6WWKW887nDdpL9PcBt7lmlvMVdxG3nblnoflLMndpnlz0ZvF
	Yjkn8MUFo4SXFdxu/lXj0OJIyd1A/JStTvanWMZ3l7yjvExyGt618NEjsB7246sXWG/swwXy
	BVIH8vIKbh3/uKmTuI4U0n+29J8t/bPNiKxFKl1cUqygi9m1zXBWmxqnS9l2Oj7WhjxPUZX2
	I9+OZvoPOhDHIvUShSU4TKuUCUmG1FgH4llSrVI49h3XKhVRQup5UR8foU+MEQ0O5MdS6lWK
	Q6FipJKLFs6JZ0UxQdT/bQnWxzcdnZLOJx9WVo3XXtD8GCu6jMMsWXeeb2i9veVLsu9pIdrx
	YmmletNaY8IzLiC0QjuWVp6dPX7sdUhUYcnRyXx//66G/WbVwJmczU4/nakMvXOOmhculYbX
	rw5WNgT7HSh2F67ZaZmULp4cDHyYHy7t8a+53xMglOTZVXebrpARGb1qyqAV/DWk3iD8BkQV
	x6EQAwAA
X-CFilter-Loop: Reflected

On Mon, Jun 23, 2025 at 11:32:16AM +0200, David Hildenbrand wrote:
> On 20.06.25 06:12, Byungchul Park wrote:
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> > 
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, and make it union'ed with the existing fields in struct
> > net_iov, allowing to organize the fields of struct net_iov.
> 
> It would be great adding some result from the previous discussions in
> here, such as that the layout of "struct net_iov" can be changed because
> it is not a "struct page" overlay, what the next steps based on this

I think the network folks already know how to use and interpret their
data struct, struct net_iov for sure.. but I will add the comment if it
you think is needed.  Thanks for the comment.

	Byungchul

> patch are etc.
> 
> --
> Cheers,
> 
> David / dhildenb

