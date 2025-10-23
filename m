Return-Path: <bpf+bounces-71898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B0AC00EC4
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509D93A728B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3EB30F544;
	Thu, 23 Oct 2025 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Uc55ETVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8530AAC5
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220556; cv=none; b=ZMOpL6D9V4io64+IG3XxD2xGvZerDecF4uZbQ8Cm4r+NH474/OCsnB31A315Gsd3QqP/7rUDlxa6fiVgJWKPdWVE9elPdYSOr9jshnllz+h6VzCPiqPreOFHabDgvY9KloPOrZmdTlL8wSEzUkcEOa73M3aBqwjOsP8gXKODOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220556; c=relaxed/simple;
	bh=azviEF2Y9DsjLGlZO8zdXXKHk7bppBImzg31itZmqpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=epjjw9GKV7eiKOBTzyyJsc04ACe/qjup65VgbgAqncaqqjtLzUBFBHKTVM4mjvcUYa8ObWUUbv1u+9QGvEcToPyPkyyzcpqsu51IugS0xGbnx70EoffunFE48vMGsZ8gxe/iM/vFReis6Iwf64EvqfBUQnnAG4ioPYGL0EPefsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Uc55ETVX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b50206773adso55955966b.0
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761220553; x=1761825353; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfSzc8kJaozUiCooo0tA6ZYtUG0roletvLtB9N7dv/Q=;
        b=Uc55ETVXKsRvMNmqiEV7evJnAWjyLlua4LNaEGxMQ0Z+ZPXjiP+xwrjeiBov3Pp8XF
         C2V1X+QLMGKqk+Zdqb+JD/2poTt20J24rpchxTkCfPuXwe8TUDaHiRqV6A5ciTaja6Wl
         rgLNa4vl80a0BI6FdWtuJiVMF+Qm4c48fMSG40TyiiW4v13WedpD4BR75XdeEEu2YP/z
         b5bS5hilKBblTyiAnrejPIzvFgxbSI+UvSBPLhDP3TLtEErfonhoQw3K8rNk5vv8yc4v
         5j2k2CmA6aiAeaoblISN5/c/zPz5sYmhqic5sJZqyX80RB72SrE76g9O4vEuququSIrN
         n+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220553; x=1761825353;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfSzc8kJaozUiCooo0tA6ZYtUG0roletvLtB9N7dv/Q=;
        b=IToVyHkeF4TruZYbOXkxqp0/oT7XLlOL5taM5wpWNi8BbbzwyZNTLaz5npRuFCiPz2
         olih8zCyPI+oJQocy5E890lCmHXkYQNjaxclBFZn2x3S7zsWLgMax/PVXEufv+vVZ77z
         vFF9crRILHvGW/p+KUvV2bSEzJqowc8wCW6WzJdquOp7bSlUvc9hiTDalUh45dOD7n0E
         EYyHzttfDM8HQTXrr/GITh+7JHZrhVevq12GWfOERN0Y4Q+Fvw/LvdJEyRPxmPtizvIa
         e2OuZ+rNEk+VGP2CMNd5xEvoLCT61IyYaSgs/Iyzufg5CCdAg6He7+FUIy4v8FqzuoiU
         lV9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWS/X3/vjts4rn+O7g2YqIycMNs2oyQJkgOBYD8R6u1wyK8hHjCP3wSUwhI5uy2AnEPfCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVgW4GW/3DJPdEL23I8TDSj4rjy7NJFR17xiaIp+Cgm4ujtSO
	WhQmU91QLGJ8NDHwACxtO4RXYxgj3u2xVBKiVnDvZrH1M07HACOboyznqvd7/fc+hL4=
