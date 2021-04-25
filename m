Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E136A87A
	for <lists+bpf@lfdr.de>; Sun, 25 Apr 2021 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhDYQxE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Apr 2021 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYQxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Apr 2021 12:53:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47193C061756;
        Sun, 25 Apr 2021 09:52:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n138so84830298lfa.3;
        Sun, 25 Apr 2021 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EB1M0gWo0xUwH/H5pRRZr/jjgjnHFpq4HP5/7TLgquw=;
        b=mKfL7XBbPUgpXuoeT+M8J5UA00y9KDHkBBlyJDTRIGF18oMS4QFwLiEW4qQrpeL7aA
         kSuh5AQKpTcn5fkeippGQS7dy7rt5+b/QIoYBtnwZn2LsaCybLc3Pa9/m+ft6cQKnL6r
         ioSqz0KVxR9XhsPoTqNJbYRtVIWqPfqhXN9RujBMqJpf4FOxO9ymoLQk/M9EVc8oWJFD
         azY0/6SjJSfaEuiFxYla8gU9/yzf98eG1DDrSurrTt6bciE0gEfTerFKPaSh3B/qBYGy
         PdaWbAK6V3oyjW+i2ia8krlH7aTwKPzr8xylNMrcEXe/6B+nicTWobw6ArD05/6A1TSR
         uxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EB1M0gWo0xUwH/H5pRRZr/jjgjnHFpq4HP5/7TLgquw=;
        b=sedIqK9NhfJwuSVeP9WyWWSrqn/qLgYGUKFshTQbka1VMa9ZzKsagYmcHyre222KFR
         1rtH/ofdO+DyXmHyCFsgv1qMb79dUcCRplnYoczxRYe1HhoBaAxc4am0laWC5/E0Wqbq
         Bh4DL7P3F8swVvQ1fFm/7dXHMFoa8S3++YHK5+N9LA3HTMus2MuSfgjDjtCLyruZY/dJ
         3yRVcy7Ljcr+TuC0fSw5nMfb4kLmZN5zbKhA84SqJ7oxeq/T4vhvYIOTfrOX0rgMofXN
         uRR479U6e0kbAmJFjBtZBNi0UoFAdjlm0b0TrKO8qCIXudtSvrKWs4eY1X7OxGxdNK4R
         2esg==
X-Gm-Message-State: AOAM5334c634n4zVS0KZpWuL874wW4lL4bw4iXR81tSdT9PVSCGp9VVb
        o7ySwW+D64ZFQytZMdRW+3TMmfl9nVfdbyrUriU=
X-Google-Smtp-Source: ABdhPJxyKCSLAn2xg/0qj+PERrbhg57bibRrpgyu2+FdeamRpnAVVz+6UeBZD+v1w1V4KlK02GEyZcz75ouK5KpNtEI=
X-Received: by 2002:ac2:510d:: with SMTP id q13mr10060117lfb.75.1619369542791;
 Sun, 25 Apr 2021 09:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com> <56932c68-4992-c5e4-819f-a88f60b3f63a@gmail.com>
In-Reply-To: <56932c68-4992-c5e4-819f-a88f60b3f63a@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 25 Apr 2021 09:52:11 -0700
Message-ID: <CAADnVQJU=r0qE-4ZHsvX4YndbFgDGvzAgNgVo7kPMGF4jCrVeg@mail.gmail.com>
Subject: Re: [RFC] bpf.2: Use standard types and attributes
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, libc-alpha@sourceware.org,
        gcc-patches@gcc.gnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 24, 2021 at 10:56 AM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> Hello Alexei,
>
> On 4/24/21 1:20 AM, Alexei Starovoitov wrote:
> > Nack.
> > The man page should describe the kernel api the way it is in .h file.
>
> Why?

Because man page must describe the linux uapi headers the way they
are installed in the system and not invent alternative implementations.
The users will include those .h with __u32 and will see them in their code.
Man page saying something else is a dangerous lie.

> using uint32_t in every situation where __u32 is expected.  They're both
> typedefs for the same basic type.

That's irrelevant. Languages like golang have their own bpf.h equivalent
that matches /usr/include/linux/bpf.h.

> I can understand why Linux will keep using u32 types (and their __ user
> space variants), but that doesn't mean user space programs need to use
> the same type.

No one says that the users must use __u32. See golang example.
But if the users do #include <linux/bpf.h> they will get them and man page
must describe that.

> If we have a standard syntax for fixed-width integral types (and for
> anything, actually), the manual pages should probably follow it,
> whenever possible.

Absolutely not. linux man page must describe linux.
