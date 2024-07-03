Return-Path: <bpf+bounces-33784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EF492668B
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0581C212C6
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB831849D2;
	Wed,  3 Jul 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQZE0GZb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A341836EC
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025820; cv=none; b=A75U4J8i2UtM/v0CLk96y63jG9mkTmhm1u4oiqv7J9PYuPdP8W2Dfj6CrZUxdB4hX6BsJTFT2SXh/CXeOGBVpNfkchpR7Bog5LUxkajy7v6+fh8DfzXTgnDKWfVD97EpU6VaLtn2EgQEdA5+wgyFgn45/iwKKCHq0AGbAeLnFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025820; c=relaxed/simple;
	bh=teX37XgyvV7Ru/Jak1UKwFMmY5CaQcTdzWuf15lXc+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9eAJodjEeEC8DUV6p5wMj7G9IS6kN6TkatpLwtLvkU/fHfEQ2/Ga7XYNYEdJjcfNk5Ctj91Um10il+QUGmmQOb5rZhwqft11trq6STOzPMbATw++zAcIl7mmA61gXMySzfYuoUheM4vzoWAgY3Wodn6LmhXz8O3XY5ZkNQUj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQZE0GZb; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4464284029dso6912491cf.1
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2024 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720025817; x=1720630617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrJD6ayDYRlKNRvFck9p1oXm/3SuBonkBJdf4YKQA4Q=;
        b=vQZE0GZb7fexqOcBdhRYPWAj0P4ObfKnMLiFFpPLEmD/xufEEl++ynxXqybA5aFUSP
         kr4/XxCNQcPnfcgi0L32zq+/yxC1t2hvvqdx4xBe3HjZ/smRNixqDs2/WXoVZZknAM3L
         WJTWnsdzRIBK1WMafbT/G283v09bfBV5zsJ+Zq7/hpfvn3r4DpBL+Ahyw9K4t4EFW5V+
         RwrUTmV9adUhP0NdR4wl8WLp9xxDxHRU7XGmRZIUSdGYmt/9H4AxO+XwJgn6V1uIOuq2
         RShRkje5Pjmx9VEP1HnD6OSPcHC+R/7+CLuAJEfwNsy5Pioa232pVhNz7kyzRLGaMgf1
         jw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720025817; x=1720630617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrJD6ayDYRlKNRvFck9p1oXm/3SuBonkBJdf4YKQA4Q=;
        b=B+tIDrMh49yi3BVCR1c0ccSQnolaYz5aJF/0V3rJd1AgeV6lrkKgfl1UspXIWNhJIi
         +1/dTPcVTHCjzo8VDFVjfWG/yUHi2gk3YPqReA9C320fRJx4AYryEv/O3hg8BoFGSOI4
         cX7dFFb2K1SgVxt4na/0UNGeZB3AZ/3UB1luzUOESV7GMt+HRwBMKHcY/MS/G9O+xFxj
         VJyxWhaxVZmx6U5zTo8pfhNU6kCVkv53CwLME04FmEzguImVheHblYTAMH+AqfT47r48
         3Q7C5wG6i/BHMmsUanTteN/l/HdEsgoUQaLJfmIQPhLZjoxa/UAPfh+TAumaNx3n+2yT
         Dx9g==
X-Forwarded-Encrypted: i=1; AJvYcCVEd0De51wSNE1x7h46A2L16dXEKG822TpzZ9o9822rthNSyNNEHPdGBiBaPRM4xtMZ2RXZharRKImHMpu5oEEtxZja
X-Gm-Message-State: AOJu0YwcZRKf9RyL123dMwvGtHGeSqmRiiwkIpfTA0qV5JR1pEknuiKI
	mtYBfY6Y5E1JFCo6fu3v43VaZQqkWCoxebD4y8ksck/veMxGx2zymxvnsZfGUFf/snNB4TvrqKU
	giQ5xkW1X5uQQfQ40MosQZwHmhqeCVfTN7ylc
X-Google-Smtp-Source: AGHT+IHa/cTtQMTpCl1GUnThR28S74I0bK2ol+291xiVaR+Vs/Jxc9vIdy+MzRrhMch0GbY9JMd0YjCsO1EcciUeO1w=
X-Received: by 2002:a05:6214:20e2:b0:6b5:198e:353d with SMTP id
 6a1803df08f44-6b5e18b18f4mr30603556d6.10.1720025817412; Wed, 03 Jul 2024
 09:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-4-almasrymina@google.com> <20240702180908.0eccf78f@kernel.org>
In-Reply-To: <20240702180908.0eccf78f@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 3 Jul 2024 09:56:45 -0700
Message-ID: <CAHS8izOCuNZWfZR_jecFOMu2XGqcYUkuVf38wRqBvoE9tmGzoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/14] netdev: support binding dma-buf to netdevice
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 28 Jun 2024 00:32:40 +0000 Mina Almasry wrote:
> > +     if (binding->list.next)
> > +             list_del(&binding->list);
> > +
> > +     xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
>
> nit: s/bound_rxq_list/bound_rxqs/ ? it's not a list
>
> > +             if (rxq->mp_params.mp_priv =3D=3D binding) {
> > +                     /* We hold the rtnl_lock while binding/unbinding
> > +                      * dma-buf, so we can't race with another thread =
that
> > +                      * is also modifying this value. However, the pag=
e_pool
> > +                      * may read this config while it's creating its
> > +                      * rx-queues. WRITE_ONCE() here to match the
> > +                      * READ_ONCE() in the page_pool.
> > +                      */
> > +                     WRITE_ONCE(rxq->mp_params.mp_priv, NULL);
>
> Is this really sufficient in terms of locking? @binding is not
> RCU-protected and neither is the reader guaranteed to be in
> an RCU critical section. Actually the "reader" tries to take a ref
> and use this struct so it's not even a pure reader.
>
> Let's add a lock or use one of the existing locks
>

Can we just use rtnl_lock() for this synchronization? It seems it's
already locked everywhere that access mp_params.mp_priv, so the
WRITE/READ_ONCE are actually superfluous. Both the dmabuf bind/unbind
already lock rtnl_lock, and the only other place that access
mp_params.mp_priv is page_pool_init(). I think it's reasonable to
assume rtnl_lock is also held during page_pool_init, no? AFAICT it
would be very weird for some code path to be reconfiguring the driver
page_pools without holding rtnl_lock?

What I wanna do here is delete the incorrect comment, remove the
READ/WRITE_ONCE, and maybe add a DEBUG_NET_WARN_ON(!rtnl_is_locked())
in mp_dmabuf_devmem_init() but probably that is too defensive.

Will apply the other comments, thanks.

--=20
Thanks,
Mina

