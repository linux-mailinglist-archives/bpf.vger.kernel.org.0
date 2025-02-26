Return-Path: <bpf+bounces-52672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F3A46820
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E195D170AAA
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED688224B0B;
	Wed, 26 Feb 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsNbOEu6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD3121B1B5;
	Wed, 26 Feb 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591033; cv=none; b=gkbkm/gYTuixfluhUB11jCKfZRRPAWwABAE8JvMNvdwqtrb7aLJSdABXOiIJUgd3GNJZvNn8lb0sSpKf9RzuyQNma7hzhHbR6XTLCwvy7F+1PlGrcU0kNzzR1QQUnV4NADrjWpLFR1HkWP87BaM3Z6p8RgI19cc/VxvP+7s4/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591033; c=relaxed/simple;
	bh=W+8mDNDJZwCYE7aOSphfX0nQzEuh/auhF9/CmRXBCSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHJW4qMYWKQWRC94fTbQF6fl+hsPp6PNIER8RRJWXA7p+Y9JrFw3pTKzyAaNwaQjRVa5lI9Ql/HI5cxvlPzpguYQ0QWPWiMZUyeGOEvNnVSsj2XleUVU5boaPCwLynbrldwKDQjKTW6Z1X2ElBttTkTBrPbQsvEyVfCdnanDWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsNbOEu6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f403edb4eso4241638f8f.3;
        Wed, 26 Feb 2025 09:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740591030; x=1741195830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+8mDNDJZwCYE7aOSphfX0nQzEuh/auhF9/CmRXBCSI=;
        b=dsNbOEu6RVCS4Vw+XwRh1p0HELuKI67VLwuZ3DxPei3dE0HmijahWvQAEiLq3yyypm
         iP04A1tzW3La2G3BVwAljybcWdFWKKab6mCy8Qe+G0NIpYC7aowoGv3+RlBTuiR1Vk3+
         U+0h72TmzEMmO5qww4jq4WY5PUfcyfMm9xunlFmFaXFjDBdeMza8b4HPC35kmBN1jtP0
         isGzMhRK1rhepvp7V+pUt3LG60X0vcHQ2jtoLSJijFLW9/VcsX/JaowPkiqpcd84hkaB
         mpl2igeJMzN/IAex94oKk4VNlfhsgoZv4ptahiXkk1ZKU2FOIn5ON79D17g8suL32SoJ
         8W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740591030; x=1741195830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+8mDNDJZwCYE7aOSphfX0nQzEuh/auhF9/CmRXBCSI=;
        b=JKQ7UvwL37aFkcRpjXVFvFlcXFyL02DMxT22a1oIF09Kh6wy8/y1XkcCbs58UrotYZ
         D67t0Zgosc96kYdad0TK+2Dk6vH4KUXM0BwsULsNOuavRzimvVTBM9Et6FnHX6ZQ4E7w
         4TaIYIzVP3szstDbnqgBzq2gwOi7oWSqXY/5UkMaaah4MYQcolhveu7ta9C5gS7MocaI
         GhTtWmv6cvGx7I2bB6xrfpB72oA2SzPcocLs+F14D7n0wPj9z9uWxr+rHepWA15mYlfq
         0Cn74I/deZLb7NXP9aoqo+vX5816H7P5icHNBZiCLpCAPxxMyDfoG6grJAw0AZh6dbXe
         Y22A==
X-Forwarded-Encrypted: i=1; AJvYcCWERMxv9d7kUOSEiOL1Rzkcw5OqXbZ4Tydby90eEOr74HBxX9CGCt7Y0SW+3axzpI832pIeMbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx6JtR7NOTmFBLmNlERSDzmlYO+Fa54TzDmirCQ5lmrd6f+bXn
	pRvqYBpsLGiWLDYZvpKSOi+8GL1XcZ/V8dR7EMglKPqPr0vhsrp97aXduU3Ajjqv046aATQvsx2
	bCaZJ8NumFC9VdyBg7oAg30MPhyE=
X-Gm-Gg: ASbGncvHvqDELr2QYlUN9VgO5h2OUphcNrP8gmMlmxsHkF2LDYa6aaaCnXQ2mP1isRp
	TEFQI2rP08rvJoKlWUv2Yw4XUMDrTeJD3OmSKfFgpbrYZKRGx7eo7ckmWsH4TVkElLWC22h8b5L
	EpOLibDpf74Z0yDDZ80Wd83OU=
