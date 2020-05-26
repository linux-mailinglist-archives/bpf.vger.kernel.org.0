Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA01E32A6
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 00:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbgEZWcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 18:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZWcW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 18:32:22 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17749C061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:32:22 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ee19so10282106qvb.11
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MuLB3Y5BDOYSMiMLlCiBkQT07E50QnXceZRsKX1T6I=;
        b=TEAjwDPec8jTSFJay+hTMc8FOse6ks/ptXNiCwVyoCWF81IpjAblRVcRw9S+b0MJBo
         G1HDR8xUVfq7L6GGV0P9SvfxaxvDLCgxtisaUoTDHZQjkAKyJRkB7aZwzlsomJoBSYie
         oeVjHO7NTQr6Yhh1W2OWt/nOn8SSmRDeIzsI5r3FcG9S04+/2iRiRfOYG+nRdks3wD4e
         ROAOQvKJTxLujP7JJo54wrgh54J0cowuf0lUKeY9lyuu2GmjcdSip8zEDpxzCyOetLy2
         6tJTNwxFe7NoZX0ECSZxmBNNeamK0AQarMhfAacNDH4shsUjD+EE5LIBw8XKVBKNuYx6
         jwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MuLB3Y5BDOYSMiMLlCiBkQT07E50QnXceZRsKX1T6I=;
        b=i54Y73cAmZNk6HGh7d/9gtMbOe++47gpO9RFu8k2zIifoS/azNm6QOTU8fqwE9jn8y
         s8t8sGmdp2/bKijNyopYsil/jtPam67wMk+Fdhhsav42uNyMc6WUdiWRFTry2m8bfv5D
         2dFzBNKnWv5GTKliBX6ucQMB8/Q7YTTVVFbRx6ms0n9UekueBBp7G7zE88xU3LxHCjv3
         MXPxOfvdctyXvI11rGiuSOMS3vhMnuQUWlXiel02zl3xOigZTTb8V8gcPlZVAVHxihki
         DQtdHFT6ZbHLo3fBoCoSV7qgQUZ5cBg5iZcoXpAC6r+gnBIcsszCUvoMXA8HmEnPM/B7
         7J4g==
X-Gm-Message-State: AOAM530Eix5uljm+9vZXFQEUHIwlOVhX52BKSNj4xCFgTPwtLqLxcpR+
        GSm901QHy+PjKNoMD/mLdkt7E1jiIpTh1yZWaTM=
X-Google-Smtp-Source: ABdhPJyA8UAZB36juvAxHrFCg//aJSRXoIw4ZbnZx3TAzMCeBBbIeyC+lNW8OYx3DK9aodcKVBYxQaWgQLXUVR6mA4U=
X-Received: by 2002:ad4:588c:: with SMTP id dz12mr22444111qvb.196.1590532341287;
 Tue, 26 May 2020 15:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> <xuny367so4k3.fsf@redhat.com>
In-Reply-To: <xuny367so4k3.fsf@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 15:32:10 -0700
Message-ID: <CAEf4BzZd507Hyfu8GYxZfJ-Rc0GAs1UNCN0uBqX3kYS9sz-yDA@mail.gmail.com>
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 11:41 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
>
> Actually, a bit more needed :)

From the other kselftest thread, it seems like selftests are not
supporting builds out-of-tree. With that, wouldn't it be simpler to
build in tree and then just copy selftests/bpf directory to wherever
you need to run tests from? It would be simple and reliable. Given I
and probably everyone else never build and run tests out-of-tree, it's
just too easy to break this and you'll be constantly chasing some
non-obvious breakages...

Is there some problem with such approach?

>
> >>>>> On Fri, 22 May 2020 07:13:02 +0300, Yauheni Kaliuta  wrote:
>
>  > I had a look, here are some fixes.
>  > Yauheni Kaliuta (8):
>  >   selftests/bpf: remove test_align from Makefile
>  >   selftests/bpf: build bench.o for any $(OUTPUT)
>  >   selftests/bpf: install btf .c files
>  >   selftests/bpf: fix object files installation
>  >   selftests/bpf: add output dir to include list
>  >   selftests/bpf: fix urandom_read installation
>  >   selftests/bpf: fix test.h placing for out of tree build
>  >   selftests/bpf: factor out MKDIR rule
>
>  >  tools/testing/selftests/bpf/Makefile | 77 ++++++++++++++++++++--------
>  >  1 file changed, 55 insertions(+), 22 deletions(-)
>
>  > --
>  > 2.26.2
>
>
> --
> WBR,
> Yauheni Kaliuta
>
