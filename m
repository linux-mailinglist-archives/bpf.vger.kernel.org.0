Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9CD6EF37E
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 13:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbjDZLhl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 07:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDZLh3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 07:37:29 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B53C0C;
        Wed, 26 Apr 2023 04:37:28 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fb8a8a597so83247497b3.0;
        Wed, 26 Apr 2023 04:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682509047; x=1685101047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lALWCsz62LMjyxVOtF5eFTXt3IIcI+kzdO5VholoM0M=;
        b=aioUzD9jPCAN3+Y5ZT3ovJOGMiPiJ+2Pbj8X11ALOrbMWxlL6sGdsVqrAVckXGxlwE
         zEZqzhh804Vn6luTB7ecv8o/AhVB59USNr84Sg76F3w7rJyIZbYZSyTAJ5aUNRHMZyJC
         2EuO9WdFV2KiXGh9t1qZixZ3+oKXM86tPps541kAJjwuUV0nQ4zokKpILJ6gAsk6SR/+
         uB7CUAP+/0ubTre/so20SSSSgkWVZ8Iq8gEU5mJVMQfaD7Hnw8KN9eoXSaUwuB4smkJv
         6oc4CuJxXeXNwEeGRIgEQqvpoItkD9ct+nZH32t8wiu6jqJtKnL8a54ZuG4pbS6ckgDL
         rBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682509047; x=1685101047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lALWCsz62LMjyxVOtF5eFTXt3IIcI+kzdO5VholoM0M=;
        b=IVHZCBIXewqKq7Uh+1ORwLGY/l6YykVguK+aHr6d3B/sZlwp47MPEuYv24hkRqImMf
         N+7s1gorUD9bN9/qK7HgyB0Rh5PyC2W0VxDOk5Ptyh3De7kfNqjdRXGw6GiiywNhayFd
         t13m8MmlJHsRQQLk7ixEDhLPzofc0kHQDjc098bjQWkV33KM38OiIed/AP2Y2CHGlPL8
         F+7cMr8wR2bh8ojYCV7fd4E7k0SLbnwIjJKb3kKgKqKiKOOXCESZ8EvsECxmIwGQmboz
         w0/keYM8bGotov4pGttWonWSFxYrd7cVdhs3BTzVbOr6hrVIVMBSsQvYj6raMg5KVfis
         nWpw==
X-Gm-Message-State: AAQBX9f5Jsb4/8JPe/gEGGcZHPxvME5LZe0U8SsJZOkYPH0ob9fb+bLQ
        DxO0EpKJ0+KPjMvIo4YEV5pzYC0mNO7WEibl1wo=
X-Google-Smtp-Source: AKy350bnB3r9FlsXadUNiokOGQ0tpZzid9gBfpCokyroyABd4z3nFL48eg2idUGJ/BoPRJjqSzCj9cGB6LqdRtdQJLs=
X-Received: by 2002:a0d:e24e:0:b0:552:a605:e408 with SMTP id
 l75-20020a0de24e000000b00552a605e408mr13495487ywe.12.1682509047657; Wed, 26
 Apr 2023 04:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
 <CACT4Y+aMdct_tjSYsBvvtGoDji6feOiANogRbp3N41qkzU+5CQ@mail.gmail.com>
 <CANiq72nm2dU2o_x_GQ5SdsXaK6yZiDXG2hXEYMykViEAZvuMqQ@mail.gmail.com>
 <CACT4Y+YyYnwg4a1zjTnBU=t0x5Brt1rGuzz-5pXf2Fz3cKf4FQ@mail.gmail.com>
 <CANiq72=vMydenfkxQx4X7kYvHD0cHzNK19xxxqow3WcLStsdRA@mail.gmail.com> <CACT4Y+ZrwXB1W31Rr7rUUOoW15YbKfnC0khY9KnNk8FTf5uQnA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZrwXB1W31Rr7rUUOoW15YbKfnC0khY9KnNk8FTf5uQnA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Apr 2023 13:37:16 +0200
Message-ID: <CANiq72=pZy6RzomqbKtM5Ky43+Y0y3c1HQkbwrpS-1FHcEqYqg@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller@googlegroups.com, alex.gaynor@gmail.com,
        andriy.shevchenko@linux.intel.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com,
        Joe Perches <joe@perches.com>
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

On Wed, Apr 26, 2023 at 12:43=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
>
> I understand your intentions and they make sense.

Thanks! I am glad you agree it may have some value -- please see below
for details.

> But adding this logic to syzbot won't help thousands of users of
> get_maintainer.pl and dozens of other testing systems. There also will

I haven't said otherwise -- as I said, I think it would be nice to
have this be part of the kernel itself. :)

> be a bit of get_maintainer.pl inside of syzbot code, so now all kernel
> developers will need to be aware of it and also submit changes to
> syzbot when they want to change maintainers logic.
>
> I think this also equally applies to all other users of K:.
> And a number of them had similar complaints re how K; works.

Yeah, I would imagine so.

> I am thinking if K: should actually apply just to patches and be
> ignored for source files?

I considered that -- for things like Rust, it could make sense, but
perhaps somebody is already using `K:` to match files they do care
about, rather than `F:`. So we would need to ask others, but I think
it is fine.

> If there are files that belong to "rust" (or "bpf" or any other user
> of K:), then I think these should be just listed explicitly in the
> subsystem (that should be a limited set of files that can be
> enumerated with wildcards).

Yes, at least for Rust, modulo omissions, we match files explicitly
with `F:`. We have a couple unimportant omissions, e.g.
`.rustfmt.toml`, but I can send a patch.

Personally, I have always seen `F:` files (and `N:`-matched ones) as
having more weight than `K:`-matched ones, i.e. I saw `K:` as more of
a "it depends on what it matches -- discretion needed".

From a quick look, most `K:`-using subsystems seem to list `F:` and
`N:` as I would expect.

> It's also reasonable to apply K: to patches.

Yes, definitely, for Rust, that is our main use case, i.e. it is
mainly why we wanted to have the `K:` entry: to catch changes to
things that are tagged with "Rust" in C files (early on, at least).

It is particularly important for us, since we are also considering
having more of these annotations in the future.

> But if a random source file happened to mention "rust" somewhere once,
> I am not sure you want to be CCed on all issues in that file.
> Does it sound reasonable?

For Rust, yes, that would probably work for us. Not sure for all
subsystems using `K:`, though.

Having said that, I suggested including the kernel config too in this
decision (i.e. not for the patches case, but for testers finding
runtime issues), because it adds information: it leaves reports out
when something is not even enabled but matched via `K:`, but still
allows a Cc when matched via `K:` and enabled. It is, of course, still
potentially a false positive, but some subsystems may want to hear
about those.

For instance, for Rust, this would be fine early on, since we don't
expect many to have `RUST=3Dy` to begin with, and thus the odd false
positive report via `K:` is fine. Later on, this heuristic may change,
and we may not change those matches anymore (especially since, by
then, the goal is that subsystems would be taking care of their own
Rust bits).

This is what I was suggesting to then put in `get_maintainer.pl`, e.g.
a `--bot` option (or `--runtime`, or `--config-based-filtering`, or
similar) option. Then the bots can add that option on their side.

Thanks again for considering this!

Cheers,
Miguel
