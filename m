Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0236031F
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhDOHTA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 03:19:00 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:34567 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOHTA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 03:19:00 -0400
Received: by mail-ua1-f45.google.com with SMTP id s2so7220196uap.1;
        Thu, 15 Apr 2021 00:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYpEFy4TiS8JfXQcnDIWzjJBFSrstXrUZn7dBlSbGg0=;
        b=twCmbuKS/Jjeqc97M5GoqKHZEYetz6QQFR+i5fK7HEu2yUI1vnKx6L+Yidg/kZmndj
         McmIEZLEYa7U8FJVtgfscbUztCA9GUmtWviyltOfdDFmuQ5RRBDLXdo/jRCJ0O3eOmwp
         3ta+CL82FL3W4qAhTleYZG+d3gu0nyKMBzse4j3mxhjjJ4hr5+Igl6CLp923FVplcmvG
         ci2EBwqVJu60vuoI9c0dw52+dC0gRAsTQMeqz0Eslu8EZfQrVdzBcCf2NPi71bCCoP7y
         WgT/icfSMgPMT0Htw3LJk4Kj2R+MIcbu0AeUGOfEGAb1ePHZiJvEQkM5MOHehcP+WAUJ
         KajA==
X-Gm-Message-State: AOAM532DNwrNOWpV8pD4IjUmqrxblGuMIjcFyb2T26vTUymlR3Y2l8wx
        dUz2nmD3pmUhAHe8GImwVaeJzLarp3gp3+KAFuc=
X-Google-Smtp-Source: ABdhPJztPwJcY9Ud2yMHeeON2pYWHFlcgH92k1SmJ4Mv/fkqt/H8QcgYvYh8pCTm1dBwGoP5HEfatXBa0el+hDTFGxM=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr856492uar.100.1618471117162;
 Thu, 15 Apr 2021 00:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
 <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
 <CAMuHMdUQOi8h31D_Qtnv_E1vsEu6RO8sHy-DArQ0jQt5v_JoVA@mail.gmail.com>
 <CABRcYmK597zCNs_ay6BUjxCuxGJazKn4iujYtOUxcZC0J=xVPg@mail.gmail.com> <CAEf4BzbROOSi8PfM2c-BR31S-=aQjVgfzTAPaCqntcjjQb1W=w@mail.gmail.com>
In-Reply-To: <CAEf4BzbROOSi8PfM2c-BR31S-=aQjVgfzTAPaCqntcjjQb1W=w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Apr 2021 09:18:25 +0200
Message-ID: <CAMuHMdXQ2=xPSGxDsrprb_pXjkOaUi_YZ+8h65kdW+SYCseWoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On Thu, Apr 15, 2021 at 12:58 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Apr 14, 2021 at 11:30 AM Florent Revest <revest@chromium.org> wrote:
> > On Wed, Apr 14, 2021 at 8:02 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Apr 14, 2021 at 9:41 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > > > +       fmt = (char *)fmt_addr + fmt_map_off;
> > > > > +
> > > >
> > > > bot complained about lack of (long) cast before fmt_addr, please address
> > >
> > > (uintptr_t), I assume?
> >
> > (uintptr_t) seems more correct to me as well. However, I just had a
> > look at the rest of verifier.c and (long) casts are already used
> > pretty much everywhere whereas uintptr_t isn't used yet.
> > I'll send a v4 with a long cast for the sake of consistency with the
> > rest of the verifier.
>
> right, I don't care about long or uintptr_t, both are guaranteed to
> work, I just remember seeing a lot of code with (long) cast. I have no
> preference.

AFAIR, uintptr_t was introduced only in C99. Early Linux code predates that,
hence uses long, and this behavior was of course copied to new code.

Please use uintptr_t in new code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
