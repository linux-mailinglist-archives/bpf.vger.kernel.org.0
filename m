Return-Path: <bpf+bounces-40354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6C9876C5
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5F31F2115B
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 15:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C995154BF8;
	Thu, 26 Sep 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rkaz+OfZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4714831C
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365461; cv=none; b=GCGOFllt0M0ymfSrxIcsPsurHCOc1PnPxksLwIv7d0Ev0+PTifAx6TxpO5qRRmFOTsID7rz6gjkB4G4b8Gu8q01GsBQg3V9B2gJvPIOa5mY4X/1Uatn5xneF8M9ZNpIXIllIojvPi5J+RqxOY800Ct/FLQoKZhdPROeU3Lf78WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365461; c=relaxed/simple;
	bh=V7sco5O5qB56BGSBcT9rW9EZrtTdvjYXQMTkKn7cs2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=XWpcH9vpSDODOVZR4rzEFwL/6YwCsGg5iHBLeu/Tal5RYrllUDSkb6woLEtT2f28HEwDhs8+5wQ6MiKpszaxlAaD8EIwwst1ttcTGk0wOYB5UjXAWRk5lOtmr/Lzbx5tzDUMaqVjeABDbg3lbwEbesP5v3YZVVNisXtoudcu2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Rkaz+OfZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so9863225e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727365458; x=1727970258; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNlMFgplqP/YLhq+yU75GYVgkPfXUNExVYq5uXGpLuI=;
        b=Rkaz+OfZVbQ/kfUnGhUucrBmqY+6c3NXAO+tb06a0w1wHPA87TMaIXWAumWNnabdrN
         6WbySG8fWYEAsRwpaabb4yZuijAB1EO8IWtoG5Z+Fc9Y3pUo9sEWtL02itOFPoLgOeNM
         UzmdQjENUtlXlq17PVdVi9zr73WxlH99QghRbAkxHv/rRvemhc9mC0zNLkjSZLgUzEak
         EhYtPq+16P56SguMqwLla0PNy/kFRXymwna8F6AqbTP9hZxkSPl+hABhY1rbHyodaHKo
         Kg4kIGMWyIP2m9rypsnSEP8XDgBz/NBiHQc7WuEwlc/deMpGMUJYeea0d0MkC1UJ05VH
         TeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365458; x=1727970258;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNlMFgplqP/YLhq+yU75GYVgkPfXUNExVYq5uXGpLuI=;
        b=EOalq4WnF4MF2kLsDuqqfiLaJJ41k7uqEw52RILxBMdjgNeHhG6VRw3EqCjCK14Hg2
         RTLFougklXKPPONmjaEJOZhx2L3wBF/dsmrJUBohKYTWK4ANN8b2JwJkNv0Yf67VJxdm
         KBYw7r2etyY+baTLed4Lesyc6AUP4lw7NIKbhPYAMEX2qIf0mh8eZrw43duk6wCJWiZS
         kAOsPNKnwoneDLIm4h+oojLL/i4qpmWnoVVkdfzAQtxjRZfcC3LnyReE34ULHQkRAx0a
         wOgKBLDBC1On9IT04oUlXGyuBM4Tkf+/b8GbOKB0eFhKy1HtaKXx13FaQ/jnOZTNNatZ
         QrcA==
X-Forwarded-Encrypted: i=1; AJvYcCXArfdOH05y29ai4Dt5Icn+dRHOxsseGaCy1+AtYxPlbuQfJDgm/6AK2XPrK8JpcLZuZ0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4TIaFYbOdHjDbtso2GX1ymZlFt5XegRGU+Qsd4QY4cRTwdxw
	uSIlcWY4mzbwsgaFSCEEQOq+yxMwGpEojng3NHwFgYmUGF7P1lhfgm7D5n0XSsw=
X-Google-Smtp-Source: AGHT+IGyE1pjonqHvE2ATI51frD2AHm4pKSiUS1utLMDSat91vi11lCEoW0NRAy2aH/BvzAGF5+pig==
X-Received: by 2002:a5d:5d86:0:b0:37c:c5b4:8b1e with SMTP id ffacd0b85a97d-37cc5b48bddmr3456423f8f.22.1727365457760;
        Thu, 26 Sep 2024 08:44:17 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::241:20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fbd3sm126802f8f.84.2024.09.26.08.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 08:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Sep 2024 17:44:15 +0200
Message-Id: <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
From: "Arthur Fabre" <afabre@cloudflare.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>, "Lorenzo Bianconi"
 <lorenzo@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <kuba@kernel.org>, <john.fastabend@gmail.com>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sdf@fomichev.me>, <tariqt@nvidia.com>,
 <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <mst@redhat.com>, <jasowang@redhat.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, "kernel-team" <kernel-team@cloudflare.com>,
 "Yan Zhai" <yan@cloudflare.com>
