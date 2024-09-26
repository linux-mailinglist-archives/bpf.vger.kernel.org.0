Return-Path: <bpf+bounces-40350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384559873BB
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78A5286F7B
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 12:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137F33C5;
	Thu, 26 Sep 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhRS2hOF"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60E28FC
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727354484; cv=none; b=AUQCffhvEijfzomR/aYvm5nIXytngB2YTmm3gqndmJ8X1Win5pyTsNdlFR7HIuwTGGvWIloCL2g3UZQyiIs4pM6Oi8PTTGQqLxDLSgECZaoc95cLn8lII6QHl0nQuMriM8Ku1vKg+wYH8ccRA5RqkueqnkQCbJbDo5Sw8N2XZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727354484; c=relaxed/simple;
	bh=m/CQ7UyTh5YrazEQXAfjD4KDPsBQ2/B1d9qjwy5ZB/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L3c8t1K4wbUaBYOsc/HNQJOAyB6lxVhrwiIIWb3zrWCuYh9Sg91bT4L7qan7SALaiKsVxGROaQQWJQm0uCPxrk+VXHk89UjUFB+AGg8CQdh++ZlOne/MoOi63tArSHZThjXUL7l3QZo9IEBg+lCkiZaLeSrfV2pe8WNibfyHZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AhRS2hOF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727354481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMJHYB8zqZmlZP20Oy49Gu05ZzldjET+scQ2w87XeYU=;
	b=AhRS2hOFGes4LzCHY772cIRdCXrl1yGWzqxqnolD1fByiXlSMOjwvmjXGHpYaPBaOSLY9Q
	V1dXfjNZhNFnbIZkv2Xt96UU/oTh8oD42ZbOcM+RmAfiW+o7qDRGrxIMf6KJOEAMnzSFpy
	8JgsMnczyS/7SauC1rjKYXE3p//SSFY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-EzOEJyusNkWvXXs0Movnwg-1; Thu, 26 Sep 2024 08:41:20 -0400
X-MC-Unique: EzOEJyusNkWvXXs0Movnwg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d1a00e0beso116295466b.0
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 05:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727354479; x=1727959279;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMJHYB8zqZmlZP20Oy49Gu05ZzldjET+scQ2w87XeYU=;
        b=Lns6EmSQ2O2va02+oppJZr1HoOX7JoUF5BmgJepCw4+nIfQTKiqrPEszvfcBVVwZEw
         uoN1G6d9b4wi+mEQidPZBKRkCHUHOT9WxHwx9IRsWO4tZ2UXeCEoUi+OfDO0JfwtyUvt
         icQhFDroXfNEq9re30h4IflS/pJiLSyZI72y+3uQSNTbioP6wcNMDDRfrZjX9/Td4/Es
         iH/B6TTcNVnutVErbQ5vH77txY1E0wg1oiLqrvFYUXIo+m6VKEa9appP3AUrW6M4RTTj
         bhf3eS49uSfx8dCcNXxXBT6NzDfSP9yfIdldZrfAoLasJ08nXEyUsDEHuF/ABth6nxUM
         OjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsW5zQo96Z/B1iGgeuO/B8DbRRnuugpLxJnYZuFTaNNEn/8ZEF+fToQB6GsXJMsOdjJ1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9lJVatmAEGE4+1QC9L7gSKIZh7+AXKy8lvO414yqZ68BSsmB
	JCsyW7738zNLDM+DlKvU+KZl1XftxhsOBkJB0vY11X0WEF6jWrSFRVYBM5CHbAOoaM50vn3kAxz
	Tk1QwGxwlebJhSjwd9unjTdZ0hYcJGb21pQkyXx0qzuASSyJYEA==
X-Received: by 2002:a17:907:7d9e:b0:a8a:754a:e1c1 with SMTP id a640c23a62f3a-a93b15d4060mr279766966b.8.1727354478953;
        Thu, 26 Sep 2024 05:41:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXJToynjae9rfSJhSBosAnZMFK/etnC+GhLgUSb8nc/h9oslSz0rwl720S6aFtTRC+xBUrFA==
