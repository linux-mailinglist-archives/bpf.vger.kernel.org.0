Return-Path: <bpf+bounces-1033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D471C70C456
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 19:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9102F280FB2
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8C16436;
	Mon, 22 May 2023 17:34:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6D16429
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 17:34:02 +0000 (UTC)
Received: from out-52.mta0.migadu.com (out-52.mta0.migadu.com [IPv6:2001:41d0:1004:224b::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC0C107
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 10:34:00 -0700 (PDT)
Message-ID: <d3865088-45df-ab48-3631-c48c84baa727@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684776839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMlvtCQBZ8lPggNrL+nZKXmCQVTMMJN+GiwKmz2KAe8=;
	b=tQLfadF0+yGsWwXVc1Uhg4W2dTUUzN1wh392IBgoezOYpiJwfagQJfzoEplkgv/dpb8IVc
	d1Ou4FKpuqVxMX+wj4FSnDSjhviPRVxsKvOzWYB2BWv9tHrWeWGscqm7NkXs3+Bw35pOpi
	yRwIxr1WJ28tPh1u6yAkKpkQg0q4Uco=
Date: Mon, 22 May 2023 10:33:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: fix a memory leak in the LRU and LRU_PERCPU hash
 maps
Content-Language: en-US
To: Anton Protopopov <aspsk@isovalent.com>, Song Liu <song@kernel.org>
References: <20230522154558.2166815-1-aspsk@isovalent.com>
 <ZGuUii1nfyvXzX4g@zh-lab-node-5>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <ZGuUii1nfyvXzX4g@zh-lab-node-5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/22/23 9:12 AM, Anton Protopopov wrote:
> On Mon, May 22, 2023 at 03:45:58PM +0000, Anton Protopopov wrote:
>> The LRU and LRU_PERCPU maps allocate a new element on update before locking the
>> target hash table bucket. Right after that the maps try to lock the bucket.
>> If this fails, then maps return -EBUSY to the caller without releasing the
>> allocated element. This makes the element untracked: it doesn't belong to
>> either of free lists, and it doesn't belong to the hash table, so can't be
>> re-used; this eventually leads to the permanent -ENOMEM on LRU map updates,
>> which is unexpected.

Ouch. This is very bad. :(

Excellent catch. Applied.

I am thinking if a test could be written but it does not seem like anything 
after htab_lock_bucket() is traceable. Not sure if Song may have good idea?

>> Fix this by returning the element to the local free list if bucket locking fails.
> Fixes: 20b6cc34ea74 ("bpf: Avoid hashtab deadlock with map_locked")
> 


