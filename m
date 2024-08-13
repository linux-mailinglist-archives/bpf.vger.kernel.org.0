Return-Path: <bpf+bounces-37008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087695000E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 10:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C07BB23E70
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C9916A957;
	Tue, 13 Aug 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHsKWfs7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88AA13BC38
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538405; cv=none; b=VOA+s26w4QibZ2aQF51IDL0GhV2FA/EZ1s8v/plorJwpvpHUGzkX2PFoOO65CK/7wn2pY0jT4RtkXo3mUsTb+gADym02vgX1JJXGU1EmpWrD3YVfdM5DBI9hBXZbZ2A1CVDNOwklClNI/9QaBggBu/LHV6x4ZkgV5ZwJLEvrhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538405; c=relaxed/simple;
	bh=h+dDRWN8jV1nwMrGh+WAeD+/RlJnf+Y+F73/jQ+w7EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evjJ09te3JMYQzJJ99UDor2yBfmhYpT2shXKboXLejXEdH4qPVoE69NMO5kGLfQ9/zWF2oRJVxq5WrH+Qp6PmL0Do3ktvEJaogHYS/kgXES270kKt+Pi0dE0CF1xwvThN6cwrHMeJYeCI+rd9HdgcC9kjGI7wWrOWaDSpszHNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHsKWfs7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b79293a858so28631546d6.3
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 01:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723538402; x=1724143202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfIvxCWgLL4atIJlIA0PqbGSOJqgAf1LTciUfWWJUn8=;
        b=ZHsKWfs7XtacxS/e4HWnhLfpJeF1dQI15r6Gs+SssFzW1ORp9CSZbLkX+hPNmtz1dI
         V/lKHrB3TsgX8KaIlDbgXULOr+QMVyve7FGhCEdOpMzW50ZHiBDmeqtCdpCfKixVqWD5
         5LWzxX4XqIisrqFfOshRHqnT26ZngO/8W9Ofc2CqNzF8YR2uslGYCV7JWJ13iJRSywjP
         IxsvzFhdPlhFF/JnUoJzWVYzIdQVNb2KxpFfMSwvEFXT2sZ9przycdnLBZyTnjglCt4/
         aAnWg8QyMuVtxMlIa3PyPKlJROi745DjcQvbz/HiBkixIKxV/AxIC7aBz/jcE0tM9gvZ
         cwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723538402; x=1724143202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfIvxCWgLL4atIJlIA0PqbGSOJqgAf1LTciUfWWJUn8=;
        b=jvVEsqCZjtvYelka/yrhk+4/E8JAejTzeYTVxde6uTO88Sq3Ryk/y9ZpjTwLQm6Ebp
         2Vp40l7NgjS5OihpTDvo+Dmln9BeuAgDDHuYN1zhxpqLmNk60Tb9sX5Wv/S9DC84J9X3
         1mQ1BZxQjkO32zpyEoW0lnPCBgcB/6JzhuZjtDU4WpGdCgzeGbcPUhMcGhWtkY9JS6cr
         euQI47ZHjK/1PztPvaRfrsAfSR8hKjVQPmxReY42ZETsyolmWBgrDKzoA1emoRZ6Vw3k
         SGTgrOn/uoHuRc3IWCtiikwwQxn2P/xK018LrzBzUpO4wzTYLwkAPkvquUTtHBPRb9hC
         sxBw==
X-Forwarded-Encrypted: i=1; AJvYcCUsS0Tv6cZr8GqgO2t6sZoEt87U3uHlVxjxBtj9PZSHlSwfaUQM8jJt1PARnP5ZhXGYkpcJijN5eigz8mzZ2Aj4yVAt
X-Gm-Message-State: AOJu0YzG8RDtffSFBpyqjVLK31Mk4D7+lCsk/N3KODD7fBaLmvhv8DUi
	q/DD/pS48IhdrKk6/02vsYDTDLPrQXADpayd6NFJf2gTVqjMcgSLIgKR6N5Vom7RuiSN62HxQqq
	F7UvLy6MIx/jacK9lzVd1bHLq9wLBMDXjdPsr
X-Google-Smtp-Source: AGHT+IF5vZpwMEwyKOsMjByGok50VQq9OHjXt2iZMdoR51xqc5PshbKjWlTOU09k9dSw6zDIWNspGRLkyEdh4LkEteM=
X-Received: by 2002:a05:6214:4410:b0:6b5:e2da:8bec with SMTP id
 6a1803df08f44-6bf4f89a375mr28560176d6.55.1723538401526; Tue, 13 Aug 2024
 01:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805212536.2172174-1-almasrymina@google.com>
 <20240805212536.2172174-8-almasrymina@google.com> <20240806135924.5bb65ec7@kernel.org>
 <CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
 <20240808192410.37a49724@kernel.org> <CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
 <fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com> <20240809205236.77c959b0@kernel.org>
 <CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
 <48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com> <20240812105732.5d2845e4@kernel.org>
 <7e2ffe62-032a-4c5e-953b-b7117ab076be@gmail.com> <71260e3c-dee4-4bf0-b257-cdabd8cff3f1@gmail.com>
 <20240812171548.509ca539@kernel.org>
In-Reply-To: <20240812171548.509ca539@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Aug 2024 04:39:47 -0400
Message-ID: <CAHS8izPyGwe_i4eNemW+A+MgMVHqJ0fdp=+-ju2ynqgc0mb_Ow@mail.gmail.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> BTW, Mina, the core should probably also check that XDP isn't installed
> before / while the netmem is bound to a queue.

Sorry if noob question, but what is the proper check for this? I tried
adding this to net_devmem_bind_dmabuf_to_queue():

if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
                 return -EEXIST;

But quickly found out that in  netif_alloc_rx_queues() we initialize
all the rxq->xdp_rxq to state REGISTERED regardless whether xdp is
installed or not, so this check actually fails.

Worthy of note is that GVE holds an instance of xdp_rxq_info in
gve_rx_ring, and seems to use that for its xdp information, not the
one that hangs off of netdev_rx_queue in core.

Additionally, my understanding of XDP is limited, but why do we want
to disable it? My understanding is that XDP is a kernel bypass that
hands the data directly to userspace. In theory at least there should
be no issue binding dmabuf to a queue, then getting the data in the
queue via an XDP program instead of via TCP sockets or io uring. Is
there some fundamental reason why dmabuf and XDP are incompatible?

--=20
Thanks,
Mina

