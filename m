Return-Path: <bpf+bounces-38347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A06963A00
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 07:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255452858B3
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 05:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C9148FF0;
	Thu, 29 Aug 2024 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBgmNRrP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D04D8C8;
	Thu, 29 Aug 2024 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910326; cv=none; b=oPkobF8okl2K0NqLP6yDE5lKVQLs2/EQHZPYABwkLPHDhIY2+MMpTaEz56WIApg3D4pbXCDHIF0DxQyZ+UOxGOb0i8HRu8NDQPA3knQgbvMZgQKbRbn0hoGPLAHDwjFU0/3c+0LUH3oo3VbbnyTpRXNUxtA1LD7+h5u2sSxReXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910326; c=relaxed/simple;
	bh=niPsbo8FagnABTd0ex4iS3PoQ4LHrM2/TG3FQ1R7abk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txaWIr2g56ZJ435v2brVUItCXEUQSEjqrjCoJRpiBggIq/1/AJJOttgGUF9P+xc/g6R+5y+JBS7cH+0YCMJuc+jU8AT+BhPh9wNYqJpxq+K+syUhgcP/AhuZ6iXlspCOjV5ic0IQ1tNtUw3aWb7VOCyAYgMaYM7X0R9vTJWw5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBgmNRrP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7bcf8077742so184658a12.0;
        Wed, 28 Aug 2024 22:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724910324; x=1725515124; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PG7vUrjczTjDpkZnaTU3bwsLk/EQ0vq8liBHN/oleaE=;
        b=aBgmNRrP5ZStXqq+R9cACG//9OYUPHWLixUQ2FsLMtxM6YNJNBoPrJ5jbhmAlrmKOm
         sLmqzyUoLykL4xi1EgAf1SaW+SRNljRh8f7TsptCMOJ4OHUtqhjamSAj/lZQMNI6VND2
         To6YCkRNxcIWRjoWEAB2zD0UnDQDkxWWtlmvOMXVcUYf6+utROcPiWlvn7nG7IZ4BKy3
         2dXYVnbkIrzWCu8uwko5PeTRS+n/fQEY5O51xWKw7BetR60NyJ6GktHN46uMeb1hCzHd
         QN0gu8yLQVVUFpLCs4RtXxrL8byWlYbZI0zlUz+1gjhIG+qHV2/3einq0MIjRTrK7YVa
         I84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724910324; x=1725515124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PG7vUrjczTjDpkZnaTU3bwsLk/EQ0vq8liBHN/oleaE=;
        b=qzdQSwLZS0tTZqxtqwON+v9mFVfUTKMna4Y1xErqFu5wIQdMr+4px9IHInYFHX2dxE
         WHjdZ3tlDdtNZb8dwtzBlSYq/vkiC+to5+NGKM6F1bqZvC7pMkdCdcS52ULSpJDDCoaz
         gmTONRC4cOxwRqnqPStVWI4M7SKhbwXdMaYQxsM+foBy5pgoaXQNPvOM5q69JmWG3K5X
         8ma+0qEX3r6J728R5LwvPhRFBAZzXQbxBHFv8JD6aJtkekjJTDGsOfq33VHQGld2x2uk
         Oa18mbb2dUnRDIv8JUOa7yBAPCl3PNVzSUgAWYtHYNQf00YKAGx8NAwBkUvr0KW7OaK9
         TotQ==
X-Forwarded-Encrypted: i=1; AJvYcCV88H5tA/hH0DD1fzNsvd+PFEsWA3AE9Ru31Ibrb0eEsl60r14uqP4wD0TGZROxvsEfaNE=@vger.kernel.org, AJvYcCX4sMaw1WsMSZdk+67597v+tn6eh7sDbPrCOMR8VIHqZTYYimKbrRcyyXMc7u4NJO9VTjsfdJfK/U211OcA@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfpjRw1xBomsyevTe5yL4D3DqebvH4i5iJhrjIgShwCXNjlUk
	Bb2QwhRX3G6RZNlzGqbZWyQOIjL6/eycrUMcVusEZ8E9/axg3dvON8VYo+Q6
X-Google-Smtp-Source: AGHT+IFRhJ/jJGZgSwALOLE4RIOGZVAVMdKqAUQuGpcwiU0TTI2cOHaHrPBCidQDiWUz0TG1tH2w+A==
X-Received: by 2002:a05:6a21:2d05:b0:1cc:e659:7ffe with SMTP id adf61e73a8af0-1cce659819emr354168637.14.1724910323765;
        Wed, 28 Aug 2024 22:45:23 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445e9a51sm3003665a91.21.2024.08.28.22.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 22:45:23 -0700 (PDT)
Message-ID: <d1ca563d8f2f5b63e7b0ec8b91c57914c32f1679.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: add check for invalid name in
 btf_name_valid_section()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>, alexei.starovoitov@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org,  linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me,  song@kernel.org,
 yonghong.song@linux.dev
Date: Wed, 28 Aug 2024 22:45:18 -0700
In-Reply-To: <20240829034552.262214-1-aha310510@gmail.com>
References: 
	<CAADnVQKsZ9zboc4k0mnrwcUv6ioSQ6aBXXC+t+-233n17Vdw-A@mail.gmail.com>
	 <20240829034552.262214-1-aha310510@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 12:45 +0900, Jeongjun Park wrote:
> Alexei Starovoitov wrote:
> >=20
> > On Fri, Aug 23, 2024 at 3:43=E2=80=AFAM Jeongjun Park <aha310510@gmail.=
com> wrote:
> > >=20
> > > If the length of the name string is 1 and the value of name[0] is NUL=
L
> > > byte, an OOB vulnerability occurs in btf_name_valid_section() and the
> > > return value is true, so the invalid name passes the check.
> > >=20
> > > To solve this, you need to check if the first position is NULL byte.
> > >=20
> > > Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATA=
SEC names")
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > >  kernel/bpf/btf.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 520f49f422fe..5c24ea1a65a4 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -823,6 +823,9 @@ static bool btf_name_valid_section(const struct b=
tf *btf, u32 offset)
> > >         const char *src =3D btf_str_by_offset(btf, offset);
> > >         const char *src_limit;
> > >=20
> > > +       if (!*src)
> > > +               return false;
> > > +
> >=20
> > We've talked about it. Quote:
> > "Pls add a selftest that demonstrates the issue
> > and produce a patch to fix just that."
> >=20
> > length =3D=3D 1 and name[0] =3D 0 is a hypothesis.
> > Demonstrate that such a scenario is possible then this patch will be
> > worth applying.
> >=20
> > pw-bot: cr
>=20
> Sorry for the omission, I still don't know how to write selftest.
>=20
> But I can give you the C repro and KASAN log that trigger this=C2=A0vulne=
rability.=20
> I would appreciate it if you could look at it and=C2=A0make a judgment.

I will prepare a test case.
Probably tomorrow.