X-Mailer: aerc 0.8.2
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk>
In-Reply-To: <87wmiysi37.fsf@toke.dk>

On Thu Sep 26, 2024 at 2:41 PM CEST, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> Arthur Fabre <afabre@cloudflare.com> writes:
>
> > On Sun, Sep 22, 2024 at 1:12=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >> FYI, we also had a discussion related to this at LPC on Friday, in thi=
s
> >> session: https://lpc.events/event/18/contributions/1935/
> >>
> >> The context here was that Arthur and Jakub want to also support extend=
ed
> >> rich metadata all the way through the SKB path, and are looking at the
> >> same area used for XDP metadata to store it. So there's a need to mana=
ge
> >> both the kernel's own usage of that area, and userspace/BPF usage of i=
t.
> >>
> >> I'll try to summarise some of the points of that discussion (all
> >> interpretations are my own, of course):
> >>
> >> - We want something that can be carried with a frame all the way from
> >>   the XDP layer, through all SKB layers and to userspace (to replace t=
he
> >>   use of skb->mark for this purpose).
> >>
> >> - We want different applications running on the system (of which the
> >>   kernel itself if one, cf this discussion) to be able to share this
> >>   field, without having to have an out of band registry (like a Github
> >>   repository where applications can agree on which bits to use). Which
> >>   probably means that the kernel needs to be in the loop somehow to
> >>   explicitly allocate space in the metadata area and track offsets.
> >>
> >> - Having an explicit API to access this from userspace, without having
> >>   to go through BPF (i.e., a socket- or CMSG-based API) would be usefu=
l.
> >>
> >
> > Thanks for looping us in, and the great summary Toke!
>
> You're welcome :)
>
> >> The TLV format was one of the suggestions in Arthur and Jakub's talk,
> >> but AFAICT, there was not a lot of enthusiasm about this in the room
> >> (myself included), because of the parsing overhead and complexity. I
> >> believe the alternative that was seen as most favourable was a map
> >> lookup-style API, where applications can request a metadata area of
> >> arbitrary size and get an ID assigned that they can then use to set/ge=
t
> >> values in the data path.
> >>
> >> So, sketching this out, this could be realised by something like:
> >>
> >> /* could be called from BPF, or through netlink or sysfs; may fail, if
> >>  * there is no more space
> >>  */
> >> int metadata_id =3D register_packet_metadata_field(sizeof(struct my_me=
ta));
> >>
> >> The ID is just an opaque identifier that can then be passed to
> >> getter/setter functions (for both SKB and XDP), like:
> >>
> >> ret =3D bpf_set_packet_metadata_field(pkt, metadata_id,
> >>                                     &my_meta_value, sizeof(my_meta_val=
ue))
> >>
> >> ret =3D bpf_get_packet_metadata_field(pkt, metadata_id,
> >>                                     &my_meta_value, sizeof(my_meta_val=
ue))
> >>
> >>
> >> On the kernel side, the implementation would track registered fields i=
n
> >> a global structure somewhere, say:
> >>
> >> struct pkt_metadata_entry {
> >>   int id;
> >>   u8 sz;
> >>   u8 offset;
> >>   u8 bit;
> >> };
> >>
> >> struct pkt_metadata_registry { /* allocated as a system-wide global */
> >>   u8 num_entries;
> >>   u8 total_size;
> >>   struct pkt_metadata_entry entries[MAX_ENTRIES];
> >> };
> >>
> >> struct xdp_rx_meta { /* at then end of xdp_frame */
> >>   u8 sz; /* set to pkt_metadata_registry->total_size on alloc */
> >>   u8 fields_set; /* bitmap of fields that have been set, see below */
> >>   u8 data[];
> >> };
> >>
> >> int register_packet_metadata_field(u8 size) {
> >>   struct pkt_metadata_registry *reg =3D get_global_registry();
> >>   struct pkt_metadata_entry *entry;
> >>
> >>   if (size + reg->total_size > MAX_METADATA_SIZE)
> >>     return -ENOSPC;
> >>
> >>   entry =3D &reg->entries[reg->num_entries++];
> >>   entry->id =3D assign_id();
> >>   entry->sz =3D size;
> >>   entry->offset =3D reg->total_size;
> >>   entry->bit =3D reg->num_entries - 1;
> >>   reg->total_size +=3D size;
> >>
> >>   return entry->id;
> >> }
> >>
> >> int bpf_set_packet_metadata_field(struct xdp_frame *frm, int id, void
> >>                                   *value, size_t sz)
> >> {
> >>   struct pkt_metadata_entry *entry =3D get_metadata_entry_by_id(id);
> >>
> >>   if (!entry)
> >>     return -ENOENT;
> >>
> >>   if (entry->sz !=3D sz)
> >>     return -EINVAL; /* user error */
> >>
> >>   if (frm->rx_meta.sz < entry->offset + sz)
> >>     return -EFAULT; /* entry allocated after xdp_frame was initialised=
 */
> >>
> >>   memcpy(&frm->rx_meta.data + entry->offset, value, sz);
> >>   frm->rx_meta.fields_set |=3D BIT(entry->bit);
> >>
> >>   return 0;
> >> }
> >>
> >> int bpf_get_packet_metadata_field(struct xdp_frame *frm, int id, void
> >>                                   *value, size_t sz)
> >> {
> >>   struct pkt_metadata_entry *entry =3D get_metadata_entry_by_id(id);
> >>
> >>   if (!entry)
> >>     return -ENOENT;
> >>
> >>   if (entry->sz !=3D sz)
> >>     return -EINVAL;
> >>
> >> if (frm->rx_meta.sz < entry->offset + sz)
> >>     return -EFAULT; /* entry allocated after xdp_frame was initialised=
 */
> >>
> >>   if (!(frm->rx_meta.fields_set & BIT(entry->bit)))
> >>     return -ENOENT;
> >>
> >>   memcpy(value, &frm->rx_meta.data + entry->offset, sz);
> >>
> >>   return 0;
> >> }
> >>
> >> I'm hinting at some complications here (with the EFAULT return) that
> >> needs to be resolved: there is no guarantee that a given packet will b=
e
> >> in sync with the current status of the registered metadata, so we need
> >> explicit checks for this. If metadata entries are de-registered again
> >> this also means dealing with holes and/or reshuffling the metadata
> >> layout to reuse the released space (incidentally, this is the one plac=
e
> >> where a TLV format would have advantages).
> >>
> >> The nice thing about an API like this, though, is that it's extensible=
,
> >> and the kernel itself can be just another consumer of it for the
> >> metadata fields Lorenzo is adding in this series. I.e., we could just
> >> pre-define some IDs for metadata vlan, timestamp etc, and use the same
> >> functions as above from within the kernel to set and get those values;
> >> using the registry, there could even be an option to turn those off if
> >> an application wants more space for its own usage. Or, alternatively, =
we
> >> could keep the kernel-internal IDs hardcoded and always allocated, and
> >> just use the getter/setter functions as the BPF API for accessing them=
.
> >
> > That's exactly what I'm thinking of too, a simple API like:
> >
> > get(u8 key, u8 len, void *val);
> > set(u8 key, u8 len, void *val);
> >
> > With "well-known" keys like METADATA_ID_HW_HASH for hardware metadata.
> >
> > If a NIC doesn't support a certain well-known metadata, the key
> > wouldn't be set, and get() would return ENOENT.
> >
> > I think this also lets us avoid having to "register" keys or bits of
> > metadata with the kernel.
> > We'd reserve some number of keys for hardware metadata.
>
> Right, but how do you allocate space/offset for each key without an
> explicit allocation step? You'd basically have to encode the list of IDs
> in the metadata area itself, which implies a TLV format that you have to
> walk on every access? The registry idea in my example above was
> basically to avoid that...

