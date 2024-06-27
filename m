Return-Path: <bpf+bounces-33290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574A91B080
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9991F22B23
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869219EEB9;
	Thu, 27 Jun 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JH490QjO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E819E827
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520635; cv=none; b=kw6tMq7K4YSALMTNPnctSMtqEfcHlXBkRvzq5/n7+zsb9aEju1Xk1WhfJJ9D7L9yo5CX5gFC17+gkbD3g2hRL9ACz7n3b4Cn/mz32/I1JKdm1cK6HUwh5L/fKoSmJq4Q9j72DAmYSon+kDNIm/FKI8SR5ehXOqmiqe+gtbaJ3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520635; c=relaxed/simple;
	bh=l10tJwz6XFZeNVP6zM+7j5f7jFyPN3goI9ctALUvyQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCrrF+1thRSaj2u2BSB3Lx5iXgyHi4xdVI/34WOCVOmNsyHENUlpFrzy7Hu89GOXp3Jqs9iXBBUh5dm7H3NgvAVFRnSW5hAINowUjQYzJojv+ID1stzzMuLEosQhz76wn1rf4HAxgG/2RhJTR7YMTZsf//h8EFZ6b9EeD4p2wE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JH490QjO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so2437079a12.3
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719520631; x=1720125431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQogwTjNx9bNj44zcbbVune0WA12P5prs4FgoFEzpbE=;
        b=JH490QjOzzKkUifvue0qj9hvV1PpFSz94aTH7xFspk0JwnFfHxBJe5HSWeCyq6hBUE
         vQdJu5FLvDVc9psecXewQIqybmVCxlRJMy0ZB30MqTqYmjSnvlemvqrNd2r4jH5xTZKv
         O5AMB/9mHOZNwy/OkllmtEL2SzUSVm5RCV+i91fSYC4FOSYiGfoxF58K5KY5x7+pxTTY
         Q//gQmqUPVYyttWCzNiV8Lr9VFOiEB6XU1EgepKhQMpHmaw+5Lfg+5VP05eKA8qNHRrg
         NBIvo87rMNlLbBchA+dtps5tpRrq68Xt3kDnjEnZCT+JE/VIUHD9n+VL6iF6PZInpsGt
         /Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520631; x=1720125431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQogwTjNx9bNj44zcbbVune0WA12P5prs4FgoFEzpbE=;
        b=uI3V4G2QqTDdzPC+y0LqfT8B2g5EWTuL8VBeXyf119uXhyAlE1hUjxfpikJXNehs1M
         QTexEkfhdT8hoHCjGqT0+Z3RcDgG/0FMM0gAF2gMs/pK9qEY+KZ6ouO5nBwR1fY5pFFH
         qk/+8i2lTYXGp0J8bcW3RumBa2wB6/TCLM80uCGwN1+LrS1uiEbfgU31ZQura9tRRUYt
         O4vQGNDs5Le8WgyGVhGXBXF47gWeUcMFq7lkLXunw4UCI11Ug/RTF9Nmrx1A9lSob+3Z
         mXAcl32XjT2Ieq7CRmK+bt+b2lliJw4VD/vwtyY7YodVTe0UBT2vyysBZglyP0YmKoNM
         HP+A==
X-Forwarded-Encrypted: i=1; AJvYcCXqFEbkY5jJ5AgjsOKACmk7zC/KCjMTXj0Vmmfk9XUvwCVpWoVA5tsVgO9f6Yp8hdIF31anu1e57+8iWI3nWoXD8glH
X-Gm-Message-State: AOJu0YxrECjPI6Tql3YkgtRz079BoyP2oIhKQQrkca4ncJ1R6vYtn9i3
	2PveM/xLev2n34RkD6KMr515UYHtNNQKgnRXWNTcmPIp2k/Rp8pipD1fuR4EffDtt6Lc4AHRK1i
	C/EyuzRBjmkEcM4HXUTcIe36ojunnemVn8I5M
