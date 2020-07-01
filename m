Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8690121132E
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGATDO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgGATDN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 15:03:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C4C08C5DB
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 12:03:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so23656441wmh.4
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=so1euM2fxDT+DX28tgZVhFo90Lj+9P/xsDqh/XdCdfc=;
        b=JLUOkeV4i1KbRUZhMOVyfEvKT+Iyb8ml2KaKI0oJmJKN7mj4A0rSIqeLLyrG1ZMf4N
         UIbUp2+YDRRu0eiMYOmfTY1T6s2yX1TbnY7SGNmlfUY4wlg5ZENRaSOVSqSJr2g/t8l/
         nfFysOnLP+rAAPrS6Oj1UnAqvFg/9vyV2J8WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=so1euM2fxDT+DX28tgZVhFo90Lj+9P/xsDqh/XdCdfc=;
        b=fRlKPWurLnPfu2FfsS13qf7slONn/+I2KTcxuguYprYk6xDiz6q/PCZKU+TiRKOBVL
         i3BKmzwPMZntxl6hf7adM84Hrw8uZPhZC9kjUAHB766Um6wMLavHyVDOZm4akeiYK79p
         +hYo4zezZ3+wH+6YKDGmq+dlpuc6ckNu8jAEJ0ThsUx6Ukdbt8qBtbEF49QAqpJCgspk
         i3P3YKxHh3xeeGAI5at1NXu/sRkQKRe6bKFrb3jjxca5MBHi0wYVZstsQ+bivJ8XIWWk
         PPw6pBbY9BLAwNATIMA1K+QxK55xCUePviu59K/3vhxIn9BzqmtIMTBLe0zn8CnyR83C
         chsw==
X-Gm-Message-State: AOAM532NDDtcJDJByqUu1SKWfRl7UYGEqA3DDDcpuCHgfUnuR7xvD//m
        8cA+NXFV5PoJXmbkVnKm9mbreOZDpHYI38h26Th5Sg==
X-Google-Smtp-Source: ABdhPJxwNmEPoFaL06Rornt7vySFMlJsTTRjX+UYFCeW+7miP86iZt/KyebJUuSMkWDk64em74XssKewY8xID/MsCCQ=
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr28928523wmo.72.1593630191577;
 Wed, 01 Jul 2020 12:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200630043343.53195-1-alexei.starovoitov@gmail.com>
 <20200630043343.53195-3-alexei.starovoitov@gmail.com> <d0c6b6a6-7b82-e620-8ced-8a1acfaf6f6d@iogearbox.net>
 <20200630234117.arqmjpbivy5fhhmk@ast-mbp.dhcp.thefacebook.com>
 <1e9d88c9-c5f2-6def-7afc-aca47a88f4b0@iogearbox.net> <CAADnVQKF4z1kGduHdoRdNqmFQSoQ+b9skyb7n23YQj7X0qx8TA@mail.gmail.com>
In-Reply-To: <CAADnVQKF4z1kGduHdoRdNqmFQSoQ+b9skyb7n23YQj7X0qx8TA@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 1 Jul 2020 21:03:00 +0200
Message-ID: <CACYkzJ4286FaB4k7ZF7UdU5q_UTAy_M4QyWGEXXGPu8pVeX3LA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/5] bpf: Introduce sleepable BPF programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 5:14 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 1, 2020 at 2:17 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > ("bpf: Replace cant_sleep() with cant_migrate()"). So perhaps one way to catch
> > bugs for sleepable progs is to add a __might_sleep() into __bpf_prog_enter_sleepable()
>
> that's a good idea.
>
> > in order to trigger the assertion generally for DEBUG_ATOMIC_SLEEP configured
> > kernels when we're in non-sleepable sections? Still not perfect since the code
> > needs to be exercised first but better than nothing at all.
> >
> > >> What about others like security_sock_rcv_skb() for example which could be
> > >> bh_lock_sock()'ed (or, generally hooks running in softirq context)?
> > >
> > > ahh. it's in running in bh at that point? then it should be added to blacklist.
> >
> > Yep.
>
> I'm assuming KP will take care of it soon.

I found one other hook, file_send_sigiotask, which mentions
"Note that this hook is sometimes called from interrupt." So I think
we should add it to the list as well.

Given some more due diligence done here
and Daniel's proposal of adding __might_sleep() to
the __bpf_prog_enter_sleepable() we should be able to
iterate on finding other non-sleepable hooks (if they exist)
and eventually augmenting the LSM_HOOK macro for a
more structured way to store this information.

- KP

> If not I'll come back to this set some time in August.
>
> In the meantime I've pushed patch 1 that removes redundant sync_rcu to bpf-next,
> since it's independent and it benefits from being in the tree as much
> as possible.
