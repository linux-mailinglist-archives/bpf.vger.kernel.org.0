Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E001E3856
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 07:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgE0Fhx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE0Fhw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 01:37:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3736C061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 22:37:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a25so15722797ljp.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxROJcUOPtf8/J1V8c+SsfyP3z+XtNkoyadTbnAQOmc=;
        b=LYQ/uN6DuFN8wgWYjKxrd4eE4LWQy91P08KFOpWEWRKn/OXk7WGmOJlHdNrb/WIRuB
         ZeDSdK9tIB/d1+9LPi4XDqg0OmKoUdgkFS3ZIQiHQPPRIWf7yk5EXMf0WGdTdOjwPHFj
         PgtTmQ1E2OywXhabXkVq9wp7JdaWhEB5yGqCfBkO+D3Ca7ZTms6dY6RIrtI10uAdmejD
         f8nf8LR4apxb0Bkg9P0AbDYiqBIAuC8xUTzcR5tBJYMrbFqPibwADf7ebtKXMsNdCRZb
         ScAmllkU1Jpdl7GZV5hY4uKITJHSsLIcw5ZAcvsiP8aJLMd+/dKSndVVAZoOCwQQVH3U
         u2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxROJcUOPtf8/J1V8c+SsfyP3z+XtNkoyadTbnAQOmc=;
        b=lQNlUD3MtjdW6rXCrisgXGNO9SHde/Jw+JxWBYni3eRCye6pxJoGNakZ0Na+KQpPmE
         YZjJU1vJJAphvbBvT45RV79YDutEKq0leEIbojPP8fzAF/H5dy0GbXXT3751gJbeip71
         o0lSCyxrb9UHGP0rqBeYN6BSJeTnEjzE8oqoCCIaT2ARcUNi5mOYxSlsTH0AzpA84gkL
         hC4HJaHe5k9P6+M1i6HR+w/T19oljnkv868JZxYzLjgNQaU6NPs09A1HMHbfykHcTOqC
         XXnD8q2G5m+eAsGxBw5TZQsTVJmBp+foLKwxv4O5t7piR3WgJ5cFawMtxa/f4dlLYRKw
         CQBg==
X-Gm-Message-State: AOAM530FkHdjwYdxUSBTRuGxYjwggJcvq0k6w1wLDs8iDwKCmijrSwLE
        KZLt8MTjAVvhr4NDxNAbYOn09puaJfJGtszCsh94Hg==
X-Google-Smtp-Source: ABdhPJyHBnbZBx/Y646asawl3c95ynilSMs8QpFStKT20wztGLIROZ/Xt85++wEies1IWRl7pRGWbxrppWNknzPblKQ=
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr2324057ljj.121.1590557870380;
 Tue, 26 May 2020 22:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <xuny367so4k3.fsf@redhat.com> <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
 <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com> <xunya71uosvv.fsf@redhat.com>
In-Reply-To: <xunya71uosvv.fsf@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 May 2020 22:37:39 -0700
Message-ID: <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 26, 2020 at 10:31 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Andrii!
>
> >>>>> On Tue, 26 May 2020 17:19:18 -0700, Andrii Nakryiko  wrote:
>
>  > On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>  >>
>  >> There is difference in depoying static and generated extra resource
>  >> files between in/out of tree build and flavors:
>  >>
>  >> - in case of unflavored out-of-tree build static files are not
>  >> available and must be copied as well as both static and generated
>  >> files for flavored build.
>  >>
>  >> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
>  >> is chosen in analogy to TEST_GEN_* variants.
>  >>
>
>  > Can we keep them together but be smarter about what needs to
>  > be copied based on source/target directories? I would really
>  > like to not blow up all these rules.
>
> I can try, ok, I just find it a bit more clear. But it's good to
> get some input from kselftest about OOT build in general.

I see no value in 'make install' of selftests/bpf
and since it's broken just remove that makefile target.
