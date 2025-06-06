Return-Path: <bpf+bounces-59850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA28ACFED5
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D124F3A6768
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 09:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4A2868AC;
	Fri,  6 Jun 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KR8o8gwP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DD2868AA
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200815; cv=none; b=NxNk3xj2u9HPFoA3Or2LUY7dHGazZai9GP1Gtpw/Fn6JhjKrLBky1zlDu7d7uRkXETv1yqx3RdVHrDNWHW9xwLIQe/aoCc593NUyQFJHQFG/7Po2pt5NnU+MJIwTKf8vCS87zoFj3g+FAH2NDl3MphmicLyAagUlRCuhkIc9wSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200815; c=relaxed/simple;
	bh=5/GIpoiLEODukIITVP+GzuZ7UBw9dQMUpLlMC4ZVZgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APXPeM8AKpBoT4kXZlJgarvaUioPtDFIgIbh2/D1xpMPmB7hBtRFTE3PN9gMeZYz3ylb6Rp3QJiJ1a9oK4rlVCixENHmeYMgOcc/ruiDAHsRIPm2j6AcjuIKk6HH/hkjwS6Oo7sHFcmbPywzCpG0xUa0Ii3idplPI4Xsd+HQEsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KR8o8gwP; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a3db0666f2so40312471cf.1
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749200812; x=1749805612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Juf4jrcJwc7M/PUKZ2NRoIutSSX565sEIodIwjaKUU=;
        b=KR8o8gwPU/AKH4wTlHWbYqWLn0K0H3kLCForFgwD9iy+n/I1Lal+DC5SHj2RrLAvEL
         c6mlOwWS/Aq2NZLWA2ALG9dkk3qXZkCm4kE1UfE031IP+eBpl2PiQJv9Lo3Yk3xSDehw
         OkkOe6AL52t9NluxQCi6TEgsejukLlR7f+5nvzmRWaaDf1Jb/W2T+/bRsy5NeLmNZ5/T
         nRYzUp7zLsK9h5Do+Zfa04PF0QXWMJj9X9JlnGGAkC7bQKv0BMA8p2B1YnZaBY5WD4H0
         EJY8zE4XUFJgy2OhCBcd1Ka79ERkP3AEjPJGEqcAknnsL+yKA/qvPzmyfHV65nKITpU2
         Z4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749200812; x=1749805612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Juf4jrcJwc7M/PUKZ2NRoIutSSX565sEIodIwjaKUU=;
        b=PkiojTblA6a/Py6uAsWaXpuhVpAzZYibGpm2k6nIy9uaZnhl1n/YvCCbsttAX5ZAe4
         sLG1ImvJLuUYTHRD8dA67pvUzd4tONzExK0ZAMFpD6N12TavMUBERpU0dBhP3O5XAf1y
         atqNjUn06cMzqRtcxk6JSl/9Cbi9Fja/F/K1vH1ztOJkDLHd2GZj5cclBhPpqhzBk3Px
         AOPRNwhSnI15Y6sq10TXfy02cqKBanwBNCmaL3UJEACYRYfR+Vt/w1+ZkW0d1LDJJyrO
         odQvk4VreV2W2aU/zMYoihTu6dzPYtZzufU2jh6kteFbA25o5eYO9NCgKWF7f5idQAXt
         MnwA==
X-Forwarded-Encrypted: i=1; AJvYcCW2PAGgwBr/uRblkK+SAcCi2zb0eEOEtZCyysoMI4RyvJvA3THtIMzCKjE21W7p+kuoz1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YznEKQ+ZWjefFvcQmpgqKfLf5o649ox11XRmEHFoy+BzAZxrb8a
	JJn8BeHWCVDOyl4tX/rAE53QhOdAhxgw77vonW3uD8N1P88zqXNREhYcvqdHWqeWV2QjljtGJd8
	kPkW2AI7QWV1o/LwQFhgiVdpaa81zPD55Y4/HuYL8maDL7fvWWhZ6BbPZIJM=
