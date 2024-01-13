Return-Path: <bpf+bounces-19511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB982CEBB
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 22:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C68A28277A
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 21:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4FE107B3;
	Sat, 13 Jan 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nametag.social header.i=@nametag.social header.b="qWTpc7en"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF86AC2
	for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nametag.social
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nametag.social
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28bd9ca247so886659166b.1
        for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 13:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nametag.social; s=google; t=1705180520; x=1705785320; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URZdqk6bxkI4HY1eozL0R514YIl6D2P4INCZwtHeJWM=;
        b=qWTpc7encda6gDA2ongOKvywekE6jzilHmQL4e+ji8iIP1XpRgcXId0FjzgqqVO82H
         ZmlCRC1MG9uWjrgoXfGd+ZOuS56h0YKqKHmvVvo65hhszKgpI+EtersCbcE7WTDr5lDx
         ZcqsfDNhXOq96hh9TAlMqrW+sgF5cRJG1lRvUIQ063z3pdHBeiZhLh/4O1W2B9aLX77U
         cIybtKJK6OPLs8F+s7M3Xa8eOE2YVClH0px+dHnZ5d+7BYYAEWkINTL3xveAgmu9IvRI
         HvpMa6jTCZktOrfobwG6h/etPeA5oeZgRF2WAeVQ0jHSZJzSqB2Y8K+j5gnYjSvdbR3i
         gz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705180520; x=1705785320;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URZdqk6bxkI4HY1eozL0R514YIl6D2P4INCZwtHeJWM=;
        b=r+sayE2xxc1w2eVybQhjNLSfhlGBqXsIcF6PA9vZHA6swzZ1tMCmKo6h6nc7T8njOq
         c3Hka5yFxhayYcxiE+049etz+Gid6vrqVTYXVf1ByDjBOD7mlX0AiTuO2hJgR1YZqrw7
         vRk1qmVPDvYsj6gil2tohyMhikriiBeqoC8JPBcy5+7Sp4c9V6dvQ0QN4ImzmnjfQVKb
         5DfXpZOUhMa8eo+KIdf6Z1Yh5Wo35HFbyTr2A//F95RYjv3vYmoKKZouiPkYI7UC91We
         yJveXiFPlXPhrQRLMn2SZzJuuwoxmKrzz0bO0JVIR0Q7olmecGIkSPgaQJQkC780K//Q
         h/1A==
X-Gm-Message-State: AOJu0YzAereznYCpzzOPJLZVSYbDrEz/rAUy0ETVUqiLOOzF+5zAJFBU
	MeqZrsUN2XpqOJd+SdMgTqGuyBjyfQFBLWUxZoRwxCQ1cDBRFeRn2gl5nJRbWec=
X-Google-Smtp-Source: AGHT+IG7jqj9U7v8YxxmgiU4GbP+nJplF9vtv6ZEoePiX0ZFFyP8N6YlLwbLVO2WI3lUHQ32Cb9KFE0cCIB+DRd31Pk=
X-Received: by 2002:a17:906:b155:b0:a2d:402d:6b7 with SMTP id
 bt21-20020a170906b15500b00a2d402d06b7mr417761ejb.23.1705180519777; Sat, 13
 Jan 2024 13:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM1kxwj533vwyxNvCPgXK2p=CxVszOm4T4g0YzaFhWPGATS0RA@mail.gmail.com>
In-Reply-To: <CAM1kxwj533vwyxNvCPgXK2p=CxVszOm4T4g0YzaFhWPGATS0RA@mail.gmail.com>
From: Victor Stewart <v@nametag.social>
Date: Sat, 13 Jan 2024 16:15:08 -0500
Message-ID: <CAM1kxwi9FMUr3vOqZeRe3FjuvwQgdW-8g0HGLL5fU2tOOjRfYA@mail.gmail.com>
Subject: Re: [RFC bpf-next] crypto for unsleepable progs + new persistent bpf
 map for kernel api structs
To: bpf <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 2:31=E2=80=AFPM Victor Stewart <v@nametag.social> w=
rote:
>
> i was just brainstorming at Vadim off mailing list about my desire to do =
AES
> decryption of QUIC connection IDs in an XDP program, RE his pending
> bpf crypto api patch series:
>
> https://lore.kernel.org/bpf/20231202010604.1877561-1-vadfed@meta.com/
>
> i'm hoping to gather some thoughts on the below two roadblocks:
>
>
> (1) crypto for preemption disabled bpf programs
>
> as he mentioned in the comments of 1/3 and to me directly, a non sleepabl=
e
> bpf program is not allowed to allocate a crypto context.
>
> is it possible for this restriction to be lifted?
>
> if not what safeguards would be required to lift it?
>
> worst case maybe an API could be added for userspace to initialize the
> context, as userspace must provide the key anyway.
>
>
> (2) persisting a kernel api provided struct across program invocations

whoops sorry for my ignorance on point 2, i now see bpf_kptr_xchg
exists. lots to learn here!

so point 1 is the only roadblock?

>
> then comes the need to persist the crypto state across invocations. for
> ciphers that require key expansion, such as AES, this expensive operation
> obviously can't be recalculated for every new packet.
>
> but struct skcipher_alg does not provide any method to provide
> pre-expanded keys, only setkey, which for AES and others implicitly
> generates the expanded keys. and adding another function to provide them
> is definitely the wrong design, as even regenerating the context on
> every invocation would wastefully cost cycles and allocation.
>
> and i'm sure as the bpf's kernel API surface area grows, there will be mo=
re
> kernel functionality exposed to bpf programs that necessitate struct
> persistence.
>
> so what i propose is:
>
> 2a) a new bpf map type that allows programs to store kernel
> api structs (containing pointers, etc) and inaccessible from userspace
>
> 2b) a way for a bpf program to inc/dec the ref count of kernel structs
> provided to it through APIs. programs would then be free to store these i=
n
> maps. and even if they leak the pointers, doesn't matter because everythi=
ng
> would be destroyed once the program is detached.

