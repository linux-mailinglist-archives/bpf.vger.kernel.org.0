Return-Path: <bpf+bounces-52490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471FDA435F4
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 08:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325A13B3448
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DEF2586CD;
	Tue, 25 Feb 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HTKTrZ0f"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC7242912
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467616; cv=none; b=hFKtk8E7KRta0hlVfiSLtmHDdQVt81ZWI5i5dTVXeqHTHu1o5sBFxfGjkRL8wjD+/1fYkQaJmJv/fHhWRjQJRXBqs7zo30dRCoI4HElbHNQXaJtYv/D2Nh1S2Moer1L5Ce71bW3gjQ6l2GSOyB5EdjD4F/1IbL5HywN2AMepS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467616; c=relaxed/simple;
	bh=VspPjQ7JUV7cWoxLDhkiDYArZjauUCyWSruWI5/OyzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=e9jJscyDtw8Rv0Av8TiPEECS8eqNUuCx49/2wSVYZaJabgWlkXKFeJGW3MmWYlbPWok6rRio5WZ6DszLY8gW+s2ueRErpDbB7EUq3ExgEkkIi1+X/8scMKjMZf8oDByrx/TjAn3ELbMZMR3Rp2itwp6wneLCuBTS1QzyBPxBoKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HTKTrZ0f; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed150c6e-7987-4729-8a6b-e1e9e38823cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740467610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poLBncer4+0p6CwxuL1RvqRLA0LblIgOz/JkxPfNkDk=;
	b=HTKTrZ0f2juVvGXULZ2tkp4dH5Eqkaheq3DpyV2ZnqLEaZB8LqVQIyKXzN0M3jPQwmmp/a
	UUiszUrBfNviBPwiFI9Ml4H4yPNL5RHzpQsCi52Gre/8dyiI9fMSmkd+Cm9XoxDAgaoInF
	DbIIfI6ZZOB4JQrweKQEQT5Q2WDa9V0=
Date: Mon, 24 Feb 2025 23:13:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: fix possible endless loop in BPF map iteration
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
References: <Z7zsLsjrldJAISJY@bkammerd-mobl>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <Z7zsLsjrldJAISJY@bkammerd-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/24/25 2:01 PM, Brandon Kammerdiener wrote:
> This patch fixes an endless loop condition that can occur in
> bpf_for_each_hash_elem, causing the core to softlock. My understanding is
> that a combination of RCU list deletion and insertion introduces the new
> element after the iteration cursor and that there is a chance that an RCU

new element is added to the head of the bucket, so the first thought is it 
should not extend the list beyond the current iteration point...

> reader may in fact use this new element in iteration. The patch uses a
> _safe variant of the macro which gets the next element to iterate before
> executing the loop body for the current element. The following simple BPF
> program can be used to reproduce the issue:
> 
>      #include "vmlinux.h"
>      #include <bpf/bpf_helpers.h>
>      #include <bpf/bpf_tracing.h>
> 
>      #define N (64)
> 
>      struct {
>          __uint(type,        BPF_MAP_TYPE_HASH);
>          __uint(max_entries, N);
>          __type(key,         __u64);
>          __type(value,       __u64);
>      } map SEC(".maps");
> 
>      static int cb(struct bpf_map *map, __u64 *key, __u64 *value, void *arg) {
>          bpf_map_delete_elem(map, key);
>          bpf_map_update_elem(map, &key, &val, 0);

I suspect what happened in this reproducer is,
there is a bucket with more than one elem(s) and the deleted elem gets 
immediately added back to the bucket->head.
Something like this, '[ ]' as the current elem.

1st iteration     (follow bucket->head.first): [elem_1] ->  elem_2
                                   delete_elem:  elem_2
                                   update_elem: [elem_1] ->  elem_2
2nd iteration (follow elem_1->hash_node.next):  elem_1  -> [elem_2]
                                   delete_elem:  elem_1
                                   update_elem: [elem_2] -> elem_1
3rd iteration (follow elem_2->hash_node.next):  elem_2  -> [elem_1]
				  loop.......

don't think "_safe" covers all cases though. "_safe" may solve this particular 
reproducer which is shooting itself in the foot by deleting and adding itself 
when iterating a bucket.

[ btw, I don't think the test code can work as is. At least the "&key" arg of 
the bpf_map_update_elem looks wrong. ]

>          return 0;
>      }
> 
>      SEC("uprobe//proc/self/exe:test")
>      int BPF_PROG(test) {
>          __u64 i;
> 
>          bpf_for(i, 0, N) {
>              bpf_map_update_elem(&map, &i, &i, 0);
>          }
> 
>          bpf_for_each_map_elem(&map, cb, NULL, 0);
> 
>          return 0;
>      }
> 
>      char LICENSE[] SEC("license") = "GPL";
> 
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> 
> ---
>   kernel/bpf/hashtab.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4a9eeb7aef85..43574b0495c3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2224,7 +2224,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
>   		b = &htab->buckets[i];
>   		rcu_read_lock();
>   		head = &b->head;
> -		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
> +		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
>   			key = elem->key;
>   			if (is_percpu) {
>   				/* current cpu value for percpu map */
> --
> 2.48.1
> 