X-Google-Smtp-Source: AGHT+IG01bZgMAGjP5tBPFfqopXM4TOonnMGd8+pitaPiRdrQl4LD+zRRX7r67IiLYfZMFYiFwI3es5iQtpASdeKF2c=
X-Received: by 2002:a17:906:6b10:b0:a72:5226:331d with SMTP id
 a640c23a62f3a-a7252263f95mr778859566b.70.1719520631048; Thu, 27 Jun 2024
 13:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625195407.1922912-1-almasrymina@google.com>
 <20240625195407.1922912-14-almasrymina@google.com> <20240626150822.742eaf6a@kernel.org>
 <20240626174634.2adec19d@kernel.org> <CAHS8izOd_yYNJ6+xv35XoCvF7MzqachPVrkQJbic8-h=T1Vg_A@mail.gmail.com>
In-Reply-To: <CAHS8izOd_yYNJ6+xv35XoCvF7MzqachPVrkQJbic8-h=T1Vg_A@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 27 Jun 2024 13:36:57 -0700
Message-ID: <CAHS8izNBB3+axWFR6cQChAawu194UqzVZ+oZp=c+H5TD4Nd8Zw@mail.gmail.com>
Subject: Re: [PATCH net-next v14 13/13] selftests: add ncdevmem, netcat for
 devmem TCP
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

On Thu, Jun 27, 2024 at 12:55=E2=80=AFPM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Wed, Jun 26, 2024 at 5:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 26 Jun 2024 15:08:22 -0700 Jakub Kicinski wrote:
> > > On Tue, 25 Jun 2024 19:54:01 +0000 Mina Almasry wrote:
> > > > +CFLAGS +=3D -I../../../net/ynl/generated/
> > > > +CFLAGS +=3D -I../../../net/ynl/lib/
> > > > +
> > > > +LDLIBS +=3D ../../../net/ynl/lib/ynl.a ../../../net/ynl/generated/=
protos.a
> > >
> > > Not as easy as this.. Please add this commit to your series:
> > > https://github.com/kuba-moo/linux/commit/c130e8cc7208be544ec4f6f3627f=
1d36875d8c47
> > >
> > > And here's an example of how you then use ynl.mk to code gen and buil=
d
> > > for desired families (note the ordering of variables vs includes,
> > > I remember that part was quite inflexible..):
> > > https://github.com/kuba-moo/linux/commit/5d357f97ccd0248ca6136c5e11ca=
3eadf5091bb3
> >
> > Investigating this further my patches will not work for O=3Dxyz builds
> > either. Please squash this into the relevant changes:
> >
>
> Thanks! I cherry-picked commit 15dbefa97fb98 ("tools: net: package
> libynl for use in selftests"), and then applied the diff below to the
> series [1].
>
> Now:
>
> `git clean -fdx && make  headers_install && make -C
> ./tools/testing/selftests/net` works
>
> `git clean -fdx && make  headers_install && make -C
> ./tools/testing/selftests/net ncdevmem` doesn't work with this error:
>
> make: Entering directory
> '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/ne=
t'
> gcc -Wall -Wl,--no-as-needed -O2 -g -I../../../../usr/include/
> -isystem /usr/local/google/home/almasrymina/cos-kernel/tools/testing/self=
tests/../../../usr/include
> -I../     ncdevmem.c  -lmnl -o ncdevmem
> ncdevmem.c:34:10: fatal error: netdev-user.h: No such file or directory
>    34 | #include "netdev-user.h"
>       |          ^~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [<builtin>: ncdevmem] Error 1
>
> It seems specifying the target doesn't trigger the libynl.a to be
> built. Isn't this a bug, or is that expected?

Nevermind, from a closer look at the docs, it looks like the proper
way to build one test is:

`make -C ./tools/testing/selftests/net TARGETS=3Dncdevmem`, which works.

`make -C ./tools/testing/selftests/net ncdevmem` was just a weird way
I was building the tests that worked for me, but it doesn't actually
show up in the docs. I'm guessing I can ignore the failure.

--=20
Thanks,
Mina

