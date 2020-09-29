Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E105727C0EF
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 11:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgI2JVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgI2JVS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 05:21:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA81C0613D1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 02:21:17 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 26so4682769ois.5
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=id5psVTZSDMhOlckpGo8CUqtpbTSRfiT9gOWo0ny4ek=;
        b=UYXIyfDhH977ntPsM+7Oah43rWc7WFUVqZoHhuofAV+q6RF3NFEbVZay5xczF/VUZ5
         sMVityv4M8OSy84DcK6AbcfQzSERk7VYSvBFBkAEpQCTjlxP8Z1YCzEfNfeCReBCVG6j
         GjIvRVGx0Glf5sBtrAQS+xN6ZzUjHEsUC/Ndw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=id5psVTZSDMhOlckpGo8CUqtpbTSRfiT9gOWo0ny4ek=;
        b=F2wRNHaqCdvB7yYEeyEKPLtsbnktozJvvygGh/CCBChtGsgdxuU+LLKLZM8SoM+LSL
         6MfLEoN0qh9qznKaOP79gy/fDVZ7XArCRGo57QZJqrpHfJdeS3FZ0tvbXn3hZln48Q8o
         J2fBSqo7om9SwRyAQmkLyj7J9aTtwFHiW9yO4dpnN2yePkEuznSJiZmJnXK3MeC34jFa
         GZcgKoR2BJKhvttjlhefshFdwZ62tXaVDM7Fon0lxC67KVCUS29f1urr5xbgaEZXCjH0
         F3fQ2vwaXF0ArtSGab8sRq6lXrvNc8kzKNDZHQbUc8tBkPSAvsFjw26+OfbZX78zNEiF
         DFJg==
X-Gm-Message-State: AOAM530QIawnt4FiTYRVR4YBg5q7QXRxQZZ60H1dotRlwfpWNf04TxH4
        KJd+fa4YeA5E7b++9NIEfhD9l7jKmdHPnqRxVtL1XQ==
X-Google-Smtp-Source: ABdhPJzEPpDikSbmSQ6GKnI9QYsxaxQGiIypykQkLCXeMXS1K9gv5joboZIw8ZWs7WWlpLRulBhfYziPmh4ivGPftuE=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr1965385oip.13.1601371276527;
 Tue, 29 Sep 2020 02:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200928090805.23343-1-lmb@cloudflare.com> <20200928090805.23343-5-lmb@cloudflare.com>
 <20200929060619.psnobg3cz3zbfx6u@kafai-mbp>
In-Reply-To: <20200929060619.psnobg3cz3zbfx6u@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 29 Sep 2020 10:21:05 +0100
Message-ID: <CACAyw9-hSfaxfHHMaVMVqBU7MHLoqgPyo55UwQ3w7NKREHcCxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftest: bpf: Test copying a sockmap and sockhash
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kselftest@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 29 Sep 2020 at 07:06, Martin KaFai Lau <kafai@fb.com> wrote:

...

> > +     /* We need a temporary buffer on the stack, since the verifier doesn't
> > +      * let us use the pointer from the context as an argument to the helper.
> Is it something that can be improved later?
>
> others LGTM.

Yeah, I think so. We'd need to do something similar to your
sock_common work for PTR_TO_RDONLY_BUF_OR_NULL. The fact that the
pointer is read only makes it a bit more difficult I think. After
that, a user could just plug the key into map_update_elem directly.
Alternatively, allow specialising map_ops per context.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
