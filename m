Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16136EF1B3
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbjDZKJa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 06:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbjDZKJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 06:09:29 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256BE44B5;
        Wed, 26 Apr 2023 03:09:28 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b992ed878ebso22466504276.0;
        Wed, 26 Apr 2023 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682503767; x=1685095767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czO2Z2QubT3+ruSG4948axnpOW9UV3kMHukttAtnVpY=;
        b=nyayCfpNuzNmpP4YN6JjLj3HvqpwSQ8ryxssMNKzxESl7FXJFQaChCPoErbGVINGNA
         Gd4pYn/S9W67ikzDl4MOmw5JPXZJ4vkhO2syf6wbjDBHzBO1UTPB+QT7n1MF2+Rip4/R
         5P9YUUz8fLG3tolFowSqum3AyYxt4uun9okyk1JgMI5uv2vMBMiRP4PM0BGZaWv7Bpc6
         QHFZMR0tdCVgtRl3SavCHuOXMpr0luFsJxkQUveiec/QBm1f4N0yfAKC9f+/k4bSjoqb
         TEUUh9oUG3880QwF+PVC5lEMeL5Wx4zK0DrJS0Qs7/UUtAaUWrXIJRJRvm8Us7AxII/Q
         Hb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682503767; x=1685095767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czO2Z2QubT3+ruSG4948axnpOW9UV3kMHukttAtnVpY=;
        b=X3nSDETzcx8Ry90XvWUv6PvVFgpjcSp4uw1AHGSywDvzOsMGSvArHSXuldAUi9GB8s
         c2dEIjJxYgzYVrYcUGbACPdop7T6IQL3fi5HFpB7cCqOTlXsDRrGp3ZdBiwpFePufWm8
         VadXfJAPqYuH1sRF1VpZnIitlNZr8zScGQAwTGC1jd5EjMCNFAfT7C4whBF+hkx/eUZw
         ePBRp+AyMQynm4wrYprKFo8VA1FVN9ANYSCsQGvSSVmMoFNb01jDp/hIb0z2daVMjybX
         AgWNk87pOfBSOUZUPJwM/8spqwEEbPwti2NJ6eSrFWI+tOu3GU3Ijbps+hKmBdg9Epvt
         KHjg==
X-Gm-Message-State: AC+VfDyKBRm9bCwDIQ1R+cpSrn3iFWN3LCiz11fvg3+EbPrBkuNMRDrp
        BLE5ptYdowseLfzsmHtLJvQPVSugGRI94k/s+0c=
X-Google-Smtp-Source: ACHHUZ6gz22auUHMTaANFGb7hbYr2WXg0YdFmmXzxnRjCSSK6aLf0TjhuZ7NY9ll8mIO8tEP00/Ymx2rMDMzNq6+u+g=
X-Received: by 2002:a81:25cb:0:b0:54f:8d54:fd3c with SMTP id
 l194-20020a8125cb000000b0054f8d54fd3cmr1369903ywl.17.1682503767283; Wed, 26
 Apr 2023 03:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
 <CACT4Y+aMdct_tjSYsBvvtGoDji6feOiANogRbp3N41qkzU+5CQ@mail.gmail.com>
In-Reply-To: <CACT4Y+aMdct_tjSYsBvvtGoDji6feOiANogRbp3N41qkzU+5CQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Apr 2023 12:09:16 +0200
Message-ID: <CANiq72nm2dU2o_x_GQ5SdsXaK6yZiDXG2hXEYMykViEAZvuMqQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller@googlegroups.com, alex.gaynor@gmail.com,
        andriy.shevchenko@linux.intel.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Dmitry,

On Wed, Apr 26, 2023 at 8:34=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> The crash is in lib/vsprintf.c and:
>
> $ scripts/get_maintainer.pl -f lib/vsprintf.c
> ...
> rust-for-linux@vger.kernel.org (open list:RUST)
> ...

Ah, yes, thanks!

For the moment it is fine, since there are not many reports nor
keyword instances, but perhaps in the future we could consider
filtering out `RUST` on the bot side if `CONFIG_RUST=3Dn` and the match
was based on `K:` (via diff with `--no-keywords`?).

Cheers,
Miguel
