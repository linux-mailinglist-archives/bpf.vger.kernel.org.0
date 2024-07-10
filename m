Return-Path: <bpf+bounces-34483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60892DC0A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 00:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF891C21605
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1328D1487C5;
	Wed, 10 Jul 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdjJ17+5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99514AD25
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651537; cv=none; b=tx6V3SQ5+gbjj5QpE9lPOsmOY9Xb+W8CqzUXz9A40WThv7L1LyCTCltJCsOJCsod0V5lRKeqnhafFqRnq6uic1FicrMYWKK3la5LxXHBv+XVGKTizsOCxXXLkjjh2WxgvgvmAfbGkzR7MrdKqHa3ksIbOQ8YTmZuT+uMVL4coLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651537; c=relaxed/simple;
	bh=zEZ4qa1KY5W/ArZqfvSqtxOP5I0qkz6xjUA5gKFEtjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5+z2FWcqZoVZnvEeDRDhgssXI40AqGT/dZYtTgH8+It76Dkccr63NthGAvpSQ9knHVGjtqX8Pm3PuwWNQyYK9hATXouE64F6h2vnp9G/TbSiHRWxYS8iouWT2xJEz9q1Rd9uQGvyq8PWw4VuMbUHsllaQueiTulxKnkdqlUWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdjJ17+5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5dd7cd945so1727046d6.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720651535; x=1721256335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewitibS3zX+WzUTqst3po2B/GkvecNeXUFCMiBjweyg=;
        b=tdjJ17+5BiKAbEvFm/bTZZzzeiiuS2bzDiid0gXaBYsG5QBdfjBTyZ10S1L+z9OmfJ
         i2b8kliyvcF2mUD5KyQmAplFOedGO69LhmT6jJWy0JP68Z7LqfmLCFJojtm7G1D6xahE
         BGELmK27tCIRvjRszqt74+slO+hb0WcuzSCNTbmccmZrVUxtZ8NzK7VoL7+HjIQ6V1ws
         9maAlusmQ8tdmc4g2j152mq/GNfVm37aQb4hCFbmvL6lnexAPE1M4CtbZry8Xy9j+Gg8
         9kNGJvyZ6yZsJV9OfllYLEj+k3aADj7IaE3Fs50CuDe6z1ztPvz33gASo+aPVafropCy
         jrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720651535; x=1721256335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewitibS3zX+WzUTqst3po2B/GkvecNeXUFCMiBjweyg=;
        b=mwiVwOLDtUHgIj30LTpusSbzNWOtf/17dzeGgkCG/BFC77mVmIXEwXAP2cgdJd04+2
         0r427XMjP9AuL0PLKS1S5J1Ilgy5k7G/gPB2f5wIQE6m0IadQE6uZOS0H4cT69w+ReB9
         txNKOlblmhuDuLjLlZPoVCGpkqo+w5+gffyJ44Dc731nau+oylcECTa+DfC7EjkqWp1s
         AVK/ElwsaCrXiPUUhJ4/sicTG98+NykdGv28RQtO+OqKIHiUPX3jYbtrfAYrMVZiX4SE
         HEuDwIeV2I+P4FsffaoHaTpgUwWsNSmh+oL5vV239ibuGDc8BsdsziKIwMupY9YJDdyj
         0cuw==
X-Forwarded-Encrypted: i=1; AJvYcCWO2VMCSkRVqwA3FwxVBidY9bOEDrWikKikaM6vELr6rMvfTyI/SKrXYS7oCf/6QtB1P5yRsuBKC2eJjGxrUUT2/+O0
X-Gm-Message-State: AOJu0YzK0M37L9OGR99mcc3e+0pev8GJpA3WzCwfSW2jFqrS0w3F1f1z
	Woc35jaoSO4IK03d+DckKu9sGhZfvlvhyFT+RiTpGdGr8AsSNCa6M7B6c6eZyVKxwQkBg/hkMZ7
	cy3YyMRalxsLl+Li3BrR0XvsEYfC99JN4Uwai
