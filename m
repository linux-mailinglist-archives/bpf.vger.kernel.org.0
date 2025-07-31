Return-Path: <bpf+bounces-64825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF70B1755E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B0767ADCE9
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D142397BE;
	Thu, 31 Jul 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRBCbek+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55072637;
	Thu, 31 Jul 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981414; cv=none; b=f9fqzySSLbkxT0pxH3UCo6idRcC8vBiu4Z582gPR/fJpTWdAhBEFqDetRLPrghQJWvdyF7LHsUCs/112NusJ4hdFz8G5srsLBtQjTtgWgKjBR+id1lWtmR8P4foClvgdCgRabqUP3MiEqqss5q5MJdZLXa1n2OvuXKVNA4AZaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981414; c=relaxed/simple;
	bh=7vdU2nzIlB0cH7WoyqZ34N9wygjHGM2SndCa4WqN494=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgYq137J8/lYe0cuL2tmxRaHGnuwDBKUrX4zjbPMC3xB6ElAtBnmX1GeP8JeXflR1u5qq7rB9EuOp/UsQc9DsrrdlMYwjAkrlS4lmmjAVkMgV4DojVEOn9wzRx+MShSDYW3Ub5bDsYYnkq6gkZpD+bNPND5H2GYu8K3lS30yuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRBCbek+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4589180b266so6414355e9.3;
        Thu, 31 Jul 2025 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753981411; x=1754586211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEpBFSQ0HXzud7IO5DhdcLDekO1YKRMjZmaFWgvgSc8=;
        b=eRBCbek+hHIdnz3alR4L3EcDC0qBZIz7l9HBC5MSNadDakfQphhWAeI9pak2DKXRHP
         05UF6iU/gF34o4FwWQ3GmJF6wC0zxJZZA3xEvtRxwnEOV+K3vqdSB+GMPKBQ8Vi016v4
         cs5Z4kg9UttfWuHyJwD7ZTOpkKweFiUFToG+t2spYrQDcYlMl6fzhlnd4PUVmsF34l1s
         0T/inqwPctGGqZs5eaP9jJmH1e4TGdXNcoMcu0Z5ZhXW9/sXWg002cHosZw4NFqAT2r3
         BfmWqYqNslztfpvHR2mrmKIJQhHTYctMHrQRqcTxJvCABWnxknhYhqZCV6a56wxNWmhk
         wSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753981411; x=1754586211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEpBFSQ0HXzud7IO5DhdcLDekO1YKRMjZmaFWgvgSc8=;
        b=GaADsaBTRgKkjSlgQzIx6s8eqpGk+ULc/Gjc0NIGvOThBwp2i22bNFbVu2IEKKH6ZM
         QvCpuXoiolWqRupq91ay5I1uT727pCZyxAKa+uSgCw831WqCPKkAfEAunRR0O0hSAnnO
         YR6oOQ4qufmeaqZyIGSTtCCUCKGrCEitpCFL7eN4zUGesQ3m0jR5S2gVL71MCKRk5Rfn
         BaAXPQCv1AGoObrx4T4+b/wUj5LYt9pyhHufz8FXsvK5pP69zwLmxxxXqc50Eil7YVPU
         1gyXPqbwCESYFUHYaT8culIy53IwKoQjNIRppZ5WPrd66EKYL8NJMXNlDhrzC6Z32rvy
         Wf0g==
X-Forwarded-Encrypted: i=1; AJvYcCU8/vcgJWgA1NXT+zO+dHbmlq5LV/nNRiRo7WYUoeY/s7MSfrECO0GQnwNc683z7lvU6cB5WHQK1fBTu7cR1ennoHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4x11cpkny9OqfxsM/2aoieBNTNo+DYWpQHEX86/D0X/ReaLik
	vEQe0jHvxHvPoSZkG9EJ4++n4A7Oz3CEyqytT6AUDKYV1+cb94P0w+hMtQBwm+81lUVsiiC+fBh
	ruJXeXTiLJYJrH3m/3DS/qT4xrvBV7bs=
