Return-Path: <bpf+bounces-28896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9728BE999
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0472B28D501
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD117B4F0;
	Tue,  7 May 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFMNv4LT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54B16E862
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100141; cv=none; b=cZIbt3M1PcK5fsLrImZoBbZ3a0+Z+JRDtMv8j37DGgCTOX/OWIXEh9pWZPK7lCFaQSM/3rMeXT+ir58jNXkQCoUfXuadbLof2FmL9Z0T4bg2AW7mA9mDDNJj7Wxr5OCtBoxpvFFMsFRZDWxfTSH+CUmSShmOeIv5xveOVcBj0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100141; c=relaxed/simple;
	bh=4xUNxPDzztu8L8/w3Kr2Lgr1+A9SAEy6b6FHPJHwwv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfGAh3i6Nf0nGKVIx30Sp8sJ5ImGxNMrwADOtYWuE33+XlPOPkClOoYcKU1NjRi3cq/9rHi73cQ470cELAyW9fsxshovR1NhcHugGEhouMDPva04IH7xDZw5RBsuVZ0dbQ9YhtP1xvLNcDbA7XTZ1ZFFIU3qLs6L8U/8h1jVy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFMNv4LT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a387fbc9so844359766b.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715100138; x=1715704938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI6bl9uqwH7zmPDcLL9svN5oVbQ7KUvxyIQRaOdtpl4=;
        b=fFMNv4LTPJ31z4uW9YnTXqY/+P/Lu3XxPsX1vj/FcwrlahaksKtwSIJkvvDzcu2rIw
         kUFK/asO0I1jpjKDr04+deUss1rHngscpNh095cNT9yAlUJGoBVdvFddfEUhojuVSLd8
         Eto5no1o3YDn7s96fv4R3s6xbKb5Bsur/LC9clY8PjSwiL/9uzZj5LS5/oC+2OGW3A0+
         vm7S0Y+TFMGs2VB53VFjDniE4wLpnem+YNJTJmc4qzG2ipR7VsHrwzdTNO1UY3pswfMu
         NQONvfepGVrBaio6afuQzEqvzCXU8mh+EjojwyPooBi4z5e68SfByNYD/7cU59orv47R
         zBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100138; x=1715704938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI6bl9uqwH7zmPDcLL9svN5oVbQ7KUvxyIQRaOdtpl4=;
        b=bz7nNBs7x2i6amVrGcxHkMztRqyGcb0/c8r25N3jW678Dt+tyA37/r3xYOsS4dy5mU
         9u2zlZwVNmiWOstoxMJHiPo5GLB21Jzu1r+/hDmGpwah8lZIfRyecLA004VQ/z0MsG7O
         Q/qyQ0xH0OR00jXIRJY4gssIaksCpHuIcO7h6Vt1troONvG96Tds/SK21ROdBvzOi5GF
         +W8gHtcQMVJj55lMnrRqy80W7YrnUkA8vlGNaGbCPH0a3OlwEsD9d3nvxLhC8ovakkm8
         6+ZcgJCjo9eMUQkXp26Zj5SkG5I41Zxfy1/UAs5Shhu7PVMDozDCSbFDYXE0mgeEpXof
         3Aug==
X-Forwarded-Encrypted: i=1; AJvYcCX2rDDQjt9Bied+gmYQGeWtFXzc11uWAq7SyKT1lnGw33V5dz1YdD9xO0W1iXG/T3pD+VeOdIA/mVRwKXV4pVs+1wyw
X-Gm-Message-State: AOJu0Yy3mD37w/ttxYtMFxXO7ZTeUNrH8/+jMTiZTrt5nruMe80zoiww
	0ncXX8fw+vwng0vR4rfLFDImBPS3pbCfLvII2hHYJud1LFnLlbS9wOXe7IrF8b+hDRBhrgXnznF
	nHQ49hGDauoVmsFqIysaVKjUcEAldPN/pGgJp
