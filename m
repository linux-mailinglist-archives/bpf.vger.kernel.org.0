Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1075BF1E0
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 02:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIUASE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 20:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIUASD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 20:18:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63806550BD
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 17:18:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z97so6230846ede.8
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 17:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=es+i72QY/UlsQkSfsWVfRamcTu1yBXwmJPho3D5N4fs=;
        b=CD+TJOWD1Ot1IsZOFBzfBo8zBXS67U9AKkLSGh0Kopw6+nbuCI0T/Z/yhINSSdBeiP
         gZJhecsancsKDE0l3FkBoIYXJ4Mmuicus9aT8ZnHS7oEKS1Q6QfuQmAmftHGopHJYSs+
         InT/BdXsdXHfMhJgS0kfCMEnaXy2HSybrf4dVOzadVocrTITbnYOTAUX/wWadzGwjFRB
         dM8cmBIZ9/STiv8uhuvJBfBKNMAH8HyE5nx9f25OHdwqHVaog2ahkJ9XugwB5ElZPAPv
         l2MpEmZAvDFdrU6+PStOkDMnWv2GU8W84VJb6S6RVMIGkChvTYco9fycHkRT5gt6uO+Q
         5YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=es+i72QY/UlsQkSfsWVfRamcTu1yBXwmJPho3D5N4fs=;
        b=Mn+JWUVwIwgezha/CWQjPqw8jHUwMtSjUH6yDXlbCHrNNqCMGmaLaTDBdZMtiQDElJ
         mhlLU9TMGBuzuUlDip/oO3xoB0gpOEOJcRD3nOrKsVIucBP5NwOJ6Cbja295tv18oXU9
         4kYoPGSoua/mP/kY+XdgUv8qYsGbGPZ2jLr3BFg6M14F1GxJwKGJ0GGylbH2yWaEWFYj
         qoLpXa4PuTfvr0OrsQgV2dXlxy3QfN43NTndR9PSge6ASO7N/a5IgxvtCworSBW0kFls
         L4a/3IDDO/jK9PaOU8EzDPHt+dIukZ1vS0pPntWBpTh6rdhmuWjBQQDxwEojAkbEQN/4
         gJKA==
X-Gm-Message-State: ACrzQf159Ql/13Sloz4VSrFtER9X/VPmptJ6fv0IJBxS757jAX1A/lgb
        TpO8t5we49Czx/paYk1+nCmApn98UoiluaUrLcI=
X-Google-Smtp-Source: AMsMyM7J0q0KrdkuxIHfeXzjKmz6UljBM8Bfcy2uk71f/G/EacbiR75KQYGbl+LN7EJg/D1LnDcYnZnW6s2KRMC+POo=
X-Received: by 2002:a05:6402:1946:b0:44e:a406:5ff5 with SMTP id
 f6-20020a056402194600b0044ea4065ff5mr22691410edz.14.1663719480669; Tue, 20
 Sep 2022 17:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220920052045.3248976-1-arilou@gmail.com> <CAEf4BzZ4NqN8e+7W03BWZvaNJ6s=u09vaC_siTh7P6UZrDGvfw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ4NqN8e+7W03BWZvaNJ6s=u09vaC_siTh7P6UZrDGvfw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Sep 2022 17:17:49 -0700
Message-ID: <CAEf4BzYFEQmz0QpuhFaC_woy_QYvzrH7-JSQ0izCWm0mbGoyww@mail.gmail.com>
Subject: Re: [PATCH bpf v1] Fix the case of running rootless with capabilities
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        Jon Doron <jond@wiz.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 20, 2022 at 5:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 19, 2022 at 10:21 PM Jon Doron <arilou@gmail.com> wrote:
> >
> > From: Jon Doron <jond@wiz.io>
> >
> > When running rootless with special capabilities like:
> > FOWNER / DAC_OVERRIDE / DAC_READ_SEARCH
> >
> > The access API will not make the proper check if there is really
> > access to a file or not.
> >
>
> This is very succinct and doesn't explain why access() doesn't work. I
> had to read the man page for access() to (hopefully) understand what's
> going on. Please elaborate a bit more and maybe quote man page:
>
>        The check is done using the calling process's real UID and GID,
>        rather than the effective IDs as is done when actually attempting
>        an operation (e.g., open(2)) on the file.  Similarly, for the
>        root user, the check uses the set of permitted capabilities
>        rather than the set of effective capabilities; and for non-root
>        users, the check uses an empty set of capabilities.
>
>        This allows set-user-ID programs and capability-endowed programs
>        to easily determine the invoking user's authority.  In other
>        words, access() does not answer the "can I read/write/execute
>        this file?" question.  It answers a slightly different question:
>        "(assuming I'm a setuid binary) can the user who invoked me
>        read/write/execute this file?", which gives set-user-ID programs
>        the possibility to prevent malicious users from causing them to
>        read files which users shouldn't be able to read.
>
> So if I understand correctly, access() is self-limiting itself
> artificially, while in practice target file can be totally readable
> due to caps or effective user ID differences.
>
> Please try to summarize this in the commit message.
>

Oh, and I think it's fine to target bpf-next tree with this. Also
please prefix libbpf patches with "libbpf: ", so your patch subject
should start with "[PATCH v2 bpf-next] libbpf: ..."


> > Signed-off-by: Jon Doron <jond@wiz.io>
> > ---
> >  tools/lib/bpf/libbpf.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 50d41815f431..df804fd65493 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -875,8 +875,9 @@ __u32 get_kernel_version(void)
> >         const char *ubuntu_kver_file = "/proc/version_signature";
> >         __u32 major, minor, patch;
> >         struct utsname info;
> > +       struct stat sb;
> >
> > -       if (access(ubuntu_kver_file, R_OK) == 0) {
> > +       if (stat(ubuntu_kver_file, &sb) == 0) {
> >                 FILE *f;
> >
> >                 f = fopen(ubuntu_kver_file, "r");
> > @@ -9877,9 +9878,10 @@ static int append_to_file(const char *file, const char *fmt, ...)
> >  static bool use_debugfs(void)
> >  {
> >         static int has_debugfs = -1;
> > +       struct stat sb;
> >
> >         if (has_debugfs < 0)
> > -               has_debugfs = access(DEBUGFS, F_OK) == 0;
> > +               has_debugfs = stat(DEBUGFS, &sb) == 0;
> >
>
> I found in total 5 access() uses in libbpf, can you please update the
> other 3 as well? Thanks!
>
>
> >         return has_debugfs == 1;
> >  }
> > --
> > 2.37.3
> >
