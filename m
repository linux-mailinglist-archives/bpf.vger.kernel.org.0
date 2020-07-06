Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4348216060
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGFUhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 16:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgGFUhG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 16:37:06 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64753C061794
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 13:37:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 12so26585017oir.4
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxuInpeT0zPJ81Anrcmt2sLX1ftg1++39V+NueezsYo=;
        b=bV2U5lx1GZOWJexjjtF82NlU68mdRX31jnCdkCvS68+1fl8Wne3/qEWGuGngdDvQwK
         k5xNocV+mNu7AdErJYmosE7jbf2ohtef+B8brHO3694aaKrS2Etfdvbvfo6mv7RraVzG
         uj+Jqo1/KiNfx+1/18f/8rD0kXtk+xJTpNhEirXz1ZtkJ1dU+LZGta9rDg0uYWQcX8Bk
         LBJKQ0cQf7sfLG4SScuOSVaMpeniTR43Qzc2y1dLT//tKvFxBCvZZ/y4hPJs/3BBfJSj
         /BP5t2+3h+hZrZ8egCJbutVdz5NVmG7RY1cfuFj+n+JZbAZEF5Fi3FzutV3ATEZwPDhi
         xldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxuInpeT0zPJ81Anrcmt2sLX1ftg1++39V+NueezsYo=;
        b=EV2WWmFPklyWx2ac/YTDbckECCJE/yiSKmqAJcwHslFsgfNG1OR04hyfrQQ9Q0du4y
         tiWKQvfvGcENazqsQ/Xc+dLDjo5PEJTGM+UOIELcteI+nP9Fq/v1au5CQ+buTzxoyXJf
         FKtvoesLICjYbwkF8XuTv45hCu80SGGkCQwl9MCtaCZ98fFfETCXLYziUEjtKvYvUOpW
         xHmFZM+A8pKBiq6K3JW3e1MkHve8wQSFs01XQijOeDB6mScLdCQwU6ljgBMbSYD+sgcE
         cb8ATKKrbTe+qojpl8fLo+UQ3itrSJBkiOrWfBsr6lc37C3YRqBIQp3mML2g0kmn7jZ3
         2yYQ==
X-Gm-Message-State: AOAM5300o5NnicFLTc6OiJnNlNKRiBtGvebPx4sVM64EXfSGx57Pkozw
        QJqHsYaFEcYzggMGthpPy/upFFKANt9Qe/e4KhWudw==
X-Google-Smtp-Source: ABdhPJyDEw+SzjKlL22HJ8/oMKjyLCyK1GAHS6gZHbrCOpQbYUR9KROo5WTX0ArpxfhKhFtk5moFoa/Bmkpua0AeyI0=
X-Received: by 2002:aca:494d:: with SMTP id w74mr856423oia.97.1594067825776;
 Mon, 06 Jul 2020 13:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+BqPeVqbgojN+nhYTE0nDcGF2-TfaeqyfPLOF-+DLn5Q@mail.gmail.com>
 <20200620212616.93894-1-zenczykowski@gmail.com> <CALAqxLVeg=EE06Eh5yMBoXtb2KTHLKKnBLXwGu-yGV4aGgoVMA@mail.gmail.com>
 <CAADnVQJOpsQhT0oY5GZikf00MT1=pR3vpCZkn+Z4hp2_duUFSQ@mail.gmail.com>
 <CALAqxLVfxSj961C5muL5iAYjB5p_JTx7T6E7zQ7nsfQGC-exFA@mail.gmail.com> <39345ec1-79a1-c329-4d2e-98904cdb11e1@iogearbox.net>
In-Reply-To: <39345ec1-79a1-c329-4d2e-98904cdb11e1@iogearbox.net>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 6 Jul 2020 13:36:41 -0700
Message-ID: <CALAqxLXNCcXp-dNudZJRYhpbR5BgES6yrYdfRj7pJg3TpeHroA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] restore behaviour of CAP_SYS_ADMIN allowing the
 loading of networking bpf programs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 6, 2020 at 1:15 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 7/6/20 10:11 PM, John Stultz wrote:
> >    Just wanted to follow up on this as I've not seen the regression fix
> > land in 5.8-rc4 yet? Is it still pending, or did it fall through a
> > gap?
>
> No, it's in DaveM's -net tree currently, will go to Linus' tree on his next pull req:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=b338cb921e6739ff59ce32f43342779fe5ffa732

Great! Much appreciated! Sorry to nag!
-john