X-Gm-Gg: ASbGnct/AY89yBTs01q56DGlQS4VHP9DNcbMDCF5ZaQIAogggLdqj3gOrZb5C8kJVgM
	MyAUgXx6QQJP+MxhwOnXprZ/zlHGPneMtCRbsaFvesazGuiv7MHeX0KbwUmqp00BbSZISVagwrv
	fRer5CNdoVYaey/09GZ4V2HAlFucIVvNSxXC5IHm8AcOs1puCeklSTg7jiMkGY6ps/kdq+2ytjs
	0RnblUz9XrwbS0CZ9RmFHY=
X-Google-Smtp-Source: AGHT+IFpRBawkvMo/n1r3ipVeiq0Qvriz2CEYDNLPJeGzKOkQWguv/EPcTJlUcFU4BXghx9xLYi/TOsk1XlpNYDXT84=
X-Received: by 2002:a05:6000:2483:b0:3b7:899c:e87c with SMTP id
 ffacd0b85a97d-3b794fb2209mr7161449f8f.2.1753981410719; Thu, 31 Jul 2025
 10:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730172745.8480-1-James.Bottomley@HansenPartnership.com> <20250730172745.8480-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20250730172745.8480-3-James.Bottomley@HansenPartnership.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Jul 2025 10:03:17 -0700
X-Gm-Features: Ac12FXyiNA3gXOAh4AjOrsVUaR2uwglIAPRIY0vYqTLm0IIPd0Jo4Jom8wXsUCQ
Message-ID: <CAADnVQJd0zwSnepH=1f6mwnd-1oFF8gkuCFnEgbMVE8pZ3qz0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] bpf: remove bpf_key reference
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 10:32=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> bpf_key.has_ref is used to distinguish between real key pointers and
> the fake key pointers that are used for system keyrings (to ensure the
> actual pointers to system keyrings are never visible outside
> certs/system_keyring.c).  The keyrings subsystem has an exported
> function to do this, so use that in the bpf keyring code eliminating
> the need to store has_ref.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
> v2: use unsigned long for pointer to int conversion
> ---
>  kernel/trace/bpf_trace.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index e7bf00d1cd05..c0ccd55a4d91 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1244,7 +1244,6 @@ static const struct bpf_func_proto bpf_get_func_arg=
_cnt_proto =3D {
>  #ifdef CONFIG_KEYS
>  struct bpf_key {
>         struct key *key;
> -       bool has_ref;
>  };
>
>  __bpf_kfunc_start_defs();
> @@ -1297,7 +1296,6 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32=
 serial, u64 flags)
>         }
>
>         bkey->key =3D key_ref_to_ptr(key_ref);
> -       bkey->has_ref =3D true;
>
>         return bkey;
>  }
> @@ -1335,7 +1333,6 @@ __bpf_kfunc struct bpf_key *bpf_lookup_system_key(u=
64 id)
>                 return NULL;
>
>         bkey->key =3D (struct key *)(unsigned long)id;
> -       bkey->has_ref =3D false;
>
>         return bkey;
>  }
> @@ -1349,7 +1346,7 @@ __bpf_kfunc struct bpf_key *bpf_lookup_system_key(u=
64 id)
>   */
>  __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
>  {
> -       if (bkey->has_ref)
> +       if (system_keyring_id_check((unsigned long)bkey->key) < 0)
>                 key_put(bkey->key);

Should be (u64) to avoid truncation ?

But is it really the case that id=3D=3D1 and id=3D=3D2 are exposed to UAPI =
already?

As far as I can see lookup_user_key() does:
        default:
                key_ref =3D ERR_PTR(-EINVAL);
                if (id < 1)
                        goto error;

                key =3D key_lookup(id);

so only id=3D=3D0 is invalid, but id=3D1 can be a valid user key, no?

