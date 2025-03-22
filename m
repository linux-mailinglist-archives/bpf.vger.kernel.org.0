Return-Path: <bpf+bounces-54576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E91A6CC7A
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 21:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4D51891A9E
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1722D2356A9;
	Sat, 22 Mar 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GQieJjcr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92121E9B34
	for <bpf@vger.kernel.org>; Sat, 22 Mar 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742676266; cv=none; b=IbbDssrSPyNq4Vt0ccSiDuEVRkmV17eA3Oavs/Q1zSaGhY6dB0nUoT6jRYv4hhA41WiEPORVUVqu0fN0TVxZfNUijOSaJIB4k5UuXX/eEPSwpqSb5AlimSsDabzXaGWXaR3Hs1U6r6Dn2G4zDSKQrxClo0qI9+8FqJaywt5B/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742676266; c=relaxed/simple;
	bh=UKlciIrjeezvhboHb0wpfeljhOCf1ywpYrDH4+tDbI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmMFolZ3F114Vredsx6GfnKU06sU18uUq53gGXlyZMPIMs2uULezkMDucwRmGQGm/sPvFO8bsedHIGeeds66kRLntjx+2M89UGPFnHVHL85qUnQfEZYcePY8+JBY7VaBNUc5simANYDjr9R6SNBqC0uJyG3a5YlMLq+QFIohFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GQieJjcr; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f768e9be1aso39793007b3.0
        for <bpf@vger.kernel.org>; Sat, 22 Mar 2025 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742676264; x=1743281064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+vTxWBkSi57+4WfhJ24nlBMfZiKcsmbPvtMMRe99nY=;
        b=GQieJjcrcWmiEj5M05POaTOS17Jp9Q0qocinbVA6c9w5Ejje9YXldSOf/9G0cp4Pc9
         7maup0mffpTRwLL9FZx5bN/iBR1nxNDsMOBmU9n4qjqvBg6Ot8LsttV94D0Y2U/k/G9L
         F62InBFMOJ8rXWyhpgJOplGNLR2sagMJdL9RWacXvz+qzGHaHnqGQO7jxBZPIgKz0wpW
         5VozKYI5YUaCI+YkiP9hM1e7rVOrCVpnE/N3DjZQ6odMXkWyyB96HRji6UdE90pgb9hE
         XiEAezRM4c1Q/SbN0jWp4BM89vKK//gdp+hVwKPvulYlAaze4TM3Ubuc2Oe9KYKuqrBs
         0bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742676264; x=1743281064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+vTxWBkSi57+4WfhJ24nlBMfZiKcsmbPvtMMRe99nY=;
        b=r3vylAuTAl4sBaohiTeuCdvVnPxrHGCk8HZ04jh7adONWbK/GFHrJC+QlMOsVqy+7V
         T2NJBn1l9mppjMx3qkluJOAcYKF8b1nEd2LzxOlCglNhw3szHZ7HY06BhikZkx+J2KZb
         NlfvAR7zesYMycWURz+j0eZe9BxynIKUJpO1bbIP96vYd9tSoxtYbgiHjBX81+n6m2+N
         23vxCeM7RGKqR7Cn93iy83aKkYdqx9SI3ClYPLf1b0uLQQwJhyQT2avbf0rT7lFiug5F
         63k+NVfTfqz18BhIJIwARmPUgCrvSu2g4IvExhnys8gNxutA1C/5RnuwXGfJhCozR2L0
         auiA==
X-Forwarded-Encrypted: i=1; AJvYcCXW6qMvSLbnsu6pqdpj+r//r6X685JU+BGEO9JKO4F317a8oDVsv+E1AftTZAi5Oi8otio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIPQpsuDFuHZ8Em4xU0slzR8YPOm+/7cI1I9KrXnITEBFai4U
	1JsGqGDlqCWwmVEMb706YHZVH17LyqR5pBZzwKzlNuGnJx3fnz5FOhfKYA9Pv2xhyY3FBIOqe1q
	ToVnsejucbxFqUBpxu1gQPV+jsUnwUKwkB6KX
X-Gm-Gg: ASbGncvtjB469ZwuzhYzMBX7mml7KsqT+3Ah83kxaAUTqgHwBjCpGY4yC8OP+3mUSWZ
	gveHLQkCcfUHnYqlCf5KN4n+YscT5KThzPkKoHAW+a/WIJZhKyfHygdNhS2c8fSXs/cTVa7t8LC
	Tp5NIOhXsISXmEqPtWeLCS8v2imA==
X-Google-Smtp-Source: AGHT+IFcKv9scbpPRaXEmfEq8UTNsrOWBSBmEAVu84IGUkNbStpZPTP0X6nSe1KdmVF1IIRaxjZIWblNbdfkJkrFAUw=
X-Received: by 2002:a05:690c:290f:b0:6fe:5dba:b190 with SMTP id
 00721157ae682-700ab33324cmr140033307b3.11.1742676263726; Sat, 22 Mar 2025
 13:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com> <Z97xvUul1ObkmulE@kernel.org>
In-Reply-To: <Z97xvUul1ObkmulE@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 22 Mar 2025 16:44:13 -0400
X-Gm-Features: AQ5f1JqeAnjTq6zKFyRLTvg80Cofo3Oa1gVwBdukxtEf_asDyE42Nwb-Nf9BM5s
Message-ID: <CAHC9VhQ4a4Dinq+WLxM88KqJF8ruQ_rOdQx7UNrKcJqTpGGG+w@mail.gmail.com>
Subject: Re: [RFC PATCH security-next 0/4] Introducing Hornet LSM
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jan Stancek <jstancek@redhat.com>, 
	Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	nkapron@google.com, teknoraver@meta.com, roberto.sassu@huawei.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 1:22=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Fri, Mar 21, 2025 at 09:45:02AM -0700, Blaise Boscaccy wrote:
> > This patch series introduces the Hornet LSM.
> >
> > Hornet takes a simple approach to light-skeleton-based eBPF signature
>
> Can you define "light-skeleton-based" before using the term.
>
> This is the first time in my life when I hear about it.

I was in the same situation a few months ago when I first heard about it :)

Blaise can surely provide a much better answer that what I'm about to
write, but since Blaise is going to be at LSFMMBPF this coming week I
suspect he might not have a lot of time to respond to email in the
next few days so I thought I would do my best to try and answer :)

An eBPF "light skeleton" is basically a BPF loader program and while
I'm sure there are several uses for a light skeleton, or lskel for
brevity, the single use case that we are interested in here, and the
one that Hornet deals with, is the idea of using a lskel to enable
signature verification of BPF programs as it seems to be the one way
that has been deemed acceptable by the BPF maintainers.

Once again, skipping over a lot of details, the basic idea is that you
take your original BPF program (A), feed it into a BPF userspace tool
to encapsulate the original program A into a BPF map and generate a
corresponding light skeleton BPF program (B), and then finally sign
the resulting binary containing the lskel program (B) and map
corresponding to the original program A.  At runtime, the lskel binary
is loaded into the kernel, and if Hornet is enabled, the signature of
both the lskel program A and original program B is verified.  If the
signature verification passes, lskel program A performs the necessary
BPF CO-RE transforms on BPF program A stored in the BPF map and then
attempts to load the original BPF program B, all from within the
kernel, and with the map frozen to prevent tampering from userspace.

Hopefully that helps fill in some gaps until someone more
knowledgeable can provide a better answer and/or correct any mistakes
in my explanation above ;)

--=20
paul-moore.com

