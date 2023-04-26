Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170CF6EF208
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbjDZKan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbjDZKai (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 06:30:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F21355B2;
        Wed, 26 Apr 2023 03:30:10 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b8ed0d0a33dso10575272276.1;
        Wed, 26 Apr 2023 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682505006; x=1685097006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aknvFi5hSkq+8WjOm547lsUjnxn4I/4wm4FxJkh13YY=;
        b=gTZBuL61YKsetYLA93/Feqi0hw9Z0rkH6t6g9LzW9tuQ7aD/q7V9A2ulDo5MXwUPER
         YHnMA5E+NAuZA4z/bQGuWZEaZ9jTBkXb6TjZHa59N4gjALxcBEJrAa12pqWV49BYRR7T
         C74jtIqnlI/5dbnEcOMOwAWpMPu2TyRSZqMs5TmnFPC36sXP9/kbq4850PtTQZJlgtmq
         /UGtB9pYAPE8ps+Jm3bdkvewTbUx5Kw9BfWBYbk72ra6Ax4xT92RHZnFxqtOtBHP6IwZ
         8qnQK6aSw+RFeUAirhNnpxG8hpw5/oWMT3IIFp0EGTKxCdnTWJegFyaszFZRYSV8xBjo
         3K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682505006; x=1685097006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aknvFi5hSkq+8WjOm547lsUjnxn4I/4wm4FxJkh13YY=;
        b=Ut+43LH/P9lYF8Pu53+zOE8PrFNl1f8N6idOgD7EWTu/kHDIxYm6xFex+wfYohk4W4
         dvU7mAwaA60HpXA80hDsT8YpyCU/Mj7of4huQCVAU7zBnb5slLvalQixof7ZAmiOTU+J
         jJXLV3ZNvYc/6mhoHh1x9z1GV/5MtQCNozeSvvzv/jkPXiHZWq0r8oHvRqaWLzhaarzY
         YZ3RCdNRx/H9FEQ6yeu3zc4K8IuU2IliCsIHYrkQU9QYLDH1VBDW6qLxf+4J78ucUmOo
         s4flFLjBKZbRin+EqgJnigiLCmH0+EeqTJfL9w/xl6SESNxX4AP8sg//yK23/ZtVCTRm
         uLGw==
X-Gm-Message-State: AAQBX9fxTNp5sC72fKYrwv6uL4KgL2+yaSQGM2sbam4Xy3U/ysqvCBuJ
        Np07AnEsFFJECSIOsKT5QmNCHHYG6grB6Vt5qCU=
X-Google-Smtp-Source: AKy350ZoWdEcwFARX6gIl+5gGtgTUve67DhA7PoUNWi7vRqDa7PQDuMehXlSB0W27DMpdq97FRWb/Cl1Vjsxv9Apjaw=
X-Received: by 2002:a25:2505:0:b0:b99:41f6:ad71 with SMTP id
 l5-20020a252505000000b00b9941f6ad71mr13506011ybl.60.1682505006596; Wed, 26
 Apr 2023 03:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
 <CACT4Y+aMdct_tjSYsBvvtGoDji6feOiANogRbp3N41qkzU+5CQ@mail.gmail.com>
 <CANiq72nm2dU2o_x_GQ5SdsXaK6yZiDXG2hXEYMykViEAZvuMqQ@mail.gmail.com> <CACT4Y+YyYnwg4a1zjTnBU=t0x5Brt1rGuzz-5pXf2Fz3cKf4FQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YyYnwg4a1zjTnBU=t0x5Brt1rGuzz-5pXf2Fz3cKf4FQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Apr 2023 12:29:55 +0200
Message-ID: <CANiq72=vMydenfkxQx4X7kYvHD0cHzNK19xxxqow3WcLStsdRA@mail.gmail.com>
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

On Wed, Apr 26, 2023 at 12:12=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
>
> In which of the dozens of kernel testing systems? ;)
> And also in heads of thousands of kernel developers and users?
> All of them use get_maintainer.pl.

I am aware, but `get_maintainer.pl` is fine as it is -- we still want
to know about things that touch things that mention Rust in general,
so that we can possibly be helpful to others, especially early on.

However, if a bot is testing the kernel with Rust actually disabled at
runtime, what I am saying is that the chance that it has something to
do with Rust is quite low, especially if matched via `K:` rather than
`F:`. Thus my request.

Now, it could be nice to have some logic like that in
`get_maintainer.pl` encoded for all bots to filter things out based on
the kernel config and the type of match; but otherwise, yes, the bots
would need to add the logic.

Cc'ing Joe in case this is already possible in `get_maintainer.pl` or
whether there could be a better approach.

Cheers,
Miguel
