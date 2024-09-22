Return-Path: <bpf+bounces-40176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A1397E255
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DA828118D
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B51A276;
	Sun, 22 Sep 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZB66Ba8O"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A936173
	for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727019661; cv=none; b=lZhpMVoF6KKZtNSTfy5ZW9th6PBHyOQUODoQN6vtHvnpQK3AVvYUku7kQwxjLE5wO6pHvi8BHSCwAq5TRV2IUY4LQCyUw60zpNztuirjLw6InxtuFmEuRLO9a4jLY41RpDAI5OrWIAwFTN1EsD7pUzXYbG10Yf9Nyrmjm2DXOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727019661; c=relaxed/simple;
	bh=Q8g1Df1iiuUB75PxnMU9SiRf5q78k5IAphF1rQq1JPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdSov4lKREoo0c7YyMlOpEI0thI8XXZfZtHdUnKgckbO2AyzsFUt526jhBkQ5M50R0N2vQoKMA7A9uYAs3I7g7Db6w8b/5NVWlv1R9TT89Kzln6w9z+PQzGtGkMvL3nECmBu1cllYk6v2TlfYT1ZVarHLqB4OjkGh7mvd9NFAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZB66Ba8O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727019657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wwkF4IUVlf79iY2PJ/Wd+ewK2HX+t/6KRXI+BJdx6c=;
	b=ZB66Ba8OFIjl48LFqPYXemejLsPCsEqBvDMoRZvVdKiqGtcLVNl/asgRaqPlqF0r7xeFkq
	p2AWcI7JgDO+w0Sh/uFsgvq6/zonUPdXhSx/9fZIgU42hOO2QyXXZRgv4/3iNB/B5ZwSII
	GDhQMshvy/lg+MF+DCQUhpdEmaljb+c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-7dCeS4brNYCXpnao-D64Gw-1; Sun, 22 Sep 2024 11:40:55 -0400
X-MC-Unique: 7dCeS4brNYCXpnao-D64Gw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb471a230so27741515e9.3
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 08:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727019655; x=1727624455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wwkF4IUVlf79iY2PJ/Wd+ewK2HX+t/6KRXI+BJdx6c=;
        b=FbI458V248m+m7pCY1zr7nxRiDXn1CXqJRb+z1XO35iIprr0Nmti7NAWgPSqJsWpax
         3kWjaRkxbccaabIgiKKay0D/XUXCqQOv9PK9lbd8bf/p4jIveF56HWqF5EWC2H65aqQ2
         ebhasXTfKJWsAJBFEE604EIcJnGMN0Etp85oeU/ghy5zohjFnrKW2Oo1KfPlvS2kEvyq
         ZJxR4GxooS+/c+8pbrF+EqZ2eAuZ59DXfh7MftsRuBYsKoqe5LomS5i6D/ppjoepg+DD
         zIcm9rHc+nw5zXmfFDcaAoLrVYfZqPQOHSFDYesKPLcS7ONzMJlDlIYS0RnudiIPYEvk
         YATg==
X-Forwarded-Encrypted: i=1; AJvYcCXmH9W+5W91gs5v11dnSlDQVwJw440VaIo0wtsQdGY8F56wWYh7U+elRXC0kRJmYvJEvlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ye/SM5txWte1fJE8XQr1XxcZ0ICRKLhHwM0SoJhcixezRiwd
	NuSVB96Po5+zurSN1+PBKLWVOB2SjidjssmnfmsDPyGaIVkoFsZBlGZljrzVJJbfU0HvC5ClSyB
	8yL4zemjpC24V4y8jWF3lsXBaY+Q6h3dY2M61OKMDL/hbUbA7aA==
X-Received: by 2002:a05:600c:4ecb:b0:42c:b3e5:f688 with SMTP id 5b1f17b1804b1-42e7abe51cfmr61320335e9.4.1727019654553;
        Sun, 22 Sep 2024 08:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh/eKA1KD1kMCztKLB338qt5lKEJSj1ocoe2VW6C9heK/uVWgB6X4kqalC4QXVD1RltLp2Xw==
X-Received: by 2002:a05:600c:4ecb:b0:42c:b3e5:f688 with SMTP id 5b1f17b1804b1-42e7abe51cfmr61320025e9.4.1727019653970;
        Sun, 22 Sep 2024 08:40:53 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7aff08b1sm77992755e9.40.2024.09.22.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:40:53 -0700 (PDT)
Date: Sun, 22 Sep 2024 17:40:52 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Arthur Fabre <afabre@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, john.fastabend@gmail.com,
	edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me,
	tariqt@nvidia.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
	mst@redhat.com, jasowang@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <ZvA6hIl6XWJ4UEJW@lore-desk>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk>
 <87ldzkndqk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r0wGTV4GKkZs/miU"
Content-Disposition: inline
In-Reply-To: <87ldzkndqk.fsf@toke.dk>


