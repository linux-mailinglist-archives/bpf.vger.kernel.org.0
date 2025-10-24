Return-Path: <bpf+bounces-71982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451DC0420B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 04:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92E174F199A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8420F25D533;
	Fri, 24 Oct 2025 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WuIBWNsl"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F025D1E9
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273188; cv=none; b=tlPQBQpdsdriIws2A1ugf+/6lmLE4RnG1qrohULliIsh3v/dx6obkhDn1AbumTpXWoEFP3PkCJS1hV2xExDugo/MCaSkUpuA6xjBlpt227B0T1ftpKxEbrV6fEd0RVTZuW2fhTTjgLtpN/GDxfqtrwNv4xuhp1G3U/toXe3v28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273188; c=relaxed/simple;
	bh=DaexkTbW1tktFFUDgTYSt6aGCtkli9Zq+RDu+QSNl/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijQlmhz4Suy97CNU483+jTJWjfMob1wgerjatoSsEX9rtj0sUkmTCdOsIJ5Th+94VlqpDlXIrGEe11Hb3rby2rh/IUjY+2fnFPukOm+wviGrrxRwPsD7jF1SPh0lJb+i3iJfzNNQsfqj/022gEpFNuqh86vRLKM5JJlAdr1Dguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WuIBWNsl; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e9f3ccc7-750b-4d60-ae03-ac493b766b56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761273172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6L8w/MYixDQ3HfZ52lY4LyJExEIaRligFMETMvjx5s=;
	b=WuIBWNsl73wntASe+xLhjZpWx0Hx3pJEHdFrXMT0MhSYzDh0YTr/Y9GqydRmRb1MeY58Sx
	Q0vbdfiEr4mdgPusJVl9J/tSh8+cN7v2u6mlSua9wIYqKn89BndiDC9fVIB/WfaoVh8sL5
	7ium+WjGGGbBjIc2orLAP9iX/tfHM4M=
Date: Thu, 23 Oct 2025 19:32:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 11/15] selftests/bpf: Expect unclone to
 preserve skb metadata
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
 <20251019-skb-meta-rx-path-v2-11-f9a58f3eb6d6@cloudflare.com>
 <2753c96b-48f9-480e-923c-60d2c20ebb03@linux.dev>
 <87ms5hvnlk.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87ms5hvnlk.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/23/25 4:55 AM, Jakub Sitnicki wrote:
> On Wed, Oct 22, 2025 at 04:12 PM -07, Martin KaFai Lau wrote:
>> On 10/19/25 5:45 AM, Jakub Sitnicki wrote:
>>> @@ -447,12 +448,14 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
>>>      /*
>>>     * Check that skb_meta dynptr is read-only before prog writes to packet payload
>>> - * using dynptr_write helper. Applies only to cloned skbs.
>>> + * using dynptr_write helper, and becomes read-write afterwards. Applies only to
>>> + * cloned skbs.
>>>     */
>>>    SEC("tc")
>>> -int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
>>> +int clone_dynptr_rdonly_before_data_dynptr_write_then_rw(struct __sk_buff *ctx)
>>>    {
>>>    	struct bpf_dynptr data, meta;
>>> +	__u8 meta_have[META_SIZE];
>>>    	const struct ethhdr *eth;
>>>      	bpf_dynptr_from_skb(ctx, 0, &data);
>>> @@ -465,15 +468,23 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
>>>      	/* Expect read-only metadata before unclone */
>>>    	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>>> -	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
>>> +	if (!bpf_dynptr_is_rdonly(&meta))
>>
>> Can the bpf_dynptr_set_rdonly() be lifted from the bpf_dynptr_from_skb_meta()?
>>
>> iiuc, the remaining thing left should be handling a cloned skb in
>> __bpf_dynptr_write()? The __bpf_skb_store_bytes() is using
>> bpf_try_make_writable, so maybe something similar can be done for the
>> BPF_DYNPTR_TYPE_SKB_META?
> 
> I'm with you. This is not user-friendly at all currently.
> 
> This patch set has already gotten quite long so how about I split out
> the pskb_expand_head patch (#1) and the related selftest change (patch
> #11) from this series, expand it to lift bpf_dynptr_set_rdonly()
> limitation for skb_meta dynptr, and do that first in a dedicated series?


A followup on lifting the bpf_dynptr_set_rdonly is fine and keep this 
set as is. Just want to check if there is anything stopping it. However, 
imo, having one or two patches over is fine. The set is not difficult to 
follow.


> 
>>
>>> +		goto out;
>>> +
>>> +	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
>>> +	if (!check_metadata(meta_have))
>>>    		goto out;
>>>      	/* Helper write to payload will unclone the packet */
>>>    	bpf_dynptr_write(&data, offsetof(struct ethhdr, h_proto), "x", 1, 0);
>>>    -	/* Expect no metadata after unclone */
>>> +	/* Expect r/w metadata after unclone */
>>>    	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>>> -	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != 0)
>>> +	if (bpf_dynptr_is_rdonly(&meta))
>>
>> then it does not have to rely on the bpf_dynptr_write(&data, ...) above to make
>> the metadata writable.
>>
>> I have a high level question about the set. I assume the skb_data_move() in
>> patch 2 will be useful in the future to preserve the metadata across the
>> stack. Preserving the metadata across different tc progs (which this set does)
>> is nice to have but it is not the end goal. Can you shed some light on the plan
>> for building on top of this set?
> Right. Starting at the highest level, I want to work toward preserving
> the metadata on RX path first (ongoing), forward path next, and TX path
> last.
> 
> On RX path, the end game is for sk_filter prog to be able to access
> metadata thru dynptr. For that we need to know where the metadata
> resides. I see two ways how we can tackle that:
> 
> A) We keep relying on metadata being in front of skb_mac_header().
> 
>     Fun fact - if you don't call any TC BPF helpers that touch
>     skb->mac_header and don't have any tunnel or tagging devices on RX
>     path, this works out of the box today. But we need to make sure that
>     any call site that changes the MAC header offset, moves the
>     metadata. I expect this approach will be a pain on TX path.
> 
> ... or ...
> 
> B) We track the metadata offset separately from MAC header offset
> 
>     This requires additional state, we need to store the metadata offset
>     somewhere. However, in exchange for a couple bytes we gain some
>     benefits:
> 
>     1. We don't need to move the metadata after skb_pull.
> 
>     2. We only need to move the metadata for skb_push if there's not
>       enough space left, that is the gap between skb->data and where
>       metadata ends is too small.
> 
>       (This means that anyone who is not using skb->data_meta on RX path
>       but the skb_meta dynptr instead, can avoid any memmove's of the
>       metadata itself.)