I've been playing around with having a small fixed header at the front
of the metadata itself, that lets you access values without walking them
all.

Still WIP, and maybe this is too restrictive, but it lets you encode 64
2, 4, or 8 byte KVs with a single 16 byte header:

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <errno.h>
#include <string.h>

/**
 * Very limited KV support:
 *
 * - Keys: 0-63. (TBD which are reserved for the kernel)
 * - Value size: 2, 4, or 8.
 *=20
 * But compact, uses a fixed 16 byte header only.
 * Reasonably fast access.
 * Insertion and deletion need a memmove (entries have to be sorted), but i=
t's ~100s of bytes of max.
 *
 * TODO - should we support more sizes? Can switch to three bits per entry.
 * TODO - should we support a 0 size to just the presence / absence of key =
without a value?
 */
bool valid_len(uint8_t len) {
    return len =3D=3D 2 || len =3D=3D 4 || len =3D=3D 8;
}

bool valid_key(uint8_t key) {
    return key < 64;
}

// Fixed header at the start of the meta area.
struct hdr {
    // 2 bit length is stored for each key:
    //  a high bit in the high word.
    //  a low bit in the low word.
    // Key itself is the bit position in each word, LSb 0.
    // This lets us count the bits in high and low to easily
    // calculate the sum of the preceeding KVs lengths.
    uint64_t high;
    uint64_t low;
};

