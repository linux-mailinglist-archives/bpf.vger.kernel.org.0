Return-Path: <bpf+bounces-40689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3F298C153
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DBF1C23B57
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA31C9DDC;
	Tue,  1 Oct 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJlDNWuV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A06C2E3
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795687; cv=none; b=l7BqRHsVXeVSqkGG3afAPJtJvIesgNZGwjPBFVB3Ni480V6wHwFr5Wnojne12jP5/VnoDfMp6SRbQxOeg0OG/XdDhF7fdV+INKdSajIe/hZ3H1k6PdplT7U62cXZK8bdjOlD4Zr5QviOG9N1uv0xGFKqCjGTEbFaFljXXZe4Fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795687; c=relaxed/simple;
	bh=AKyFe2hq/R/RiIepSk+0vF7YQ4DmL5B9lXuonYQXDE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EQ8+gDeRxXgqLIQx7jD2h72B4yavFxnBpaTNao4fUn9YhdORioLobHI+tCf8TMqIE4ovlQxDJ61kwr1GKtwQe0TewPw4UrWkKUZBjIYeQby8T/W4NwRY6FgzXO1gdZ1sdHiUd3XEygp95P4H2/K69fYIwuIskzk7IfU2pqNVIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJlDNWuV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727795684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5dTFKu82vESr8yr6vd4vi7LjlIE8ld4GmyUnMyrhfJQ=;
	b=FJlDNWuVyWrIWKqgH7nnFB1NP9cvTDW2UVpOhMzNDVbPntdgPOCq50HVIL3mr70R4eCmK7
	3VO93b7M8Ui9kML8VgMLdANyJVYqSNqK0t5DKrzSZhb2Ho0XkKpKrB4z7kGpC3iIcJI04s
	d2fEtlHDGONoiJXTSIemlQ8pCG2ToDA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-iyZ1RV1RNIKt4nsD2BnsrQ-1; Tue, 01 Oct 2024 11:14:43 -0400
X-MC-Unique: iyZ1RV1RNIKt4nsD2BnsrQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cd18bd0d6so1837310f8f.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 08:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795682; x=1728400482;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dTFKu82vESr8yr6vd4vi7LjlIE8ld4GmyUnMyrhfJQ=;
        b=hKSXO+mRIp8enlTbHwMsRLpEwBzxgG6nzN4BQSF7/ZIzi2qc1FuS6RmwTpffDBlPA2
         zxnHFk26u0gCJQc8z35gkMokJ0WxYupV6f3qC5KFeZSdaVxSPKmLwwgDSw1xRieGXNPY
         krOnyJKgyoMqfL6lq+HiXGDANgcDx5L62s8SpsnFGIgFcTN4E9HHJ0LQWHXSf837AeKv
         hkDT96YKrZWTl+ovKn3yHTbzbp9E8VYbKfXUjOrAHQc6IU01Qqm/y43GUEJNGUM3+qWk
         eRvBA1FN0op35f3BMsdeOZSUBZ1dDAXjeHBppyXxBvyyXRFB1j857+3RI0GxWiNczvCO
         Qdnw==
X-Forwarded-Encrypted: i=1; AJvYcCWHjuRa0U+s/MqsxR/vOYn/s7xrCYeegEewLc1bfdlSdx2+WjlMsvH8fp9PThAN6lhwWq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwreN2Pi1DMJvZCM06QwBjlYrpB43TPQRM+Dlg1Hs3JU612hSZc
	SKAsqQUORwug6U0zcLm00drxuE0K7LjENanF2Uv1NB6sb2mmgEOHO4UYmlBsroSBGweL5wwshDQ
	gjtasvutwc4YmkOltcRSNLKSt5hiG7rgNUNQWN6AE2XzB2VW2QA==
X-Received: by 2002:a5d:45c7:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-37cd5a87904mr7597247f8f.17.1727795681861;
        Tue, 01 Oct 2024 08:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcXOE3tocH8XOJc5qBA0lGHo9gNU2YLoseuv0UbAszC4jNN0/YfSTwqn7BqZ62Nm2YhPL5iA==
X-Received: by 2002:a5d:45c7:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-37cd5a87904mr7597230f8f.17.1727795681407;
        Tue, 01 Oct 2024 08:14:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565dff6sm12022029f8f.30.2024.10.01.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:14:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 045F71580155; Tue, 01 Oct 2024 17:14:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Arthur Fabre <afabre@cloudflare.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me,
 tariqt@nvidia.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 mst@redhat.com, jasowang@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel-team <kernel-team@cloudflare.com>,
 Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
In-Reply-To: <ZvwNQqN4gez1Ksfn@lore-desk>
References: <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk> <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <ZvbKDT-2xqx2unrx@lore-rh-laptop> <871q11s91e.fsf@toke.dk>
 <ZvqQOpqnK9hBmXNn@lore-desk> <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
 <ZvwNQqN4gez1Ksfn@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Oct 2024 17:14:39 +0200
