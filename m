Return-Path: <bpf+bounces-40174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F497E10C
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 13:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C51C20B27
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F116719307E;
	Sun, 22 Sep 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUsdjS2c"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186C1420DD
	for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727003581; cv=none; b=QaMFVmz/5NjQ8bAOC88g7mg4IEPyucEXsNuZ5z8jQPRgIwPwf7Hy73pdDPVS2y+Ogs8ZsRDtfvRc8bnMOx/T25xvBKfDqKLTBQ+NTWj8gZ4k23T5c20rMOTIA40Y1QdTjZLu44jJdHDXf2mAHGka9mb9sqHRZOekG3yBTZyjsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727003581; c=relaxed/simple;
	bh=+dnOGf2jNKhOuBP2Vs118vVAnQueKIe8GELlsD8XP8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BFza3u2PjvVqRsqMON/oWDVKXLNUhfYTawZRoNlYl5prejq3G2vTNyodx0ivTi0Gr6PsSXH6rW/QbHHReEOV3AczzKpptEH5rzP7tYTHtsEB5i4l9sUX/jmHlFvMMz9a+VZCTLDxsyjlfc1up/5xQA5jElcosMWRCk1iWwUTLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUsdjS2c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727003578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GbIg/W7PN6QRKq8OkNaoprJd23O4LShI0s3EFhauIE=;
	b=SUsdjS2c4kZqDpYyzPQjAI60gIKFEB5Ul8cTW9RiOzIqwrxRk6XtE3edXXdaQhv4GvUMOb
	Nw823FiePgTpxg9JsCiq4Nchwl3U9cY2AVKHUC3QokjIMooOR4FXUzrqP2booQ6fhvQbTx
	tJbuPeY42DKb2J0i9ikNrJtjkEjTu24=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ZFKDutkdNGWCwH0JcyqpSQ-1; Sun, 22 Sep 2024 07:12:56 -0400
X-MC-Unique: ZFKDutkdNGWCwH0JcyqpSQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7d2d414949so261366166b.0
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 04:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727003575; x=1727608375;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GbIg/W7PN6QRKq8OkNaoprJd23O4LShI0s3EFhauIE=;
        b=dlP4+l+Tr/MSsafgeIPMJVncEjU4aDjmsyzkWedxURXKofpQ8GPxGnrbdHftMcVtWe
         TcrIRLwFbziouh9hF+kob5wbcgkFE+/vuVz/46lbhZVMhDJIhDtLr0avqxeow/h69o/z
         vJJvt9w/agJzu9WJCdEh0oyhSYnPFgTq3JX2AgHUAFcsVB7u6ZEckf+WPGiwpFjxy8Ro
         ro2q4WHykx6efOJV9K1dAlwLxjLLxNzh9iuwNiiM3mWDdZuAc0PMk7ymzMhnbXX4bByV
         67Lik82jz6st62Z/Fqtt2E3O4ED3PgiHr/s7hhWHn+keybkqeymmqxl9GMnW3Xvs86tG
         uujA==
X-Forwarded-Encrypted: i=1; AJvYcCUd2+PVJuHHTeAugT9cU8BvTZNwtntrErSSCuCqwYmhWt83PbW3H7eZ8PdaRQzACR21Af4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8ckrGD/ckwZNKkW9G08FeGsgTZhvNv364w7Uj3m2ZHBQw6ly
	Ih5eLdBFLSkbivLqY87wi+MQ1aBmxTHF5N2DYDkN4Mlq9pBFZS5wWeJVwzUU1YIaADRRIiZICSi
	4GQEC1Vch4RKbh/A9JhJhzo5tZxKb25CW68mKkzEQ4ec6p/ab7A==
X-Received: by 2002:a17:907:928a:b0:a86:78fd:1df0 with SMTP id a640c23a62f3a-a90d562206bmr870729466b.34.1727003575431;
        Sun, 22 Sep 2024 04:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYhXGcTRkbaV5483odfYCMi2PaOl6gjAcqkLrOEgNokoh/A2poiFUcWQyHrsAHvnxxdBc9+A==
