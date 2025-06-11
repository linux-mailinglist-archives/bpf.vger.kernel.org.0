Return-Path: <bpf+bounces-60291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB585AD48DA
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 04:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916FF189D361
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 02:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5157717A2FF;
	Wed, 11 Jun 2025 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ0Y6kBW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33445286A9
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749608767; cv=none; b=OWCptSx7gEkABpUU1MtSiDPB5J+nh+xAXCk7xKv4SLz7o9+Id6S++0vcWmTxmbFep9xAUGJTo0OkoUnLiDS4tvi2I4f0n5zI1JP9dG1qMvKJN4bqAf5yUYee/laHebzv7z2+DGb7EaFtAmMKtaDG2lpyXaLxqvhHDyCfuB3p2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749608767; c=relaxed/simple;
	bh=qQoLmwXtNHxR/vKrQ4fY3ozpz2mEUrpd59j5sbNdACc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpBTpw7he9Jl68BuksP8SYUulHDeTEUAVqlZsczAM4Xtg3DlI/s27EFnO0erRHGHHGygY3eWPU5oiUr7iVZM5SYq6OYvNs/IGbacp05U0CZyIjOVs/KEQf7lFtPi0nKjixREr1YA7h0zwKlIzeHGwBUgoZ3jhzPWQaieYzmJz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ0Y6kBW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54690d369so2550331f8f.3
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749608763; x=1750213563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfGyI8lm2/tzUihr+EPhjizt+9EWVURIdLSqDn3iQS0=;
        b=FJ0Y6kBWBdFyPKg1ZoWNgY//sCvjT/BJSduVCSRy91tuw+6RWPOOvPhDK4swyGKH1X
         tA7+CSJBju96GiezsNLp1hVp5MzxKiqH0jpGRwrvDe3xRYVDOs4eOTdR9ZUGh1vLK88D
         DnojIk7xbb6ZEzgyB1zw7IQxKMBL0+d+gBtgAbOURjeCl5MWC1wRCketwtHHtSQewIx7
         XnRFLZSn/zjDzqrq9JH5mbGYswoI4P15Yjdx1VgHDp+tBoZtcA59j3hDSmrAhNCVO/6I
         Yn4Fm7YkS7430DAWedwbn9ebVN539TO9Hb9Y0x1FaTwmR55YCgWeI5bthD2chV3iB2LS
         j3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749608763; x=1750213563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfGyI8lm2/tzUihr+EPhjizt+9EWVURIdLSqDn3iQS0=;
        b=WRssw5BeFbZymoYg/PPw5nLqtM1EB8HfB1lOZC3RrnG9sroBcEwfZbt4ytnLyUW1/X
         1ZcLUnpYBO+gO5SHcosCFQ8LU3ko0N4/je0iIwuFoeLh/NmF5wu53T/jBguC9oanQY+N
         AKUlKqDvoJZ5yE04b/oKZ37hs/85AibvCvN9Knoibox6ZSz++Fl8Aumb9vKMT6CkbH0e
         Sjab2aFH4diCPCxe0kGXhvKl4YmbP0orH2xfn3eM/cqmdWmeDq/U6N3EnoSGvxviQjKl
         4l5MJMXUaidRGzRr/ZIDmzZV/+QeHaFEyQfQuAFUDQyOCIlOAtgQaag6gGTOOMKhjnoD
         oEcw==
X-Gm-Message-State: AOJu0YwoJknNn0adTH7uG0U4NIlyaxXUaAP4Hd05H3+i/7QoIilsfypn
	JRIT1Aa+s2+JnlEO8Qkv+2tVYpDJt/ENOGPWQ8b6T32q7GEZtousQpfC4FEIL6sTVw+YucCgakp
	BPxOYs1wmOmwMVLMDIVcy9/0iX7SIP31YZg==
X-Gm-Gg: ASbGncvFt4T4nJHhL9p029f0UoikHs1cpZ4ggicEuNXNFCs3frJpj8CfsU1hxmntnnW
	YVWwS1In86LlrT9Fi/KZ4w3mlLwCnJQXhefC1azW/GdtY09GV8RM8QwT0vUsEHEpLopot7FQg9r
	MWANnVdC6J6cxFRywlOebB67jNGLaj/tRhZidemMw7O6v2nZRDBzPuc70IbUs9Gk6cZ0g2P8z8
X-Google-Smtp-Source: AGHT+IFSdsGdtwD7pz8INw/m1yUNVDtukoawrcdPdoY3WI/e3Ukmlpi/Ec61CuxAbfl/NsCzWZpqWpsQQtAvLMpiF7o=
X-Received: by 2002:a05:6000:4028:b0:3a5:287b:da02 with SMTP id
 ffacd0b85a97d-3a558a3138dmr849863f8f.40.1749608763284; Tue, 10 Jun 2025
 19:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610232418.GA3544567@ax162> <CAADnVQ+jNQyC=RcoiwDXeHj9y6CGzr322scz_8uGwCDVx-Od4Q@mail.gmail.com>
 <20250611020522.GA3981304@ax162>
In-Reply-To: <20250611020522.GA3981304@ax162>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Jun 2025 19:25:52 -0700
X-Gm-Features: AX0GCFvkcjZRnP7xpZYc2JrdqH6YzuB8ObJQ6ArvSdla8G5K0SFXWkviXJE56sI
Message-ID: <CAADnVQKTGgBGgqfVsDGxijuL1oVkBOhmgx+0XQ+VOL4wLoVKYw@mail.gmail.com>
Subject: Re: bpf-restrict-fs fails to load without DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 on arm64
To: Nathan Chancellor <nathan@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 7:05=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Tue, Jun 10, 2025 at 04:37:24PM -0700, Alexei Starovoitov wrote:
> > On Tue, Jun 10, 2025 at 4:24=E2=80=AFPM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > > I was able to figure out that enabling CONFIG_CFI_CLANG was the culpr=
it
> > > for the change in behavior but it does not appear to be the root caus=
e,
> > > as I can get the same error with GCC and the following diff (which
> > > happens with CFI_CLANG because of the CALL_OPS dependency):
> ...
> > > -       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
> > > -               if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CA=
LL_OPS
> > >         select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> > >                 if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
> > >                     (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
> > >
> ...
> > That's expected.
> > See how kernel/bpf/trampoline.c is using DYNAMIC_FTRACE_WITH_DIRECT_CAL=
LS.
> >
> > Theoretically we can make bpf trampoline work without it,
> > but why bother? Just enable this config.
>
> As I note above, this is incompatible with CONFIG_CFI_CLANG, which is
> more important for my particular area of testing and maintenance. Since
> you note this is expected, I will just go back to ignoring the warning
> in my kernel logs :) thank you for the quick response!

Somebody probably needs to fix CFI_CLANG on arm64 then.
It's not clear to me why dynamic ftrace has to be disabled in such a case.
It's not disabled for CFI_CLANG on x86, right?