X-Received: by 2002:a17:907:7d9e:b0:a8a:754a:e1c1 with SMTP id a640c23a62f3a-a93b15d4060mr279763966b.8.1727354478469;
        Thu, 26 Sep 2024 05:41:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f34976sm340030166b.45.2024.09.26.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:41:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A6C8D157FC7C; Thu, 26 Sep 2024 14:41:16 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Arthur Fabre <afabre@cloudflare.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
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
In-Reply-To: <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 26 Sep 2024 14:41:16 +0200
Message-ID: <87wmiysi37.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Arthur Fabre <afabre@cloudflare.com> writes:

> On Sun, Sep 22, 2024 at 1:12=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>> FYI, we also had a discussion related to this at LPC on Friday, in this
>> session: https://lpc.events/event/18/contributions/1935/
>>
>> The context here was that Arthur and Jakub want to also support extended
>> rich metadata all the way through the SKB path, and are looking at the
>> same area used for XDP metadata to store it. So there's a need to manage
>> both the kernel's own usage of that area, and userspace/BPF usage of it.
>>
>> I'll try to summarise some of the points of that discussion (all
>> interpretations are my own, of course):
>>
>> - We want something that can be carried with a frame all the way from
>>   the XDP layer, through all SKB layers and to userspace (to replace the
>>   use of skb->mark for this purpose).
>>
>> - We want different applications running on the system (of which the
>>   kernel itself if one, cf this discussion) to be able to share this
>>   field, without having to have an out of band registry (like a Github
>>   repository where applications can agree on which bits to use). Which
>>   probably means that the kernel needs to be in the loop somehow to
>>   explicitly allocate space in the metadata area and track offsets.
>>
>> - Having an explicit API to access this from userspace, without having
>>   to go through BPF (i.e., a socket- or CMSG-based API) would be useful.
>>
>
> Thanks for looping us in, and the great summary Toke!

You're welcome :)

