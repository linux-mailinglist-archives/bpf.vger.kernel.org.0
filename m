Return-Path: <bpf+bounces-39209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A45EC970AC2
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 02:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DABFB211FA
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 00:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863F6AD2C;
	Mon,  9 Sep 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1Phm7wG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABD6116
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725841299; cv=none; b=R+gxsxQ6q1wyqkQdVZX5slyblbFFjzOX4H64DVv5yAVobGjdLVXSad/BU0+ec0kUwPQg5GtPt5F6fnbY11sh/jRGUjJ8Nh3JN7aK6wZp3xEHPd6j8YpvwtuJN+LRBPwuyg6BpyCTUXrWv8xCkJwU18UQ5cWTpGHOuSHC+K2OSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725841299; c=relaxed/simple;
	bh=KVZMNnMYMnNRh9XEUd/AbAsrshEQNXgSkDB5lDD5qq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBTUzzWYrYwyMiHr55EhJgDCko5QYU4zOwRA5JlV507adoANcJouPS+RyP18xajYiAjmdy0KdVoK7MWt/NXepKH2ehWQfp20GZ5Wh2YMRXuMrNFRuuLoENjQAxCwIgBQr5so+xrtadzGvwNIeahdFruAl+vtW6d0/BLI3uSfMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1Phm7wG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4582a5b495cso163431cf.1
        for <bpf@vger.kernel.org>; Sun, 08 Sep 2024 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725841296; x=1726446096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M1qVooEyNPT1gAAftfRiR4Q5Ah3XuHi08JSkLTfyCg=;
        b=L1Phm7wGMuZuJebhYKnd+JQyBUyE9C1zk1fQHdZNxb97P8m+M+PxEraXZjvXXUAMxN
         YgeLRp+lFQS66t9ESCBstlYEggoxa0L1O/PC+UpZxl6L665n3Rv4OnKWpcbaTlaXpWf0
         9c/7mIYxN3/DmAJu6trHAsXv8hyRFuuFoFHjV/iJGToGgpxTbH2z/J2T93C6Ekh9D9Xw
         mKakVQhQm860axVGd1VHj7SIRv/pB5vXfMZqrzwpugZo5E1rbuACJ0d/qs9z36lc0gC4
         v+H5OuBq9pX20rpRn3oES5ryQ4nnoL4jusdt9JjBhzBLJ3hxIViJUR2dmGv04meKCtBN
         ye6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725841296; x=1726446096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+M1qVooEyNPT1gAAftfRiR4Q5Ah3XuHi08JSkLTfyCg=;
        b=ibr0WjTjSUlXzwKmUqmmsP9A89sNmhwKebapM10GbBza1nZwUjCRHahbdOvHk+7wMB
         XEf4pH+QsrWyh5f4eoyNVNsiu4qg9bhiUWvlFm17YeGS2ZdqEwTMQSxYLofSDw8+jMXU
         AeMxKz6wcD8icoQzwjjMiIbCgG+gXJzELSknqv5rzsxWvsDzPlLsG7PFACzliUqJoxq7
         RE1AZLgrvAazvWgNtvVoVg0etZ4YOS5ATktlp8o7PtgIz8R5SnpXhsbEiO3c5eW/8Aq0
         co9okcDGtEriZA0l9RAz6hWYBnulZ5lhJQWmu1w/OpS44XNZODOYQTMszJ/L2T85m+VC
         dxQw==
X-Forwarded-Encrypted: i=1; AJvYcCUKA7FXaM9xEaxcPKk/J4PVDTY0gjQBZIGml0TMcpocQKRLcKM9GQ3s5DgxRqeYSI0Y2oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmhgnV4w2sNgn0XT/GvgUubH+QHyIbqk/7GAQfLmmS0vfixcq
	E2WSZtDC45c5ABFZHNYyaOz8/f8twZyilpKKrt6FWN5+5NbIM0ReffO1NHGWvnUHCtauA3NOhoC
	3TRqi+bE4PmyPhzQXam0xr7dresIUCu/RDkZi
X-Google-Smtp-Source: AGHT+IHeebo47LrVuqQNlmWSroknDWyh0p2+ySnmSfFMd++vvWmH0RLig1T8xF/sYDtVArFYD/iKIyTthz+4Y2vdWxE=
X-Received: by 2002:ac8:5714:0:b0:456:796b:2fe5 with SMTP id
 d75a77b69052e-4582147fdcamr3000151cf.9.1725841295262; Sun, 08 Sep 2024
 17:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831004313.3713467-1-almasrymina@google.com>
 <20240831004313.3713467-7-almasrymina@google.com> <20240903141948.269e22bb@kernel.org>
In-Reply-To: <20240903141948.269e22bb@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 8 Sep 2024 17:21:23 -0700
Message-ID: <CAHS8izN_6_0VUWJzyXZ60kDjvGpdJv1a=-6mGOURapHdfHbcMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v24 06/13] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 31 Aug 2024 00:43:06 +0000 Mina Almasry wrote:
> > diff --git a/include/net/mp_dmabuf_devmem.h b/include/net/mp_dmabuf_dev=
mem.h
> > new file mode 100644
> > index 000000000000..6d1cf2a77f6b
> > --- /dev/null
> > +++ b/include/net/mp_dmabuf_devmem.h
>
> this header can live under net/core/ like netmem_priv.h right?
> devmem internals should be of no interest outside of core networking.
>

Yes, those can be moved under net/core trivially. done.

> In fact the same is true for include/net/devmem.h ?
>

This turned out to be possible, but with a minor moving around of some
helpers. Basically netmem.h included devmem.h to get access to some
devmem internals for some of the net_iov helpers specific to devmem.
Moving these helpers to devmem.h enabled me to keep
include/net/netmem.h but put devmem.h under net/core. Now netmem.h
doesn't need to include devmem.h. I think this is an improvement.

> > +static inline netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_po=
ol *pool,
> > +                                                     gfp_t gfp)
>
> Please break the lines after the return type if the line gets long:
>
> static inline netmem_ref
> mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
>
> Please fix where you can (at least where it cases going over 80 chars)
>

FWIW I use a formatting tool (clang-format) which seems to prefer
breaking in between the args, but I'll fix this manually and wherever
else I notice.

> >       struct_group_tagged(page_pool_params_slow, slow,
> >               struct net_device *netdev;
> > +             struct netdev_rx_queue *queue;
>
> Why set a pointer? It should work but drivers don't usually deal with
> netdev_rx_queue struct directly. struct xdp_rxq_info takes an integer
> queue id, and it serves a somewhat similar function.
>
> Keep in mind that there will be more drivers than core code, so
> convenience for them matters more.
>

Makes sense.

> > +bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref =
netmem)
> > +{
> > +     if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> > +             return false;
> > +
> > +     if (WARN_ON_ONCE(atomic_long_read(netmem_get_pp_ref_count_ref(net=
mem)) !=3D
> > +                  1))
>
> something needs factoring out here, to make this line shorter, please..
> either netmem -> net_iov conversion or at least reading of the ref
> count?
>

Ah, sorry I think you pointed this out earlier and I missed applying
it. Should be done in the next iteration.

--
Thanks,
Mina

