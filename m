Return-Path: <bpf+bounces-40345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAEC9872D6
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 13:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44D41C24D50
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 11:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07E1465A0;
	Thu, 26 Sep 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NenNtkBK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1F134BD
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350309; cv=none; b=XaXp6GWTWUbexVSp3BU7+tY3Eq7+WCGyA0EZEW3RNgVB3N8dr63m9qqIOt9ps1yM01jFZjnA9rgm3w35skvuXKmWgdbp57PfN4Iqay4OXfrewg2uKAJHzmqNCLFNWNEqWhcpCRmWQv+JpM6h8atvs0OAScM2wAGyNhb5At7s+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350309; c=relaxed/simple;
	bh=a1Xfl2vS/5d7z1ufv4GPfwBjQJzHsZPMu0mBuoejp70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwfNBEXqhlTXlqL8VYrYcJG5Wd93H7IObnjqf1Y7NRLtSTH+PrWkcWRjlBd+scrNL0KtCBdEvJyXaXHwqSX2Ipk9eDntpllz/FbuTGcN0LMHbNCnTkhRiLYiLZBne8x67hpxZY51zJY/OICbRpKY+8vqyXSy1aUiwrcOa9uaEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NenNtkBK; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-28706be9bd7so101584fac.2
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727350307; x=1727955107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvM6053l3hC75XR9JeT71cBHHY82737Z6/RTWNO0Vas=;
        b=NenNtkBKQRN4aRfYqUrTKSrgxnOY4MPCnlrqpDrvFlbfbKjTGd1Z2n13TK8wlcNstu
         UodJrFKiRPg1WNa1LFv5/ua1UI/o2LHAJRZrJ7pt0jN8+oS6FDHkkAnIKtWYy7E/QF/u
         yHB4wdRSh3bOcTnJzaQjQWqxMSq1sBu9aQCAsZ7WPsKkQkGuAq1pSRQxCmywM0bMPKrs
         DyGWOxC7wd/EGht2LPT4O5Z83H1cJnJV5iyFywBW8plkYT5nEjGgGs4N/Ie/5ILVsibr
         IqdS/sB7Q0B0uwMqixajf/WvG57Ik7ne2JSWjswyLIzbE21AljvEYZRorvEDfuNxCwmS
         tFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727350307; x=1727955107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvM6053l3hC75XR9JeT71cBHHY82737Z6/RTWNO0Vas=;
        b=goffl9BG9wuCj98VbtYPl4znr/pGIoni2eVBYaobkIFWNZwFx6zJPVfcrLJtpoT7WF
         mYoYGX4xeSGrYieS/4QSjiEb/GEPihHU7ojuvdKMl8sYX53SoYN+iwd1sfmRL/T7anly
         WwjYxjOCHoFXdgBmGDF0wzrBPv55zLt1Z2JIWCh0bl8f5sUiShCA2WEqc/ZQ8t3Cd36b
         WFGgiDB1jGx1coGLPzi/oyCIurX+U6olyOnvW58iNRd16V3GHGq9IuxDjYYMteH3YGCk
         /3sPyuM7L7RrAEMZfvEVcyHcVvlP6ZHMkvaRwlhrOl84XpC8ybx+lnfyghNlq/eIDhv2
         gijA==
X-Forwarded-Encrypted: i=1; AJvYcCXsXuMsXG35nlfkL8FIj2CoviH/MAAtIGdp23GO0Iksg8d2iTpBsgVhOIxNVYUTMkHGed0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOCu/e1Pi080WhN0eyQQYyoCIadsi9svulxXeBzr6jHheiy9u
	/TbuJqOvJiLpNKi6ZtDJV7i1VAWAGj+fsYTh/9DyVWTrCy15VVV8XX6+VQds086aqd2b5thKyl9
	SPfOqS8VF25lkDjdxN8HN1xIC7RlRPih8uHW3kA==
