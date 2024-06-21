Return-Path: <bpf+bounces-32732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB7F912941
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 17:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F51F22EE3
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2D7CF39;
	Fri, 21 Jun 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XUzZP5xl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952696EB73
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983037; cv=none; b=k17gBdjLGF/ELSCDcTqICo//2im/XCvZTQWNzgxw8Vrj2Mkn7Ha5al4ZoYVlG5LGLoYXQWOd+TENeGtPUEN77pFDKq9kWzmnnfewQFuEn2lwvwRvwan+mhYX5zXK3oo5R3oCdMkDkgsWgjwz+xt76/BKfFIZAFWzWbqPxEGJWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983037; c=relaxed/simple;
	bh=Q0K8wveLDtQ5rqIrCYq9H6yuQqmRsmPrm11leJJmngg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo5AXpUT3e47C3CblUAPkVUIApDgP35ER3dnktx6mgGTQ+7Nix6oCs+JcnlkS57NlrT0JG0iUpNgoYuVQleZZJd/WPiVM9o4VuIZ6QH1Qek8pAOqpa6auaFxqSjB7LBvGXIqerLkW3d6pbeZCzNekSmrypk8tTzCVQLptA6aU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XUzZP5xl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a63359aaacaso315925566b.1
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718983034; x=1719587834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVdWsH/CebZrv81hSvkbbEEBVG7k1A0KP1jmRZJ7hOw=;
        b=XUzZP5xl+VveWv9uFbsZWkuJOR+KtaLgLdZNjTofo+jiS6TlH1OStVc+1ANAAK2Fmx
         JrQCv9HD74WWCgwAXjYPLurXCJgihEPpuIdffHWFME9QiYYCIeSvMPAr4TgppgIvTnvi
         TmwVF+5tLTyyvkNoDHPb8vnCoVXE0G0he1qjlS3xyqcbuFJyfTldmcrcgLJlU51h0TQi
         Ihl2MNgcNawhHf4JfcDeXT3qyrEK+/HsJJdjKo55pKBqWNV3AZhRh1gUXMRuaSs6DuP8
         Wtdt2BvKpB9wjrGGRh3wuOb0kudSQPNepWNNIyOOJZ8a61p3K7m84S4OdN17If896J6J
         5cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718983034; x=1719587834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVdWsH/CebZrv81hSvkbbEEBVG7k1A0KP1jmRZJ7hOw=;
        b=th7cJxnQ3t2rZaM5kJ1/WQyCenrnsWHvQZZhBaqT4TOG0donyL2FZVtIv8oFQLgnzF
         rnWPDMaezn2mXwS8sxDNxqFhOD4mi4sMg3ZZOscHZcxgWAMno7hOGPYh17qPXKUQL7Le
         ZYgeSWnRpiocDfRUtrr0RTPaYMOWP7ksya/b42ztAGJpVFuwyfPuPdnNKlua2NhAxzzy
         /R0+aHRXQK4lswOR7OWTSUOqhKbbX1w6CW5BsxCjVxOAYRjucpiTn3vr25FVEKEcv9at
         yxqGrw6CMAdmsEPCtUafjdfE3mpvVz8cqYszv8uZ3z6cQkffe2nEZ5GxH8LzaLgOjBAh
         46CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvqexjDQizdXao5XOtAdqikbIbfo3LYW20RW+eFyKIfXzKfJEE/l/xPWikOhqSkm4tIl8/NlO/ULKKYWCCHpNvcZpO
X-Gm-Message-State: AOJu0YxWDdYRsPS8t7jWRTGxzTjynp2SxdrSvcdWnPQum2AOIjHEYxPa
	KCQOImsVQ8h0XFfc6ODJYOxEOz88PGQdKI50R4Oinsolf/ayw0uZW3+kqmIzTJ5INwq6PSEGJjS
	8JkzHXCDCYQne3n83ruooBHY0CWx5SodicEugog==
X-Google-Smtp-Source: AGHT+IHtoStFABY+6/Ct10yo+DluObSiNmm2iazrXX4v4aPFp4/k1VH8xzcmISmR1LM13gr6PkVkt+hHTcQEdX7ujLg=
X-Received: by 2002:a17:906:af0c:b0:a6f:1025:8dd6 with SMTP id
 a640c23a62f3a-a6fab7d0484mr549596266b.71.1718983033870; Fri, 21 Jun 2024
 08:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <2081388d3e05e1e6324d81524c6496006058bbb9.camel@redhat.com>
In-Reply-To: <2081388d3e05e1e6324d81524c6496006058bbb9.camel@redhat.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 10:17:02 -0500
Message-ID: <CAO3-Pbo_gNVP4qcEGNJe-RmPBy7CgFZab+dwwv2MyFiJRg9_fA@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Mina Almasry <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	David Howells <dhowells@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Ahern <dsahern@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Antoine Tenart <atenart@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:57=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2024-06-20 at 15:19 -0700, Yan Zhai wrote:
> > Software GRO is currently controlled by a single switch, i.e.
> >
> >   ethtool -K dev gro on|off
> >
> > However, this is not always desired. When GRO is enabled, even if the
> > kernel cannot GRO certain traffic, it has to run through the GRO receiv=
e
> > handlers with no benefit.
> >
> > There are also scenarios that turning off GRO is a requirement. For
> > example, our production environment has a scenario that a TC egress hoo=
k
> > may add multiple encapsulation headers to forwarded skbs for load
> > balancing and isolation purpose. The encapsulation is implemented via
> > BPF. But the problem arises then: there is no way to properly offload a
> > double-encapsulated packet, since skb only has network_header and
> > inner_network_header to track one layer of encapsulation, but not two.
> > On the other hand, not all the traffic through this device needs double
> > encapsulation. But we have to turn off GRO completely for any ingress
> > device as a result.
>
> Could you please add more details WRT this last statement? I'm unsure
> if I understand your problem. My guess is as follow:
>
> Your device receive some traffic, GRO and forward it, and the multiple
> encapsulation can happen on such forwarded traffic (since I can't find
> almost none of the above your message is mainly a wild guess).
>
> Assuming I guessed correctly, I think you could solve the problem with
> no kernel changes: redirect the to-be-tunneled traffic to some virtual
> device and all TX offload on top of it and let the encap happen there.
>
Let's say we have a netns to implement network functions like
DoS/IDS/Load balancing for IP traffic. The netns has a single veth
entrance/exit, and a bunch of ip tunnels, GRE/XFRM, to receive and
tunnel traffic from customer's private sites. Some of such traffic
could be encapsulated to reach services outside of the netns (but on
the same server), for example, customers may also want to use our
CDN/Caching functionality. The complication here is that we might have
to further tunnel traffic to another data center, because the routing
is asymmetric so we can receive client traffic from US but the
response may come back to our EU data center, and in order to do
layer4/layer7 service, we have to make sure those land on the same
server.

It is true that a device like a veth pair or even netkit could allow
the kernel segment GRO packets for us. But this does not sound
actually right in terms of design: if we know already some packet path
should not be GRO-ed, can we enforce this rather than having to
aggregate it then chop it down soon after? For our specific case
though, it also becomes a headache for analytics and customer rules
that rely on ingress device name, we probably need to pair each tunnel
with such a virtual device. There could be hundreds of ipsec tunnels,
and that seems to be a substantial overhead for both data path and
control plane management.

To make this a bit more general, what I'd like to introduce here is:
when we know GRO is either problematic or simply not useful (like to
some UDP traffic), can we have more control toggle to skip it?

thanks
Yan

> Cheers,
>
> Paolo
>