X-Gm-Gg: ASbGncuuaz9Tefl8yjcfix0acJANuo5uo8k27bDPLiIWwYSGLEWGmcz7c4HUBr8/pEp
	fgPpTpQtmfz4Rhc4pMPgQtopjy2GtgpgtSq0QlAmqi84Zqm+6N5QlJqtXnvhxbZ5r7OjMuvg3Ib
	hZGz2OryOmoLVQeQDoywWlsIHO/6qXIxnm+p1kYeur9X9AB/EKjHhPs7X7cLXkefKAO90NcuMTU
	DEHVA==
X-Google-Smtp-Source: AGHT+IHrlc9mecNqwz2N+nw+P4UYGvVjpnyOb92OYDI8uLthwW+8fWcUH8+t4NPziYSbwMH5pv1fl34SjJ41A6Aw6oE=
X-Received: by 2002:a05:622a:4a15:b0:4a4:3b41:916c with SMTP id
 d75a77b69052e-4a5b9a38b4bmr50944651cf.17.1749200811395; Fri, 06 Jun 2025
 02:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
 <87zfemtbah.fsf@toke.dk> <CANn89i+7crgdpf-UXDpTNdWfei95+JHyMD_dBD8efTbLBnvZUQ@mail.gmail.com>
 <CANn89iKpZ5aLNpv66B9M4R1d_Pn5ZX=8-XaiyCLgKRy3marUtQ@mail.gmail.com> <5f19b555-b0fa-472a-a5f3-6673c0b69c5c@hetzner-cloud.de>
