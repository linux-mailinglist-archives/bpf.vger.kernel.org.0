Return-Path: <bpf+bounces-41193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E999408A
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D431C2596B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75072010F5;
	Tue,  8 Oct 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MXRdpNSy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07331FF7D5
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371764; cv=none; b=nQytOVJQXLtnV6p7183vEx5sYnNUZmuEYRlSt9CUS2pzVRDl+WNZutJE/8Tz7I8KKechhWuXO0+wph47s960xZInvOgwelq2E5lKwgoX/H73+nNfuIEdodjtdC46TXQ9qTZw1ZCp55PPDCl0Poz114b4AW6uv7x8szY02B2uuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371764; c=relaxed/simple;
	bh=VFjX1QavLeLzJwyUCKTDugF+FWb3RbCevKvof29zq78=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iMR91EC7CMDP0/muS21kePj9gpoozOCIaXrvpnXrIVWQW6JolK1y+rhxpgZrhXbIbVThM4x+KSRYOj+CgruM7EPt678yYoO4LQZIS/T8R/jNSJHZKQG0XLswgjUB1xkRAP8xlQRNQVv5yE3qlPOxYJUN5vcDy7IyTGVW3irywYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MXRdpNSy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so54321205e9.1
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 00:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728371759; x=1728976559; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2ueIGZGFFuijyr+mi84RMycpanED72itl8B8kGLf0A=;
        b=MXRdpNSyD8Jlq19ig7miW+dvvBtMZP2sMLM7M974egVjIE4VAjRzhEifhRsLlp/OxH
         xErBYZlAijv15p9f+CeyHi415ik7/UF6F3ZTLOhvFEpyLCo2D2lUhTpCziwgRR/1/YZe
         XWUXkBMSYA6bmp3YppfbB3DGmTfa+c7FqcMUedbbfBiWdxkZyu+PGbKtY0Ih4zuQxxEO
         kBFBky7sK1M0MqRpb3Dj8e2CvaBoV8n3BcJ4ivJLTj87J5ifM6J3pK54aaE2ooUp++Zj
         G37xGOyZ+FhvKwpx/UPtcmSKyWDy37gUPuiDNCTfH9VUt36W1Y7xHWupahl7IFPaIP0G
         4THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371759; x=1728976559;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S2ueIGZGFFuijyr+mi84RMycpanED72itl8B8kGLf0A=;
        b=f40HH8lONBOPCAUwc+/mkGiqKfFdksV71dnFSwucImrAkea1JsebTmHVOFihP1Bw+i
         ZKam+Orgpa4UM0tYBr9Cb+o4vwF+LjINikvymuwwnYo8hLyUY2I7wkUGvc/GDLLctHuY
         XSPk6rKitKfrbsq23uwid2gShW9UI7nnWPXdJPpp+e5atH9Hts4Cvzq5ce+Dx7UTiQ/H
         /wIEmdQqeKeJ22/uC0LLTUvN3bYLtB0iQOLiGtIv57y4VcegXtHIu5EVcxWbvJnqQbzF
         kWsIgGoJoar7r/BBwLVWfv80LhLn+DTjFr1ASA5oZ70mEVQGb2Ko+4GxNtKtCa4Me28l
         mLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9eytHZZDjz9shF+WeFcGKSkN5rAxSw7NrnT82FVG/qmllTgo4k1qreEwg9R1urYRmmwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mp1Vpst5CjaCVutnRgMFlVaCh3I+BgyMsym2XBJTXWBB25XO
	THsyKt9R0+nLnbpf7R1ntnpuDOGfNMDRMsEJ88CbDl03SYw4luupPmEtxjXjNn29EUzT25dQj6/
	R7xkQrg==
X-Google-Smtp-Source: AGHT+IHLIvf/mdkUVnE3YZebgoJmimuDbqbaYR4qzhNrK3mnyNkUciw2Q6Oqe3tYnWECPsRjHMl9cA==
X-Received: by 2002:a5d:5e0f:0:b0:37d:3256:76e4 with SMTP id ffacd0b85a97d-37d32567825mr266216f8f.11.1728371759077;
        Tue, 08 Oct 2024 00:15:59 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::241:66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f767sm7340969f8f.20.2024.10.08.00.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 09:15:56 +0200
