Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8735FE18
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 00:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhDNW6n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 18:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhDNW6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 18:58:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4461FC061574;
        Wed, 14 Apr 2021 15:58:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id x76so13963889ybe.5;
        Wed, 14 Apr 2021 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nV9RJgL5nqXsnEN27udq8GpkpJZtoA2KkXDX+mgAJY=;
        b=PPA67RnK9YC3zRliV29IsSpCuJwygYp0SRM2nx+35yYKGpoWjehFsK3KKUN1Yh9zSa
         nZq51wU7KbuQTMKQWHEVbL12ZhGwFopFb2vpRXQyPS3Gu9r9b3werKtWZQoaZ87H8NrW
         ydA9sBQWNVtyielhnl7x41Vzg/q0acJU9+BtBKSQiTabB8NUT16wTOeaUuNu8wcG3jre
         CE0UkvVXVUfpdaLXybxE+GFX9LWmfE3vpsBklcnfVxwatkzaiyMIXePTUQBzNJrnqsoK
         nSLYHDL9yA/VvXuJKry5dvTMSB3mWkX7VM70zWSkpRsiZkWUbP7OnmlFBCN2KwXbxpPW
         o+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nV9RJgL5nqXsnEN27udq8GpkpJZtoA2KkXDX+mgAJY=;
        b=Gah/P8nk688O9Pl/sOaSuKpcJuLo/ABWTrk7NboB6XoUpJy83vksDOweWF31ae1/CS
         eKIGHVV2BGL6mKgDdUcegfRO6vQw2mT1TOb62jqBz3cx2Dq976fPbPX1s+Fx0P9y0I0G
         xspEglZUfjjLgpcKphzQwtPfLx+0N1j9Ci18SzUyPPg/F/bBrK0pHlEGxAutptt50WiT
         h9lEiNLY1pvbzIuIiAkDkZOcfs9sA7wz38DepA/u8q+tA2rM/OQwDgFdChu3PTuS5ife
         3JURZX0jyGZlqrpWglr7lSmynplJR0LG0WEnqOpL9p//hq9RhOaBdvF1YcXHvRzU8a10
         TuMQ==
X-Gm-Message-State: AOAM531L5KpmzTRBbD2QtPRx5nf1ktL8RLja2fzZQ8ETbon6a8xmAiMX
        Od7qlTUoI0VvbJzFNRF37aoeECCx/3p9hLwN84Y7Dpc7
X-Google-Smtp-Source: ABdhPJxOiIxHYYbXAdEgVJq8tYasGNaX8qVpxDEUOJiQrMaLbutVxJNeUJOsv3nCvC8aYf5jN2k4Sqj+TplXonSCqJk=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr400676ybf.425.1618441098570;
 Wed, 14 Apr 2021 15:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
 <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
 <CAMuHMdUQOi8h31D_Qtnv_E1vsEu6RO8sHy-DArQ0jQt5v_JoVA@mail.gmail.com> <CABRcYmK597zCNs_ay6BUjxCuxGJazKn4iujYtOUxcZC0J=xVPg@mail.gmail.com>
In-Reply-To: <CABRcYmK597zCNs_ay6BUjxCuxGJazKn4iujYtOUxcZC0J=xVPg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 15:58:07 -0700
Message-ID: <CAEf4BzbROOSi8PfM2c-BR31S-=aQjVgfzTAPaCqntcjjQb1W=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
To:     Florent Revest <revest@chromium.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 11:30 AM Florent Revest <revest@chromium.org> wrote:
>
> Hey Geert! :)
>
> On Wed, Apr 14, 2021 at 8:02 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Apr 14, 2021 at 9:41 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > > +       fmt = (char *)fmt_addr + fmt_map_off;
> > > > +
> > >
> > > bot complained about lack of (long) cast before fmt_addr, please address
> >
> > (uintptr_t), I assume?
>
> (uintptr_t) seems more correct to me as well. However, I just had a
> look at the rest of verifier.c and (long) casts are already used
> pretty much everywhere whereas uintptr_t isn't used yet.
> I'll send a v4 with a long cast for the sake of consistency with the
> rest of the verifier.

right, I don't care about long or uintptr_t, both are guaranteed to
work, I just remember seeing a lot of code with (long) cast. I have no
preference.
