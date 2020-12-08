Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6CE2D1FD5
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 02:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgLHBOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 20:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgLHBOC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 20:14:02 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A95C061794
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 17:13:22 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y19so8692679lfa.13
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 17:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPjyKtKZAWSrnuvTIYsa3TgyzWvdhqzQmY4qv5Sg1QE=;
        b=KraaQlU4ZB3vgl/VMwliYRINg2DfGbnS2z/kYflZ9b6IBwdLOup0FT2OJq8Ljcaldj
         y3I58wwwABOwiwIl5MB8v8KksVoUPbjZNQk0PYF+K2jJQKvZcWCjKn7SmxPNu7zYAgr4
         ulMCnXeUvj8GLII44QSlQPqRsztM1rANrdvj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPjyKtKZAWSrnuvTIYsa3TgyzWvdhqzQmY4qv5Sg1QE=;
        b=W9M2gNC13L7rWLK+McRp1xSvF4eCGPbLv+92pZas+Plm+Za2SNPTKDDK+Rc+Xi223v
         uaQTEeYr+WjStyRv3V4tLIDzPhmmWzoAIW1A/DncAArNUHeV5aw1YBKdlqmz4dkjXNLe
         DWbvsmjmSrJFQVzXzDS3UfXZkkZzOeONooKMaTgxrBFBIth1EwE+3n2K6nnyq8CH0UWF
         0SN+LK7YqbyCEZ+cwhvdVsYtmgqoi8BXNr59MvU2+BwcjFmMTKpCE5md/dRfcZjSpsaG
         JwMWnwVhYxgKbrBibcv0+F9PiBpXxx/0YfwsMqNIJRe6+Xe+mR7rskin9wXTCZZe4Ttn
         moEg==
X-Gm-Message-State: AOAM533AT5c3u2HFD8M2zxGfi927lFDaLMLzaktIolhUIFXaZggI21RV
        wmKNtP1drJRRuj3sCofc76ncK//EGnH/P5UCpuaZoQ==
X-Google-Smtp-Source: ABdhPJwJGKuNPAcevDkewuTLZHHGSaOhWpWjf+uUb1oW453oxtJOsN5n8M9ASaWmDs2qhhJRac5v+rU4/FojCAkeILU=
X-Received: by 2002:a19:418d:: with SMTP id o135mr9293535lfa.329.1607390000773;
 Mon, 07 Dec 2020 17:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20201204152554.955599-1-kpsingh@chromium.org> <CAEf4Bzb8i9i6YqYwiczeDZoT_PVpHZqPoJETdwDz+40__u5+vw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb8i9i6YqYwiczeDZoT_PVpHZqPoJETdwDz+40__u5+vw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 8 Dec 2020 02:13:10 +0100
Message-ID: <CACYkzJ4+ACs2x6kzK14MeJTM2tD1G04XSGQj7P5tzMZfjz3x7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add verbosity to ima_setup.sh
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> > ---
> >  tools/testing/selftests/bpf/ima_setup.sh      | 36 ++++++++++++++++---
> >  .../selftests/bpf/prog_tests/test_ima.c       | 11 ++++--
> >  2 files changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > index 2bfc646bc230..d8d063fa7781 100755
> > --- a/tools/testing/selftests/bpf/ima_setup.sh
> > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > @@ -10,7 +10,7 @@ TEST_BINARY="/bin/true"
> >
> >  usage()
> >  {
> > -       echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
> > +       echo "Usage: $0 -a <setup|cleanup|run> -d <existing_tmp_dir> -v <yes|no>"
>
> why -v <yes|no> vs common -v for verbose, and lack of -v for
> non-verbose? Seems much cleaner? Yes, C code will need to deal with it
> in a bit different way than you implemented it currently.

I did not care much about convention since it was a helper that was only
used by this particular test.

>
> But honestly, even just setting envvar would do. This script is for
> selftests only, so test_progs could have a convention of
> SELFTESTS_VERBOSE=1 for verbose mode or something. No arguments
> needed.

I like this better, and will send in an update.

- KP

>
> >         exit 1
> >  }
> >
>
> [...]