X-Google-Smtp-Source: AGHT+IF5eUrWI3iGBloyaIenGjn6niXEyyaOV4S/5O4aymX7e6kogYU+UbBk/KI5YYE/pmMB4biArqXH6clq6XINtH0=
X-Received: by 2002:ad4:5c68:0:b0:6b5:d9ef:d576 with SMTP id
 6a1803df08f44-6b61bc80440mr73134066d6.12.1720651534418; Wed, 10 Jul 2024
 15:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710001749.1388631-1-almasrymina@google.com>
 <20240710001749.1388631-5-almasrymina@google.com> <20240710093624.26d22f02@kernel.org>
 <CAHS8izOoM3YfcQorLJXL4H+t2OL+oJ4fPP5ZBJRhnH5AxsUqfQ@mail.gmail.com> <20240710125533.7a14bbe7@kernel.org>
In-Reply-To: <20240710125533.7a14bbe7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 10 Jul 2024 15:45:19 -0700
Message-ID: <CAHS8izMhTKndLEYrCyNK5WcUHQB6iXefr1=TcxKNxd+ghJGp0w@mail.gmail.com>
Subject: Re: [PATCH net-next v16 04/13] netdev: netdevice devmem allocator
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 10 Jul 2024 12:29:58 -0700 Mina Almasry wrote:
> > On Wed, Jul 10, 2024 at 9:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Wed, 10 Jul 2024 00:17:37 +0000 Mina Almasry wrote:
> > > > +     net_devmem_dmabuf_binding_get(binding);
> > >
> > > Why does every iov need to hold a ref? pp holds a ref and does its ow=
n
> > > accounting, so it won't disappear unless all the pages are returned.
> >
> > I guess it doesn't really need to, but this is the design/approach I
> > went with, and I actually prefer it a bit. The design is borrowed from
> > how struct dev_pagemap does this, IIRC. Every page allocated from the
> > pgmap holds a reference to the pgmap to ensure the pgmap doesn't go
> > away while some page that originated from it is out in the wild, and
> > similarly I did so in the binding here.
>
> Oh, you napi_pp_put_page() on the other end! I can see how that could
> be fine.
>
> > We could assume that the page_pool is accounting iovs for us, but that
> > is not always true, right? page_pool_return_page() disconnects a
> > netmem from the page_pool and AFAIU the page_pool can go away while
> > there is such a netmem still in use in the net stack. Currently this
> > can't happen with iovs because I currently don't support non-pp
> > refcounting for iovs (so they're always recyclable), but you have a
> > comment on the other patch asking why that works; depending on how we
> > converge on that conversation, the details of how the pp refcounting
> > could change.
>
> Even then - we could take the ref as the page "leaks" out of the pool,
> rather than doing it on the fast path, right? Or just BUG_ON() 'cause
> that reference ain't coming back ;)
>

OK, I'll see how the conversation on the other thread converges
vis-a-vis net_iov refcounting happens, and then look at if I can avoid
the binding_get/put per page in that framework.

> > It's nice to know that the binding refcounting will work regardless of
> > the details of how the pp refcounting works. IMHO having the binding
> > rely on the pp refcounting to ensure all the iovs are freed introduces
> > some fragility.
> >
> > Additionally IMO the net_devmem_dmabuf_binding_get/put aren't so
> > expensive to want to optimize out, right? The allocation is a slow
> > path anyway and the fast path recycles netmem.
>
> Yes, I should have read patch 10. I think it's avoidable :) but with
> recycling it can indeed perform just fine (do you happen to have
> recycling rate stats from prod runs?)

I don't to be honest. For a couple of reasons, one is that gcloud VMs
where we mainly use this, these stats are private to the VM and is not
something I can query widly. I only get access to the data when shared
with bug reports on specific issues.

In our internal test runs, I do not monitor the recycling rate to be
honest, as that is fine as long as the recycling is fast enough to
find available memory for incoming data. What I do look at very
closely is the allocation failure rate. That is when GVE tries to
alloc a new devmem but it's out of devmem (which would likely be due
to recycling not happening fast enough). The stat is `page_alloc_fail`
in ethtool -S for us and it's one of the first things I check when
things go wrong. It hasn't been the root cause for any of our issues
in reality.

--
Thanks,
Mina