Message-Id: <D4Q8NJRMZCYY.QRM4L1W95PE2@bobby>
Cc: "Jesper Dangaard Brouer" <hawk@kernel.org>, "Daniel Xu" <dxu@dxuuu.xyz>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "Lorenzo Bianconi"
 <lorenzo.bianconi@redhat.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <davem@davemloft.net>, <kuba@kernel.org>, <john.fastabend@gmail.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <sdf@fomichev.me>,
 <tariqt@nvidia.com>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <mst@redhat.com>, <jasowang@redhat.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, "kernel-team" <kernel-team@cloudflare.com>,
 "Yan Zhai" <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Stanislav Fomichev" <stfomichev@gmail.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: aerc 0.8.2
References: <87zfnnq2hs.fsf@toke.dk> <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk> <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby> <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
 <ZwArrsqrYx7IM5tq@mini-arch> <87ldz1edaz.fsf@toke.dk>
 <ZwQtAHpg2LB-7en_@mini-arch>
In-Reply-To: <ZwQtAHpg2LB-7en_@mini-arch>

On Mon Oct 7, 2024 at 8:48 PM CEST, Stanislav Fomichev wrote:
> On 10/06, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Stanislav Fomichev <stfomichev@gmail.com> writes:
> >=20
> > > On 10/04, Jesper Dangaard Brouer wrote:
> > >>=20
> > >>=20
> > >> On 04/10/2024 04.13, Daniel Xu wrote:
> > >> > On Thu, Oct 03, 2024 at 01:26:08PM GMT, Stanislav Fomichev wrote:
> > >> > > On 10/03, Arthur Fabre wrote:
> > >> > > > On Thu Oct 3, 2024 at 12:49 AM CEST, Stanislav Fomichev wrote:
> > >> > > > > On 10/02, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > >> > > > > > Stanislav Fomichev <stfomichev@gmail.com> writes:
> > >> > > > > >=20
> > >> > > > > > > On 10/01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > >> > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > >> > > > > > > >=20
> > >> > > > > > > > > > On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianc=
oni wrote:
> > >> > > > > > > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > >> > > > > > > > > > > >=20
> > >> [...]
> > >> > > > > > > > > > > > >=20
> > >> > > > > > > > > > > > > I like this 'fast' KV approach but I guess w=
e should really evaluate its
> > >> > > > > > > > > > > > > impact on performances (especially for xdp) =
since, based on the kfunc calls
> > >> > > > > > > > > > > > > order in the ebpf program, we can have one o=
r multiple memmove/memcpy for
> > >> > > > > > > > > > > > > each packet, right?
> > >> > > > > > > > > > > >=20
> > >> > > > > > > > > > > > Yes, with Arthur's scheme, performance will be=
 ordering dependent. Using
> > >>=20
> > >> I really like the *compact* Key-Value (KV) store idea from Arthur.
> > >>  - The question is it is fast enough?
> > >>=20
> > >> I've promised Arthur to XDP micro-benchmark this, if he codes this u=
p to
> > >> be usable in the XDP code path.  Listening to the LPC recording I he=
ard
> > >> that Alexei also saw potential and other use-case for this kind of
> > >> fast-and-compact KV approach.
> > >>=20
> > >> I have high hopes for the performance, as Arthur uses POPCNT instruc=
tion
> > >> which is *very* fast[1]. I checked[2] AMD Zen 3 and 4 have Ops/Laten=
cy=3D1
> > >> and Reciprocal throughput 0.25.
> > >>=20
> > >>  [1] https://www.agner.org/optimize/blog/read.php?i=3D853#848
> > >>  [2] https://www.agner.org/optimize/instruction_tables.pdf
> > >>=20
> > >> [...]
> > >> > > > There are two different use-cases for the metadata:
> > >> > > >=20
> > >> > > > * "Hardware" metadata (like the hash, rx_timestamp...). There =
are only a
> > >> > > >    few well known fields, and only XDP can access them to set =
them as
> > >> > > >    metadata, so storing them in a struct somewhere could make =
sense.
> > >> > > >=20
> > >> > > > * Arbitrary metadata used by services. Eg a TC filter could se=
t a field
> > >> > > >    describing which service a packet is for, and that could be=
 reused for
