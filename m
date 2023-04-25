Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787716EE8FD
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjDYU0f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 16:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDYU0f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 16:26:35 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C61545E;
        Tue, 25 Apr 2023 13:26:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b99efd7c335so1903848276.0;
        Tue, 25 Apr 2023 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682454393; x=1685046393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztj/pjzcD/5i0nuLrEPO12i9eGvh86GmaKFkyefTt74=;
        b=EMARqdV5KGNh5makMhN3X+U7H5PFRj4fYhANYm/ZPnrGWhAGdKrk0/7Y44HEYDvZ6X
         Zwxu7YCsh+xy/sa4qeBdbMY+YVH+zNXvTLJ91B2LWlsbG83dzGrNzeTQ2B6vZQb9LPeA
         1FjczEa5bGpNhR/p9vMsm1cixbtbpHXL3Qbbq1b/AMNm3HL+2Gtk7J43zw1s5/sGPhF8
         x4JzgCJMy+00Elj98CvM6LFizFLq7d+LXJwaUj3Th2yUly4Q3nKuH1AQM37PwilGX9SR
         IMiCksG1RJaPPrDApbs+mvZZumKpkrrRLYCLwIYl4nlqcz0Bsuqu1i1dKrUzcZpSo4I2
         N+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682454393; x=1685046393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztj/pjzcD/5i0nuLrEPO12i9eGvh86GmaKFkyefTt74=;
        b=G5R2v4gvSLClTfQmFVZdltSM9e3J2K5w58aZ9bk8fXuXktMeIWSIi7dofmsQWkLBg7
         uKpKq2qlnVARXVpnfmef5ZWpIDNZcSP0//0FanjhUjH34zvnMH/yiXoGDCt11S9F8ZGY
         Qaj7y6eIEqDEHmWkLMsKNl2BPb/LHlqHa/7dI2ek7U/G/GQkbod6GZCRFlMzVtFGCj7k
         tlxbg232p6E0erdpdZRJqA5DiluMhkBGMlJ11nBmx/wTojNj6ZgFES9d9sWppCOQJfsK
         nwL8vC+V3+jrQdVAqjprZ77OJ4+k5rrxBtiuyUPbYaTeSlKG5yaKu+aQctV0g5tV2GHy
         zOmA==
X-Gm-Message-State: AAQBX9fP/ibMabYqSzhfmFV7HRPvm9+cu4vvh6ahiBePWcdnTgwqH31w
        EJ23OrN8DNIVHPKLrEWlx1+DMhASgQp7xFyh0Sg=
X-Google-Smtp-Source: AKy350byuGUcUfM0yyAPQOM13tZ/8PRD5a6HcKoz6ElVQuJl6zAzfUzJ1JfepnyHFSv8XSePV5W8VMC+7272cDwyRl0=
X-Received: by 2002:a25:5057:0:b0:b92:3edc:d4f0 with SMTP id
 e84-20020a255057000000b00b923edcd4f0mr14082369ybb.20.1682454393112; Tue, 25
 Apr 2023 13:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com>
In-Reply-To: <00000000000079eebe05fa2ea9ad@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 25 Apr 2023 22:26:22 +0200
Message-ID: <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To:     syzkaller@googlegroups.com
Cc:     alex.gaynor@gmail.com, andriy.shevchenko@linux.intel.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi syzbot engineers,

On Tue, Apr 25, 2023 at 10:06=E2=80=AFPM syzbot
<syzbot+d692037148a8169fc9dd@syzkaller.appspotmail.com> wrote:
>
> HEAD commit:    de10553fce40 Merge tag 'x86-apic-2023-04-24' of git://git=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14bdae6828000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D975b8311f6b96=
bca
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd692037148a8169=
fc9dd
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm

I am not sure what triggered the bot to consider Rust here -- the
config does not enable it.

What am I missing?

Cheers,
Miguel
