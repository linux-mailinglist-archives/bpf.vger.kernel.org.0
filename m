Return-Path: <bpf+bounces-59851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 857C9ACFF83
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 11:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517BA3B1C4D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E86286D53;
	Fri,  6 Jun 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsbKINYz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D6286D47
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202847; cv=none; b=g10bZwWGQK2EpEpwQaV9VdOfZJq3L/RsQEH9F8QeuHjCNRQaBYiflVDiWqXdya7KfHlsxwI73+EijG/iyRRZLmeytEdeIOZCx/Z3etDM1T2GWoiqaTVDIH1f3PQCWXKFzKHqMSm9UYRnAuqOKys9CVTBECGHqZhAj8qE9BRCDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202847; c=relaxed/simple;
	bh=PnuyZEF43PAaG6ER7b1YMQ31IpCLXqhEAlrLZbQXrG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwmiHl7+2063papboIbdfDlbup8rrfXpWE9xzLzHuNpPQLHmezMZqqKFyZ/XjMhmdsL9axCBLSf2xxMBIU+bvTbDkguRArbZtYMAeaveyz7ADlAdFmZvfkCwJJMZzT28R9zcJmCO+yKUPJcfrklGqIS9yOzavY8nzEiRfzJ28B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsbKINYz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so8963a12.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749202844; x=1749807644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAfTd10Yw9K2pZvfr2dRb9UAhgYnCFwO4TyYe6PRuSc=;
        b=DsbKINYzOMHiBlWUKnsmgf8+axxYICImRNi2MXXt0Y0MgwSzHxPwz76C6BqhnHeGyv
         3KMohnEVC6iAyxsL2MgOcjjgu8jcsdsHEEkcLjK66nonGXBErAu7K8TnDGdem6EUlEhu
         NxOtLGA2Oad1/7T+CYG9Spny9o7Jg/j4BUj5GFn9Z36XjJGJntKolP76aGJaDI1QoVwh
         70ezE8uXmQwYV9s/DVOeEiWEzY8LFSEYWPOnraE/jFJZcFwbD2l6qyaJ0Lh2suguxOil
         Wulhjict75GlVRLpxTmJWGnSF8x1/yaFpsgoCIT3/Jqvr5g9Uwzehh+9XciCgOBQVtuo
         hJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749202844; x=1749807644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAfTd10Yw9K2pZvfr2dRb9UAhgYnCFwO4TyYe6PRuSc=;
        b=Upfr09VArOGXmTsrGpygyAE3LBSS4KmhCgCeCTI878/W/lJpeaogu24nlgI1r/wStm
         V2mDUZzO3E8Giz5nEkasFI5GxEwGWu6OPnNf4AscppjCk2lZRxcJBb04pHBrb7ZlKoIB
         hkYbuBUQ/kdRX1O/Jj6XmCzrzzB2+r9MZy6lH4jQDMtOjaG6jH/ooTiQG25HnleTI0Kz
         hbM1NoU+D9eMI+oUI6TCYivCnnd1Loec0UEP0jOn2aNrhmFBGZ7oXqYiDHw4BLRFcX5y
         qBV2jI29mTpfuiLIcK62hgKyeNmHQqMlAf8zUhGk03FzgCIR6vHtWRZ8F6mmIRc1/gjQ
         +DEw==
X-Forwarded-Encrypted: i=1; AJvYcCVK6pqzqiudabfDZuf0Y/OLxsaPii6E7tmgon9jLxbSJ2VfAQylA/hynMjNBPm4hGPRM88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJHJl/s1z/+lI6t9wRgKlknIUqzZNPU8xI7x1txsjb/++Ft0Y
	tdv1RIzTF9PSMLCoRg7viGpp5s0Pt7yxIXmyTLdDOxIgl/C44r+mcz+Cu5oAAj46962kLAb/dvD
	6uQbWmUQuZs3dnU87yvPK5AyHm3iRgd6QegIgAjq4
X-Gm-Gg: ASbGncsMbEfs9Xm2sPrFSAmLbZxtuTO3FzQsv6xtS+RUKstxxSm5posgf29iXJ/kH6b
	VaFzTpb5tIkJ9lwvt4+q4/Lf35hqPW7476yAqxtf3hjYeV0VHHu9ywkeajOsQ2QKj0nKFuhZ4Cp
	aWtmvWAy99YhpC32YSy0zQZakyKHSzDjRaTHihxj9dvx/GhYysV8mzVOcR310duV8HMHTRkeSQ1
	chL
X-Google-Smtp-Source: AGHT+IGKKbLOyqwWS4IZGmwjDIgoabOvBLdPv+RQWjr5FaPAucKt8M0vS/txudh3ymwJQKw69mVr2CPYgfW54HNZ9Po=
X-Received: by 2002:a05:6402:3125:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-6077295a9c2mr81449a12.0.1749202843719; Fri, 06 Jun 2025
 02:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604210604.257036-1-kuba@kernel.org> <CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
 <20250605062234.1df7e74a@kernel.org> <CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
 <20250605070131.53d870f6@kernel.org> <684231d3bb907_208a5f2945f@willemb.c.googlers.com.notmuch>
 <20250605173142.1c370506@kernel.org>
