Return-Path: <bpf+bounces-34447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7537392D8AB
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BE52821F1
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E766F197555;
	Wed, 10 Jul 2024 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycb+VfHK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B0195FF0
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638087; cv=none; b=h6HCtNiVVTsL7pA8F56dhU/fw1rnlYWODe+mMfTrKXJzO53cVH/Fqp+VOT8GXg+QMVhbmlRy0VvnLdUcZeMq3Oyd61dAd4SrHTxC54m/5TOD/Nv+yaZfkcsR5ZbtvAVh/qwv/PBYe7fwOFqrty9EWW51+ffSTg5K7kad7B0+EWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638087; c=relaxed/simple;
	bh=vz5jHrDDWTHi6a/pDF42WoHq8VgZ5TLHCvw0VfuZBzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijwmKp5aebuY1yNT1IOnza8d60VYNQSXyFx5hYfAweIBakFI0AnF8/5YeL2WqBNRwDcu0a75aaFnZ2RSRU/3ypSGLhd6cQukj77AQiBlbeHPXLf4JZOUzG34pZo2zGBBZGrRDDxNS25chpk5ZckB0mFd8dNotxQAVIjQvFCdADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycb+VfHK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee910d6aaeso873261fa.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 12:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720638084; x=1721242884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz5jHrDDWTHi6a/pDF42WoHq8VgZ5TLHCvw0VfuZBzc=;
        b=Ycb+VfHKbC3xa2G4wsKtGG+PUqum2qgt+66kw1whPCPtUDKkXQnklr+g1RaoKEN955
         A4n9bLqGY6g5pWqlOfpmRr+aDwCrfoNrhUEHtBDwmObfS8Ezmoqc30e0Lny+IXbFUzPk
         Za9qyecnREIztabk8uhdM7MRU1I8bflB+Nf0wyquotEySOcT1TYIOQXoj7UITtUmUlQq
         SmgyPDkff6FAI7RBIaZNz0R/u0cMtBz4/yivMzdQjwaVPrJ0Bid68nGC2oBSaXVnLFR6
         r4hibIwUgTZ/rLk5b1P83D2Avrdxkr26zV3oIUNf3S9sRd6jX5UBveX9+gooYHXvA7al
         C5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638084; x=1721242884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vz5jHrDDWTHi6a/pDF42WoHq8VgZ5TLHCvw0VfuZBzc=;
        b=XNmeUr7lD5cVhv6owfPVch8Uyl1tsc59bPxRvJNrPOAa+q+58FPa34HUel9PsX4muu
         Cshrm14nB5QhS+smJ/OJiqx8f/+iNENOt9VqF7P2LzJHes5nOybKIGVWh0+RGpAg08ca
         lyd7uDKdPmQK2ErJxDcBkNbShhi7CrMjmpOCtO2Z1+7qpxzue85nMvm48o52CabANBDo
         JgHm3KjO7zyO69kgSEQJ6h993ohcw1Jrc1X57uWGIe6e38wKAO+G4HgyU6jGzHZrDMZm
         qUo+Jqgm4kiHiDSbzZLAUHqADhxS9Ezr2exE3U1/+eAkMq+i3hboas0QAN64kCn8Ppfu
         J0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUS4RO91K5di1DXpV5KETY4s+yWnmY187VFxltOdWOhuDlrGo4NyQCMgo32dH+0Gyb8RL+nhB+h2Pt7T0aGvsW6AO+a
X-Gm-Message-State: AOJu0Yxrnltn6uE9k0e++Ut5w7NFSILfkHivz+wJLpi0vb1QzMo2lKoO
	adslg6U+knRvG1bttLKp5w0FMiaIWwnonB+8oVw1DFD+rbcS1s3vCBDegB81FSdEXdFURbalTSy
	rj6DlLglykpd7CVQC0BF/C+3f4B8=
X-Google-Smtp-Source: AGHT+IHXzE9dKsiYciz8t2EuQvDBxbiwUWE5xFZgaVg409TT9fJ8kn+3vvzHK4m7qqnHpJ4K24hhNZ27rthg1xImexk=
X-Received: by 2002:a05:651c:8b:b0:2ec:4d82:9e93 with SMTP id
 38308e7fff4ca-2eeb3198608mr40125991fa.44.1720638083948; Wed, 10 Jul 2024
 12:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
 <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com> <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
In-Reply-To: <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 12:01:12 -0700
Message-ID: <CAADnVQKjK-ofDRmG7iCVo7-nABY7gW5-6qzNqZqifcWGWMZZfA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 8:36=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> But, tbh, I'd make this stricter. I'd dictate that within a subprogram
> all no_csr patterns *should* end with the same stack offset and I
> would check for that (so what I mentioned before that instead of min
> or max we need assignment and check for equality if we already
> assigned it once).

No.
Compiler has full right to use different slots in nocsr region
for spills/fills. At every nocsr callsite there could be a different number
of live registers too.