X-Google-Smtp-Source: AGHT+IGEjG4QXZW3khJ9pJWOBa/Y+jo71vJ+/93A1uk75nHWtmHXzhPzZiXUGjMRdCrsPfaN3qc7s+v/rucD7ehgcog=
X-Received: by 2002:a5d:5983:0:b0:38f:4d20:4a0a with SMTP id
 ffacd0b85a97d-390cc609d0fmr7100943f8f.28.1740591029923; Wed, 26 Feb 2025
 09:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
 <CAADnVQKYkwV1jc3aLwWqzgP7TKaPvq_NjpwvYdOXOgDQ3QZfeA@mail.gmail.com> <Z73TS/tjk9okSqlC@boxer>
In-Reply-To: <Z73TS/tjk9okSqlC@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Feb 2025 09:30:18 -0800
X-Gm-Features: AQ5f1JpQtap0tuew6P2Heurpjvuf24ejI9hIjLoPl8xun3nE45XvegWs-UvTRd4
Message-ID: <CAADnVQ++0o-YoFR=yUcbJvaLX2rmWjC2LHjc3yyCp+bkgWGn1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: introduce skb refcount kfuncs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Kicinski <kuba@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 6:27=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Feb 21, 2025 at 05:55:57PM -0800, Alexei Starovoitov wrote:
> > On Thu, Feb 20, 2025 at 5:45=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > Hi!
> > >
> > > This patchset provides what is needed for storing skbs as kptrs in bp=
f
> > > maps. We start with necessary kernel change as discussed at [0] with
> > > Martin, then next patch adds kfuncs for handling skb refcount and on =
top
> > > of that a test case is added where one program stores skbs and then n=
ext
> > > program is able to retrieve them from map.
> > >
> > > Martin, regarding the kernel change I decided to go with boolean
> > > approach instead of what you initially suggested. Let me know if it
> > > works for you.
> > >
> > > Thanks,
> > > Maciej
> > >
> > > [0]: https://lore.kernel.org/bpf/Z0X%2F9PhIhvQwsgfW@boxer/
> >
> > Before we go further we need a lot more details on "why" part.
> > In the old thread I was able to find:
> >
> > > On TC egress hook skb is stored in a map ...
> > > During TC ingress hook on the same interface, the skb that was previo=
usly
> > stored in map is retrieved ...
> >
> > This is too cryptic. I see several concerns with such use case
> > including netns crossing, L2/L3 mismatch, skb_scrub.
> >
> > I doubt we can make such "skb stash in a map" safe without
> > restricting the usage, so please provide detailed
> > description of the use case.
>
> Hi Alexei,
>
> We have a system with two nodes: one is a fully fledged Linux system (big=
 node)
> and the other one a smaller embedded system. The big node runs Linux PTP =
for
> time synchronization, the smaller node we have no control over (might run=
 Linux
> or something else). The problem is that we would like to use the Tx times=
tamps
> from the small node in the Linux PTP application on the big node. When a =
packet
> is sent out from the big node it arrives at the small node that send it o=
ut one
> of its interfaces. It then replies with another packet back to the big no=
de
> with the Tx timestamp in it.
>
> Our current PoC for attacking this is to store the skb in a map (using th=
is
> patch set) when it is sent out from the big node then retrieve it from th=
e map
> when the reply from the small node is received. We then take the timestam=
p from
> the packet and put it in the skb and send it up to the socket error queue=
 so
> that Linux PTP works out of the box.

This sounds like you're actually xmit-ing the skb out of the big node
and storing it in a map via simple refcnt++.
That may work in some setups, but in general is not quite correct
from networking stack pov.
You need to skb_clone() it and keep the clone, so only cloned skb
can go into the socket error queue and up to user space.
xmit-ing the same skb and sending to user space
is going to cause issues.

Cleaner design would probably involve bpf_clone_redirect()
and may be some form of bpf-qdisc where packet is waiting in the queue
until its hwtimestamp is adjusted and its released from the queue
into user space.

What happens when small node doesn't send that timestamped packet?
The map will eventually overflow, right?
Overall it feels that stashing skb-s in a map isn't the right approach.

> Note that for the purpose of setting skb->hwtstamp and sending it up to t=
he
> error queue we are adding a kfunc (bpf_tx_tstamp) responsible for it, whi=
ch is
> not included in this set, so I understand it is not obvious what we achie=
ved
> with the current form of this patch set being discussed.
>
> We did not consider the restrictions that should be implemented from netn=
s POV,
> so that is a good point. How would you see this being fixed?
>