X-Received: by 2002:a17:907:928a:b0:a86:78fd:1df0 with SMTP id a640c23a62f3a-a90d562206bmr870725566b.34.1727003574855;
        Sun, 22 Sep 2024 04:12:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f44fasm1070152966b.79.2024.09.22.04.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 04:12:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A3600157F92A; Sun, 22 Sep 2024 13:12:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Arthur Fabre <afabre@cloudflare.com>, Jakub Sitnicki
 <jakub@cloudflare.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, john.fastabend@gmail.com, edumazet@google.com,
 pabeni@redhat.com, sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, mst@redhat.com, jasowang@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, kernel-team
 <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
In-Reply-To: <Zu_gvkXe4RYjJXtq@lore-desk>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sun, 22 Sep 2024 13:12:51 +0200
Message-ID: <87ldzkndqk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> 
>> 
>> On 21/09/2024 22.17, Alexander Lobakin wrote:
>> > From: Lorenzo Bianconi <lorenzo@kernel.org>
>> > Date: Sat, 21 Sep 2024 18:52:56 +0200
>> > 
>> > > This series introduces the xdp_rx_meta struct in the xdp_buff/xdp_frame
>> > 
>> > &xdp_buff is on the stack.
>> > &xdp_frame consumes headroom.
>> > 
>> > IOW they're size-sensitive and putting metadata directly there might
>> > play bad; if not now, then later.
>> > 
>> > Our idea (me + Toke) was as follows:
>> > 
>> > - new BPF kfunc to build generic meta. If called, the driver builds a
>> >    generic meta with hash, csum etc., in the data_meta area.
>> 
>> I do agree that it should be the XDP prog (via a new BPF kfunc) that
>> decide if xdp_frame should be updated to contain a generic meta struct.
>> *BUT* I think we should use the xdp_frame area, and not the
>> xdp->data_meta area.
>
> ack, I will add a new kfunc for it.
>
>> 
>> A details is that I think this kfunc should write data directly into
>> xdp_frame area, even then we are only operating on the xdp_buff, as we
>> do have access to the area xdp_frame will be created in.
>
> this would avoid to copy it when we convert from xdp_buff to xdp_frame, nice :)
>
>> 
>> 
>> When using data_meta area, then netstack encap/decap needs to move the
>> data_meta area (extra cycles).  The xdp_frame area (live in top) don't
>> have this issue.
>> 
>> It is easier to allow xdp_frame area to survive longer together with the
>> SKB. Today we "release" this xdp_frame area to be used by SKB for extra
>> headroom (see xdp_scrub_frame).  I can imagine that we can move SKB
>> fields to this area, and reduce the size of the SKB alloc. (This then
>> becomes the mini-SKB we discussed a couple of years ago).
>> 
>> 
>> >    Yes, this also consumes headroom, but only when the corresponding func
>> >    is called. Introducing new fields like you're doing will consume it
>> >    unconditionally;
>> 
>> We agree on the kfunc call marks area as consumed/in-use.  We can extend
>> xdp_frame statically like Lorenzo does (with struct xdp_rx_meta), but
>> xdp_frame->flags can be used for marking this area as used or not.
>
> the only downside with respect to a TLV approach would be to consume all the
> xdp_rx_meta as soon as we set a single xdp rx hw hint in it, right?
> The upside is it is easier and it requires less instructions.

FYI, we also had a discussion related to this at LPC on Friday, in this
session: https://lpc.events/event/18/contributions/1935/

The context here was that Arthur and Jakub want to also support extended
rich metadata all the way through the SKB path, and are looking at the
same area used for XDP metadata to store it. So there's a need to manage
both the kernel's own usage of that area, and userspace/BPF usage of it.

I'll try to summarise some of the points of that discussion (all
interpretations are my own, of course):

- We want something that can be carried with a frame all the way from
  the XDP layer, through all SKB layers and to userspace (to replace the
  use of skb->mark for this purpose).

- We want different applications running on the system (of which the
  kernel itself if one, cf this discussion) to be able to share this
  field, without having to have an out of band registry (like a Github
  repository where applications can agree on which bits to use). Which
  probably means that the kernel needs to be in the loop somehow to
  explicitly allocate space in the metadata area and track offsets.

- Having an explicit API to access this from userspace, without having
  to go through BPF (i.e., a socket- or CMSG-based API) would be useful.