In-Reply-To: <5f19b555-b0fa-472a-a5f3-6673c0b69c5c@hetzner-cloud.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Jun 2025 02:06:40 -0700
X-Gm-Features: AX0GCFuvatprhbrKC4R-61A0CpjrF1M_FzEpByoJmTe1A2qJ9Yyf7FigygmAcu0
Message-ID: <CANn89iJAR3HvWXNqNSR=y9qYm4W5sD40La+UpRraF4NE8yhfrA@mail.gmail.com>
Subject: Re: [BUG] veth: TX drops with NAPI enabled and crash in combination
 with qdisc
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:17=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> Am 06.06.25 um 00:11 schrieb Eric Dumazet:
> > On Thu, Jun 5, 2025 at 9:46=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> On Thu, Jun 5, 2025 at 9:15=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>>
> >>> Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de> writes:
> >>>
> >>>> Hi,
> >>>>
> >>>> while experimenting with XDP_REDIRECT from a veth-pair to another in=
terface, I
> >>>> noticed that the veth-pair looses lots of packets when multiple TCP =
streams go
> >>>> through it, resulting in stalling TCP connections and noticeable ins=
tabilities.
> >>>>
> >>>> This doesn't seem to be an issue with just XDP but rather occurs whe=
never the
> >>>> NAPI mode of the veth driver is active.
> >>>> I managed to reproduce the same behavior just by bringing the veth-p=
air into
> >>>> NAPI mode (see commit d3256efd8e8b ("veth: allow enabling NAPI even =
without
> >>>> XDP")) and running multiple TCP streams through it using a network n=
amespace.
> >>>>
> >>>> Here is how I reproduced it:
> >>>>
> >>>>   ip netns add lb
> >>>>   ip link add dev to-lb type veth peer name in-lb netns lb
> >>>>
> >>>>   # Enable NAPI
> >>>>   ethtool -K to-lb gro on
> >>>>   ethtool -K to-lb tso off
> >>>>   ip netns exec lb ethtool -K in-lb gro on
> >>>>   ip netns exec lb ethtool -K in-lb tso off
> >>>>
> >>>>   ip link set dev to-lb up
> >>>>   ip -netns lb link set dev in-lb up
> >>>>
> >>>> Then run a HTTP server inside the "lb" namespace that serves a large=
 file:
> >>>>
> >>>>   fallocate -l 10G testfiles/10GB.bin
> >>>>   caddy file-server --root testfiles/
> >>>>
> >>>> Download this file from within the root namespace multiple times in =
parallel:
> >>>>
> >>>>   curl http://[fe80::...%to-lb]/10GB.bin -o /dev/null
> >>>>
> >>>> In my tests, I ran four parallel curls at the same time and after ju=
st a few
> >>>> seconds, three of them stalled while the other one "won" over the fu=
ll bandwidth
> >>>> and completed the download.
> >>>>
> >>>> This is probably a result of the veth's ptr_ring running full, causi=
ng many
> >>>> packet drops on TX, and the TCP congestion control reacting to that.
> >>>>
> >>>> In this context, I also took notice of Jesper's patch which describe=
s a very
> >>>> similar issue and should help to resolve this:
> >>>>   commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_r=
ing to
> >>>>   reduce TX drops")
> >>>>
> >>>> But when repeating the above test with latest mainline, which includ=
es this
> >>>> patch, and enabling qdisc via
> >>>>   tc qdisc add dev in-lb root sfq perturb 10
> >>>> the Kernel crashed just after starting the second TCP stream (see ou=
tput below).
> >>>>
> >>>> So I have two questions:
> >>>> - Is my understanding of the described issue correct and is Jesper's=
 patch
> >>>>   sufficient to solve this?
> >>>
> >>> Hmm, yeah, this does sound likely.
> >>>
> >>>> - Is my qdisc configuration to make use of this patch correct and th=
e kernel
> >>>>   crash is likely a bug?
> >>>>
> >>>> ------------[ cut here ]------------
> >>>> UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:12
> >>>> index 65535 is out of range for type 'sfq_head [128]'
> >>>
> >>> This (the 'index 65535') kinda screams "integer underflow". So certai=
nly
> >>> looks like a kernel bug, yeah. Don't see any obvious reason why Jespe=
r's
> >>> patch would trigger this; maybe Eric has an idea?
> >>>
> >>> Does this happen with other qdiscs as well, or is it specific to sfq?
> >>
> >> This seems like a bug in sfq, we already had recent fixes in it, and
> >> other fixes in net/sched vs qdisc_tree_reduce_backlog()
> >>
> >> It is possible qdisc_pkt_len() could be wrong in this use case (TSO of=
f ?)
> >
> > This seems to be a very old bug, indeed caused by sch->gso_skb
> > contribution to sch->q.qlen
> >
> > diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> > index b912ad99aa15d95b297fb28d0fd0baa9c21ab5cd..77fa02f2bfcd56a36815199=
aa2e7987943ea226f
> > 100644
> > --- a/net/sched/sch_sfq.c
> > +++ b/net/sched/sch_sfq.c
> > @@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch,
> > struct sk_buff **to_free)
> >                 /* It is difficult to believe, but ALL THE SLOTS HAVE
> > LENGTH 1. */
> >                 x =3D q->tail->next;
> >                 slot =3D &q->slots[x];
> > -               q->tail->next =3D slot->next;
> > +               if (slot->next =3D=3D x)
> > +                       q->tail =3D NULL; /* no more active slots */
> > +               else
> > +                       q->tail->next =3D slot->next;
> >                 q->ht[slot->hash] =3D SFQ_EMPTY_SLOT;
> >                 goto drop;
> >         }
> >
>
> Hi,
>
> thank you for looking into it.
> I'll give your patch a try and will also do tests with other qdiscs as we=
ll when I'm back
> in office.
>

I have been using this repro :

ip netns add lb

ip link add dev to-lb type veth peer name in-lb netns lb

# force qdisc to requeue gso_skb
ethtool -K to-lb tso off

# Enable NAPI
ip netns exec lb ethtool -K in-lb gro on

ip link set dev to-lb up
ip -netns lb link set dev in-lb up

ip addr add dev to-lb 192.168.20.1/24
ip -netns lb addr add dev in-lb 192.168.20.2/24

tc qdisc replace dev to-lb root sfq limit 100

ip netns exec lb netserver

netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &

