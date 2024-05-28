Return-Path: <bpf+bounces-30797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D58D2829
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91281F26B7F
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384613E055;
	Tue, 28 May 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmss24gC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0F13E042
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936103; cv=none; b=BQStR0qjGcAwGa9ZHnQnGq5KwSKVKLWcSWMzMerWuWbTFFSLJnI6V22BfPid0xa7k0euyHTHPk3wffsxlRVpBS/P0thncDKmUsu+blSiL4zm6YNaam0uoZWN60DhdmS+8yQVgnbody8pFo7zxT5dtsax9N6yGUJL11RiB/1XdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936103; c=relaxed/simple;
	bh=Pmt5zXjXcZqbMtdEgpo6mZ3A3/TNyfA5e0PEKfg1juw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igI528wC11lgwbuXtUOCWbufwtDeHhuikvbK5K3Nte9SKCjL9er1P6XJa/S4IaeAwPpRYj8+qMm6AufM1loBulR3KhzwYJQkOpDDOychZRcLbMHA/m1CFsNYpTsu23ttPgSzMURqW29yL2Hre/9XVJDbAKozKk227kQvPpEWJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmss24gC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so1180176b3a.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716936102; x=1717540902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Poo/kJCEBiIHgm7VqOQJDpUKGC2jOJgvLVj4eMGEm4=;
        b=nmss24gCn2aV9oEtn45j7yn0Dlk+7zil1eHkkqxY4IIQPElfRzCxDxG8lj1cnAmQiz
         XWRJq1NIwKkTbVJlDiV4XwNfyN+iQh7fNoETZV80Y4UTj7yqQEEUBMJGH5W+Yp+KEfSj
         s49LUqC4BadqVhVrMhhlrpfJpbtSSHKFxkldHWhSaqpgC303hSbXwaTGvnw0p27t8i+Q
         7QmmVRFokDVLnwwK3DYeIcE4wDZUq9hZIizIlJ0ykBe15PlSTtBX0YdwsCxFoQTPIDOE
         fCMoGDiZciKNSF/rZNtWPEapVWLnTCUvh5L8wDPK/yU7m/FrkrHhZGP+qjxoSgADw/8e
         kToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716936102; x=1717540902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Poo/kJCEBiIHgm7VqOQJDpUKGC2jOJgvLVj4eMGEm4=;
        b=SzIoHcEskLOdCGObqhhNlZcgaXh8rMSl26t5dqQLDjKtmbdO2sy9IlsRJ2+u2Vvy8l
         SkDZ8VCWs4OeNwqRvLi5X5jFgEHD/XMuStkV9h+civmB/Red3TLqUuZCzE8cre8u8WEt
         cVQZJK0eOfuHvlAR183095ykb+nUI1hraksvsUAd/X1cizy9CHPjVT2V+UJA64EVFycM
         eb0OffX3gKlNxWklDK4bj8oqrbxDfQNJEwcwoWmTEzDkGt0HOLjmQXssmUCTZbj6Tq93
         FC+0WoOx+EaoUgqVw9pl9K0+DhRz6YrG2R1Y0WvhqY/9qx8BO4nF8M8k+35dMXO0kvQy
         A6ZQ==
X-Gm-Message-State: AOJu0Ywo8siVMtZH+m4AVUWKi1AfKML6JJ+tIyGZg0neO3CLSRfG1/fL
	fiRIsy6lwwLeEgwSPrcNjsVtBieZZZXB+XFv4vY7yL110wHYXHv9
X-Google-Smtp-Source: AGHT+IGJ8SjiiW34k7OVAAtoChxoStNifNx16TmHXNkFaOIIR6Y70k4BF9IqJ2TOWl/PlCZ0pFjdAQ==
X-Received: by 2002:a05:6a00:8013:b0:6f3:f5e8:31f7 with SMTP id d2e1a72fcca58-6f8f2c71745mr13962897b3a.7.1716936101714;
        Tue, 28 May 2024 15:41:41 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd2d909asm7125887b3a.178.2024.05.28.15.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:41:40 -0700 (PDT)
Message-ID: <0aa2c967191a5abdd31fc3dd0a0ba022a08ecdb6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: put forward declarations to
 btf_dump->emit_queue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, alan.maguire@oracle.com
Date: Tue, 28 May 2024 15:41:40 -0700
In-Reply-To: <CAEf4BzZYauwNDch47x2aUsTL1MK-_Y6fqdazk1rttHyU2E2psg@mail.gmail.com>
References: <20240517190555.4032078-1-eddyz87@gmail.com>
	 <20240517190555.4032078-2-eddyz87@gmail.com>
	 <CAEf4BzbZVteBuTMGUowBjQqF2iR8FqQBxZ3_oBtLB4+nhAGYSw@mail.gmail.com>
	 <9574c1e856c20eb98085ceb0071033169ec360ec.camel@gmail.com>
	 <CAEf4BzZYauwNDch47x2aUsTL1MK-_Y6fqdazk1rttHyU2E2psg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 15:39 -0700, Andrii Nakryiko wrote:


[...]

> I meant something less heavy-handed:
>=20
> static const char *btf_dump_missing_alias(struct btf_dump *d, __u32 id)
> {
>         const char *name =3D btf_dump_type_name(d, id);
>         int i;
>=20
>         for (i =3D 0; i < ARRAY_SIZE(missing_base_types); i++) {
>                 if (strcmp(name, missing_base_types[i][0]) =3D=3D 0)
>                         return missing_base_types[i][1];
>         }
>         return NULL;
> }
>=20
> And we actually don't need to use btf_dump_type_name(), btf_name_of()
> should be more than adequate for this.
>=20
> Then if you get NULL from this function, there is no aliasing
> required. If you got non-NULL, you have the name you should alias to
> (btf_name_of() will give you original name).

This should do it, thank you.