The TLV format was one of the suggestions in Arthur and Jakub's talk,
but AFAICT, there was not a lot of enthusiasm about this in the room
(myself included), because of the parsing overhead and complexity. I
believe the alternative that was seen as most favourable was a map
lookup-style API, where applications can request a metadata area of
arbitrary size and get an ID assigned that they can then use to set/get
values in the data path.

So, sketching this out, this could be realised by something like:

/* could be called from BPF, or through netlink or sysfs; may fail, if
 * there is no more space
 */
int metadata_id = register_packet_metadata_field(sizeof(struct my_meta));

The ID is just an opaque identifier that can then be passed to
getter/setter functions (for both SKB and XDP), like:

ret = bpf_set_packet_metadata_field(pkt, metadata_id,
                                    &my_meta_value, sizeof(my_meta_value))

ret = bpf_get_packet_metadata_field(pkt, metadata_id,
                                    &my_meta_value, sizeof(my_meta_value))


On the kernel side, the implementation would track registered fields in
a global structure somewhere, say:

struct pkt_metadata_entry {
  int id;
  u8 sz;
  u8 offset;
  u8 bit;
};

struct pkt_metadata_registry { /* allocated as a system-wide global */
  u8 num_entries;
  u8 total_size;
  struct pkt_metadata_entry entries[MAX_ENTRIES];
};

struct xdp_rx_meta { /* at then end of xdp_frame */
  u8 sz; /* set to pkt_metadata_registry->total_size on alloc */
  u8 fields_set; /* bitmap of fields that have been set, see below */
  u8 data[];
};

int register_packet_metadata_field(u8 size) {
  struct pkt_metadata_registry *reg = get_global_registry();
  struct pkt_metadata_entry *entry;

  if (size + reg->total_size > MAX_METADATA_SIZE)
    return -ENOSPC;

  entry = &reg->entries[reg->num_entries++];
  entry->id = assign_id();
  entry->sz = size;
  entry->offset = reg->total_size;
  entry->bit = reg->num_entries - 1;
  reg->total_size += size;

  return entry->id;
}

int bpf_set_packet_metadata_field(struct xdp_frame *frm, int id, void
                                  *value, size_t sz)
{
  struct pkt_metadata_entry *entry = get_metadata_entry_by_id(id);

  if (!entry)
    return -ENOENT;

  if (entry->sz != sz)
    return -EINVAL; /* user error */

  if (frm->rx_meta.sz < entry->offset + sz)
    return -EFAULT; /* entry allocated after xdp_frame was initialised */

  memcpy(&frm->rx_meta.data + entry->offset, value, sz);
  frm->rx_meta.fields_set |= BIT(entry->bit);

  return 0;
}

int bpf_get_packet_metadata_field(struct xdp_frame *frm, int id, void
                                  *value, size_t sz)
{
  struct pkt_metadata_entry *entry = get_metadata_entry_by_id(id);

  if (!entry)
    return -ENOENT;

  if (entry->sz != sz)
    return -EINVAL;

if (frm->rx_meta.sz < entry->offset + sz)
    return -EFAULT; /* entry allocated after xdp_frame was initialised */

  if (!(frm->rx_meta.fields_set & BIT(entry->bit)))
    return -ENOENT;

  memcpy(value, &frm->rx_meta.data + entry->offset, sz);

  return 0;
}

I'm hinting at some complications here (with the EFAULT return) that
needs to be resolved: there is no guarantee that a given packet will be
in sync with the current status of the registered metadata, so we need
explicit checks for this. If metadata entries are de-registered again
this also means dealing with holes and/or reshuffling the metadata
layout to reuse the released space (incidentally, this is the one place
where a TLV format would have advantages).

The nice thing about an API like this, though, is that it's extensible,
and the kernel itself can be just another consumer of it for the
metadata fields Lorenzo is adding in this series. I.e., we could just
pre-define some IDs for metadata vlan, timestamp etc, and use the same
functions as above from within the kernel to set and get those values;
using the registry, there could even be an option to turn those off if
an application wants more space for its own usage. Or, alternatively, we
could keep the kernel-internal IDs hardcoded and always allocated, and
just use the getter/setter functions as the BPF API for accessing them.

-Toke


