Return-Path: <bpf+bounces-13996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DFB7DF91E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3577281CA3
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D3208D2;
	Thu,  2 Nov 2023 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/fNRAxw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF0208A4;
	Thu,  2 Nov 2023 17:47:26 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B82B137;
	Thu,  2 Nov 2023 10:47:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d2c54482fbso199383866b.2;
        Thu, 02 Nov 2023 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698947241; x=1699552041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LZVQdmd+E8mUtJWBLZRWGzqUC4FZBj+7S3JJxwc7EY=;
        b=B/fNRAxwjHjApPsPjHqM9Gb4EGHfr6yz4yD75i2IH64fiXsTvOCKy14zKJMQ8zoYFe
         rtkiQiTFaT0pyaW80JlsSWd5lWeQGbxZN0pP6gHq80AiveLvqZZv0szWOjCGH91HWGxW
         oAfDB5n3WHZZsiIuuvQ1z8WO8JsAB5g67yZEUx+zVCXWRnOFK1NprvdNAupKFPzhhGGk
         EW3IBVTxVj/+eKU3ilIkij3aUvtssHTI8+A1DVBiQwL+UGovirAOTVNRHf6WTO0Oq9ik
         4t4yecapsyn4+2ncWM0vrdxvKD/Xj4o6143XroD62PdI8gXh428apHfViJWC01gC45OH
         8O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947241; x=1699552041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LZVQdmd+E8mUtJWBLZRWGzqUC4FZBj+7S3JJxwc7EY=;
        b=HetJz9/TRKdByt3MiKcwttj4huKhOqlkCusfvrGqIVb6JqOg9NcDG++gkR9VfSwSor
         QeZ7OPXI1zhWXGBe9Eu+ywUvScx0kwy8q6pf0DqebAc5XxzATqXtPBZQBHvIYcxFAAr2
         VrvHtAMzcACpxiKv+pjbHTTlGDiQA0xZ+C9HR9eyFN2oyQP6TtX7iXMq1BxH+zKwsZL5
         xM+jLT97jox2kYW+A2SNE4RbCV9gTI7CmHLLlMD9Uo/C1LWOZ2NyL2sWYzOPMc2v3nO9
         qwu/T7SJ4faUaSjThCaLak9Ff5RHmbQzs+oEcUwqI5UNtogjzv1KZSH7sGoaWxaKJ2mr
         v84w==
X-Gm-Message-State: AOJu0YxkqcfOr0dK0Ex6EuBAJVrzqNrjZSNUCHteySt5nj6HHDHhftSl
	FFr+9XImQwGaWErSr8LENlmWYjsNWe/trcMNkN8=
X-Google-Smtp-Source: AGHT+IEqunsdVFO/zR+l4k+OY5SPbC2+r41lSgaeXTaeLzAUAHVWSFxDpOZN1gkb3gyrg7M8zYWMhAs/ewfgBaArRoI=
X-Received: by 2002:a17:907:1c17:b0:9be:fc60:32d9 with SMTP id
 nc23-20020a1709071c1700b009befc6032d9mr4697800ejc.47.1698947240709; Thu, 02
 Nov 2023 10:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031134900.1432945-1-vadfed@meta.com> <dac97b74-5ff1-172b-9cd5-4cdcf07386ec@linux.dev>
 <91a6d5a7-7b18-48a2-9a74-7c00509467f8@linux.dev> <6947046d-27e3-90ee-3419-0b480af0abb0@linux.dev>
 <4258aabd-5f7b-4b7f-ab43-408b69bfdc58@linux.dev> <CAADnVQ+9pp33zv9DxouEmg24o7w27OKFUcvKChHuby_+d6-bLg@mail.gmail.com>
 <c4e6296d-f273-4b27-a33a-eee5c8f54aab@linux.dev>
In-Reply-To: <c4e6296d-f273-4b27-a33a-eee5c8f54aab@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 10:47:08 -0700
Message-ID: <CAEf4BzYrjPhvKpfhLAtZ9T-7yqpZin57VhPumtXextSmnwDV=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP programs
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Vadim Fedorenko <vadfed@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:14=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 02/11/2023 15:36, Alexei Starovoitov wrote:
> > On Thu, Nov 2, 2023 at 6:44=E2=80=AFAM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 01/11/2023 23:41, Martin KaFai Lau wrote:
> >>> On 11/1/23 3:50=E2=80=AFPM, Vadim Fedorenko wrote:
> >>>>>> +static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *=
ptr)
> >>>>>> +{
> >>>>>> +    enum bpf_dynptr_type type;
> >>>>>> +
> >>>>>> +    if (!ptr->data)
> >>>>>> +        return NULL;
> >>>>>> +
> >>>>>> +    type =3D bpf_dynptr_get_type(ptr);
> >>>>>> +
> >>>>>> +    switch (type) {
> >>>>>> +    case BPF_DYNPTR_TYPE_LOCAL:
> >>>>>> +    case BPF_DYNPTR_TYPE_RINGBUF:
> >>>>>> +        return ptr->data + ptr->offset;
> >>>>>> +    case BPF_DYNPTR_TYPE_SKB:
> >>>>>> +        return skb_pointer_if_linear(ptr->data, ptr->offset,
> >>>>>> __bpf_dynptr_size(ptr));
> >>>>>> +    case BPF_DYNPTR_TYPE_XDP:
> >>>>>> +    {
> >>>>>> +        void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offset,
> >>>>>> __bpf_dynptr_size(ptr));
> >>>>>
> >>>>> I suspect what it is doing here (for skb and xdp in particular) is
> >>>>> very similar to bpf_dynptr_slice. Please check if
> >>>>> bpf_dynptr_slice(ptr, 0, NULL, sz) will work.
> >>>>>
> >>>>
> >>>> Well, yes, it's simplified version of bpf_dynptr_slice. The problem =
is
> >>>> that bpf_dynptr_slice bpf_kfunc which cannot be used in another
> >>>> bpf_kfunc. Should I refactor the code to use it in both places? Like
> >>>
> >>> Sorry, scrolled too fast in my earlier reply :(
> >>>
> >>> I am not aware of this limitation. What error does it have?
> >>> The bpf_dynptr_slice_rdwr kfunc() is also calling the bpf_dynptr_slic=
e()
> >>> kfunc.
> >>>
> >>>> create __bpf_dynptr_slice() which will be internal part of bpf_kfunc=
?
> >>
> >> Apparently Song has a patch to expose these bpf_dynptr_slice* function=
s
> >> ton in-kernel users.
> >>
> >> https://lore.kernel.org/bpf/20231024235551.2769174-2-song@kernel.org/
> >>
> >> Should I wait for it to be merged before sending next version?
> >
> > If you need something from another developer it's best to ask them
> > explicitly :)
> > In this case Song can respin with just that change that you need.
>
> Got it. I actually need 2 different changes from the same patchset, I'll
> ping Song in the appropriate thread, thanks!
>

Please also check my ramblings in [0]

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231024235551.2=
769174-2-song@kernel.org/