--r0wGTV4GKkZs/miU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
>=20
> >>=20
> >>=20
> >> On 21/09/2024 22.17, Alexander Lobakin wrote:
> >> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> >> > Date: Sat, 21 Sep 2024 18:52:56 +0200
> >> >=20
> >> > > This series introduces the xdp_rx_meta struct in the xdp_buff/xdp_=
frame
> >> >=20
> >> > &xdp_buff is on the stack.
> >> > &xdp_frame consumes headroom.
> >> >=20
> >> > IOW they're size-sensitive and putting metadata directly there might
> >> > play bad; if not now, then later.
> >> >=20
> >> > Our idea (me + Toke) was as follows:
> >> >=20
> >> > - new BPF kfunc to build generic meta. If called, the driver builds a
> >> >    generic meta with hash, csum etc., in the data_meta area.
> >>=20
> >> I do agree that it should be the XDP prog (via a new BPF kfunc) that
> >> decide if xdp_frame should be updated to contain a generic meta struct.
> >> *BUT* I think we should use the xdp_frame area, and not the
> >> xdp->data_meta area.
> >
> > ack, I will add a new kfunc for it.
> >
> >>=20
> >> A details is that I think this kfunc should write data directly into
> >> xdp_frame area, even then we are only operating on the xdp_buff, as we
> >> do have access to the area xdp_frame will be created in.
> >
> > this would avoid to copy it when we convert from xdp_buff to xdp_frame,=
 nice :)
> >
> >>=20
> >>=20
> >> When using data_meta area, then netstack encap/decap needs to move the
> >> data_meta area (extra cycles).  The xdp_frame area (live in top) don't
> >> have this issue.
> >>=20
> >> It is easier to allow xdp_frame area to survive longer together with t=
he
> >> SKB. Today we "release" this xdp_frame area to be used by SKB for extra
> >> headroom (see xdp_scrub_frame).  I can imagine that we can move SKB
> >> fields to this area, and reduce the size of the SKB alloc. (This then
> >> becomes the mini-SKB we discussed a couple of years ago).
> >>=20
> >>=20
> >> >    Yes, this also consumes headroom, but only when the corresponding=
 func
> >> >    is called. Introducing new fields like you're doing will consume =
it
> >> >    unconditionally;
> >>=20
> >> We agree on the kfunc call marks area as consumed/in-use.  We can exte=
nd
> >> xdp_frame statically like Lorenzo does (with struct xdp_rx_meta), but
> >> xdp_frame->flags can be used for marking this area as used or not.
> >
> > the only downside with respect to a TLV approach would be to consume al=
l the
> > xdp_rx_meta as soon as we set a single xdp rx hw hint in it, right?
> > The upside is it is easier and it requires less instructions.
>=20
> FYI, we also had a discussion related to this at LPC on Friday, in this
> session: https://lpc.events/event/18/contributions/1935/

Hi Toke,

thx for the pointer

>=20
> The context here was that Arthur and Jakub want to also support extended
> rich metadata all the way through the SKB path, and are looking at the
> same area used for XDP metadata to store it. So there's a need to manage
> both the kernel's own usage of that area, and userspace/BPF usage of it.

it would be cool if we can collaborate on it.

