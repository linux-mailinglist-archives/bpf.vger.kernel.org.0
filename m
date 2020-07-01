Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F117921154D
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 23:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgGAVrB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGAVrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 17:47:01 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F9CC08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 14:47:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h23so19754200qtr.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIPZq3JbRr7fP53oiNW2t/8GZ0Nw/bdCbUC0CbNGg+o=;
        b=EjaIs3vF3fz2r64jIIqIHR/I5ztiJwp/KTmN1b9ALsAzKeEG5ix96PfChsdab4zeDK
         ffIHZyEXchGsJjme7sYRIcuQlEiaus+Xo+POkQHnwJajA1TMsifJsC0Vtm/B1Rf5Yvu7
         +8PH6SpH/OrJ0TXi3LUILE3Pkpf8Dkq6awI4AhKBExI0r9mJRwG4a0r/c36pY85UglLV
         wt8Y3XTS1lQFfXxMKNR/cUvHjWv1rhVIsSKC51Yt7ZYtBfPG/zzYCPklH2dMtQXWDmoJ
         Kha7dj+XPAfCfNKQM/LNnLadxM/tRN8wnolwr4gs+PdfVYHcP9uNsw9UUEUgNdR9rB6+
         Lz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIPZq3JbRr7fP53oiNW2t/8GZ0Nw/bdCbUC0CbNGg+o=;
        b=qKFWb3+j54zPWhmxO3M1BmRRHSwAVhJAU0KveBhvL46RqCnUkW9VG9qJHLpdb20RLd
         X1qI+s1kIE6K4+19P9z6A10u/qK+EmC5OveW3sc2nCZeoqXwTGO098gtdIW7cEy09DjQ
         u5uLD6zBzyEGoBz5wh64GeVevWN5zp7xxfGYWBM9wrhtX+joqMDcHtczVR/6lpUfbrEZ
         dVvZfem6qlEaCBMkAxamWiWhSgLcHN5EytdTheCWViHiNcvQyUN7LNes8B54wPEWU7aA
         mWiyUud+DWAQj+7hOUIq8R5f6/D+ptuKaRP1red1t1hQWDT91LjWQgBlB+eLak1H6lO/
         Modg==
X-Gm-Message-State: AOAM5338upEnBmtPibssT1kK0JcFIl6O6s32EimyhLLnDmoLgyPU7tWB
        Og/DLWBEXQsSp6ATjo3pDKYzwDzCgRw0/fBaUt0=
X-Google-Smtp-Source: ABdhPJwvS9xlupdB9CGs53GpweYi35GrsYScazqlrFe6igW5tEAytmzgh9NU3A146RvoSjzEMS2SiNa6IViA09XQWss=
X-Received: by 2002:ac8:19c4:: with SMTP id s4mr23925242qtk.117.1593640020547;
 Wed, 01 Jul 2020 14:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <159363976938.930467.11835380146293463365.stgit@firesoul> <159363984736.930467.17956007131403952343.stgit@firesoul>
In-Reply-To: <159363984736.930467.17956007131403952343.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Jul 2020 14:46:49 -0700
Message-ID: <CAEf4Bzbq=uhwEsVK+j_=S8H=tN6aK4ftLa_J8-z4BLgHq0dXGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next V3 1/3] selftests/bpf: test_progs indicate to
 shell on non-actions
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 2:44 PM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> When a user selects a non-existing test the summary is printed with
> indication 0 for all info types, and shell "success" (EXIT_SUCCESS) is
> indicated. This can be understood by a human end-user, but for shell
> scripting is it useful to indicate a shell failure (EXIT_FAILURE).
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/test_progs.c |    3 +++
>  1 file changed, 3 insertions(+)
>

[...]
