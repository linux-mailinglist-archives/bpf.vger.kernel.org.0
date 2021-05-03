Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099F33713E7
	for <lists+bpf@lfdr.de>; Mon,  3 May 2021 12:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhECK7q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 May 2021 06:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhECK7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 May 2021 06:59:46 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD06C06174A
        for <bpf@vger.kernel.org>; Mon,  3 May 2021 03:58:53 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id u20so4520347qku.10
        for <bpf@vger.kernel.org>; Mon, 03 May 2021 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/zrsnTLZK1E/jzB16BpwyUULYWVwk9y9X2WiHMFdTQ=;
        b=B+dMxQr6169RROHt11NCRDbz3gyrG9Fa+Wo0jLcf5itG3ccOYSeatZDaJx5TOW9WIz
         l4k1tB4np60fCQvhc91XP/q0y6Llwp1DZ4m8uVc17+c5/aPUSGBG4cMYtANneHszehLP
         hK6FqsKOrZPiKBgb7/w0Yzto7lQrHkbCswe1uix9ZmkMNfYsJY1VDtAT3lBEYp0rMFl0
         FtLTTYgUYcIm+GSAitx4mT7XQedTHMXsN1k6SaKlSe+/wYj1xw5TGawpr7MNske8WFBt
         0ZpDHfzSmSlE3mkCWFWXT8E1wSF3npDX4hvTkMeRNRaKE3XhNid+8FzUmW3DdZQsk078
         oL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/zrsnTLZK1E/jzB16BpwyUULYWVwk9y9X2WiHMFdTQ=;
        b=ZGhg3PgP7cdZcyI5ezkKqRiVvZSCmfTslVppIegd/v52F7Qg4NKK7oLALYQHZ/QMsA
         O52zzvvziEMGnOevQ48r0f9kiQYLzKVdbCuGEHh+DJGzrZTGUm+MNFAVQwC8pEcbTl88
         F7yGH8GOkXmDs832EqcoFPlIw423UpeLEO/jtxukYWM2N0NFX+lPtsL7tkVyFOoOYQcu
         pKaeHdftSDzORHvKFKnPN+XpRpq5E7DkJ/MkABswNeAQ2CK2IjwGNM15yaNoDHy8hd3E
         bkdJM3vgBlf2RXD0zkdF+w8+OC2yRNkukGdRxfCQqMmkFto/bA2xRd4p0TooVnDHFNyR
         lgqw==
X-Gm-Message-State: AOAM531r5DJ37nb4CtXxzrWeQ5/GpDo/Ph1DNvORdnwo1MH1SVlMd7C0
        skT7Z2Jpf3EP7RhEtED2bxxMPonWfgnFDCG42Q==
X-Google-Smtp-Source: ABdhPJxrkWoSQubtlChSadCC/b3CXgpLiQFqc0k9QATBJsWVbJN+JhQpp2JmBRa0ziWqYKCnBz0uP6nIS8gZd6VhEv8=
X-Received: by 2002:a37:5fc2:: with SMTP id t185mr18183511qkb.254.1620039532428;
 Mon, 03 May 2021 03:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210429153043.3145478-1-joamaki@gmail.com> <CAEf4BzbQPE=oQ1UUhMc8d6HOmvrpmhg7kOHUtFHENN7Ux6P9OA@mail.gmail.com>
In-Reply-To: <CAEf4BzbQPE=oQ1UUhMc8d6HOmvrpmhg7kOHUtFHENN7Ux6P9OA@mail.gmail.com>
From:   Jussi Maki <joamaki@gmail.com>
Date:   Mon, 3 May 2021 12:58:41 +0200
Message-ID: <CAHn8xckUw+avQye-YMPBvb7cUMZkeKLRJWVcVXPeswqr9itLBA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Rewrite test_tc_redirect.sh as prog_tests/tc_redirect.c
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 30, 2021 at 9:56 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 29, 2021 at 8:32 AM Jussi Maki <joamaki@gmail.com> wrote:
> >
> > Ports test_tc_redirect.sh to the test_progs framework and removes the
> > old test. This makes it more in line with rest of the tests and makes
> > it possible to run this test with vmtest.sh and under the bpf CI.
> >
> > Signed-off-by: Jussi Maki <joamaki@gmail.com>
> > ---
>
> Aren't there any Makefile changes that need to be done as well, given
> you are removing "old style" test script?

Nope, it isn't mentioned anywhere.

I'll send a v2 that addresses your comments, e.g. switching
to ASSERT_xxx() and rewroting the sysctl stuff to handle errors
and restore original values so it won't affect other tests.