X-Gm-Gg: ASbGnctpzJTpn8ZoDJlVN2KJgaemKRVqdgaGXr5oKBWM6nHSQBoXQ7+0/JZIwNl5SWq
	pWZBfs5D3KHDKvPGyDnANdEs5a4hiDmJ7VF7aXFL+CHQOGp3C3gfRrSUiB6+KErf8uFM2L1JP0E
	n1i/GpGx59rZoJZ90mpEbk8e/9WIuW5GHHn3Fn+JD+w6z/NwtYvd9WNPq5PGhSLCo9nWu07kza4
	Rm37kltJsd+Rht3/yR8IZKUFOuIZsgwa8EeAR2oggBJB9+KMJl5WYmdRemZ235rTtt9ChqrCGyX
	sFhZWfJNGx7k8plQs2s0UsUXNl8OFuDP0J/ituitwhBXqNVUrhIErETIK1O06CyH9G04WCsuvfD
	jTR8HxklCyT1J3aG9pR8IaHdFIV/TO57e8fNVB+HFrV2Gj/ndNVBCplhwR6uyOLnK8DwF
X-Google-Smtp-Source: AGHT+IEI3LwYTd9zFcd/viEBkli7RyXBE4AUj66P9/ZXp+kyUrGJGoB9rBxYKTCx1VJkF4vIwOM3HA==
X-Received: by 2002:a17:907:7f19:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-b6d2c79fd9emr844385366b.30.1761220553164;
        Thu, 23 Oct 2025 04:55:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:7f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f7027sm223524166b.25.2025.10.23.04.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:55:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Stanislav Fomichev <sdf@fomichev.me>,  Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Arthur Fabre
 <arthur@arthurfabre.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2 11/15] selftests/bpf: Expect unclone to
 preserve skb metadata
In-Reply-To: <2753c96b-48f9-480e-923c-60d2c20ebb03@linux.dev> (Martin KaFai
	Lau's message of "Wed, 22 Oct 2025 16:12:39 -0700")
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
	<20251019-skb-meta-rx-path-v2-11-f9a58f3eb6d6@cloudflare.com>
	<2753c96b-48f9-480e-923c-60d2c20ebb03@linux.dev>
Date: Thu, 23 Oct 2025 13:55:51 +0200
Message-ID: <87ms5hvnlk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 22, 2025 at 04:12 PM -07, Martin KaFai Lau wrote:
> On 10/19/25 5:45 AM, Jakub Sitnicki wrote:
>> @@ -447,12 +448,14 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
>>     /*
>>    * Check that skb_meta dynptr is read-only before prog writes to packet payload
>> - * using dynptr_write helper. Applies only to cloned skbs.
>> + * using dynptr_write helper, and becomes read-write afterwards. Applies only to
>> + * cloned skbs.
>>    */
>>   SEC("tc")
>> -int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
>> +int clone_dynptr_rdonly_before_data_dynptr_write_then_rw(struct __sk_buff *ctx)
>>   {
>>   	struct bpf_dynptr data, meta;
>> +	__u8 meta_have[META_SIZE];
>>   	const struct ethhdr *eth;
>>     	bpf_dynptr_from_skb(ctx, 0, &data);
>> @@ -465,15 +468,23 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
>>     	/* Expect read-only metadata before unclone */
>>   	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>> -	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
>> +	if (!bpf_dynptr_is_rdonly(&meta))
>
> Can the bpf_dynptr_set_rdonly() be lifted from the bpf_dynptr_from_skb_meta()?
>
> iiuc, the remaining thing left should be handling a cloned skb in
> __bpf_dynptr_write()? The __bpf_skb_store_bytes() is using
> bpf_try_make_writable, so maybe something similar can be done for the
> BPF_DYNPTR_TYPE_SKB_META?

I'm with you. This is not user-friendly at all currently.

This patch set has already gotten quite long so how about I split out
the pskb_expand_head patch (#1) and the related selftest change (patch
#11) from this series, expand it to lift bpf_dynptr_set_rdonly()
limitation for skb_meta dynptr, and do that first in a dedicated series?

>
>> +		goto out;
>> +
>> +	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
>> +	if (!check_metadata(meta_have))
>>   		goto out;
>>     	/* Helper write to payload will unclone the packet */
>>   	bpf_dynptr_write(&data, offsetof(struct ethhdr, h_proto), "x", 1, 0);
>>   -	/* Expect no metadata after unclone */
>> +	/* Expect r/w metadata after unclone */
>>   	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
>> -	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != 0)
>> +	if (bpf_dynptr_is_rdonly(&meta))
>
> then it does not have to rely on the bpf_dynptr_write(&data, ...) above to make
> the metadata writable.
>
> I have a high level question about the set. I assume the skb_data_move() in
> patch 2 will be useful in the future to preserve the metadata across the
> stack. Preserving the metadata across different tc progs (which this set does)
> is nice to have but it is not the end goal. Can you shed some light on the plan
> for building on top of this set?

Right. Starting at the highest level, I want to work toward preserving
the metadata on RX path first (ongoing), forward path next, and TX path
last.

On RX path, the end game is for sk_filter prog to be able to access
metadata thru dynptr. For that we need to know where the metadata
resides. I see two ways how we can tackle that:

A) We keep relying on metadata being in front of skb_mac_header().

   Fun fact - if you don't call any TC BPF helpers that touch
   skb->mac_header and don't have any tunnel or tagging devices on RX
   path, this works out of the box today. But we need to make sure that
   any call site that changes the MAC header offset, moves the
   metadata. I expect this approach will be a pain on TX path.

... or ...

B) We track the metadata offset separately from MAC header offset

   This requires additional state, we need to store the metadata offset
   somewhere. However, in exchange for a couple bytes we gain some
   benefits:

   1. We don't need to move the metadata after skb_pull.

   2. We only need to move the metadata for skb_push if there's not
     enough space left, that is the gap between skb->data and where
     metadata ends is too small.

     (This means that anyone who is not using skb->data_meta on RX path
     but the skb_meta dynptr instead, can avoid any memmove's of the
     metadata itself.)
     
   3. We can place the metadata at skb->head, which plays nicely with TX
      path, where we need the headroom for pushing headers.