Message-ID: <87zfnnq2hs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
>> > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> > > 
>> > > >> > We could combine such a registration API with your header format, so
>> > > >> > that the registration just becomes a way of allocating one of the keys
>> > > >> > from 0-63 (and the registry just becomes a global copy of the header).
>> > > >> > This would basically amount to moving the "service config file" into the
>> > > >> > kernel, since that seems to be the only common denominator we can rely
>> > > >> > on between BPF applications (as all attempts to write a common daemon
>> > > >> > for BPF management have shown).
>> > > >> 
>> > > >> That sounds reasonable. And I guess we'd have set() check the global
>> > > >> registry to enforce that the key has been registered beforehand?
>> > > >> 
>> > > >> >
>> > > >> > -Toke
>> > > >> 
>> > > >> Thanks for all the feedback!
>> > > >
>> > > > I like this 'fast' KV approach but I guess we should really evaluate its
>> > > > impact on performances (especially for xdp) since, based on the kfunc calls
>> > > > order in the ebpf program, we can have one or multiple memmove/memcpy for
>> > > > each packet, right?
>> > > 
>> > > Yes, with Arthur's scheme, performance will be ordering dependent. Using
>> > > a global registry for offsets would sidestep this, but have the
>> > > synchronisation issues we discussed up-thread. So on balance, I think
>> > > the memmove() suggestion will probably lead to the least pain.
>> > > 
>> > > For the HW metadata we could sidestep this by always having a fixed
>> > > struct for it (but using the same set/get() API with reserved keys). The
>> > > only drawback of doing that is that we statically reserve a bit of
>> > > space, but I'm not sure that is such a big issue in practice (at least
>> > > not until this becomes to popular that the space starts to be contended;
>> > > but surely 256 bytes ought to be enough for everybody, right? :)).
>> >
>> > I am fine with the proposed approach, but I think we need to verify what is the
>> > impact on performances (in the worst case??)
>> 
>> If drivers are responsible for populating the hardware metadata before
>> XDP, we could make sure drivers set the fields in order to avoid any
>> memove() (and maybe even provide a helper to ensure this?).
>
> nope, since the current APIs introduced by Stanislav are consuming NIC
> metadata in kfuncs (mainly for af_xdp) and, according to my understanding,
> we want to add a kfunc to store the info for each NIC metadata (e.g rx-hash,
> timestamping, ..) into the packet (this is what Toke is proposing, right?).
> In this case kfunc calling order makes a difference.
> We can think even to add single kfunc to store all the info for all the NIC
> metadata (maybe via a helping struct) but it seems not scalable to me and we
> are losing kfunc versatility.

Yes, I agree we should have separate kfuncs for each metadata field.
Which means it makes a lot of sense to just use the same setter API that
we use for the user-registered metadata fields, but using reserved keys.
So something like:

#define BPF_METADATA_HW_HASH      BIT(60)
#define BPF_METADATA_HW_TIMESTAMP BIT(61)
#define BPF_METADATA_HW_VLAN      BIT(62)
#define BPF_METADATA_RESERVED (0xffff << 48)

bpf_packet_metadata_set(pkt, BPF_METADATA_HW_HASH, hash_value);


As for the internal representation, we can just have the kfunc do
something like:

int bpf_packet_metadata_set(field_id, value) {
  switch(field_id) {
    case BPF_METADATA_HW_HASH:
      pkt->xdp_hw_meta.hash = value;
      break;
    [...]
    default:
      /* do the key packing thing */
  }
}


that way the order of setting the HW fields doesn't matter, only the
user-defined metadata.

>> > > > Moreover, I still think the metadata area in the xdp_frame/xdp_buff is not
>> > > > so suitable for nic hw metadata since:
>> > > > - it grows backward 
>> > > > - it is probably in a different cacheline with respect to xdp_frame
>> > > > - nic hw metadata will not start at fixed and immutable address, but it depends
>> > > >   on the running ebpf program
>> > > >
>> > > > What about having something like:
>> > > > - fixed hw nic metadata: just after xdp_frame struct (or if you want at the end
>> > > >   of the metadata area :)). Here he can reuse the same KV approach if it is fast
>> > > > - user defined metadata: in the metadata area of the xdp_frame/xdp_buff
>> > > 
>> > > AFAIU, none of this will live in the (current) XDP metadata area. It
>> > > will all live just after the xdp_frame struct (so sharing the space with
>> > > the metadata area in the sense that adding more metadata kv fields will
>> > > decrease the amount of space that is usable by the current XDP metadata
>> > > APIs).
>> > > 
>> > > -Toke
>> > > 
>> >
>> > ah, ok. I was thinking the proposed approach was to put them in the current
>> > metadata field.
>> 
>> I've also been thinking of putting this new KV stuff at the start of the
>> headroom (I think that's what you're saying Toke?). It has a few nice
>> advantanges:
>> 
>> * It coexists nicely with the current XDP / TC metadata support.
>> Those users won't be able to overwrite / corrupt the KV metadata.
>> KV users won't need to call xdp_adjust_meta() (which would be awkward -
>> how would they know how much space the KV implementation needs).

Yes, that was what I was saying; we need this to co-exist with the
existing xdp_adjust_meta() facility, and moving it back and forth to
achieve that seems like a non-starter. So definitely at the start of the
headroom (after xdp_frame).

>> * We don't have to move all the metadata everytime we call
>> xdp_adjust_head() (or the kernel equivalent).
>> 
>> Are there any performance implications of that, e.g. for caching?

Well, putting it at the beginning means that the HW metadata (assuming
that comes first) will be on the same cache line as the xdp_frame struct
itself (and thus should be cache-hot). For user-defined metadata it will
depend on the size, of course, it will probably end up stilling into the
next cache line (which will affect performance), but I don't think that
can be helped...

-Toke


