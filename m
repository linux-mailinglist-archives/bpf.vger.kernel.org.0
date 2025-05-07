Return-Path: <bpf+bounces-57684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F31AAE7AF
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E3B3BE785
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378A728C5BF;
	Wed,  7 May 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/Jtifty"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256810F9;
	Wed,  7 May 2025 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638511; cv=none; b=jYOkFU5CZMxkrjaCD88350s4+NughU5hZlRpRy5trwwLWuIDcne/A8Coocit8yoeNFPqH0l2JeuP4rgHopWQ7KpyyMhRFNTxT6EJsSAhDnOGubWUr+kHp1GeX/6WDb6d7ywUfhwc+kcaHUqxPCI66lILjwoLE353Dze7DRFjQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638511; c=relaxed/simple;
	bh=4KN9AehXbtU3i0vwYhUfPh24WVFdZf+DzWH3CNB70ys=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BvN/0rDihZuiMZ6Shz6TJKBcFIkSSzyP2vlqwqcAL8GzlHpUXz8VWjR7O7piC3ATlYzI2LGpDod/gqcnO0a92I8lxgAyBecgRLu36x2xbiKzRNFRPxTL3Y+F4IWo+Qc7led+O58qUPwkLcYirAmF3i8lz38Pk53iqj3OJroWBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/Jtifty; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c597760323so6418285a.3;
        Wed, 07 May 2025 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638509; x=1747243309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KN9AehXbtU3i0vwYhUfPh24WVFdZf+DzWH3CNB70ys=;
        b=T/JtiftyJxYn65xmdJDmPuU1UX51mR51cV3x918CjIlEVEUkaKbpnQxISnv7cstA1D
         kxke484hG02H9CuYBfDB1R+Fy4KqUUxdBA6lYJjJIyT4nRvJ6g8wRwuvdgtPZo6gOPpL
         L9E8c2+Fcebgt0i9oRuB65IraCEKuYsYer/DzUJiytJJrBHfN3+mq+s0hEQjcVfNV34h
         CGxY56lnPpQxnZhdr9HQogxZpVaKVQJ6cVjvBVycJ9FIv72fFXN8MKpcMlMlh3FDRtt8
         VZgcg9KWKbGhpM14P3hBkfEbh2gKQAqRfzwGkJNV98bYhoRyDklCUaofUYqTGp3FE3Qy
         tZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638509; x=1747243309;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4KN9AehXbtU3i0vwYhUfPh24WVFdZf+DzWH3CNB70ys=;
        b=hrTVjpgGJ8vfEY657HZaSYVRhq8JFq7Py8V18W2hfBD3SyMUo0DGWLj2Fp5c7N1ONY
         kIGK59PNJXfKBbdPbqEayIllDoN5NRr9jqSxPNBR1d2FVsIONkbS4LBoRlBWjPHpmMAG
         XDhBPseyx9iwONeZNCUy//RhWLw3tPfLHWCX07STa1g+oQZuGvgnl/gwopr5lmgglCaz
         j8UMrbt5DifrGBO9lu06aLyFcZIiHDLKG4/OzJNMwBrZoUGO7TvT06tw0+/YYogcLZ6A
         CB1IVr4Nu4GmD6vLprfr8b1WqngzIA52qAJYgBJi7LGXfsxsB4RPd2Tm6YZAuYxGZUeb
         oJAA==
X-Forwarded-Encrypted: i=1; AJvYcCWcJZD26YFVghf/CdA9/Ax4Syv1w45fTFLbJW4IxQ9BBSr3+fek/MZIyb/qAGZsr2mRnNNrDcWQ6STIX2R1@vger.kernel.org, AJvYcCXJslpJGlvDnqDLRfVEi/JYBm/mT6TltVbllYgi+pqllEBN5l4JKva1CBeDOhIRWljcGbJag/WX@vger.kernel.org, AJvYcCXObqs6vtHu6Z80ot/y+BNpGhfXtj17hAri/M4ihVPtD3kWQDZK+qpuevhyIJ6VBkQW7no=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXN5NPonNXLrFmaOAg1kfabtiVCXb9n0pYdjT1mwYaBImj5t2
	DflwRvYhHyotW1H8WmTHqcMzUcFkAmdRV77gAU7zAExE0wQT6PQx
X-Gm-Gg: ASbGncvgpQ4X18tGYlxXlSkYZXWuEl86nU51T+eltfmEReyx+Q7w93u8YiNeQi+bgL4
	loTpfxqm3cQYKI9sGAy8+0mpeZNiiRrPBqFAlEJVKuNG9AWTBARgBBHqBzq7+e+LCgVk5H0e5hj
	YwosPl6Zb3QrvIbf4tNoePn5IBcLO6GzgaMy1fg0yt41940J0wKQYUhP1VmepRfaBhAqUCiXkx5
	8d1Tpw7bbrDfW/OTbdP9OQ6yPXDfBxPb4pJUfxvuNp/T/3JHuj6L9/eVr856Hju6sB83XFKH5K5
	ezhGHvTDKCTX76B7vt3GNd5ZoccqtKWKxP9RwoyCH0z5+kT45U4chyjfVZs3LqegIrELDbQVUZV
	zOZqXqbM3LDrxReks1vYVaIMIIlvCRCE=
X-Google-Smtp-Source: AGHT+IFeNep8CP7L4LAzS/uSxqoN/oIKx0uul0Rcnz5cdJfuTyulIiJ8UZMjk/2h9FPh1pGy5nXRfw==
X-Received: by 2002:a05:620a:d87:b0:7c5:d72b:1a00 with SMTP id af79cd13be357-7caf7386bdcmr514256985a.15.1746638509060;
        Wed, 07 May 2025 10:21:49 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf75b85a6sm177992785a.68.2025.05.07.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:21:48 -0700 (PDT)
Date: Wed, 07 May 2025 13:21:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
 Zvi Effron <zeffron@riotgames.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Jon Kohler <jon@nutanix.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <681b96abe7ae4_1f6aad294c9@willemb.c.googlers.com.notmuch>
In-Reply-To: <062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
References: <20250506125242.2685182-1-jon@nutanix.com>
 <aBpKLNPct95KdADM@mini-arch>
 <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
 <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
 <CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
 <062e886f-7c83-4d46-97f1-ebbce3ca8212@kernel.org>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer wrote:
> =

> =

> On 07/05/2025 19.02, Zvi Effron wrote:
> > On Wed, May 7, 2025 at 9:37=E2=80=AFAM Jesper Dangaard Brouer <hawk@k=
ernel.org> wrote:
> >>
> >>
> >>
> >> On 07/05/2025 15.29, Willem de Bruijn wrote:
> >>> Stanislav Fomichev wrote:
> >>>> On 05/06, Jon Kohler wrote:
> >>>>> Introduce new XDP helpers:
> >>>>> - xdp_headlen: Similar to skb_headlen
> >>
> >> I really dislike xdp_headlen(). This "headlen" originates from an SK=
B
> >> implementation detail, that I don't think we should carry over into =
XDP
> >> land.
> >> We need to come up with something that isn't easily mis-read as the
> >> header-length.
> > =

> > ... snip ...
> > =

> >>>> + * xdp_headlen - Calculate the length of the data in an XDP buffe=
r
> > =

> > How about xdp_datalen()?
> =

> Yes, I like xdp_datalen() :-)

This is confusing in that it is the inverse of skb->data_len:
which is exactly the part of the data not in the skb head.

There is value in consistent naming. I've never confused headlen
with header len.

But if diverging, at least let's choose something not
associated with skbs with a different meaning.

