Return-Path: <bpf+bounces-41615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00857999209
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41157B25892
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3D41E571F;
	Thu, 10 Oct 2024 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUoXlEW7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858519CD17
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587231; cv=none; b=hFuufwqr5wMtdeWEBMhJ8C9eR/87PDOdC7RHL4T0C204+6eV2qAL3nZb9VCPCngmAcVDpv4HmdY1hmTYAhikl07ozUJ3LVUADjG4lSlVwktiwyA8kexeyJFLkeXY6LbJVI/IwkXdT3Z2i5HvIaNhtPciJ8qkErcCKVToeTDdSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587231; c=relaxed/simple;
	bh=NXd7sQnZtEq94MLibAaleM3FV0K9PSYeMrQHcIq+4P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnQJg/i8xzYMgvZP58SteqQyLfiPGZ4RnPbaI5VhQYkDc2EacG36uDLGxc0hx40ZBhvlwZkwHFNgPK20gwbP0dWNVNJWZQ1gpl8G3GUimaflapdxJdr9D2ISJM7RdomkbOgAArdIOwLMSjgzFYpeFunQppxazgabvj+LTC0yDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUoXlEW7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so153069f8f.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728587228; x=1729192028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLpoabgzjH1mlBMsr4qvsZjUI/I8ORn0DwqeGcEpdB0=;
        b=aUoXlEW78t1ffvCjLGufhruk3SyVuqA7mllPpVPKpuy3x4WAO1d2puPtr/Nzu0Fovd
         uxxVidoy3fSQ8XQdsDdAXNiDwUmWjlhvD+6mtr1Ik6Y+yGTgXDVuvbxRXFKksc56q8X6
         XDyTYi0+//IjLXXHULuXgVNbyq1Qy0P7O6QKkxAxSVIWq96IWaN1xYEhkM5iDgy9/VO7
         S1oAa7pIjSU4gMv1ZVSd/7yzn+0JDqnyeqUJWEyR8DP64EUFkPK93HEl0AJpdTrBP88P
         213zroJnntqZ/mm+lVqgab38cQhXUJ0gQjvzTuIsyl+KoiKLEjPJIMjKG6fVRd9JNYkY
         5VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587228; x=1729192028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLpoabgzjH1mlBMsr4qvsZjUI/I8ORn0DwqeGcEpdB0=;
        b=xDLjMUUt2OgTXHhZpPg+U4WAVvEsu071pCzsBMSny4tV8DZu29jQvPrbaf6aiNIfh2
         /Cyfv7ypPIBRJhFAypPVYRyj/GXwaQzhYHT3Zupb8evXyzMw8O6c+Ua/qFUU2MXYWPsW
         oDstXaDEaQyPQqzWqtJO6htQjanDN+Kln4syBWmVn3uAT/aQdO3DaTPxCG0c1E6Nu7Ro
         0ZqTubXgBZA2kMQSeDqnx/DZdtDovNXOWfwlGOvgqE8Bk453i/uBT2Nq6pJuKIsLUotS
         fngD7rMXjEho6lAcFBBW/pKb8VnFvS1Hgbt/UL4gtVbgFSc0MOLb6aeE0rpBHvfTvKFV
         LkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn7hN7TzCnF03+wzj1mX6i2GBPgr/auGlmgcWm6Uj5okDEe2AvvGm7PsFL7kSiT2hRWjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtRekUfYEn5BqujbIeD4mp2M7K+Ar4ArAtU3GNnrfumjn1ckY
	U+0CqxAtYylUpBBI1qCyjL9zQm7Ku5PVpkhq3pSHPgPC6wMdUg9zRExyosBof2woOU1S31tf3Bu
	SiMRkyk8046gZQU2vdC5voXOeniE=
X-Google-Smtp-Source: AGHT+IFCQd5rrd0TBfC07Hfjh2e39mXXP/b568HMLyy7vAgvxDN/mzzTzDjHMlX1+10ACxES1bGs/Xm4IZZKxED2K2I=
X-Received: by 2002:adf:a1c9:0:b0:37d:498a:a237 with SMTP id
 ffacd0b85a97d-37d5519880cmr109736f8f.8.1728587227488; Thu, 10 Oct 2024
 12:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010184556.985660-1-martin.kelly@crowdstrike.com>
 <CAADnVQ+=eb7V6EYYZXghOCqYHcuP4=uNL2DtVghK-7WOHJa0Jw@mail.gmail.com> <e4207aaa1cfbb00b3cb73d2a77c04623ca34a40b.camel@crowdstrike.com>
In-Reply-To: <e4207aaa1cfbb00b3cb73d2a77c04623ca34a40b.camel@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 12:06:56 -0700
Message-ID: <CAADnVQ+CkMuDx6oheKABR7esjeo-A=szAOLM-0MbaJnfTsqZ5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: update docs on CONFIG_FUNCTION_ERROR_INJECTION
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:57=E2=80=AFAM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> On Thu, 2024-10-10 at 11:54 -0700, Alexei Starovoitov wrote:
> > On Thu, Oct 10, 2024 at 11:47=E2=80=AFAM Martin Kelly
> > <martin.kelly@crowdstrike.com> wrote:
> > >
> > > The documentation says CONFIG_FUNCTION_ERROR_INJECTION is supported
> > > only
> > > on x86. This was presumably true at the time of writing, but it's
> > > now
> > > supported on many other architectures too, so drop the part of the
> > > statement mentioning x86.
> > >
> > > Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> > > ---
> > >  include/uapi/linux/bpf.h       | 3 +--
> > >  tools/include/uapi/linux/bpf.h | 3 +--
> > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 8ab4d8184b9d..a2ddfc8c8ed9 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -3105,8 +3105,7 @@ union bpf_attr {
> > >   *             **ALLOW_ERROR_INJECTION** in the kernel code.
> > >   *
> > >   *             Also, the helper is only available for the
> > > architectures having
> > > - *             the CONFIG_FUNCTION_ERROR_INJECTION option. As of
> > > this writing,
> > > - *             x86 architecture is the only one to support this
> > > feature.
> > > + *             the CONFIG_FUNCTION_ERROR_INJECTION option.
> >
> > Something like this is good to add to
> > Documentation/fault-injection/fault-injection.rst
> > and may be a link to it somewhere in Documentation/bpf/.
> >
> > But uapi/bpf.h is not such place.
> >
> > pw-bot: cr
>
> Would you prefer to just remove the sentence altogether? Currently,
> this statement is already in the headers, so I think it's best to
> either correct it or remove it, but not leave it the way it is (which
> is not very accurate).

I say let's remove the whole paragraph then.

.h already says
"It is only available if the kernel was compiled
 with the **CONFIG_BPF_KPROBE_OVERRIDE** configuration
 option,"

which in turn depends on:

config BPF_KPROBE_OVERRIDE
        bool "Enable BPF programs to override a kprobed function"
        depends on BPF_EVENTS
        depends on FUNCTION_ERROR_INJECTION

No need to duplicate kconfig dependencies as a doc in .h