> > >> > > >    iptables, routing, socket dispatch...
> > >> > > >    Similarly we could set a "packet_id" field that uniquely id=
entifies a
> > >> > > >    packet so we can trace it throughout the network stack (thr=
ough
> > >> > > >    clones, encap, decap, userspace services...).
> > >> > > >    The skb->mark, but with more room, and better support for s=
haring it.
> > >> > > >=20
> > >> > > > We can only know the layout ahead of time for the first one. A=
nd they're
> > >> > > > similar enough in their requirements (need to be stored somewh=
ere in the
> > >> > > > SKB, have a way of retrieving each one individually, that it s=
eems to
> > >> > > > make sense to use a common API).
> > >> > >=20
> > >> > > Why not have the following layout then?
> > >> > >=20
> > >> > > +---------------+-------------------+---------------------------=
-------------+------+
> > >> > > | more headroom | user-defined meta | hw-meta (potentially fixed=
 skb format) | data |
> > >> > > +---------------+-------------------+---------------------------=
-------------+------+
> > >> > >                  ^                                              =
              ^
> > >> > >              data_meta                                          =
            data
> > >> > >=20
> > >> > > You obviously still have a problem of communicating the layout i=
f you
> > >> > > have some redirects in between, but you, in theory still have th=
is
> > >> > > problem with user-defined metadata anyway (unless I'm missing
> > >> > > something).
> > >> > >=20
> > >>=20
> > >> Hmm, I think you are missing something... As far as I'm concerned we=
 are
> > >> discussing placing the KV data after the xdp_frame, and not in the X=
DP
> > >> data_meta area (as your drawing suggests).  The xdp_frame is stored =
at
> > >> the very top of the headroom.  Lorenzo's patchset is extending struc=
t
> > >> xdp_frame and now we are discussing to we can make a more flexible A=
PI
> > >> for extending this. I understand that Toke confirmed this here [3]. =
 Let
> > >> me know if I missed something :-)
> > >>=20
> > >>  [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
> > >>
> > >> As part of designing this flexible API, we/Toke are trying hard not =
to
> > >> tie this to a specific data area.  This is a good API design, keepin=
g it
> > >> flexible enough that we can move things around should the need arise=
.
> > >>=20
> > >> I don't think it is viable to store this KV data in XDP data_meta ar=
ea,
> > >> because existing BPF-prog's already have direct memory (write) acces=
s
> > >> and can change size of area, which creates too much headache with
> > >> (existing) BPF-progs creating unintentional breakage for the KV stor=
e,
> > >> which would then need extensive checks to handle random corruptions
> > >> (slowing down KV-store code).
> > >
> > > Yes, I'm definitely missing the bigger picture. If we want to have a =
global
> > > metadata registry in the kernel, why can't it be built on top of the =
existing
> > > area?
> >=20
> > Because we have no way of preventing existing XDP programs from
> > overwriting (corrupting) the area using the xdp_adjust_meta() API and
> > data_meta field.
>
> True, but this can be solved with some new BPF_F_XDP_HAS_FRAGS-like
> flag (which can reject loading if there is some incompatibility)?
> Even in the new KV-metadata world, 2+ programs still need to be
> aware of the new method to work correctly. But I do see your point
> that it's better to not apply any metadata than apply something
> that's corrupt/overridden.

Currently the new KV-metadata will be tied to XDP, because most NICs only
reserve enough headroom if an XDP program is attached.

But longer-term, I'm hoping to lift this restriction to let users not using
XDP (eg using TC only, or other hook points) use the KV metadata too.
Enabling it with an XDP flag would make that hard.

We also want to store the new KV metadata at the start of the headroom=20
(right after xdp_frame) so that we don't have to move it for every=20
xdp_adjust_head() call.

That makes it very easy for them to coexist, it's just a few bounds
checks when we grow each one.

> > But in a sense the *memory area* is shared between the two APIs, in the
> > sense that they both use the headroom before the packet data, just from
> > opposite ends. So if you store lots of data using the new KV API, that
> > space will no longer be available for xdp_adjust_{head,meta}. But the
> > kernel can enforce this so we don't get programs corrupting the KV
> > format.
>
> Ack, let's see how it shapes out. My main concern comes from the
> growing api surface where for af_xdp it's one mechanism, for xdp
> redirect it's another. And for Jakub's consumption from userspace
> it's gonna be another special case probably (to read it out from the
> headroom head)? Idk, maybe it's fine as long as each case is clearly
> documented.

You're right, there's going to be relatively big API surface. Hopefully
the APIs should all be very similar, and we'll document them.

