Return-Path: <bpf+bounces-33532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247D091E84B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 21:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C1F1C21C38
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A653B16F278;
	Mon,  1 Jul 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZ6WxNcq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF081C8C7
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861137; cv=none; b=Z9b7+NknWJdafGt6B21e0SgQdovw/hLgxIfb1RqI8zvpW3ZcgkNugzazTDlB0W8YgqhTf5ylKMNg9uqahIidQQIvJ+8V3X6306Cb2sATltUnDgEHAtbCid0YzCrkvHnFa4u7irMcL+18Uamh5zylccVeRwXB4Z6QKgA86yHkJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861137; c=relaxed/simple;
	bh=8k0AtF9KiolyJWuK8HLhDCv/hmVhr/rBk1ct5cuT9AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToCzyaZs8g2y9x/dpRq40yVweyQIbonFWgYwy794oOMM7E9BkLR1dEn2F812P83cF5yahIK1GfS2zQZu0lXJU3r0awmdZpR+YmhjuMtCSvFy3L3w9h7KR3TVGj44NhxK8+YVrZC7QXgw0nmEkkst1lCmdyslnlPdvIkKlQpHToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZ6WxNcq; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c22527f8d6so1177142eaf.0
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719861135; x=1720465935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iyaJckUfwKLOavZsL0Dti/NvsfMxOg4fM60nbeLb3c=;
        b=VZ6WxNcqj1Y9gthhzySSEaouXJdWjE3022tMWQXV13JH/YjxCHmJlRWwGmFTaihER8
         dqDvcILbbePiWcR0cm21UuAupAVJJMTf4JqIptuVgjz8Ql7wsK5STw6CmJ2GWCsbCFXP
         4DZhADSiaSGi1v49d9LdRuyO1mpwCunYPOgPZM1lVxIWuav8W2sGqzTtawiXbvFH1QbB
         dO6IUvFcQHZ8qjSwdHnrvf804YXlm/JGyKVpBj4Ui6Vo8L7tpLz2GW+bmu0LBAMlWGgX
         XStbnSnH5KoeozYUaq02axk7H+dz5f0feXE7e8Zbera/mIOZW+vvqbJL/EwLJaFAXDet
         65TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719861135; x=1720465935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iyaJckUfwKLOavZsL0Dti/NvsfMxOg4fM60nbeLb3c=;
        b=Qw+pMi6fNYvrppb47srmbEaDJDYAtnKdufjMoUz+GRB5kRTRYeI5Y/j6IXQF39MLZR
         HmNap5N3HgBGSoiQs1Eajite1dOOO0vMnTQ2X8F1VP5L9Vy+csA2cLmUmJp+ZLuQcsNb
         s5PySF7P/Ceou7WhhNFCtjfzYpY8UftaPJ+ns2exLPLcr5ULlevWVAUf5rfiTBCW8dY3
         AjHKJL7aUhrfj08Lz2MaA48mk19kyvv8/UulsAKlxZYyYxOxyRqcm3/8PkT8uTpdYg6d
         hiczOOFYO5BDq7cINa9RzB0akgb5UxOpx6a6YSsob4m0Z7hbrq4TBR6+ulgThnisOymk
         Hwfw==
X-Forwarded-Encrypted: i=1; AJvYcCXpWGSikvjhCB+oybxu/MAV1/yv5+NfBviB4JOnRS20otom/XE8w/m9xmC6XO85ReDt42YXkeMUDAKAc0lKVZoZYQ7Q
X-Gm-Message-State: AOJu0YzrILAnBRzfbCLdtchV4evvnqwt7MQ2OnTGLkiN5F9VFJOtysu/
	M6wZmLUwLxXPTbTF4RqMTjRm0sshhnEEuUHF/8IoukhApIqha8eEHBaY7+B9ElzU34LRGMpFwlY
	YfBQytGyYMeJG3FU7TVVSd3GJn9ydN+gmPlWAfNSbDMZfXxzeZ6KCvNajxw==
X-Google-Smtp-Source: AGHT+IFMk/Fy8HmApu9Nagm7rkVtZNRgXI7ZtAkmxpMtHuX4P9lSyGrItN72Z9tf2GD9wH/LCrC3alUkG3t3FzAjxFY=
X-Received: by 2002:ad4:5762:0:b0:6b5:413a:3f96 with SMTP id
 6a1803df08f44-6b5b704f0e0mr82787156d6.10.1719860701461; Mon, 01 Jul 2024
 12:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-3-almasrymina@google.com> <m27ce9cris.fsf@gmail.com>
In-Reply-To: <m27ce9cris.fsf@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 1 Jul 2024 12:04:49 -0700
Message-ID: <CAHS8izNM8TjJ1DU+7gzq-0kH=tVeM6j-QsaKk=2FHNDF6RLwnA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 02/14] net: netdev netlink api to bind
 dma-buf to a net device
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
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
	Praveen Kaligineedi <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 3:10=E2=80=AFAM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
> > +  -
> > +    name: bind-dmabuf
> > +    attributes:
> > +      -
> > +        name: ifindex
> > +        doc: netdev ifindex to bind the dma-buf to.
>
> Minor nit:
>
> The series uses a mix of dmabuf and dma-buf but the doc additions
> (devmem.rst) consistently uses dmabuf. I think it would be helpful to be
> consistent here and say 'devmem dmabuf' in the docstring to highlight
> whos dmabuf it is and keep the generated netdev docs in alignment.
>

To be honest, even the dmabuf docs mixes 'dma-buf' and 'dmabuf', to my eye:

https://docs.kernel.org/driver-api/dma-buf.html

I can edit these docs I'm adding so these are consistent.

But on 'devmem dmabuf', not sure to be honest. Technically all dmabufs
are supported, even non-devmem ones. I'm not sure non-devmem dmabufs
are common at all, the only example I can think of is udmabuf whose
primary user is qemu and testing, so it's somewhat implied that the
dmabuf is devmem, and even if it isn't, it would be supported. I
prefer to keep the docs saying just 'dmabuf' as technically all are
supported. Maybe I should add a note about this somewhere in the
dedicated docs.

--=20
Thanks,
Mina

