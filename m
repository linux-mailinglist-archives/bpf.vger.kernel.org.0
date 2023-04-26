Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8464B6EF1BE
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbjDZKNB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 06:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjDZKM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 06:12:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360E10CE
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 03:12:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4edc63e066fso7074e87.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682503975; x=1685095975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snYOiKqgoVnB5ohuUHnbns4RINmjT1R7uP5BkhOFNUM=;
        b=y6X1iR7tK83MSYkNINDwsddtrA4mJaLb7s4bpZ+TZskQWeySmpRKDgS7TeDViJxVpW
         xhG4xYNiitFZvcsIxT1GF8jCGwLnJdE4JNYgO3/4YLSs8W+1eA7V4yzhoCRvwveOT62H
         gsRxclLFHgSYmgg+u0EdPatJEE6SQVPPWSt41yH9znDO6yswt/rkPoi8MqBG8AvD//lR
         nrSc1Ak620ATHAa4DT8IdyEe7eO+1crv12VySTO3b5a8VZRu9fd+5kF2VD5A9/gfdlRM
         eaGoW+A4LZ2TIVWrOR4WAi4aoqyBMKhsyIfckflN6Th2CHYtjf1eDdddlY9IoMnQzuIm
         mHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682503975; x=1685095975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snYOiKqgoVnB5ohuUHnbns4RINmjT1R7uP5BkhOFNUM=;
        b=PYT13k8kUIFL7NOhdDUxqn/yPaJG08AFJIekDm66ybOrghIXcwB7wTaagjC0EAJwJc
         uzphR/ZZaX2/FIGhA8xtdpZ1AM7UH2KTvdRnzYF5WhvTlcDQ9G+1g7ux7wEo86HwPlWy
         RpZdOkkr5agmoXTkIkz0564FL6MUqqEwuw58wsFrP04/Z7YS6xXzF15G0OUesE3dcCfv
         H3mQ78xYnf35s6W+Osjpo3OkRJ4VDa8Vu8YoF/drW70dm/koiBupq5frhgBortEbsxf4
         GE+YH0o2wMdBB3cXJjJSauBm0X6h7OygIAlTGmCeZ5/ylXIVVxq3ZhsXQXxUEYN8kNKw
         zNEw==
X-Gm-Message-State: AC+VfDyumuGR0GwgUigsZh9f6uUWTkPynN7jHcn8ZLOkLtu3aoAMim+5
        PrZIDWr4ZaROWZZ1MDeFKq3a2xG+xhw2rNWrDd2f+g==
X-Google-Smtp-Source: ACHHUZ5iHaw85sJIT2gsRxufAtrkLZdcbqBLY/FYJ30FnnxWPifbM7NglNYAP+L+lxTt47/gvPjnvN6e++u2crAt6i4=
X-Received: by 2002:a05:6512:ea8:b0:4ed:b0bd:a96c with SMTP id
 bi40-20020a0565120ea800b004edb0bda96cmr175258lfb.6.1682503975217; Wed, 26 Apr
 2023 03:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
 <CACT4Y+aMdct_tjSYsBvvtGoDji6feOiANogRbp3N41qkzU+5CQ@mail.gmail.com> <CANiq72nm2dU2o_x_GQ5SdsXaK6yZiDXG2hXEYMykViEAZvuMqQ@mail.gmail.com>
In-Reply-To: <CANiq72nm2dU2o_x_GQ5SdsXaK6yZiDXG2hXEYMykViEAZvuMqQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Apr 2023 12:12:42 +0200
Message-ID: <CACT4Y+YyYnwg4a1zjTnBU=t0x5Brt1rGuzz-5pXf2Fz3cKf4FQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     syzkaller@googlegroups.com, alex.gaynor@gmail.com,
        andriy.shevchenko@linux.intel.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 Apr 2023 at 12:09, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Dmitry,
>
> On Wed, Apr 26, 2023 at 8:34=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com=
> wrote:
> >
> > The crash is in lib/vsprintf.c and:
> >
> > $ scripts/get_maintainer.pl -f lib/vsprintf.c
> > ...
> > rust-for-linux@vger.kernel.org (open list:RUST)
> > ...
>
> Ah, yes, thanks!
>
> For the moment it is fine, since there are not many reports nor
> keyword instances, but perhaps in the future we could consider

In which of the dozens of kernel testing systems? ;)
And also in heads of thousands of kernel developers and users?
All of them use get_maintainer.pl.


> filtering out `RUST` on the bot side if `CONFIG_RUST=3Dn` and the match
> was based on `K:` (via diff with `--no-keywords`?).
>
> Cheers,
> Miguel
