Return-Path: <bpf+bounces-34666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBB692FEB8
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 18:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCF71C228F3
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A917624A;
	Fri, 12 Jul 2024 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrafyCeA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BC1DFD2
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802611; cv=none; b=rjciKcXOdLt7ZyD5HIJED9CDNJ9EADxO73vkye+6NIo84ZHUWtWDwBhUES7m/Xyc9iMjmRcsgxfUKNIeb/61UUxVKGokWJKpKJgkxvQSL+Nb+fADDgfLLn+r1btkNy2xtu9vkdYLYkqWgOm0kogKV3G3mngxKenek2P+oqzDTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802611; c=relaxed/simple;
	bh=U/vbWKI8UaRyLiBdLawSkHPdUh6SIDc0FcD2fiTsWco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPpA9yppafpe8wp19WFB/f4T6kkCUHxd8T5bt8W06Ul4VzoCVNcFCD2Jb3K6yldzI3wVfd9kbxAXnvskzI1dUZ6ZVVTUXFvSm4BbllB5zB76G+EEy5wM6TxJDqNLhGZ0gPozNFcTtI/86nI53qb0D6b9oJFwzIy6Efn4fDfhglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrafyCeA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso19720315e9.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720802608; x=1721407408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O/lssQUadPh2/E0K/U2OTbSy1LpYSF/pApWvOQXT28=;
        b=HrafyCeAPBTCkEMArRiyFus2nm9JgnkFBOpmE+t7IAhwzsp1fZ7JsymMjqcQy+u0JD
         lZK9se9jofWpb8obcSvtbnXf62wAoDbGHCCdpUr12XRrNu1KARcAd6gtrrrd9YIzCOPa
         kbeYQwlMuErTbPvwDNvpemIG1wLYxaH24U/nW/cQX/untx6Sm9Z7TZAQEGocpxjIEKSn
         cEEKfErFc+X7mCMa5Pgkrmrte8wIT0C1DEwO5YXYOs1rVpKft1oiGEvxeYYpoDzdjC+3
         bK5TYylqidvGeB8u8WaQVM7oe+v6U6EzK4JvNrvoZuU2h/J9mdz4KuqgacuFVyuKTkbJ
         XlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802608; x=1721407408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2O/lssQUadPh2/E0K/U2OTbSy1LpYSF/pApWvOQXT28=;
        b=fsCRcNM+RpGvoVR7AEcoh65q1jG4Md6dEIgqz2fwhPhkAexyuefWNPeRBlADjApTO0
         GAeKUEsHsWFGE18UttMF5QwOgsk4l8/ONalYHlq6T5Z28anFFzo81RDzYYss4gLEXIe0
         M/E1gs46LiUEnep9VqEsyRAYlFxrHEGpxRGQrc4DohldUc2VDmahb87zuiWt5UcSaKLp
         TZQwN9nqV3AfAGO0jJIy726hNyExnycnA/GXP7ZD/OyZfwxkNMePBd45Am+JF1Uzmmc6
         a0rqTKOO2tbXH1tfO4xynEoS9Yw+APcvrc3xKw2fA1hSvxzVIvzUKNxmgIUBSPormi0Q
         rAlg==
X-Forwarded-Encrypted: i=1; AJvYcCXt5PGvjEkrb8N55F+5JXm6RoZjFSqrwsHLhADe/e0bIKzPJ2G8P4hb6P7Tcxt/Ia+YPhtF2YuXLt8d/whVetI3z1bM
X-Gm-Message-State: AOJu0YzlX8fFW9xBMVSqBI9Eo9K9mKw3o/6nAH99MRqNaKfzP+Fms21l
	X/UuHoHA5i6f3HuilN1fSUxugv714Wm2HaSxg3OGsE+WXcvcNF3FAO0u5/A8p/4bCKBcT4WJ4Ma
	OCatRcuVJKX7O4TvwU5slDTETWM4J/rVsfWU=
X-Google-Smtp-Source: AGHT+IEVU7gXUYP3Te2WTr9klKvRHCefYUi7xwNsWUibJBOnlwDmcOj+5wMnD52mL/fN6dEt7sfchlvhu02garh6eKA=
X-Received: by 2002:a5d:4fce:0:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36804fda7a5mr1847303f8f.30.1720802608186; Fri, 12 Jul 2024
 09:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711054525.20748-1-flyingpeng@tencent.com>
In-Reply-To: <20240711054525.20748-1-flyingpeng@tencent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jul 2024 09:43:16 -0700
Message-ID: <CAADnVQJ+UxmOe_G+UL_wFEZOFTVL4XQ=D8X1N29CT=zHNmi6NQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: make function do_misc_fixups as noinline_for_stack
To: Hao Peng <flyingpenghao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:45=E2=80=AFPM <flyingpenghao@gmail.com> wrote:
>
>
> By tracing the call chain, we found that do_misc_fixups consumed a lot
> of stack space. mark it as noinline_for_stack to prevent it from spreadin=
g
> to bpf_check's stack size.

...
> -static int do_misc_fixups(struct bpf_verifier_env *env)
> +static noinline_for_stack int do_misc_fixups(struct bpf_verifier_env *en=
v)

Now we're getting somewhere, but this is not a fix.
It may shut up the warn, but it will only increase the total stack usage.
Looking at C code do_misc_fixups() needs ~200 bytes worth of stack
space for insn_buf[16] and spill/fill.
That's far from the artificial 2k limit.

Please figure out what exact variable is causing kasan to consume
so much stack. You may need to analyze compiler internals and
do more homework.
What is before/after stack usage ? with and without kasan?
With gcc try
+CFLAGS_verifier.o +=3D -fstack-usage

I see:
sort -k2 -n kernel/bpf/verifier.su |tail -10
../kernel/bpf/verifier.c:13087:12:adjust_ptr_min_max_vals    240
dynamic,bounded
../kernel/bpf/verifier.c:20804:12:do_check_common    248    dynamic,bounded
../kernel/bpf/verifier.c:19151:12:convert_ctx_accesses    256    static
../kernel/bpf/verifier.c:7450:12:check_mem_reg    256    static
../kernel/bpf/verifier.c:7482:12:check_kfunc_mem_size_reg    256    static
../kernel/bpf/verifier.c:10268:12:check_helper_call.isra    272
dynamic,bounded
../kernel/bpf/verifier.c:21562:5:bpf_check    296    dynamic,bounded
../kernel/bpf/verifier.c:19860:12:do_misc_fixups    320    static
../kernel/bpf/verifier.c:13991:12:adjust_reg_min_max_vals    392    static
../kernel/bpf/verifier.c:12280:12:check_kfunc_call.isra    408
dynamic,bounded

do_misc_fixups() is not the smallest, but not that large either.

Do in-depth analysis instead of silencing the warn.

pw-bot: cr

