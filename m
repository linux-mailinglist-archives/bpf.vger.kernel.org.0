Return-Path: <bpf+bounces-14527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6BC7E6056
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE90281464
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 22:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A01374F5;
	Wed,  8 Nov 2023 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENgOWxOa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25A1CFBB
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 22:09:02 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F1258A
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 14:09:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d2e6c8b542so38828766b.0
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699481340; x=1700086140; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsYZBCjRP4q9+Sm808ZM7YmZwPSB78BrChroNwQnwPc=;
        b=ENgOWxOaNx5J5nr+4QckCACcvkun6LRD2DeSOLTWXnzDRC0fTqpoujBR3f6iorqaut
         1RhQgtpImhjSSw/xxrSyVzBFU7GCdrV3J+QfFoAQHAERwEnUjJZHUAeHEglhcuUMbN41
         WyXMLcjyU/BkyxA1Rop2g4LrB55hvrfXi/YTQpxwOR/GxyCe2TmPVaCz/utl0N1MrsRt
         dCGOBiOqMe+F3o1SyPY/5RdPnAeIE6crUd7VvWZRP5UHdQRBRYcXQANvC6RSBodBUp5X
         J7a36HwOrGT2hWMiHb5xFX/mOS9s6K6/ZV9J2v/dyglsZgVO7BS+g5jGgrEd2WVD+l4E
         xRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699481340; x=1700086140;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsYZBCjRP4q9+Sm808ZM7YmZwPSB78BrChroNwQnwPc=;
        b=W4EAojwGriC39f2zVaha8iidytwaRdzWK0xZgNQ8JjoNdBdJhibd8Vr2GtXsvhi7Ee
         aA/W3n6kJ0km2LyYoTx0sXS4bUsskDeZXiTyCfAZ1sTfbgl/IMuYh83IYhndR08ohBD1
         ICrpS9Aqk4zn56gp06KRw4r4E+Tn7THMXxRRUqd3zawoLuvTQ+9B5GmJCCEhKzsaY71W
         za7LVLpUy58b7TqxYqztDAW8mihIXCrlJpxtwCh3AdC+mD0/5aqi+CNHeEjTAfegvZzZ
         8+4EAkkNkWW+IShYtCJUZFFcVjlxy8kESwIO2zUg70o9PgvvsCkVhy3YkSCoQfY16sfx
         /9ug==
X-Gm-Message-State: AOJu0YxPUVuYAaUcJYrccXaiBJGsXS1kf9L9bCRuOVktHO5sFRxXU6dG
	z7uBPc99ohwpTAvMmSMtoIM=
X-Google-Smtp-Source: AGHT+IHK1e09ssW7ZpS6AxvKCi/ZnN1nZPM1QNaqFblHKsr3nddpHv5wIIp2ekh49kCdbuzS4Arn+Q==
X-Received: by 2002:a17:907:7ea8:b0:9a1:aea2:d18d with SMTP id qb40-20020a1709077ea800b009a1aea2d18dmr2917184ejc.48.1699481340167;
        Wed, 08 Nov 2023 14:09:00 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lf28-20020a170907175c00b0099bc2d1429csm1664539ejc.72.2023.11.08.14.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:08:59 -0800 (PST)
Message-ID: <e89051a718d676f6f73d354774c2161dfe562faf.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/23] selftests/bpf: BPF register range
 bounds tester
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 09 Nov 2023 00:08:58 +0200
In-Reply-To: <20231027181346.4019398-11-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-11-andrii@kernel.org>
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

> On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:

I read through whole program and it seems to be a good specimen of an
idiomatic C program. Aside from two nitpicks below I can't really complain
about the code.

On the other hand, I'm a bit at odds with the core idea.
The algorithm for ranges computation repeats the one used in kernel
(arguably in a bit more elegant way). So, effectively we check if two
implementations of the same algorithm end up with the same answers.

It is a maintenance burden in a way.
What are the benefits of such approach?=20
Simpler userspace prototyping for new range tracking features?

[...]

> +__printf(2, 3)
> +static inline void snappendf(struct strbuf *s, const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	s->pos +=3D vsnprintf(s->buf + s->pos, s->buf_sz - s->pos, fmt, args);
> +	va_end(args);
> +}

The manpage for vsnprintf says the following about it's return value:

  ... If the output was truncated due to this limit, then the return
  value is the number of characters (excluding the terminating null
  byte) which would have been written to the final string if enough
  space had been available ...

Which is definitely a footgun to say the least. So, I picked strbuf,
DEFINE_STRBUF, snappendf definitions to a separate file and tried the
following [0]:

    $ cat test.c
    ...
    int main(int argc, char *argv)
    {
      DEFINE_STRBUF(buf, 2);
      snappendf(buf, "kinda long string...");
      printf("buf->pos=3D%d\n", buf->pos);
      snappendf(buf, "will this overflow buf?");
    }

    $ gcc -O0 -g test.c && valgrind -q ./a.out
    buf->pos=3D20
    =3D=3D27408=3D=3D Jump to the invalid address stated on the next line
    =3D=3D27408=3D=3D    at 0x6C667265766F2073: ???
    =3D=3D27408=3D=3D    by 0x66756220776E: ???
    =3D=3D27408=3D=3D    by 0x401244: snappendf (test.c:24)
    =3D=3D27408=3D=3D    by 0x10040003F: ???
    =3D=3D27408=3D=3D    by 0x1FFEFFF837: ???
    =3D=3D27408=3D=3D    by 0x1FFEFFF837: ???
    =3D=3D27408=3D=3D    by 0x3C9D8E3B01CC2FB5: ???
    =3D=3D27408=3D=3D  Address 0x6c667265766f2073 is not stack'd, malloc'd =
or (recently) free'd
    ...

[0] https://gist.github.com/eddyz87/251e5f0f676a0f954d4f604c83b4922d

[...]

> +#define str_has_pfx(str, pfx) \
> +	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen=
(pfx)) =3D=3D 0)

Nitpick: both gcc and clang optimize away strlen("foobar"),
         __builtin_constant_p check is not necessary.

[...]