int total_length(struct hdr h) {
    // TODO - is this builtin allowed in kernel code?
    return (__builtin_popcountll(h.high) << 2) + (__builtin_popcountll(h.lo=
w) << 1);
}

struct hdr and(struct hdr h, uint64_t mask) {
    return (struct hdr){
        h.high & mask,
        h.low & mask,
    };
}

int offset(struct hdr h, uint8_t key) {
    // Calculate total length of previous keys by masking out keys after.
    return sizeof(struct hdr) + total_length(and(h, ~(~0llu << key)));
}

// TODO - is headroom zero initialized?
#define META_LEN (sizeof(struct hdr) + 128)
uint8_t meta[META_LEN];

int set(uint8_t key, uint8_t len, void *val) {
    if (!valid_key(key)) {
        return -EINVAL;
    }
    if (!valid_len(len)) {
        return -EINVAL;
    }

    struct hdr *h =3D (struct hdr *)meta;

    // Figure out if we have enough room left: total length of everything n=
ow.
    if (sizeof(struct hdr) + total_length(*h) + len > sizeof(meta)) {
        return -ENOMEM;
    }

    // Offset of value of this key.
    int off =3D offset(*h, key);

    // Memmove all the kvs after us over.
    memmove(meta+off+len, meta+off, sizeof(meta)-off);

    // Set our value.
    memcpy(meta+off, val, len);

    // Store our length in header.
    uint64_t encode_len =3D 0;
    switch (len) {
    case 2:
        encode_len =3D 1;
        break;
    case 4:
        encode_len =3D 2;
        break;
    case 8:
        encode_len =3D 3;
        break;
    }
    h->high |=3D (encode_len >> 1) << key;
    h->low |=3D (encode_len & 1) << key;

    return 0;
}

// Callers need to know the format ahead of time,
// so they'll know the length too.
// We just check the buffer is big enough for the value.
int get(uint8_t key, uint8_t len, void *val) {
    if (!valid_key(key)) {
        return -EINVAL;
    }
    if (!valid_len(len)) {
        return -EINVAL;
    }

    struct hdr h =3D *(struct hdr *)meta;

    // Check key is set.
    if (!((h.high & (1ull << key)) || (h.low & (1ull << key)))) {
        return -ENOENT;
    }

    // Offset of value of this key.
    int off =3D offset(h, key);

    // Figure out our length.
    int real_len =3D total_length(and(h, (1ull << key)));

    if (real_len > len) {
        return -EFBIG;
    }

    memcpy(val, meta+off, real_len);
    return 0;
}

int del(uint8_t key) {
    if (!valid_key(key)) {
        return -EINVAL;
    }

    struct hdr *h =3D (struct hdr *)meta;

    // Check key is set.
    if (!((h->high & (1ull << key)) || (h->low & (1ull << key)))) {
        return -ENOENT;
    }

    // Offset and length of value of this key.
    int off =3D offset(*h, key);
    int len =3D total_length(and(*h, (1ull << key)));

    // Memmove all the kvs after us over.
    memmove(meta+off, meta+off+len, sizeof(meta)-off-len);

    // Clear our length in header.
    h->high &=3D ~(1ull << key);
    h->low &=3D ~(1ull << key);
    return 0;
}

>
> > The remaining keys would be up to users. They'd have to allocate keys
> > to services, and configure services to use those keys.
> > This is similar to the way listening on a certain port works: only one
> > service can use port 80 or 443, and that can typically beconfigured in
> > a service's config file.
>
> Right, well, port numbers *do* actually have an out of band service
> registry (IANA), which I thought was what we wanted to avoid? ;)

Depends how you think about it ;)

I think we should avoid a global registry. But having a registry per
deployment / server doesn't seem awful. Services that want to use a
field would have a config file setting to set which index it corresponds
to.
Admins would just have to pick a free one on their system, and set it in
the config file of the service.

This is similar to what we do for non-IANA registered ports internally.
For example each service needs a port on an internal interface to expose
metrics, and we just track which ports are taken in our config
management.

Dynamically registering fields means you have to share the returned ID
with whoever is interested, which sounds tricky.
If an XDP program sets a field like packet_id, every tracing
program that looks at it, and userspace service, would need to know what
the ID of that field is.
Is there a way to easily share that ID with all of them?

>
> > This side-steps the whole question of how to change the registered
> > metadata for in-flight packets, and how to deal with different NICs
> > with different hardware metadata.
> >
> > I think I've figured out a suitable encoding format, hopefully we'll
> > have an RFC soon!
>
> Alright, cool!
>
> -Toke


