Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7073994A3
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 22:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFBUjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBUjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 16:39:12 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905F0C06174A;
        Wed,  2 Jun 2021 13:37:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g38so5611263ybi.12;
        Wed, 02 Jun 2021 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9aHYoO59eRyQ7Fly6N3dGAwZibkeW7kt/2A0ssudiV0=;
        b=rgA35ImxzKGrqsJlHwMUs5sQ58usTZHWqCxcsN/JgtcW1SjRxNPHrK38lSxidpp+LR
         FxR1256tznlCzgDcOXAdnnmyt5NSHJDKoMPo4P+U/Cde8QGN7zYyItsxd1jdMskuDu/4
         ANwIV/WFzBU53G2L/gSqa/9GhXpakRCFLeboRt1zTVxA/9kZM+sGIQ0x4cO49q1lSa1p
         pUw+YLyzATmxcsGYpXoTkLBjWLBzy22bZkD1TZetKoW6IV8hU6fnFXOQpiK09+7ibXVt
         v01NZbziTCkRCSSf+r5JU7/jDdc6K4Ng3KQtLtb4Cqm9ItCct91iRbLmD2GXzg4SPCNp
         +nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9aHYoO59eRyQ7Fly6N3dGAwZibkeW7kt/2A0ssudiV0=;
        b=KEZ5a9NMF+xaJNLVyTpEjgTiCqTd4mTzjcWOOLKkazXT99beILxV4bNh7sQU8Wzmkd
         TVjU0LWws6cXFGQLgVDDOAKeqfD+r7o/NgoKYxftcK2K4IfTL7hSoMDXTa8lgSqzZZTB
         yjciQ0Nh5wXDtkjcxGNrasPo8qvPCBT/ooKxtFCiXXQZuRVO49f0PhOhYv+UNqgrUl28
         kBxM23F0PDINhOOwrixCPhsH5lif34UyuBGXp1FxTaKW1ylK8AMGxJvnw0rcCa2cZW1U
         8a6LRBhTlazjLNzf+6mC6FgARutXMifZoVotwso9BmOpO1ul9qo/2fC/NZKBe+DmAuo5
         vZsA==
X-Gm-Message-State: AOAM532xllBt/tMif5kuwVX+epStv47p3bjd9LmOIiEA0bMxuF0G6jsL
        d81cHIBPvm/EvnyNsAKdhYlC+ydZme7QnUi0Z+pZR72DXRA=
X-Google-Smtp-Source: ABdhPJydig8/g4JqAhoPMag0TDq502migzV4TKzgVUBA/blZ2IlpaV0nc+OpHXoH7UJWBWJPwbsZM8HTftOGOn7eyPo=
X-Received: by 2002:a25:9942:: with SMTP id n2mr51468820ybo.230.1622666248889;
 Wed, 02 Jun 2021 13:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210531195553.168298-1-grantseltzer@gmail.com> <871r9lbef0.fsf@meer.lwn.net>
In-Reply-To: <871r9lbef0.fsf@meer.lwn.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Jun 2021 13:37:18 -0700
Message-ID: <CAEf4BzahgzHg_Rzntxag-XQViVSG4H0XGLErq9agQ4qS0JL=7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Autogenerating libbpf API documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     grantseltzer <grantseltzer@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 1, 2021 at 11:58 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> grantseltzer <grantseltzer@gmail.com> writes:
>
> > This patch series is meant to start the initiative to document libbpf.
> > It includes .rst files which are text documentation describing building,
> > API naming convention, as well as an index to generated API documentation.
> >
> > In this approach the generated API documentation is enabled by the kernels
> > existing kernel documentation system which uses sphinx. The resulting docs
> > would then be synced to kernel.org/doc
> >
> > You can test this by running `make htmldocs` and serving the html in
> > Documentation/output. Since libbpf does not yet have comments in kernel
> > doc format, see kernel.org/doc/html/latest/doc-guide/kernel-doc.html for
> > an example so you can test this.
> >
> > The advantage of this approach is to use the existing sphinx
> > infrastructure that the kernel has, and have libbpf docs in
> > the same place as everything else.
> >
> > The perhaps large disadvantage of this approach is that libbpf versions
> > independently from the kernel. If it's possible to version libbpf
> > separately without having duplicates that would be the ideal scenario.
>
> I'm happy to see things going this direction; it looks like a good start
> to me.
>
> Let me know if you'd like this to go through the docs tree, or feel free
> to add:
>
>   Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks, Jonathan! I prefer to take this through bpf-next, which will
make it easier to keep it in sync on Github (if we do that, of
course).

>
> if you want to route it via some other path.
>
> Thanks,
>
> jon