>=20
> I'll try to summarise some of the points of that discussion (all
> interpretations are my own, of course):
>=20
> - We want something that can be carried with a frame all the way from
>   the XDP layer, through all SKB layers and to userspace (to replace the
>   use of skb->mark for this purpose).
>=20
> - We want different applications running on the system (of which the
>   kernel itself if one, cf this discussion) to be able to share this
>   field, without having to have an out of band registry (like a Github
>   repository where applications can agree on which bits to use). Which
>   probably means that the kernel needs to be in the loop somehow to
>   explicitly allocate space in the metadata area and track offsets.
>=20
> - Having an explicit API to access this from userspace, without having
>   to go through BPF (i.e., a socket- or CMSG-based API) would be useful.
>=20
>=20
> The TLV format was one of the suggestions in Arthur and Jakub's talk,
> but AFAICT, there was not a lot of enthusiasm about this in the room
> (myself included), because of the parsing overhead and complexity. I
> believe the alternative that was seen as most favourable was a map
> lookup-style API, where applications can request a metadata area of
> arbitrary size and get an ID assigned that they can then use to set/get
> values in the data path.
>=20
> So, sketching this out, this could be realised by something like:
>=20
> /* could be called from BPF, or through netlink or sysfs; may fail, if
>  * there is no more space
>  */
> int metadata_id =3D register_packet_metadata_field(sizeof(struct my_meta)=
);
>=20
> The ID is just an opaque identifier that can then be passed to
> getter/setter functions (for both SKB and XDP), like:
>=20
> ret =3D bpf_set_packet_metadata_field(pkt, metadata_id,
>                                     &my_meta_value, sizeof(my_meta_value))
>=20
> ret =3D bpf_get_packet_metadata_field(pkt, metadata_id,
>                                     &my_meta_value, sizeof(my_meta_value))
>=20
>=20
> On the kernel side, the implementation would track registered fields in
> a global structure somewhere, say:
>=20
> struct pkt_metadata_entry {
>   int id;
>   u8 sz;
>   u8 offset;
>   u8 bit;
> };
>=20
> struct pkt_metadata_registry { /* allocated as a system-wide global */
>   u8 num_entries;
>   u8 total_size;
>   struct pkt_metadata_entry entries[MAX_ENTRIES];
> };
>=20
> struct xdp_rx_meta { /* at then end of xdp_frame */
>   u8 sz; /* set to pkt_metadata_registry->total_size on alloc */
>   u8 fields_set; /* bitmap of fields that have been set, see below */
>   u8 data[];
> };
>=20
> int register_packet_metadata_field(u8 size) {
>   struct pkt_metadata_registry *reg =3D get_global_registry();
>   struct pkt_metadata_entry *entry;
>=20
>   if (size + reg->total_size > MAX_METADATA_SIZE)
>     return -ENOSPC;
>=20
>   entry =3D &reg->entries[reg->num_entries++];
>   entry->id =3D assign_id();
>   entry->sz =3D size;
>   entry->offset =3D reg->total_size;
>   entry->bit =3D reg->num_entries - 1;
>   reg->total_size +=3D size;
>=20
>   return entry->id;
> }
>=20
> int bpf_set_packet_metadata_field(struct xdp_frame *frm, int id, void
>                                   *value, size_t sz)
> {
>   struct pkt_metadata_entry *entry =3D get_metadata_entry_by_id(id);
>=20
>   if (!entry)
>     return -ENOENT;
>=20
>   if (entry->sz !=3D sz)
>     return -EINVAL; /* user error */
>=20
>   if (frm->rx_meta.sz < entry->offset + sz)
>     return -EFAULT; /* entry allocated after xdp_frame was initialised */
>=20
>   memcpy(&frm->rx_meta.data + entry->offset, value, sz);
>   frm->rx_meta.fields_set |=3D BIT(entry->bit);
>=20
>   return 0;
> }
>=20
> int bpf_get_packet_metadata_field(struct xdp_frame *frm, int id, void
>                                   *value, size_t sz)
> {
>   struct pkt_metadata_entry *entry =3D get_metadata_entry_by_id(id);
>=20
>   if (!entry)
>     return -ENOENT;
>=20
>   if (entry->sz !=3D sz)
>     return -EINVAL;
>=20
> if (frm->rx_meta.sz < entry->offset + sz)
>     return -EFAULT; /* entry allocated after xdp_frame was initialised */
>=20
>   if (!(frm->rx_meta.fields_set & BIT(entry->bit)))
>     return -ENOENT;
>=20
>   memcpy(value, &frm->rx_meta.data + entry->offset, sz);
>=20
>   return 0;
> }
>=20
> I'm hinting at some complications here (with the EFAULT return) that
> needs to be resolved: there is no guarantee that a given packet will be
> in sync with the current status of the registered metadata, so we need
> explicit checks for this. If metadata entries are de-registered again
> this also means dealing with holes and/or reshuffling the metadata
> layout to reuse the released space (incidentally, this is the one place
> where a TLV format would have advantages).

I like this approach but it seems to me more suitable for 'sw' metadata
(this is main Arthur and Jakub use case iiuc) where the userspace would
enable/disable these functionalities system-wide.
Regarding device hw metadata (e.g. checksum offload) I can see some issues
since on a system we can have multiple NICs with different capabilities.
If we consider current codebase, stmmac driver supports only rx timestamp,
while mlx5 supports all of them. In a theoretical system with these two
NICs, since pkt_metadata_registry is global system-wide, we will end-up
with quite a lot of holes for the stmmac, right? (I am not sure if this
case is relevant or not). In other words, we will end-up with a fixed
struct for device rx hw metadata (like xdp_rx_meta). So I am wondering
if we really need all this complexity for xdp rx hw metadata?
Maybe we can start with a simple approach for xdp rx hw metadata putting
the struct in xdp_frame as suggested by Jesper and covering the most common
use-cases. We can then integrate this approach with Arthur/Jakub's solution
without introducing any backward compatibility issue since these field are
not visible to userspace.

Regards,
Lorenzo

>=20
> The nice thing about an API like this, though, is that it's extensible,
> and the kernel itself can be just another consumer of it for the
> metadata fields Lorenzo is adding in this series. I.e., we could just
> pre-define some IDs for metadata vlan, timestamp etc, and use the same
> functions as above from within the kernel to set and get those values;
> using the registry, there could even be an option to turn those off if
> an application wants more space for its own usage. Or, alternatively, we
> could keep the kernel-internal IDs hardcoded and always allocated, and
> just use the getter/setter functions as the BPF API for accessing them.
>=20
> -Toke
>=20

--r0wGTV4GKkZs/miU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZvA6hAAKCRA6cBh0uS2t
rDRxAQCn2noFP6UHLAUDBDUiAvq0PM6CAYg6l6nN9HUAlaENBQD+NIqsDKRPNUAE
9qc9yFhgY75XxmiPZU0QXVmgHUw1Wgo=
=8hYC
-----END PGP SIGNATURE-----

--r0wGTV4GKkZs/miU--


