Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212152DAAD5
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 11:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgLOK03 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 05:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgLOK0X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 05:26:23 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FF0C0617A6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 02:25:43 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id z136so19964688iof.3
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 02:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYwvHC1fHXXPxgQTJYlzDLgaAZWSso9gRqg6NnmZgMU=;
        b=Ej6Tf3+a/k0GN71pJhkruSgx3zKjuenT6kxe49HM5LcgswLynVKKA7iZjhYbDUgaWu
         dM/FavFAn6Lk5dTPKzYxurGA4Wxje1xu78DusJ4U0YgPb/RNw0KfnheG2FIEfgd2lOWz
         cG8Ywc+iU4LwSGgJJbny+yOuXaww1UgVEnFL9kYAMoiRcMduznHGtHfloTHVYKFhaQaS
         wj1DOJu3G57YmWGsZkDP5u0CDFlMDnxz7FUvgRAfxfsxkT3/j1hrdRzxw8i7Lr6ZEFlL
         iZg2tXoxdK/Izh/63BsCqfc2IU0ZwQOBHYAwkgJDHH7TC7dNFNvXcG+IU4q3pq/ucETo
         MLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYwvHC1fHXXPxgQTJYlzDLgaAZWSso9gRqg6NnmZgMU=;
        b=TS1j5PxjUFE1s6sYfG2O0IjKhMqD/weADyl93Q+5nsBVYr+al8fdnTEksw9ACqi2Hn
         L9jsAFtCzLWg1UqOqGf6U/zn5hYs/Lx8pFGTxe5+okXvGpSt4zUtR1LR3K6B6mX0YGMs
         lxS2cHk8ZLScZreleAAlLeZxjvivTMOCnlHiJUUua5cLXHQ3iCH5mG0WapKrdqup7BZb
         6Qkgb3YVkPwZrUX1+XEkD3efaVtAAqZLdgxmj/RnSpg4xt0uSy55hxtXe5VO4vGXjCdN
         PmxFakULpu47Jv6/tyvBYV78JDCjhTl8Qxv05hAKaXqanQfBDJ34iX37DZNCq2vdx+az
         b5rA==
X-Gm-Message-State: AOAM530O3cZlCSmPm5So3KtDn6h7b3jxyezbTzrLWVrhHeEdCb4X/JYQ
        09uLgxSSuik+E9+8GMCggoRipkdhV8FwD5WdM7B4nA==
X-Google-Smtp-Source: ABdhPJwk3hKxRWkNXLPRXqtWttXwYAH9yfuF2x1Afy2F3Msh19zJ+74RV4RRCsOGnUfS1hciR9Bww6+cKnvQxn5WCsQ=
X-Received: by 2002:a02:488:: with SMTP id 130mr38391350jab.39.1608027942821;
 Tue, 15 Dec 2020 02:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20201214113812.305274-1-jackmanb@google.com> <f19112d6-7ee7-f685-b203-e0961a246b80@iogearbox.net>
In-Reply-To: <f19112d6-7ee7-f685-b203-e0961a246b80@iogearbox.net>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 15 Dec 2020 11:25:31 +0100
Message-ID: <CA+i-1C0zySfk-bmUcZZWpyVGH3Bt99WOXrd6fsQkx4+cbUDyZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Expose libbpf ringbufer epoll_fd
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 14 Dec 2020 at 21:46, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/14/20 12:38 PM, Brendan Jackman wrote:
[...]
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 7c4126542e2b..7be850271be6 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -348,4 +348,5 @@ LIBBPF_0.3.0 {
> >               btf__new_split;
> >               xsk_setup_xdp_prog;
> >               xsk_socket__update_xskmap;
> > +                ring_buffer__epoll_fd;
>
> Fyi, this had a whitespace issue, Andrii fixed it up while applying.

Sorry about that.
