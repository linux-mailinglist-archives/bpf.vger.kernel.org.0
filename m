Return-Path: <bpf+bounces-31209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3938D864E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F64F1C21744
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88813213B;
	Mon,  3 Jun 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2pGxbPQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019F131BAF
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429459; cv=none; b=PvxIGe2oPhCaA/OnK7dYH8r+jNHsGAddT03xe1pRgiBdkIQ+tsIQoiZ2CDAr/EF/ojeu6JYqOes7Vd/lR0N8x8CNQ45yWsRHj/JwH8C5KzLjed6WqQZ/0GA8V64dOIihTKgKnMfK7YxRZ8akYuGUyLBp4bamIN7HtEVRxe2Vrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429459; c=relaxed/simple;
	bh=ViCOgp0Yz/a1mBDif8ovCtOgE1SFPQZh2StHW9aA04A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JORE9r5EX7QduvuWzH1GV7S/1j8qKCAjdg1cvogu3G0g8ig/UJmUu9N2Fxplr9SCwUPpYC/TDMeft/uzAd86M9TAp0a/5tkgB1kRppd7H4+SoL07upD2OGJ9P17LbZgTh1S9e1G9oFieewUI3N5v+FtzmTp/o25dc9GDMfXN4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2pGxbPQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a634e03339dso495537766b.3
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717429455; x=1718034255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqJ9wkj5wZpDYGPbIA+rqZwe8IgS9OX1IL+4hKpxPn4=;
        b=g2pGxbPQ9ZGPb9G9nYOHHhrxTVOtUJfV9458zm88if8hA13aqyLDEJipAGSqvX8TB+
         FTasRCdH7JHpoINO3WVCONpJheLxEsaNr8Ef1yGDiBNaN2RxJ2Nzl7ihOG9ZAEaFdOK8
         GfllnyypXe50GRE0mPPo+THrRNvBwWfaWOb29haboSGS4whavBCCiCEYHNIDHW2u3Bj9
         mcWO3d1uQJfuFBZAa89/mW4CLtQsdh8Cx0waCMTKIdowIlPddY3GDPmhoWU9o7SJrLe7
         i+0l2jfSFXe46fNY2b0ovBZWKMpvDDMucWgOaO7ZZamsjmtZbL3/zRbXMaKnUCQTMx1t
         8lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717429455; x=1718034255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqJ9wkj5wZpDYGPbIA+rqZwe8IgS9OX1IL+4hKpxPn4=;
        b=rSl1tszcW21CngYRB+VMLvu5bDG/7/YELfYAbTUfJmRZEBNw4alyt9iHIlO7LFEnL4
         djZY4juxv5VbDsxESZUyzG3z4xzobtC/sxaLCkORbRlrbJ/imJeTIinNY54Unh85ex5g
         0FQvQIj4HDdqKYRL6VAMJHH4a8lXVjCSZkARhrzZAgJnXUUPkudb/7efBzfy8pxjM7c/
         SAbuNGNX3P/L98LvdaaqHK7KAbI1T/m84AnsqiT2VLoo/NOV5KWPkO3dFmRiLHY30ZCA
         x9ExF7os5gut4kym8S6+XWBy0AU8jLaLb4n2NshlMRlPRYDoImzoQN8PqBC1tjVYqopY
         SnUg==
X-Forwarded-Encrypted: i=1; AJvYcCVhQ7vmCtv6BwIez6tc+tpOBpVUK/JKihv74hRxZ5WXWncfVuZiXP9LOf1xRSWzbkP/lwc/539PVlAEghsaIeUB59ge
X-Gm-Message-State: AOJu0YwsFIbUUlqYCbeMMibOLwMqZ7+XigZPoWH8UCcQSbl4T1E4/t+5
	RJv/PRp0cQdgfoF3GN4V497QygwFeIH6pa5G0WH30ip1M3fHr95npJ/zQr6/gDShYoGBDy6GwtM
	3xdwK0IT7YdprQjUS7Oc4cb8B8r+aZ17yv1lP
X-Google-Smtp-Source: AGHT+IEgXEMq7A34vV1MITk1aHrXEuVw+nVV7KMqkaSqRj4HNWxMWt5F6AEA8YGPMHEYOyWRevT8/8awpnNeVecVNuY=
X-Received: by 2002:a17:907:3f28:b0:a68:5ac4:3aaf with SMTP id
 a640c23a62f3a-a685ac43be7mr699125166b.41.1717429454535; Mon, 03 Jun 2024
 08:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com> <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com> <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
In-Reply-To: <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Jun 2024 08:43:58 -0700
Message-ID: <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:52=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 6/3/24 15:17, Mina Almasry wrote:
> > On Fri, May 31, 2024 at 10:35=E2=80=AFPM Christoph Hellwig <hch@infrade=
ad.org> wrote:
> >>
> >> On Thu, May 30, 2024 at 08:16:01PM +0000, Mina Almasry wrote:
> >>> I'm unsure if the discussion has been resolved yet. Sending the serie=
s
> >>> anyway to get reviews/feedback on the (unrelated) rest of the series.
> >>
> >> As far as I'm concerned it is not.  I've not seen any convincing
> >> argument for more than page/folio allocator including larger order /
> >> huge page and dmabuf.
> >>
> >
> > Thanks Christoph, this particular patch series adds dmabuf, so I
> > assume no objection there. I assume the objection is that you want the
> > generic, extensible hooks removed.
> >
> > To be honest, I don't think the hooks are an integral part of the
> > design, and at this point I think we've argued for them enough. I
> > think we can easily achieve the same thing with just raw if statements
> > in a couple of places. We can always add the hooks if and only if we
> > actually justify many memory providers.
> >
> > Any objections to me removing the hooks and directing to memory
> > allocations via simple if statements? Something like (very rough
> > draft, doesn't compile):
>
> The question for Christoph is what exactly is the objection here? Why we
> would not be using well defined ops when we know there will be more
> users? Repeating what I said in the last thread, for io_uring it's used
> to implement the flow of buffers from userspace to the kernel, the ABI,
> which is orthogonal to the issue of what memory type it is and how it
> came there. And even if you mandate unnecessary dmabuf condoms for user
> memory in one form or another IMHO for no clear reason, the callbacks
> (or yet another if-else) would still be needed.
>
> Sure, Mina can drop and hard code devmem path to easy the pain for
> him and delay the discussion, but then shortly after I will be
> re-sending same shit.

You don't need to re-send the same ops again, right? You can add io
uring support without ops. Something like:

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
+       if (unlikely(page_pool_is_dmabuf(pool)))
+               netmem =3D mp_dmabuf_devmem_alloc_pages():
+       else if (unlikely(page_pool_is_iouring(pool)))
+               netmem =3D mp_io_uring_alloc_pages():
       else
                netmem =3D __page_pool_alloc_pages_slow(pool, gfp);
        return netmem;

So IMO, the ops themselves, which Christoph is repeatedly nacking, are
not that important.

I humbly think the energy should be spent convincing maintainers of
the use case of io uring memory, not the ops. The ops are a cosmetic
change to the code, and can be added later. Christoph is nacking the
ops because it gives people too much rope [1].

But if you disagree and think the ops themselves are important for a
reason I missed, I'm happy waiting until agreement is reached here.
Sorry, just voicing my 2 cents.

[1] https://lore.kernel.org/netdev/ZjjHUh1eINPg1wkn@infradead.org/

--=20
Thanks,
Mina

