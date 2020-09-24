Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EABD27761F
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 18:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgIXQCX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgIXQCX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 12:02:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E77C0613CE;
        Thu, 24 Sep 2020 09:02:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so1877198plo.13;
        Thu, 24 Sep 2020 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRCLmg4VDNmw7XaOEseuJn4hXfsbbPGMKJw0MmQ0DNw=;
        b=pb0eJj9rc50bEDW7RBoGUAvuENUYLTp6H/MsgH6/3hVf+AvE3Iqpy6vw6fTVnTtUc0
         XaprcJ4xCk0WB8pggZarMBsPFF7/4tHj4rRihbeagR33gvtgOohtANOS3YoGU5ymVdnp
         f0aZz6Vq6a1X98YS68yqX3h4R67eRfLA1M83OXQhCSDEej6qDOfQc8iK3hnrWOfmM0ze
         aVvSo4vuvZA3cePODNWKCA3lq4fAnJlyXV8QR6lRnhrbP/E8kfLctMlF0+i3Ag7CqtIX
         nu0J3RkD81Q3EDukQrd958DdXBfz/WuJK+qZU8q5yNnpsLTGY4t5YlONIVKSfepnOJl6
         38tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRCLmg4VDNmw7XaOEseuJn4hXfsbbPGMKJw0MmQ0DNw=;
        b=ivWu94WtphA8FAf4CgC9nGKo1FkMM9Dr7gFXiBvz+uavw+C8ojFHPwNyWhL+9309uR
         C4ABjdd1hIsS4mNaRfc8YhAg1DhIC2jA11331U3tSe2pP15+BUUWzXgqRIcTD+vo2RrE
         mfE0s62O9rYutIYTL4Nm8Zbv9iLuEYNspYVbz358PeZULN9OrEOi+Umwr8FTF8/kSg9l
         kF7BW/VgHZgkUrDVNjcEjCukaF34bjHPBBNvtRxVU2ECCKBtQR/EPZhRB4R0nQfRUjr1
         0amXdw/J1O03NyWHXQUEA+45zJH94TBjNOzWPxU7gM7gU4ASE+8TE02KgLwYm7LE9hYa
         pNEw==
X-Gm-Message-State: AOAM532G+g47xBCTp709LZh2xsCmgP/P9jkGNOugjZloUNLagvMqiOqR
        t37S+McCuIQv8ze+nhFDKhOMB+LC+t5Y+8+YIFI=
X-Google-Smtp-Source: ABdhPJwMK2AyELo9LPxKKCnULIfqM45VOQhCysUmD7RLdDao+ghn99Hqy1JLu5VcPdW9QRvffafqvTw1JXKBcnbf0KE=
X-Received: by 2002:a17:90b:4b82:: with SMTP id lr2mr52199pjb.184.1600963341422;
 Thu, 24 Sep 2020 09:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <20bbc8ed4b9f2c83d0f67f37955eb2d789268525.1600951211.git.yifeifz2@illinois.edu>
 <7042ba3307b34ce3b95e5fede823514e@AcuMS.aculab.com> <CABqSeASWf_CArdOzASLeRBPZQ-S_vtinhZLteYng4iAof4py+w@mail.gmail.com>
 <665ea57e360a421c958fffa08da77920@AcuMS.aculab.com> <CABqSeARmtCk+vUbUfQ39z+mCXiHm2Gd=OopLHXvPTnvwcHfwOw@mail.gmail.com>
In-Reply-To: <CABqSeARmtCk+vUbUfQ39z+mCXiHm2Gd=OopLHXvPTnvwcHfwOw@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 11:02:10 -0500
Message-ID: <CABqSeAQ2mek4ZJ0SFZDy6obJ_JveoWX9GDi-_Q_e8o8ZPpF-XQ@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
To:     David Laight <David.Laight@aculab.com>
Cc:     "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 9:37 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > Try with a slghtly older gcc.
> > I think that entire optimisation (discarding const arrays)
> > is very recent.
>
> Will try, will take a while to get an old GCC to run, however :/

Possibly one of the oldest I can easily get to work is GCC 6.5.0, and
unrolling seems is still the case:

0000000000001560 <__seccomp_filter>:
[...]
    15d4:       41 8b 74 24 04          mov    0x4(%r12),%esi
    15d9:       bf 08 01 00 00          mov    $0x108,%edi
    15de:       81 fe 3e 00 00 c0       cmp    $0xc000003e,%esi
    15e4:       75 30                   jne    1616 <__seccomp_filter+0xb6>
[...]
    1616:       81 fe 03 00 00 40       cmp    $0x40000003,%esi
    161c:       bf 40 01 00 00          mov    $0x140,%edi
    1621:       74 c3                   je     15e6 <__seccomp_filter+0x86>
    1623:       0f 0b                   ud2

Am I overlooking something or should I go further back in the compiler version?

YiFei Zhu
