Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC440BAB5
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 23:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhINVtz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhINVtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 17:49:50 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD6EC061766
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 14:48:32 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y13so1241285ybi.6
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 14:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YXWogIdh/txnNWc6oERhuIkhZVVMkjfmrjd10bME58M=;
        b=bVuod73QLbjlZj9AEBbg3SPpRDmMYC3g5HYrWMNCmlA+yr/s5V576FJ0RUJ/QR9htg
         uqv0oC1hVcSa7pzSfwveHiA5IQ5oRBjSH6ZIE/HS84pmNhO8KLkfCO43LvbCpEsd0yHN
         hYxi3DeVVTkQz8tP3Cm1dAYUg4fP6gcoEuGvn16IxFq5JjayGtTwO3KWRWQWLm6dWYFQ
         wKQx/Wg2+Mu+6ybBjogdPeGn5qW3vl80hfFJz5jhXrgurxr0NZxu+Ik90Zz9KLAvyOhv
         AOJ7ACREDEVAshFr14C4WqNGcF170Aw1vvPiiQEz5WylxvxLh31KR6Prl+1xIfyaWr0j
         l3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YXWogIdh/txnNWc6oERhuIkhZVVMkjfmrjd10bME58M=;
        b=5IkASBzkZ2dqrRfPTqb82XE/cPM1BidoYYmLX+S6P1ZLRFb8Auz8KGC4nyImlzYqJZ
         TiflBCvtvpxUKo41q8SJSkGvrfASPnZpi4X8cnMGQdN5rCGKRNMQi1S2zEj0AhWpGF2H
         b/zA1MfLlZiwkMOKB5RwbG+SoikBhJh58ufBcvHejqJRCBZtcdQYPdX4ywK4DDoXKgiI
         ldxFaRCn7GBKG9Aq8u0YSBzqVgjQRyzzaXJWLAujkkQWwUZL4a+hqqHXz3lhee+Ynkhz
         LFQUR2euesJva3upjvEkg8CtTKZRDY25T0RFYRTRWSFQLRibAjWyrCepFFSVTPdjPE8i
         4OcA==
X-Gm-Message-State: AOAM532m64hYG84kt9aAeBVEXUbrEZc6zBinTjbQc6SAFx2KG27npO+U
        v9q1Q3OtG43sOEMAg8TOB/vDyCcZlSgLbschm1y/I90Z
X-Google-Smtp-Source: ABdhPJyy+U6q/u9655xBBJarNtR3daMqHmX+4ZNuC6SG6+geQvTiviXw87EA/OswjxGhvtOTqEMOkDED04ezLurR2yA=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr1888713yba.225.1631656111997;
 Tue, 14 Sep 2021 14:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <7500F71C-79CF-449C-819E-7734B6B62EA5@gmail.com>
 <20210914213554.2338381-1-rafaeldtinoco@gmail.com> <4B1531CC-63FE-4D22-8645-9EDB666F2707@gmail.com>
In-Reply-To: <4B1531CC-63FE-4D22-8645-9EDB666F2707@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 14:48:21 -0700
Message-ID: <CAEf4BzZW5L7bfwBwzoQpx8=LygaHepYDh9Ou8TmPhZJa_HZvPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: fix build error introduced by legacy
 kprobe feature
To:     Rafael David Tinoco <rafaeldtinoco@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Yucong Sun <sunyucong@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 2:39 PM Rafael David Tinoco
<rafaeldtinoco@gmail.com> wrote:
>
>
> > -     char cmd[192], probename[128], probefunc[128];
> > +     char cmd[288] =3D "\0", probename[128] =3D "\0", probefunc[128] =
=3D "\0";
> >       const char *file =3D "/sys/kernel/debug/tracing/kprobe_events";
>
> I had gcc-10 with:
>
> libbpf.c: In function =E2=80=98poke_kprobe_events=E2=80=99:
> libbpf.c:9012:37: error: =E2=80=98%s=E2=80=99 directive output may be tru=
ncated writing up to 127 bytes into a region of size between 62 and 189 [-W=
error=3Dformat-truncation=3D]
>  9012 |   snprintf(cmd, sizeof(cmd), "%c:%s %s",
>       |                                     ^~
> In file included from /usr/include/stdio.h:866,
>                  from libbpf.c:17:
> /usr/include/x86_64-linux-gnu/bits/stdio2.h:71:10: note: =E2=80=98__built=
in___snprintf_chk=E2=80=99 output between 4 and 258 bytes into a destinatio=
n of size 192
>    71 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL =
- 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>    72 |        __glibc_objsize (__s), __fmt,
>       |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    73 |        __va_arg_pack ());
>       |        ~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> locally AND it fixed the issue for me but Alexei reported:
>
> https://github.com/kernel-patches/bpf/runs/3603448190
>
> with a truncation of max 258 bytes. I raised cmd size to 288.

Right, if offset !=3D 0 GCC is able to deduce that sizeof(probename) +
sizeof(probefunc) add up to 256 (plus few more characters in format
string) and that will be truncated in cmd. It completely ignores such
possibility when offset =3D=3D 0 and we use name as is. Either way, I
bumped the cmd size to 256 and force-pushed. It should build fine now.
Sorry for delay.

>
> Let's see if that fixes the issue.
>
