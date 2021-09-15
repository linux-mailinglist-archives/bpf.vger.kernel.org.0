Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C78D40CF40
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 00:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhIOWRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 18:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIOWRb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 18:17:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92471C061574
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 15:16:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k4so10309860lfj.7
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSJH9MCowd5OnYP8AMUwKaW12zhge7ouKo4jA7sIYXo=;
        b=nicVar+sApWCFpJDQHjrS6ts8AnjbqAMGG69L26y5qo1PA2/WNyNwxHF1tdFbu5HGO
         iqdVm7pyvxviqvW3PRRQNwMyg1LBhVK+xRkLEChO5EFuTcpk9l7dnGZmdGoycynI5lKR
         b9pIftCqkv+fvPQTXMLgzyHnyQWR5vy9uA5miPSbv7m3JE0cCs25yX/mEGZLATG2UA7H
         rXbqQgY9+Ml4frxkRFzMgtl+vqt8SFID5afcyim0OGjekhcqq3wALTMMyRSjygosyz+a
         TGfhPPvjt1HT+piz2dcIojXDkUCLg0iXeRwY/cqi2QZAKGpnK2LAh/3ZTVkE/AIHDEjo
         Hr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSJH9MCowd5OnYP8AMUwKaW12zhge7ouKo4jA7sIYXo=;
        b=HdHzG9wRDK7uqa4w9Vr6UETsE+0oTQAZQLebamYp27wSq6aN7ZVaYEVhECnbThgdpE
         lpGgq/vad0/JRXQL9tinfP7mzbIx4emQndNglFEIvFad9KI3s653w+4ewJiFmZwlq3Tk
         SmUlFzwmTShCu3ffYl+Ktck/7aITiD4hL99jZPGI7lgSSemaHcnlC1uI6A/glOnxO+Yy
         Xw40NIeZ50uztgGFEzvk6+rEJ3PmmLGpzqTYVAZqpiRKXeKJZUvfoaBNcZ+jZkGqCqQ7
         uKPNOGvk9yM3DhnsVidgeDLdYSZhTXzW3ZnetSw0TvjwDFmWBtTSrc6MaV5jKCZh4Ifi
         9LYw==
X-Gm-Message-State: AOAM532+PJC/bov9I8NSHlG3t4NqkzXeRnNGyeAkYsQLeLZF7vxXWQ3w
        u+a3SESJgxauIFmqMEX2IgD6bO6isjSCmTzOUKM=
X-Google-Smtp-Source: ABdhPJxs8zr2kEm/6rjMXC6GFUm6SMugOhRG3PfOkYt2VAtEuv8mo1c8r/4czakZXQ/0YZspYlyEsRGU6c/8LEyFv2k=
X-Received: by 2002:a2e:bb8f:: with SMTP id y15mr2072079lje.148.1631744169649;
 Wed, 15 Sep 2021 15:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210913193906.2813357-1-fallentree@fb.com> <20210913193906.2813357-3-fallentree@fb.com>
 <CAEf4BzZTv7HtiX5w-5H5hjRvaANXTPorqGNgae_FTJX9CD9Ytg@mail.gmail.com>
In-Reply-To: <CAEf4BzZTv7HtiX5w-5H5hjRvaANXTPorqGNgae_FTJX9CD9Ytg@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Wed, 15 Sep 2021 18:15:43 -0400
Message-ID: <CAJygYd1rUTPpoOX9uXgHCwN5d1pR7LXu0jwjcnfoFx8O3LJ=fA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: pin some tests to worker 0
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 3:23 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 13, 2021 at 12:39 PM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This patch adds a simple name list to pin some tests that fail to run in
> > parallel to worker 0. On encountering these tests, all other threads will wait
> > on a conditional variable, which worker 0 will signal once the tests has
> > finished running.
> >
> > Additionally, before running the test, thread 0 also check and wait until all
> > other threads has finished their work, to make sure the pinned test really are
> > the only test running in the system.
> >
> > After this change, all tests should pass in '-j' mode.
> >
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/test_progs.c | 109 ++++++++++++++++++++---
> >  1 file changed, 97 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index f0eeb17c348d..dc72b3f526a6 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -18,6 +18,16 @@
> >  #include <sys/socket.h>
> >  #include <sys/un.h>
> >
> > +char *TESTS_MUST_SERIALIZE[] = {
> > +       "netcnt",
> > +       "select_reuseport",
> > +       "sockmap_listen",
> > +       "tc_redirect",
> > +       "xdp_bonding",
> > +       "xdp_info",
> > +       NULL,
> > +};
> > +
>
> I was actually thinking to encode this as part of the test function
> name itself. I.e.,
>
> void test_vmlinux(void) for parallelizable tests
>
> and
>
> void serial_test_vmlinux(void)
>
>
> Then we can use weak symbols to "detect" which one is actually defined
> for any given test.:
>
> struct prog_test_def {
>     void (*run_test)(void);
>     void (*run_test_serial)(void);
>     ...
> };
>
> then test_progs.c will define
>
> #define DEFINE_TEST(name) extern void test_##name(void) __weak; extern
> void serial_test_##name(void) __weak;
>
> and that prog_test_def (though another DEFINE_TEST macro definition)
> will be initialized as
>
> {
>     .test_name = #name,
>     .run_test = &test_##name,
>     .run_test_serial = &serial_test_##name,
> }
>
>
> After all that checking which of .run_test or .run_test_serial isn't
> NULL (and erroring out if both or neither) will determine whether the
> test is serial or parallel. Keeping this knowledge next to test itself
> is nice in that it will never get out of sync, will never be
> mismatched, etc (and it's very obvious when looking at the test file
> itself).
>
> Thoughts?

Great idea!

I ended up doing "serial_test_NAME()" and "run_serial_test()", but the
idea is the same.

>
>
> [...]
