Return-Path: <bpf+bounces-32710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035E91215D
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 11:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EA7B20F30
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DEE16F85A;
	Fri, 21 Jun 2024 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB8OXqdv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10216F843
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963832; cv=none; b=Wryri8HztqyHLvDqyLMb6t30uZqokkuv+BphH5f5ty6tyLE3zrheyfqc4hhwSDBh29E/TBZxix6iV302a3R1U97WLeCg1/rm8EZf5s4Vf0aUflO5RrdjsZT5IaLzwAiwzUcPFUGA3eb4Cg34FQ55+6lHoqXtTSRzCeIg46M5t7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963832; c=relaxed/simple;
	bh=iJFRdWNKQ4fd8heDLgL5aLx6gHg1HzLoAys/N863UD0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z5058m+qeXXrMXLLo5r+TwkhGWeF732b6NtiPZfc2EUOCd9LsgjhZpynYz2kNQc31Aa5vrvx8kyhKjPwtJ+lF2hf2YqPbKS0miJnDy2DjJ4Rnr+Y9CIqT+mVXLI5URzeOKel+XjwH2F79+AbmDZIHBN49Ykq3kTe0QR97knhpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HB8OXqdv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718963829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=38G26vSnP45XuOy+Bej3ZUMTBwKAbH0lYjkgTUmXBPk=;
	b=HB8OXqdvfYfZmj6dUBFz1QeVbaT6oiHjEp2/kw130XVxsqFLbxExMSKpep7Bmv2M7//CdT
	tCGmTFrJ3cmEc+MvUW4SSsTsKyLZ7GUpNXKc31K/Frgs8Zg9rj5iFuQwWDUBU6MULOyJJQ
	jHSX1ygI9GOHD1yrBUWJFXqfGe/jW0w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-60OUlPy7OZuYvXJ6aWQbqQ-1; Fri, 21 Jun 2024 05:57:08 -0400
X-MC-Unique: 60OUlPy7OZuYvXJ6aWQbqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4217f4b7355so2840765e9.3
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 02:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718963827; x=1719568627;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38G26vSnP45XuOy+Bej3ZUMTBwKAbH0lYjkgTUmXBPk=;
        b=dAnlC2n+Ilnphwsy6QlD893YH7gilTA4VjvLVqgiEGlHqaLWA1sW9SIexVLtEsL2yv
         ciC/YQ7+yBIvA/CaaXsaYJB31aTJdlWAWTL05NdEgxwSGfMzhbc0sg5V+RSMVMd1NU7V
         7Hn4Qsw+aqpLZGO6ndhvalTy7NQb1JACXuGXgyVsycLlc2Ie6Sh5v3jYqnDAdapDB/f9
         CsyXTTGBvlbfd/buOcUih+94DjxsYhe+kWuaxBm6jdUiYuVrCKwDwcqChFUcNuRscL2R
         U1eSSWDuYMPWcsB9SF8PVpDK2pX6TZlUVhdsEG3J2BqOIUDbYtPQyGkCXLWyMlVt7AOO
         SIcw==
X-Forwarded-Encrypted: i=1; AJvYcCX3XZICEmIW6vqmIXPwPQyFACjCr42jImDTBGd8AXx7P7rWpoQFEv4Q8S0k5+AYqY9Wokk54VXMV5kuPR4ES5KV+o6A
X-Gm-Message-State: AOJu0YzgZbXXK3CadFwWWcFoH5oGAmydbffUkTe7a/ju+frICd8W6YXk
	R3Qp1KLb8tdKslMxLiqiBJ4W3ublckw+xrL7iW+jArKRAQkjfX/I7XZ7WMjV5SpzPYVhZSvOxa9
	zgp9DgM9AGqclu4Tz6Z4u+r/Kylqg0JyyNeYXpMgoGcoV2SWtOw==
X-Received: by 2002:a05:600c:1d09:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-42475296800mr55210085e9.2.1718963827309;
        Fri, 21 Jun 2024 02:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhCv4S3sqOUeoRHbQvJ7ysqB82xo4PjfMVMg1twnOU2B6QkdHWGk0NERGdplcS8IdL7Ckg4w==
X-Received: by 2002:a05:600c:1d09:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-42475296800mr55209745e9.2.1718963826895;
        Fri, 21 Jun 2024 02:57:06 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b08b:6910:937c:803f:4309:91d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be841sm56250535e9.20.2024.06.21.02.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 02:57:06 -0700 (PDT)
Message-ID: <2081388d3e05e1e6324d81524c6496006058bbb9.camel@redhat.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
From: Paolo Abeni <pabeni@redhat.com>
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, Simon
 Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, Mina Almasry
 <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 David Howells <dhowells@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, David Ahern <dsahern@kernel.org>, Richard
 Gobert <richardbgobert@gmail.com>, Antoine Tenart <atenart@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, Soheil Hassas Yeganeh <soheil@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <linux@weissschuh.net>,  linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 21 Jun 2024 11:57:04 +0200
In-Reply-To: <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
	 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 15:19 -0700, Yan Zhai wrote:
> Software GRO is currently controlled by a single switch, i.e.
>=20
>   ethtool -K dev gro on|off
>=20
> However, this is not always desired. When GRO is enabled, even if the
> kernel cannot GRO certain traffic, it has to run through the GRO receive
> handlers with no benefit.
>=20
> There are also scenarios that turning off GRO is a requirement. For
> example, our production environment has a scenario that a TC egress hook
> may add multiple encapsulation headers to forwarded skbs for load
> balancing and isolation purpose. The encapsulation is implemented via
> BPF. But the problem arises then: there is no way to properly offload a
> double-encapsulated packet, since skb only has network_header and
> inner_network_header to track one layer of encapsulation, but not two.
> On the other hand, not all the traffic through this device needs double
> encapsulation. But we have to turn off GRO completely for any ingress
> device as a result.

Could you please add more details WRT this last statement?=C2=A0I'm unsure
if I understand your problem. My guess is as follow:

Your device receive some traffic, GRO and forward it, and the multiple
encapsulation can happen on such forwarded traffic (since I can't find
almost none of the above your message is mainly a wild guess).

Assuming I guessed correctly, I think you could solve the problem with
no kernel changes: redirect the to-be-tunneled traffic to some virtual
device and all TX offload on top of it and let the encap happen there.

Cheers,

Paolo


