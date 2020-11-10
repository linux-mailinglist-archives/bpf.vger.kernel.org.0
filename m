Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B861C2ADE83
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbgKJSig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 13:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbgKJSif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 13:38:35 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73AAC0613D1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 10:38:33 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id c129so12615010yba.8
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 10:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXO6WJmsmxyc6DBaxc6kvqwTRSWm1EtW8L0V/68IKAI=;
        b=sptnaXsoTgCl0xk9L8Ckf8nvgMV79heO+ROutzxFcqOCHfj6suw8PFtnTt1Fsg/+X7
         mVnBC3BlETobq2hhksQFvyt4c8p+w6EwHu2v0z80xYi6Pav5x6unK19Q4yOQ5/isFoQx
         h60lEwMPFQK0TteCudtwLVyMEMh5BCxO2cJmBc0McKJHO2Ead6Hh63sAnOsGqgWofvAr
         C0eec8GwLYrkdk12V7YZoPc8c8Axdu2uK0g8FX0u/kLHddSuTGX79vna8Kmv0CQigGeo
         3mL2OLFS8kBu4fjsXb/wy6NAivEIPMZBjLA2X3DGcKp2bHs8wGVwmYxbaTA2v3txNW9l
         KLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXO6WJmsmxyc6DBaxc6kvqwTRSWm1EtW8L0V/68IKAI=;
        b=n8s4StAxt17lSaq/joC4nOTTqdsS/uVDidiJkLqP9HI/zde/Mw3o1vGjdyYoJTn6eO
         M8EsWl+o1t659wCJAaBGviTUCieQsZs7f1674/pTacqPRWHK1DQYUvAyZUWo39LJDAgz
         4cXDCPzO9JjIg1JnpHdEAXNEoF1aeSBNvHKV8Yr7ZMw2AIt1oVTxsYbdvXVSHHL7A3P9
         nOCZdpxmndhICS8bf2oz6uUd7Usr0qeZdmbpY0tv/B8JKQMwa2JdfVXheFMj9at6kh4v
         pkOkC3PgegS9zPZk96TFYcy1Mf2RN16UqfnvKFOcZlbfHf5q3Utst7j1i4XQNK2rcWi+
         nSOw==
X-Gm-Message-State: AOAM531hl7k11qXBGtWNMula79C0/capRqtVgtKOBqZzACbSvvU7dID/
        sME1Wv4mbWSs3JVWjxhVgD6cmq0ZNO0YXhv5yrkQkCtNHOI=
X-Google-Smtp-Source: ABdhPJxXRtIr0r41o2UoBvBf0i3gjwn5WEoyXtTICPpOcCYOHbigKnks88O5XrWQJfUkhcX7203bhxRn+6WY8vfbE4Y=
X-Received: by 2002:a25:df82:: with SMTP id w124mr187541ybg.347.1605033513211;
 Tue, 10 Nov 2020 10:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
 <CAEf4BzZeymUUNSp-wg1_UVUH_7-N3JaXWT7qArqT612459nLmA@mail.gmail.com> <20201110124220.GA1521675@myrica>
In-Reply-To: <20201110124220.GA1521675@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 10:38:22 -0800
Message-ID: <CAEf4BzYt1nD6oRqSGXEfbciW0q=h9c4DAydW78e1xMiYF_O7FQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] tools/bpftool: Fix cross and out-of-tree builds
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 4:42 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Mon, Nov 09, 2020 at 10:11:52AM -0800, Andrii Nakryiko wrote:
> > On Mon, Nov 9, 2020 at 3:11 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > A few fixes for cross and out-of-tree build of bpftool and runqslower.
> > > These changes allow to build for different target architectures, using
> > > the same source tree.
> > >
> > > I sent [v1] ages ago but haven't found time to resend. No change except
> > > rebasing on the latest bpf-next/master.
> > >
> > > [v1] https://lore.kernel.org/bpf/20200827153629.3820891-1-jean-philippe@linaro.org/
> > >
> >
> > While you are looking at bpftool builds... Seems like it regressed
> > recently and doesn't honor -jX setting. Either way the build is
> > sequential (and rather slow). Do you mind checking if your changes
> > could fix the regression (I haven't had a chance to bisect the
> > offending change causing regression).
>
> I bisected it to ba2fd563b740 ("tools/bpftool: Support passing
> BPFTOOL_VERSION to make"), in v5.9. As BPFTOOL_VERSION became a recursivly
> expanded variable, the shell function is evaluated on every expansion of
> CFLAGS. I'll add the fix to v3:
>
> -BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> +ifeq ($(BPFTOOL_VERSION),)
> +BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> +endif
>

Great, thanks!

> Thanks,
> Jean
