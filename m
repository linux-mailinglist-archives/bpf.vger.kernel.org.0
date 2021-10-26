Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8BF43B1C7
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhJZMG0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235137AbhJZMG0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 08:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bbLnbRSwhQhs8N5RIiGSM3VgajNsI4V0GezJnyOJpM0=;
        b=ERD7tT0lUcsgdDioAlbwPTZYJD1QuS4GRnUEDgm8xSTaGLwjFsGdIwpiBl0C+E0FfSY+vy
        lqbswtai2piOK/aqEwTRxMo08QBRonTQKhIisgeFAK/Vb0ONupIP0gKiRj+TOfDUbkFxso
        rzCjahEvg2b6JNPGSUP5vYuFzjY2nJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-ta5oZ3XcOcKf6uOFHcL-Xg-1; Tue, 26 Oct 2021 08:04:01 -0400
X-MC-Unique: ta5oZ3XcOcKf6uOFHcL-Xg-1
Received: by mail-wm1-f70.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso901095wml.9
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 05:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bbLnbRSwhQhs8N5RIiGSM3VgajNsI4V0GezJnyOJpM0=;
        b=glOq9UxG1cMJdQFqzz4WD8RpmWH9/VRkkOpI0OK2SSPdBG87wYGL3FkO54C+6zsW3N
         iAloLWXaACU2GTXNyoXd8GDmfJ+l3W68tw007zIHFzwDrbk3rG2LdgB0prB6TlyPTNym
         M7vBFKi+f/3RTl/HGSK45zxFp5eWxmhxRpJbCbtZ991xdiCSv2eM4N1NeCcAJG1jzHXT
         Ys9+puv/wZR4Xhrl0lInjVN4UbWXa5/UjFvnJEgDEypAu9nB/K7uwSrQ0K3QO9OuHdlI
         VTShATHO3epYIx6MRZ4zRvJf/5qlwze7wjVR9fX1ZJOCt6Z26gOIqPcJDNFibiMrN3iT
         1PMg==
X-Gm-Message-State: AOAM532UHYHjFJyALMdzchef1wYtx0v8Wl5pskOWV0WE4gnjIgTiqeor
        tz1gnZEILXwViONADgTmfeek9PlmMi4opWFD1/FmIkBbjWkTpHBLeUHqjlrNdpKtC0y2+eZJSgq
        mkKs7TvVl7KXc
X-Received: by 2002:a7b:c858:: with SMTP id c24mr26221209wml.171.1635249839698;
        Tue, 26 Oct 2021 05:03:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJvjKDHPGbMGVwdOiYPfUuiFmMZo0qJ4BKiGjBexd8LXhhl4CNtK3HD5jILfUUiEVdnHUjlQ==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr26221177wml.171.1635249839393;
        Tue, 26 Oct 2021 05:03:59 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id f3sm428348wmb.12.2021.10.26.05.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 05:03:58 -0700 (PDT)
Date:   Tue, 26 Oct 2021 14:03:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next 1/2] kbuild: Unify options for BTF generation
 for vmlinux and modules
Message-ID: <YXfurV+mNr0daiz9@krava>
References: <20211023120452.212885-1-jolsa@kernel.org>
 <20211023120452.212885-2-jolsa@kernel.org>
 <CAEf4BzZimh+OotN3gWR=E-eCGzxFYm7rM8jbgAMy7HRCYpKnNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZimh+OotN3gWR=E-eCGzxFYm7rM8jbgAMy7HRCYpKnNw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 09:56:37PM -0700, Andrii Nakryiko wrote:
> On Sat, Oct 23, 2021 at 5:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Using new PAHOLE_FLAGS variable to pass extra arguments to
> > pahole for both vmlinux and modules BTF data generation.
> >
> > Adding new scripts/pahole-flags.sh script that detect and
> > prints pahole options.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> LGTM. I suggest posting it separately from the BTF dedup hack.

ok, will post today

thanks,
jirka

> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  Makefile                  |  3 +++
> >  scripts/Makefile.modfinal |  2 +-
> >  scripts/link-vmlinux.sh   | 11 +----------
> >  scripts/pahole-flags.sh   | 20 ++++++++++++++++++++
> >  4 files changed, 25 insertions(+), 11 deletions(-)
> >  create mode 100755 scripts/pahole-flags.sh
> >
> 
> [...]
> 

