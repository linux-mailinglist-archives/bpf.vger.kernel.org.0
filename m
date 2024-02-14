Return-Path: <bpf+bounces-22019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD98550A8
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FE8285CCD
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7886644;
	Wed, 14 Feb 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXBZsfLU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E257E0EA
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932744; cv=none; b=dTJPYSQiRDFh62+WwP3FWucl+hh0c+Fi+ww3xNB0X+ydbW+YE4kKm0iixPTqei5kjc6++8itEfWrxrEU1KoyWcGexYARTlHr3PNkRQMY8xdf/WjQlj4ylhy+X1jZm0WVEzaNdsQvB8LyRFPKvZavXMzKlMMQTbLMkT465oKtHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932744; c=relaxed/simple;
	bh=HuIwypD3BIoofjF/KS9EUSyJ95IJhGJWVaPQkqwp9mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsJfThkQTJaholvuZuLQ0794e9Dq5XrCT3Ils4SsX4jCLjMp5aYAEs9l2i8L/O2qnvn/9KlskxuYgi989ab8/hqu3PxSzYXNAXzShlxKUJSYAb6IehNG8+4ZlFEIsQGkut2ElPPq7KMPLm7i6nTS4id1PG7ZEc3a5DkOff+GyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXBZsfLU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so3700988f8f.0
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707932741; x=1708537541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRnImQ9uQNGNma8u5QxFrBkc6zo/zvivQCNl6ZYCdKg=;
        b=kXBZsfLU+MMtOvq3j6JXWJhGDGnV3u+qBeo4kzZVX9pI4Nfz8ZSptZ0I1+5+WTwS0L
         pQTnND1NmAr5a3IPiLgwI2OKUg08zizRTCXNEO1C3OauKoTXovGVgxALfmD07g5S0qDN
         TskqxScWw3x3JSvGydMLe/OWzk4vOvBPw3C1Umj+cTCek6FAnUJLv21BOfG6rth9G3w1
         vRroNE+DIX+xFNaIvbJDNKzvlr1QDB7GmyXTNcUA667vtQaBFx0nxT9At0rsJ47TELt9
         g0tbcHOUsZ+fAKlfs4YEiD5UxIqws5owzwH5RfYTQtGS537CDuXlXsCb/r/29JMBg0DW
         64VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932741; x=1708537541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRnImQ9uQNGNma8u5QxFrBkc6zo/zvivQCNl6ZYCdKg=;
        b=AjyHBIwv5Oo2sIBmEP7bdK8YKHJOT2kuueSfmh9vjdtTgwABD3C+6rKqFG5M9UP5zH
         wU1AB+VLTFp5v+cXgfhx9qw7zUnPmfzdVjBSCZ27QCr+ZbB0ux4rEb3wyaKtTyShhZye
         vcE4tVEDKrL3jxXtR6jnkAD6RC3+O/8MKPzDwrZITok+56F4XtpF+9Z4jpOr33VhU04w
         ZWjy0XGKnDiMwzBNTPaQBHSXP5D3njIAWqgIesymAtVF2HdOnJ+Utxb5au2wzpbYpIQa
         qSC2PJlNqA6hLEHbSDQHMnI3kpTI/x0bnKu+cuJO2V9LTpMs/b106SZtUjpgWSUG/aqh
         bDSg==
X-Forwarded-Encrypted: i=1; AJvYcCXNif/MfCIRoLXjvChYqBIwQ75On8enHdntXlAMAfyMZnOmAin2X0V6LywIhiVy3cWcfs0SuQckEKkLhEgcnSGL0T8J
X-Gm-Message-State: AOJu0Yx/yuZpDZgfsKq2ItJNbZrBaFanfy9fhBcicQcx685Uc4bApLB9
	ufhQCyZgg/FBpYC5M1/jGIwW02MbZfc1Fcrq4E+PBVV+R9qq5PuosHPDrLqRVuLYtnvVDwjEEi0
	Gnesb5MMBf6/hosXa5BQsLPf63VU=
X-Google-Smtp-Source: AGHT+IEvnWdPGyANBhQyWpY5MEDDuPQQKY9U5zDC7KouTbQemr995NrQ8zf7AR/TvaBlj54W1Odqa7YTbdxrBjHrbKc=
X-Received: by 2002:adf:eac5:0:b0:33b:7b43:4ea4 with SMTP id
 o5-20020adfeac5000000b0033b7b434ea4mr2096763wrn.28.1707932740781; Wed, 14 Feb
 2024 09:45:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-17-alexei.starovoitov@gmail.com> <CAP01T743Mzfi9+2yMjB5+m2jpBLvij_tLyLFptkOpCekUn=soA@mail.gmail.com>
 <CAADnVQ+FMHN9oMd+Tvz_9wonW6JoGgPboLAJ6ysa+26jNK+Mpg@mail.gmail.com> <86d1f3c1483d07815ad1dd542abf6038da1da24a.camel@gmail.com>
In-Reply-To: <86d1f3c1483d07815ad1dd542abf6038da1da24a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Feb 2024 09:45:29 -0800
Message-ID: <CAADnVQ+pL9mc5rGED=C8ZkBD8WVrE3R8Pg6_kurgqrEkJrGa0Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 16/20] bpf: Add helper macro bpf_arena_cast()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:47=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-02-13 at 14:35 -0800, Alexei Starovoitov wrote:
> [...]
>
> > This arena bpf_arena_cast() macro probably will be removed
> > once llvm 19 is released and we upgrade bpf CI to it.
> > It's here for selftests only.
> > It's quite tricky and fragile to use in practice.
> > Notice it does:
> > "r"(__var)
> > which is not quite correct,
> > since llvm won't recognize it as output that changes __var and
> > will use a copy of __var in a different register later.
> > But if the macro changes to "=3Dr" or "+r" then llvm allocates
> > a register and that screws up codegen even more.
> >
> > The __var;}) also doesn't always work.
> > So this macro is not suited for all to use.
>
> Could you please elaborate a bit on why is this macro fragile?
> I toyed a bit with a version patched as below and it seems to work fine.
> Don't see how  ": [reg]"+r"(var) : ..." could be broken by the compiler
> (when "+r" is in the "output constraint" position):
> from clang pov the variable 'var' would be in register and updated
> after the asm volatile part.
>
> ---
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index e73b7d48439f..488001236506 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -334,8 +334,6 @@ l_true:                                              =
                                               \
>  /* emit instruction: rX=3DrX .off =3D mode .imm32 =3D address_space */
>  #ifndef bpf_arena_cast
>  #define bpf_arena_cast(var, mode, addr_space)  \
> -       ({                                      \
> -       typeof(var) __var =3D var;                \
>         asm volatile(".byte 0xBF;               \
>                      .ifc %[reg], r0;           \
>                      .byte 0x00;                \
> @@ -368,8 +366,7 @@ l_true:                                              =
                                               \
>                      .byte 0x99;                \
>                      .endif;                    \
>                      .short %[off]; .long %[as]"        \
> -                    :: [reg]"r"(__var), [off]"i"(mode), [as]"i"(addr_spa=
ce)); __var; \
> -       })
> +                    : [reg]"+r"(var) : [off]"i"(mode), [as]"i"(addr_spac=
e))

Earlier I tried "+r" while keeping __var.
Directly using var seems to work indeed.
I'll apply this change.