X-Google-Smtp-Source: AGHT+IHJjgBOQfQMiN/CUeToaqxQ7sdFEgOuujhoHJOkXUL6BboAbpYLTcebilxGue9vqbV0FYh52CYcX4NRivI+zgY=
X-Received: by 2002:a05:6870:e387:b0:278:32f:f171 with SMTP id
 586e51a60fabf-286e1443c02mr4694438fac.26.1727350306752; Thu, 26 Sep 2024
 04:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726935917.git.lorenzo@kernel.org> <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org> <Zu_gvkXe4RYjJXtq@lore-desk>
 <87ldzkndqk.fsf@toke.dk>
In-Reply-To: <87ldzkndqk.fsf@toke.dk>
From: Arthur Fabre <afabre@cloudflare.com>
Date: Thu, 26 Sep 2024 13:31:35 +0200
Message-ID: <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing XDP_REDIRECT
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, 
	john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com, 
	sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	intel-wired-lan@lists.osuosl.org, mst@redhat.com, jasowang@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	kernel-team <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 1:12=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
> FYI, we also had a discussion related to this at LPC on Friday, in this
> session: https://lpc.events/event/18/contributions/1935/
>
> The context here was that Arthur and Jakub want to also support extended
> rich metadata all the way through the SKB path, and are looking at the
> same area used for XDP metadata to store it. So there's a need to manage
> both the kernel's own usage of that area, and userspace/BPF usage of it.
>
> I'll try to summarise some of the points of that discussion (all
> interpretations are my own, of course):
>
> - We want something that can be carried with a frame all the way from
>   the XDP layer, through all SKB layers and to userspace (to replace the
>   use of skb->mark for this purpose).
>
> - We want different applications running on the system (of which the
>   kernel itself if one, cf this discussion) to be able to share this
>   field, without having to have an out of band registry (like a Github
>   repository where applications can agree on which bits to use). Which
>   probably means that the kernel needs to be in the loop somehow to
>   explicitly allocate space in the metadata area and track offsets.
>
> - Having an explicit API to access this from userspace, without having
>   to go through BPF (i.e., a socket- or CMSG-based API) would be useful.
>

Thanks for looping us in, and the great summary Toke!