>> The TLV format was one of the suggestions in Arthur and Jakub's talk,
>> but AFAICT, there was not a lot of enthusiasm about this in the room
>> (myself included), because of the parsing overhead and complexity. I
>> believe the alternative that was seen as most favourable was a map
>> lookup-style API, where applications can request a metadata area of
>> arbitrary size and get an ID assigned that they can then use to set/get
>> values in the data path.
>>
>> So, sketching this out, this could be realised by something like:
>>
>> /* could be called from BPF, or through netlink or sysfs; may fail, if
>>  * there is no more space
>>  */
>> int metadata_id =3D register_packet_metadata_field(sizeof(struct my_meta=
));
>>
>> The ID is just an opaque identifier that can then be passed to
>> getter/setter functions (for both SKB and XDP), like:
>>
>> ret =3D bpf_set_packet_metadata_field(pkt, metadata_id,
>>                                     &my_meta_value, sizeof(my_meta_value=
))
>>
>> ret =3D bpf_get_packet_metadata_field(pkt, metadata_id,
>>                                     &my_meta_value, sizeof(my_meta_value=
))
>>
>>
>> On the kernel side, the implementation would track registered fields in
>> a global structure somewhere, say:
>>
>> struct pkt_metadata_entry {
>>   int id;
>>   u8 sz;
>>   u8 offset;
>>   u8 bit;
>> };
>>
>> struct pkt_metadata_registry { /* allocated as a system-wide global */
>>   u8 num_entries;
>>   u8 total_size;
>>   struct pkt_metadata_entry entries[MAX_ENTRIES];
>> };
>>
>> struct xdp_rx_meta { /* at then end of xdp_frame */
>>   u8 sz; /* set to pkt_metadata_registry->total_size on alloc */
>>   u8 fields_set; /* bitmap of fields that have been set, see below */
>>   u8 data[];
>> };
>>
>> int register_packet_metadata_field(u8 size) {
>>   struct pkt_metadata_registry *reg =3D get_global_registry();
>>   struct pkt_metadata_entry *entry;
>>
>>   if (size + reg->total_size > MAX_METADATA_SIZE)
>>     return -ENOSPC;
>>
>>   entry =3D &reg->entries[reg->num_entries++];
>>   entry->id =3D assign_id();
>>   entry->sz =3D size;
>>   entry->offset =3D reg->total_size;
>>   entry->bit =3D reg->num_entries - 1;
>>   reg->total_size +=3D size;
>>
>>   return entry->id;
>> }
>>
>> int bpf_set_packet_metadata_field(struct xdp_frame *frm, int id, void
>>                                   *value, size_t sz)
>> {
>>   struct pkt_metadata_entry *entry =3D get_metadata_entry_by_id(id);
>>
>>   if (!entry)
>>     return -ENOENT;
>>
>>   if (entry->sz !=3D sz)
>>     return -EINVAL; /* user error */
>>
>>   if (frm->rx_meta.sz < entry->offset + sz)
>>     return -EFAULT; /* entry allocated after xdp_frame was initialised */
>>
>>   memcpy(&frm->rx_meta.data + entry->offset, value, sz);
>>   frm->rx_meta.fields_set |=3D BIT(entry->bit);
>>
>>   return 0;
>> }
>>
>> int bpf_get_packet_metadata_field(struct xdp_frame *frm, int id, void
>>                                   *value, size_t sz)
>> {
>>   struct pkt_metadata_entry *entry =3D get_metadata_entry_by_id(id);
>>
>>   if (!entry)
>>     return -ENOENT;
>>
>>   if (entry->sz !=3D sz)
>>     return -EINVAL;
>>
>> if (frm->rx_meta.sz < entry->offset + sz)
>>     return -EFAULT; /* entry allocated after xdp_frame was initialised */
>>
>>   if (!(frm->rx_meta.fields_set & BIT(entry->bit)))
>>     return -ENOENT;
>>
>>   memcpy(value, &frm->rx_meta.data + entry->offset, sz);
>>
>>   return 0;
>> }
>>
>> I'm hinting at some complications here (with the EFAULT return) that
>> needs to be resolved: there is no guarantee that a given packet will be
>> in sync with the current status of the registered metadata, so we need
>> explicit checks for this. If metadata entries are de-registered again
>> this also means dealing with holes and/or reshuffling the metadata
>> layout to reuse the released space (incidentally, this is the one place
>> where a TLV format would have advantages).
>>
>> The nice thing about an API like this, though, is that it's extensible,
>> and the kernel itself can be just another consumer of it for the
>> metadata fields Lorenzo is adding in this series. I.e., we could just
>> pre-define some IDs for metadata vlan, timestamp etc, and use the same
>> functions as above from within the kernel to set and get those values;
>> using the registry, there could even be an option to turn those off if
>> an application wants more space for its own usage. Or, alternatively, we
>> could keep the kernel-internal IDs hardcoded and always allocated, and
>> just use the getter/setter functions as the BPF API for accessing them.
>
> That's exactly what I'm thinking of too, a simple API like:
>
> get(u8 key, u8 len, void *val);
> set(u8 key, u8 len, void *val);
>
> With "well-known" keys like METADATA_ID_HW_HASH for hardware metadata.
>
> If a NIC doesn't support a certain well-known metadata, the key
> wouldn't be set, and get() would return ENOENT.
>
> I think this also lets us avoid having to "register" keys or bits of
> metadata with the kernel.
> We'd reserve some number of keys for hardware metadata.

Right, but how do you allocate space/offset for each key without an
explicit allocation step? You'd basically have to encode the list of IDs
in the metadata area itself, which implies a TLV format that you have to
walk on every access? The registry idea in my example above was
basically to avoid that...

> The remaining keys would be up to users. They'd have to allocate keys
> to services, and configure services to use those keys.
> This is similar to the way listening on a certain port works: only one
> service can use port 80 or 443, and that can typically beconfigured in
> a service's config file.

Right, well, port numbers *do* actually have an out of band service
registry (IANA), which I thought was what we wanted to avoid? ;)

> This side-steps the whole question of how to change the registered
> metadata for in-flight packets, and how to deal with different NICs
> with different hardware metadata.
>
> I think I've figured out a suitable encoding format, hopefully we'll
> have an RFC soon!

Alright, cool!

-Toke


