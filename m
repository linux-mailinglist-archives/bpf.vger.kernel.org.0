Return-Path: <bpf+bounces-16452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6AD801385
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8861C2102E
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815C74F1F9;
	Fri,  1 Dec 2023 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni1AdsdO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE9F2
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 11:20:39 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1882023bbfso318813166b.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 11:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701458438; x=1702063238; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXzPa+1qctYhzbI+FJQnLY7m5d5hXT5+gnhi9QMMFuw=;
        b=ni1AdsdOuBcKyKyyqC0zX54HW2x2Qg23Rc8BFcrLs9Rl1bK7MsG/+JXa4EQbwvX9P5
         ReSBsxGsIXwjSdHsZa6hujtsxHBOptyX8449trDXP9ndKdyCwIn0epnC/4un8IOV/Xqc
         vXFtgc5/f6EMv54zxPF+Km5COtZiGHuI0T+kjqULrmBtJP4kw1OTaxjCOQoS5oe6E9Ab
         6zYYmHT6VxvlmNaWq4NB0xGCqURhLkOU8NTWI/9oYgb+kbr3G50yq4cJX5upM6aSWx12
         YhYSZrvklTp2km3kHFeaMTRN+6fqfkJ917Qc0EQEa67ahcJMW77nHzYA6LEC3vnZ+z3u
         /cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701458438; x=1702063238;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXzPa+1qctYhzbI+FJQnLY7m5d5hXT5+gnhi9QMMFuw=;
        b=FxG/frQUQhuLy+W/zZJhyil5LvI8iJ38N4NYkT6D61d6xScrN5uSNoaXqFw7cRGkqi
         OWQYencXhyA7DY4ELMReHhMCafTITPj4/baV6VOwF/xkuwvEcgOjcm5c2Q1TaL4vJMoh
         BnKaX1torUz+n24fmH0Sy1l8XB/EDzqNae6gonKJ/mto3S2YRaIGSv74Y1IYiGF1ZsxK
         I2RPPK7KOJr51aeR4u9GGkx41icnH3dy8wJNBBoJbdtFpFR/7OXzVyttYADkNoKMSwGA
         4JF9Z2YhlKqx3Pt9+xzfEEO0nE2/X0kzrnn8ssovNedi0RonjRFaXQoUt0O04x20J2jO
         lFPA==
X-Gm-Message-State: AOJu0Yx23nLW2sXanxMr3qb/kJ2lGX56UhBxIJSA3A1mLcJ35VKwyjcx
	IGQ7t4/qIUaVaDiytxVGQvcOsA+xODgSlw==
X-Google-Smtp-Source: AGHT+IGPZdRJzXcrWdc7Mgtq+4zwp2t/qB9DZ4oHy4Tn0Nb11pxSQmaUEWN74qdzXKmFTziV62sx9A==
X-Received: by 2002:a17:906:748d:b0:a19:a19b:55c0 with SMTP id e13-20020a170906748d00b00a19a19b55c0mr1107743ejl.80.1701458437842;
        Fri, 01 Dec 2023 11:20:37 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id mj9-20020a170906af8900b00a1907e36244sm1837199ejb.118.2023.12.01.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:20:37 -0800 (PST)
Message-ID: <583eb34882904c94f74a737650c20ac2d2fe18fa.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: validate eliminated global
 subprog is not freplaceable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Fri, 01 Dec 2023 21:20:31 +0200
In-Reply-To: <CAEf4BzYgdX4m15fV9Xujk8RRDbwNH5zWuV6Wb+k2+NXigJ5nNA@mail.gmail.com>
References: <20231201013006.910349-1-andrii@kernel.org>
	 <68fc1915f6d0fec5d4503052dfabe0f0f9fb6d91.camel@gmail.com>
	 <CAEf4BzYgdX4m15fV9Xujk8RRDbwNH5zWuV6Wb+k2+NXigJ5nNA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 11:17 -0800, Andrii Nakryiko wrote:
[...]
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Oops, didn't see your reply before sending v2. But there will be v3 anywa=
y :)

np

[...]
> > Nit: the log is not printed if verbose tests execution is requested.
>=20
> I'm not sure I understand. What do you expect to happen that's not
> happening in verbose mode?

I tried running this test -vvv and it did not print verification log
(admittedly this is the case with many tests in prog_tests/*.c).

[...]

> > Nit/question:
> >   Why change prototype from (void) to (int) here and elsewhere?
> >   Does not seem necessary for test logic.
>=20
> I had some troubles attaching freplace initially, but my freplace
> skills were rusty :) I can try undoing this and leaving it as is.

No strong opinion, just curious.