I don't think I get this part. For example, 
bpf_dynptr_slice_rdwr(&meta_dynptr) should be treated like
skb->data_meta also?


>       
>     3. We can place the metadata at skb->head, which plays nicely with TX
>        path, where we need the headroom for pushing headers.


Having a way to separately track the metadata start/end is useful.
An unrelated dumb/lazy question, is it possible/lot-of-changes to put 
the metadata in the head (or after xdp_frame?) in the RX path?

> 
> I've been trying out how (B) plays out when safe-proofing the tunnel &
> tagging devices, your VLANs and GREs, to preserve the metadata.
> 
> To that end I've added a new u16 field in skb_shinfo to track
> meta_end. There a 4B hole there currently and we load the whole
> cacheline from skb_shinf to access meta_len anyway.
> 
> Once I had that, I could modify the skb_data_move() to relocate the
> metadata only if necessary, which looks like so:
> 
> static inline void skb_data_move(struct sk_buff *skb, const int len,
> 				 const unsigned int n)
> {
> 	const u8 meta_len = skb_metadata_len(skb);
> 	u8 *meta, *meta_end;
> 
> 	if (!len || (!n && !meta_len))
> 		return;
> 
> 	if (!meta_len)
> 		goto no_metadata;
> 
> 	/* Not enough headroom left for metadata. Drop it. */
> 	if (WARN_ON_ONCE(meta_len > skb_headroom(skb))) {
> 		skb_metadata_clear(skb);
> 		goto no_metadata;
> 	}
> 
> 	meta_end = skb_metadata_end(skb);
> 	meta = meta_end - meta_len;
> 
> 	/* Metadata in front of data before push/pull. Keep it that way. */
> 	if (meta_end == skb->data - len) {
> 		memmove(meta + len, meta, meta_len + n);
> 		skb_shinfo(skb)->meta_end += len;
> 		return;
> 	}
> 
> 	if (len < 0) {
> 		/* Data pushed. Move metadata to the top. */
> 		memmove(skb->head, meta, meta_len);
> 		skb_shinfo(skb)->meta_end = meta_len;
> 	}
> no_metadata:
> 	memmove(skb->data, skb->data - len, n);
> }
> 
> The goal is for RX path is to hit everwhere just the last memmove(),
> since we will be usually pulling from skb->data, if you're not using the
> skb->data_meta pseudo-pointer in your TC(X) BPF programs.
> 
> There are some verifier changes needed to keep skb->data_meta
> working. We need to move the metadata back in front of the MAC header
> before a TC(X) prog that uses skb->data_meta runs, or things break.
> 
> Early code for that is also available for a preview. I've pushed it to:
> 
> https://github.com/jsitnicki/linux/commits/skb-meta/safeproof-netdevs/

Thanks. I will take a look.