In-Reply-To: <20250605173142.1c370506@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 6 Jun 2025 11:40:31 +0200
X-Gm-Features: AX0GCFvkymAy0ucuJORzcFDXtLnLbeZp-CZZfSawlnJHrrBGX7mUqZoSXJ1VWkQ
Message-ID: <CANP3RGfXNrL7b+BPUCPc_=iiExtxZVxLhpQR=vyzgksuuLYkeA@mail.gmail.com>
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, martin.lau@linux.dev, 
	daniel@iogearbox.net, john.fastabend@gmail.com, eddyz87@gmail.com, 
	sdf@fomichev.me, haoluo@google.com, willemb@google.com, 
	william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 2:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 05 Jun 2025 20:09:55 -0400 Willem de Bruijn wrote:
> > > > It does make a fair bit of sense.
> > > > Question: does calling it as a kfunc require kernel BTF?
> > > > Specifically some ram limited devices want to disable CONFIG_DEBUG_=
INFO_BTF...
> > > > I know normal bpf helpers don't need that...
> > > > I guess you could always convert ipv4 -> ipv6 -> ipv4 ;-)
> > >
> > > Not sure how BPF folks feel about that, but technically we could
> > > also add a flag to bpf_skb_adjust_room() or bpf_skb_change_proto().
> >
> > To invert the question: what is the value in keeping the dst?
>
> I guess simplicity defined as "how many English words are needed to
> explain the semantics".
>
> The semantics I have in mind would be - dst is dropped if (1) proto
> is changed (this patch), or (2) "CLEAR_DST" flag is explicitly set
> (future extension).
>
> If we drop on encap (which I supposed is the counter proposal)
> we may end up with: dst is dropped if (1) proto is changed,
> (2) encap flags are set (1+2 =3D alternative patch), or (3) "CLEAR_DST"
> flag is explicitly set (future extension).
>
> Don't think we can rule out the need for a CLEAR_DST flag as not all
> re-routings are encaps.
>
> But both you and Maciej consider dropping for all encaps more
> intuitive, so I'll do that in v2 unless someone objects.
>
> > The test refers to a nat6to4.bpf.o, but this is not included.
>
> I reused an existing BPF prog, it does what we need -
> it turns a v4 packet into a v6 one :)

I haven't yet written code like this, so I'm not sure which specific
helpers would be used, but here's what I'm aware of:

nat46/nat64 translation - obviously the dst should be dropped, as it
cannot be correct
- note that the bpf skb change proto helper is not always enough,
as it always adjusts by 20, but for fragments you need to adjust by 8
more (ipv4 had frag info straight in the core ipv4 header, ipv6
requires an extra 8 byte extension header),
thus our latest Android clat/nat64/nat46 code sometimes calls:
  bpf_skb_adjust_room(skb, -(__s32)sizeof(struct frag_hdr),
BPF_ADJ_ROOM_NET, /*flags*/0))

(and should also do the reverse +8 in the other direction, but that's
not yet implemented)
Anyway in theory this bpf_skb_adjust_room(BPF_ADJ_ROOM_NET) likely
shouldn't clear dst.

ipv4-in-ipv6/ipv6-in-ipv4 decap/encap - drop, cannot be correct

ipv4-in-ipv4/ipv6-in-ipv6 decap/encap - the dst ip is almost always
different in inner vs outer packet, so again drop seems correct,
though yeah I guess it could be conditional

now, what other cases do we have where we need to insert stuff at the
beginning of the packet (I assume we're not talking about cases where
we change something at the end)

I can think of 2 more:

(a) forwarding to an interface with a different L2 header size

specifically I think in Android when we forward (tethering offload)
from rawip to ether we have to adjust the front of the packet to add
an ethernet header: bpf_skb_change_head(skb, sizeof(struct ethhdr),
/*flags*/ 0))
- in practice, for v4, we just did manual nat44 so the dst is garbage,
while for v6 we didn't so the dst would in theory still be valid (but
we immediately bpf_redirect(EGRESS) so dst is also likely useless)

I think we might unconditionally add the ethernet header when
forwarding from rawip to rawip as well, because I think the kernel
then just drops / ignores it when egressing (via bpf_redirect) through
a rawip interface.

Honestly this stuff is annoying as hell to deal with (unfortunately
true of bpf in general).

(b) adding/removing some sort of vlan tag / mpls tag / ipv4
options/ipv6 extension headers / tcp options or something - most of
these likely should keep the dst

I think this wouldn't use BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 & friends but
something else, and at least some of these should likely not
invalidate the dst.

I'm not clear on what all the 'proper' apis are for all these different cas=
es.

(I thought I had a 3rd case, but I can't remember it any more...)

Hopefully this is helpful?

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