I've been trying out how (B) plays out when safe-proofing the tunnel &
tagging devices, your VLANs and GREs, to preserve the metadata.

To that end I've added a new u16 field in skb_shinfo to track
meta_end. There a 4B hole there currently and we load the whole
cacheline from skb_shinf to access meta_len anyway.

Once I had that, I could modify the skb_data_move() to relocate the
metadata only if necessary, which looks like so:

static inline void skb_data_move(struct sk_buff *skb, const int len,
				 const unsigned int n)
{
	const u8 meta_len = skb_metadata_len(skb);
	u8 *meta, *meta_end;

	if (!len || (!n && !meta_len))
		return;

	if (!meta_len)
		goto no_metadata;

	/* Not enough headroom left for metadata. Drop it. */
	if (WARN_ON_ONCE(meta_len > skb_headroom(skb))) {
		skb_metadata_clear(skb);
		goto no_metadata;
	}

	meta_end = skb_metadata_end(skb);
	meta = meta_end - meta_len;

	/* Metadata in front of data before push/pull. Keep it that way. */
	if (meta_end == skb->data - len) {
		memmove(meta + len, meta, meta_len + n);
		skb_shinfo(skb)->meta_end += len;
		return;
	}

	if (len < 0) {
		/* Data pushed. Move metadata to the top. */
		memmove(skb->head, meta, meta_len);
		skb_shinfo(skb)->meta_end = meta_len;
	}
no_metadata:
	memmove(skb->data, skb->data - len, n);
}

The goal is for RX path is to hit everwhere just the last memmove(),
since we will be usually pulling from skb->data, if you're not using the
skb->data_meta pseudo-pointer in your TC(X) BPF programs.

There are some verifier changes needed to keep skb->data_meta
working. We need to move the metadata back in front of the MAC header
before a TC(X) prog that uses skb->data_meta runs, or things break.

Early code for that is also available for a preview. I've pushed it to:

https://github.com/jsitnicki/linux/commits/skb-meta/safeproof-netdevs/

Thanks,
-jkbs

