Return-Path: <bpf+bounces-70222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0887BB4C11
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 19:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C7C7A9EDE
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932202749CB;
	Thu,  2 Oct 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRdTQj5H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93557219A89
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427611; cv=none; b=g8a2T/xanI8foYQo9AjbzvRRpxsIjyplfHkQRlkLZOZcQwTD7EsaHt81KsJw1MgNfQoAaVimf4PFqw/etCio3qKdTy2VUA9JFHRbHYeQsHKAVhu/l2lMopclLk3tn53K9LhvIjYNxbnzL64FbpSUalbrvSpLLy4/H+W4e3mUBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427611; c=relaxed/simple;
	bh=lYlR9JAkY6eonM9QwEMKfhCQRHt2uu3QYqSTTamIBdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlfOG3x7PPT3+ezrjfiqYxFZsKEHLUix6+NHMvamvPJXdMVlyuTmoKQW/FYirUmBE4Y6MZcUs2x5Q2oshAaPu17fltd8vHdUM79bulLK9oNXYmErGGghpfhehg45rIxAwilarjQoeSx+/Er3sIPlbNuFvGE4KQCMOZm53OMNkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRdTQj5H; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso9208455e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759427607; x=1760032407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaxQ5nlkJBoLX0kDXGvJ6XBK66v+3iFsoex1hiWJ05Q=;
        b=LRdTQj5HA57YVY7NqSsaSHUE9ezVXfVkKiA3tx4sIG7YPF3d+j3ltMzh9hU7u0Lo+v
         zs+y0nRiwOGSD0ALpJq61LnvsdOv9kJplLXDi0AhjWMUM1u88fIYWDmjzLA9orpdKeZD
         THAoAu+3KbIGNaLEYA4aKNcVcy78ngRuQRTdEurCD6yvjcbr8WKEuOG8NdEA5HUUQWGl
         pVv0BWSYfj0ZXbfAiSIcKRRWZA8ZOYLhqfSR6679FCMS9tb4+/6KNANJjge0du1wtWlS
         ff94Rcj4eW7l4j7UxSTKtmLdRlUEAoCd5zzn+/jrx1Au+XG+k1cUxzBmHtuwM48YcD2g
         U9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759427607; x=1760032407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaxQ5nlkJBoLX0kDXGvJ6XBK66v+3iFsoex1hiWJ05Q=;
        b=kSCTeruqQvhvBkATCJmNLR+6xR1xdjFnW1Allk0se7ZKDBHVNI6khT7yhy/vW4x0R5
         PhjzYIb0ntb3FWQcAuHkucMbQlhnhKG4V9JtHZXlTfm2/BsOwsw5j8l/yQwaxQrpQ3da
         6U3UqnPYeereXUyv4WDdTXQnNRpJDp0UsIyPWEhA4dmyyD/zEVq1iqEeNIva7ohw5V3A
         qGBdhK/UXWhbY1Ym/LhEp+gyewQJFqHC9+VVlYlkZs6kwjVULZRrT2GnjMsYaG2yyY2E
         fIH6G4UlH+9a5LMBAdA7t0bjMyzuGPmos4pYde7IKfTJqv5sRnAFClR4Umcx43epNGbt
         EDKA==
X-Forwarded-Encrypted: i=1; AJvYcCVFuBD2xzQT7+aPtSr4MaPQ9w9VveyC+a25S7uTfD6T502zbJqgeBq5V/8XuqS6cVyXrgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZTjQwyD7mudffgiBM6mCJ6P4C5CS7tChnbfeJKx/4UHPu5dF
	a6zQW+cjgend1bQpJyK68L8sBPC1x5AUEIRREBd6W6Id3UGRlSHjLcDUju1D2Ug3tebqTbmXxZS
	XGuSs5TFJd0E4lP/dmpSdOmAsraFp6hK7Zn+M
X-Gm-Gg: ASbGncvM5EWZngj7S/6YZiCpDCpP3Km8h/U5TUUP+GMPLZ26fycHrFO0m2shsIVQWYr
	XQPOyEYp/dKL9tXqSRxosNTJLb6ffWW/aloyImiC1vxKGLwKTzqLJAPUCzDZN5pK/A859l18+8j
	UAYys8cVrI/+S+zRgPE5WP2SdA0ZseES+N+mAKOPL2uRtWy2nHFnytTL3qYtf97ttleviyN3QAd
	8dyjzLUttzwKVGWns7BNCR5yNdpA4EW5g5tIk4JSRN2bWI=
X-Google-Smtp-Source: AGHT+IGUdaUJJ5Am0eJaFvkFzR87l/n/eveNeYR/SWSgPBWRcduqOdb2zPykXRgYMPLLpVYYFEtMNgr6Gvw1FOwxbKQ=
X-Received: by 2002:a5d:5d87:0:b0:40d:86d8:a180 with SMTP id
 ffacd0b85a97d-425671362a3mr143408f8f.20.1759427606568; Thu, 02 Oct 2025
 10:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929194648.145585-1-ebiggers@kernel.org> <CAADnVQKKQEjZjz21e_639XkttoT4NvXYxUb8oTQ4X7hZKYLduQ@mail.gmail.com>
 <20251001233304.GB2760@quark> <CAADnVQL=zs-n1s-0emSuDmpfnU7QzMFo+92D3b4tqa3sG+uiQw@mail.gmail.com>
 <20251002173630.GD1697@sol>
In-Reply-To: <20251002173630.GD1697@sol>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 10:53:13 -0700
X-Gm-Features: AS18NWCbGcuZ8Cebik8lq4lHKUH7KbCo2CuA-1gvo_9eRy3exLlbGTVyNK97Dds
Message-ID: <CAADnVQKTvXWQ72iBaAvCsDumq834t7f_0Vjy+Vz-8zaYtnupwA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 10:37=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Thu, Oct 02, 2025 at 10:12:12AM -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 1, 2025 at 4:33=E2=80=AFPM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> > >
> > > On Wed, Oct 01, 2025 at 03:59:31PM -0700, Alexei Starovoitov wrote:
> > > > On Mon, Sep 29, 2025 at 12:48=E2=80=AFPM Eric Biggers <ebiggers@ker=
nel.org> wrote:
> > > > >
> > > > > Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy=
.c use
> > > > > it to calculate SHA-1 digests instead of the previous AF_ALG-base=
d code.
> > > > >
> > > > > This eliminates the dependency on AF_ALG, specifically the kernel=
 config
> > > > > options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
> > > > >
> > > > > Over the years AF_ALG has been very problematic, and it is also n=
ot
> > > > > supported on all kernels.  Escalating to the kernel's privileged
> > > > > execution context merely to calculate software algorithms, which =
can be
> > > > > done in userspace instead, is not something that should have ever=
 been
> > > > > supported.  Even on kernels that support it, the syscall overhead=
 of
> > > > > AF_ALG means that it is often slower than userspace code.
> > > >
> > > > Help me understand the crusade against AF_ALG.
> > > > Do you want to deprecate AF_ALG altogether or when it's used for
> > > > sha-s like sha1 and sha256 ?
> > >
> > > Altogether, when possible.  AF_ALG has been (and continues to be)
> > > incredibly problematic, for both security and maintainability.
> >
> > Could you provide an example of a security issue with AF_ALG ?
> > Not challenging the statement. Mainly curious what is going
> > to understand it better and pass the message.
>
> It's a gold mine for attackers looking to exploit the kernel.  Here are
> some examples from the CVE list when searching for "AF_ALG":

Ohh. I see. That made it very concrete. Thanks!

Acked-by: Alexei Starovoitov <ast@kernel.org>

