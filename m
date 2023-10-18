Return-Path: <bpf+bounces-12614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B67CEB5D
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CC4281DD8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 22:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6539857;
	Wed, 18 Oct 2023 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C93TGwMX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B33984A
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 22:35:03 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE392113
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:35:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1186668066b.1
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697668500; x=1698273300; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=khKRonpg4rDfEJUqAEvq7mmy9HnYLn0RJ96ntz8nHr8=;
        b=C93TGwMX6ussVMbpFapEU0I8edzaL6dAR+6JI1/oJif/Uut5ZxpLycDYUe+IJTmduh
         zFUg5PXdUFrW/BPTBHUkTSO0v6JQ6jb5NTuFl8kj8X+gD2CH9CxI3KBPRi8SZrhHXwqE
         og/TbFUJbG13YrWkwZbIMMCrzb09ww4Ta5SiPlbQZ+o4Ve6U6x6+HOOieRlBN8P3A44m
         bXesGxRjonkcGUoaSe1ONKXTVkyh1ruZ92UtY8K2BF/SFrtzLlFirDZP2Xtb37v4eAsC
         gsr9k4Wh+MUGkHhSbvENF0sMIwCU0DUThmYFFTWZiWDDdscT2lo2HelR1VkMDYaIxAxo
         Lx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668500; x=1698273300;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khKRonpg4rDfEJUqAEvq7mmy9HnYLn0RJ96ntz8nHr8=;
        b=wf6MomfxmNwnISo2XlsrECLwhqdWgD1CUQ2d87IuYAHQ9nsfzOwxJQmijGCXyVV5X0
         TtAA6z37MaujYkiDcqjchLaFIqzNGvFGoRgVPKV0zN+FejQBd4mxufuS+s/+W8Bf8OfY
         b5ZZyxDdaJbaI4M6wkoCtr59w3mjq8+A5OxRoN70EtZu3CmneUQdhJJ62xky7JOPNjMb
         0W9eb66/Zn9mCCUwYhuxqqC1VWXypIj8F+Tk4HhL2mtg9y4DX+eCeJfV7QNMQLSKy4TR
         V6OpnjQ2jRB4H8ssr+S52Atj/BwoCZE6HUFWxGQ+mwUXNCLS7+c5K066cruycolCHsZk
         b+0Q==
X-Gm-Message-State: AOJu0Yx3cktplD9n1ea+ZyDZ9fJLXWXxKLpvOILUaCdeUNZ26CGQspAe
	/ingCHN4iakJyFgGbBWQAi8=
X-Google-Smtp-Source: AGHT+IGZIZfADzr1LtS6MJEPaJ43JB1uknRK7RQNw/P9w0ZOTVaANnp/Sj58Ct5jv+/Wkc21qMM8xA==
X-Received: by 2002:a17:907:9411:b0:9be:3c8e:1506 with SMTP id dk17-20020a170907941100b009be3c8e1506mr397679ejc.70.1697668500017;
        Wed, 18 Oct 2023 15:35:00 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090619c800b00993664a9987sm2426827ejd.103.2023.10.18.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:34:59 -0700 (PDT)
Message-ID: <d1a0907588e9d809aebba260377b6188897bd383.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Define signed modulo as using
 truncated division
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
Date: Thu, 19 Oct 2023 01:34:58 +0300
In-Reply-To: <20231017203020.1500-1-dthaler1968@googlemail.com>
References: <20231017203020.1500-1-dthaler1968@googlemail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-17 at 20:30 +0000, Dave Thaler wrote:
> From: Dave Thaler <dthaler@microsoft.com>
>=20
> There's different mathematical definitions (truncated, floored,
> rounded, etc.) and different languages have chosen different
> definitions [0][1].  E.g., languages/libraries that follow Knuth
> use a different mathematical definition than C uses.  This
> patch specifies which definition BPF uses, as verified by
> Eduard [2] and others.
>=20
> [0]: https://en.wikipedia.org/wiki/Modulo#Variants_of_the_definition
> [1]: https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
> [2]: https://lore.kernel.org/bpf/57e6fefadaf3b2995bb259fa8e711c7220ce5290=
.camel@gmail.com/
>=20
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index c5d53a6e8c7..245b6defc29 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -283,6 +283,14 @@ For signed operations (``BPF_SDIV`` and ``BPF_SMOD``=
), for ``BPF_ALU``,
>  is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
>  interpreted as a 64-bit signed value.
> =20
> +Note that there are varying definitions of the signed modulo operation
> +when the dividend or divisor are negative, where implementations often
> +vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
> +etc. This specification requires that signed modulo use truncated divisi=
on
> +(where -13 % 3 =3D=3D -1) as implemented in C, Go, etc.:
> +
> +   a % n =3D a - n * trunc(a / n)
> +
>  The ``BPF_MOVSX`` instruction does a move operation with sign extension.
>  ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-b=
it operands into 32
>  bit operands, and zeroes the remaining upper 32 bits.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

