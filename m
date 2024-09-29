Return-Path: <bpf+bounces-40514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC559896B7
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394871C212D9
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A594207A;
	Sun, 29 Sep 2024 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyfIH3nP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571F36AF5
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727633355; cv=none; b=V7IuHYpd8peZY9O5UNJNK7f7MTVl5cMIMbDR5gWbQkzje6XvaryDynU6SG3mugFl+tJtbr7iCzafASMeo/Zk3yYMJ0AFTNFmaE8fwYM7p6gt+s95+lH4QqV1kNCNpvXiRi5KpmsILeUfZuG6Bd8Vb0ZO9xeuDgdf0ahMbLUcXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727633355; c=relaxed/simple;
	bh=IMCLKO7fhfTIkd5kaH3rPPYxSX8whuWiPDn1SJr0uQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSX1jRBTjbj7h1YqCGTLuNCTTIKoNQNIV9qtWg7+n7imT+YiPaTN0B1WsuU1WGyJaFKT5UckrZVfGpX7/DLDRQLZ50LqV32aCRXIkgu7f6dA8+B1J0/KQ9mf3gcX88/5NO3g7n4hkMdkhExzbnrAJ8rkuBm5gETz+NYOdMfe0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyfIH3nP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so637781166b.1
        for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727633352; x=1728238152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjZ2ja/dWa9U+ZTEmd2jbHu48rCyasxgDCLPSN5uawI=;
        b=EyfIH3nP+ovKPPhOJyDswTWooZVLboAOTPtef9ho/QZ+m6tK6Jfm1AEE/83XXUK3lJ
         g7y+qY92ciMftLppKDZfGWjH0uyiKasG0wv554aQ0bEzJuemLPBKUdQWnBzymhqAwvvZ
         QTvJrpkknnsWVJIGXWeVFj3Fu09lDtL4t7cFP7m8CMDTtgUMr325cgwe0FeJ2JoLdcif
         VLQhocGqgSlAm6tvSDEBuj6cMnDOqXv17tLoL19LoCbRSPpV14WLRLTNNB8EjZ+RJ8Ae
         fAkb6kV3Y9wGen7lQAY/Bb1u9HkBVvuxfGFDO2vjvxGUApYDCGURW3Lq6LMpg02Cybrs
         wS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727633352; x=1728238152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjZ2ja/dWa9U+ZTEmd2jbHu48rCyasxgDCLPSN5uawI=;
        b=YlEgG0DSA0CDISA+EztkzegO9pkQSKXO72HrcvHGu54AUQmKFoULInLnkVqOZHIRPS
         mpcBFyzBX1vrFug1jwegqrX6rrWim+BxtibZ9lhEeqRBsKALWlsv8MLHa8Z9PH9qd+XU
         NVYdc7LCtxJafZeC2zwBmuqdbXx3D2r7Ir/ZCUABTJve8MaAa0IGCNoBxqVPaMi7g+wi
         rDJ32pNZdym7i1HL9uyxaSLPMC1RTBCb3Y083pdbQIqijgyrJxr4U/AGhdRmeoKlaELj
         gmiDpbEhrsz2er/094f96cBx/hSTd9SYCqCidfUBOwExkNmBmcGeuV8YiIu3Cd/MBy6c
         g+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1gz4Je55Zk7bPp+HUCOLj8G5DCdp+rH8jXx/1pQbRJDhWn7FIN/UUKhmQcrGUSCPKzzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5sbsKUXO+a+2Q+YZA5vywzJhBwblyonWz2dJaYBm6FbPcdcju
	Dkvtiq6VpsbXiMVucse4sEFoVHjgkYhbhpbjwz0PdHqrv3vfr/XgV/baV3ZXmogP0gugSqu96qN
	N9RS8lyfUQ36xngOIoieGegE07fw=
X-Google-Smtp-Source: AGHT+IEyZ2a79kVPekmDAuL+fYgohZQO5kgHPOOmhJW8tfgIriuKXi/xi+9fVhfVtH0VyeG30x2eVPvwQRh/30DzuSM=
X-Received: by 2002:a17:907:9604:b0:a8a:8a31:c481 with SMTP id
 a640c23a62f3a-a93c4a8763cmr1170279966b.42.1727633352179; Sun, 29 Sep 2024
 11:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75d1352e-c05e-4fdf-96bf-b1c3daaf41f0@paulmck-laptop>
In-Reply-To: <75d1352e-c05e-4fdf-96bf-b1c3daaf41f0@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 11:09:00 -0700
Message-ID: <CAADnVQL7jSL_ewvgPrz1pdYcw2Xbw+oEjDVgozKizBqvbnMO1A@mail.gmail.com>
Subject: Re: Summary of discussions on BPF load-acquire instruction ordering
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 3:00=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> o       All this leads me to stick with my position called out in TL;DR
>         above, namely that the BPF load-acquire instruction should have
>         the weaker RCpc semantics (like ldapr, not ldar).  That said,
>         it is entirely reasonable for ARM64 JITs to use the stronger RCsc
>         ldar instruction to implement the BPF load-acquire instruction.
>
> Thoughts?

All makes sense to me. Thanks for sharing these details.
They probably can become a part of the doc on BPF memory model .rst
somewhere in Documentation/bpf.

Eventually we'd need to update standardization/instruction-set.rst
as well when new instructions are fully fleshed out.

