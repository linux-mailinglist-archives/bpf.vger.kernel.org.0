Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB54231F963
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 13:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBSMY6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 07:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhBSMY5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 07:24:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EBC061786
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 04:24:12 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a22so19201003ljp.10
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 04:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHrYkCK1zLRD6wByIwlBLFI5CiL9tLM6cLoCKLmdSfI=;
        b=f5UVscClc1+dxFKiSTb8GrmugqWtOiZ6ciLfydsqvbi99dBTBjorDFqJxkYoWViwZD
         P6ASCmD4/Vpg1ph9hfJuG7LUAkj76GXyJbONNkZrCxxCcDh5UOc/gfCQHeWSUatEBUKT
         VU0rheK34iG4itgCQE1tCMbDk819CRQol7y0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHrYkCK1zLRD6wByIwlBLFI5CiL9tLM6cLoCKLmdSfI=;
        b=ga+L5rn4FVWlWPClUkbNhYwsle8mfGM92e32lOwA6zo7CwurQ8PE/aoaPex4MwhwgO
         dcImME+fL6hXA7bXzNIy64ZMslPw2esuDPLHMib4PGTsmcw309FZB4YoKrgItc9FyML8
         M3+l/aiTjxn37iDTiPEx9RkKMEC9fCXjOXb4m6k/NflLHiFwl0kKEqwWSLqBzRWqG0Bj
         7eOLEsjUug4u3HGCvX8A4xzl/SviRSAMjXCmVS4ewyypSyS5p+ZmYcyxs07RLGoV7x73
         LNHeFOmjzLpBSb2ej5xAeN84qQ5YwcUlllFcSFkH8Bre9TE3IlTHcrnUh0j4UFd0Bjd7
         kQJQ==
X-Gm-Message-State: AOAM533Im+/uSlGZ7UErBccc9W/jt4igUR6sCB6llMwxVh2SI47LszbT
        RgdQWIzJ8eKPI6otTsrQ7iBFTpWmlOo4D4hbrEJvTQ==
X-Google-Smtp-Source: ABdhPJwwyMd6Srv1DZ/UHrUroAn7W8bc+ka6yIQG/53X01Z8QDbMzTzc7XlBvAdwOD6l4D+anWou6oFsLd5xyaNpb3c=
X-Received: by 2002:a2e:8846:: with SMTP id z6mr210646ljj.376.1613737450639;
 Fri, 19 Feb 2021 04:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20210219095149.50346-1-lmb@cloudflare.com> <20210219095149.50346-2-lmb@cloudflare.com>
 <00f63863-34ae-aa25-6a36-376db62de510@gmail.com>
In-Reply-To: <00f63863-34ae-aa25-6a36-376db62de510@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 19 Feb 2021 12:23:59 +0000
Message-ID: <CACAyw9_kY9fPdC5DLz4GKiBR8B4mCCnknB2xY1DSKYwkridgFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] net: add SO_NETNS_COOKIE socket option
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 19 Feb 2021 at 11:49, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> > +     case SO_NETNS_COOKIE:
> > +             lv = sizeof(u64);
> > +             if (len < lv)
> > +                     return -EINVAL;
>
>         if (len != lv)
>                 return -EINVAL;
>
> (There is no reason to support bigger value before at least hundred years)

Sorry that was copy pasta from SO_COOKIE which uses the same check. I'll
change it to your suggestion. Want me to fix SO_COOKIE as well?

>
> > +#ifdef CONFIG_NET_NS
> > +             v.val64 = sock_net(sk)->net_cookie;
> > +#else
> > +             v.val64 = init_net.net_cookie;
> > +#endif
> > +             break;
> > +
>
> Why using this ugly #ifdef ?
>
> The following should work just fine, even if CONFIG_NET_NS is not set.
>
> v.val64 = sock_net(sk)->net_cookie;

I looked at sock_net and didn't understand how it avoids a compile error
so I didn't use it, thanks for pointing this out.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
