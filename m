Return-Path: <bpf+bounces-31862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9319042B9
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBCF1C24D28
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FBE73473;
	Tue, 11 Jun 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPVFjqjN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A057C8A
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128143; cv=none; b=JbEOa1Ge8NW6qklDC3GSlpvcw8AxPoRjn0Dv0sV/lLm8nCGPFrYViOw+bLapOXKA2yWznKmh3Ubngi12UN8TWPLY/lqlVKLmftKIJId6pLN14C9DVXuLKyk1Fsn3nBiJgib1fHCWTxRGnU+PDIRyYeDjUBoCd7ZjZjzsWckZhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128143; c=relaxed/simple;
	bh=qqI28F86pyCn46b6E2hC9EGzpBvx1aR16iSkTi1rBL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peaJsswF+tgEyXdmiDVaqGDD3Zdjs0sEVHUeCPKdvqip+YuVa0+nLpC0+H77wKlK0se23UbmhGZ3mlB0gbyuS8ByqLnh4E33szmSnBkNXp9okdDJHMR7jqGOdwVv59Qb8nx7IL4ljWjffKVP+7iOx9uUY+tB3K/xwek46YrDAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPVFjqjN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52962423ed8so6884305e87.2
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718128140; x=1718732940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqI28F86pyCn46b6E2hC9EGzpBvx1aR16iSkTi1rBL8=;
        b=IPVFjqjN/tV8zxx7PkHbMF4K/IYb/jlC2tNit5JdvoLifzWpkyDf9JrBFefkflu+aW
         hiA18c2EjQNXyBLcSixdWO0kk2xuSNuKdKO/T7XNH/JOiYXo+V6xtEBI+/UQnZVN4Wi4
         wJmV3pBdP3FZ+M+BJPCgzvoMJX6U7b0v6zRx97/K244ibz8EcDPiJyb24JuTdFHzGOps
         N87qOHVGTsz0jLlKV2cAcqOd96eJfNPr8SjRHvz2/Ne5EGuStsAG8Se3GTIfhH3848XQ
         tTf1dm55Al2vnllfL+M3Kh3sVeZM4YFd8HbBIyODEajeZeimEvCZznCejuVCGbBO8fyz
         HLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718128140; x=1718732940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqI28F86pyCn46b6E2hC9EGzpBvx1aR16iSkTi1rBL8=;
        b=fD1n1N7jCJG190e+rrU74pdmWVVASUzmZ0orRSczVBnnV2BE4CpqCcosgKkhrVSCtn
         8Q3gn6juiitbPdaZZO90vonYr9z6mdmlCUsJGvF+B2PFTSb0dFhs3lpKmnHzOYWLZs90
         CACtGa3xaVzrFsaH+u0GXc91EYQHSMCS2ONxlKx529C7LpU9OCay0jDiOVDMGRsVxLGp
         IhdkIgbMAZAsK2ts7IjFAuY/9cnGphvQWG+jlSPNRG0azAJ2Q7+9eUwDO1sWDFWIYqB2
         Z2JsVLy3CEvqypU9M4O9tHqeOOEfBNssIK+4ofSpEe5gIMqEoUwmH7BNLTNbrkfvahYO
         vLDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUET6ZPR+nF4nfeMZivldRWcbU6TZDBcgQsWTiYXoJZVjtq9GS+CBU0liMyTfcTIUyIx2lAJRYsNYiuPGE3mS8IuQES
X-Gm-Message-State: AOJu0Ywj0wAnFfRG2LbaGKY+bsrqFdPu5hQkJT58Ytdjv892bMnpEL5K
	6eIar4bX4PfYKynh9plEnqwFLPdHax8pNyKH1jh1uijCu3V8wbc36P6f8xhvfHxHgTjF9aHGTT/
	Cev0JSoelbNoJFs3So6e+ArRl2ug6HDizCFU7
X-Google-Smtp-Source: AGHT+IGQwZWXRepZRotKaxzF2bqAPZNCNL5wX5Y/FzlEvs4cnUetjrNqG6bJ0xN0MmD46e2zpfETL/dJPuZcdCbp5Pc=
X-Received: by 2002:a05:6512:324f:b0:52b:fc90:acdc with SMTP id
 2adb3069b0e04-52bfc90ae01mr6138523e87.32.1718128139379; Tue, 11 Jun 2024
 10:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com> <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com> <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca> <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com> <20240610121625.GI791043@ziepe.ca>
 <59443d14-1f1d-42bb-8be3-73e6e4a0b683@kernel.org> <ZmfuGUugiwMPdnkR@infradead.org>
In-Reply-To: <ZmfuGUugiwMPdnkR@infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Jun 2024 10:48:47 -0700
Message-ID: <CAHS8izOyV4ZFi=sC5BofaS2NQ=QDAKsmpd2Z1iaNDLpd9rOKVw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>
Cc: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	Herbert Xu <herbert@gondor.apana.org.au>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:26=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Mon, Jun 10, 2024 at 09:16:43AM -0600, David Ahern wrote:
> >
> > exactly. io_uring, page_pool, dmabuf - all kernel building blocks for
> > solutions. This why I was pushing for Mina's set not to be using the
> > name `devmem` - it is but one type of memory and with dmabuf it should
> > not matter if it is gpu or host (or something else later on - cxl?).
>
> While not really realted to the rest of the discussion I agree.
> It really is dmabuf integration now, so let's call it that?

My mental model is that the feature folks care about is the ability to
use TCP with device memory, and dmabuf is an implementation detail
that is the format that device memory is packaged in. Although not
likely given this discussion, in theory we could want to extend devmem
TCP to support p2pdma for nvme, or some other format if a new one
arises in device drivers. I also think it's more obvious to an end
user what 'devmem TCP' aims to do rather than 'dmabuf TCP' especially
if the user is not a kernel developer familiar with dmabuf.

--=20
Thanks,
Mina