X-Google-Smtp-Source: AGHT+IGXrfCrbPuBFYGXmT+FZdafT4oz7XFNMT8FfUWaWmudph1z0+uFgT86I0JhwB1+1uK0PlezLiQ7rsxPPg9MW2Q=
X-Received: by 2002:a17:906:1d4b:b0:a59:c833:d275 with SMTP id
 a640c23a62f3a-a59fb94dbe4mr1458266b.30.1715100137853; Tue, 07 May 2024
 09:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com> <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org> <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
In-Reply-To: <ZjpVfPqGNfE5N4bl@infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 May 2024 09:42:05 -0700
Message-ID: <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
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
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:24=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, May 07, 2024 at 01:18:57PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 07, 2024 at 05:05:12PM +0100, Pavel Begunkov wrote:
> > > > even in tree if you give them enough rope, and they should not have
> > > > that rope when the only sensible options are page/folio based kerne=
l
> > > > memory (incuding large/huge folios) and dmabuf.
> > >
> > > I believe there is at least one deep confusion here, considering you
> > > previously mentioned Keith's pre-mapping patches. The "hooks" are not
> > > that about in what format you pass memory, it's arguably the least
> > > interesting part for page pool, more or less it'd circulate whatever
> > > is given. It's more of how to have a better control over buffer lifet=
ime
> > > and implement a buffer pool passing data to users and empty buffers
> > > back.
> >
> > Isn't that more or less exactly what dmabuf is? Why do you need
> > another almost dma-buf thing for another project?
>
> That's the exact point I've been making since the last round of
> the series.  We don't need to reinvent dmabuf poorly in every
> subsystem, but instead fix the odd parts in it and make it suitable
> for everyone.
>


FWIW the change Christoph is requesting is straight forward from my
POV and doesn't really hurt the devmem use case. I'd basically remove
the ops and add an if statement in the slow path where the ops are
being used to alloc/free from dmabuf instead of alloc_pages().
Something like (very rough, doesn't compile):

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 92be1aaf18ccc..2cc986455bce6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -557,8 +557,8 @@ netmem_ref page_pool_alloc_netmem(struct page_pool
*pool, gfp_t gfp)
                return netmem;

        /* Slow-path: cache empty, do real allocation */
-       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_op=
s)
-               netmem =3D pool->mp_ops->alloc_pages(pool, gfp);
+       if (page_pool_is_dmabuf(pool))
+               netmem =3D mp_dmabuf_devmem_alloc_pages():
        else
                netmem =3D __page_pool_alloc_pages_slow(pool, gfp);
        return netmem;


The folks that will be negatively impacted by this are
Jakub/Pavel/David. I think all were planning to extend the hooks for
io_uring or other memory types.

Pavel/David, AFAICT you have these options here (but maybe you can
think of more):

1. Align with devmem TCP to use udmabuf for your io_uring memory. I
think in the past you said it's a uapi you don't link but in the face
of this pushback you may want to reconsider.

2. Follow the example of devmem TCP and add another if statement to
alloc from io_uring, so something like:

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 92be1aaf18ccc..3545bb82c7d05 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -557,8 +557,10 @@ netmem_ref page_pool_alloc_netmem(struct
page_pool *pool, gfp_t gfp)
                return netmem;

        /* Slow-path: cache empty, do real allocation */
-       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_op=
s)
-               netmem =3D pool->mp_ops->alloc_pages(pool, gfp);
+       if (page_pool_is_dmabuf(pool))
+               netmem =3D mp_dmabuf_devmem_alloc_pages():
+       else if (page_pool_is_io_uring(pool))
+               netmem =3D mp_io_uring_alloc_pages():
        else
                netmem =3D __page_pool_alloc_pages_slow(pool, gfp);
        return netmem;

Note that Christoph/Jason may not like you adding non-dmabuf io_uring
backing memory in the first place, so there may be pushback against
this approach.

3. Pushback on the nack on this thread. It seems you're already
discussing this. I'll see what happens.

To be honest the GVE queue-API has just been merged I think, so I'm
now unblocked on sending non-RFCs of this work and I'm hoping to send
the next version soon. I may apply these changes on the next version
for more discussion or leave as is and carry the nack until the
conversation converges.

--=20
Thanks,
Mina