> The TLV format was one of the suggestions in Arthur and Jakub's talk,
> but AFAICT, there was not a lot of enthusiasm about this in the room
> (myself included), because of the parsing overhead and complexity. I
> believe the alternative that was seen as most favourable was a map
> lookup-style API, where applications can request a metadata area of
> arbitrary size and get an ID assigned that they can then use to set/get
> values in the data path.
>
> So, sketching this out, this could be realised by something like:
>
> /* could be called from BPF, or through netlink or sysfs; may fail, if
>  * there is no more space
>  */
> int metadata_id =3D register_packet_metadata_field(sizeof(struct my_meta)=
);
>
> The ID is just an opaque identifier that can then be passed to
> getter/setter functions (for both SKB and XDP), like:
>
> ret =3D bpf_set_packet_metadata_field(pkt, metadata_id,
>                                     &my_meta_value, sizeof(my_meta_value)=
)
>
> ret =3D bpf_get_packet_metadata_field(pkt, metadata_id,
>                                     &my_meta_value, sizeof(my_meta_value)=
)
>
>
> On the kernel side, the implementation would track registered fields in
> a global structure somewhere, say:
>
> struct pkt_metadata_entry {
>   int id;
>   u8 sz;
>   u8 offset;
>   u8 bit;
> };
>
> struct pkt_metadata_registry { /* allocated as a system-wide global */
>   u8 num_entries;
>   u8 total_size;
>   struct pkt_metadata_entry entries[MAX_ENTRIES];
> };
>
> struct xdp_rx_meta { /* at then end of xdp_frame */
>   u8 sz; /* set to pkt_metadata_registry->total_size on alloc */
>   u8 fields_set; /* bitmap of fields that have been set, see below */
>   u8 data[];
> };
>
> int register_packet_metadata_field(u8 size) {
>   struct pkt_metadata_registry *reg =3D get_global_registry();
>   struct pkt_metadata_entry *entry;
>
>   if (size + reg->total_size > MAX_METADATA_SIZE)
>     return -ENOSPC;
>
>   entry =3D &reg->entries[reg->num_entries++];
>   entry->id =3D assign_id();
>   entry->sz =3D size;
>   entry->offset =3D reg->total_size;
>   entry->bit =3D reg->num_entries - 1;
>   reg->total_size +=3D size;
>
>   return entry->id;
> }
>
> int bpf_set_packet_metadata_field(struct xdp_frame *frm, int id, void
>                                   *value, size_t sz)
> {
>   struct pkt_metadata_entry *entry =3D get_metadata_entry_by_id(id);
>
>   if (!entry)
>     return -ENOENT;
>
>   if (entry->sz !=3D sz)
>     return -EINVAL; /* user error */
>
>   if (frm->rx_meta.sz < entry->offset + sz)
>     return -EFAULT; /* entry allocated after xdp_frame was initialised */
>
>   memcpy(&frm->rx_meta.data + entry->offset, value, sz);
>   frm->rx_meta.fields_set |=3D BIT(entry->bit);
>
>   return 0;
> }
>
> int bpf_get_packet_metadata_field(struct xdp_frame *frm, int id, void
>                                   *value, size_t sz)
> {
>   struct pkt_metadata_entry *entry =3D get_metadata_entry_by_id(id);
>
>   if (!entry)
>     return -ENOENT;
>
>   if (entry->sz !=3D sz)
>     return -EINVAL;
>
> if (frm->rx_meta.sz < entry->offset + sz)
>     return -EFAULT; /* entry allocated after xdp_frame was initialised */
>
>   if (!(frm->rx_meta.fields_set & BIT(entry->bit)))
>     return -ENOENT;
>
>   memcpy(value, &frm->rx_meta.data + entry->offset, sz);
>
>   return 0;
> }
>
> I'm hinting at some complications here (with the EFAULT return) that
> needs to be resolved: there is no guarantee that a given packet will be
> in sync with the current status of the registered metadata, so we need
> explicit checks for this. If metadata entries are de-registered again
> this also means dealing with holes and/or reshuffling the metadata
> layout to reuse the released space (incidentally, this is the one place
> where a TLV format would have advantages).
>
> The nice thing about an API like this, though, is that it's extensible,
> and the kernel itself can be just another consumer of it for the
> metadata fields Lorenzo is adding in this series. I.e., we could just
> pre-define some IDs for metadata vlan, timestamp etc, and use the same
> functions as above from within the kernel to set and get those values;
> using the registry, there could even be an option to turn those off if
> an application wants more space for its own usage. Or, alternatively, we
> could keep the kernel-internal IDs hardcoded and always allocated, and
> just use the getter/setter functions as the BPF API for accessing them.

That's exactly what I'm thinking of too, a simple API like:

get(u8 key, u8 len, void *val);
set(u8 key, u8 len, void *val);

With "well-known" keys like METADATA_ID_HW_HASH for hardware metadata.

If a NIC doesn't support a certain well-known metadata, the key
wouldn't be set, and get() would return ENOENT.

I think this also lets us avoid having to "register" keys or bits of
metadata with the kernel.
We'd reserve some number of keys for hardware metadata.

The remaining keys would be up to users. They'd have to allocate keys
to services, and configure services to use those keys.
This is similar to the way listening on a certain port works: only one
service can use port 80 or 443, and that can typically beconfigured in
a service's config file.

This side-steps the whole question of how to change the registered
metadata for in-flight packets, and how to deal with different NICs
with different hardware metadata.

I think I've figured out a suitable encoding format, hopefully we'll have a=
n
RFC soon!

> -Toke
>

