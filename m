Return-Path: <bpf+bounces-38896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194C96C212
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287491F21512
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976421E0088;
	Wed,  4 Sep 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtu6fplo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7A1DEFFE
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463109; cv=none; b=Fq6SQvMqslXN1x2/oCcZNeAlNhHGSlyVs9UIUA7lPVFznMJqxA9vIP9VEfZZPK1lLfyLyNxYtdAUcB+nDyyeEjueR3LjRRRL6AtyAFmjtp1BsEGi7HWRH9Ec/eQ56EeuHVJvhNrt8/b09Oj9YU4+hk6qyAUQ2utyoTq2ChDqHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463109; c=relaxed/simple;
	bh=sXtLgXQzVV2KYM3glPRuxYC/5hs3yMDkVUdSwXrs2JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDAOQuTUEnalesfSUpasTL2XnkzlnP5HbYmOgg+8cSUt4kExkYsbJQgiPTztuVcPRc3I1twGV0qtU9SiYOtMsVNgKT5edB1LorOGN02IVareDTzMBLiCP3XT/K1dhzp7DI9L/2DALj/Bp5PWIO5YP4XkLW8/YxXN9OBqXxfxvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtu6fplo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4567fe32141so262441cf.0
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725463105; x=1726067905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD/VB3T6PK6SWkzZ0xkGr8kbW+Sx4WeUFngHFhxmWFU=;
        b=jtu6fplo1EwDPApGNAcMv77ohhFeLh4VheMMrgCIQr/HxgXOCom31HIY9dHgl+Yags
         CX4ugkPSHfPKAMLaMnWetadC75u3xU243A39AynmHCr9PuGWtBi472Y7fuMnnaAiqbz0
         Aqm6Dqk5oEuVB1GxzWQhsDCmBMbelKhmuWkrhJeHLcFEb4hSfHZHRzA3ZZx2uq8BmbsV
         TQzYXA0O2cc1bI+hAGxAOlSss1ajW07jMykWMPtz92MDS128Mjf2J21DnhKtXaw6FH9s
         FyqrSgkqBYsc4yZ4XakxSQfhyj1Vafbv/2dtFeYTfR4tE9ki2wCOgkCUkrGU0CT3i7CI
         4vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463105; x=1726067905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD/VB3T6PK6SWkzZ0xkGr8kbW+Sx4WeUFngHFhxmWFU=;
        b=jncBEQ/OGwAcwPLx9GpVt2JDMIoSry4cKYHdNHPf2JXQZOGWm+w55sVb+bt19TWhXT
         feaikmKoLF3z23A6qlaDynOxRBcbdCGRtkMaDjlgg0dEFQNtc4LMHoou4lHaa5chO9Rj
         juKBBa0pT9TVNDbziRpmEBDc1puDa/QcGUulPt7ZqUbN7pHB2Ors9VeCh/ErJ9b14njM
         74UPUXAHzpMf+ytMP/JG1JW2zgJplV5flSUiFStTXfyKIFYTzhfpjQTUIA4CtroQo/w7
         /aKqTuzCkDvWvuiVJgtCy2YYu2a0WCkVL9UKCTdn3YVD88zclPT+8jm1Ds/4J2YiRwfk
         X6wA==
X-Forwarded-Encrypted: i=1; AJvYcCVaBMUp2oB15cu/i8brL4lwW9Y2T4Tu4Dz2LNURY6Gj+fHVaVBvMPdiLfZaQV9vfV0TiNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eu2Oglxw0IeErkKNfdLJruty9ryncixOQqWMUAxUpVbTdY2X
	HRocWnMWBxLbG1HK+h/M8QSKZ0qoAiWzlbUzUoTvoCC/u25xDTDPMS7fujnqJnFT8pE2ZH7A96p
	5vhRbj1zkEydogSC3T6G3i+K/S2ZCL1Id57zo
X-Google-Smtp-Source: AGHT+IFUx/o9LJkME5WyEg785HOWYMcUA5VsWIPNTEqlhEzpir/bmFgy1UHj7/XRd4GdWuFH4iylG23RG+gVAR1iVpU=
X-Received: by 2002:ac8:7d07:0:b0:456:7cc9:be15 with SMTP id
 d75a77b69052e-457f7b38578mr3074581cf.29.1725463104431; Wed, 04 Sep 2024
 08:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831004313.3713467-1-almasrymina@google.com>
 <20240831004313.3713467-9-almasrymina@google.com> <20240903144011.3e7135f9@kernel.org>
In-Reply-To: <20240903144011.3e7135f9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 4 Sep 2024 08:18:12 -0700
Message-ID: <CAHS8izPN8cDVhAzdedr7zb9zmDaiOMqkaDqB07QwVKKEJ62HzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v24 08/13] net: add support for skbs with
 unreadable frags
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

On Tue, Sep 3, 2024 at 2:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 31 Aug 2024 00:43:08 +0000 Mina Almasry wrote:
> >  static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
> >  {
> > -     return likely(!TCP_SKB_CB(skb)->eor);
> > +     return likely(!TCP_SKB_CB(skb)->eor && skb_frags_readable(skb));
>
> Do you remember why this is here?

Yeah, to be honest, when I first implemented some of these checks I
erred on the side of caution, and added checks around anything that
looked concerning, some of these unnecessary checks got removed, but
looks like this one didn't.

> Both for Rx and Tx what should matter
> is whether the "readability" matches, right? We can merge two unreadable
> messages.

Yes, you're right, only 'readability matches' should be the criteria
here. `tcp_skb_can_collapse` already checks readability is matching
correctly, so no issue there. The `tcp_skb_can_collapse_to` check
you're commenting on here looks unnecessary. I will remove it and run
that through some testing.

As an aside, it looks to me like that tcp_skb_can_collapse_to
callsites don't seem to be doing any collapsing. Unless I misread the
code. It looks like tcp_skb_can_collapse_to is used as an eor check. I
can rename the function to tcp_skb_is_eor() or something if that makes
sense (in a separate patch). I think the name of the function confused
me slightly and made me think I need to do a readability check.

--
Thanks,
Mina

